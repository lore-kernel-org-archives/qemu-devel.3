Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F11EDEBE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbFR-0004ag-C8; Tue, 03 Mar 2026 20:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vxbFP-0004aI-RV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:41:59 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vxbFM-0000gJ-VR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:41:59 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-56adf76631cso379717e0c.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 17:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772588515; x=1773193315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o3JvKW/+GHuHCKVZcMTsEX8KByjilP9LITsEXZJLkFM=;
 b=TgexFXRsjXr98EragZvuAM0wtghgnB/BFjNuxNLRNSqiaLukAuS5z7fBQHC4n+2dot
 7/2SaPjjWunqJf4F7SkIC7GuJ1cYNgMUmVyipQuMEQtCOc939nm3+uPy9pM2gkjkJIL/
 izgFIq/njUZ7UBT2IjNU7BjKhTHWVgwSWIfEbOOAQfTM8CpujbVfOOSzQN7sT1jjinGi
 r5iYsKdC4tiKX9vlIEaIvZ4H1faQTYt0YPZYf7c5rmmsWogR+/ObzO1dxWeVN03oTv/h
 5qRMUsxXvyDdLuqISdnP2pdBuM7J6OPAYuoo62rO2mD6DLy1VRH8GMy+RS2IHt6eKoNS
 GRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772588515; x=1773193315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3JvKW/+GHuHCKVZcMTsEX8KByjilP9LITsEXZJLkFM=;
 b=Tn4KGh/pPDgNFKfLQvT5nMfYll572vVCj/KrVv9ouWz4oXfVQyi/lRVB4TeWwY+BTB
 AmS7OwV57cUi5nCJ/JbLYMoqWGbk/vtoGoXmdIdgtkpliHZDf/5ZndxPKwvFP4ziZ96T
 OAwaOZ1bH+dEU5P1UDtNkELrOOF41lksABzJpONOujjjZhNrbhjXYmo+fAFOepqYK+A4
 zVISSjZ1TL4cM3yxZtu47/jgM95sTnJt9+2QEXLVMIQCt4JpHnoUVIigx5XHYrUBDN76
 Ku72ccNfsu6etbKZDRpQNktKOqBkgU3QPDKdTVvSGouHbbAlla0D3/AzIxuW0vk9Dhnj
 vQqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTUvdM6REYG4hLXw6bC1u2EP36AcWEvDORdHZObZ9bSfyjcu8s4DNlJIpk4MM6vGV3BuowNZTn9kiQ@nongnu.org
X-Gm-Message-State: AOJu0YxZZ2Y6K3bRNDvYqRHi9nSRGHb1gKUwYK0OGF2rSLogjLf+o63H
 OrzNeECxU9KdLPwA7tr9E/MswyAlsH2OwuDBprcLjl+uFh1uCIX/rdGEULqvwiSr85E=
X-Gm-Gg: ATEYQzyG+vBFdNnl71xPbV3pPFh95hPJqyDCDfv6E/f4kYo9Pi0GWgatgkNM+FM+BGv
 XW4/dnmjJ6b19WLa49A5c7mz+vRbxUdbhLYF73zZOYcl3M6USKrrL+gvkw2Ya4/x7abSxiXenFs
 FQrb0OHBT8bVF/G6yyBtvSUXURaQJaQXqcFL6e3FBvyLzoPyU+mtojJ1EZgHIqF5cGwFX+hHsco
 G4vaqAlYkFOw6amqqAO8UhgdlRJesh6zuiXT0DZzW+PGq2kvj7nZZ7gZj+19dnTNZfWPXKEYDLW
 1dcTwYxn7b9h9A/ZT0FqhcRTu9d4JnNTTCiZwFhK+kCpatOBjhOwLg22wCnJhdNDS331gjmBsmE
 6QJJPA4J6PyRplh5FSt9kjae2KTsnWvMSKlTx2Mn4dQ9EkGFETTrNAvROgRSLVPlMQA7Z7wHzO+
 TQpQKUeT8P39FQFZHuZgZUPTGE4VzP0BQf
X-Received: by 2002:a05:6122:1b8f:b0:559:6723:628c with SMTP id
 71dfb90a1353d-56ae77e425dmr222658e0c.16.1772588515166; 
 Tue, 03 Mar 2026 17:41:55 -0800 (PST)
Received: from [192.168.0.103] ([191.8.216.93])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56a91b8c7ddsm21413469e0c.3.2026.03.03.17.41.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 17:41:54 -0800 (PST)
Message-ID: <f49624c0-e2be-443d-a211-752a35e545f7@linaro.org>
Date: Tue, 3 Mar 2026 22:41:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace @tuxfamily.org address
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260303203044.8403-1-huth@tuxfamily.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260303203044.8403-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2e.google.com
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

Hi Thomas,

On 3/3/26 17:30, Thomas Huth wrote:
> Tuxfamily.org has had many outages in the recent years and will likely
> go away in the near future:
> 
>   https://forum.tuxfamily.org/post/3381/#p3381
> 
> Thus replace my @tuxfamily.org address with another one that is more
> reliable and hopefully will survive longer.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   MAINTAINERS | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6698e5ff69..b75f1e592f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1367,13 +1367,13 @@ F: gdb-xml/loongarch*.xml
>   M68K Machines
>   -------------
>   an5206
> -M: Thomas Huth <huth@tuxfamily.org>
> +M: Thomas Huth <th.huth+qemu@posteo.eu>
>   S: Odd Fixes
>   F: hw/m68k/an5206.c
>   F: hw/m68k/mcf5206.c
>   
>   mcf5208
> -M: Thomas Huth <huth@tuxfamily.org>
> +M: Thomas Huth <th.huth+qemu@posteo.eu>
>   S: Odd Fixes
>   F: hw/m68k/mcf5208.c
>   F: hw/m68k/mcf_intc.c
> @@ -1383,7 +1383,7 @@ F: include/hw/m68k/mcf*.h
>   F: tests/functional/m68k/test_mcf5208evb.py
>   
>   NeXTcube
> -M: Thomas Huth <huth@tuxfamily.org>
> +M: Thomas Huth <th.huth+qemu@posteo.eu>
>   S: Odd Fixes
>   F: hw/m68k/next-*.c
>   F: hw/display/next-fb.c
> @@ -3098,7 +3098,7 @@ F: audio/paaudio.c
>   
>   SDL Audio backend
>   M: Gerd Hoffmann <kraxel@redhat.com>
> -R: Thomas Huth <huth@tuxfamily.org>
> +R: Thomas Huth <th.huth+qemu@posteo.eu>
>   S: Odd Fixes
>   F: audio/sdlaudio.c
>   

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

