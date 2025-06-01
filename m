Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7293FC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 17:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLmU1-0003p5-DP; Sun, 01 Jun 2025 13:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLmTy-0003oX-Ew
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 13:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLmTv-0007H9-UH
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 13:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748798903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cg1D7kIt0HpF38hNtgjlA5zs2T48nyvnHXGsjb5UtAs=;
 b=ILcsKhIjMOapdyE6iXMyL17ftf5thO/oSHjAWx+eeJAkBHPcVatluKxxeIHEd6lEQRfMYD
 kbtWQUrN3E9TVzJ4Yty3QC8dhy7nus38tHxdExndJHXbCNmVZD/xgWcJj+J3sBgNRWYDqU
 +tkUouJhlU59gv8lHDzEp6LIOwc9Czg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-UeXbiNHfMLSNncH0KIKN6Q-1; Sun, 01 Jun 2025 13:28:19 -0400
X-MC-Unique: UeXbiNHfMLSNncH0KIKN6Q-1
X-Mimecast-MFC-AGG-ID: UeXbiNHfMLSNncH0KIKN6Q_1748798898
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f6e0c285so1625672f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 10:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748798898; x=1749403698;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cg1D7kIt0HpF38hNtgjlA5zs2T48nyvnHXGsjb5UtAs=;
 b=IoCciCSVv4YUeBY8DtkHtpXpi9tNTBUvCRYgnSzGEPAMqrhXyf2+5xKVTxhxaLfXLj
 P95CW0ld/dh92CXU0orXdJH/b/5+7ec/jbJETlhvGJgn72pSlBlyJeP6KIXNqJB/uvXp
 ElH71Il7VTe+oDldkGb0Pf1s+qM5zBOST9rg3h2u8Dom846fjx57XVF9XfDAcZkeYIrh
 WRs0w2dg09g8leSvFOiMNxbQQOZ3sAxes6XO5bDI6/V6l1H//H2a9pV3I9PpU58KmCby
 Jqlcfi5/e4n6dmyehAxY5jIbaRy3o+6Fgtw1dzGqcefCosjD+g+U3Zpl2OyXPGfZPKDG
 UiZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+KoXGVWvOB0IsRE9le1fy4JrD4azGlBZys9eoGZFKJTj2RJWKj2vmA1frwvbcq60svzzJrToLWabo@nongnu.org
X-Gm-Message-State: AOJu0YwVZwQmnMcpcnKYJ1/aNaCWfD2qvd2pHNTahxCYBr/EfZiCi17m
 xhVb+4xeWG0+LJ2hoMhu/coBGmEcyvzroBEQHJeXYyUmTBDqF4oa8M20soEO7ItkwjRBqkLC+5c
 7Ad8t6m/9DwZLrJeOkGIpYPc8UgyRVAOozbCyCcLQS+sc+Gua/WogYt4g
X-Gm-Gg: ASbGncug58dBW95lBle1i/S9ucsQabDRdszZwP1VrMn82kpoe/ygyREVKOWk945kFjy
 ahXDtuIEcBdPWpSHVx/+rbom44SR+I5ZPls30iHBLERVcADoO68/S3NIpDmoLeAng1tv0Vm61H+
 YYIaY4+WBevkD2DT3LYTc+tuP4AR6JGgC71Ohn5baZnxJ/+RDxAX+OJR+pKHROv7ooKecWFr9gv
 v5YWYncrGrVZUeViY/YHMOFY5OPpPBgyHOrveV7MnhTLIZtA2qDImaF7Ycm+Tbpu7bForxpn4n/
 Ig1mdw4lSDhvbnBkr1bvDTYiLCzsUXyqqDfq+wpRsThFZ9ngrg==
X-Received: by 2002:a05:6000:2008:b0:3a4:cfbf:51ae with SMTP id
 ffacd0b85a97d-3a4fe154ecfmr3983984f8f.4.1748798898414; 
 Sun, 01 Jun 2025 10:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeCLRg0k2Weo7AkCyOwv9D5lNVXiyd2G/oiAXH8FPzpgqEn4B9apSotkFYNWd+UQgPswlE+Q==
X-Received: by 2002:a05:6000:2008:b0:3a4:cfbf:51ae with SMTP id
 ffacd0b85a97d-3a4fe154ecfmr3983967f8f.4.1748798898012; 
 Sun, 01 Jun 2025 10:28:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb0654sm91879065e9.21.2025.06.01.10.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 10:28:17 -0700 (PDT)
Message-ID: <33844330-fc17-4f22-bf97-daa5f7306390@redhat.com>
Date: Sun, 1 Jun 2025 19:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 22/42] vfio-pci: preserve MSI
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-23-git-send-email-steven.sistare@oracle.com>
 <a01fca3f-1411-4b4c-a87b-59f97776e14f@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a01fca3f-1411-4b4c-a87b-59f97776e14f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/28/25 19:44, Steven Sistare wrote:
> Hi Cedric,
>    Do you have any comments on this before I send V4?
> Ditto for patch "vfio-pci: preserve INTx".
> In both, I made the changes you requested in V2.
> And I will change all "reused" tests to cpr_is_incoming as we
> discussed elsewhere.

I saw. Thanks for the changes.

> You mentioned these possibly conflict with vfio-user, but it would
> help to get your stylistic and correctness comments on these from a
> cpr-only point of view before I send the next version.

OK. I will try to do that on v4 after the PR (with part 1) is sent.

> And as I mentioned, I propose to block CPR when vfio-user is used,
> at least initially, so you can ignore vfio-user in the cpr load paths below.

Thanks,

C.



> 
> - Steve
> 
> On 5/12/2025 11:32 AM, Steve Sistare wrote:
>> Save the MSI message area as part of vfio-pci vmstate, and preserve the
>> interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
>> then the vfio-pci post_load handler finds the eventfds in CPR state,
>> rebuilds vector data structures, and attaches the interrupts to the new
>> KVM instance.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/cpr.c              | 91 ++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/pci.c              | 40 ++++++++++++++++++--
>>   include/hw/vfio/vfio-cpr.h |  8 ++++
>>   3 files changed, 136 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index 6ea8e9f..be132fa 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -9,6 +9,8 @@
>>   #include "hw/vfio/vfio-device.h"
>>   #include "hw/vfio/vfio-cpr.h"
>>   #include "hw/vfio/pci.h"
>> +#include "hw/pci/msix.h"
>> +#include "hw/pci/msi.h"
>>   #include "migration/cpr.h"
>>   #include "qapi/error.h"
>>   #include "system/runstate.h"
>> @@ -40,6 +42,69 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>>   }
>> +#define STRDUP_VECTOR_FD_NAME(vdev, name)   \
>> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>> +
>> +void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>> +                             int fd)
>> +{
>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> +    cpr_save_fd(fdname, nr, fd);
>> +}
>> +
>> +int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> +{
>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> +    return cpr_find_fd(fdname, nr);
>> +}
>> +
>> +void vfio_cpr_delete_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> +{
>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> +    cpr_delete_fd(fdname, nr);
>> +}
>> +
>> +static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
>> +                                   bool msix)
>> +{
>> +    int i, fd;
>> +    bool pending = false;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +
>> +    vdev->nr_vectors = nr_vectors;
>> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
>> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
>> +
>> +    vfio_prepare_kvm_msi_virq_batch(vdev);
>> +
>> +    for (i = 0; i < nr_vectors; i++) {
>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>> +
>> +        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
>> +        if (fd >= 0) {
>> +            vfio_vector_init(vdev, i);
>> +            qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
>> +        }
>> +
>> +        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
>> +            vfio_add_kvm_msi_virq(vdev, vector, i, msix);
>> +        } else {
>> +            vdev->msi_vectors[i].virq = -1;
>> +        }
>> +
>> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
>> +            set_bit(i, vdev->msix->pending);
>> +            pending = true;
>> +        }
>> +    }
>> +
>> +    vfio_commit_kvm_msi_virq_batch(vdev);
>> +
>> +    if (msix) {
>> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
>> +    }
>> +}
>> +
>>   /*
>>    * The kernel may change non-emulated config bits.  Exclude them from the
>>    * changed-bits check in get_pci_config_device.
>> @@ -58,13 +123,39 @@ static int vfio_cpr_pci_pre_load(void *opaque)
>>       return 0;
>>   }
>> +static int vfio_cpr_pci_post_load(void *opaque, int version_id)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int nr_vectors;
>> +
>> +    if (msix_enabled(pdev)) {
>> +        msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
>> +                                   vfio_msix_vector_release, NULL);
>> +        nr_vectors = vdev->msix->entries;
>> +        vfio_cpr_claim_vectors(vdev, nr_vectors, true);
>> +
>> +    } else if (msi_enabled(pdev)) {
>> +        nr_vectors = msi_nr_vectors_allocated(pdev);
>> +        vfio_cpr_claim_vectors(vdev, nr_vectors, false);
>> +
>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> +        g_assert_not_reached();      /* completed in a subsequent patch */
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   const VMStateDescription vfio_cpr_pci_vmstate = {
>>       .name = "vfio-cpr-pci",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>>       .pre_load = vfio_cpr_pci_pre_load,
>> +    .post_load = vfio_cpr_pci_post_load,
>>       .needed = cpr_needed_for_reuse,
>>       .fields = (VMStateField[]) {
>> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 1bca415..bfa72bc 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -29,6 +29,7 @@
>>   #include "hw/pci/pci_bridge.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-properties-system.h"
>> +#include "hw/vfio/vfio-cpr.h"
>>   #include "migration/vmstate.h"
>>   #include "qobject/qdict.h"
>>   #include "qemu/error-report.h"
>> @@ -56,13 +57,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>> +/* Create new or reuse existing eventfd */
>>   static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>                                  const char *name, int nr, Error **errp)
>>   {
>> -    int ret = event_notifier_init(e, 0);
>> +    int fd = vfio_cpr_load_vector_fd(vdev, name, nr);
>> +    int ret = 0;
>> -    if (ret) {
>> -        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
>> +    if (fd >= 0) {
>> +        event_notifier_init_fd(e, fd);
>> +    } else {
>> +        ret = event_notifier_init(e, 0);
>> +        if (ret) {
>> +            error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
>> +        } else {
>> +            fd = event_notifier_get_fd(e);
>> +            if (fd >= 0) {
>> +                vfio_cpr_save_vector_fd(vdev, name, nr, fd);
>> +            }
>> +        }
>>       }
>>       return !ret;
>>   }
>> @@ -70,6 +83,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>>                                     const char *name, int nr)
>>   {
>> +    vfio_cpr_delete_vector_fd(vdev, name, nr);
>>       event_notifier_cleanup(e);
>>   }
>> @@ -554,6 +568,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>       int ret;
>>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>> +    /*
>> +     * Ignore the callback from msix_set_vector_notifiers during resume.
>> +     * The necessary subset of these actions is called from
>> +     * vfio_cpr_claim_vectors during post load.
>> +     */
>> +    if (vdev->vbasedev.cpr.reused) {
>> +        return 0;
>> +    }
>> +
>>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>>       vector = &vdev->msi_vectors[nr];
>> @@ -2937,6 +2960,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->err_notifier);
>>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>> +    /* Do not alter irq_signaling during vfio_realize for cpr */
>> +    if (vdev->vbasedev.cpr.reused) {
>> +        return;
>> +    }
>> +
>>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> @@ -3004,6 +3032,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->req_notifier);
>>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>> +    /* Do not alter irq_signaling during vfio_realize for cpr */
>> +    if (vdev->vbasedev.cpr.reused) {
>> +        vdev->req_enabled = true;
>> +        return;
>> +    }
>> +
>>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index e93600f..765e334 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -28,6 +28,7 @@ typedef struct VFIODeviceCPR {
>>   struct VFIOContainer;
>>   struct VFIOContainerBase;
>>   struct VFIOGroup;
>> +struct VFIOPCIDevice;
>>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>                                           Error **errp);
>> @@ -49,6 +50,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>>   bool vfio_cpr_ram_discard_register_listener(
>>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>> +void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> +                             int nr, int fd);
>> +int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> +                            int nr);
>> +void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> +                               int nr);
>> +
>>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>>   #endif /* HW_VFIO_VFIO_CPR_H */
> 


