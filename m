Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85783C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGZQ-00079f-32; Thu, 03 Jul 2025 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGZO-000790-A3
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:49:30 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGZM-0000OR-PK
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:49:30 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-712be7e034cso52263687b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751536167; x=1752140967; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt3Qn5FiaR9rYN4TTmSry1xkmc95CmHF121XGvGJ00k=;
 b=W582pcw1+JcXuAvixXDjW4CngR5KHwzkx24A3KWzP+3iOgS5I9CJz51xgNJKO06d0q
 bo2G6Kq9PL19mjWgEn0dEtsANN2ZzVwkMNbCx3XkFLS2PusKxUDtQGvGj5JIPIYdsG/8
 StSq7YHIvuXCgcw34w8r0aPYcmcm3NrUc37TUtO1yjBj5WggVycrnbVXv8u1a8C+f7Kt
 jU9W69o+8rXluP3l+E5aLhFIf+h5XNyU8F0KXyw7vLI89pkruuMseMPp1qZTweVaOeFT
 s5K/eiFdHZkeLnJUoMo+5RKT138sfZY3MklMTemuwaDBOduxfrll1FnYHMhqZBoCIBub
 MsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751536167; x=1752140967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dt3Qn5FiaR9rYN4TTmSry1xkmc95CmHF121XGvGJ00k=;
 b=rREvmQJkfBy7RH0oPUBt/nOg6hoSXL6y+WoJNNTH+zAV1aepSkzq8hOfv1esoL/U0q
 PavULLMWGcjBk2XojxNOxWZDfAO2FvAWUpn5rWnvrmJMjqNeBv5hP1EIf+FfefzSqdF5
 UfAFS9ce8/I5FNwUBbqL2TxgqN8XsDGbdpRNsPuZBJIn1DWQQjBJq+vZV9H2sFDS9Wu2
 LICZHDWXvvbexa3/mfozM/VGovrOEBSH9ptlXuHrLUiqZBGcEo9Gxtqtuwn9U4FhdnKk
 PvrjMvMrOa7geBDAQ3LWJXYzHlBrkhBBeHJW4FcbpRLRbKR2F2pzSrsyqKufJapdR9hC
 p10Q==
X-Gm-Message-State: AOJu0Yx97HrqYfdir+jbEox5y13dOjcyUlt/X9Bmfuq9B5W9FesZkWjs
 wjqMoC/X3zD4v8CcVQqM8O9yb3d3GK6fhNFfAU+up7+5KPlxqHqmU4lBf0u8vOiQUn6VRRt6XkX
 TCILvhT3d7+b1n8GkzidluqYvZxftP9mvbAjeZpAZ83Aw6IpymQ/V
X-Gm-Gg: ASbGncuUOHOb5sm0hCVH1jeSvVVCfSI22F9fopqn/1ThcjwO8x20uvqw9wZ8asG0Sye
 WzaAiXNeDgu7fGt4C2pY50UwJyo43+n0pxSubc7sL7/2VqpOfXwi7ZahFQ75fGdXL4vELbgsmmw
 w3Tn1xPEc0R2wAsl73e+ogTobAvDT61HMsN5kq/N4IJaCK
X-Google-Smtp-Source: AGHT+IEaunBdOAVG78u4Xz+CAI+/w2iUJw8RLbtkxSZ8vePyRuBCz3TNNbLYOIcLj3v6jedlhKkif31ILZ8xdWr6HIU=
X-Received: by 2002:a05:690c:dca:b0:711:7128:114f with SMTP id
 00721157ae682-71658ffd52cmr40373837b3.12.1751536167306; Thu, 03 Jul 2025
 02:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-33-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:49:15 +0100
X-Gm-Features: Ac12FXzG2NAu5XZbDdxeVgRZZofrBm5ozt8H8HPVqC21Hbz_-EKNCGLLlGoJeJA
Message-ID: <CAFEAcA8_hJvLDNhk=qZ8vbxH_+WjVHd6YXsQjhcfDKhonYTZDQ@mail.gmail.com>
Subject: Re: [PATCH v3 32/97] target/arm: Rename SVE SDOT and UDOT patterns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
> Emphasize the 4-way nature of these dot products.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

