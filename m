Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0710AE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPEh-0002KC-DJ; Wed, 11 Dec 2024 11:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPEd-0002Jh-Hg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:06:47 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPEc-0005PB-3w
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:06:47 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e39841c8fd6so6315537276.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933205; x=1734538005; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VnovJPgixDijZrPnP0lHYxsnngXcrD8HJjXxr8vQ+wo=;
 b=Y2Hl8YnZxwL3p2CjeVhP4a6wRP5wVGn7f4Hj+RfmoivghsRojXkumettv154/uYDZN
 1jvWEHqW9OsWpJ/jD4yXJ7ffox/NXh/4w2W9cO1A6Dsi5YkoYCcC3JVuFVrjFqT0D51M
 97GFOcJ8Hl4GRf13u23BCgZULD3odVNGX/MlzUlt/v3/ShGNyow4O9ZEtdtnd/az97CL
 vtaFNJloC/ALOLmHdf/5MnodJhg1KUUf8gO4x9D8O4IoWdU9r/vPn3GHvSHKzkreaeUN
 JZ9pbtilfu35cMkO4X3xvAa0TDd94ugFbuI8px5G2dCvp8xnweb1gtLrvMw9PiaDWkzx
 cgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933205; x=1734538005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnovJPgixDijZrPnP0lHYxsnngXcrD8HJjXxr8vQ+wo=;
 b=e2h3JsTYV4b8VnL/tvMSA7/exXoUEz6QXN+pflley1DcrHTnuwUJ7jnTu2hVjwnkiX
 W0Wit1rtoil+FBMqS2UTNmvb6+9LwMKESPaEV9ZoyVxo2zAgNvNPvldAEgEh0xAEDa2l
 9r83tMvjBiM8RthNMmtgqFq9nG/NZZaXeuq7KdZ8gDLmUXG5qIsVhh/+QemcVut+dEGg
 OKWxKX3sqxvLHyUHltcNE6ExBA53JrvrnipSXzsDxAMFrUM5Ai96um91Wz0NLBIv59H1
 MRr9RB+VcOAIL8c7RjQBdZIZxqK99Es5LONcJfUfvtMJQih95mDRhybMiMUK3ZTTU6uQ
 ++jg==
X-Gm-Message-State: AOJu0YwUOLTwxxiV7NHDgQS/+F0ZNcIiIrrvYL1EcsRavjrTjObpbj1B
 VwssFG8r2g5n5PKs/DAkEH7/2Ngn7BXG2HX26EN65P8B9Yxm71psOc3lMtctsJm+Szq7IdC40lj
 ZmwkFKKPky5swfNS4T3e1706dEMB5BS0XA4GfNg==
X-Gm-Gg: ASbGncsuHBaWiFqEG1VP0bC2FaviTTyqwX//0MZN2IcJz/MS+SJpnt/Y3uMh88MhbLp
 xEFY4m6zr7zP4FvohcHOT6hJjXmaHlYD7WMI4
X-Google-Smtp-Source: AGHT+IHlxs6+CssBwBYeDmohIpRVhPBKsFKZFzJtJoGW9ePBBDds7Gbwq2OZ0s6vJRK3TdBO3C3Cisf+ZGd0mcu/Iz0=
X-Received: by 2002:a05:6902:1688:b0:e33:121:4150 with SMTP id
 3f1490d57ef6-e3ca022c9dbmr556423276.0.1733933204728; Wed, 11 Dec 2024
 08:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-63-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-63-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:06:33 +0000
Message-ID: <CAFEAcA98UbhBpYFdCfjp3=6qNFYByBZv0Y-Z=AMOZmazgqKt1w@mail.gmail.com>
Subject: Re: [PATCH v2 62/69] target/arm: Convert [US]CVTF (vector) to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Tue, 10 Dec 2024 at 16:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove handle_simd_intfp_conv and handle_simd_shift_intfp_conv
> as these were the last insns decoded by those functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

