Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B74EC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqXw-0000tn-5p; Fri, 16 May 2025 04:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqXq-0000tA-1k
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqXm-0005t3-MB
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747384549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jTsSCVLhKC03pOAfrKPidNvsFD/3pNvVG+Z+mJTtnrI=;
 b=JLeXKRY3wSOzb+AtJYe1Lx+zg3QEe/NEirJWw2u7ZLPbmPE/ujvy9SR+EsQR/aPsTZgtpD
 REp3V2lhEPVRy/kMSb+N579VUjR0kKpkzT4/OXwmNHMZiq8i9eYlfeZGSMkmwkiNLIjtrq
 tV0ro/pWcwd043fQm/QoICsi9jZ4ggQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-MlR33hLSN7mGav-7ueiyfw-1; Fri, 16 May 2025 04:35:47 -0400
X-MC-Unique: MlR33hLSN7mGav-7ueiyfw-1
X-Mimecast-MFC-AGG-ID: MlR33hLSN7mGav-7ueiyfw_1747384546
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a35bf8377fso904991f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747384546; x=1747989346;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTsSCVLhKC03pOAfrKPidNvsFD/3pNvVG+Z+mJTtnrI=;
 b=dX6G+tO/C2dQ+Q6me/0q04087SziyTRDPddXSUt9G8iPpTEs1vE3LeyFdrqw5NUNf6
 h9oYrMZ52siDw/0AGwWNIlFeDXSxjxp+d9VZYFnzQzMror6lSH3Q2CaCmVKeA563EI3H
 zSwMCH73geL29tHgbCjZxRsBJtljGsJQ7nDA6I/8/At8488WLlt85fHhJaOPdbwwlOHA
 1PDh0Aj1ZeuFGKVlvFzfPfrwgrzJpyDNa+wxvE3vFQaPfcuS+BtsfswezQw25nBs+7lu
 uYuycsVaDCSWPeIGp7308aLHsbvIeW061t6DsBII120KGVrBnf+S08NW0BmUTR3r5ecg
 MTyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViCcaODfbNYCA/QqDsMheIXmfBSRdhP3dtrbev12zw9IFL+eiEi7Se3vyoX3FKM46lVTxGMUE2x0nB@nongnu.org
X-Gm-Message-State: AOJu0Yx0qxJGTm8DO3Y8ZwxBaoSXEHhaoFRLER+sJ1CYbN1DHKgQTP1W
 MOaosjk7x+v02jNrfhexpx3wYKD1lgjgwiDZQ2uoqG+1LOE5WLEphhh3ykQf9Wv56rNRpFfUaEB
 x1u2ZWZfT6qEqgabKUL2911RaqScBFw/iwP9ucIWPCLqhWxhuG38yTXF+
X-Gm-Gg: ASbGncvHlPoK7sBs86pV+QzTV/+s4AwSYIvLGKmdZXrpI9NCZHqHbTZnHMD1gwosYk5
 VVAoeR6UV84pWQMgOAkpvUZz+yMF18LQJsSE34HjzehHYrrzucFstMb10VuroipLJYqJ2SRI4Ei
 vOCsezgfWx03wTIY/H8n4fn1cKJo7+o2F/KH3AJdhYbPFwtM2znh1mg3xS5/kMe+F3pQpZEw47D
 J29h29UVMawovRaIEngkfoR3QWD5zXoAkXA106elQAgMRlOZRz9O4PmQYLU2WbHmdPlJ9djSBHi
 GJqpYWegbb1LrULhVWhExMtYgg5aXUxLnX6IfzLC+6uosk/HSA==
X-Received: by 2002:a5d:64ef:0:b0:39a:c9b3:e1d7 with SMTP id
 ffacd0b85a97d-3a35fe9623fmr1472413f8f.29.1747384546163; 
 Fri, 16 May 2025 01:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGqsT7uVpL0XIBpQy/QlhSZEh+/PA2l7OjcWci9NvGOoUrN69ress8oxrkpZxGg8elQXAv6w==
X-Received: by 2002:a5d:64ef:0:b0:39a:c9b3:e1d7 with SMTP id
 ffacd0b85a97d-3a35fe9623fmr1472382f8f.29.1747384545745; 
 Fri, 16 May 2025 01:35:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8d005sm2113237f8f.90.2025.05.16.01.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:35:45 -0700 (PDT)
Message-ID: <9a664228-9a00-4387-b2d0-f7a428b52c75@redhat.com>
Date: Fri, 16 May 2025 10:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 24/42] migration: close kvm after cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-25-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-25-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
> cpr-transfer breaks vfio network connectivity to and from the guest, and
> the host system log shows:
>    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
> which is EBUSY.  This occurs because KVM descriptors are still open in
> the old QEMU process.  Close them.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

This patch doesn't build.

/usr/bin/ld: libcommon.a.p/migration_cpr.c.o: in function `cpr_kvm_close':
./build/../migration/cpr.c:260: undefined reference to `kvm_close'



Thanks,

C.



> ---
>   accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
>   hw/vfio/helpers.c             | 10 ++++++++++
>   include/hw/vfio/vfio-device.h |  2 ++
>   include/migration/cpr.h       |  2 ++
>   include/qemu/vfio-helpers.h   |  1 -
>   include/system/kvm.h          |  1 +
>   migration/cpr-transfer.c      | 18 ++++++++++++++++++
>   migration/cpr.c               |  8 ++++++++
>   migration/migration.c         |  1 +
>   9 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 278a506..d619448 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -512,16 +512,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>           goto err;
>       }
>   
> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
> +        s->coalesced_mmio_ring = NULL;
> +    }
> +
>       ret = munmap(cpu->kvm_run, mmap_size);
>       if (ret < 0) {
>           goto err;
>       }
> +    cpu->kvm_run = NULL;
>   
>       if (cpu->kvm_dirty_gfns) {
>           ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>           if (ret < 0) {
>               goto err;
>           }
> +        cpu->kvm_dirty_gfns = NULL;
>       }
>   
>       kvm_park_vcpu(cpu);
> @@ -600,6 +607,27 @@ err:
>       return ret;
>   }
>   
> +void kvm_close(void)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_remove_sync(cpu);
> +        close(cpu->kvm_fd);
> +        cpu->kvm_fd = -1;
> +        close(cpu->kvm_vcpu_stats_fd);
> +        cpu->kvm_vcpu_stats_fd = -1;
> +    }
> +
> +    if (kvm_state && kvm_state->fd != -1) {
> +        close(kvm_state->vmfd);
> +        kvm_state->vmfd = -1;
> +        close(kvm_state->fd);
> +        kvm_state->fd = -1;
> +    }
> +    kvm_state = NULL;
> +}
> +
>   /*
>    * dirty pages logging control
>    */
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index d0dbab1..af1db2f 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>   int vfio_kvm_device_fd = -1;
>   #endif
>   
> +void vfio_kvm_device_close(void)
> +{
> +#ifdef CONFIG_KVM
> +    if (vfio_kvm_device_fd != -1) {
> +        close(vfio_kvm_device_fd);
> +        vfio_kvm_device_fd = -1;
> +    }
> +#endif
> +}
> +
>   int vfio_kvm_device_add_fd(int fd, Error **errp)
>   {
>   #ifdef CONFIG_KVM
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 4e4d0b6..6eb6f21 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>                         DeviceState *dev, bool ram_discard);
>   int vfio_device_get_aw_bits(VFIODevice *vdev);
> +
> +void vfio_kvm_device_close(void);
>   #endif /* HW_VFIO_VFIO_COMMON_H */
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index fc6aa33..5f1ff10 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -31,7 +31,9 @@ void cpr_state_close(void);
>   struct QIOChannel *cpr_state_ioc(void);
>   
>   bool cpr_needed_for_reuse(void *opaque);
> +void cpr_kvm_close(void);
>   
> +void cpr_transfer_init(void);
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>   
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index bde9495..a029036 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -28,5 +28,4 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>                                uint64_t offset, uint64_t size);
>   int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>                              int irq_type, Error **errp);
> -
>   #endif
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index b690dda..cfaa94c 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
>   int kvm_has_vcpu_events(void);
>   int kvm_max_nested_state_length(void);
>   int kvm_has_gsi_routing(void);
> +void kvm_close(void);
>   
>   /**
>    * kvm_arm_supports_user_irq
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index e1f1403..396558f 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -17,6 +17,24 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   
> +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
> +                                 MigrationEvent *e,
> +                                 Error **errp)
> +{
> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +        cpr_kvm_close();
> +    }
> +    return 0;
> +}
> +
> +void cpr_transfer_init(void)
> +{
> +    static NotifierWithReturn notifier;
> +
> +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
> +                                MIG_MODE_CPR_TRANSFER);
> +}
> +
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>   {
>       MigrationAddress *addr = channel->addr;
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 0b01e25..6102d04 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -7,12 +7,14 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "migration/cpr.h"
>   #include "migration/misc.h"
>   #include "migration/options.h"
>   #include "migration/qemu-file.h"
>   #include "migration/savevm.h"
>   #include "migration/vmstate.h"
> +#include "system/kvm.h"
>   #include "system/runstate.h"
>   #include "trace.h"
>   
> @@ -252,3 +254,9 @@ bool cpr_needed_for_reuse(void *opaque)
>       MigMode mode = migrate_mode();
>       return mode == MIG_MODE_CPR_TRANSFER;
>   }
> +
> +void cpr_kvm_close(void)
> +{
> +    kvm_close();
> +    vfio_kvm_device_close();
> +}
> diff --git a/migration/migration.c b/migration/migration.c
> index 4697732..89e2026 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -337,6 +337,7 @@ void migration_object_init(void)
>   
>       ram_mig_init();
>       dirty_bitmap_mig_init();
> +    cpr_transfer_init();
>   
>       /* Initialize cpu throttle timers */
>       cpu_throttle_init();


