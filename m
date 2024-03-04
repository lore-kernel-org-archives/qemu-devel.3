Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08370C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh606-0006d5-AU; Mon, 04 Mar 2024 05:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh604-0006bA-Qb
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:56:52 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh601-0006j6-3Y
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:56:52 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-563b7b3e3ecso6533394a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709549807; x=1710154607; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CozLA37GlIctt8Lc0uD8VZtJjR6dCRQzabX5tRp250w=;
 b=R7l2YMKWsZnowSS1IKn3012aRvPWUdTFwQkTv9v1BCr95p2DX//4I/77kUDsvruD4o
 X4UU2u79BND5Vdf34wqYw/QBCgoIwr/3zKxf9uKhTyh7Nw9s2ZIdJ18o2t64k3Qv+6Xu
 S6fWj1qtAYbxUVT0os1bnh4Ch5KYs8tOqMZ/ujoNjvTp84gNbl8cxsa0dKVG8FohlJue
 HUZMVOfIlxLZ0t0i/4sKF+gGmhb2lW/ggOsnWcgAHxxwMSoWdFOFJUl8kkYi+eU+Jv00
 8NPaE4mrdGFxAxTJkXtxjN+tW8gj2ozLmHtfzdqVsFrLbI8AGp+gyf2YTrIu0Zc5ySoY
 SM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709549807; x=1710154607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CozLA37GlIctt8Lc0uD8VZtJjR6dCRQzabX5tRp250w=;
 b=AAz19tOBMmtgf2SR3ECJf8Z1kppDohHbqH0nrQ0MkFpNlt5BU/ltwnFhHXgIfbOe3S
 FAjXrFcXG3enGChtnGWnTatKxDxA7CWobIlk+NQwGxQSX1TGH/r0zDFojatkiuGljkyd
 H5/YYnHMDNn+hrSVZvjpIprhvufEU/YLWunnntA4/096CGe2Yz8Z488lLD4xO7SieiH9
 tkNG48ISx39jeCn/VMYFJQTP/s5ZXCEiFhW5Nmp3vRa8wbMEjM1Dg8kK9MeBbcJ5lXQB
 UY0kuJT55SodbhSlUMAfQOYyUpTPd3NZb9KQPYApEkL3DacGTV5ciz6xmJTweF/8OiMV
 80lQ==
X-Gm-Message-State: AOJu0Yy03QvIU7haYNggv6lkFhQiOTGdXdCxoJhiyGVd7d0baMfXDq/+
 G0zk9txzeUIsSLBG/Ac/aZZWPL6WjsNFONC7doOwAwrnjKj1OiMfCw650UTF2DTjj9BbM8SZ869
 Im3nu9mmDpajTe5/lpnzY+9dtBBpE5XoGkGqVFFsnEZcxErWz
X-Google-Smtp-Source: AGHT+IHpVyJeCxycEk/J8qArsC4UzOZ5NqqPM1zPt8r5ufrNn8dnzzOj6piiW6CjpIxmdZNEL83qHDqMqRv6fxHmVMc=
X-Received: by 2002:a50:cac7:0:b0:566:d274:a41d with SMTP id
 f7-20020a50cac7000000b00566d274a41dmr5025280edi.42.1709549807273; Mon, 04 Mar
 2024 02:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20240304093618.24131-1-thuth@redhat.com>
In-Reply-To: <20240304093618.24131-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 10:56:36 +0000
Message-ID: <CAFEAcA83XhUSTDL9QL40ek4vDt-PMxRM10XeTXMPPZLwiibFxA@mail.gmail.com>
Subject: Re: [PATCH] docs/conf.py: Remove usage of distutils
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 4 Mar 2024 at 09:36, Thomas Huth <thuth@redhat.com> wrote:
>
> The macOS jobs in our CI recently started failing, complaining that
> the distutils module is not available anymore. And indeed, according to
> https://peps.python.org/pep-0632/ it's been deprecated since a while
> and now likely got removed in recent Python versions.
>
> Fortunately, we only use it for a version check via LooseVersion here
> which we don't really need anymore: All distros ship newer versions of
> Sphinx now (see https://repology.org/project/python:sphinx/versions -
> the oldest one is 0.6.6 on CentOS 6!), so we can simply drop the version
> check now.

This code isn't checking the Sphinx version (we do that via the
setting of needs_sphinx, current minimum 1.6), but the
sphinx-rtd-theme version, which is independent of Sphinx's
version numbering scheme.

I get timeouts trying to connect to repology.org, so can't check:
do distros all ship new enough versions of sphinx-rtd-theme yet?

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/conf.py | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/docs/conf.py b/docs/conf.py
> index e84a95e71c..1b2afa241c 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -29,7 +29,6 @@
>  import os
>  import sys
>  import sphinx
> -from distutils.version import LooseVersion
>  from sphinx.errors import ConfigError
>
>  # The per-manual conf.py will set qemu_docdir for a single-manual build;
> @@ -165,11 +164,10 @@
>  # Theme options are theme-specific and customize the look and feel of a theme
>  # further.  For a list of options available for each theme, see the
>  # documentation.
> -if LooseVersion(sphinx_rtd_theme.__version__) >= LooseVersion("0.4.3"):
> -    html_theme_options = {
> -        "style_nav_header_background": "#802400",
> -        "navigation_with_keys": True,
> -    }
> +html_theme_options = {
> +    "style_nav_header_background": "#802400",
> +    "navigation_with_keys": True,
> +}
>
>  html_logo = os.path.join(qemu_docdir, "../ui/icons/qemu_128x128.png")

thanks
-- PMM

