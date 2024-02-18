Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4A9C48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 07:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbbe8-0006r8-C7; Sun, 18 Feb 2024 02:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbbe5-0006qc-0V
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:31:29 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbbe3-0004Tw-4t
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:31:28 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e34d12404eso551157b3a.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 23:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708241485; x=1708846285;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wfVRGB4vumaE42vCocyoaiugbi0K1eWChgxM91EueI=;
 b=KYIZ8C8T4nVez00bUoSgUxlKAGgtIoJx67eoGvsUhTrY9v7mTMNnB7mgqdwi8rXvM9
 mkisWCj4pgiJlLErJHDW2vZscHBIBNdzOlG2KZSeXwoKbUm71QlSOxOKa3kIhZb2kUum
 OYvArRharwBHjzD4GoH3L98sAmPdKPDs6iZ5e7V5SlMbdO1BfQ1om77AScq5mWwtxDCE
 SAQ6Mn/oq9WVkC1zv9/JJUdp6b9tdXPYidvIjTVzNCE06m6MCZlQ54zlZ1d3x5xUEHUf
 4Y2KusrzI78gWCBd7o6osGE5C+IyS2lWuR20fL7cYPwaTmOTx13me+GZ2iI9hbKfBJ0H
 eDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708241485; x=1708846285;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wfVRGB4vumaE42vCocyoaiugbi0K1eWChgxM91EueI=;
 b=h8RDQEQ0Y4d9z+C2f/eBRCCjC8u93E9eY8xIhlDwZfb2ty3h3nd+N6oleSbdHXkCJu
 t65lSE0D+W6xSGalNStWhxUTNipmvNcuGSuElcP0cPrMhhVsCLsQ28HBH6jXG7ULrQk0
 SWaki8AbgTUcF7kqhRSQbMmfukP9r+7nxIDXh4xnjN0MVjRJRA5IqPd3qNQXFcgfmUb4
 gmbkuzvOskz3M8uTvFhRqkBKUJKYNPPQbm9qRK2kz1OMjzhSqIQSv0fk8P76ZmpaCnT8
 SoytnnZ6cXvC9QJ4JyCy1RKNfQk0e1Qr4SOtbfy+P3Vm/6XiUtyYN3U2kzVfTsndEEoN
 uXKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpbGouALemyz7Ws0Y088jG/aYViY79KI+C6GvUJgAjO5/Kcztum2CCTa4GBJm9JnZZyARio7qv7i30WsennJfwb6OlrRM=
X-Gm-Message-State: AOJu0YwrTEUIKeitC2yQ9tKFbjGj21YYwp5OCFPal0UEDfbiZ9VgdDVc
 L7FcF94ee+NhFhbdw0yuYbOVuwujHNyoSdX9hRTDYEjtb3yG6CcFebj+ZoaMul0otxxz6LwQtw6
 z
X-Google-Smtp-Source: AGHT+IGBdUX5S9AE10YeywOYHQc8vvQxkn5cUJw5DVDNgm239ajpKJDFMgu+ziCQ7/tEJQXEtvA9hg==
X-Received: by 2002:a05:6a00:b52:b0:6e0:e1c3:85f5 with SMTP id
 p18-20020a056a000b5200b006e0e1c385f5mr12394042pfo.22.1708241485553; 
 Sat, 17 Feb 2024 23:31:25 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa79f5a000000b006e410699a5fsm788564pfr.191.2024.02.17.23.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 23:31:25 -0800 (PST)
Message-ID: <022c1345-d2a8-41ab-b907-c3332a4fa0e4@daynix.com>
Date: Sun, 18 Feb 2024 16:31:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tap-win32: Remove unnecessary stubs
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org
References: <20240212-tap-v2-1-94e2ee18b925@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240212-tap-v2-1-94e2ee18b925@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Jason,

I have this and a few other network-related patches not reviewed. Can 
you review them?
I have the following patches ready for review:

https://patchew.org/QEMU/20230921094851.36295-1-akihiko.odaki@daynix.com/
("[PATCH v2] Revert "tap: setting error appropriately when calling 
net_init_tap_one()"")

https://patchew.org/QEMU/20231219-glib-v1-0-1b040d286b91@daynix.com
("[PATCH 0/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()")

https://patchew.org/QEMU/20240212-tap-v2-1-94e2ee18b925@daynix.com
(this patch)

Regards,
Akihiko Odaki

On 2024/02/12 23:04, Akihiko Odaki wrote:
> Some of them are only necessary for POSIX systems. The others are
> assigned to function pointers in NetClientInfo that can actually be
> NULL.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Rebased.
> - Link to v1: https://lore.kernel.org/r/20231006051127.5429-1-akihiko.odaki@daynix.com
> ---
>   net/tap-win32.c | 54 ------------------------------------------------------
>   1 file changed, 54 deletions(-)
> 
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 7b8b4be02cff..7edbd7163370 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -707,70 +707,16 @@ static void tap_win32_send(void *opaque)
>       }
>   }
>   
> -static bool tap_has_ufo(NetClientState *nc)
> -{
> -    return false;
> -}
> -
> -static bool tap_has_vnet_hdr(NetClientState *nc)
> -{
> -    return false;
> -}
> -
> -int tap_probe_vnet_hdr_len(int fd, int len)
> -{
> -    return 0;
> -}
> -
> -void tap_fd_set_vnet_hdr_len(int fd, int len)
> -{
> -}
> -
> -int tap_fd_set_vnet_le(int fd, int is_le)
> -{
> -    return -EINVAL;
> -}
> -
> -int tap_fd_set_vnet_be(int fd, int is_be)
> -{
> -    return -EINVAL;
> -}
> -
> -static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
> -{
> -}
> -
> -static void tap_set_offload(NetClientState *nc, int csum, int tso4,
> -                     int tso6, int ecn, int ufo, int uso4, int uso6)
> -{
> -}
> -
>   struct vhost_net *tap_get_vhost_net(NetClientState *nc)
>   {
>       return NULL;
>   }
>   
> -static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
> -{
> -    return false;
> -}
> -
> -static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
> -{
> -    abort();
> -}
> -
>   static NetClientInfo net_tap_win32_info = {
>       .type = NET_CLIENT_DRIVER_TAP,
>       .size = sizeof(TAPState),
>       .receive = tap_receive,
>       .cleanup = tap_cleanup,
> -    .has_ufo = tap_has_ufo,
> -    .has_vnet_hdr = tap_has_vnet_hdr,
> -    .has_vnet_hdr_len = tap_has_vnet_hdr_len,
> -    .using_vnet_hdr = tap_using_vnet_hdr,
> -    .set_offload = tap_set_offload,
> -    .set_vnet_hdr_len = tap_set_vnet_hdr_len,
>   };
>   
>   static int tap_win32_init(NetClientState *peer, const char *model,
> 
> ---
> base-commit: 5d1fc614413b10dd94858b07a1b2e26b1aa0296c
> change-id: 20240212-tap-51087194c8eb
> 
> Best regards,

