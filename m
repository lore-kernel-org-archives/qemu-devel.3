Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0FFC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkCd-0005gk-FX; Wed, 05 Mar 2025 03:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkCb-0005gJ-MW
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:34:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkCZ-0008Rl-MF
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741163642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/4d5VNr24nyerZQ4rMcpTMGtThH/Yb6cYTgv0ztKSEg=;
 b=FSra2C0t8S2IBm9HhEV92RbODFhCC9Az+Up3t0VORFbBh6S2oG3uA5yC0jYZD9ljXWPqth
 eYqmPZNLsyZJLxvdQMayQlukJQG0HmcvKkJwNwHJDHX9sGWPmO96dt2t0MnGQMXHtIRlyW
 CrwNhC+I+OFCA3DrmAraTrOEWlWOy2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669--wslMm9iPN-RQVcJlg39Lw-1; Wed, 05 Mar 2025 03:34:00 -0500
X-MC-Unique: -wslMm9iPN-RQVcJlg39Lw-1
X-Mimecast-MFC-AGG-ID: -wslMm9iPN-RQVcJlg39Lw_1741163640
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bcb061704so8089185e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741163640; x=1741768440;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4d5VNr24nyerZQ4rMcpTMGtThH/Yb6cYTgv0ztKSEg=;
 b=LR5RycKBmLhIovcO3YRMmga13EPO/YOa1g3I4Hv7V3YY2kY+SYZZDuXhD6JG+4LGbl
 CFW3alu2SXCXb0uyb6l1CgUXuRert7y8QIR7r2yZNyzjckLWehOdVNGSXlINL4t4XXMO
 l9dElyGfkckQX4ZfNWfii+nIKM2p9nKY6pSsOTXM4v7Ku8Kunw9jm5ZcgGhrQEAnjPZA
 FfQxSCnIs/SK5HE5maSyftbMfeFeircEr3mijCmyqoxSg/ubBzONF1wbRdnmhpvUoryp
 eLr5v2S4dcfEBOAilgQpzEtz3xMvYuMHqM56OWfN8Ycd9Le1Kj8wy1MfQFt760TxGt3g
 5MNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmAcbz+tD4M6gMSj5/nhEQh3Ibh/9z9vxj7B88LsFHAWYANaiF2ILMwHwYbWGTx8EW4R4MBKh7qTZs@nongnu.org
X-Gm-Message-State: AOJu0YyCOEyyoszhMlLT+DtYfDx+u+VaPl6gJeH6iQaVr5yHiK5aYa9K
 Qa4DaZ9Z83+Ro/2Dtdn4i+ajnT+6KIqBJzWGFzNJ578Ek6t2HAheE1y0+ivtIkHynfJsZ94Ub/1
 FQahDArpgjpb0b+/R0TYtb+gB/W6MPPZgbg4BzWecYcg5USg295Ef
X-Gm-Gg: ASbGncvitGw/LW8ZwNEUSzpyz7ofdD1fw5g5fFuebg5d6/ukOQp8Z7mQpfWcneRytcW
 +NC/xHsn5uQkfoWao0U3CE3c+BSPNdA+KxQ4tLkB68/6Fyin/IQJINOkXeH4zH4H8ESKhNzs+u2
 dM26bv5i0T05//fOQU+Orjg1V0uhH1/qYetP+1+uiuCdyYYz3zG39mTKRbKx6vy9criQ4of3NOx
 B5DW2UQEgroySAqintX62XmsHEtes1SoO6UyXUqJxrYyALHYsPNN5bHXg5Xu+jd/AznnUmVVIoR
 FEHSMjQmRvIXr9/h7Zp4sRJLqPWrc5we9djmQbxO1mO+CUQGu8Ptbg==
X-Received: by 2002:a05:600c:3ba8:b0:43a:ed4d:716c with SMTP id
 5b1f17b1804b1-43bd29b7dadmr11611045e9.22.1741163639680; 
 Wed, 05 Mar 2025 00:33:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzK5i8XD5rou1YfCwz/XN8ig0zlhLhO7NP3tAecCnlUA8pSWbFRWZqva2f2kFm7sw58qHYKA==
X-Received: by 2002:a05:600c:3ba8:b0:43a:ed4d:716c with SMTP id
 5b1f17b1804b1-43bd29b7dadmr11610795e9.22.1741163639314; 
 Wed, 05 Mar 2025 00:33:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c6ffsm10186455e9.33.2025.03.05.00.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:33:58 -0800 (PST)
Message-ID: <35b10237-606a-43b3-9cda-9e3fc4e2b7eb@redhat.com>
Date: Wed, 5 Mar 2025 09:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 29/36] vfio/migration: Multifd device state transfer
 support - config loading support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <5dbd3f3703ec1097da2cf82a7262233452146fee.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <5dbd3f3703ec1097da2cf82a7262233452146fee.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 3/4/25 23:03, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Load device config received via multifd using the existing machinery
> behind vfio_load_device_config_state().
> 
> Also, make sure to process the relevant main migration channel flags.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration-multifd.c   | 49 +++++++++++++++++++++++++++++++++--
>   hw/vfio/migration.c           |  9 ++++++-
>   include/hw/vfio/vfio-common.h |  2 ++
>   3 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 2eef27604e4f..1d81233c755f 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -17,6 +17,7 @@
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/thread.h"
> +#include "io/channel-buffer.h"
>   #include "migration/qemu-file.h"
>   #include "migration-multifd.h"
>   #include "trace.h"
> @@ -193,8 +194,52 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>   static bool vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
>                                                 Error **errp)
>   {
> -    error_setg(errp, "not yet there");
> -    return false;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIOStateBuffer *lb;
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    g_autoptr(QEMUFile) f_out = NULL, f_in = NULL;
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
> +        error_setg(errp, "%s: load config state flush failed: %d",
> +                   vbasedev->name, ret);
> +        return false;
> +    }
> +
> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
> +
> +    mig_header = qemu_get_be64(f_in);
> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
> +        error_setg(errp, "%s: expected FLAG_DEV_CONFIG_STATE but got %" PRIx64,
> +                   vbasedev->name, mig_header);
> +        return false;
> +    }
> +
> +    bql_lock();
> +    ret = vfio_load_device_config_state(f_in, vbasedev);
> +    bql_unlock();
> +
> +    if (ret < 0) {
> +        error_setg(errp, "%s: vfio_load_device_config_state() failed: %d",
> +                   vbasedev->name, ret);
> +        return false;
> +    }
> +
> +    return true;
>   }
>   
>   static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 0096344f74f9..f325a619c3ed 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -264,7 +264,7 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>       return ret;
>   }
>   
> -static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> +int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>       uint64_t data;
> @@ -723,6 +723,13 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>           switch (data) {
>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>           {
> +            if (vfio_multifd_transfer_enabled(vbasedev)) {
> +                error_report("%s: got DEV_CONFIG_STATE in main migration "
> +                             "channel but doing multifd transfer",
> +                             vbasedev->name);
> +                return -EINVAL;
> +            }
> +
>               return vfio_load_device_config_state(f, opaque);
>           }
>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 40382390692d..9d72ac1eae8a 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -298,6 +298,8 @@ void vfio_mig_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>   
> +int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> +
>   #ifdef CONFIG_LINUX
>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                            struct vfio_region_info **info);
> 


