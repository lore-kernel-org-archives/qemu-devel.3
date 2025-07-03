Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71344C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGVg-0005rF-Ev; Thu, 03 Jul 2025 05:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGVZ-0005ns-P5
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:45:33 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGVX-000883-VC
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:45:33 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70b4e497d96so56069847b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751535930; x=1752140730; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yqLrDQKiB7p2Djao7wyoxhIuPDF5XbtOnum5lvMNefE=;
 b=T2r9rbFl9qAiWLzeAfbv/2C2ItOWIflqxjyASOrs8NFNUrh1koUzMepT45m3XyXuA3
 EMnDfQfg8joHP9tDFHDBKcWHCxO5aSKH7v5gqOofghI3NSeL8SRN9WkG//Hh9UkijUSs
 xiJR+8y+jw7XFY5Pv32oiAgHrIzGqgI0DBuXKfMKylNQ2lDLJaoUmUIQpKHbijt1MPD5
 Hiseo26relPVhvn2O22jUJ1DTo0OQ44ZZzGwcoslLcmN8ZTasXazkSzuQcSlEzxIvFEr
 UYHEbBGRfRHSve/zDS79CP1ybuolH+htGOf4LYmWqtFvB4/9bPeBQIaEAeWFsPVJ2p8a
 Pg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751535930; x=1752140730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yqLrDQKiB7p2Djao7wyoxhIuPDF5XbtOnum5lvMNefE=;
 b=Mx/s8dlZAlQE3/k/iDvGXisLFwTd904BuY5aBUyBw+EUI5MpeHLNEVNaPYvCWCzbu8
 53k92Jx/AVwxdCYwUWhXIlFLiGYmzJpKnK6AMY+ch4cfS821ff/Cx6Mc325eiAUB6nwC
 dQBh2dSa/IUdYHzzH7t+gLsBFi0neOZI5mW1B9tmpkR7Etdh7oM16U4uFtqb/OsKwm8g
 rmsH6KvOnhKhvbGLz4uozRDA3tW2bZjjBCXrbm3EnihecUMed/egMM8Qn7EYAI5RDFbo
 /CJnyfbc+iV3hRI5WjxMStEqQEK1kxfivB/lboDA902BdfuqvDWf1y0iE9adkpUiBdWV
 KOjA==
X-Gm-Message-State: AOJu0Yyy8Is+aU4RY/FAnXJ4o/rspvsEm74TjQAbfV/wmYpfRNSWmFtc
 NC++MQLxe/BdaUdpTMhdJIG+SAdzihQt57urzxi/cOxRa+MeIIb1oB6RRdlLshVHmQcn8uo+++Y
 a5J2Ijz2U0zaoslyXKn3bpAGTRT1QFt5guvpzc/JTKg==
X-Gm-Gg: ASbGncuPAKCtfRv38VH5t+z0eOkjNa080SMYrNkrb9Ihp9mlMh0zOai9mufZbZudhBJ
 EpkH8qwq+YLhgw6lY0DIB5MQjn5N8DNiP7TujbCvlA5zIhK0B9Iur2IPTd1I1l+GakvkisDUskx
 4SnsFfuI30wmHvCEtBJVbg2ThrtpKQdnSoIwOpe/cSL9oh
X-Google-Smtp-Source: AGHT+IGjIfIAD+LV2tqehV7yb3BH/6Z3KXaPE6RPuMbUYwZT62TaaucfNaS54V7bkDSyEphUJf6AP95/IJeBJb5+iF4=
X-Received: by 2002:a05:690c:f0d:b0:712:cc11:aed with SMTP id
 00721157ae682-7164d27d0e4mr90397977b3.2.1751535930213; Thu, 03 Jul 2025
 02:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-32-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:45:18 +0100
X-Gm-Features: Ac12FXzYp_EOl4Fj5V6qX_5rlS4wbCmsU_qh2I4BV8fA2paflc3HX76WbAUu6Rg
Message-ID: <CAFEAcA8szLP4mEvkatHhbBJzU5A6w0XGcMRRJYr_HPSNgZmU7Q@mail.gmail.com>
Subject: Re: [PATCH v3 31/97] target/arm: Implemement SME2 SDOT, UDOT, USDOT,
 SUDOT
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

On Wed, 2 Jul 2025 at 13:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



> +/* Similar for 2-way dot product */
> +#define DO_DOT(NAME, TYPED, TYPEN, TYPEM) \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
> +{                                                                         \
> +    intptr_t i, opr_sz = simd_oprsz(desc);                                \
> +    TYPED *d = vd, *a = va;                                               \
> +    TYPEN *n = vn;                                                        \
> +    TYPEM *m = vm;                                                        \
> +    for (i = 0; i < opr_sz / sizeof(TYPED); ++i) {                        \
> +        d[i] = (a[i] +                                                    \
> +                (TYPED)n[i * 2 + 0] * m[i * 2 + 0] +                      \
> +                (TYPED)n[i * 2 + 1] * m[i * 2 + 1]);                      \

Don't we need some H macros here for the big-endian host case?
(For that matter, the existing 4-way dot product helpers also
look like they won't work on big-endian...)

> +    }                                                                     \
> +    clear_tail(d, opr_sz, simd_maxsz(desc));                              \
> +}
> +
> +#define DO_DOT_IDX(NAME, TYPED, TYPEN, TYPEM, HD) \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
> +{                                                                         \
> +    intptr_t i = 0, opr_sz = simd_oprsz(desc);                            \
> +    intptr_t opr_sz_n = opr_sz / sizeof(TYPED);                           \
> +    intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);                  \
> +    intptr_t index = simd_data(desc);                                     \
> +    TYPED *d = vd, *a = va;                                               \
> +    TYPEN *n = vn;                                                        \
> +    TYPEM *m_indexed = (TYPEM *)vm + HD(index) * 2;                       \
> +    do {                                                                  \
> +        TYPED m0 = m_indexed[i * 2 + 0];                                  \
> +        TYPED m1 = m_indexed[i * 2 + 1];                                  \
> +        do {                                                              \
> +            d[i] = (a[i] +                                                \
> +                    n[i * 2 + 0] * m0 +                                   \
> +                    n[i * 2 + 1] * m1);                                   \

Similarly here.

> +        } while (++i < segend);                                           \
> +        segend = i + (16 / sizeof(TYPED));                                \
> +    } while (i < opr_sz_n);                                               \
> +    clear_tail(d, opr_sz, simd_maxsz(desc));                              \
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

