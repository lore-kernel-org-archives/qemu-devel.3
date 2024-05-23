Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D84FC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 11:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA6VN-0000Kv-Me; Thu, 23 May 2024 07:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6VK-0000EG-0p
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:21:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6VG-0002FQ-Vx
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:21:00 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57847c08e0cso785406a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716463253; x=1717068053; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3TftuAjqYhvVjsSBNnC7HmXavSpZdwsBZyLQvBuHfT4=;
 b=cpxtarhgLKLaB8yWL9ZBk7cper6/b6EZn3Ffd1ho7YQA0YMfRVr7FKKq2FClDpvinQ
 u2u8u4I8xKYGYP5IdYpKvztCKlYviv74EmHNx47iHIh6rlLBO5NdCo2K5qw8B4nzyakO
 rx8UrdJMpf/AKrC9jTAY4eAwSEzeL6X/OAs5TQ6mDN/CKP6+v/5UqwHcmUhoquSfomof
 hvr1bg/ucWc37Rchcn0OBymQkiadRNFQBXcSb2OfVz4HiGt2KVGy08rcYi3/yWvuSvQK
 8BcZlC2qzbnHfIqaaF3Nds9wMGMFC5UW+dqoqU8OJBOkNMj3F72neT/FRd01b37hfD9P
 FcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716463253; x=1717068053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TftuAjqYhvVjsSBNnC7HmXavSpZdwsBZyLQvBuHfT4=;
 b=RufJ5cVUtvvPKSG3lVmTONNBMdKNi6bP+FAehX72pflkeW5TEYaISOeZoz9F1A74DL
 QjmwY5BYINzW7pb9eHnH0L2YZfnnue9bWbUVx+VYpISYK/S1RnaaxUGixUkTnkHDnHsy
 BRe88EQrrZVzTiyJjJnbeGccy8gMUJk/GtPFYKQJ5mqlwonDGVOXimGgnQ2pbu3luKQi
 ryT/bpsdQES/10QHnWdB5w0DNkf18bKitM+D5ov7V49E/feIHn4mF+oLtkmhvlCJ9YH7
 1lW3v12oBcsLbV0ffAr6Di2k7eXt+qRoh7vOSA0awEVxXavhCsL+ic/4v/Ab+ClCtAU3
 Pkgg==
X-Gm-Message-State: AOJu0YxHpE8n51TR45W/Qhj6XKars/cwr2rp+hJykbBs6mQw+4FfLlpy
 ZHObBBfcm0lkZ4mLOsGJm6sQ40rLUrSHIf8ESoHA2UMOoZfLCAHfF7YeBzVDZINetayAMd/O8MO
 t/cCL7t+ib1j6J7CgFybGlmOEIVJkdM73LRrvEg==
X-Google-Smtp-Source: AGHT+IHS/lpmdZ8cbZhdYH0L/RRZP2Qa7Q1x7PZR2wXbO3w77i1GRzjXyPG6gIbvMCD3wpTLCHM/lj/rnlZoGnDm6t8=
X-Received: by 2002:a50:a69e:0:b0:572:a172:be71 with SMTP id
 4fb4d7f45d1cf-57843ec07cfmr1567426a12.14.1716463251787; Thu, 23 May 2024
 04:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-12-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 12:20:40 +0100
Message-ID: <CAFEAcA_DOmefxboeO7jDHBJ43MxCkfGGj-Te=1gyx83LTY05-g@mail.gmail.com>
Subject: Re: [PATCH 11/57] target/arm: Convert Advanced SIMD copy to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  13 +
>  target/arm/tcg/translate-a64.c | 426 +++++++++++----------------------
>  2 files changed, 152 insertions(+), 287 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

