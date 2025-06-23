Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E60C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTiSP-0007yi-DJ; Mon, 23 Jun 2025 10:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiSL-0007yL-C2
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:47:33 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiSJ-0006B7-Sg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:47:33 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70e78e04e48so32674747b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750690047; x=1751294847; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TdnORn1g8xxV/rO1zitVTw4Odv6o6xFdVqP7q87wL5A=;
 b=UF4uaSb8Liu1Mda237XXdqbqBItw/ZRgUDelDBxrNdXFfEIoV1Vtp0UPKfREp4MeRM
 kvt9HfD6Np9UxL8IX2FIpiNrA2+e18xyh1OU4DzNLn5MMevaZGYPxsURWzzfOsE02gf9
 3FWtjOSUThsnk2uP7Q4P7A92KwKq2tbEX5NExzNLLeApLRJfgLtyFoBGZFXa4YYLg+H2
 tNhTWfaOYSpTDxx6wY3PoBFh6VwdhxTf8wXOn/Btu7QskFFqcRAsu0uZoGGktOb04uZV
 8lEDcGZxgbyOqx1xtCzuVVpqkEaq3WQ6TvysFo9cFrZCrtrly3HviDqMIUQvNEdw+AEi
 uwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750690047; x=1751294847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdnORn1g8xxV/rO1zitVTw4Odv6o6xFdVqP7q87wL5A=;
 b=rap8YoYTUoMiHaowYEGaBAme28IPKRwynJmyZxsLttLR2pnm1adnnFSoWy/yLhE761
 braDmZcN08064PQ5Cxglm0AehUXfgMD6BnlyR7I7Pd5aMQtfaYJ53IAmoEW5lNWiq03r
 F0YwwhRAlxva4Em9oi9m9rsiwXdVNA/AeBc5pcWlFfisW7Kw4FJq+2aC4MxFpiUIn7i6
 +61wC8MmsqQZghayI0rzQanZmFGmP6IzTpq6du1yEf4BDsQ6hD2OF49Ml/PGiWROVbu+
 XsMQMRwqVR51L/vIViHupuiTBg4svjHVdIfAIwm1Npca7J8+Y3GbNpwLut5JmosRI7Pu
 Vheg==
X-Gm-Message-State: AOJu0YzNBjXquQdRH+8jpaVFU1zNbSky5pHruTaD5Q2CJSdsHIBJdpFz
 n/UvpCyq1VmrIbSqJQKRZHKPGJ0GyBTSlVb1rAzjr5WNvJRpzNy90IdrGA90hlYgJewohqsYU4Y
 Tvi9TGw6DqPZocZCl0q8HgGy99/O44iXpX0l3vta+5A==
X-Gm-Gg: ASbGncsTT4bPkyTnNzb/jJxA7FQnG8DB3sOe6nSu38CvdlkgkVgU0X2kUWmc7J7808x
 8FOwcDIjeVpMyquJfscvIz3IAGfAs/7dAqHdyBbvUZspnsrdr78R072QtKuS+OehvFnu0eueEcY
 t/Q9o82CTQGak4G76+lJFwrJ6Yon6EzsDjQKIbsdrT54+u
X-Google-Smtp-Source: AGHT+IEy2Nf1HXnnfWpoIcXt/gyvN4mlaza5h+V9KN8jR3qm+tLHyihmE+xt0GnFF1YHCrK9EiLmW0OkEDE8N5KsM7A=
X-Received: by 2002:a05:690c:6c12:b0:70e:404:85e5 with SMTP id
 00721157ae682-712c63beecbmr210297477b3.11.1750690047424; Mon, 23 Jun 2025
 07:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-27-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 15:47:16 +0100
X-Gm-Features: AX0GCFvABinr7eAC-hrwfjVVgxW0n5okn4IbcjMRtTob5tZ9GxWN6HQkUWOIfdw
Message-ID: <CAFEAcA_zH43_H=bsLpJJh1G3=Vi9XHKdgVv7PoTdHMqCo0hG3w@mail.gmail.com>
Subject: Re: [PATCH v2 026/101] target/arm: Implement SME2 BMOPA
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

