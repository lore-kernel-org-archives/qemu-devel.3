Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62454C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 05:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfBYo-00026c-E9; Tue, 04 Feb 2025 00:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfBYn-00026U-60
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 00:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfBYl-0008D0-IP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 00:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738647198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEeOlsnYhDiPSKrDSj6BPfhNFyCgIkg6bjkXUXrEpug=;
 b=DTfkWIjXkKIJ8rpZi6+v9KywpJ6aVSse9MYpdqgFYVLZtNXx1kNTCwbDs9J/cXNqE9GVDM
 H3Xm8jRB0Sjcba9pet/e/r8tLzRdw1NbPu6BGUi7LVGXU5VZgZtz5ReuK+lIIAInrzflhC
 9et49kTSB0x7nozUSi57iT+PelHCR30=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Hu8fc8ULMNChhcX-NIWizw-1; Tue, 04 Feb 2025 00:33:16 -0500
X-MC-Unique: Hu8fc8ULMNChhcX-NIWizw-1
X-Mimecast-MFC-AGG-ID: Hu8fc8ULMNChhcX-NIWizw
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2166f9f52fbso172385495ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 21:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738647195; x=1739251995;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vEeOlsnYhDiPSKrDSj6BPfhNFyCgIkg6bjkXUXrEpug=;
 b=HqvqttFz3sWW+DQQOaNyLzy8qp+5oGZcsmSurWDFF51b03Nb/qlY9j1ffAHZFlTmg9
 AugM+NDnhO/Ft2wLoa9o9t0aeb9Y3z0zP/x19to96qnQXgtg9sW9Si1Exb5vLNALwl+J
 3kGTWLfu0QgHdGDbcERJ/xK7fshojv5nX7J5yVd/34ynh42I4OfRJ/C+IKVLoVPjNx7f
 p4ILl2kSgn28zwppfUwmpErWY0NsgK+z1zMJHEeOUZH+ekE7xtonb+sRBMkMUWeBtMAR
 7lD1RKVKvrDna7yTc5vJGvWEDPSRXgI18DlXkTC4uqHQfS+AJ4sOAxOgysBIbWQG8NuB
 7Gfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtQzhRmaPTNaKfuo1RZl9k0Ryg5GgX2fxS9EHkIAW3wfQcgWk2tUsa2g3JmCdI1Fj6E9ypl17QEhQE@nongnu.org
X-Gm-Message-State: AOJu0YwcqfkIryJ9/3xc2hQtgXD3B/GhcHeTpvoydzOQKepqNzGLcsOG
 be46nFYipzE1S1FEBznLQiaQ4hALxtfNh1yiFpho4s5hZp/54HVXzlDqCI3BHZGiMnsA1HVR1jF
 /XKGYoDPIGJQ18X6iZGQ0yfO8SV74HxHMeqyNIYKNGgLnxWkowI/2
X-Gm-Gg: ASbGncty5AEIaAB0Cmt4OzxNzkngceAx8olD0pgtVHtQwQpYthBffjR8gwKu7FY+Ce/
 bFBi7bZmTV7qds4WQJU5L3Fx0lvv3qk8YUKY/cqLHlIlL5Ju6+SRNxqfxISw+D1vesWQMQ8CJ14
 Vg3GmiIMYswrTMgGLiG3dUdFP1KwpK568obb7nt8jcqotEoZZazeiAbMo39UKGfnGk5/koEooTC
 R01JpLkqkYz7udztthpn+gyew5SmAxkJgrqMOiAnFsAzkDSjMSbtrBVQXmd3DCMiK8zD+jep6VV
 CZicHw==
X-Received: by 2002:a17:903:2a8b:b0:215:97c5:52b4 with SMTP id
 d9443c01a7336-21dd7dccd5amr357030845ad.39.1738647195369; 
 Mon, 03 Feb 2025 21:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3PiKYz+xeuQMFbzwH8Y4y6LEnFc7wLbHvS1/oKyzEyDMwwVYIPRn3XPbY+vSc9yx50dEf5g==
X-Received: by 2002:a17:903:2a8b:b0:215:97c5:52b4 with SMTP id
 d9443c01a7336-21dd7dccd5amr357030655ad.39.1738647195075; 
 Mon, 03 Feb 2025 21:33:15 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32ea5bbsm86914565ad.150.2025.02.03.21.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 21:33:14 -0800 (PST)
Message-ID: <73f81e95-7636-4a55-aa29-d288b20005b1@redhat.com>
Date: Tue, 4 Feb 2025 15:33:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/26] hw/core/loader: Add ROM loader notifier
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-10-jean-philippe@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241125195626.856992-10-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/26/24 5:56 AM, Jean-Philippe Brucker wrote:
> Add a function to register a notifier, that is invoked after a ROM gets
> loaded into guest memory.
> 
> It will be used by Arm confidential guest support, in order to register
> all blobs loaded into memory with KVM, so that their content is moved
> into Realm state and measured into the initial VM state.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   include/hw/loader.h | 15 +++++++++++++++
>   hw/core/loader.c    | 15 +++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 7f6d06b956..0cd9905f97 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -353,6 +353,21 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
>   ssize_t rom_add_vga(const char *file);
>   ssize_t rom_add_option(const char *file, int32_t bootindex);
>   
> +typedef struct RomLoaderNotify {
> +    /* Parameters passed to rom_add_blob() */
> +    hwaddr addr;
> +    size_t len;
> +    size_t max_len;
> +} RomLoaderNotify;
> +

I would suggest to rename it to RomLoaderNotifyData since it's the
data passed to the notifier.

> +/**
> + * rom_add_load_notifier - Add a notifier for loaded images
> + *
> + * Add a notifier that will be invoked with a RomLoaderNotify structure for each
> + * blob loaded into guest memory, after the blob is loaded.
> + */
> +void rom_add_load_notifier(Notifier *notifier);
> +
>   /* This is the usual maximum in uboot, so if a uImage overflows this, it would
>    * overflow on real hardware too. */
>   #define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 31593a1171..759a62cf58 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -67,6 +67,8 @@
>   #include <zlib.h>
>   
>   static int roms_loaded;
> +static NotifierList rom_loader_notifier =
> +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
>   
>   /* return the size or -1 if error */
>   int64_t get_image_size(const char *filename)
> @@ -1179,6 +1181,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>       return mr;
>   }
>   
> +void rom_add_load_notifier(Notifier *notifier)
> +{
> +    notifier_list_add(&rom_loader_notifier, notifier);
> +}
> +
>   /* This function is specific for elf program because we don't need to allocate
>    * all the rom. We just allocate the first part and the rest is just zeros. This
>    * is why romsize and datasize are different. Also, this function takes its own
> @@ -1220,6 +1227,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
>   static void rom_reset(void *unused)
>   {
>       Rom *rom;
> +    RomLoaderNotify notify;
>   
>       QTAILQ_FOREACH(rom, &roms, next) {
>           if (rom->fw_file) {
> @@ -1268,6 +1276,13 @@ static void rom_reset(void *unused)
>           cpu_flush_icache_range(rom->addr, rom->datasize);
>   
>           trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> +
> +        notify = (RomLoaderNotify) {
> +            .addr = rom->addr,
> +            .len = rom->datasize,
> +            .max_len = rom->romsize,
> +        };
> +        notifier_list_notify(&rom_loader_notifier, &notify);
>       }
>   }
>   

Thanks,
Gavin


