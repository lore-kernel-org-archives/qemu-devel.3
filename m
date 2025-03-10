Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AFCC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 18:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhv5-0001mo-Qs; Mon, 10 Mar 2025 14:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trhue-0001fV-Uj
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trhud-00065h-5H
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741631497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YS8atgOWeJhUGJyJyFpP1nm1mWLcnslDulanhaJwBYs=;
 b=eUbQ1lZT0dGtk+bjLv1M/Wc715c01LWNieJDEmdhQRnt+VSQmEPAq60pgCK0o73bZxQWoK
 r/1rRHWRWDg9vso51h37FwIrGVlVFGsq5P9mSmUikPzlkINs6wGWioZcG/qgncC0FVGcW7
 10xskIlnXhhDvXA5HnJX+oO3ywsmchg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-niB22jMbNmOlfC1MbNSOHw-1; Mon, 10 Mar 2025 14:31:31 -0400
X-MC-Unique: niB22jMbNmOlfC1MbNSOHw-1
X-Mimecast-MFC-AGG-ID: niB22jMbNmOlfC1MbNSOHw_1741631490
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac297c7a0c2so124649166b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 11:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741631489; x=1742236289;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YS8atgOWeJhUGJyJyFpP1nm1mWLcnslDulanhaJwBYs=;
 b=ocHF0lJF9fFr6wGFZUAuetuCM2mWnX3ighMUgIPGiQoYtLzCMsXbS/beD5lwFslMgh
 XyJNI01Zg6MTk2bscDoHCIvbLX7k0vnU8DKXCkxKeQ1DWRsokvCS3arIbCTBufpBpG6f
 ds8Rv0wnk0oaaXLsADi6Gc4gTC3LnhKK4DGic8EPFXjf9mfZ2HWjjCclNIk6x9O8IZUA
 kIjPKAKF1T5Sz9wb1dIrcdTMEEqNGrbXLo9pvbKaHeTqQZt4Aq0Jw75jaqETwDSQL65B
 WYRUGVbcyCGh8zIMSynKKyZSMhEbHEOH14IjoVpzQnZBTYWaWRxvpK2IQdE/7Hn/8Eta
 2FWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD9v04tyaMt9abD88+KING5FNe19ScBYiVB3o1J66ffgafWJmkavLYIxQcc45ApVpjkVExCWdM9E1P@nongnu.org
X-Gm-Message-State: AOJu0Yz+fxbRwDewh/ikf8yFwhDsE56sbeYSGDAVUk6Mv69NEPGbgktv
 7ayeGMxulbcEUGR93f8UWyNncfF+ANpp5vv7CO0VVHhRBj17yKj/zJimyaY7ibe1da0OJWQMuDS
 0JH1TU9FdLRe4pHDsw+1MwfcU/GaOFjRhRFfZ4vqI2AnF96aJJp5wWG59/NAu84Y=
X-Gm-Gg: ASbGncu9Nj6QOKWud6tUuy3wDNKqVIZI5BJPxKk3e5pedMBB29ANW5QPhjkOTJmxAig
 MvggxZUBVGZ6TIM1e89m6fNNhpdNjP/rixM1PeyXBe6ok68xM01/CftKcBR3LFJlXpJfQr6F9dk
 KvPOANl5m5+UjitPSbWejXparTO9M9cXjkd13L5BoO0aJXWrnLSO63fCF9wws4ZHmp2vK8yuPZ9
 VkPgzghr28A8SDeIwNoNmzRwHR6LFQ7cBxnwpfubS8yrKeKIHAjNB9p7qY2A9Dws5cJ6cC/7XzL
 EkfakFUbptLKxx0PW0/4sA==
X-Received: by 2002:a05:6402:3494:b0:5e6:414b:525c with SMTP id
 4fb4d7f45d1cf-5e75f5a0ee3mr781089a12.25.1741631489075; 
 Mon, 10 Mar 2025 11:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1UFLlPbS0qPSDSD2aARfQzKGSiMYbdGFGLPfa9PIKa7siDxlhHK5ybtPL39DAg/byrs2HgQ==
X-Received: by 2002:a05:6402:3494:b0:5e6:414b:525c with SMTP id
 4fb4d7f45d1cf-5e75f5a0ee3mr781062a12.25.1741631488705; 
 Mon, 10 Mar 2025 11:31:28 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.122.167])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c768f8cbsm7104959a12.76.2025.03.10.11.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 11:31:28 -0700 (PDT)
Message-ID: <c4fa5da8-30d1-4d6f-ae18-27b17892314b@redhat.com>
Date: Mon, 10 Mar 2025 19:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Explain how to use passt
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Stefano Brivio
 <sbrivio@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20250310180050.112682-1-lvivier@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250310180050.112682-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.47, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/10/25 19:00, Laurent Vivier wrote:
> +Using passt as the user mode network stack
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +`passt(1)`_ can be used as a simple replacement for SLIRP (``-net user``).

I would use just `passt` for the link, linking to passt.top only the 
first time and...

> +`passt(1)`_ can be connected to QEMU either by using a socket
> +(``-netdev stream``) or using the vhost-user interface (``-netdev vhost-user``).
> +See `passt web site`_ and `passt(1)`_ for more details on passt.

... the man page here.  After the first two occurrences you don't need 
any more links.

> +Example of migration of a guest on the same host
> +________________________________________________
> +
> +Before being able to run passt-repair, the CAP_NET_ADMIN capability must be set
> +on the file, run as root::
> +
> +   setcat cap_net_admin+eip ./passt-repair

setcap

:)

> +Start `passt(1)`_ for the source side::
> +
> +   passt
> +
> +Start passt-repair::
> +
> +   passt-repair /tmp/passt_1.socket.repair
> +
> +Start source side QEMU with a monitor to be able to send the migrate command:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -monitor stdio
> +
> +Start `passt(1)`_ for the destination side::
> +
> +   passt
> +
> +Start passt-repair::
> +
> +   passt-repair /tmp/passt_2.socket.repair
> +
> +Start QEMU with the ``-incoming`` parameter:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -incoming tcp:localhost:4444
> +
> +Then in the source guest monitor the migration can be started::
> +
> +   (qemu) migrate tcp:localhost:4444
> +
>   Hubs
>   ~~~~
>   


