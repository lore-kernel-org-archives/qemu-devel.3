Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA3BC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4or5-0000e2-Fp; Thu, 10 Sep 2026 20:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4ldO-0008Al-1C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:45:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4ldM-0005mP-7j
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:44:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIRJio2114334
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 20:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +chqUTm6UJXfD7aF/izpceBqEiL/t5fhyVkCxo13nCU=; b=go1e4cgv7wx84wOd
 yTuEPgjFR5IKT8uEcQaAl+fCNCUfgCTBQTbo29qC35TmEKEfBx3dkQnmbyk5VB8W
 LqdVZYCVCP7gvxm8sJmZFDgJIXWmnIdHj5uVffBp67K1hWY+WCg8y4Fyb9O735kT
 7DMPCs0ihY7e9jG4tyZxZszGUc1ws5XacKkCLru4IlgcgX3EfxaIbC5JSnucJ/fP
 FVkVqnpvR20hbUEEgQJO3E3Ouf8AaLjI0W02arXGUMzjrIqeKLBrvAeSeiOWVeBd
 1SBAwXoxc/qPuh6k4Hz0awVMFrO6magNKxlDDDbUQPVLfC5O/VJ3x/+McHhibKnj
 didtkg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrcjuegm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 20:15:40 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7f66ceea676so268358a34.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789071339; cv=none;
 d=google.com; s=arc-20260327;
 b=dfjYUiRwLUlu/KLhLcJn8RMn6lKrS10orsOoNV2Eh/U6HYdOcvQi1nLZkWZfbWbm+h
 w7bi62cNuEKr/AQrqhuNCUi3RI0M9ka2zAowhVZpR2F4P8gI1O1NpPwNBgtuGdM5RDyg
 jHLQVjVOJZtieUP06skThn6oD0lTzmJypdCeo9cs33JP/+U2B8g9bfwdoo8TSb+7RTcq
 HBPjOqdsfvy36FXROIDQd6iSd1MLhM8q3TcpL8+RPxtF6jbiGjeXi+b1+7jvFNgm7IZW
 9tg4NUkmZw6TxvxnpOWAGAhCzrEb0ZweZS3GKXn2Ys86h17xAj3ohXHW36to4gMU9i2L
 023A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+chqUTm6UJXfD7aF/izpceBqEiL/t5fhyVkCxo13nCU=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=H6Wm4VGLzANBWPmq0MkIIrLNc+e5z/ejThH/EoXm0aQuHX0F1nERKAaIAwyYCG0P12
 69chFiM5sK8iMni6Dre4lcQ3hw1QJyO8QDekfmHgHaHRMfWmhKxuf/JcZxBoNUHDwqJ/
 zRl55oJOgg0yJeqeoNuhxLNcl+DfUPbI6nqjxcig42lzcELHinw4DJSx5dyNBIeZRXob
 908j4dWKmhPsV4ZT3hRXlh3Te17YV2fAOFc67w6o2tU4UP0AMHnxbM/PS2Lb36Tu4/e/
 HuodypQgnRr9Ei0rA6Su3ymf5fRFpEzut3MMJMcHEOgrqAlEHTogsjAPS0jZB5SMCw4H
 aPaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789071339; x=1789676139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+chqUTm6UJXfD7aF/izpceBqEiL/t5fhyVkCxo13nCU=;
 b=VmKJu2ZIEJ9V9XXq5r33KmaNm7fkWLYI8gvb/FuTctAIge9bFQ6KqZ0cS9hogy8okF
 rWAnj/oxXAGlY+azlcaD2StE6hW3+zIA4MPG9s9H4VTUqcPAKXphRQI7ti6qKG8nI3wJ
 jvrA0fWz16B7gidDWqLFPYGmrSO54+ptezYxxniyqNPnpLSvx+X40LCiX4C8rmJ0dXM5
 HS5vdJUViRKrG+t2mw3hTNIjhJwHmknJtHoMOiwGrkIh1OrwaVuaJC5aWwjvmKlBnbRt
 eHfmFXKq7jgTLQ5USi/Os/7rWXpZuANBiDoJPQwMzL3jrUbPAYM1dUndOMwnXoCYPpVs
 xllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071339; x=1789676139;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+chqUTm6UJXfD7aF/izpceBqEiL/t5fhyVkCxo13nCU=;
 b=OU0FDfg0QRyBPOS3hrqVvONxsilUQ4OgZr0PhxrrMZRtZW4nQ+hQJpOjfv/pS0fnLZ
 eePD0ZWXu+Xs2+xFBlYkhTwWdhgJcZGy1qYw151rRjvoGIdu+wtxfEwQ5zAnlZikxiqA
 +FJaiQAfMw4NT5CzzWyUm85+kxAMuLBQ86FPQC829V571wURpO4nL64Fh79g37Y0lxET
 clzWuBqxDI/1vXgjZyIyupsK4wpOt7scpgTbgof6z0cnvNrnxvxEksqVK6hMPDtFrh4u
 4yrjFDngg7cmUxb8OipPHYIAnmjwEvMTH9FsHMiHwWh7NgH/96/j+25q1oZekMHk3EM5
 9xQg==
X-Gm-Message-State: AFuF++lKE0PQqfXze606e2r/5E+Su/kdIBNyP6B2CEthZByl0YcE80ja
 OU5WT6DrV1ixNAZgkOpLrKaGVI4ktAHm2OSvW7qEr1rE+UyvN1Nkq8f1BW2w3A+7XOL5FAYwKUN
 9gWh6zp3KSwWNpCOpFvCTMKEYG28SXJ2b6qyb7RkRvm1B7qQTHncXB64pTOD6N9Eq7xrBBVgRrb
 ndOdZkuPpWykCOwcFKxYERl5lOwWmi0ZxJ
X-Gm-Gg: AYBFou1aOcCDWlf6qBbAJw7nxoPyQ98zgBZrhrNPMn0jwjGrGfTldzuwBsFYe5+C4AQ
 IVLXXMxXThmHSwGXlnAIr86GeyftCBY3eEgv1+r0K+lu7d/5gYHrzjILPiUe1zuV+1+Sk1+GaJs
 tXX6etA+FqcOYItknNnt9NrezSiIHt2lgmNDYlMucCwzDpm+8OiATKEORMyv8=
X-Received: by 2002:a05:6820:55db:10b0:6b7:46fa:169e with SMTP id
 006d021491bc7-6c0bc9b8162mr384684eaf.51.1789071339615; 
 Thu, 10 Sep 2026 13:15:39 -0700 (PDT)
X-Received: by 2002:a05:6820:55db:10b0:6b7:46fa:169e with SMTP id
 006d021491bc7-6c0bc9b8162mr384670eaf.51.1789071339115; Thu, 10 Sep 2026
 13:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-5-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:15:28 -0500
X-Gm-Features: AcwNN1VRJUy2Flo6NOdLgSQYjcpGonpRO6zkgXhjYree3RNid5DNGf7VMkPIlFc
Message-ID: <CAJ+KCYPB8-coR8irYHZ3f9HqzH1EYyG_8ASSperhPkkj-g9zAQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] target/hexagon: raise an exception for HVX with
 SSR:XE clear
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI0OSBTYWx0ZWRfXyE+7NmkFiI8U
 DeQBFLaJqpbaaCYwADFBG2qTP5SnVLCuZK4GX2dfmaQGZa5UMkarRn6Fs6oWP1NLgKcx+CXcMnr
 SOsplSFxMNTBHuuUa4tToM2PBNqZbgc=
X-Proofpoint-GUID: neZSR7QvrcG385RDR3UYEFVecDwBzAHi
X-Authority-Analysis: v=2.4 cv=aef0Dhot c=1 sm=1 tr=0 ts=6aa30fec cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=5Jhoi1_dSe9dIxniScsA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI0OSBTYWx0ZWRfX1AE+t7N2uSlM
 7pM0nEG6VhmQvsm25wPmkbuIaeAqX2i3g9EMcamq5yRR/4ctTeW8Jq6RV3IsEyNJ8ydjt8ehZvm
 cp1hnfaBzS5rWSdaD83V6NM854DqBK+3Uuw7qybP3tL2zAwcMc+yDpFAiw/9EyLVWDx6eOp9AOU
 PXHzHC24Fx/XbqLhI9lYS5DPQGVaDZJPiX5Lrq6mjVuAaBTuLMxVwKwZUNAsESAuMMM1+BWbplN
 znJl1TruPN/ZEmJBFmVLiS16PJZcqldySL5rlglQ8ycxPpciASVo4i697LsXmMwSGprYxYFpmMl
 628P0POWPkBS67p6O7JTe/prjB7ecGdhV7CKKFV2iY4QP0BUwTYmAASoGkzKmzDIaX3L+re5qPq
 4tAwwrIccNU44elsWZ9Z59q5HK2v/cQOGMggAs09yBbPoa3Xw4NGxJM7I0oe/8e4wR5DxRXxsG/
 vkLIQtLGxK1jx6XlX8Q==
X-Proofpoint-ORIG-GUID: neZSR7QvrcG385RDR3UYEFVecDwBzAHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_06,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100249
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> SSR:XE gates access to the HVX coprocessor: executing an HVX instruction
> while it is clear must raise a precise exception with cause 0x16,
> NO_COPROC_ENABLE.
>
> Carry SSR:XE in a TB flag and emit the exception for the
> first HVX packet of a TB when the coprocessor is disabled.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h       |  1 +
>  target/hexagon/translate.h |  2 ++
>  target/hexagon/cpu.c       |  2 ++
>  target/hexagon/translate.c | 11 +++++++++++
>  4 files changed, 16 insertions(+)

> +    hex_flags =3D FIELD_DP32(hex_flags, TB_FLAGS, HVX_COPROC_ENABLED,
> +                           GET_SSR_FIELD(SSR_XE, env->t_sreg[HEX_SREG_SS=
R]));

Is it safe to cache SSR.XE? What happens if a thread changes SSR.XE
while executing the TB?

