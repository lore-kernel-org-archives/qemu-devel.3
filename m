Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F9CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 21:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn2Ct-0006Tz-FO; Tue, 25 Feb 2025 16:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tn2Cp-0006TV-2U
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tn2Ck-0006RP-Ad
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740517859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4wAyZujxz4Pug/T+8Dik/0ppmHoLPFAS4zaaW77/Yoc=;
 b=EGnThpEJmSz7XPvdXGUeqVSRVC5pAd/AnwYGnQ0MM01r/O+xXTPsbyX78lY9deRP8bm28q
 x6Ui4MhuZ9+083cLG0p2bd4VJQwTl1Q4K2yh63j4M/G/FELUW5UpWU7V9hpaWgdWTn1t2H
 NwR816iPVfsOxeUDW94vxGhikgmnJ9Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-rCyVegdzM-SWFDIQ6RvEvw-1; Tue, 25 Feb 2025 16:10:58 -0500
X-MC-Unique: rCyVegdzM-SWFDIQ6RvEvw-1
X-Mimecast-MFC-AGG-ID: rCyVegdzM-SWFDIQ6RvEvw_1740517857
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393ed818ccso44216925e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 13:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740517857; x=1741122657;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4wAyZujxz4Pug/T+8Dik/0ppmHoLPFAS4zaaW77/Yoc=;
 b=KGZ5sWKLQnBg0WCPcBoNB0S599NC2KTA4IhJuJcxEL2winTEyqKYdzaiWpOsSUWaoe
 XSTq3+s4X2xmKMQT5szZPGoCXwLSezs7VxIaur5ts6CXmphpwMYnPUk+4K4bqPUORARB
 lRvRif0UakXCx5d0wKAuau9Yx7Nc73IGBx7srdQtvbLfC1EDWiIRoL4Efj1sSMoItZ/Q
 LwvAfqDOypA53Mm/w+bzlKoPAkZDcUP4dhz5ScE1ce44qhhzBI6SfQhGUQA0mrb6vwYQ
 9dibyB2xxTdoXDaMMMmg+bRF5lussty1Cd3NP3oZHg6OB6D7Ix7994c8bt8ZEnG/Kc18
 igEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFXmWxm18gAxVCUpev/MmC/qBb1NsnsBtITGJjd+YCLjEABKVLHcspD86nwBUtScmTkhZuMFxM/6Jn@nongnu.org
X-Gm-Message-State: AOJu0Yx1EON8VHsJ0o0QhUXZnCAfRKujPTbHbJMelWufc796FQofXPlB
 SdZitPPtpZtguGdoE5UWDzlA7i/qlrN+XddG++K5JL3MwpT9IIxE9gPGHWDJBHzI2Jm+9tbRvMy
 wNJXRVzXbyo0kpspDdUtquLyNe4dmEqIc6iqJBx7HAi0MYobMY0WW
X-Gm-Gg: ASbGncthMjfgFPtbVYrzW63ujUsVrQKV+4GN4H6T9xWkiq/rn1hNXOHjvqSmdjtaxHf
 4aNgfBbVx4JB8r/rWPMcTBNt9y8O8YJM1fiWHiYUuL5j7MOq4Si+SJ7loH+fJJF0O9EVt0OH/pO
 VJnr/dcFBBEv5iemTYKc5QAVlsb4z2H7reAa0YtWOv4q4Y5ZG9+p2847HQwp1kemYPmPgxyKZAY
 1RTpa/NL+D/UIteUhRf9ie7MJJovFuqtRiht9cwmRGdWUOcqjxNqFIXauE/cd2HMWKA6EVkzlBm
 Bq5kJNV1VqXuNFwYbjxyWQMmfWzDSrDRG0WWf85kIWu8
X-Received: by 2002:a05:6000:1f83:b0:38f:2a32:abbb with SMTP id
 ffacd0b85a97d-390d4f37826mr498840f8f.4.1740517856762; 
 Tue, 25 Feb 2025 13:10:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfTAthBnr76+CYknlZ+9KaLuxD/CcM03jlZMHNPXplZgiMSOt8xFajpggrqJkn4SGfbiTfEQ==
X-Received: by 2002:a05:6000:1f83:b0:38f:2a32:abbb with SMTP id
 ffacd0b85a97d-390d4f37826mr498833f8f.4.1740517856413; 
 Tue, 25 Feb 2025 13:10:56 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6373.dip0.t-ipconnect.de. [91.12.99.115])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5329besm110525e9.15.2025.02.25.13.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 13:10:55 -0800 (PST)
Message-ID: <28175337-552e-45c3-b6db-86c8f06fbce8@redhat.com>
Date: Tue, 25 Feb 2025 22:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] migration: ram block cpr blockers
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1740517563-245516-1-git-send-email-steven.sistare@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1740517563-245516-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> +    /* Ram device is remapped in new QEMU */
> +    if (memory_region_is_ram_device(mr)) {
> +        return true;
> +    }
> +
> +    /* Named files are remapped in new QEMU, same contents if shared (no COW) */
> +    if (qemu_ram_is_shared(rb) && qemu_ram_is_named_file(rb)) {
> +        return true;
> +    }
> +
> +    /* A file descriptor is remapped in new QEMU */
> +    if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
> +        return true;
> +    }


Sorry, I was not fast enough to reply to your v3 reply.

This is now essentially:

if (qemu_ram_is_shared(rb) &&
     (qemu_ram_is_named_file(rb) || rb->fd >= 0)) {
	return true;
}

But what is the purpose of the "name file" check then, if rb->fd 
essentially allows for any files?

So either the "fd >= 0" check is insufficient or the 
qemu_ram_is_named_file() check us superfluous.

-- 
Cheers,

David / dhildenb


