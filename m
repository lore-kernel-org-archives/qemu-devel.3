Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42046606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g3T4QKAx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eOD7MidB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJyPL-0002EJ-D6; Thu, 22 Oct 2026 15:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJyPJ-0002DT-3N
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:24:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJyPH-000150-Cl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:24:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHAB03741647
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 19:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8/YVScX4dduPrcjFC+u7PJME99fm6jJVCw1FXSxfXJM=; b=g3T4QKAxjp8q02Cr
 vqONuorzFrBll0WiinNhINbIMZNvHI0xh58OeiSr3TRcvJLhSmXmkeB0esFgA3pc
 M3kmpPswP6WwCSNTfN30fjmjnUvvx6goiHu7O1B8onUkss8htkmsg1gyEzUy4njo
 bELtrVLDLaGU7WroV4Cel5ydrZdLapr8kAst/BOUUHWxlOMYR1lxFQk5/8PYv6yK
 Ir1WoKjkGY84yTWLUitriGKE+SAzs0oLAhodfJKbdPcx87+x0ZSUkf6lwXE2rAa6
 16WiKfmCZma5a8L8YsII6NUBliZSuU3IKuiP4UbMhUJKRcZ+ePvcNLkjn3EOIqUl
 D/nNKg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms07xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 19:24:53 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4f9b643ae53so193500b6e.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 12:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792697092; cv=none;
 d=google.com; s=arc-20260327;
 b=Bz3s57X/BNGMJSPZ3XmV6AJptcmSw2Kz+yxuxfCT14pncqW0L6n/EdRnFsqrJPZM6Y
 VBBT43cCJ2Pp+83foiabaqnNCv88/rGlhrIOBd9xxEPiGqU7GezxK21DpjoqudBdiAL/
 zNPfX+yPqt3nDkg3oalbFUoeG9K3RZCJVMpzMB25IXqLu0zaWysVXmECMX7OhcReZpMR
 H6UlCT/poyIYtyV20bj3jt9mBRML7ryz6iWAuqPDlKLhQp8kiCpunyQLLJwZV27tikkn
 +r331bv8LvWdJCw9UmzHtS00K8s0NfKXqKWNCRl9byDv/R/H/Nut104ws72Xu6U6qWNe
 sg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8/YVScX4dduPrcjFC+u7PJME99fm6jJVCw1FXSxfXJM=;
 fh=X+mPrGF8PwPNFxjkNXNuYtliDikbywOcHBV8TCdDgCM=;
 b=PAVjg1P+J7G1+pSIOlcIWJvcYtQPT3WX3XXi4rZUAK4d9vatJSUzz6IlUYb32Vl8nE
 GFAz2AgqczNiGyPVFJuAYhNZrB1IWouWLuRJENSpOB+qAE+8DYQOdZtjXshhtaT/bmKn
 i5iBOH8G7JbcAJtLlC/fZ+J220rs/LJdn8w3rvyIIUZ54X5ICE5EFuBwKt/oXYFKFsus
 kXwkSHfwKzEAqFebZZWo4nw7rH0hj7KZFt/hKjwmea7wZOgRBCYct65TV5fqPbssETxf
 RyVEXzl5u9DRdwmCQtqXbB940rHjoG7JYkneZw7sfS+j5nG19uvm+aJxqh5W9p0pShny
 sZ4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792697092; x=1793301892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8/YVScX4dduPrcjFC+u7PJME99fm6jJVCw1FXSxfXJM=;
 b=eOD7MidBfQmtBJZowBbGsWjFlpaKxod/Nkvlq3OGyh3sVtYYwRupH2bW6cBZPMq2WX
 +VOXv2SU2FUCpm7vopY2oosDk+jN6fpzPdIKrUgofH8gZp2GGhVNpVgCQ7EDHLtT39Xl
 sJ7pnB269rmGQ2m+rDyLGek0UUD2cyUYbm0axXRghqVlm5gYxZ3aA2bbm5sz8wJG3Qq+
 +ZUDB3GrsApuopM7lzAd5axzFTnfIDdUQr7JwRQQ8JJ4EFEmxLR1Dxs6sz4V+GOEQg9w
 NbmyRY36VaACho3g19lL2o7mUgRai/0cqSbWgrg6FSPUym+F/tWDyEyLNMVpjwcTBExc
 I+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792697092; x=1793301892;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8/YVScX4dduPrcjFC+u7PJME99fm6jJVCw1FXSxfXJM=;
 b=zosIIM3+JE9Wf3FxEHp6I1i41MSw0uXs/BNeiH66ArjSq+7UmyWcEmxmzMrm8RVU68
 Vhd3T3qqAbv2UXKq158BQ3KOHIhigeU4OL6YTxTDeQZL2aV0ZTGmGf0NQMvf71p0YD35
 muktB55OktWy1NKOXSVJKNSeF5C45Ussw+YCuvCQxoUPWLl3BJi1YmmR/1uVLQZmukhE
 46/4eHRL7NsuheyiZ029physmJ49We/a2yk/WGEIKaWR06nFIWmAm90pubQhQCwZGZ/P
 Yo46tbAD0Q9lq8WcAQwTjP0KiZgKQ+YiS+MYuGvTsHJLFqCrb3HhEUtVavT7OQxPAo3H
 9N4A==
X-Gm-Message-State: AFq9FYI16Kzr3LucJ2lsHsu9xAB4q7zqrhnzhSb8MccnW1t4d9ROxn4t
 VKNQlKhuO/7f3tBz7SlaXPbh7wiuend+IPnO7S1CRreCaY6x3uwJPHh2RLD9OIJUPak9uqeblei
 7/vED/Kjtdpk1L0i2mrsFf7Nm5zQCI19NeA+VP9MfUoeU948OYsVuFQpV3TvSBThlHfPPcwKOjO
 J8koFf1NowNQjAsiT5JCJrZ+1+ByzK2bae
X-Gm-Gg: AYBFou1DW9IHka5UuHXrmmF9Grax8gALplznOWtidW9/WdiF+0TtNsWI4c9TnMvTByQ
 3VHEospjlQiuDTeMiX1zCgscZLQ2Xp487F2TPV4iFVkSY/eXPPzbsCsFSTnQl3GR65A/5uchG4s
 aIiIavsMtxlaTwWaqhZibkwexOo4FTTcy0xxzo7pQD0Ug+brS3piY/Rk/CQqbqiJgf9WObB8+i7
 x8QBHwDxn9RL0NssNI=
X-Received: by 2002:a05:6808:c1c2:b0:4f7:a3f2:d8b4 with SMTP id
 5614622812f47-55be86b3b89mr7372b6e.65.1792697092479; 
 Thu, 22 Oct 2026 12:24:52 -0700 (PDT)
X-Received: by 2002:a05:6808:c1c2:b0:4f7:a3f2:d8b4 with SMTP id
 5614622812f47-55be86b3b89mr7352b6e.65.1792697092038; Thu, 22 Oct 2026
 12:24:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
 <20261022183147.1535585-12-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261022183147.1535585-12-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:24:41 -0500
X-Gm-Features: AclHuK9CdNOgwazyr_VLwDOKo8-b6kUDZ0e2csfsRxoDWoOQlYCouqm7wbFpL2M
Message-ID: <CAJ+KCYOM=VMaKMcYO8McRgNxyw1oyugKJj-foUGJSsYXdByMhA@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] tests/tcg/hexagon: add v85 scalar tests
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NyBTYWx0ZWRfX2a2V/PjkiXc8
 oJ6YrKq+6dCXs23GokWUtFhFO82tAu3wWdOOIU4XbXx+qP8Qjzhj7DVWwei2WjA1Ol61En3/QLe
 7udojnUXowlK3Bf+lLjFQ4bC9aR/XnfkmE26fPyBaRKjWPMGHaH6wYMMTPJlTTPE7flxVnAVlz8
 rXslxbIToAsIgpZGPNwwbYEV6/+vYPwdbVt/NlgfM6MSA/AdIomBS5rXbhHRMpUEKXg0HaOP0py
 WO0G3BZ2Be7q91ZS3sYcJ/cenrePM8VsMWGg36kqpL818zjQfTdXAuKXy0929Pr67p6rOuO0n1r
 ysvkBRpV8870m++Wrrt62Przxzybgn8eP955KKRpekEc6LCnPAU9V05AwCoY5UaoJ03vMQEctOZ
 cRSu9HYmHh20GpOmMjG5w5nP66hcLcsRDOk4PhY5q6EZyNkeypxrbxUpuDDIVpSlP6gre5VsZW2
 1a5hpl7EApH514EvMtA==
X-Proofpoint-GUID: si2GmHeb6aYOTno6Rv7dLyp4YQ4_eNFg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NyBTYWx0ZWRfX42oTGkLYMCzz
 cDq9Aq5gArFugAMeDEVyEihjbedMaBIqlXhaD4F/IqZiIldMQD6lmkp4QOpORax4/c/RCjdX9kR
 PcJOhX2FHLGhdhnp6/twgqyjgzNS5jY=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada6305 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=vvbggdHkYOeSWvUQqd8A:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: si2GmHeb6aYOTno6Rv7dLyp4YQ4_eNFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220077
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 1:32=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add tests for: vallocframe, atomics, trap2, CFI/restricted branches, and
> scalar fp instructions.
>
> New instructions not yet supported by the toolchain are manually encoded
> with .word directives.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/cfi_tgts.h         |  18 +++
>  tests/tcg/hexagon/atomics.c          | 111 +++++++++++++++++
>  tests/tcg/hexagon/cfi_tlb.c          |  99 +++++++++++++++
>  tests/tcg/hexagon/cfi_user.c         |  73 +++++++++++
>  tests/tcg/hexagon/check_rev_gating.c |  10 ++
>  tests/tcg/hexagon/invalid-encoding.c |  20 +++
>  tests/tcg/hexagon/trap2.c            |  34 +++++
>  tests/tcg/hexagon/v83_scalar_fp.c    |  98 +++++++++++++++
>  tests/tcg/hexagon/vallocframe.c      | 130 +++++++++++++++++++
>  tests/tcg/hexagon/cfi_tgts.S         | 178 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build        |  24 +++-
>  11 files changed, 793 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>  create mode 100644 tests/tcg/hexagon/cfi_tlb.c
>  create mode 100644 tests/tcg/hexagon/cfi_user.c
>  create mode 100644 tests/tcg/hexagon/trap2.c
>  create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>  create mode 100644 tests/tcg/hexagon/vallocframe.c
>  create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

