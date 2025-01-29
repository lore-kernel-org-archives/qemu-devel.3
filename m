Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377C3C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 09:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3xt-0008Rr-Iw; Wed, 29 Jan 2025 04:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td3xn-0008Qw-H6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 04:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td3xl-0000tH-RF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 04:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738141340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I7e+um+ya3M7kZNyHa73rArelg2A7q9Wm0o6GUWosSU=;
 b=dNmTO6vwBQeQFOw61EjmHhqKY5mArGQIICLqSjXD1xGWyHzlNn37eFHQ7rcfIlDAo9GBwV
 dVCYWZM/z+z34KF1Yd8I+AaO1J1eVU7t7OjvVcmAkZZxdE2X5a7jooxPHgufioGC+nAhQ1
 XToiefRKx5OgrMKU+XThlsWCdVH1s9o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-oi-PUDexN4eO-qjJIw1fTQ-1; Wed, 29 Jan 2025 04:02:19 -0500
X-MC-Unique: oi-PUDexN4eO-qjJIw1fTQ-1
X-Mimecast-MFC-AGG-ID: oi-PUDexN4eO-qjJIw1fTQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43646b453bcso33278955e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 01:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738141338; x=1738746138;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I7e+um+ya3M7kZNyHa73rArelg2A7q9Wm0o6GUWosSU=;
 b=R/xVcd4ADGPnpibWDSYUJYzZrma8QWdwsJ9NJBLmtwbkYrn0gcbgrei8X7shmmI7wl
 AOhPyOY79BbKSB654Cy3kxwTfj+l/CTnYM+W9ITUUxpvMT7AtBrrPD/7dNhpuwPTlv13
 VGQS9cSlie118h0bRXeqWoyZdTEMvXg9NW6o1SF5cIq8AoQXHder0rQxHfAcvOh337xC
 vP38n3qw8LQhbCHPE8gFjwtgW3B7YuiONDiJZRTN/z+DleV6uKTM2YH9hT5M2DhJSQG3
 eQm2CskOHiqxr0ewiznNCh2vCSXjRp2HfQuW/mAWDFyIJ5EfKxFF6KrF3HPog+ifqkjk
 lz1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZZ15gkmohGHQsVTLi7BYeX4/rNQN9LBCWU7LD+MSY7DZJ7aeyZNBrjBGH3axQvuuZZp9VYQ25SHII@nongnu.org
X-Gm-Message-State: AOJu0YzublyfsuYZpzYxQDPoDkqo/q49QdXhU1QtCYCLl+vBBSXVEbRy
 RaDspFLsdin+F+g2uVRlVgS4DYB/gAB8S69SXPDKZupulkogcydXXQ9unLesfQwD7fPI1ztVVPq
 /MFceYR8gBm34AXvhf19DUSG9jbuCV3F/XVP9thcIZjyzLH4Iv4jX
X-Gm-Gg: ASbGncsiKT5uEPOWkaWYUuN4fbbH95wxp4gsE/Ye2oVxacUt2Knzs0qw2x5eBCiVXXD
 /oSMsDMm3uUmYoaMFa9gu+yOSDKYxnjBbMl8tKOVFC5Y4uHdtehOdeHiygpIivU0KlGXDtZBcBW
 yPHCBZEYFtVsg77ug54EEyQOscyg6QLbKu7i4TUIlnLzlUNgNubbJFm3QkbKSebHoD15cI0ZgVk
 FepeSdHl6exuVn++MjCiDzd6cQH4uyX2/P/5gPt0u2nCNNT1oOYVNVvS/Aq3oMTt+SHYjsH3YzQ
 gV7wTfee6pvsT0zAWjPYecXBSgktBww2UeEh
X-Received: by 2002:a05:600c:138b:b0:436:faeb:2a1b with SMTP id
 5b1f17b1804b1-438dc3c7b6dmr17394205e9.13.1738141337828; 
 Wed, 29 Jan 2025 01:02:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXhXetKKBpiU2YRXA3RPdUyRLKn32REs+mo1HZJ7rsLO309cbACAVaoXpdnKbmAZ5LLu+1gA==
X-Received: by 2002:a05:600c:138b:b0:436:faeb:2a1b with SMTP id
 5b1f17b1804b1-438dc3c7b6dmr17393885e9.13.1738141337451; 
 Wed, 29 Jan 2025 01:02:17 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc24e73sm15012695e9.16.2025.01.29.01.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 01:02:17 -0800 (PST)
Message-ID: <e83c270e-e0e4-4af9-8896-600c15d31d28@redhat.com>
Date: Wed, 29 Jan 2025 10:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/functional: Introduce a witherspoon machine test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250129071820.1258133-1-clg@redhat.com>
 <20250129071820.1258133-5-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250129071820.1258133-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/01/2025 08.18, Cédric Le Goater wrote:
> Use do_test_arm_aspeed_openbmc() routine to run the latest OpenBMC
> firmware build of the witherspoon BMC.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/meson.build                  |  2 ++
>   .../functional/test_arm_aspeed_witherspoon.py | 24 +++++++++++++++++++
>   2 files changed, 26 insertions(+)
>   create mode 100755 tests/functional/test_arm_aspeed_witherspoon.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index b7719ab85f90..5c782ceb0a98 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -22,6 +22,7 @@ test_timeouts = {
>     'acpi_bits' : 420,
>     'arm_aspeed_palmetto' : 120,
>     'arm_aspeed_romulus' : 120,
> +  'arm_aspeed_witherspoon' : 120,
>     'arm_aspeed_ast2500' : 480,
>     'arm_aspeed_ast2600' : 720,
>     'arm_aspeed_rainier' : 240,
> @@ -82,6 +83,7 @@ tests_arm_system_thorough = [
>     'arm_aspeed_ast1030',
>     'arm_aspeed_palmetto',
>     'arm_aspeed_romulus',
> +  'arm_aspeed_witherspoon',
>     'arm_aspeed_ast2500',
>     'arm_aspeed_ast2600',
>     'arm_aspeed_rainier',
> diff --git a/tests/functional/test_arm_aspeed_witherspoon.py b/tests/functional/test_arm_aspeed_witherspoon.py
> new file mode 100755
> index 000000000000..12714323733a
> --- /dev/null
> +++ b/tests/functional/test_arm_aspeed_witherspoon.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from aspeed import AspeedTest
> +
> +class WitherspoonMachine(AspeedTest):
> +
> +    ASSET_WITHERSPOON_FLASH = Asset(
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/witherspoon-bmc/openbmc-20240618035022/obmc-phosphor-image-witherspoon-20240618035022.ubi.mtd',
> +        '937d9ed449ea6c6cbed983519088a42d0cafe276bcfe4fce07772ca6673f9213');
> +
> +    def test_arm_ast2500_witherspoon_openbmc(self):
> +        image_path = self.ASSET_WITHERSPOON_FLASH.fetch()
> +
> +        self.do_test_arm_aspeed_openbmc('witherspoon-bmc', image=image_path,
> +                                        uboot='2016.07', cpu_id='0x0',
> +                                        soc='AST2500 rev A1');
> +
> +if __name__ == '__main__':
> +    AspeedTest.main()

Reviewed-by: Thomas Huth <thuth@redhat.com>


