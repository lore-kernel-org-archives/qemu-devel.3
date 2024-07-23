Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1672C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9W7-0008Ok-UD; Tue, 23 Jul 2024 03:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sW9W7-0008OH-1I
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sW9W4-0000RV-Ql
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718054;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFl3HrwLjoySraknE8EuzIsY/PKufmEFbFHCeaLFeYM=;
 b=KHuBPdvG3eW/8TawW0LaLc1BYzTfwllxhn2J5GxY4mte9gHQ0+mjLViW0e0DePULhgjcom
 l4oiNC1tgEM6Z5QH8h6VOBVN+4fmjPTRh59FPWM5n668jaDaMPD8vszQBPsXtpPvAcEak9
 ITVVO49PpzLqCF7FXgi7HahOsXEsrME=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-4tD9g351MY2Nr8m0cI7y9g-1; Tue, 23 Jul 2024 03:00:51 -0400
X-MC-Unique: 4tD9g351MY2Nr8m0cI7y9g-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79f19f19b11so718693585a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721718051; x=1722322851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFl3HrwLjoySraknE8EuzIsY/PKufmEFbFHCeaLFeYM=;
 b=gg/ytc0EYlPK4cek1kOJO89K0uw475bNcmN4yW7A2hwXi+PZw0SJZBeLeGPpKWFG6M
 0dPUUuDDyLqk8GE1ScMar9JCvbYCZJwoAFe8NbbedZxeBS3DD8uU4iQntR5cKANVWrfA
 PenKIuy/qWF+MGXNjd1gjvVWkHtSpyJdCj7Pcf5k2SMNo7SFwhPi/qaiF6sZEa/KFjOT
 yIok/DEb0Gy4qhJlVwrTcDRwPwklD2E8JsNseQ+izC1mq9oLraFstAi32PCcPhEmxMea
 6vPLeMdlSnIoB4G7XkHsMhI0Qu7HKWsBVLi1cQNeWqYigDSA51khuC9Mhjn3iCFRki0i
 19kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrWNK6/IlZ0+F4v0snwEnJGtyLAbgSEG/ASgObgBvGE8QOFqK8OLj/bqeCqCeS7Z8n8GlObv/fIUiTaIrNdOfO0w5414U=
X-Gm-Message-State: AOJu0Yx8N9GblNNF7MKUwlxxgfAp7NVIp74KfWyxQKD1W/+PqToLWI/j
 VvwFOkISR4rnSlZ7vrOwX/my7WMBj6IeXWltwDvyKMBe3xc01/7svjyuU9bymYthynC642hhOW6
 6tcP2y/6Htzz/2wzIZ+lQDAlzTYtXJqq5SrjPy6wRNR6dpFf7tLvL
X-Received: by 2002:ad4:574e:0:b0:6b7:a7b7:de9b with SMTP id
 6a1803df08f44-6b98192b449mr27583286d6.20.1721718050926; 
 Tue, 23 Jul 2024 00:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaCh794YKi6Z3rcVVxFy13yO9HITLNgjKeS2Deve3pWLGrskD45GhL3RPqdjxhJOYod3Bd8Q==
X-Received: by 2002:ad4:574e:0:b0:6b7:a7b7:de9b with SMTP id
 6a1803df08f44-6b98192b449mr27582876d6.20.1721718050472; 
 Tue, 23 Jul 2024 00:00:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac7e9fffsm43556976d6.63.2024.07.23.00.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:00:49 -0700 (PDT)
Message-ID: <50cf5507-ca71-47ac-bc24-8845982b99ad@redhat.com>
Date: Tue, 23 Jul 2024 09:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/13] vfio/pci: Extract mdev check into an helper
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-2-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240719120501.81279-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/19/24 14:04, Joao Martins wrote:
> In preparation to skip initialization of the HostIOMMUDevice for mdev,
> extract the checks that validate if a device is an mdev into helpers.
>
> A vfio_device_is_mdev() is created, and subsystems consult VFIODevice::mdev
> to check if it's mdev or not.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/vfio/helpers.c             | 14 ++++++++++++++
>  hw/vfio/pci.c                 | 12 +++---------
>  3 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e8ddf92bb185..98acae8c1c97 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -116,6 +116,7 @@ typedef struct VFIODevice {
>      DeviceState *dev;
>      int fd;
>      int type;
> +    bool mdev;
>      bool reset_works;
>      bool needs_reset;
>      bool no_mmap;
> @@ -231,6 +232,7 @@ void vfio_region_exit(VFIORegion *region);
>  void vfio_region_finalize(VFIORegion *region);
>  void vfio_reset_handler(void *opaque);
>  struct vfio_device_info *vfio_get_device_info(int fd);
> +bool vfio_device_is_mdev(VFIODevice *vbasedev);
>  bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                          AddressSpace *as, Error **errp);
>  void vfio_detach_device(VFIODevice *vbasedev);
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index b14edd46edc9..7e23e9080c9d 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -675,3 +675,17 @@ int vfio_device_get_aw_bits(VFIODevice *vdev)
>  
>      return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
>  }
> +
> +bool vfio_device_is_mdev(VFIODevice *vbasedev)
> +{
> +    g_autofree char *subsys = NULL;
> +    g_autofree char *tmp = NULL;
> +
> +    if (!vbasedev->sysfsdev) {
> +        return false;
> +    }
> +
> +    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
> +    subsys = realpath(tmp, NULL);
> +    return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e03d9f3ba546..b34e91468a53 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2963,12 +2963,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      ERRP_GUARD();
>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>      VFIODevice *vbasedev = &vdev->vbasedev;
> -    char *subsys;
>      int i, ret;
> -    bool is_mdev;
>      char uuid[UUID_STR_LEN];
>      g_autofree char *name = NULL;
> -    g_autofree char *tmp = NULL;
>  
>      if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>          if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -2997,14 +2994,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       * stays in sync with the active working set of the guest driver.  Prevent
>       * the x-balloon-allowed option unless this is minimally an mdev device.
>       */
> -    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
> -    subsys = realpath(tmp, NULL);
> -    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
> -    free(subsys);
> +    vbasedev->mdev = vfio_device_is_mdev(vbasedev);
>  
> -    trace_vfio_mdev(vbasedev->name, is_mdev);
> +    trace_vfio_mdev(vbasedev->name, vbasedev->mdev);
>  
> -    if (vbasedev->ram_block_discard_allowed && !is_mdev) {
> +    if (vbasedev->ram_block_discard_allowed && !vbasedev->mdev) {
>          error_setg(errp, "x-balloon-allowed only potentially compatible "
>                     "with mdev devices");
>          goto error;


