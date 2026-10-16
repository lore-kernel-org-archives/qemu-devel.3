Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D95CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeFq-00005f-7e; Fri, 16 Oct 2026 05:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHeFm-00004w-JA
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:29:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHeFk-00050i-Ng
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:29:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e9995ce866so1514455ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142967; x=1792747767; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T8lP2QnyTKqKvsF5AqU2c4smyw5OlXHzVafdJExpjpc=;
 b=eSd2rGvEWZv6k58S+ekbEoJXj10t2U1y5n+Z+jF/bWnL7RvyOkGqOOA7NHKdRtDnj5
 43hr4kt7aBLX5t2uYFHVKjh6QvmtpNtu4pCg93VDVtGAInKAg5Jq9jxBTmfALygwOQPc
 2jdAuK1UcUCcQjORp+WM/oScEEFjNl3W/3A+JAfdnazGuVj6rntPNg681e9PqWaKBv8B
 tdnIRm7p++lqUxBRIqNzeSK4W86ZEjhIM/QiqehAinwwfXe+qv0nSU2WbdKVxs2tfvkn
 euYD4F77E//Mz1tTI8kMliBq+cG6g2F3Y67B5d3BnFa6qNBPvGY2boUIFVV4bOK+pegX
 KMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142967; x=1792747767;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T8lP2QnyTKqKvsF5AqU2c4smyw5OlXHzVafdJExpjpc=;
 b=NKX2D4PQXrXviaSCncntpC8GcQkeWcCV8WryLaK3amNGILSI+e0lHYUxdnZNu7LDJK
 AhgoEOPozW99835+vO29u3k7chD89d0Po+t2lL3/iFkf/kPT2Rtt8GhNERWStLPZZD4Q
 FfR14RafiiAPInjlx3TGGcLhmVK7T7ca9riB2K64YMS4u9YjvB23kvDAFwJsDT8KI71Q
 MadzUq7tRQXq6SQFST0VqvteapzbUtux9DEOemYcQD7Klt78fdvozJuB/oKwcBgv5Qlh
 cGip0x/AG4X2UV9BOsNK2qArWLyJOHUhXq7PBUkbShncMPOhb6/5QGzkTv3vSYAWkotS
 oJ/A==
X-Gm-Message-State: AFq9FYK18XP+nVwzwE7Bt4syYiGEpRJpe+C5zG6dyoHYlYF8iNRPVUZH
 I652KFyw8apSq+ycR14MIGu+aAy4XRthiDtLWwVULU9eUXyE8kQoT7vL
X-Gm-Gg: AYBFou1k9FguT1d0Ea8UGaaq+ykp3yCMIXR0WMCheRahdZq2fUvvtHyhmqGLqCHV42x
 ozvxQKAvG7uHqNuubl27ZWrxzV3b9DRXpi1jTX9Gr+OlP3NnHvg8HA7qeudwNJP5R6CY7uyQ5Pk
 OGgxL2TpPX3z4sUpL5tdMp+z1L+mvvupkmNbDYcOP8i8UMhOuZ5/bXccsjEUO7+RZ2rorNN+V5e
 xZsjSW1UXNqOv2zEGR+8C4Gj0rGnn+hs55iDmo1JUpswhuFDtKPuoVO0qxeO1RhGP27ae8i/9/r
 ze691I9ZN/LxR7d/mf7i1YRJ7OuhmtB0+MekYjv+kR4jxyILfTG5mAhPM6jEpv1Xj7QyQAOJeWI
 ev69LLXx49DS5agoIMZsopjlKNMT0d99B9gosc5W3X9wLfpnez6iXVcuO5zKaKFiXpsDQvUahdl
 mJL7roKTUaultLK1yb84s5WP5hRMGLQMsoE5hPPU/AbgAQnir/6AdW7EqnxcryDFk361Lq11R2X
 xcKQEHazFB6I2g=
X-Received: by 2002:a17:902:d50a:b0:2cc:6018:f030 with SMTP id
 d9443c01a7336-2e8429a6f7cmr198821215ad.14.1792142966700; 
 Fri, 16 Oct 2026 02:29:26 -0700 (PDT)
Received: from JaminLin-PC.aspeed.com ([118.99.183.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e8b1d82sm7218235ad.70.2026.10.16.02.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:29:25 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:29:21 +0800
From: Jamin Lin <jaminlin1207@gmail.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Patrick Leis <venture@google.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 50/50] tests/functional/arm: minerva: add BMC boot test
Message-ID: <atHucTPkBkcPoMRu@JaminLin-PC.aspeed.com>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
 <20261015-bmc-minerva-v3-50-7d50c8a108e5@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-bmc-minerva-v3-50-7d50c8a108e5@free.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jaminlin1207@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 15, 2026 at 11:28:37AM +0200, Emmanuel Blot via qemu development wrote:
> Add a functional test booting the Facebook Minerva BMC machine.
> 
> Note: The boot image currently lives on a personal fork; a TODO in the
> test notes it should be relocated under legoater/qemu-aspeed-boot before
> upstreaming.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  tests/functional/arm/meson.build            |  2 ++
>  tests/functional/arm/test_aspeed_minerva.py | 30 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
> index 61b00932db..dd1ddf7f6f 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -16,6 +16,7 @@ test_arm_timeouts = {
>    'aspeed_bletchley' : 480,
>    'aspeed_catalina' : 480,
>    'aspeed_gb200nvl_bmc' : 480,
> +  'aspeed_minerva' : 480,
>    'aspeed_rainier' : 480,
>    'bpim2u' : 500,
>    'collie' : 180,
> @@ -51,6 +52,7 @@ tests_arm_system_thorough = [
>    'aspeed_bletchley',
>    'aspeed_catalina',
>    'aspeed_gb200nvl_bmc',
> +  'aspeed_minerva',
>    'aspeed_rainier',
>    'bpim2u',
>    'canona1100',
> diff --git a/tests/functional/arm/test_aspeed_minerva.py b/tests/functional/arm/test_aspeed_minerva.py
> new file mode 100644
> index 0000000000..925a82b139
> --- /dev/null
> +++ b/tests/functional/arm/test_aspeed_minerva.py
> @@ -0,0 +1,30 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from aspeed import AspeedTest
> +
> +
> +class MinervaMachine(AspeedTest):
> +
> +    # TODO: the boot image currently lives on a personal fork; move it under
> +    # legoater/qemu-aspeed-boot before upstreaming.
> +    ASSET_MINERVA_FLASH = Asset(
> +        'https://github.com/eblot/qemu-aspeed-boot/raw/refs/heads/minerva-bmc/images/minerva-bmc/openbmc-20260720025047/'
> +            'obmc-phosphor-image-minerva-20260720025047.static.mtd.xz',
> +        'bd713df39d3c09846299a2377315465187a4dcd33c29d3b3d683ef13b59f36bb')
> +
> +    def test_arm_ast2600_minerva_openbmc(self):
> +        image_path = self.uncompress(self.ASSET_MINERVA_FLASH)
> +
> +        self.do_test_arm_aspeed_openbmc('minerva-bmc', image=image_path,
> +                                        uboot='2019.04', cpu_id='0xf00',
> +                                        soc='AST2600 rev A3')
> +
> +if __name__ == '__main__':
> +    AspeedTest.main()
> 
> -- 
> 2.53.0-Meta
> 
> 
LGTM
Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>

