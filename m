Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DDCC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJvk-00011j-UG; Thu, 03 Jul 2025 09:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJvg-00010S-Jw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:24:44 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJva-00057B-IT
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:24:40 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70b4e497d96so58702747b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751549077; x=1752153877; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ry9bsEJhCFndr7Pnz81frNVhLoeXrHIE+rSgpBk3oPY=;
 b=E/MBN9hnc4kTgnixuYdusPVXCA0GzQzExE+Z3rC+X3rDeHuGv3shwOTL7n/0X956QR
 mOESkqfR/2qYoitSayXHpdl+4lZKbvl0w6DMXL3nwk0cdCtL+SHGB1okq40HyYU+CiuL
 xOIqm7PLnKShDM9gqM0GW8UdmrVSr9H5dE5wWBD5J5XE5i6nUwPMxNK88z4JUOkDHonl
 58OWEVE6kX0F29OwuaQVwAV+C9/IVgOZZ8xzuze436aw7Cktyny6YAw9iLhCH3Y3tuwl
 WzrnQp+Hr1WJ0qGMkDPx/zzVeVHFGwFeRXLmAxAuhxy9LjWnpl4f2apnyHgqtMm74AWL
 rIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751549077; x=1752153877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ry9bsEJhCFndr7Pnz81frNVhLoeXrHIE+rSgpBk3oPY=;
 b=h3mV6ICYYzaLhxWx949V0haKjwfrUa7xjuRtR3rY9UdsrrzpuyVvyBQxYYQGtafFwc
 AE++W3igAQtr4qw8Rv7XkBOuSb6ZbqI5WO6DdxQ5gciRM6vrAvNTWiOR4WUudcwTgMor
 cQ3K9BwKCK4emtSvVgwknE/M2C7Bl24vzx8hhCL5aBfLqXdJ0khRo9AtvEyhYHS3gzon
 CZJOja2nBKKddDtv8npJ987DTzbFux6N5RM+qL8k/CFX0mdwA3Ij3Tqc+jfiTC6hwArb
 0BfhRFZjIm8f9pThmRhxwuHMNyZ9FbI+3pUCe4aRY9mCQm4Fr0RhFkeq3eNxr1D9Z0yF
 87xw==
X-Gm-Message-State: AOJu0YwZZsOZwqZmq/ndpRrVKLpbw1NzwX0hYs1CiEFThS0gergpiDAo
 dm5wQgKHcRGs6VinvynvPpGrI3kF9AnB4THKAQqnKE4a+nLo1Iz5Y00+vftQBfir91PYw5ZPQ8+
 buBK+Vlb4ovczomwznP5lZnJaxl7KD4UKMciHca/+WA==
X-Gm-Gg: ASbGncvLW1iUPlFIWzsRazi57RQOfa071GzFq/ePLwRhqiZ0uaNE9I2AROZ09eLaUBT
 h0N7gPDEgEDbJg+hMWt84dXJC1X8aReWZSZdWAgWbhkVovRJnRtZwxzG/+qH2N/WJMnMT90DIof
 vil+dTC4rX8AFQpZrr25BEEZznPsGYufZ7tP2O/o7FaMdD
X-Google-Smtp-Source: AGHT+IFCeM/fytLWqMsS73FErriGVb/VKOk34aCyMwKX+N3vz74LGdJDG9ha1JeHV4GhkUeHb8qmqV47TFawepsw0wQ=
X-Received: by 2002:a05:690c:6287:b0:70e:2d17:84b3 with SMTP id
 00721157ae682-7164d4d2eb3mr88382277b3.37.1751549076886; Thu, 03 Jul 2025
 06:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-80-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-80-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 14:24:25 +0100
X-Gm-Features: Ac12FXxDxJXUB-9C4MgNrvWwFc29ErfcE57jjSaS30TQoVpF-c_U1bfxm_GwUKs
Message-ID: <CAFEAcA837SedaYqtKaDOFSuZjZ2H=6YgZuFOVs9pSoLN5GZ8vQ@mail.gmail.com>
Subject: Re: [PATCH v3 79/97] target/arm: Implement PMOV for SME2p1/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    |   8 +
>  target/arm/tcg/sve_helper.c    | 317 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sve.c |  93 ++++++++++
>  target/arm/tcg/sve.decode      |  17 ++
>  4 files changed, 435 insertions(+)

Given how much code we end up with here for insns which are
implemented in the pseudocode as a two-line loop, I think
some more comments on what's going on would be helpful.
I assume we're just specializing the arbitrary-length
pack and unpack operations for element size and also vector
length, but especially the bitwise operation magic could
use some description of what it's doing.

> diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
> index 733828a880..04b9545c11 100644
> --- a/target/arm/tcg/helper-sve.h
> +++ b/target/arm/tcg/helper-sve.h
> @@ -3020,3 +3020,11 @@ DEF_HELPER_FLAGS_4(sve2p1_andqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve2p1_andqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve2p1_andqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(sve2p1_andqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_3(pmov_pv_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(pmov_pv_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(pmov_pv_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_3(pmov_vp_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(pmov_vp_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(pmov_vp_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
> index c41143468a..7af5c59fa5 100644
> --- a/target/arm/tcg/sve_helper.c
> +++ b/target/arm/tcg/sve_helper.c
> @@ -3035,6 +3035,323 @@ void HELPER(sve_rev_d)(void *vd, void *vn, uint32_t desc)
>      }
>  }
>
> +static uint64_t extractn(uint64_t *p, unsigned pos, unsigned len)
> +{
> +    uint64_t x;
> +
> +    p += pos / 64;
> +    pos = pos % 64;
> +
> +    x = p[0];
> +    if (pos + len > 64) {
> +        x = (x >> pos) | (p[1] << (-pos & 63));
> +        pos = 0;
> +    }
> +    return extract64(x, pos, len);
> +}

This gets moved to a different file in a later patch, so we should
put it in that place from the start.

> +
> +static void depositn(uint64_t *p, unsigned pos, unsigned len, uint64_t val)

This could use a brief doc comment, like the one extractn() gets in
the later patch.

> +{
> +    p += pos / 64;
> +    pos = pos % 64;
> +
> +    if (pos + len <= 64) {
> +        p[0] = deposit64(p[0], pos, len, val);
> +    } else {
> +        unsigned len0 = 64 - pos;
> +        unsigned len1 = len - len0;
> +
> +        p[0] = deposit64(p[0], pos, len0, val);
> +        p[1] = deposit64(p[1], 0, len1, val >> len0);
> +    }
> +}

thanks
-- PMM

