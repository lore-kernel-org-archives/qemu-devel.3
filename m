Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CF510F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXfF-0005DX-8i; Wed, 08 Apr 2026 14:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXf4-0005C4-Dx
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:30:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wASCj-0003H9-CA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:40:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so8676775e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775652018; x=1776256818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mq04osIwFUHaumN4ljl75ZTWgCB1GKiJFuM1W21+i1k=;
 b=SkWPCQuQlWV48ANHPsfyhTRgOW2StSzhaOHyzuEybRh8Mzx3SKgB1fvqnP00GmMA/5
 1Wmci8AisS5iflxmbuavrHIZBpBtEn9+GHVJXDH8kDYWeHFz0iygxiUiGBKyh5XxGqPR
 BwvIqLt7T2Bnhev1h5DDvMWCWQZkO4rGWWy4J32EuTZ3bHBDNt5oqy25Os4rSXjIG/5Z
 hnqp4m6GR1qIUwXheQSxh3jiYkRYMSbhBxebBEjdcwD6atyyhJiuaO0tEcVVw1szwl6X
 vVXwlQF457KyMl1TS/G8MZIjgoQ/P+3EqO6vaDIMdRFTJAKacawjxmsukaocZCG+0tjh
 2fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775652018; x=1776256818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mq04osIwFUHaumN4ljl75ZTWgCB1GKiJFuM1W21+i1k=;
 b=FgC4YwpLOv2JeVz2YclQ1FHHU+TobxjANCFrUaNEDLMiIJdVevNcGx9/IO+e1eK+7R
 hTicKs69Dm7qSoiUk1DYXEhTs/20wOetBK5JeX1V+ytubqx/yfrzxzrwhe1q0IVhJzpt
 Xn7kriMLuQDIyzcm8uBFWAx2CrcdcH4GH1n6XLkbffTFxbaxTG+HsUeCl7cX14FH+aHK
 ZBep3Z/5nLa7yPw9yM40zsVuCX6JiG5/RuFo2JpC0OEiNCo1YIyUeeH/V1ZpwpQIjPIH
 /kHWfafJDQMtPSFErpAMAma5wkciljwOWrAw/NFxJ9OoVdlZxecCpf12c6oFO5140beY
 54ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUVc2dl0Imt6Mce1V2DiVn9oh5rEoKIWENgA/1HXuHsyXkOVpk8fKABjJ/2wuqfTJZi7ttns2EhUtA@nongnu.org
X-Gm-Message-State: AOJu0Yy2KzljfmxEazdy1Zqp8vl9iJw8o+zniGhCvHKkFf8pzsWeG/Xt
 rU9VCYjZ5dlBvVt7SwWPRnytdPRKaKBplTyu3vVHCbLYt6PTxBv/5YCE2ESgTbWAeBQ=
X-Gm-Gg: AeBDieu/MyJJyOGB3x8fU8gyNTCqkbTukbkjwbr8pdxbpJ0L9+KeI7nltOr35qykm3E
 vxvePpPMdcX2Bzl4lFLz4zqvuQFds/AHbZCYG+p6FUm+TcN8nJYVd4tfNM6KBHEmiyyzDP6uEMB
 umOi2uCpBApHUle+rfNczHk/sT5U+piHNkcXUonDjZ0UbFfaYMTJQQKJ+MXNyd3/Id14QTNVsdU
 c/pgMPyWV0yHVgd9+1nDOSs1yggAQASoijcriA/mWG8s/DxCM6MALPGsVQwDq8yiUzjcIopVS3H
 gP1uuMyQKe/8idbbCmxHKjM0AAR23963F01HWkqRZRW7+GMbb/Pajp/XAk2hDJ/EaYr/WaTdsS5
 IKL76BzFraJvhMnuYxUlJO6R3w2qRjRoszCTYHFpNWGX7c3seyeGwWZKmm2MS37KAYYUj+ez2Jb
 N3954X83hm8lQ5IVuctwl79ftJthPX6k+HBX5YFxsNOgUfkIjifGYU75/p0L3cIRCRLw==
X-Received: by 2002:a05:600c:c0cf:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-4889945f8e8mr183609435e9.2.1775652018395; 
 Wed, 08 Apr 2026 05:40:18 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e83682fsm667738815e9.7.2026.04.08.05.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 05:40:17 -0700 (PDT)
Message-ID: <3c573599-a965-48e6-83f0-a76b1e7a04f2@linaro.org>
Date: Wed, 8 Apr 2026 14:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.0] util: fix missing aio_wait_kick sym in qemu
 guest agent only build
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "wubo . bob" <wubo.bob@bytedance.com>, Kevin Wolf <kwolf@redhat.com>,
 hongmianquan <hongmianquan@bytedance.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260407152207.363647-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407152207.363647-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/4/26 17:22, Daniel P. Berrangé wrote:
> Configure QEMU with
> 
>   --disable-system --disable-user --disable-tools --enable-guest-agent
> 
> and the build with fail with
> 
>    FAILED: [code=1] qga/qemu-ga
>    /usr/bin/ld: libqemuutil.a.p/qapi_qmp-dispatch.c.o: in function `do_qmp_dispatch_bh':
>    /var/home/berrange/src/virt/qemu/build/../qapi/qmp-dispatch.c:140:(.text+0x5c): undefined reference to `aio_wait_kick'
> 
> This aio_kick() usage was recently introduced in qmp-dispatch.c
> without updating the build logic.
> 
> Fixes commit fc1a2ec7da531223b3473185dc2584f8a7c6c659
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   util/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

