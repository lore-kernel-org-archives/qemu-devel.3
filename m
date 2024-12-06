Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81586E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJbDX-0005lX-Oj; Fri, 06 Dec 2024 11:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJbDV-0005jm-1z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:30:09 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJbDT-0005xe-Gr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:30:08 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d0f6fa6f8bso3197757a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733502605; x=1734107405; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aH+FOYNIBbdbb/rC/ymbhx0K5JnxU65wu/7eZubR4ts=;
 b=Esj471A+anTkrSjMB0a2K/8PZ7IHHutPqIGIkERI+XoE9kXylcRdG2DXDKJVovUDbC
 TXT00yRyBq5aKLAFE/uNXO7zJDHJZaIjyT5/RhWcZD7Ib9zJ89zcIivbI9RC/fHWTYJX
 aA0nhT3o2iZPH1cdvKUsiK8Cw+1qZsfr7ViMCwoRN5cv2ehCgn65XnFKzuMaWRG3Ow53
 +B9aM/W1EbNe9sVNT2P8YpkwpCewKd3I2fO3xQx/2cymfadJh4zEBCHDe67MO/Hkksa6
 uGfEUR29ytnqnnVn7Zdl5Vc+jaXWUUoAirfK63L0+ooMHAe6utaswz8kRYttybow4fxz
 BIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733502605; x=1734107405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aH+FOYNIBbdbb/rC/ymbhx0K5JnxU65wu/7eZubR4ts=;
 b=J9clz3ryrkH8vgPnZ1WPc0UUWCUk83HEOfRLoappiLoJf2kV3USUrPv03RsrJRzIMe
 86etXc/GPiBgYl/iD/AtjtoqHsQl53Gh487B0X4VCCgoIz4fszqaM4zvKoUeuvCPQaKz
 etioZCmwrtJHfjDDfedWIhcvcy7h4kq1aGU0KOegAvDAMilTmwwMRaurZZnR6nI4Qz60
 gHXk9DYR4GugrvtLHCnSC5RGIsx1PXhxg0m2MrSgWHlhvQAfydLBCMTh2yjSfQ88BuMU
 WC+r3N3hm4wL4lOx677s+CgcumD+naLW2/zbRjK470UKhskTz3QVo5VY137LMKBymM7i
 vQDA==
X-Gm-Message-State: AOJu0YyhgtLroSxry78hd1G+QtoKXI/5lFpU99BeYas69gC/Rwfzh0Wv
 CITYTugwweJO7qR2JSaDQj3K/XpdTWUoBs23VeqF6z05Qh0hsGCPySpQACLOO4OcE3gPbMcZ8gY
 6XIbPxlOAm9TYBgtqekhbZjzhxtJjPK4rY0YEMw==
X-Gm-Gg: ASbGncu32VGfo6FXFymWzxB65bRdd7BLHlpS5FigWdxSz5NCwITPn9K1w09Q1UqCROo
 dVau8zyVn8k4j0rrOQFxqUUvLWDTYRycQ
X-Google-Smtp-Source: AGHT+IHdQh8oP2BdiKbL6ym9XgJW4kL/dWsvaU36dH/VF8fgqC+Hnrfh1z++A0+hZ2mNb3kGTHM5IRChWwxZMkbbT+A=
X-Received: by 2002:a05:6402:5215:b0:5d0:bdc1:75df with SMTP id
 4fb4d7f45d1cf-5d3be763965mr3216124a12.24.1733502605086; Fri, 06 Dec 2024
 08:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-64-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-64-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 16:29:54 +0000
Message-ID: <CAFEAcA8WydPKZ+mMut2uayGF-ueSGYLm1rrMZ77tOKCSX3d+cg@mail.gmail.com>
Subject: Re: [PATCH 63/67] target/arm: Convert handle_2misc_fcmp_zero to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 1 Dec 2024 at 15:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes FCMEQ, FCMGT, FCMGE, FCMLT, FCMLE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

