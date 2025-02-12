Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAA6C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFUC-0003Go-KK; Wed, 12 Feb 2025 11:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiFU4-0003E4-FY
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:21:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiFU2-0007Vj-Ip
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739377265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oLf/2JIBy8ZDWFbbyyKijy18tOvWuQ73U8FgW7i7AfY=;
 b=Vz9ZgnrAzh+tte/W2IFhHNJqbCcXSVxoXqJz0sDdcK1JHp/as0S4VF7if6PPZG0T1CC1hv
 Y+zpJTD8VEdpsJzykBhW40rL/P7Z48dXJWm1ZtCfOUSeZBT8CgSa2cCX+VUDni5iEtwqFW
 pZcmqQzYvyCWGZgH4z/CZPkRiPNSydM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-xw7o-yuUP5moT45aY5Jn0A-1; Wed, 12 Feb 2025 11:21:03 -0500
X-MC-Unique: xw7o-yuUP5moT45aY5Jn0A-1
X-Mimecast-MFC-AGG-ID: xw7o-yuUP5moT45aY5Jn0A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43935bcec79so20460205e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 08:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739377262; x=1739982062;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLf/2JIBy8ZDWFbbyyKijy18tOvWuQ73U8FgW7i7AfY=;
 b=ErUUCrfCh+XqZbW2Bx0aqGjmRwYhHY/QVArkIi7lA5CNWztFUifgFFepEed+KUs90s
 1mAr2VsGrR17V3PYpOgqmsFgrXmsu4Sffkm4WAdTDDVuAoCZz9lVlwYoAdduxizmLeXE
 V6lUPW55eW9/AVHyt+X1hAvYSteV+ukHVSBw0EAPpDnJZwrC0hU/u/cao8W/NXh5KQlw
 KhKgEE/+oYoLXDT3V63QaUaRxWJHkVHOus2htliaGtyj+7YwuoVllFjns70GVvxF/Zfg
 5F9m8sgKfzTEBzakAm3ESyH1qiIV9bfGhQ7C0pV2XpYc4oCva8iFCP9PVLm6hEx/VVqh
 n5XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXk77fEjJT4wREf4aJiowlw1E2hK2DJJknUJ8rJxRkNQBMPbFDhwLlG1+iuRV6hzluAU1rWVJ2avPx@nongnu.org
X-Gm-Message-State: AOJu0Yz70q6lzqcbPRO+VFNNGVQw58zIqbEARU1g2TDz5Y7JvtgbCJny
 j9fT28nx/P4yykll/oHTwMWzAhfV7obFmDP3hBaNavBCZeURnOhaB6n2clgo/Q6Sl2gghVig9kq
 AiJU2ElNwqYV2LTZBChP671oUaDr87cAYhTwtSk+qsAQLGCXwm1rA
X-Gm-Gg: ASbGncsxnglnxE4ty0Uj9oH3At62KhLuTT+YV+GNabbFp+u48YdZIwoHo81zxIDmQjA
 9z7Kr/7o11p/fl9Y1zIP1CxCPr75dsKLJpR9O3na1bAc52kz/lknp7PPpITgqq6K/7D+wVZc395
 j0B2Bo9u8u3Gfnx0gDduZt5dugkcImyLUKrrBo3pfg2Lb/at97xd7pBi0yAucULS1U44IKmpbxd
 SSa5GmgC/B9xnyS4C6M+YAbTKxCwv+SnR3LUqP7xzD93okfi53z1M2wa3Yv7UJ37w5G+hZlp1ZQ
 wZ9Ztle4JXcro6z7fv+Ex9TKzhTzhU7EHnfGR68+1zA=
X-Received: by 2002:a05:600c:2294:b0:439:6030:9b8d with SMTP id
 5b1f17b1804b1-43960309c5dmr335375e9.29.1739377262209; 
 Wed, 12 Feb 2025 08:21:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt+7Hmp44g3PxRTtCZMZ2lJcDbzNji8KrZ0RfURiQfTotI17l4h0UrfIH41oi23HgMRF8zpA==
X-Received: by 2002:a05:600c:2294:b0:439:6030:9b8d with SMTP id
 5b1f17b1804b1-43960309c5dmr335065e9.29.1739377261784; 
 Wed, 12 Feb 2025 08:21:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f23asm24071595e9.7.2025.02.12.08.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:21:01 -0800 (PST)
Message-ID: <6a7108ac-38be-4028-bc07-bb9b68625906@redhat.com>
Date: Wed, 12 Feb 2025 17:21:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/33] vfio/migration: Multifd device state transfer
 support - config loading support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <de41d1ae244fccfa928eb78787ba903b420e1346.1738171076.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <de41d1ae244fccfa928eb78787ba903b420e1346.1738171076.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/30/25 11:08, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Load device config received via multifd using the existing machinery
> behind vfio_load_device_config_state().
> 
> Also, make sure to process the relevant main migration channel flags.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c | 103 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 98 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index ab5b097f59c9..31f651ffee85 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -15,6 +15,7 @@
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   
> +#include "io/channel-buffer.h"
>   #include "system/runstate.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "migration/misc.h"
> @@ -457,6 +458,57 @@ static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>       return true;
>   }
>   
> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> +
> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIOStateBuffer *lb;
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    QEMUFile *f_out = NULL, *f_in = NULL;
> +    uint64_t mig_header;
> +    int ret;
> +
> +    assert(multifd->load_buf_idx == multifd->load_buf_idx_last);
> +    lb = vfio_state_buffers_at(&multifd->load_bufs, multifd->load_buf_idx);
> +    assert(lb->is_present);
> +
> +    bioc = qio_channel_buffer_new(lb->len);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
> +
> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
> +
> +    ret = qemu_fflush(f_out);
> +    if (ret) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        return ret;
> +    }
> +
> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
> +
> +    mig_header = qemu_get_be64(f_in);
> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        g_clear_pointer(&f_in, qemu_fclose);
> +        return -EINVAL;
> +    }
> +
> +    bql_lock();
> +    ret = vfio_load_device_config_state(f_in, vbasedev);
> +    bql_unlock();
> +
> +    g_clear_pointer(&f_out, qemu_fclose);
> +    g_clear_pointer(&f_in, qemu_fclose);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>   static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
>   {
>       VFIOStateBuffer *lb;
> @@ -477,11 +529,6 @@ static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
>       return lb;
>   }
>   
> -static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
> -{
> -    return -EINVAL;
> -}

Please remove this change from this patch and from patch 28.

>   static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
>                                            VFIOStateBuffer *lb,
>                                            Error **errp)
> @@ -1168,6 +1215,8 @@ static int vfio_load_cleanup(void *opaque)
>   static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
>       int ret = 0;
>       uint64_t data;
>   
> @@ -1179,6 +1228,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>           switch (data) {
>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>           {
> +            if (migration->multifd_transfer) {
> +                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
> +                             vbasedev->name);
> +                return -EINVAL;
> +            }
> +
>               return vfio_load_device_config_state(f, opaque);
>           }
>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> @@ -1223,6 +1278,44 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>   
>               return ret;
>           }
> +        case VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY:
> +        {
> +            if (!migration->multifd_transfer) {
> +                error_report("%s: got DEV_CONFIG_LOAD_READY outside multifd transfer",
> +                             vbasedev->name);
> +                return -EINVAL;
> +            }
> +
> +            if (!vfio_load_config_after_iter(vbasedev)) {
> +                error_report("%s: got DEV_CONFIG_LOAD_READY but was disabled",
> +                             vbasedev->name);
> +                return -EINVAL;
> +            }

Please put the above chunck at the end of the series with the patch
adding ARM support.


> +            assert(multifd);
> +
> +            /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +            bql_unlock();
> +            WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +                if (multifd->load_bufs_iter_done) {
> +                    /* Can't print error here as we're outside BQL */
> +                    ret = -EINVAL;
> +                    break;
> +                }
> +
> +                multifd->load_bufs_iter_done = true;
> +                qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
> +                ret = 0;> +            }
> +            bql_lock();

Please introduce a vfio_multifd routine for the code above.



Thanks,

C.


> +
> +            if (ret) {
> +                error_report("%s: duplicate DEV_CONFIG_LOAD_READY",
> +                             vbasedev->name);
> +            }
> +            return ret;
> +        }
>           default:
>               error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
>               return -EINVAL;
> 


