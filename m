Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8D9C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXG15-0003Rc-1N; Thu, 03 Jul 2025 05:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXG0w-0003Po-LN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:13:56 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXG0t-0002Oe-TT
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:13:53 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e1d8c2dc2so53915357b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751534029; x=1752138829; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jShZV7YTb0wir7CgNkRRubWx084G582r+Vo/uc1OJlE=;
 b=Y3xcAoxKpv0qpA2nS2OdORPULPRN08m5HGNUFCya80H1uxcXVwWVRD2Xd/cBVJLDfC
 SF7MIlEIBL+ju243bKFTGg8GM1MTQk3ggieir4aSti/OvZ5yT3yfjZOuf3N/h+zAMYe/
 696ScttL74tqPctnP/MvjRwaMzw4qo3618XRqWcT+cvJNO3Umo2YbNifDQOBAJ3WILHt
 F3C9HRrA23VpAuo+PHtOMFq8NcobBrByzm/b8AnJo4zxhl/7n3hzhnuZ1RMvtKN4+TN7
 PEoxOE8B9CyQdpINQMFE5cSwwabSDAChcg8Sh832nxRN3MedxJ33qSVdPbQ8ENJo60/M
 Uj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751534029; x=1752138829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jShZV7YTb0wir7CgNkRRubWx084G582r+Vo/uc1OJlE=;
 b=ZnnGYOcA8vAbHrtYa6RHb28aYPraltT50WsdLmFIwWzP4lmtyJqloFGretfyqXxDgm
 69LIoHmX7XyksH3zQMIat9b9lLiFXc28T8FSEVyscrm/MEr7RgasUdoujUvqLN6h466J
 Z9gSBfp06HbDVJAKzJJtEYIAHuhYd9nfzZbGKvrZXUswRJJP/dP9IfhQ/48f0Yqbniqd
 4w9brog4LbElJvIPui9DEA82Xx48CKi8td+Qv2GvZPefTNT7eJCfrgSpdtbLiUFFxB1/
 ninQC29mRFDUgDL0QJDdOGMxJsS2GRAqHoUOKdCWwNzY5hTGCWTKoPPqKrwe9HcgYtB3
 o+qg==
X-Gm-Message-State: AOJu0YwVGSxdBv4NYXiDMyvqvkfkPEqRlRhrhxm+mfx2wD/dk9ADqomW
 aQ18by9upek1k11+XH+91a7MXSrqS1ghgZCOBjaJ4A7HQxN2K1giH5oMBVz2obpCHp8XgnYYb2K
 dpudkxoNFrCeBa+5sNfmoxK82RLX8NAURO6r+sw1IMg==
X-Gm-Gg: ASbGncvoyQ3g7ibKvQAhnue17cs1GHo19aNN7p75093490m6tiDUqHjFdyQuB5aZKFy
 d8xVW/SbuSEv6Y/10eT40/clm6hXxmTFmsO9F6YcJb0IYXTwl6r95AEiqYMBK8nDwpK9/pHRehA
 UhG3jmysv9caJNtD6cXbK2AQVzM1yRr7AKnjSddoeR+AHw
X-Google-Smtp-Source: AGHT+IHeDhx+JOXfE4umtzFh7pSgQBGF2qxLnY6kXcx4LyP64EvVGGavR4dL0vw5nTPlPumW4FLb7W6WSm1ydaqGcbo=
X-Received: by 2002:a05:690c:fcc:b0:709:197d:5d3c with SMTP id
 00721157ae682-7164d2c7e12mr90705157b3.11.1751534029352; Thu, 03 Jul 2025
 02:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-10-richard.henderson@linaro.org>
In-Reply-To: <20250702122213.758588-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:13:37 +0100
X-Gm-Features: Ac12FXxHROE6WicPcu59BvDqB-HVVYixTkL3nUz_AyIcPRqHhTNHHNLyVVqSsOo
Message-ID: <CAFEAcA82qZu54fsQjfmy-s3VdzsJrGYccTQPdM7oQ0ienk9LpA@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] target/arm: Fix bfdotadd_ebf vs nan selection
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 2 Jul 2025 at 13:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implement FPProcessNaNs4 within f16_dotadd, rather than

should be "bfdotadd_ebf" ?

> simply letting NaNs propagate through the function.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 0e1850182a1 ("target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +    /* C.f. FPProcessNaNs4 */
> +    if (float32_is_any_nan(s1r) || float32_is_any_nan(s1c) ||
> +        float32_is_any_nan(s2r) || float32_is_any_nan(s2c)) {
> +        if (float32_is_signaling_nan(s2r, fpst)) {
> +            t32 = s2r;
> +        } else if (float32_is_signaling_nan(s2c, fpst)) {
> +            t32 = s2c;
> +        } else if (float32_is_signaling_nan(s2r, fpst)) {
> +            t32 = s2r;
> +        } else if (float32_is_signaling_nan(s2c, fpst)) {
> +            t32 = s2c;
> +        } else if (float32_is_any_nan(s2r)) {
> +            t32 = s2r;
> +        } else if (float32_is_any_nan(s2c)) {
> +            t32 = s2c;
> +        } else if (float32_is_any_nan(s2r)) {
> +            t32 = s2r;
> +        } else {
> +            t32 = s2c;
> +        }

Looks like a cut-and-paste error -- we check s2r and s2c
twice and never look at s1r and s1c.

-- PMM

