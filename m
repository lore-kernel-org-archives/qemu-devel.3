Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E054AC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTi2B-0002nW-SZ; Mon, 23 Jun 2025 10:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTi2A-0002nF-IF
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:20:30 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTi28-0002G3-RS
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:20:30 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70f147b5a52so31151717b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750688427; x=1751293227; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yuppWqaXYL5UWd6raTKBE7r81gHvrLWtf5JJRZhellc=;
 b=SxVct9Ut5Axk0KnTbtBcKL7C33A9latjJv/FIRN4jS+X31ZBtJdPArp/yBonIcxqMc
 IH7gPBiTqzN+uSdM+4+1oly/4uty3k/T5H361vXKnjDZWdbpvfoeKNNeZldVJ2tOhfjE
 Pix6lKQsLy8+a7gXq+LxXBztM+2sYx+DVbTfRC6YIwEpfouxr9DlL0xMcfZU9ItnvZmR
 ZIIoSudUJtoPebS2WsSM2tMheJ1kRL/ZZp7+hDEPnMc/8ItcKS6ZQ03prJdVQP6KQZq3
 mf19h98WCsU3vlZxgIm8uCR6C7xj5qnjPluib+pR3hgTvdggYc/i8MP6xxwp4+/cYd/p
 EeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750688427; x=1751293227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yuppWqaXYL5UWd6raTKBE7r81gHvrLWtf5JJRZhellc=;
 b=kiyGi9J//hE8vqnXcrNevj+8pEkyWMFqF6+rrMWcCdJfeiGIVKRYVBMxxGtzp68ttB
 d9Ru6d7O269RUq7kOybRGdEM+T9btxHLA6WlvBtYZcIIPHvLC4kuLLBYa5hFdDYGaeGV
 jKOwsDQ414/EwHGaldczRkTlg7XtikmgTEhunU9PRnElL9l9hBLQrMZRQ7DsBP+yoJxQ
 F9Vy6L23w+MAsdh7dDCNlQBnmkYvvDrXlPwClPPQV3wZqOnW3CeJXYo3ExLWiKzwnxyq
 E1N9EOHvS+IyvG1qDJjARKcgqjm0HC+hKFtd1yCwdVmyzEYHqW1KzDKxq1bg3npoFF0M
 QUkg==
X-Gm-Message-State: AOJu0YzjVaiinH2vXPqYmw3RdJeZfELCcC1Lswb6q79s2BNPb2CKnv5f
 RP/8AMBWzp7Apzgx1RQ18BfokJ6vMaR6we8qEwTAEjbHCEj08epb43tQt7CcVl9PP5hQLSzpWtu
 WUMElUS1I41d0qiQcaLXYs5YRKXQ0fyxPlDz5aoXQjw==
X-Gm-Gg: ASbGncvfjixxndUvwfFwqjubqCmdWOC0t635l3v+fuu4GdzwojNNIgt3K7LVe2Luhpb
 nAPN6bD5tly9u9e4GlcaDfZyYv2sDHqepcK8anDrqS8fSxS+ugoyPcRGyWRZTepUVM9aDBxB2/t
 pVkI3RvJQyMhlcT4ejkjtAbggLbHIuNQdoCaK6vpQNX5hZ
X-Google-Smtp-Source: AGHT+IH9SeJ3GA6hcU2X/rzOl/7TU0D+V4Qddyt2ucji/8+2QxA9nziKYXN6vcdvrdwbFM++prIYcprxQLdCplDGGBA=
X-Received: by 2002:a05:690c:28f:b0:710:f564:5071 with SMTP id
 00721157ae682-712c63b17e8mr200593477b3.11.1750688426692; Mon, 23 Jun 2025
 07:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-24-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 15:20:15 +0100
X-Gm-Features: AX0GCFvE6_1unCFDQ4Go7mw8NlD4J3fWuWmOpG4SJ4TBUBGa5BcgFieLljo2mQg
Message-ID: <CAFEAcA_+nS5jJxaOdoLD=mQSUatL01+NckO-dTZqrti3JqzYiA@mail.gmail.com>
Subject: Re: [PATCH v2 023/101] target/arm: Implement SME2 MOVA to/from tile, 
 multiple registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sun, 22 Jun 2025 at 00:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---



> +static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
> +{
> +    static gen_helper_gvec_2 * const cz_fns[] = {
> +        gen_helper_sme2_mova_cz_b, gen_helper_sme2_mova_cz_h,
> +        gen_helper_sme2_mova_cz_s, gen_helper_sme2_mova_cz_d,
> +    };
> +    static gen_helper_gvec_2 * const zc_fns[] = {
> +        gen_helper_sme2_mova_zc_b, gen_helper_sme2_mova_zc_h,
> +        gen_helper_sme2_mova_zc_s, gen_helper_sme2_mova_zc_d,
> +    };
> +    TCGv_ptr t_za;
> +    int svl;
> +
> +    if (!sme_smza_enabled_check(s)) {
> +        return true;
> +    }
> +
> +    svl = streaming_vec_reg_size(s);
> +    if (svl == 16 && n == 4 && a->esz == MO_64) {

"svl < 32" would be a closer match to the pseudocode.

Exceedingly nitpicky nit: the pseudocode seems to require
that if the SVL is < 256 bits because the implementation
doesn't support any larger SVL then this UNDEF should take
precedence over the SVE/ZA-enabled check, but if the SVL
is < 256 bits because software has set it that way then
that UNDEF check happens after the SVE/ZA-enabled check.
(The former happens in the decode-pseudocode, the latter
in the operation-pseudocode.)


> +        unallocated_encoding(s);
> +        return true;
> +    }

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

