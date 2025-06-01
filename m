Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89430C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 16:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLm0O-00075I-CQ; Sun, 01 Jun 2025 12:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLm0M-00074r-PH
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 12:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLm0K-0004Zv-7g
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 12:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748797066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IYkbN41bg/npyiyYBZZpP/MOIQD6Ifj7ogh4EH03h+8=;
 b=hzEi4M0cKV7mfnBdI1JsSYwk4lG/JDDMSl88wLGenPH+TRNW+R98vubJPW4uzYmfx/T7qj
 +veyX95CcG/PHtB61sbVqgEQqo55PKxGEbZoyBuGXZ4uhA//r+YjiZI7pZIIiBfPyayMQW
 lv5r8eE5TH2oL1g7iL193cioB9rxx1k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687--kAvxgUdM9O-hdsxVpghXA-1; Sun, 01 Jun 2025 12:57:45 -0400
X-MC-Unique: -kAvxgUdM9O-hdsxVpghXA-1
X-Mimecast-MFC-AGG-ID: -kAvxgUdM9O-hdsxVpghXA_1748797064
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d57a0641so22057515e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 09:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748797064; x=1749401864;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYkbN41bg/npyiyYBZZpP/MOIQD6Ifj7ogh4EH03h+8=;
 b=fJYx8alJoYF38oY0PF4Cn1W7zuhUnAfBWshML23K/lVIH2KgZkyTqIYSTVuJA9favj
 hEuWVH7SFlff5kY6rre3e+jdyHweOI2E1+SSSpRKBt1BEmPJz4idC0i3pjPEvnIArMgO
 FZBT9HOWztw/iKAVThnPbSEUIJCpfedNmw9M3gwxHqOkUOjs5i4JucG98ZIUOwoGhDhH
 c6kXouDkROpqR2HbePP0bBhFxjfw9KRCK6h9CvqLmdvPHvZxKJrDuelnUOqzeP0s3L+n
 f+coeGJaWLpnZJ1glfzW8PtL7rHlcikYj32ZEUOfw/UcdpgykW2lIQEwdf2boo+gnuIB
 +GuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1QmjgqOpP9tkJPj5AYG8wMfVNfAUM9pnTXCZM/zVLFg2MIFzJA8bbBlN3HNvpHkWr6H2oUinISKXj@nongnu.org
X-Gm-Message-State: AOJu0YyY66iXL3nQMEtS/Yao3wAdjUl62bzGlXMXOpt0g7AfvIpU/f6h
 VsWd8RO9DajlWn3mbEgdW4GPQpvcCUN1zmdhqc7X7PAUV91B6jCrDWkNlHQaS+kLo0TU9uCGuSf
 cDnBEq54BI2uSKQYahV98YU4Npku4hKUeixjjpLRTJ0CdIb3lQ99M7q1n
X-Gm-Gg: ASbGnctT8BFIQAfH2iR96J7eREP9nV3Vw6ODFGFL5VHs/MglHbS42xScifi3qL1P/dH
 kmXESsN6zSwpuDYu3KL0Z2fHDnYcAkVlNeoxoQ3ZlpP0nMTw6aFxcRhyPvcSdDMK7C5L7kBtS5e
 wzL/Xe34pcNZUXwhwiuNUEd611YOmu4d91InvQ8l86hnd1Cs64eePMKp3ZF7PlvUurp7OAcXcRF
 B5GVWnS+HMkYUgw/kj/U3qlCtgEpSSLfoP7oBpjtAae/xmdzk9vCX1TceQ0ve5irWczvWB/Mxgg
 VJjpA4mf4CTp0hwj1hPM7npIo0d7REwK6XpHG2J/sXpMdd5GCg==
X-Received: by 2002:a05:600c:1c1e:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-4511ecb8a5emr40616595e9.7.1748797064152; 
 Sun, 01 Jun 2025 09:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsHnDnKZS/lLLdflf3jeSTBWIN7jI8fCWBLZrjQZE0z9X/lCQ0x7cTqh9e2vkqe77dz13qKw==
X-Received: by 2002:a05:600c:1c1e:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-4511ecb8a5emr40616415e9.7.1748797063601; 
 Sun, 01 Jun 2025 09:57:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe74072sm12252755f8f.52.2025.06.01.09.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 09:57:43 -0700 (PDT)
Message-ID: <4e4a7e63-0f8a-40d6-ada1-55d27b460b33@redhat.com>
Date: Sun, 1 Jun 2025 18:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/43] vfio/container: preserve descriptors
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-11-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-11-git-send-email-steven.sistare@oracle.com>
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

On 5/29/25 21:24, Steve Sistare wrote:
> At vfio creation time, save the value of vfio container, group, and device
> descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
> the saved descriptors.
> 
> During reuse, device and iommu state is already configured, so operations
> in vfio_realize that would modify the configuration, such as vfio ioctl's,
> are skipped.  The result is that vfio_realize constructs qemu data
> structures that reflect the current state of the device.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Thanks for making the changes. They look much better in container.c.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

C.


> ---
>   include/hw/vfio/vfio-cpr.h |  6 +++++
>   hw/vfio/container.c        | 67 +++++++++++++++++++++++++++++++++++-----------
>   hw/vfio/cpr-legacy.c       | 42 +++++++++++++++++++++++++++++
>   3 files changed, 100 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index d4e0bd5..5a2e5f6 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -13,6 +13,7 @@
>   
>   struct VFIOContainer;
>   struct VFIOContainerBase;
> +struct VFIOGroup;
>   
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
> @@ -30,4 +31,9 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>                                    Error **errp);
>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>   
> +int vfio_cpr_group_get_device_fd(int d, const char *name);
> +
> +bool vfio_cpr_container_match(struct VFIOContainer *container,
> +                              struct VFIOGroup *group, int fd);
> +
>   #endif /* HW_VFIO_VFIO_CPR_H */
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 7d2035c..798abda 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -31,6 +31,8 @@
>   #include "system/reset.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> +#include "migration/cpr.h"
> +#include "migration/blocker.h"
>   #include "pci.h"
>   #include "hw/vfio/vfio-container.h"
>   #include "hw/vfio/vfio-cpr.h"
> @@ -426,7 +428,12 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>           return NULL;
>       }
>   
> -    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
> +    /*
> +     * During CPR, just set the container type and skip the ioctls, as the
> +     * container and group are already configured in the kernel.
> +     */
> +    if (!cpr_is_incoming() &&
> +        !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>           return NULL;
>       }
>   
> @@ -593,6 +600,11 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>       group->container = container;
>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>       vfio_group_add_kvm_device(group);
> +    /*
> +     * Remember the container fd for each group, so we can attach to the same
> +     * container after CPR.
> +     */
> +    cpr_resave_fd("vfio_container_for_group", group->groupid, container->fd);
>       return true;
>   }
>   
> @@ -602,6 +614,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
>       group->container = NULL;
>       vfio_group_del_kvm_device(group);
>       vfio_ram_block_discard_disable(container, false);
> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>   }
>   
>   static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
> @@ -616,17 +629,34 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>       bool group_was_added = false;
>   
>       space = vfio_address_space_get(as);
> +    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
>   
> -    QLIST_FOREACH(bcontainer, &space->containers, next) {
> -        container = container_of(bcontainer, VFIOContainer, bcontainer);
> -        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
> -            return vfio_container_group_add(container, group, errp);
> +    if (!cpr_is_incoming()) {
> +        QLIST_FOREACH(bcontainer, &space->containers, next) {
> +            container = container_of(bcontainer, VFIOContainer, bcontainer);
> +            if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
> +                return vfio_container_group_add(container, group, errp);
> +            }
>           }
> -    }
>   
> -    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
> -    if (fd < 0) {
> -        goto fail;
> +        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
> +        if (fd < 0) {
> +            goto fail;
> +        }
> +    } else {
> +        /*
> +         * For incoming CPR, the group is already attached in the kernel.
> +         * If a container with matching fd is found, then update the
> +         * userland group list and return.  If not, then after the loop,
> +         * create the container struct and group list.
> +         */
> +        QLIST_FOREACH(bcontainer, &space->containers, next) {
> +            container = container_of(bcontainer, VFIOContainer, bcontainer);
> +
> +            if (vfio_cpr_container_match(container, group, fd)) {
> +                return vfio_container_group_add(container, group, errp);
> +            }
> +        }
>       }
>   
>       ret = ioctl(fd, VFIO_GET_API_VERSION);
> @@ -698,6 +728,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>   
>       QLIST_REMOVE(group, container_next);
>       group->container = NULL;
> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>   
>       /*
>        * Explicitly release the listener first before unset container,
> @@ -751,7 +782,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>       group = g_malloc0(sizeof(*group));
>   
>       snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
> -    group->fd = qemu_open(path, O_RDWR, errp);
> +    group->fd = cpr_open_fd(path, O_RDWR, "vfio_group", groupid, errp);
>       if (group->fd < 0) {
>           goto free_group_exit;
>       }
> @@ -783,6 +814,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>       return group;
>   
>   close_fd_exit:
> +    cpr_delete_fd("vfio_group", groupid);
>       close(group->fd);
>   
>   free_group_exit:
> @@ -804,6 +836,7 @@ static void vfio_group_put(VFIOGroup *group)
>       vfio_container_disconnect(group);
>       QLIST_REMOVE(group, next);
>       trace_vfio_group_put(group->fd);
> +    cpr_delete_fd("vfio_group", group->groupid);
>       close(group->fd);
>       g_free(group);
>   }
> @@ -814,7 +847,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>       g_autofree struct vfio_device_info *info = NULL;
>       int fd;
>   
> -    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
> +    fd = vfio_cpr_group_get_device_fd(group->fd, name);
>       if (fd < 0) {
>           error_setg_errno(errp, errno, "error getting device from group %d",
>                            group->groupid);
> @@ -827,8 +860,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>       info = vfio_get_device_info(fd);
>       if (!info) {
>           error_setg_errno(errp, errno, "error getting device info");
> -        close(fd);
> -        return false;
> +        goto fail;
>       }
>   
>       /*
> @@ -842,8 +874,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>           if (!QLIST_EMPTY(&group->device_list)) {
>               error_setg(errp, "Inconsistent setting of support for discarding "
>                          "RAM (e.g., balloon) within group");
> -            close(fd);
> -            return false;
> +            goto fail;
>           }
>   
>           if (!group->ram_block_discard_allowed) {
> @@ -861,6 +892,11 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>       trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
>   
>       return true;
> +
> +fail:
> +    close(fd);
> +    cpr_delete_fd(name, 0);
> +    return false;
>   }
>   
>   static void vfio_device_put(VFIODevice *vbasedev)
> @@ -871,6 +907,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
>       QLIST_REMOVE(vbasedev, next);
>       vbasedev->group = NULL;
>       trace_vfio_device_put(vbasedev->fd);
> +    cpr_delete_fd(vbasedev->name, 0);
>       close(vbasedev->fd);
>   }
>   
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 419b9fb..29be64f 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -9,6 +9,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/vfio/vfio-container.h"
>   #include "hw/vfio/vfio-cpr.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "migration/blocker.h"
>   #include "migration/cpr.h"
>   #include "migration/migration.h"
> @@ -67,3 +68,44 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>       migrate_del_blocker(&container->cpr.blocker);
>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
>   }
> +
> +int vfio_cpr_group_get_device_fd(int d, const char *name)
> +{
> +    const int id = 0;
> +    int fd = cpr_find_fd(name, id);
> +
> +    if (fd < 0) {
> +        fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
> +        if (fd >= 0) {
> +            cpr_save_fd(name, id, fd);
> +        }
> +    }
> +    return fd;
> +}
> +
> +static bool same_device(int fd1, int fd2)
> +{
> +    struct stat st1, st2;
> +
> +    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
> +}
> +
> +bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
> +                              int fd)
> +{
> +    if (container->fd == fd) {
> +        return true;
> +    }
> +    if (!same_device(container->fd, fd)) {
> +        return false;
> +    }
> +    /*
> +     * Same device, different fd.  This occurs when the container fd is
> +     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
> +     * produces duplicates.  De-dup it.
> +     */
> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
> +    close(fd);
> +    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
> +    return true;
> +}


