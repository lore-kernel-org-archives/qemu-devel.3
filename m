Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05B3C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkd6-0006N6-Cv; Wed, 05 Mar 2025 04:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkce-00068j-7z
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:01:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkca-0005Ss-Tr
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741165256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FtRrmVKiegAMU417TqBR5dNnxwanItIjHpI5WjpEFIs=;
 b=hcDcP5e819ISN16UdKsTPir3UaZ0D7734bXMYCPA0jTDm5hh/rgQF4311PU1xwcDHsFjlr
 y33bsSW7FCK4zSbrl130b9Q+Fo6NwmneJqGimKJlJB1QoKGknJC33oYo2o73VQ7vCvbJL0
 WBxNjcASjcFXyF+6BAgsFXGZkEiMhUM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-0YECgYrWO4a4Bh7mrtOPNw-1; Wed, 05 Mar 2025 04:00:52 -0500
X-MC-Unique: 0YECgYrWO4a4Bh7mrtOPNw-1
X-Mimecast-MFC-AGG-ID: 0YECgYrWO4a4Bh7mrtOPNw_1741165251
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390fd681712so1770027f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 01:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741165250; x=1741770050;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtRrmVKiegAMU417TqBR5dNnxwanItIjHpI5WjpEFIs=;
 b=F3z3tVHD/5RnzJf+HTQsjAukZWxreoizh0SkZD5ye1+9Fo+oMEW0R0RXOgGkNxatx/
 kDz+NTqiJzZqzWclLFOoFHMeHZtGV++O26NdbSW9sr8dDLrPvzw6RFi00hyGOsztcS0v
 6EoabsnsfgofFedv8CQJOXlocnlt3wSG1Ff8Ef8M8P14zfjmojEoFNUS9D4/GY8+2WuL
 qUtrkV2Yf25Pgde0ODXM41HVTGVYDcYFMX+1OL0zxXcdDrVZuLMGHZq6qmP6WeMneIIl
 6t/fPCzL6WhzesRaIVq4aUm2TVhGn6U2Bf5xgunvzm/FsjZh2XZtO6Rqg4hqp4iF+eEA
 ALKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjUmIIZWyh8uEIgglGdYUyi5dyX1uta8q9MYSMX5M0o6Ncy4b+/mwSnku+xKK/45fm2FPA67DYfcKT@nongnu.org
X-Gm-Message-State: AOJu0YyJUMIg9CG+7fYQLKirEIyiLZB0bYvsq4legh+l79wTia3FMV/6
 i881qSv2SvOmPZPj29phLLjCUXRnBF/K431Y1+H4opILFgjdFzwCm5tOFKkLT6YfjAIhl8zK6MT
 OW/XvNlmVc+TN1XEfSBr2XKzYmtLk6rlZA08Y4Foe2HMry4w/GLXI
X-Gm-Gg: ASbGncur/SU3/F3HzYjm480VUOQYQRVxFSuci98YRJPhWSm9CmtWWkSKmLO3TTHs1YD
 tN1nq0ip8nUZejK04ZDPMWOY3iEbBjPj/Cs0E26l3EAx7wZRva1VSK3KRyFM7nm9v+x9qsxbcAR
 uoekiqFozJnM2K67j0NZxZB32cogAqnezI8ipa6HX1ay3aA7KE+/2dLEcJkkzkfeZEQt2pC2RPc
 iiof0f9e3J+SzGL7F+OKWEqYOrOGFpTUtHrOyzCODcQif/9soLDUiVGhQk39k1HGu4lKNm63QEl
 WEdyhcIoNgB26IwuBHKRVOR43qV8qLsfdpSDY6QrprHkt3kf3VY6Qg==
X-Received: by 2002:a05:6000:188b:b0:390:f832:383f with SMTP id
 ffacd0b85a97d-3911f7264eemr1628102f8f.2.1741165250551; 
 Wed, 05 Mar 2025 01:00:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVAhCaMHylLkO9AAR7rguTggVbD2XgbABa/iFsU4LSYsgjmGFLC/ZjeAAbuza5NsEaZkgk0Q==
X-Received: by 2002:a05:6000:188b:b0:390:f832:383f with SMTP id
 ffacd0b85a97d-3911f7264eemr1628075f8f.2.1741165250165; 
 Wed, 05 Mar 2025 01:00:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4848252sm20498934f8f.69.2025.03.05.01.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 01:00:49 -0800 (PST)
Message-ID: <96def84c-d740-458d-bbd4-ac2e8d419e9b@redhat.com>
Date: Wed, 5 Mar 2025 10:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/36] migration/multifd: Make MultiFDSendData a struct
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <7b02baba8e6ddb23ef7c349d312b9b631db09d7e.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7b02baba8e6ddb23ef7c349d312b9b631db09d7e.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Fabiano,

Could you please ack (or not) this patch please ?

Thanks,

C.


On 3/4/25 23:03, Maciej S. Szmigiero wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The newly introduced device state buffer can be used for either storing
> VFIO's read() raw data, but already also possible to store generic device
> states.  After noticing that device states may not easily provide a max
> buffer size (also the fact that RAM MultiFDPages_t after all also want to
> have flexibility on managing offset[] array), it may not be a good idea to
> stick with union on MultiFDSendData.. as it won't play well with such
> flexibility.
> 
> Switch MultiFDSendData to a struct.
> 
> It won't consume a lot more space in reality, after all the real buffers
> were already dynamically allocated, so it's so far only about the two
> structs (pages, device_state) that will be duplicated, but they're small.
> 
> With this, we can remove the pretty hard to understand alloc size logic.
> Because now we can allocate offset[] together with the SendData, and
> properly free it when the SendData is freed.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [MSS: Make sure to clear possible device state payload before freeing
> MultiFDSendData, remove placeholders for other patches not included]
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   migration/multifd-device-state.c |  5 -----
>   migration/multifd-nocomp.c       | 13 ++++++-------
>   migration/multifd.c              | 25 +++++++------------------
>   migration/multifd.h              | 15 +++++++++------
>   4 files changed, 22 insertions(+), 36 deletions(-)
> 
> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> index e383e75b1a02..64d8ca180167 100644
> --- a/migration/multifd-device-state.c
> +++ b/migration/multifd-device-state.c
> @@ -20,11 +20,6 @@ static struct {
>       MultiFDSendData *send_data;
>   } *multifd_send_device_state;
>   
> -size_t multifd_device_state_payload_size(void)
> -{
> -    return sizeof(MultiFDDeviceState_t);
> -}
> -
>   void multifd_device_state_send_setup(void)
>   {
>       assert(!multifd_send_device_state);
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index c00804652383..ffe75256c9fb 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -25,15 +25,14 @@
>   
>   static MultiFDSendData *multifd_ram_send;
>   
> -size_t multifd_ram_payload_size(void)
> +void multifd_ram_payload_alloc(MultiFDPages_t *pages)
>   {
> -    uint32_t n = multifd_ram_page_count();
> +    pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
> +}
>   
> -    /*
> -     * We keep an array of page offsets at the end of MultiFDPages_t,
> -     * add space for it in the allocation.
> -     */
> -    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
> +void multifd_ram_payload_free(MultiFDPages_t *pages)
> +{
> +    g_clear_pointer(&pages->offset, g_free);
>   }
>   
>   void multifd_ram_save_setup(void)
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3625c9a37c0e..dfb5189f0ea3 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -105,26 +105,12 @@ struct {
>   
>   MultiFDSendData *multifd_send_data_alloc(void)
>   {
> -    size_t max_payload_size, size_minus_payload;
> +    MultiFDSendData *new = g_new0(MultiFDSendData, 1);
>   
> -    /*
> -     * MultiFDPages_t has a flexible array at the end, account for it
> -     * when allocating MultiFDSendData. Use max() in case other types
> -     * added to the union in the future are larger than
> -     * (MultiFDPages_t + flex array).
> -     */
> -    max_payload_size = MAX(multifd_ram_payload_size(),
> -                           multifd_device_state_payload_size());
> -    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
> +    multifd_ram_payload_alloc(&new->u.ram);
> +    /* Device state allocates its payload on-demand */
>   
> -    /*
> -     * Account for any holes the compiler might insert. We can't pack
> -     * the structure because that misaligns the members and triggers
> -     * Waddress-of-packed-member.
> -     */
> -    size_minus_payload = sizeof(MultiFDSendData) - sizeof(MultiFDPayload);
> -
> -    return g_malloc0(size_minus_payload + max_payload_size);
> +    return new;
>   }
>   
>   void multifd_send_data_clear(MultiFDSendData *data)
> @@ -151,8 +137,11 @@ void multifd_send_data_free(MultiFDSendData *data)
>           return;
>       }
>   
> +    /* This also free's device state payload */
>       multifd_send_data_clear(data);
>   
> +    multifd_ram_payload_free(&data->u.ram);
> +
>       g_free(data);
>   }
>   
> diff --git a/migration/multifd.h b/migration/multifd.h
> index aa679d8bbe83..2d337e7b3b52 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -115,9 +115,13 @@ typedef struct {
>       uint32_t num;
>       /* number of normal pages */
>       uint32_t normal_num;
> +    /*
> +     * Pointer to the ramblock.  NOTE: it's caller's responsibility to make
> +     * sure the pointer is always valid!
> +     */
>       RAMBlock *block;
> -    /* offset of each page */
> -    ram_addr_t offset[];
> +    /* offset array of each page, managed by multifd */
> +    ram_addr_t *offset;
>   } MultiFDPages_t;
>   
>   struct MultiFDRecvData {
> @@ -140,7 +144,7 @@ typedef enum {
>       MULTIFD_PAYLOAD_DEVICE_STATE,
>   } MultiFDPayloadType;
>   
> -typedef union MultiFDPayload {
> +typedef struct MultiFDPayload {
>       MultiFDPages_t ram;
>       MultiFDDeviceState_t device_state;
>   } MultiFDPayload;
> @@ -394,12 +398,11 @@ void multifd_ram_save_cleanup(void);
>   int multifd_ram_flush_and_sync(QEMUFile *f);
>   bool multifd_ram_sync_per_round(void);
>   bool multifd_ram_sync_per_section(void);
> -size_t multifd_ram_payload_size(void);
> +void multifd_ram_payload_alloc(MultiFDPages_t *pages);
> +void multifd_ram_payload_free(MultiFDPages_t *pages);
>   void multifd_ram_fill_packet(MultiFDSendParams *p);
>   int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
>   
> -size_t multifd_device_state_payload_size(void);
> -
>   void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state);
>   
>   void multifd_device_state_send_setup(void);
> 


