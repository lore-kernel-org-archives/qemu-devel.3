Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0549CC79FAB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qKV-0001jM-O7; Tue, 08 Sep 2026 03:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3qKO-0001j0-Ix
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:33:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3qKM-0008QP-Db
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:33:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LjP32172623
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 07:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=FJ0xoQPf5oOoMa0v7icu0LvWrxjxWOB8CX8g7gFWM/M=; b=FM
 buTjMNLOvNbcPAc3AGaqIVm/Z08FDTbqVhNVRHcuZrsj8uAKMd3J8ygZ+QHiMnsq
 Q7oz48VsSmzrjuVLm14uGO2Zzmm0DWd1lI+z6YGpbHUDZjBWbLkikOiGDwrVJBJS
 tfIBCjq2zQtcusnOjqnH4fqrDdcom3xZL3j0XT1pGn4hXaZwe58xh8sBjqLfoHg/
 WBVedXIDkjVopiesA/o5HqZfgi/b2p2EF9HN1Hd+CDrE7o0x+QVNw0qktxEJ44l/
 HqCe4doio9EF+jtCiShBRK9YcCb3egZMnuR3a8Jw9E7bgIEkHznv951SKGXDLlwo
 6bvXiRVCOqfNlF+6NNkg==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rrj9kh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:33:08 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66c70f4b830so4883053d50.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 00:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788852787; cv=none;
 d=google.com; s=arc-20260327;
 b=UwT92Vc0oYPjknXk2Yc2+JZxRHAXynwqF1JxKP7FPD2vAhorkPy5zo5Dvj7axwEYpn
 si2qiluv7SAuTb205GF2TvNeXZv2ULxQ2ekZ4lHb+IU+YqgdSuGZ1ntLxaStf3OviPpM
 aEXSqT+0hPs3Ay9fINkA51fURfm+Eb358gJWVpfQl97Xv8oN8izTGmntrgRSpXCQKwvo
 vSxN+2HHYUMNBpYESaLNVY61qTNeAGl+edspJTBL3k7f4F17SqSwxlLGf/51cpvRYcT3
 gQapDK2BZC2p2uOiUh8LFi/9S9miZB2Gq8wOZ7oPSesCKhMKzZCg/nbs3pzoUYfD7m9Y
 MW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=FJ0xoQPf5oOoMa0v7icu0LvWrxjxWOB8CX8g7gFWM/M=;
 fh=YDrTDHxFaRR2vq70+ry41iIIC78JIgnF/XcDmaTBLsM=;
 b=P1cp1jRA5/X/V+NMt5nFXD1vSU+8eEkk7N9U4LxLAJXAYf4sXCorSTovporIvVyjSH
 ZmyUvDEch/P5bNU572C+BBdh5dzg8cSe3PkECJhdZ0al9WsntdxCm7s7Dy9uAjs72PZO
 wX/qcQehEc8KW26L5YF3fqaAIXnwv4RG+mmpsjIFKFGP4ma8VQNOerX2HBNsCraCFT13
 h4YGeL9Em5RNeumQ2HbHzkoowrM+x9bI77ddrw9S8c5CQly+wdVx/1hjS8mmXbqh/eBP
 OeQ5AFXS5/nMkZ9hcTBpkZGTH+qxa0srD9Vbf+O2fsrQPmfrPyFLBVW2iOokL2UnSGUp
 UFag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788852787; x=1789457587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FJ0xoQPf5oOoMa0v7icu0LvWrxjxWOB8CX8g7gFWM/M=;
 b=kWVlzQB8IwxcphbSBgbTsfm3tYsxdqaokcpgF3m3PImXMz75Zq+MGztlTCRB0r/d00
 +dFvhAsTz3Oy/B0elcrmyDG7KDyV5dVt2r8RLIhxQzeZ5LCuRt7oXr9c3piCa3B9I7B+
 qJ2rHma1GgjfsnEIayhyAQ2yKadDfuFPSDLFgqr9y7sDUKIL+0ZeW7JamBNLVECheGDL
 vXzOIsYZ8YiGl0Lo+zW42W80W5Dchpd5+AY0Kbh/liao+5yMQm18YRUNhUTGfCK0ZxR7
 pgUAk/TrF2qnylfGCOcA4XU15Xn97W0luWFPGR3i22BZXNLhkFmUJAl/+LlJdqx8tnJ/
 /IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852787; x=1789457587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FJ0xoQPf5oOoMa0v7icu0LvWrxjxWOB8CX8g7gFWM/M=;
 b=UbZR2+kpmljtUdLlzrmIwfQTvmnJUiFgOLOqjF50zIOt4fR6bqLrqa0HrwHYpqq0oS
 P4ilelscjb0tYr8G8tbibxQvLESx/pY/xbEIxeZR6axq6XeuUmzVRpf23XIvkc5fciZD
 6NT3DOqOBAOiArWpTcFzcn2Ap7gSWtjq7igmA9J8xM+Q7hsHUoDv5EFB9t127emUd0JY
 dYju1+O1wXsiu6OZcLrx2rSTvn/6fVgx4HNFKJ5p7kvBj27vneAqM8ophx11US2981ig
 e/XlzsGKL9LmX+Eb0CvocDpKBfeDfTo/oTgKCv4ekP3TVX/BPP2AZroTVjh6+0LhyVp/
 eWHA==
X-Gm-Message-State: AFuF++kKXE7EBlTdbU0ykIssClX8Saq5nsrTtfOapVP5uyGaHX9Nzf5c
 4O/ooSINcxbqt1DdOYds1rL7xy1Y8cNt1jMypBirNq/2G2XQUV+KccjsbFBFrYmg2aljy8fj4Bz
 3PN0HRNjAJ+DBcEKvhwmwbx5cpWa/pWHVeUEJpxa/jsMJvieuRJwFTF3A3Fs8flhbAne2MB0QVb
 WJSqREDKhLvFIlJ/VnF+PBdwwV5nYafwK5
X-Gm-Gg: AYBFou2LijqvnHiGHGUukDzdqVazXzKVc7HBVk4VfLSp79B9pH8QWlDLC0LRdHVM5JG
 hpDD6ajT5gqo89hIZi1m1FZ5xGv5usnP5VCnd5ZVDJJe1VyDWcRClN1WjZMkqhxwS0A4jCIWCP2
 30NxXXcvTGE1acSoGVtF1KfHAn4asN3q84REVQiQsT/YhWRryw5nphdCPv5TE=
X-Received: by 2002:a05:690e:138a:b0:66f:c1db:6dd5 with SMTP id
 956f58d0204a3-66fc1db828dmr6138067d50.54.1788852787618; 
 Tue, 08 Sep 2026 00:33:07 -0700 (PDT)
X-Received: by 2002:a05:690e:138a:b0:66f:c1db:6dd5 with SMTP id
 956f58d0204a3-66fc1db828dmr6138055d50.54.1788852787195; Tue, 08 Sep 2026
 00:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-6-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260904195610.964829-6-daniel.barboza@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 13:02:56 +0530
X-Gm-Features: AcwNN1Xhe2oRpDoHgb5cjGmiTLVFM9I_cEjTNcdePQLl2Lo_GLrM2tJDCx5WZzY
Message-ID: <CAB19ukFK_q7JnzON6AcLo6VupgnQnYxTKUv=Mw_1kZqYOLj8+A@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] docs: add riscv-server-ref.rst
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, andrew.jones@oss.qualcomm.com,
 leif.lindholm@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3NiBTYWx0ZWRfX7U1vfiU8d0/f
 PPivj69RBngRKdxajauFKDf0AithylPqS+IzBfQfFcFm3AdbaR0JGd5mStRIT7UeS9n8JId9j1p
 Hjr2/r5RDZzuz/z/iHCZ6PbzgLoL56Y=
X-Proofpoint-GUID: GT7Ik0Sn228gKfqu1dgjgORGGfvRaGQA
X-Authority-Analysis: v=2.4 cv=NsjhtcdJ c=1 sm=1 tr=0 ts=6a9fba34 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8
 a=r-YDLeC8pWfmBPvFspwA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
 a=xVlTc564ipvMDusKsbsT:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3NiBTYWx0ZWRfX36Hm5EPeeKR3
 SNG81aKX0meo3y4ajKFaEQFBOIifuoTTa86pDR1/uHyeEkHZDvogmbLqRU9x7ijQff7nHGCL0KI
 LfZFsM7kX+PXNxZHSt+5a+51qDjzysdtkpbL1Mn+XrVlvBaPAZWJRYYdxHUlKC/PX3I0cGhxcc3
 QmBkrgjgjnd/yW2Xo4su/rPjOftNHbGgi2C+fnmuFho4v1L18JTIyHyUrEnPvt5Q7UT5niJgtUh
 7fuwG9riKLVSEWS00YttK9Aawu1OCLLvJoHKxxplBp+/cjt6dhotDJmbVhJwmquGEL+DMvCEL6n
 9diZSR07TnMVvviaj8jqzKrrIQS4J5Hdpab5yEuJWSvvZ/NqIFywNRT3Hc78cyqkcZXmFHFN84c
 PRkzTN0H9punUc6pbv/yyl6w+L+cDux6mELHviu/wz+9nhJB9lEa10DTuGGCMrPf+NVjJcUAkgz
 x/jkGr2QA1mjEa9rSag==
X-Proofpoint-ORIG-GUID: GT7Ik0Sn228gKfqu1dgjgORGGfvRaGQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 5, 2026 at 1:27=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Add documentation for the new riscv-server-ref board.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>  docs/system/riscv/riscv-server-ref.rst | 62 ++++++++++++++++++++++++++
>  docs/system/target-riscv.rst           |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 docs/system/riscv/riscv-server-ref.rst
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

