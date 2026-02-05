Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A00EA795F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnqMw-0007Ij-Q5; Wed, 04 Feb 2026 22:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vnqMv-0007IU-7n
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:49:25 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vnqMt-0006Zm-DI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:49:24 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6153e3oi2158155
 for <qemu-devel@nongnu.org>; Thu, 5 Feb 2026 03:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lpId79Wv8LpZge3s2DvsAJCs7h8ofKBQZTaBz0w9ji0=; b=Z3zCs9UqVofKo6nc
 XZcyEIR1m4RB65RRzOw/bZmwYOCEW9u6/x7ik7MbliWqYGydp4RcqRWUu4sSZwTg
 27pa47VrOvLfNMUxzw4bEyNmfWwuxKGO7yfE8Y5m6t3XvIw8al5l4I0y2f7iP1IG
 AiCd6GGfdlkmoHQ5t7MYRvnV25ruSnmXj9muxmXaBiZXcLfTZ425Skrw5TvAMDym
 hiHOc5LAvKKOnHk/WRLwX/XOgQaRxP6KJRPn4KANgFH+om/NnxFRHYgmv3VfAC5K
 MN/ruZq7fc6k1aD4pQljoY9Ky7/qIQ13lbeqqI9Js/ZW8u/nwyB79YW8gdhjd5jR
 4zMqUg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4gynrdwj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:49:19 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-794f00a879eso7707267b3.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770263359; cv=none;
 d=google.com; s=arc-20240605;
 b=LkUjPUj/ChfEey1Dhw4IsQt059aJaCEzSNjm7/KTeyYWW0Hl5Xoy6Xj88VBAq+lXJ6
 zdJmeXIbELBHIXTVGPOT+behtCTHHXCcqkCbtoFXSI5Jy4A11HuejbCHtY+E/WNYutB1
 wISYqP/hCKIgzLg7obgnnw1fHjfib/MY0hg+ImnBYxpz+6iHOnxh0q1UUd4+B8ND3Bd7
 g1Q1E7ot0WE2FJCC1thadHt2BrRXFLxDiENbNncBLDZenFB8nHYuFESziQ238vrHcwjP
 CqAOajj18Kr9m/D5MBvOft3UP3ngJBXsceW4b00F6l/VcaZolKMu4zBtWVsC7JipQ5Do
 WLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lpId79Wv8LpZge3s2DvsAJCs7h8ofKBQZTaBz0w9ji0=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=WWn1V/B5PNe1LK8zOLYvYo3ty6VwrNY2EXtNudUHOCdwVJ8rjbnEaHeCBW/aGcuafw
 I+1HTkh3DFMvixLncVH0lKMN68vJc4wV/jlmCNjv5lwB3Da29soffLWXJn8QpXvxEgng
 v9Jg6i45GUVqRqjKI+4CIn1l8fKpvE81eMvF52FZnwPyDMh1kdNoup07zPZOGk0+ZaHF
 Q7Oy9/sS/c4Rw7NA3KsLxHjmdiPucCcfJJbTXvRXIuJk8SuPNd3V0nbgjfBp74FcboqI
 W1GvU61zr0rUYGoXNabYKG0vXNKdgqd2n5hzBhsARwvbmoldblV0vJid3iBvf39gVCn6
 iabg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770263359; x=1770868159; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpId79Wv8LpZge3s2DvsAJCs7h8ofKBQZTaBz0w9ji0=;
 b=WTlSH+dM75y7sU1rPC74Np68AyKy90rmV9J5AP0a1xsQsV5ZSOwGJgMgNn6r/L6ZFj
 XoTtLWtkKpyO9cpMEiNh4W/F8CKH3Kl8r6LGelUvop7XJWWsyMgmR6XZAODHnipgdbbp
 t198uZSCeEZ904xqLtCnPNEqmmgT3J5S+3ynIbs4DW3Sygp/gvRefpWFz870U9/obGuy
 +Te8pFdGprY8GntTU6oIYsreS+4jL7oLo9r4c+LU5hC1LfvE7+0k9c2n7+L+bLrbuz4D
 /+P+FbmMmvS++1H8TiZyqeQbBx95OqwhcXzh1j8dR9YAs4WJXecQHHXCRDFwhW3yBTCl
 WOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770263359; x=1770868159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lpId79Wv8LpZge3s2DvsAJCs7h8ofKBQZTaBz0w9ji0=;
 b=O6Roq6onqRWg4Sy2DiUQ3zRbUVRdlvMEFvXWxregTFNaP9Nsk7I4bPrDkn4W0yikOV
 vm84BFEvCtufRZd8IAmVUyKJCadeClLaLyJPfxUjVyrFsE93uSNpRYPlnBJghidiN376
 OxsmtOuRwEZKonqjvR562dxzW2VhaYnI6AhidO3Z2ioAUhFgoB2ruWBzd1psXMCAdRSI
 Jy3JB+P9/ssgaWWnKku4Nh4OBhaJqX21Hh9nWx2kDiqZF2c54FqjnUmNQQ5n3yDBgiM2
 HcUFVR8GFENZ+A0ptd9JdztsuJn9tpEtCmOpv10w9yAZUKloifSX7oBdhFyxNqyej3Vt
 4NeQ==
X-Gm-Message-State: AOJu0Yz6f1VEnpMgsYM5iFP/KboojN4S398PFelH+AtQ3EoKPO1IgwLO
 P9/dHHou386z1e5vw9i2FVN3vT3M6nUP+vHwiyJAWriHRP6nAOWsGwpLl2PsDKE0zyEWfhgecJE
 lKI/RxIJVPR24r9608KxVhk5FjbOB5UZg8l1MgdnIMMfvf9s63FHdsLKA+M280uzaAHw6/bRJQk
 vWw6+g64PREzeb7pRk4LqfkylJW+BVLdVk
X-Gm-Gg: AZuq6aIULCzOSm4gy8QZm08on4mfIy7HM261ve3SFJVVhRKpevVs+sGEqBdmz7yXrFq
 Ljjs/ecZ24WGvbGCm4N0W+yHgL6DqoISqZJ7pXWUGyD67Vw2KEGlHW8B9XHJhMJk79BMPuFx2qd
 +FKy+DvLz8nV6F+ud9jsuRhfUym0cu2goz2AxRx2lszRxRLlM1bsFq4MFS/I88vmtxc5I=
X-Received: by 2002:a05:690e:128d:b0:649:59c2:8f56 with SMTP id
 956f58d0204a3-649db33f986mr4572964d50.18.1770263359184; 
 Wed, 04 Feb 2026 19:49:19 -0800 (PST)
X-Received: by 2002:a05:690e:128d:b0:649:59c2:8f56 with SMTP id
 956f58d0204a3-649db33f986mr4572955d50.18.1770263358741; Wed, 04 Feb 2026
 19:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20260205030617.266625-1-richard.henderson@linaro.org>
 <20260205030617.266625-2-richard.henderson@linaro.org>
In-Reply-To: <20260205030617.266625-2-richard.henderson@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 21:49:03 -0600
X-Gm-Features: AZwV_Qht2r8gfiTLw7MLsm-HAOwhCCtopyEPxQ0JysTs1pumwZ3QJv33ywFkXAU
Message-ID: <CAEqNhNbw3EKT1Cra4-UjMxvNCa+4Acjg_OFwdLvBdW3rcLudLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] qapi: Add hexagon to SysEmuTarget
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDAyMiBTYWx0ZWRfX5BEolo7nVqST
 Nvt22tlpLmRiYVprB/+D62hiToms2scmrEHbHpFRfcNk/u1rs1cKMjpfH6+Yu2vPN26Vazr12hJ
 AM8EvgIgqzS3VansZcj4nQtJ/1qtYRNAxHZh8/6MNvdpZiivyAsXs8Q1itcKzM5fum+XjQTUH5v
 ID0FBhs6dMB0gX0kZiFTEhLi6OzGhtT/AE81w14Kqzj+wauX9S+Dv77ksg0YJk2yK8q+P+1F0uU
 xSG5vLUg+5QMLnM18ZmA9CJZc7WsOa1RcPgbiHgaxw5kdT7rWr0BObU6yQmjtTW7+0NjgavAe3y
 sl4iakf2LwPaCeSS5Hp5nR7DW/4nNf0J1V7tYnNNutrw3cgCQ5b+y0vRarw0xCmJe+x72PQdyUP
 HE4BquQBaSHWQe2/7+yvEMIeeAZDOgU/CjBo7ZVLSLTTc2Rj2aTFHlqIYt4Ff6EQlrayiLa1kpU
 SZmd+h/1oYYMHjURyKg==
X-Authority-Analysis: v=2.4 cv=GdcaXAXL c=1 sm=1 tr=0 ts=6984133f cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=MCnnou26b1ttWP-Drf4A:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DDkmwu2yeLuGopxu6YrOgOkindkD0D0M
X-Proofpoint-GUID: DDkmwu2yeLuGopxu6YrOgOkindkD0D0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050022
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Feb 4, 2026 at 9:06=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  qapi/machine.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 907cb25f75..ef8575b6eb 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -28,6 +28,8 @@
>  #
>  # @loongarch64: since 7.1
>  #
> +# @hexagon: since 11.0

I-owe-you one hexagon sysemu :)

> +#
>  # .. note:: The resulting QMP strings can be appended to the
>  #    "qemu-system-" prefix to produce the corresponding QEMU
>  #    executable name.  This is true even for "qemu-system-x86_64".
> @@ -35,7 +37,7 @@
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386'=
,
>               'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips'=
, 'mips64',
>               'mips64el', 'mipsel', 'or1k', 'ppc',
>               'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> --
> 2.43.0
>
>

