Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983A6EF0713
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 06:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpL54-0003Y0-K7; Mon, 09 Feb 2026 01:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpL4s-0003XH-7s
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 01:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpL4d-0004pH-Bf
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 01:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770619720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bGTKN4G+1mhrZPK0XlRE/HRCG0eZEe3KAx4Qk2112bA=;
 b=eoA8UbsHDsvO2mN6WETk1IMlrKNSoIdkjkzipUJfHX0TSFMJsdkrNke2SyHWldVXtQHQ6l
 5mCseikceOafzMXjkEYEOiQ0Z0Xp0tYUdzO1vdnTiMnWVY0ivfDNLf/2mSr1r3WPEEPGXM
 JG2qkOg8qR37FWV2WAHn2sHneWfMb+o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-vDl5eVmDPuGkH0chLVdznw-1; Mon, 09 Feb 2026 01:48:38 -0500
X-MC-Unique: vDl5eVmDPuGkH0chLVdznw-1
X-Mimecast-MFC-AGG-ID: vDl5eVmDPuGkH0chLVdznw_1770619717
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483129eb5ccso43131675e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 22:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770619717; x=1771224517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bGTKN4G+1mhrZPK0XlRE/HRCG0eZEe3KAx4Qk2112bA=;
 b=A4mhN7qGkeuZny2ShVJMZXS2whQ3fNFNsG5aCVNyLkBBY5jRHJX7D026I2XnSO91WJ
 h1RvoKcBLZmzGtvC4gCZBrEUuICmdGs/cICVX+SMBeaFD8/XgST5ub2zN8KUwsSoAtGm
 gv6PGyDfBzzXlLLCABuNR/RTpMNsFZiL2utHdNtIlBDw/kpGG4XXNWuZO6maudhiq5rH
 V/ZpuFe+9rwi2dI43CmgVmNDNUaBSG50jTDMZ1yN7CcypWG5UMP5doEW3VW1/nSHSTe5
 ut27YIouVRlMhl3G4aGtYTR9uc7iuzu/jKL+jOWmR3mKoy/32SZ5zWtnUIA064ZhQ/hn
 5ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770619717; x=1771224517;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGTKN4G+1mhrZPK0XlRE/HRCG0eZEe3KAx4Qk2112bA=;
 b=i0xDbxWOyGdUYe+Yq3IRVmfdQkE0Hg4lLjMD4p6WDgOXJgHJqCap60zrPCIK1M30La
 IqHix0pkqmN5My11rJvB3x2RLl5S/zSa8tAZAkifN8UBN5cuL/YbW03bDjrv6Km8YOPQ
 jyuNX9GvzNHE4ZLXBksuBD1PKUcy/uaN8NMW/rMQvhgUQfpLPzMsftV2UfHriBSoHpTS
 S+u42/adZyu5GcSln+d6IfL/spt/bqa6Uiyj6prVxDVDnO54bRNv73uR5Py85lI0xR/U
 QHgQaN+6kjIDJcV+HI+RMo8G7u26ASzIofzlkvNob6tU4lhr0diYerMA9H51+jRwnoeX
 FMIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWphemJJxnC8siyTakzb/9kDCaQH7baCuT5w8QgSZ4l1QHyLCcATG+92BFfhSaGVHg3Fv5QuYWSpInF@nongnu.org
X-Gm-Message-State: AOJu0YwMP+r/LCz9fpTOFA7pxjKveOMTh/kohIxGn42gX0go5wFedcu5
 a0x8HoSn2F2OJhm+ZVS8yFkmJpsHUR7vSnrWnf1aFlwow98V5qnZ1NjYdzu9DK+KfPbrJt0I35/
 52uBZcMgZ4amwSYe2UFw32emx3AJi8/TAfAz/nnU88MSn0pI93j0foqbSKCEBZowe
X-Gm-Gg: AZuq6aItb2p6D7ia+gpHZfNiWBc/LyQMylc7CkjpmtaMNvrrctkes1Rtc/2UMdcpjE2
 /QJ7gyDuueVqXS65i3FnwHW+ryPnfrorj1n/EFVB9CqKQM5wT1434vQh7UREMaDxzHLcp72mosX
 p5YD/rNRkQhib3teQdfZDRDEOMq5xPD69E2A19lBD0ZEEhS1+6uKl7T19tuPExp5a5Uh2GlRxm5
 vRTM+577hTyJnRrkM+G72Huw+rpQHtPwo3LO4G1+t7ZKQqGoVAawcGWvZT43zsnryrKAGiCOT4R
 AVNR6UN4YFPjscPw4DgxceU85nslmNSxKdRhhvhOUv7Rhp6BmuYJMh124aygchrD7B1+9mKb/XC
 TOjMPtq2MPOYQ+k4AsWxDhEd67JexpyZybaHmIc8GrC9Ateq0
X-Received: by 2002:a05:600c:a111:b0:483:3380:ca12 with SMTP id
 5b1f17b1804b1-4833380cb1amr61223435e9.29.1770619716613; 
 Sun, 08 Feb 2026 22:48:36 -0800 (PST)
X-Received: by 2002:a05:600c:a111:b0:483:3380:ca12 with SMTP id
 5b1f17b1804b1-4833380cb1amr61223265e9.29.1770619716149; 
 Sun, 08 Feb 2026 22:48:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b2d43sm23990451f8f.8.2026.02.08.22.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 22:48:35 -0800 (PST)
Message-ID: <7feb4327-fbe6-4ed3-bfe5-e0f8adf8022e@redhat.com>
Date: Mon, 9 Feb 2026 07:48:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/33] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: Ani Sinha <anisinha@redhat.com>, Alex Williamson <alex@shazbot.org>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-23-anisinha@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260127051612.219475-23-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/27/26 06:15, Ani Sinha wrote:
> Normally the vfio pseudo device file descriptor lives for the life of the VM.
> However, when the kvm VM file descriptor changes, a new file descriptor
> for the pseudo device needs to be generated against the new kvm VM descriptor.
> Other existing vfio descriptors needs to be reattached to the new pseudo device
> descriptor. This change performs the above steps.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/vfio/helpers.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index f68f8165d0..d467875b4b 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -110,12 +110,71 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>   #ifdef CONFIG_KVM
>   /*
>    * We have a single VFIO pseudo device per KVM VM.  Once created it lives
> - * for the life of the VM.  Closing the file descriptor only drops our
> - * reference to it and the device's reference to kvm.  Therefore once
> - * initialized, this file descriptor is only released on QEMU exit and
> + * for the life of the VM except when the vm file descriptor changes for
> + * confidential virtual machines. In that case, the old file descriptor is
> + * closed and a new file descriptor is recreated.  Closing the file descriptor
> + * only drops our reference to it and the device's reference to kvm.
> + * Therefore once initialized, this file descriptor is normally only released
> + * on QEMU exit (except for confidential VMs as stated above) and

Instead of changing this paragraph, I would prefer having, below
the vfio_kvm_device_fd definition, a new section starting with
comment "Confidential virtual machines"

>    * we'll re-use it should another vfio device be attached before then.
>    */
>   int vfio_kvm_device_fd = -1;

/*
  * Confidential virtual machines

    <what is different from non confidential VMs>

  */
   
<Code>

> +
> +typedef struct KVMVfioFileFd {
> +    int fd;
> +    QLIST_ENTRY(KVMVfioFileFd) node;
> +} KVMVfioFileFd;
> +
> +static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =
> +    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
> +
> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *data,
> +                                  Error **errp);

This declaration could be avoided.

> +static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier = {
> +    .notify = kvm_vfio_filefd_rebind,
> +};
> +
> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *data,
> +                                  Error **errp)
> +{
> +    KVMVfioFileFd *file_fd;
> +    int ret = 0;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_DEV_VFIO_FILE,
> +        .attr = KVM_DEV_VFIO_FILE_ADD,
> +    };
> +    struct kvm_create_device cd = {
> +        .type = KVM_DEV_TYPE_VFIO,
> +    };
> +
> +    /* we are not interested in pre vmfd change notification */
> +    if (((VmfdChangeNotifier *)data)->pre) {
> +        return 0;
> +    }
> +
> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
> +        return -errno;
> +    }
> +
> +    if (vfio_kvm_device_fd) {

May be "vfio_kvm_device_fd != -1" ?

> +        close(vfio_kvm_device_fd);
> +    }
> +
> +    vfio_kvm_device_fd = cd.fd;
> +
> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> +        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> +            error_setg_errno(errp, errno,
> +                             "Failed to add fd %d to KVM VFIO device",
> +                             file_fd->fd);
> +            ret = -errno;
> +        }
> +    }
> +    return ret;
> +}
> +
>   #endif
>   
>   void vfio_kvm_device_close(void)
> @@ -137,6 +196,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>           .attr = KVM_DEV_VFIO_FILE_ADD,
>           .addr = (uint64_t)(unsigned long)&fd,
>       };
> +    KVMVfioFileFd *file_fd;
>   
>       if (!kvm_enabled()) {
>           return 0;
> @@ -153,6 +213,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>           }
>   
>           vfio_kvm_device_fd = cd.fd;
> +        /*
> +         * If the vm file descriptor changes, add a notifier so that we can
> +         * re-create the vfio_kvm_device_fd.
> +         */
> +        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
>       }
>   
>       if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> @@ -160,6 +225,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>                            fd);
>           return -errno;
>       }
> +
> +    file_fd = g_malloc0(sizeof(*file_fd));
> +    file_fd->fd = fd;
> +    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
> +

Please introduce a helper routine.


>   #endif
>       return 0;
>   }
> @@ -172,6 +242,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>           .attr = KVM_DEV_VFIO_FILE_DEL,
>           .addr = (uint64_t)(unsigned long)&fd,
>       };
> +    KVMVfioFileFd *file_fd;
>   
>       if (vfio_kvm_device_fd < 0) {
>           error_setg(errp, "KVM VFIO device isn't created yet");
> @@ -183,6 +254,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>                            "Failed to remove fd %d from KVM VFIO device", fd);
>           return -errno;
>       }
> +
> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> +        if (file_fd->fd == fd) {
> +            QLIST_REMOVE(file_fd, node);
> +            g_free(file_fd);
> +            break;
> +        }
> +    }

and a second helper for removal.

Thanks,

C.

>   #endif
>       return 0;
>   }


