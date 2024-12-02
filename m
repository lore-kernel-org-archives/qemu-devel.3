Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530CCD78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7Tf-0002XK-6j; Mon, 02 Dec 2024 09:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7TE-00026y-74
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:32:16 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7T9-0003q5-9n
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:32:13 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cfddb70965so5604613a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733149926; x=1733754726; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DJXfFbP9yKwUSasMny5GASk9Xvb86L3rQnSXjqCmMkE=;
 b=lwnbwlB+5rcqisxiCpsKngFDMJjb9sSVEYYoYdhjTvnw9wPECPqXiS+5pk0j9iSSB0
 0WNr87yN10XVikdp99QK8ZPQNrafUlOmr5OX/+MRPvQ3F8lO4ytL7L8UlK+pDRO9RbsI
 aKqhOiwxD/6JleoD9WJ49OpJaG16o594xRSv+3hG+ZFbZa7fZy+htEr9t0pb2jqjoHhT
 acinEwZvZsMD0nr9BED6mWp/rNhbdDFzpB4T8JYcBBm5QKVw4REVQ2lw83Zv63SR18rg
 LZrjvCqwid7Q0+GtK3aZlKOvrKqNKkL8WVEk90eskjvqFRzYiimDNax1ETqUChhGJtru
 j9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733149926; x=1733754726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DJXfFbP9yKwUSasMny5GASk9Xvb86L3rQnSXjqCmMkE=;
 b=lYkkhP8treHaIJ/rl9diIBmqd1dwRVX6TKhww4QdJRbUBDdEk1esdnyXpbHn0BYJNr
 luznmbIeCRZX+oPtEGMAQtWpSI3QkyW2OlHEtVhE7fUU+7Zi1gTcLpkDs6LldvNGbC20
 h9vYpewneQgy1I0qTiM8e5xokneVHMWuuy5hj+1jy9ejnpK+8NGyozGrqUZhWgrC0tQP
 ycZs77v+zrILmvSjItfck3nqsMvDY3UdkR+oRQjLpmLYKJvY5Pr0F3vxA11kzBHqkpdl
 wFetTR7tuUEFZj7zxiJbp6LkwbQYlG3jg8ro5HlLPsCNHCWW0gR1W8l4Gd1DIdERM8WM
 Em6g==
X-Gm-Message-State: AOJu0Yy/yvTNOhFQTrrOFQ8yH3jNBqa9JEeCznkYvbV1G67oLJp1DX9u
 R6X/vxwrkS5ubawu9388BfmHYB2opifzukp73G2gQnj2gL6sXxn9RMastm7N8vlO2CA7j3tPHFG
 r9TTKfzdDuCAgThGP9ZAMHypnuYNrO+WkFkQ6oQ==
X-Gm-Gg: ASbGncsSGiS3p0+bjB2oisf4c6Wpph4Cfy/lDuKZsy/DGsKf7OSoGuxIFUo5DJkSVFn
 KYu6KLxiAtOJ9dJa17C9GprO7SLBhs8tD
X-Google-Smtp-Source: AGHT+IH9JIPrbsOe5nGPszR6otmQZaWY4rUBgI0zKuy9wc0Dwty7kUFqZAfINqsYeC6rXtFp7C5mM+bWPzGbMRz/9pY=
X-Received: by 2002:a05:6402:4015:b0:5d0:9081:7929 with SMTP id
 4fb4d7f45d1cf-5d09081793dmr22024320a12.23.1733149926145; Mon, 02 Dec 2024
 06:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20241102125724.532843-1-shentey@gmail.com>
 <20241102125724.532843-4-shentey@gmail.com>
In-Reply-To: <20241102125724.532843-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 14:31:55 +0000
Message-ID: <CAFEAcA-mLhGeLmtnGjpgVFoMdSwZPRpOMsMtFuEoPkDD1H_q5g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] hw/net/lan9118_phy: Fix off-by-one error in
 MII_ANLPAR register
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 2 Nov 2024 at 12:57, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Turns 0x70 into 0xe0 (== 0x70 << 1) which adds the missing MII_ANLPAR_TX and
> fixes the MSB of selector field to be zero, as specified in the datasheet.
>
> Fixes: 2a424990170b "LAN9118 emulation"
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/net/lan9118_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
> index d2dcd732ac..d8fc9ddd3a 100644
> --- a/hw/net/lan9118_phy.c
> +++ b/hw/net/lan9118_phy.c
> @@ -54,7 +54,7 @@ uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
>          val = s->advertise;
>          break;
>      case 5: /* Auto-neg Link Partner Ability */
> -        val = 0x0f71;
> +        val = 0x0fe1;
>          break;
>      case 6: /* Auto-neg Expansion */
>          val = 1;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

