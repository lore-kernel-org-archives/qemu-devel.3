Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A93FC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjj1-0001zn-QA; Wed, 05 Mar 2025 03:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpjiz-0001zC-QD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpjix-0001bE-BR
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741161805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tiqajl8YrEsRZNofLkPxgRiu6e9IyXEU30+HPtH1A7k=;
 b=LAb+EQsN2DFlVucI7whdW4LZIEqODRtac/uIsJI7wyVuIWdc8v8YNYItAAr1bqwU+BQUN3
 oCyXTpJA2yKzpLpSvBpaaugfZ70Xrs4lUId+MfIss1u7M+2G1YxheGeeBAFTvxcmkjvENL
 OHtevdAYQM0QP7DOp0AynHojVDFsb5w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-0VZuk5iNO4eqPmd0BPdPTA-1; Wed, 05 Mar 2025 03:03:24 -0500
X-MC-Unique: 0VZuk5iNO4eqPmd0BPdPTA-1
X-Mimecast-MFC-AGG-ID: 0VZuk5iNO4eqPmd0BPdPTA_1741161803
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390fc428a45so1560827f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741161803; x=1741766603;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tiqajl8YrEsRZNofLkPxgRiu6e9IyXEU30+HPtH1A7k=;
 b=AL6FqQu6PP+0k/pHWhUHIXKMi//uxu/CLYAxNR9U83bj2DsoxPYuqV8IQ9AQnharoF
 RDS2zLk4wFB44Fk9J7l5ewvunFPuNlREBnBn1idLYK5V2pw2V9IUwD9UkEb+j6VdPgdj
 H6mat88zgnQ5/uKRbota3FVvpyI9o2TqE4ZSty90UIrEQOBj231jNaKMpNBMNuR9EGFr
 pSz79FDQRssuF23wd9dZI6cG09RznNAIuYj5NKVCQwzCdEnJ+s1H2qfnk5Zchq/4Nrrb
 4RnkP9SU/fkoknhuw1JLIKkJp5WXZVPay0O6Ko/zbkPudoZfe6zKAo8sxM5iHED9/tqE
 LFKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcB7AU3PnN8ADb2unjxr5h78epzp5WsE0h+Cj/+pe6x4eyfG3f1UFS83bNM1YMD5k1+Rp+Vh3CDb9R@nongnu.org
X-Gm-Message-State: AOJu0YztoeZdxCXS80D1WUVptmNG0J8JcVZZ1FnoWULinf/98zMQ1cwN
 ldS2P+OZnn1N2q6ICGanVOK9UrMTCkeTuXN57Vv5q5xx4YOXQzSjJwphhScHYXeInPLB3+Jms6X
 m+DwPanl62TpxJq+NH4/2oVt7XSc8p4MKa+dnyXiGD/xmNjqmlxgn
X-Gm-Gg: ASbGncvVqQ3Ljoiuh5IldPupihzDdvaiFvpOfeAX6CP4ltpjpH4B0JWWOYTIXyxaq2Q
 ewMH9FVBBigOxQDfsIxzVm+chkkIuokmaCt7cKhE+454XszbWI5fcr4oAml2VbnVkeu9UgBzxZN
 6hsviOPaKCkdv1qeyWdP3KspNntNmWda/YQe5gzn48Ic0Y1NEcQl+6Zeoa9BxEIscz9NtUz4r45
 kLEXExkPpR5OfRCGjUfHbNuSI3T5kV2KIS7gI8fYTqedyE80SuCd8K39wEyD6hMn5kYlYUmvVJi
 sX36QzwO2uyg0+P8WL9li64kDWy41IWAIhaukSU1ql5QZBL5mFuEIw==
X-Received: by 2002:a05:6000:156f:b0:390:f734:13b1 with SMTP id
 ffacd0b85a97d-3911f756fdfmr1451835f8f.23.1741161801624; 
 Wed, 05 Mar 2025 00:03:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE/1Nw6iZtpKfJgJZTMBa3nMOFVCKBWlgT/9yOd5GR4azas2k0lp8ndp4qk8nlv5P6xgpeAA==
X-Received: by 2002:a05:6000:156f:b0:390:f734:13b1 with SMTP id
 ffacd0b85a97d-3911f756fdfmr1451800f8f.23.1741161801273; 
 Wed, 05 Mar 2025 00:03:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e045sm20390612f8f.99.2025.03.05.00.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:03:20 -0800 (PST)
Message-ID: <ab68c2e7-b44b-484a-959c-45d430664032@redhat.com>
Date: Wed, 5 Mar 2025 09:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/36] vfio/migration: Multifd setup/cleanup functions
 and associated VFIOMultifd
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <c0520523053b1087787152ddf2163257d3030be0.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <c0520523053b1087787152ddf2163257d3030be0.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/4/25 23:03, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Add multifd setup/cleanup functions and an associated VFIOMultifd data
> structure that will contain most of the receive-side data together
> with its init/cleanup methods.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration-multifd.c   | 44 +++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h   |  4 ++++
>   include/hw/vfio/vfio-common.h |  3 +++
>   3 files changed, 51 insertions(+)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 79fae0b6296f..091dc43210ad 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -32,8 +32,52 @@ typedef struct VFIODeviceStatePacket {
>       uint8_t data[0];
>   } QEMU_PACKED VFIODeviceStatePacket;
>   
> +typedef struct VFIOMultifd {
> +} VFIOMultifd;
> +
> +static VFIOMultifd *vfio_multifd_new(void)
> +{
> +    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
> +
> +    return multifd;
> +}
> +
> +static void vfio_multifd_free(VFIOMultifd *multifd)
> +{
> +    g_free(multifd);
> +}
> +
> +void vfio_multifd_cleanup(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    g_clear_pointer(&migration->multifd, vfio_multifd_free);
> +}
> +
>   bool vfio_multifd_transfer_supported(void)
>   {
>       return multifd_device_state_supported() &&
>           migrate_send_switchover_start();
>   }
> +
> +bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
> +{
> +    return false;
> +}
> +
> +bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        /* Nothing further to check or do */
> +        return true;
> +    }
> +
> +    if (alloc_multifd) {
> +        assert(!migration->multifd);
> +        migration->multifd = vfio_multifd_new();
> +    }
> +
> +    return true;
> +}
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index 1b60d5f67a1c..2a7a76164f29 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -14,6 +14,10 @@
>   
>   #include "hw/vfio/vfio-common.h"
>   
> +bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp);
> +void vfio_multifd_cleanup(VFIODevice *vbasedev);
> +
>   bool vfio_multifd_transfer_supported(void);
> +bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>   
>   #endif
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index bf5d52087129..40382390692d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -78,6 +78,8 @@ typedef struct VFIORegion {
>       uint8_t nr; /* cache the region number for debug */
>   } VFIORegion;
>   
> +typedef struct VFIOMultifd VFIOMultifd;
> +
>   typedef struct VFIOMigration {
>       struct VFIODevice *vbasedev;
>       VMChangeStateEntry *vm_state;
> @@ -89,6 +91,7 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    VFIOMultifd *multifd;
>       bool initial_data_sent;
>   
>       bool event_save_iterate_started;
> 


