Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259B8C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 07:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCDuH-000532-UB; Wed, 29 May 2024 03:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCDuE-00052t-PH
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCDuC-0007vv-Ri
 for qemu-devel@nongnu.org; Wed, 29 May 2024 03:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716968366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6D/3tiwCtcDhEIer0+xCrdhhQWJab7qYxRKO6MTrWmU=;
 b=G4rKmI8Jt+c5/IwFnX7pC+vhx2bX8AiSM0pFpLiXOtxQm2eDQ01s00YFSpaFuSs0BtK0+Y
 mpH2/8QFlDuewxo9aqR5ibZ8cwMLsHyLoX0a9Bc/4RFRv9tLUrB9AuI1lxIYM0NYHO/ay/
 uhr4jfPfesO9lAtmiSQHcybDJdqJYbU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-5v3o-0SxMk66EUl23qy8Lg-1; Wed, 29 May 2024 03:39:24 -0400
X-MC-Unique: 5v3o-0SxMk66EUl23qy8Lg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-357766bb14fso1202289f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 00:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716968363; x=1717573163;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6D/3tiwCtcDhEIer0+xCrdhhQWJab7qYxRKO6MTrWmU=;
 b=NNcM5Ljy/L+ro2wu+MCnFSH2HaXH15bq8l8g/Ah/3hUdOFttWZH4uuT+piI7ypbb8x
 6CpeKKJxA0WRV5iK1iLsUu2hxG0uafoS0sZUqyfoEKe8x2DySI1VhOlJd821aCNcECS/
 aT0tW+PuKv2zHJcDDNyAzW5IiabrM0qRdXc4EKNx6hWnspriDrFwQsfXKeaivfbYmm68
 z4V9dJykL/wtYWktdAYpuwUWbmYH10oODzbsXo/CE0mmJvHg6I1MYOQUnvmSleiJFffq
 sxy66uOzkQEUgwFsQi6gkNDPnsBXj85OuXkRSrw63FHmL1hxIE9GfNtho9bFQMqQCyIT
 lyDA==
X-Gm-Message-State: AOJu0Yy3Z2RkmUkvx9vrimtBQT35eZXUutm4fn8Veqie+qolXpnQgBlG
 LTHUYj/oBpgydRtNIudLkFortR1mN8NcnQYyNH3p7N878mU7rTxaqyRLgrLDvIHZFBOxfm5OC6T
 sM2+U/uZQ0F3vT3BiFrUe6mPW0ZRaXY/sLIXYZ/pC/vNJDmi6jLlb
X-Received: by 2002:adf:e642:0:b0:354:fca5:4190 with SMTP id
 ffacd0b85a97d-35526c6f4a3mr10105042f8f.41.1716968363395; 
 Wed, 29 May 2024 00:39:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV/gvdg+F/9a/DW8AwNlUwN2d/PJJkaYk6qtOGNsCwdD6WKzdy/oaCn3REAiKyTNpreVwyRA==
X-Received: by 2002:adf:e642:0:b0:354:fca5:4190 with SMTP id
 ffacd0b85a97d-35526c6f4a3mr10105016f8f.41.1716968362910; 
 Wed, 29 May 2024 00:39:22 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7db8csm13998367f8f.8.2024.05.29.00.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 00:39:22 -0700 (PDT)
Message-ID: <ad1ea27a-9ecd-4c72-a9a6-b11e5eeb1293@redhat.com>
Date: Wed, 29 May 2024 09:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Fix sanitizer errors with clang 18.1.1
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev
 <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/05/2024 07.35, Akihiko Odaki wrote:
> I upgraded my Fedora Asahi Remix from 39 to 40 and found new sanitizer
> errors with clang it ships so here are fixes.
> 
> The patch "meson: Drop the .fa library prefix" may have a broad impact
> to the build system so please tell me if you have a concern with it.
> 
> To: Michael Tokarev <mjt@tls.msk.ru>
> To: Laurent Vivier <laurent@vivier.eu>
> To: Paolo Bonzini <pbonzini@redhat.com>
> To: Marc-André Lureau <marcandre.lureau@redhat.com>
> To: Daniel P. Berrangé <berrange@redhat.com>
> To: Thomas Huth <thuth@redhat.com>
> To: Philippe Mathieu-Daudé <philmd@linaro.org>
> To: Alex Bennée <alex.bennee@linaro.org>
> To: Wainer dos Santos Moschetta <wainersm@redhat.com>
> To: Beraldo Leal <bleal@redhat.com>
> To: Richard Henderson <richard.henderson@linaro.org>
> To: Laurent Vivier <lvivier@redhat.com>
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Changes in v4:
> - Fixed function pointer problems instead of ignoring them.
> - Made references to allocations static instead of incompletely freeing
>    them for qemu-keymap.
> - s/prefix/suffix/ for patch "meson: Drop the .fa library suffix".
> - Link to v3: https://lore.kernel.org/r/20240522-xkb-v3-0-c429de860fa1@daynix.com
> 
> Changes in v3:
> - Moved changes that should belong to patch "meson: Drop the .fa library
>    prefix" from patch "meson: Add -fno-sanitize=function".
> - Link to v2: https://lore.kernel.org/r/20240522-xkb-v2-0-67b54fa7c98f@daynix.com
> 
> Changes in v2:
> - Added more patches and converted them to a series.
> - Link to v1: https://lore.kernel.org/r/20240501-xkb-v1-1-f046d8e11a2b@daynix.com
> 
> ---
> Akihiko Odaki (4):
>        qemu-keymap: Make references to allocations static
>        lockable: Do not cast function pointers
>        qapi: Do not cast function pointers
>        meson: Drop the .fa library suffix

FYI, I'll try to pick up patches 1 - 3 for my next pull request (updating 
the commit description of patch 3 according to Markus' suggestions).

Patch 4 does not apply cleanly anymore, so it needs a respin, but I'd also 
like to see this going through Paolo's meson tree if possible.

  Thomas



