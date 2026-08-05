Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1221BC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfAn-0003SR-DG; Wed, 05 Aug 2026 13:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <philippe.mathieu-daude@oss.qualcomm.com>)
 id 1wrfAl-0003SH-5X
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:12:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <philippe.mathieu-daude@oss.qualcomm.com>)
 id 1wrfAi-0005sA-TP
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:12:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVL9E3356561
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 17:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:reply-to:subject:to; s=qcppdkim1; bh=NdFbojcB9LM2J
 jG+j1evYrTT1rQlZNFl6v2gu9MwArc=; b=mSYBgVnZODIxMwRPd/Ma5bGmGHs7T
 kd+PRu26c9jtR6FzE622nyUXx0kKmRmcwJE6OInPCaymJpkbb5inFT8OnvUT3xDF
 50/vJB2IM6ZaPWqqy2nT5x/XFux5iGbPRMPx/i9UwXx9HDgyKXX1Qcm/3kpspuuW
 g27TE9ziP31QzOfAfDvIFg4fNdjpBkhoJbYeWUqlodaeXUnFmW+JdsHv2+1XlDWf
 sJLLhHcdICZ8iJJGyQDoCBZ7LBgT7eVS7iY6couPKkR4AhhDQNWrizJmq3FixP3R
 +KYByFxAdpjEgM4rZKEF2ePmq8idpBDaSl2pOq1U0IkPzXShI/92nEp0Q==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2r622a2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 17:12:48 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-976cb36b375so234349241.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785949968; cv=none;
 d=google.com; s=arc-20260327;
 b=oaYeCf+BrYyd3nUfLf+MIgEvxi9/wCjigZZPJXSc+Il4varDpu8eI0BSoFdbuAEt8A
 Ona9WDolydh0NsOZgIB6V66Hgo84fltd8PeoJoC8lFWQL5pSZJiL8lK2/5eK3qIiBnpo
 axl5HZUlNqn9yrQ+oi4Z1RVxiffdMvJlWYXFf/C1Po5ELA478B8gmj+L4+5HFb4sGkzU
 iSNbcCZOBGh0SLGrSczyPbYF6GMZuTJhXq4xzyBsJLu3vynhel1S8RHfHZ45QL/Iajnk
 VyK8qlbsgRBqtPJBvhPEPzkDfOjtI+IHva+rDYRBnZ4mgBwfar4HF/xLIT3hSfpvkbMy
 es/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:mime-version:dkim-signature;
 bh=NdFbojcB9LM2JjG+j1evYrTT1rQlZNFl6v2gu9MwArc=;
 fh=61BSukYk6bgvj4GpJ3Prd4H5hOhQKozIhcO1l4pnlxs=;
 b=Paob0Ic6Hs/xob7zB4qMK/dTqQbYBRtPAZ+Ujfw/OXl7PlLiDezT59F9CpxqAgfBSr
 qGDJGrxd43mBuVeHV7Bfp+8sS7eOorIbGpIdR4xtxU6kabgySGS6D8sZ3e7IvgzOwGXS
 4t5B4ko3zDB+ity8sqQB664QycJh+JelNMCMgn1fnIZUt4xpsyf7Ds74u3Pm78HqbWMV
 2Ah4jP1hAzwyduW/msYCGKSRSWyyZp7BQh75xjvhONGvGxvK3JEMX+r9K29Zo5h+LuuB
 FRzrc2STKwtqx+uIok0bxn0gSGgB6aOHVR0ZBMu3iHwFgJd06zUliDZSRBHsYw3baIfe
 3AzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785949968; x=1786554768; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NdFbojcB9LM2JjG+j1evYrTT1rQlZNFl6v2gu9MwArc=;
 b=SUiGID5nij4Gl2s3Nv6a32YXGoo7jw7TPR7Ktas/3AA1K7Sn21nRsXFKNvdp2SXWgF
 fWSJb4zhdVhoc7diu5X0PUtFND2GnnqHJDhVA2dG6qH/25/dzvAWSG9pWq+rOX19TKst
 7LtAV++Vp/0K2u+gQ4zx+rm/bm74YMtzfJ6xmgB7F/4GlVqunBJlKktjmLQv+62Q5xTq
 BcNhmsteEA+B0smAH5SgLy+2eydxOWwyxp3vs0DyKTDhpWvye9N9g8/dQl7GPONh0Lc0
 XX0LGYAPYhqnYt74rCxB8wwK4jCMtKCbIIdddaJeiVz20S9gmgbC/RoPVNErI3L+8j8d
 Wdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785949968; x=1786554768;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NdFbojcB9LM2JjG+j1evYrTT1rQlZNFl6v2gu9MwArc=;
 b=E5xoa+JihjG0jIF+3QUf/WEFL3qte0rUwPADbi8IdkiL7TGXSlUX7jGcCWZ6KGvBOr
 FBjtGtjtYy2e9MT36No5AhfUEHgGuClYSVB+c+jYt2YneQxnEeQ/ugjvnFiGvBRsC5Nc
 lJkx5j7jkInToKH0nWpIBthHs6WDcMJQqHHTk7AA2x3De3ZN42zeO7lcPjjImkz86QpA
 w+zWmLc+z37SkH6OIr+zs+3CkJvvgBylY/6CdtK6TPD6KYiQuTQ4lQ8yROS6kBtio3GR
 XDksGLhppEMaMniUrVu0z9z6ddvxDsm7E18bspist0OivSYw3fNnbwKg81EbTgo0oBjm
 ktVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDBAgqEQY3q/oFSBS3QFiLZi28rJcU+/jcmk1qB+aeIjXDKLae6dPxaSX86TinB2jwNrvb0IgU5D5J@nongnu.org
X-Gm-Message-State: AOJu0YwY/XZq65jtJW8t5a4Q4UJRef2vpjcwLNL38CBir71t5bWPyJxm
 8ZvnXwTL/KrvOcUUhWNu1jlC/EPISMpPomwgQTjZ+VmNI4FS1qr/MK1jkhoPZePvKYroqzbcirW
 RhR4Go847TBGjK2XPERZRaaGD6vj17ZKHQpJ2dD3MZ9DXlr7lWvy30zWgTMHb2ZC5+jPh85szPB
 TIs+QYeuE35ffRtHP85Zi2BrZtD0WNaHG8
X-Gm-Gg: AR+sD10m9BNNgWPB6X8aiimLhq8B3beeBujBhN3d+J95iGxRSuC9NFvSjR6GBATwOmA
 VybYguihe/uekIGdlHO0O+T+6hUJsB5NDIBhIXAFONeRT3ki2IpkTy0/FZXQC52+Y1yyWCeopDY
 IhQ18QLQpyVtWewpmb4Kru/SmY7QDRiwqA4ptfBIr6HX9h1aUN7WoQLIDf05M=
X-Received: by 2002:a05:6102:6a85:b0:739:5f55:3c3c with SMTP id
 ada2fe7eead31-760ed284196mr1983318137.13.1785949967684; 
 Wed, 05 Aug 2026 10:12:47 -0700 (PDT)
X-Received: by 2002:a05:6102:6a85:b0:739:5f55:3c3c with SMTP id
 ada2fe7eead31-760ed284196mr1983301137.13.1785949967208; Wed, 05 Aug 2026
 10:12:47 -0700 (PDT)
MIME-Version: 1.0
From: Philippe Mathieu-Daude <philmd@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 19:12:35 +0200
X-Gm-Features: AUfX_mz17nNt8eocfxqjFVae9trD5RMucwdEb1BrN3DPOFE-KhPTAj7U9raaJ_c
Message-ID: <CANWQopVRj=Uogwhf=MTGrs3-Hk3HrE+X6aU5Zmtq8zyCiNciWg@mail.gmail.com>
Subject: Re: [PATCH 1/6] host-utils: fix ssub32/64_saturate return type and
 clamp direction
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=WrIb99fv c=1 sm=1 tr=0 ts=6a736f10 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=4YZXNOiDV-AFHUgz1FwA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: OdfDlY-3jOjK44fbTD0Bz16fcdKhFVwT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE0MSBTYWx0ZWRfX2IwNl5da2uHw
 0XLvKIAzInaFCsYF1HYfXl0baCXosU+9YxvxLLjJRc/rbh4Sue7USLdIEvjkRqHBpsgt3qJsCQY
 FloQyJ0kM0UJLIoGL+MJkKhIobS1Ky8=
X-Proofpoint-ORIG-GUID: OdfDlY-3jOjK44fbTD0Bz16fcdKhFVwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE0MSBTYWx0ZWRfX6G7cBLpjFa3N
 pl/hrzPj7IypfSrhqid0HNThsKOuVBybR5Amzn0cUtoOyLpHVwLyyf/E6gYq13tNWe3/W3gS4/9
 mDSoL12RQbcI03MtOmWaA7RVFDQ+cZ0qqZO9f77RdFAB2/xPjzJeT7Lmr4QSuf0ta1gcw5tBrVe
 edqVFUhXBxPEgSrg7lyDReu1vCxhyUQtQCwSsMF2MxWl1ALMvvIak4naaUxAw0fKYSyoUydCxBX
 UFlKAcvB34UR+LLM8uMxPRPNhuMx71cjIJDzU92DbqBt5w87xJaXeXEyiaO89CAfzaM9e92cOVZ
 SpcNcLd1ZpkRBubHmnz5PWsbBuVvKNYumi1mGnhLVN5k+pszBiTyk9abrszJJx0Bn4Ul7ZCpIgK
 t+GBETtzln9OBH+kWSvo8UJngZUHrJ+cE+HrmZeAna3iPvYWVLkkO3cznX0u6F3YlMPEdQL74Df
 OOCyM/0hK3go4YKI4Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050141
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philippe.mathieu-daude@oss.qualcomm.com;
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
Reply-To: philmd@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/8/26 18:52, Brian Cain wrote:
> ssub32_saturate() and ssub64_saturate() were declared to return bool
> instead of int32_t/int64_t, and clamped to the wrong bound on overflow.
>

Cc: qemu-stable@nongnu.org
Fixes: 16495533131 ("host-utils: Introduce signed saturation primitives")

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/qemu/host-utils.h | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> index 2e8da7fb3d0..291bb198b65 100644
> --- a/include/qemu/host-utils.h
> +++ b/include/qemu/host-utils.h
> @@ -610,7 +610,7 @@ static inline bool umul64_overflow(uint64_t x, uint64=
_t y, uint64_t *ret)
>    * sadd32_saturate - addition with saturation

While here, "32-bit signed addition with saturation".

>    * @x, @y: addends
>    *
> - * Computes @x + @y, and saturates rathern than truncating the result.
> + * Computes @x + @y, and saturates rather than truncating the result.
>    */
>   static inline int32_t sadd32_saturate(int32_t x, int32_t y)
>   {
> @@ -625,7 +625,7 @@ static inline int32_t sadd32_saturate(int32_t x, int3=
2_t y)
>    * sadd64_saturate - addition with saturation

Also  "64-bit signed addition with saturation", etc.

>    * @x, @y: addends
>    *
> - * Computes @x + @y, and saturates rathern than truncating the result.
> + * Computes @x + @y, and saturates rather than truncating the result.
>    */
>   static inline int64_t sadd64_saturate(int64_t x, int64_t y)
>   {
> @@ -638,30 +638,30 @@ static inline int64_t sadd64_saturate(int64_t x, in=
t64_t y)
>
>   /**
>    * ssub32_saturate - subtraction with saturation
> - * @x, @y: addends
> + * @x, @y: minuend and subtrahend

Eh? "addends" is a good description. If you rather:

  * @x: first addend
  * @y: second addend

>    *
> - * Computes @x + @y, and saturates rathern than truncating the result.
> + * Computes @x - @y, and saturates rather than truncating the result.
>    */
> -static inline bool ssub32_saturate(int32_t x, int32_t y)
> +static inline int32_t ssub32_saturate(int32_t x, int32_t y)
>   {
>       int32_t ret;
>       if (ssub32_overflow(x, y, &ret)) {
> -        ret =3D x < 0 ? INT32_MAX : INT32_MIN;
> +        ret =3D x < 0 ? INT32_MIN : INT32_MAX;
>       }
>       return ret;
>   }
>
>   /**
>    * ssub64_saturate - subtraction with saturation
> - * @x, @y: addends
> + * @x, @y: minuend and subtrahend
>    *
> - * Computes @x + @y, and saturates rathern than truncating the result.
> + * Computes @x - @y, and saturates rather than truncating the result.
>    */

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

