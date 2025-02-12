Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EE3C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 10:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiAOj-0002FA-Cr; Wed, 12 Feb 2025 05:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiAOh-0002El-7D
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 05:55:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiAOd-0005qo-Uj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 05:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739357710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+7HVAjvcdoiZAG2veGP/ShmxXBVO5/tTP0TRXXk3Erc=;
 b=JMC6HtBGkFpZg6HzAr26RzNLYDM9yqpE0l2P6Z3fbFIVTdihmrnID8X5NT6O4PpAIphNWV
 PAMKukCf5VkFQIT98UPhJxSQOm7XXQq2SpCgXdD3S+qRffLeIrh4poNEmcYeDxORC8r6Kc
 gMV4nEcaHh/EMkGhfdaLk+3n2MfcDK0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-muleNfhKOVuejgGWWVXIvA-1; Wed, 12 Feb 2025 05:55:08 -0500
X-MC-Unique: muleNfhKOVuejgGWWVXIvA-1
X-Mimecast-MFC-AGG-ID: muleNfhKOVuejgGWWVXIvA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dc709f938so412361f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 02:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739357707; x=1739962507;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7HVAjvcdoiZAG2veGP/ShmxXBVO5/tTP0TRXXk3Erc=;
 b=fFkZsUVKjRx9a1zqc6Mfn+TNHBeE7ghSpARmCA5kZzqQqvs4jBguOsTJpgaPgbouLk
 QmeXPd5ktTCONk3aR120wsdPqqf8HNNZzztoXwH4Qac5ciqOCTxPuIOQ5eQ/X8P27V3Z
 cz9VtAiwNCRWPDjiG2h2KCIowY3Kek/u/dD9z1YJttVw2HHZr3Z7fmFOXNrS2m+dBwh3
 pVEqMjAWeIhqPcRPBHKVpuYcD9HuBICZ5t5oW+pHpC+VpzHL8K3spmtPk38qPgEQTWtv
 9xOCNNCPIWq+ZY+EQNgMFtIcSc7NkjvyoTTP2fojydX6ZTU6g4ekqP9ibh+353iAPrWM
 nDNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+n10qYK+Fi+IMdFJmOFgHeYGp5NOq7jfP68yRK45sQMt0oCSBd0TuE8ZCx2unN3XTE+5purE93zM1@nongnu.org
X-Gm-Message-State: AOJu0Yzd1+lNsXgSQy0LNcBAuf+gV72nuouDTx9CJlXo1auNaTB/Antg
 Cb4pgWlxMycyHv5sF1JYz84cu7GrZ1wyGpzmDkLi5EOw+wk2SSwB2e6FLBUMJHvdG5jywQqJTtG
 +XHqdzGKV9DrSSClt2UzRYQkYy3IRJzF/Mxs0rrfHpDEkHUCMnW1J
X-Gm-Gg: ASbGncvBQohbJoz6w5e/eZqP46KYausTe0fPHucE5O9qOgmTCgzz7ssqZDjDdBQACik
 JDqtu9eq/JaP8uvlnBbFT8whhv3FY6eFAg+kaiHE/I5brj7ZDdqHoHCMwe6YRSX+D+lUwBMa2sK
 VF0w7/CVuF/gzLnArtjR8wL/o63CqqV/RK60vaPpDGfHdnVemYVe8jd6f6AF0ztWR4sJBvHMXxV
 SB6DGrC0AzuFe18OMjii8zlsH2LNCnxl0qov32rIzd3aqXdVeFogycN0RM/mBQgNcf+0GGM5Slo
 mSUP0BhPXUSrAjb4XjYf8NzcQH41nRCK3sW8d1WOZXc=
X-Received: by 2002:a5d:6d0b:0:b0:38d:dfdc:c874 with SMTP id
 ffacd0b85a97d-38de439d620mr5482678f8f.10.1739357707118; 
 Wed, 12 Feb 2025 02:55:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECMpZpoWdaiZ+5WNLYqXyU/ZrCdBcQWSQMXEYIMx+Qtwkc1ZxpN0JHuEYOFCjavuwlsifa5w==
X-Received: by 2002:a5d:6d0b:0:b0:38d:dfdc:c874 with SMTP id
 ffacd0b85a97d-38de439d620mr5482645f8f.10.1739357706679; 
 Wed, 12 Feb 2025 02:55:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a0711c1sm16035585e9.28.2025.02.12.02.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 02:55:05 -0800 (PST)
Message-ID: <6c337aec-d004-4ede-a86b-0c934b275fa9@redhat.com>
Date: Wed, 12 Feb 2025 11:55:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/33] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <1fcf182307e8e1f67a3c226e62d26cad3a2f60d0.1738171076.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1fcf182307e8e1f67a3c226e62d26cad3a2f60d0.1738171076.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

On 1/30/25 11:08, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Add support for VFIOMultifd data structure that will contain most of the
> receive-side data together with its init/cleanup methods.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 52 +++++++++++++++++++++++++++++++++--
>   include/hw/vfio/vfio-common.h |  5 ++++
>   2 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 3211041939c6..bcdf204d5cf4 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -300,6 +300,9 @@ typedef struct VFIOStateBuffer {
>       size_t len;
>   } VFIOStateBuffer;
>   
> +typedef struct VFIOMultifd {
> +} VFIOMultifd;
> +
>   static void vfio_state_buffer_clear(gpointer data)
>   {
>       VFIOStateBuffer *lb = data;
> @@ -398,6 +401,18 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>       return qemu_file_get_error(f);
>   }
>   
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
>   static void vfio_migration_cleanup(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
> @@ -785,14 +800,47 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    /*
> +     * Make a copy of this setting at the start in case it is changed
> +     * mid-migration.
> +     */
> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
> +        migration->multifd_transfer = vfio_multifd_transfer_supported();

Attribute "migration->multifd_transfer" is not necessary. It can be
replaced by a small inline helper testing pointer migration->multifd
and this routine can use a local variable instead.

I don't think the '_transfer' suffix adds much to the understanding.

> +    } else {
> +        migration->multifd_transfer =
> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
> +    }
> +
> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
> +        error_setg(errp,
> +                   "%s: Multifd device transfer requested but unsupported in the current config",
> +                   vbasedev->name);
> +        return -EINVAL;
> +    }

The above checks are also introduced in vfio_save_setup(). Please
implement a common routine vfio_multifd_is_enabled() or some other
name.

> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> +                                   migration->device_state, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (migration->multifd_transfer) {
> +        assert(!migration->multifd);
> +        migration->multifd = vfio_multifd_new();
> +    }
>   
> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> -                                    vbasedev->migration->device_state, errp);
> +    return 0;
>   }
>   
>   static int vfio_load_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    g_clear_pointer(&migration->multifd, vfio_multifd_free);

please add a vfio_multifd_cleanup() routine.


>       vfio_migration_cleanup(vbasedev);
>       trace_vfio_load_cleanup(vbasedev->name);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 153d03745dc7..c0c9c0b1b263 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -61,6 +61,8 @@ typedef struct VFIORegion {
>       uint8_t nr; /* cache the region number for debug */
>   } VFIORegion;
>   
> +typedef struct VFIOMultifd VFIOMultifd;
> +
>   typedef struct VFIOMigration {
>       struct VFIODevice *vbasedev;
>       VMChangeStateEntry *vm_state;
> @@ -72,6 +74,8 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
> +    VFIOMultifd *multifd;
>       bool initial_data_sent;
>   
>       bool event_save_iterate_started;
> @@ -133,6 +137,7 @@ typedef struct VFIODevice {
>       bool no_mmap;
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
> +    OnOffAuto migration_multifd_transfer;

This property should be added at the end of the series, with documentation,
and used in the vfio_multifd_some_name() routine I mentioned above.


Thanks,

C.



>       OnOffAuto migration_load_config_after_iter;
>       bool migration_events;
>       VFIODeviceOps *ops;
> 


