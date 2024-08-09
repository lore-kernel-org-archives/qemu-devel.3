Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587D8C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLC5-0001rQ-EM; Fri, 09 Aug 2024 04:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLC3-0001qw-Qo
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:41:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLC2-00026h-9A
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:41:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428e3129851so12933545e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723192908; x=1723797708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xaeyry21owWivIkETo/KT6QZqxHNh5ZMCQdjOw/+FVA=;
 b=KfsK+184Rfs0qOmgVzgeE5BFOY96zix8u/QeWZ9HVnxIgeDMNmG/JMehbRPzk57bJP
 4R41qsx/VzJt+kqFgPciUTPW3+S6wcNUcUnCHtl+DjdB+ARmiYHr6WWIwzL+bYzkFHqJ
 jVve6e6Egtjif07y4fJAx5DHswBpuNjva6GYVMzvmWsQgoh1rKfauPxN11zmCzbz79AD
 GvzrjN1X/crGyf/WIu+YJo17KHyZzYkha6D1Tww41YvnpWMuZIbcLf9Z+waza23owvlT
 RB2UVSsq45RnLssgRxNhtNG2bLvBv5NrbBrB31oy6QPNXyMm2CoCBHt+uXZrfNLWjmUm
 NJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723192908; x=1723797708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xaeyry21owWivIkETo/KT6QZqxHNh5ZMCQdjOw/+FVA=;
 b=IcIS9glassSP06WXQhM89XcfGF4xj+tWZtJOQinupxxnWBJ6Vi08OFijx1QRHThV3o
 FR8oA8J/vs/TaSnJm7yfDkAQ9oqbJge6SBMgvIgl9vMMq+iilNPUYiQMWh5HqgyHYBMH
 iCnGJvA+QeGFlG/r+BVojmacv/MOD/Zv9xvEsf0M08fp9Ip86BGk9pwxcfSuJlA8VRJ1
 1a9r9eoOMRZoREyI9KQsdlHp3RxuOSDK/Ns0vvsF6w6vaIvVI5ubS0twaMA/lgLFIZQh
 pQ2IATuWC3f7mBphXKqCTWLD8vunpwkdLFQCTVtqZq0QV2z4NIXa3KQGkLn37YPWMFI4
 cZmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1HQpqb9VmNxRNVQnVWhfUdDF89jCDKVTnmVXC0EYYmXr8KvEgJWH4m6l9XUW0JVz7Bn9P1yL2wQJhGFuu5JfJhgTaUGU=
X-Gm-Message-State: AOJu0YyXjjOp03f9ZAM8i3FS+kzJybCsCWjrUODW5k3D6ERYMf2yPslP
 94eq07m4d3xXao0QA6Qd6nOStD4d+IAu1HywnzXGWd9MPA31pboexS/Ws7jsIck=
X-Google-Smtp-Source: AGHT+IGIFs7PTEVfdVhTDeqQvtsLx4pYJxPq0Zy22Gj80RCccCXD87qlTOIqSuAXhtJRD1JUsvwXyQ==
X-Received: by 2002:a05:600c:4e92:b0:428:17b6:bcf1 with SMTP id
 5b1f17b1804b1-429c3a291f9mr6312175e9.22.1723192908419; 
 Fri, 09 Aug 2024 01:41:48 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c779d1csm63885655e9.34.2024.08.09.01.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 01:41:47 -0700 (PDT)
Message-ID: <e33c4bde-ac13-422b-883f-514d2f41b483@linaro.org>
Date: Fri, 9 Aug 2024 10:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] qapi/rocker: Supply missing member documentation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 jiri@resnulli.us, jsnow@redhat.com
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-7-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240808182636.3657537-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 8/8/24 20:26, Markus Armbruster wrote:
> Since we neglect to document the argument of query-rocker and
> query-rocker-ports, their description in the QEMU QMP Reference manual
> is "Not documented".  Fix that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/pragma.json | 4 +---
>   qapi/rocker.json | 4 ++++
>   2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


