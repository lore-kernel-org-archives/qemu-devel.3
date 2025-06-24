Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E0AC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7eT-0008CW-GV; Tue, 24 Jun 2025 13:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU7eK-0008Bw-JE
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:41:38 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU7eI-0001Iv-J9
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:41:36 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e81749142b3so709675276.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750786892; x=1751391692; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cEpmuZIOfbe/eyHtJ8Un+mngZx1uRpOMLH3GjvXh3Zg=;
 b=XrG3YKdc97nSLjJ2og4h7fp6djLrbPRyZ5QTqelpg/v6nkMFzSUYVzRMN+hB/QqBGf
 bnuQBVNvFnfvG4D3gD5dN8SJymTbHw+j1P4JAbm5PpTmtBq0yE47Z7Rd7B869kToDGLr
 pWJnC+BVl8qwNpoFdtTOEao0QqWMG5Kq2AjDWmtYqdEJBPZDKcqKpQl7C5ruJuZYjOeh
 pHL5bs3h9act13TG8igYGbBZjX2regYUuwuqDgksH/b8O6Z19+wNMxXcT//Esu3oXPvG
 PAagHgtMA5eSAjw8rY8l+YJfidq9+iscYmcMLgBgtMrvPbiJml/EdqqdSjHpjSTFVC35
 +/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750786892; x=1751391692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cEpmuZIOfbe/eyHtJ8Un+mngZx1uRpOMLH3GjvXh3Zg=;
 b=jzFvgSY3MvQ5qNNqZmJs9SejXRxsXFQjbU7mNQ4zsesMcDE8vDgNNEGUZESnvRZtVf
 yvY2I+dNMLxCj7rCW0epUJihK0nyuITY5bhcWLNFGrdicW1lqI74Q3i/nYqdPvOKAme1
 Pxescnl0ZaIEGY4Yds+Oj1XgnhlowcW1djHRD4fyxxPGsSMIxLDep6BjW/0J9tgQ801E
 yZ4NGZJp0qAGUjsDbbegarpu918YGc3Hww95yXajZffWoQEJt0VxzGB78KqF1aXFQ+k1
 BIJgbwCWWw53QNHo+yh7U8TBb4HLfWaM3rp2x6Lz+LtRqBttSPTijF5TETNjrEy5vGy8
 Fwhg==
X-Gm-Message-State: AOJu0Yx8USGA/l6A0Dh45FWQRf0ghVsYT/bLbbHZDVtGI9Ey6pRUkQhk
 9RtWNWBHmSosWpoO/001lbn/kK30pWpBf6HbEL9S30TKegKYqFGT1GJ/VmAHOnkk4/6gr/bGvIP
 bjdREy/mlBVbTnhfAC3yYIhKk8RN2k2kEGCNLXTBlig==
X-Gm-Gg: ASbGncsTbE+dqE01pJiHLa4upPl/79kfB7mwiXcBWtNigsk7AvepnG0mtYW3ILXiFJJ
 WSEsubaal+MhBsOB+oickLQ5w6Tw6NTavmYlu3onKnpeMcHDGgLPoeIsXAsjiAox1dDaccqx7mU
 NTZGGzgroThXH1E9474qd2BsgKjdwrLCicWJHOHZWKJolR
X-Google-Smtp-Source: AGHT+IG65foZ3hK4NPZMIZZxU4ynTnExuSl5iP4ce+cqfJNBZA6Zp4jVC94K+Bj0b6QtLEBqJXJ+PgGNZF+Xb+xIwKc=
X-Received: by 2002:a05:690c:4d82:b0:70d:ed5d:b4da with SMTP id
 00721157ae682-712c63b1f6bmr251411657b3.8.1750786892502; Tue, 24 Jun 2025
 10:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-47-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 18:41:20 +0100
X-Gm-Features: AX0GCFvDoP50E4cjFaNqhzrW8KgoH_vbIZNbhefBqXAfRqWmIOCjDpfJF5XfDiU
Message-ID: <CAFEAcA8kMpXXV1H0FDY2Pm4vCRF6JXMur3+qm3aoKuRcE8Btrg@mail.gmail.com>
Subject: Re: [PATCH v2 046/101] target/arm: Implement SME2 SMLALL, SMLSLL,
 UMLALL, UMLSLL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Sun, 22 Jun 2025 at 01:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  22 ++++++
>  target/arm/tcg/sme_helper.c    |  60 +++++++++++++++
>  target/arm/tcg/translate-sme.c |  78 +++++++++++++++++++
>  target/arm/tcg/sme.decode      | 135 +++++++++++++++++++++++++++++++++
>  4 files changed, 295 insertions(+)



> +#define DO_MLALL_IDX(NAME, TYPEW, TYPEN, TYPEM, HW, HN, OP) \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
> +{                                                               \
> +    intptr_t elements = simd_oprsz(desc) / sizeof(TYPEW);       \
> +    intptr_t eltspersegment = 16 / sizeof(TYPEW);               \
> +    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 2);         \
> +    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 4);     \
> +    TYPEW *d = vd, *a = va; TYPEN *n = vn; TYPEM *m = vm;       \
> +    for (intptr_t i = 0; i < elements; i += eltspersegment) {   \
> +        TYPEW mm = m[HN(i * 4 + idx)];                          \
> +        for (intptr_t j = 0; j < eltspersegment; ++j) {         \
> +            TYPEN nn = n[HN((i + j) * 4 + sel)];                \
> +            d[HW(i + j)] = a[HW(i + j)] OP (nn * mm);           \
> +        }                                                       \
> +    }                                                           \
> +}

Here the indexed helper takes the indexes out of vm, so...

> +static void gen_helper_sme2_sumlall_idx_s(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
> +                                          TCGv_ptr a, TCGv_i32 desc)
> +{
> +    gen_helper_sme2_usmlall_idx_s(d, m, n, a, desc);
> +}
> +
> +static void gen_helper_sme2_sumlall_idx_d(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
> +                                          TCGv_ptr a, TCGv_i32 desc)
> +{
> +    gen_helper_sme2_usmlall_idx_d(d, m, n, a, desc);
> +}

...you can't use the usmlall_idx helper for sumlall_idx.

This should fix it:

--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -219,6 +219,8 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_s,
TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr,
ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr,
ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_d, TCG_CALL_NO_RWG, void, ptr,
ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr,
ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_sumlall_idx_d, TCG_CALL_NO_RWG, void, ptr,
ptr, ptr, ptr, i32)

 DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 16bdf61f51d..ba80aec6d45 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1515,6 +1515,9 @@ DO_MLALL_IDX(sme2_umlsll_idx_d, uint64_t,
uint16_t, uint16_t, H8, H2, -)
 DO_MLALL_IDX(sme2_usmlall_idx_s, uint32_t, uint8_t, int8_t, H4, H1, +)
 DO_MLALL_IDX(sme2_usmlall_idx_d, uint64_t, uint16_t, int16_t, H8, H2, +)

+DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_sumlall_idx_d, uint64_t, int16_t, uint16_t, H8, H2, +)
+
 #undef DO_MLALL_IDX

 /* Convert and compress */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index c507c7cd277..006d4e2ac09 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1282,18 +1282,6 @@ static bool do_smlall_nx(DisasContext *s, arg_azx_n *a,
                       a->idx << 2, 0, false, fn);
 }

-static void gen_helper_sme2_sumlall_idx_s(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
-                                          TCGv_ptr a, TCGv_i32 desc)
-{
-    gen_helper_sme2_usmlall_idx_s(d, m, n, a, desc);
-}
-
-static void gen_helper_sme2_sumlall_idx_d(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
-                                          TCGv_ptr a, TCGv_i32 desc)
-{
-    gen_helper_sme2_usmlall_idx_d(d, m, n, a, desc);
-}
-
 TRANS_FEAT(SMLALL_nx_s, aa64_sme, do_smlall_nx, a,
gen_helper_sme2_smlall_idx_s)
 TRANS_FEAT(SMLSLL_nx_s, aa64_sme, do_smlall_nx, a,
gen_helper_sme2_smlsll_idx_s)
 TRANS_FEAT(UMLALL_nx_s, aa64_sme, do_smlall_nx, a,
gen_helper_sme2_umlall_idx_s)

-- PMM

