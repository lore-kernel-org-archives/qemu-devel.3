Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98223C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kaH-0005s4-54; Thu, 10 Sep 2026 15:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4kTf-0003Pk-6E
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:30:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4kT4-0005B2-GS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:30:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIRFjH2890549
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 19:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /RJyGWrKePlp0LwcE/4T0PDsYt031vCPaFda19iRLwI=; b=EtetcRzWpb+MmU2a
 tJuRgNlF4LrnmwuZ6EV5xy+JjaRpVXzFQ6S9PfIPN88nRyAQs3i8zGj+DD1GOODN
 zgHdxG8COp6a1KdzSCpZevc8JIg1/TQ+iMcdzjEvQaJ8x6b9wD3SCZ3reDfFNK1h
 N59cabTkfXx9mAgj0a80dq2mq4Ic5NnWVnBsjoZpELPmZQbNh3OSHs3qEWIh2nq3
 US0PjWTW0UEQ8XXSwtbhMeeVUzFYdw4vUdKKfH9yxJiGIh+rhrmIAhmYY2NLLHVw
 aqwID8Bt8pIBZttq+66Tm8mJnExrElWjI4WItZoo33uG1059FV0mWEcD8vyYxsJu
 ECWymA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxnv9abr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 19:29:23 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4c307941971so270161b6e.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789068563; cv=none;
 d=google.com; s=arc-20260327;
 b=WIeOMUywRQIIsuawKmZnyykESu/4t+eBtaLENm0ONMbnt0xlTDDYmpwNLDggX3VNTg
 NmL5FxTO6IY+p01GWGnUHiShrEBbdXHntCsEhc+0+FVMb6eexAxoDs4oJV9FtxJMqtQe
 RmTBXNxXJPR9e+gV2uZHbePPxwi9F+7ndvyk9Lf/KxQVweQDgtvWuuFqOqwRT1RxEZh5
 fn2kV3l14Kcv/jnbDyi+8TMVTa6MiRBqMaDtngsTfCGX+oFGJ3sx43Lp6KvTV/UOG3ad
 HydB68n8wtLFf/1V78NKnLnXY4bQQNBSvsKGDLkwbzHmA44lWAueqPxRgrhJuxGLxMBr
 GQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/RJyGWrKePlp0LwcE/4T0PDsYt031vCPaFda19iRLwI=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=Fzrr1JQSe0h1TRC+hosXGid/Elc/wO3FWNp0J+eBylqZGScufTQPc5dC3oofVzy3jY
 d1USmgoiU6K7P3DabwMaobKX9sBAxspyqTdIUMl2X+91MB8DvNaBuLdCx9v7HLwnSRC5
 5pVoj/yUYSRrUyfHEUkdy3TraRlEXymD6JbxnVXB89Z65kNrFRzUX2j4p4KYpMd2OG67
 ZBEd/VIf9niUnkykoyfEsjonC4ZUjtvyGEjKYkpOXujQG/gD7oV6fffZlyMHqw4cGLL/
 F9DEWutNWGiSOkN+Dwp0lGA6uwZ5TzsXeIV6/yt0B2oZni/qYO1todid1EIcMVjWQbjx
 NdgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789068563; x=1789673363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/RJyGWrKePlp0LwcE/4T0PDsYt031vCPaFda19iRLwI=;
 b=d87lcQqCLLTy+07H4/81jK7z+Xf5J2G5dIslBOlfACz8iHVfe4GtipJ0mDatCWeMF/
 224ZrVGRJ0KyxK23Bn6fXYX1Of9V2LrVQBE9ViB4C3ZXOMeAIHLr8ly1xy0/gv6cO+C9
 Dg8xjF1sdWyTdmpaFU1eseAQX0MeD0xSeK33NajmtzF0v2zVMZHe86zW8MhOVm1gJ2TW
 hpqW99tJUI4dYBMHOqiRpGCAwNJYv0WJJsR6VO/VmKOUXx3C8u6WCbho2S/EBGU4VAjH
 RN+SrjBmOss9mdwtTsohew+X6GKJGePnUs7aW3C/NvAwHdKoxYPxmOlT7l/0qzq09a9G
 r1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789068563; x=1789673363;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/RJyGWrKePlp0LwcE/4T0PDsYt031vCPaFda19iRLwI=;
 b=LX1zZ4FAw0iTKpz39K/n/E3ekGr0yXy2Qd84jvArup3GVRk6KmfNfA6jOHP+pe94WU
 yNqKmxm25G1X9HIpq8fAgN3sfrtBlEdwYAQrt5qkupRhxyJrhbZMBoh/kQ3hyBz3wn7e
 n0RWZGaxqoaDBrm86aHFX9AuXyvgzOARYpnVwzZEXDyQXxEIRSe512z6SZNc86ZkGPWa
 Sz/4Sdy5ezwGyI30jjlcPbFiCGu6P1mu7GCjAKMuVBdtMRCHepHxhrM4/ZyXGCQoY8K0
 yi4RQ+qZ37OunPRnKFNhgzq8dsjIgxcQSf50nmEQs6CrGi0/bgwRon1b1YxdTiDCI2at
 SUMQ==
X-Gm-Message-State: AFuF++l+43xOwwAXzVPs+pHsoV4RPuKExK5yvI+ffbPh46A8nuxWxx57
 TZZ799BgW/0/V+d/Y/MSEZ0iFxMHAoHEOJwTWrbNKIg6DRVwV/RjV791bzWLM9g7FQeYPMIF6QI
 mWsBOUKcOQU6Ze5y0zOMGQTAP/pukcqgzsUmaRIAwtltxTx5ce2zqLuBHrKaI/s5bQp9Fb6s19c
 b34+EOcekXqzcmSwrJTXgFLrUIK1Ak9gZg
X-Gm-Gg: AYBFou1on4qc38Ae+znfw4cuuqNb/AviATx78HhM/iYfPp2U14/zz4jAxp/fhcF7ItM
 B+YKjyt1EvQ1WsK4i7KDj5m5fE1Sd2zYI1UPM+7hzaj7NVNlqZ/fO24r0OxjX109XLFgZbQLaz3
 bdUuN7nXvzUv9yh+Y4CconW/BPzMuegIhmU1ktP7ho9Xv02nkVvv+EZUlYHSY=
X-Received: by 2002:a05:6820:806:b0:6a1:4507:3544 with SMTP id
 006d021491bc7-6c0bb3fd453mr363797eaf.28.1789068562900; 
 Thu, 10 Sep 2026 12:29:22 -0700 (PDT)
X-Received: by 2002:a05:6820:806:b0:6a1:4507:3544 with SMTP id
 006d021491bc7-6c0bb3fd453mr363779eaf.28.1789068562457; Thu, 10 Sep 2026
 12:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-3-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 14:29:11 -0500
X-Gm-Features: AcwNN1VMbkm2qUQgFITPV7k7MsAw-VcrxF_hE0ylaNH0LuwV8BxRvH0e4QLMXZI
Message-ID: <CAJ+KCYOxi4G2GEF9Lm6o3CvMxV36NWFPnv9QnB-ok9p6VBzjDQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] tcg: add base arguments to the gvec 2s, dup_i32 and
 cmp expanders
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI0MCBTYWx0ZWRfXxYs19pactOn+
 CeaFRZzvCuziQne9s94fmSKyKIh1R/7rqChEMMqaH0mVP4kYDEBMkZt60hl6VEqmFH3Tm1IfdO9
 CrusLlpdUMVYg4PEvowi/zdCcz54qSnlxotE0kwfkYmutwNFwO0ahQm8JNH7Y2LC3WCKI618MTl
 b9h8M8pPvBlSmQO64diANXNhF66lnbquah+3JAYzn95cFxkl+TcSo7sbiZrVl8IWvIChz0o+XFd
 xT1G31N2IIfQBzM157ILASSd668xdCJwlhe2ZwpVUdUgXNtFui0HMT5guxemP3vCNV+XUGRZzPN
 6BX3aM8ZQbr+FYH4r3hPfu6ADZwAnWI/yHS1lJoFFw9XTnJhg0xIaXl4DvMN3qBOQ7cRF0gHEmO
 buVeCgBNx2PSLDJ1oeIQzGhwz/ZQ1PHL+gu5E02Ewwqr7vlua8XLOisGl5LiIHuEi5MfNpgJ46k
 MiB8F6dbOMLpDnGrZCA==
X-Authority-Analysis: v=2.4 cv=RsxQvymK c=1 sm=1 tr=0 ts=6aa30513 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=vwp-26ZQ3WPr8MkEgdAA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: WpD7ei9cLH3MPJ6Je-9UGnZMezs_-nZE
X-Proofpoint-ORIG-GUID: WpD7ei9cLH3MPJ6Je-9UGnZMezs_-nZE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI0MCBTYWx0ZWRfXxmnfi2myIozr
 l3mAumWaDUEA4YOsK868WPQ1BHO+Lm8Co1fnbRPulkNvOhHgK4U4i5fEwEjzi4CIlt6QTS1dWU+
 kr0GJ555nlSYAXCyyjkbjhtNqDWGI7k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_06,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100240
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 10, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> These three families still name tcg_env directly, so they cannot be
> reached from a _var entry point.  Thread a TCGv_ptr base per operand
> through expand_2s_{i32,i64,vec}, expand_2sh_vec, expand_cmp_{i32,i64,vec}
> and do_gvec_shifts, and split expand_2i_ool out of tcg_gen_gvec_2i_ool
> the way expand_2_ool already is, so the out-of-line fallback is reachable
> too.
>
> Add tcg_gen_gvec_{2s,shls,shrs,sars,dup_i32,cmp}_var; the existing entry
> points become wrappers passing tcg_env and generate identical code.
>
> Note that the operand swap in tcg_gen_gvec_cmp_var, used when a condition
> has no helper, now has to swap the bases along with the offsets.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/tcg/tcg-op-gvec-common.h |  21 +++
>  tcg/tcg-op-gvec.c                | 256 +++++++++++++++++++++----------
>  2 files changed, 192 insertions(+), 85 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

