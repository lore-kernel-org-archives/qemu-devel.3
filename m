Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D3C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3TEF-0004eQ-DS; Mon, 07 Sep 2026 02:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1x3TEA-0004e3-MY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:53:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1x3TE7-0007ci-Px
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:53:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6873m8k23456232
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 06:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FdPJ9gPrUT4lnJemglO50MyNP2L9Kt90VuTJX6E75+E=; b=LhDI2QdXk5aqgu+u
 5PKxXH0HfZOd0SJW6gfI6ESfQd9nrDy/a2vFxyQvCOePJ5zYy17fOMsky4qQndQ6
 uOa3sZKP0ji0dBtO82gKcR370CR0gWty6WQmcrDhxOTRJgSvs+OUQBZbkae1ZvlU
 hzXXBlqOz7GmyLweekxqbUkUDmo+zbAPayADeu9eKuhX2A6NrNxZEkv4Bgu4iVvc
 Or28RQ75P1lBXExUGn+tbLfU+RG1zjhOpvb0ERizrBpNbSb7aVbHiG51Lzwx0JkB
 5mrgDp06VynvqjBA8kCI1xjWIZ4XmIVErKb8at0koPrYIYUC0bxS+I4+4SQ7u2Cg
 1yQu4w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany5dys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:53:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d7151120d6so51886645ad.3
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788763989; cv=none;
 d=google.com; s=arc-20260327;
 b=AHB+EJmcL6+/6HBx65ChFaw6luVlC7ut3LanTUN4jDYLI83CnMJ+ENp/YQ/IDTyHS1
 oA8k1cy1BvkAt2du6HqzSAKWC0WalhDoDXwR1dDSJ3DwWMed4rffxOWRJiGgnGcHR7Eh
 Oi5dkc6aBJ8W4ubTWF7Un6PjZga3+xLYo7IsW8sraAACof2WO7c5UPcZ6VoMOYsax1bL
 Qlt2TdO5N3K5jieLc+Cr3SBAiBTOZOkQYBVtAu5Q2YeBBRACp4z0WmyhO31q3VVrLuYS
 V1F+O1haC0CJA58nR7KNtrN6c1kPni+5wQHWht6tG10RwxczGq5VkR0BTNThXV07cRK8
 wNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FdPJ9gPrUT4lnJemglO50MyNP2L9Kt90VuTJX6E75+E=;
 fh=AxzAqHJ34I6km1oAaP+WhI+lF/wsDLPkLlY9RNOpOjs=;
 b=StK3rRIAHn+RvzoyiOA5Wp7mRvXe8ou5yahTkDA7VcrRcRQyEnHcWluR6rWu2T6K2A
 8Htb102WIsbzsfKUaDHIX8pmXvLmB6w1bWvQxHpMVB/jruux3/AyjTnL0TNd5tTo6fne
 7XqS3Yh7I/vzmhcXKScqJYxM13bnXkUJT2s+IiG9NW2OkechxoKN0F77TzsITqsyXfR3
 /nMgYWFTtu+ek6HWlUeA0944ATHa2RTRU6Yy7Yw46CqqDy3MWH9iBZUnXtyzLiBD3xLW
 Du4J5jZ4GNNBssQdOKPuDPFEVZCHbcQY71YwNcoSTirIXi1PSPTAeqfQRifJRpcecexV
 wXLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788763989; x=1789368789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FdPJ9gPrUT4lnJemglO50MyNP2L9Kt90VuTJX6E75+E=;
 b=TiNIKl3b3+M0LP50c3ckz/B/JnoxPINrKhdK7MOP2IgIvYDhQtV5/v3i83BktfKT4G
 spe7PvUHh5svDH5PmXKskK3gzDD/m0bSgR6WHLO5xqpwJlejA4/1LsahaItA4VRJNDrw
 rxADToy7+45Vui+5x6r/1iCwH10XfxNLbAwbrK0kZFxvIXE0tapgZdcyg1FpHrwFdaBj
 Z/D52RxWQYOK6oBbFfNS8wLU/U6UPQ2DIrLSIzhTV9Kafyrg2AgzhCdyRdGXjq/b6ZNg
 bMUEHdNqTTJYzrI2/Rt12InEqucO3nyrw9//h75q4V4pppHpUr3cchxI3cdhsKuKK936
 xaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763989; x=1789368789;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FdPJ9gPrUT4lnJemglO50MyNP2L9Kt90VuTJX6E75+E=;
 b=MPzaSzi9HCPjc3G7s2QzJt27ycaNjJAM00G0bTtsu03pgTuEx0xdf8cp8DO++CwNBu
 XNf/MKaF+DzCke4VDKUFzAereFtkj1wNlkmA7T6NKNTxA/1YNkGhYJSwuFkcp4YhekiK
 wbdxXoPnsLzF6ApMKzLpTFOPi5G5wcnNQNuD6gVohAlEgeLYvbV9pPp49lmoBnZXIb+D
 X/XVp91xmqaZ8IOhAIOspkGNI1PZ8y430R2z4AmNuMfvf3tQpv+/fZ/Duoofbz1hU2Tn
 f+/oFG4nzQi9RQV/2OlSy99N3N7dSrFI8tyuiTf3aQewBbqJm6BYxY4UjsFrqFGDlPx2
 TbqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrJ936Uw9ZS5m+HoqPciPKfVf2I/6snT8LnDX/M7gfwAIl+Vqj5JY4xu+zCnHHE6/1ohhYnqpbaWVM@nongnu.org
X-Gm-Message-State: AFuF++moiTMtPifizeRiQY9YM+FStuoUAbVK/PnbXlKSqkiBnRevMxyj
 ptP84o6gws7yx3dfvKOT5KXl1xH5XvSMldNjJNQQsKhZB2+X7NL2qW/IJ/jfUUjrUc4VMV0cy/L
 15CZg1UYd5YO3GzYBOzXkReLgJGpop6hspgOro34BEbdhGo0khaPKgdHInSfWHUb8gTjmdSXvNl
 HWRbjYZ0L90oIim1IQkWBRWZPnh3k91KZO
X-Gm-Gg: AYBFou1JJ6Mp1o00QYckxeCWA6xXG7kuO1Pj/sh3cXw+7YFFWqzK834oJFN1583m//V
 UI6rYUJUywmwGBKB8x827dAzTYfgDJLPWDYylpnHFU1RTOjY6srH+ihDHEYVPpxkt6W+Ter6B/M
 S8ZUkj0xj+QfYGcZbfC2bBKZokiaTdVsoX4pw3tNA4mWs2g0xi8b108Bpi5Q==
X-Received: by 2002:a17:902:fb48:b0:2d7:203b:9863 with SMTP id
 d9443c01a7336-2db1232c6a9mr207428775ad.1.1788763989294; 
 Sun, 06 Sep 2026 23:53:09 -0700 (PDT)
X-Received: by 2002:a17:902:fb48:b0:2d7:203b:9863 with SMTP id
 d9443c01a7336-2db1232c6a9mr207428485ad.1.1788763988864; Sun, 06 Sep 2026
 23:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260813134002.862578-1-mayuresh.chitale@oss.qualcomm.com>
 <6354eb8b-7319-4e03-ab16-12e8857added@linux.alibaba.com>
In-Reply-To: <6354eb8b-7319-4e03-ab16-12e8857added@linux.alibaba.com>
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 12:22:55 +0530
X-Gm-Features: AcwNN1Xv4AX6I-IV47pMem2cxxzStcnlz0pAgL2SoeiiBcU7uoVVBV2NEBreMqU
Message-ID: <CAHuiULA+aYJa3428RYpORV73iyZ-svzmH=JyR6gj77WemhvfSQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix LCOFI masking in sie/sip/mvip
To: TianCheng TANG <lyndra@linux.alibaba.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Gong Shuai <gsh517025@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9e5f56 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=p0WdMEafAAAA:8 a=SRrdq9N9AAAA:8
 a=NuDas1xL7WfDCPMZ89QA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Hj9NelrdPpM7cLGVU19qXyPvI38z9gJC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3MiBTYWx0ZWRfX6oh40G5tCqbd
 o6cBrynK2v8u9nl9Z+4jjiRST94ZzhVTZV8oRrttXdqNUYXYzQ3dk4vZ6qsrelPFtINVAU+0yX/
 LxK1CWqCUZCA7yOc2QLi4eLiHkittVEobYCAmV7WWhpOoCO+J5yMrnWAhxccW13uPfeCbEBy26S
 d4s2m4wPAo0No4gKuu2cIBH/kEdtDziAT4TPRSy1wJ+8uAqo2+LZrGwhCoSmXqhIbadCUWhako+
 n8xaTmSTCTOL/p0dX6K9oFnTyAhpLAuztqLmMP6dR9iBKcCzNFcXhRsKQc+WL4dueIB7OKHfr3P
 z9XZAk5Ws/FTUP0Rfrx/KesYL4ZUkvPTMd6+FFT12q57ZMaxJsuVmCnSzhay61qD4iA4jncvVAx
 fbY+BsiAh9VCpxFRgYoYlBNzQGtxTJuaaJFquPsEflTO09RJ3LDkFL+o10pGpOaq3nRVioqttjN
 /ulS0zPbYTHsPvwFKXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3MiBTYWx0ZWRfX/Gf+jxnSfUGP
 7ieo/aX5wywC3OsoTsUpn4E/0DbAxFVT8/8Ink8zeG0ilPcGsI2vnN2pxKI6uErM5kUrwpGgGcU
 5bqd9MMbddhSYQT5sHLUCjA2O9aO6dY=
X-Proofpoint-GUID: Hj9NelrdPpM7cLGVU19qXyPvI38z9gJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Hi Tiancheng,

On Mon, Aug 31, 2026 at 1:45=E2=80=AFPM TianCheng TANG <lyndra@linux.alibab=
a.com> wrote:
>
> Hi Mayuresh,
>
> Thanks for fixing this.
>
> While testing related RISC-V PMU changes, I noticed the same read-back
> issue reported by Gong: rmw_sip64() also needs to include LCOFI in its
> read mask.
>
> I also noticed that adding MIP_LCOFIP to the static masks exposes bit
> 13 when Sscofpmf is disabled. The specification requires sip.LCOFIP
> and sie.LCOFIE to be read-only zero in that configuration. Would it
> make sense to condition these masks on ext_sscofpmf?
>
> For the virtual-interrupt path, Smcdeleg requires both mvip and mvien
> LCOFI when Smcdeleg, Sscofpmf, and Smaia are implemented. Is mvien
> support planned as a follow-up?
I have just sent the v2 with this change.
>
> I have local TCG tests covering the base, extension-disabled, and
> virtual-interrupt cases and can share them if useful.
>
> This also appears to address:
> https://gitlab.com/qemu-project/qemu/-/work_items/3969
>
> Thanks,
> Tiancheng

