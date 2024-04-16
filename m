Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D00C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwf5C-0007QB-Sf; Tue, 16 Apr 2024 05:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rwf56-0007Or-6P
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rwf4q-0001HH-Ej
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713259565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50Dw7as93RN5q6+esv7+ClV6UaVcs+ihqYfNvO3BArE=;
 b=jFtN2yyZXBr7x69E7Ir9Fmlw0/Efq7RfoyTjRgNGMFP9ZqIUw7ydURk3Xz2T4vI7KZgGE8
 9GZM3NQlu6yyvmaQvv8pJGY3Cvs/WXEKYhF0R191mkrAaaGv9a8awjF/Ko5AncNAhfJncm
 xOcNmFUBpXvRoDYVpcSWFQ+egntkswk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-BCWG_XwCO_ivWI6-rGddgA-1; Tue, 16 Apr 2024 05:26:03 -0400
X-MC-Unique: BCWG_XwCO_ivWI6-rGddgA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a52521c7e12so181854566b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 02:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713259562; x=1713864362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=50Dw7as93RN5q6+esv7+ClV6UaVcs+ihqYfNvO3BArE=;
 b=a7O1tG8Fy3g64M5URW60zK1/msu6GR8cH7U7STvTkFtAymzeBJ9V2N+T/34zKvK7Zk
 OSUK6jLESFV0T2ZiJl+s6A4+nkEN7Agjo1uMl1tuasbYnD9it127i3voecJ6p80DZgX9
 y0wGugjfvHmu9TmmYFVVnECrnTBA/uHsQ1ZIN+HoeblftUikHY2YqqRh6qg6Rcsmvswk
 Vfyis+MHhaiqs57e7PaCACsOwPQugifi1AGIYQRAssiYK4na/4fCTBqpAcN8DZkU2Ksb
 moUeUJCWGHSwTSNCunmBLoKNxb63B5F2trUl2gs2yQ0wWp6oEHXd7LzW+ykwggbaqEeQ
 zfPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6MDoZS7+zu7XpHKnjFr9FN5VS0TBE3H+X+VznE1p6XBT59+TpQmk2xHjf3U/f1aLw7BSP+Vsexu2WF6OhueWCX8fiLts=
X-Gm-Message-State: AOJu0YwjOJKDuvZZpYIo0LfDFI5JH/XEHiF+BLvTL3UyYlq+BlLBxKgg
 DygIO2WWOZQolNaACyNotfvsiV6D4oDI5LI3FeljlnBKdCGPmO7Oz6ZJsOILf/YGV2/jgNIt770
 mDz8TODvwP7DN1atVStI+REalGhUrOi6t+r0ZYSW49CSQimMtUlG/
X-Received: by 2002:a17:906:374e:b0:a54:c11b:773d with SMTP id
 e14-20020a170906374e00b00a54c11b773dmr2244734ejc.73.1713259562794; 
 Tue, 16 Apr 2024 02:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPLRsHunjwgMKHb/gt3bxpA+PKG3xuCefK6B0bW8n0ELwjfgNbCKhwbm4dmUpIfk+MaF2oIw==
X-Received: by 2002:a17:906:374e:b0:a54:c11b:773d with SMTP id
 e14-20020a170906374e00b00a54c11b773dmr2244727ejc.73.1713259562430; 
 Tue, 16 Apr 2024 02:26:02 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:8ef:9484:1fb6:626:824c?
 (p200300cfd70008ef94841fb60626824c.dip0.t-ipconnect.de.
 [2003:cf:d700:8ef:9484:1fb6:626:824c])
 by smtp.gmail.com with ESMTPSA id
 cr19-20020a170906d55300b00a46b4c09670sm6571208ejc.131.2024.04.16.02.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 02:26:01 -0700 (PDT)
Message-ID: <95399e0a-9ec6-4751-a4a3-83e44dedf8a4@redhat.com>
Date: Tue, 16 Apr 2024 11:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0?] usb-storage: Fix BlockConf defaults
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
References: <20240412144202.13786-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240412144202.13786-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12.04.24 16:42, Kevin Wolf wrote:
> Commit 30896374 started to pass the full BlockConf from usb-storage to
> scsi-disk, while previously only a few select properties would be
> forwarded. This enables the user to set more properties, e.g. the block
> size, that are actually taking effect.
>
> However, now the calls to blkconf_apply_backend_options() and
> blkconf_blocksizes() in usb_msd_storage_realize() that modify some of
> these properties take effect, too, instead of being silently ignored.
> This means at least that the block sizes get an unconditional default of
> 512 bytes before the configuration is passed to scsi-disk.
>
> Before commit 30896374, the property wouldn't be set for scsi-disk and
> therefore the device dependent defaults would apply - 512 for scsi-hd,
> but 2048 for scsi-cd. The latter default has now become 512, too, which
> makes at least Windows 11 installation fail when installing from
> usb-storage.
>
> Fix this by simply not calling these functions any more in usb-storage
> and passing BlockConf on unmodified (except for the BlockBackend). The
> same functions are called by the SCSI code anyway and it sets the right
> defaults for the actual media type.
>
> Fixes: 308963746169 ('scsi: Don't ignore most usb-storage properties')
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2260
> Reported-by: Jonas Svensson
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> Considering this a candidate for 9.0 given that we're already having an
> rc4, it's a regression from 8.2 and breaks installing Windows from USB
>
>   hw/usb/dev-storage-classic.c | 9 ---------
>   1 file changed, 9 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


