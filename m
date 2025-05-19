Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F56AC54756
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 08:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGwDt-00032l-1o; Mon, 19 May 2025 04:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uGwDq-0002yr-1b
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uGwDn-00087Y-Fg
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747644702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zYAeDMesBoYsjozJj0/D223rJEwv1ngnpsbpvHlCYx8=;
 b=Gag28bAEXObmSIXgVD8Bcy55H6u7p6Z/cjDxoHbTpzNi3/rNBPSwkFUsWwkf8pB2b3zKk9
 ssNK05JbjC7zNtPpFWqKTWTkalWcW0RJhfx3SWZs/rPPO25rE0HYxqapB6YYpaofF3z6L1
 gLQRVqwFr/10U6pDOYlaTn0MCfWg4SU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-M0FSoviCN7u899uEXyiicQ-1; Mon, 19 May 2025 04:51:40 -0400
X-MC-Unique: M0FSoviCN7u899uEXyiicQ-1
X-Mimecast-MFC-AGG-ID: M0FSoviCN7u899uEXyiicQ_1747644699
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso222928f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 01:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747644699; x=1748249499;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYAeDMesBoYsjozJj0/D223rJEwv1ngnpsbpvHlCYx8=;
 b=uvBslkDCyqi/RbkLGDSyrYo7DK1Nw1zzjOZhUGbfQYqWoLxPl2bO/pwFtkhXh1P1lm
 enPET0+BDF30u32cK8/Ve4NBUeZz9eOM+Vao0Wt3JWqsksZePEiBuLUF9ENyyF5TKuZW
 CcLrw342UfrfgcENG6+WlVoESzv6DKtZbAVHPeb2EjoED4q0nj/zhhULD7BsoBwmSlUM
 gFQZ+N4wcaE4buyGRnVDRqqcRXwzcKn64Tp7xNi3zWfGXyA6CDBhPMZJggYqIAch117g
 JWzcxokC88dFmnhGnD+0H9kzrEdhn/BmTD80NiXXZtk7WDewJGaajPruazn51GRfEiwH
 msAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWesH17+MBH2QNIHaOsDbJMdEHFoTiTgcS+WD5cAXsD3ehmbSXn3etdIASJRSGLDugU0uPJhzMDCJuC@nongnu.org
X-Gm-Message-State: AOJu0YwsBVrpV+kAd6xIYxGFValiA4N3frWdOfJEAktWZUC7ZQuxlfWb
 zEAGWds3fw/i84CZLloJV7jDpOzcuuG0rnwKgii9lK0rA0d17P7x9foFCfbH+ZEYvyBRkEYGsZm
 YkpvDwQyePvaSI3SIL5kM+mdGrj7z4TKXdifx6mLPSp13CWp9CSKNKxyJ
X-Gm-Gg: ASbGncs21UtngNN+9uYlF/uiR2qsI94JGD2EsSSFDAKxZeRS4PmAIqXBbmTsT1JIDig
 N1lLzdRqTv/kl44y+bkmQU/06Kcjm8cFM2HhizIM2NP/hG+RbEQnqoWh0JbsyuOINXot6cG7ej/
 MpCbphIuKU7D/D0mQ7Y+eNiBJ+t+Sd2XA52XgdZn/5YnDw2CEiCyUD9/zalejWbq7DZhe97oBYZ
 r7ravCxEGNhA2z4F+yKhqhx7fMOBKl35KPCajVEdZB1dhdVKT4QLNJrLFi1EoUYu0p+zvzIeBeF
 6PVIMdEdnhC0TaGerCkHeb1HzQfjxTrk6ssIS9HMSORPqP55AA==
X-Received: by 2002:a05:6000:400d:b0:3a3:648e:17da with SMTP id
 ffacd0b85a97d-3a3648e1838mr8425497f8f.7.1747644699224; 
 Mon, 19 May 2025 01:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX6D0KElrZaHVRco9fstSRCz/z18OMKvhRYbMwEplXaKc+RmLN9Ohj7xdIWinL6RsQ43FO6w==
X-Received: by 2002:a05:6000:400d:b0:3a3:648e:17da with SMTP id
 ffacd0b85a97d-3a3648e1838mr8425461f8f.7.1747644698772; 
 Mon, 19 May 2025 01:51:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8caf0sm11833686f8f.82.2025.05.19.01.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 01:51:38 -0700 (PDT)
Message-ID: <ae7710bc-2877-44bb-b122-7df7ed564b22@redhat.com>
Date: Mon, 19 May 2025 10:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 24/42] migration: close kvm after cpr
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-25-git-send-email-steven.sistare@oracle.com>
 <9a664228-9a00-4387-b2d0-f7a428b52c75@redhat.com>
 <fb047fe4-1a8d-42c5-98c2-28adfee0f23a@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <fb047fe4-1a8d-42c5-98c2-28adfee0f23a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/16/25 20:18, Steven Sistare wrote:
> On 5/16/2025 4:35 AM, Cédric Le Goater wrote:
>> On 5/12/25 17:32, Steve Sistare wrote:
>>> cpr-transfer breaks vfio network connectivity to and from the guest, and
>>> the host system log shows:
>>>    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
>>> which is EBUSY.  This occurs because KVM descriptors are still open in
>>> the old QEMU process.  Close them.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> This patch doesn't build.
>>
>> /usr/bin/ld: libcommon.a.p/migration_cpr.c.o: in function `cpr_kvm_close':
>> ./build/../migration/cpr.c:260: undefined reference to `kvm_close'
> 
> My build works.
> For what binary does this ld command fail?


FAILED: qemu-system-s390x
FAILED: qemu-system-ppc
FAILED: qemu-system-ppc64
FAILED: qemu-system-arm
FAILED: qemu-system-aarch64


Thanks,

C.



> Could you send the complete ld command with make V=1?
> 
> - Steve
> 
>>> ---
>>>   accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
>>>   hw/vfio/helpers.c             | 10 ++++++++++
>>>   include/hw/vfio/vfio-device.h |  2 ++
>>>   include/migration/cpr.h       |  2 ++
>>>   include/qemu/vfio-helpers.h   |  1 -
>>>   include/system/kvm.h          |  1 +
>>>   migration/cpr-transfer.c      | 18 ++++++++++++++++++
>>>   migration/cpr.c               |  8 ++++++++
>>>   migration/migration.c         |  1 +
>>>   9 files changed, 70 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 278a506..d619448 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -512,16 +512,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>           goto err;
>>>       }
>>> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
>>> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
>>> +        s->coalesced_mmio_ring = NULL;
>>> +    }
>>> +
>>>       ret = munmap(cpu->kvm_run, mmap_size);
>>>       if (ret < 0) {
>>>           goto err;
>>>       }
>>> +    cpu->kvm_run = NULL;
>>>       if (cpu->kvm_dirty_gfns) {
>>>           ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>>>           if (ret < 0) {
>>>               goto err;
>>>           }
>>> +        cpu->kvm_dirty_gfns = NULL;
>>>       }
>>>       kvm_park_vcpu(cpu);
>>> @@ -600,6 +607,27 @@ err:
>>>       return ret;
>>>   }
>>> +void kvm_close(void)
>>> +{
>>> +    CPUState *cpu;
>>> +
>>> +    CPU_FOREACH(cpu) {
>>> +        cpu_remove_sync(cpu);
>>> +        close(cpu->kvm_fd);
>>> +        cpu->kvm_fd = -1;
>>> +        close(cpu->kvm_vcpu_stats_fd);
>>> +        cpu->kvm_vcpu_stats_fd = -1;
>>> +    }
>>> +
>>> +    if (kvm_state && kvm_state->fd != -1) {
>>> +        close(kvm_state->vmfd);
>>> +        kvm_state->vmfd = -1;
>>> +        close(kvm_state->fd);
>>> +        kvm_state->fd = -1;
>>> +    }
>>> +    kvm_state = NULL;
>>> +}
>>> +
>>>   /*
>>>    * dirty pages logging control
>>>    */
>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>> index d0dbab1..af1db2f 100644
>>> --- a/hw/vfio/helpers.c
>>> +++ b/hw/vfio/helpers.c
>>> @@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>>   int vfio_kvm_device_fd = -1;
>>>   #endif
>>> +void vfio_kvm_device_close(void)
>>> +{
>>> +#ifdef CONFIG_KVM
>>> +    if (vfio_kvm_device_fd != -1) {
>>> +        close(vfio_kvm_device_fd);
>>> +        vfio_kvm_device_fd = -1;
>>> +    }
>>> +#endif
>>> +}
>>> +
>>>   int vfio_kvm_device_add_fd(int fd, Error **errp)
>>>   {
>>>   #ifdef CONFIG_KVM
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>> index 4e4d0b6..6eb6f21 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>>>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>>>                         DeviceState *dev, bool ram_discard);
>>>   int vfio_device_get_aw_bits(VFIODevice *vdev);
>>> +
>>> +void vfio_kvm_device_close(void);
>>>   #endif /* HW_VFIO_VFIO_COMMON_H */
>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>> index fc6aa33..5f1ff10 100644
>>> --- a/include/migration/cpr.h
>>> +++ b/include/migration/cpr.h
>>> @@ -31,7 +31,9 @@ void cpr_state_close(void);
>>>   struct QIOChannel *cpr_state_ioc(void);
>>>   bool cpr_needed_for_reuse(void *opaque);
>>> +void cpr_kvm_close(void);
>>> +void cpr_transfer_init(void);
>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
>>> index bde9495..a029036 100644
>>> --- a/include/qemu/vfio-helpers.h
>>> +++ b/include/qemu/vfio-helpers.h
>>> @@ -28,5 +28,4 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>>>                                uint64_t offset, uint64_t size);
>>>   int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>>>                              int irq_type, Error **errp);
>>> -
>>>   #endif
>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>> index b690dda..cfaa94c 100644
>>> --- a/include/system/kvm.h
>>> +++ b/include/system/kvm.h
>>> @@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
>>>   int kvm_has_vcpu_events(void);
>>>   int kvm_max_nested_state_length(void);
>>>   int kvm_has_gsi_routing(void);
>>> +void kvm_close(void);
>>>   /**
>>>    * kvm_arm_supports_user_irq
>>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>>> index e1f1403..396558f 100644
>>> --- a/migration/cpr-transfer.c
>>> +++ b/migration/cpr-transfer.c
>>> @@ -17,6 +17,24 @@
>>>   #include "migration/vmstate.h"
>>>   #include "trace.h"
>>> +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
>>> +                                 MigrationEvent *e,
>>> +                                 Error **errp)
>>> +{
>>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>>> +        cpr_kvm_close();
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +void cpr_transfer_init(void)
>>> +{
>>> +    static NotifierWithReturn notifier;
>>> +
>>> +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
>>> +                                MIG_MODE_CPR_TRANSFER);
>>> +}
>>> +
>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>>   {
>>>       MigrationAddress *addr = channel->addr;
>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>> index 0b01e25..6102d04 100644
>>> --- a/migration/cpr.c
>>> +++ b/migration/cpr.c
>>> @@ -7,12 +7,14 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qapi/error.h"
>>> +#include "hw/vfio/vfio-device.h"
>>>   #include "migration/cpr.h"
>>>   #include "migration/misc.h"
>>>   #include "migration/options.h"
>>>   #include "migration/qemu-file.h"
>>>   #include "migration/savevm.h"
>>>   #include "migration/vmstate.h"
>>> +#include "system/kvm.h"
>>>   #include "system/runstate.h"
>>>   #include "trace.h"
>>> @@ -252,3 +254,9 @@ bool cpr_needed_for_reuse(void *opaque)
>>>       MigMode mode = migrate_mode();
>>>       return mode == MIG_MODE_CPR_TRANSFER;
>>>   }
>>> +
>>> +void cpr_kvm_close(void)
>>> +{
>>> +    kvm_close();
>>> +    vfio_kvm_device_close();
>>> +}
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 4697732..89e2026 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -337,6 +337,7 @@ void migration_object_init(void)
>>>       ram_mig_init();
>>>       dirty_bitmap_mig_init();
>>> +    cpr_transfer_init();
>>>       /* Initialize cpu throttle timers */
>>>       cpu_throttle_init();
>>
> 


