Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDC2C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tclsu-00006V-Eg; Tue, 28 Jan 2025 08:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1tclsr-00005z-KJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1tclsp-0004q4-PI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738071842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdWsVQACmhmcAcqZmQ6j+jM0BIX6IrO+WNds52i+6qo=;
 b=Cb9N2SRVtzw9BXtuk2j/W7XOHuhVcobLi97BVf2HvlAtrnAIXaCqdhvj7OdRrFWbbNaBAI
 3OOnrr7K3+yLqOr4qiNdUx4Ogf8G1+pzKA52G3EruAWc1sNXj2RgW7NJBM/XW/afGwfA1R
 w4ukmgF+n9fcjuTwBA7Wd0zL2d9uEKY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Pj_CyjENNLS7Od0hslLBsg-1; Tue, 28 Jan 2025 08:42:40 -0500
X-MC-Unique: Pj_CyjENNLS7Od0hslLBsg-1
X-Mimecast-MFC-AGG-ID: Pj_CyjENNLS7Od0hslLBsg
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3021e171631so28744241fa.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738071757; x=1738676557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZdWsVQACmhmcAcqZmQ6j+jM0BIX6IrO+WNds52i+6qo=;
 b=OgL9rXpkZaw1LlJ7daDrOvqdTPpA6E8Orz0oKWRYeEF6iTtE4yS+lsMX9rwftEcGtV
 LEqO3UKMrftXGzmn044Ao1yJZRVyI91B/NU/KYslSCEe3ZCLpehPo7/v8rCX0HCHeM45
 IwvllDtaOj2Oeyi7+3WxPNIVk/N5kkOgHE3oXSPu7Gvgf94Fp2hxr/ucs+dzqTuWNpUv
 7znCINe+6OKiWf9IBy9B1CKEw09EsTh4UkuEvlb98bd/VRMKEQwr3TjY8umqjaNl0jua
 sc1LrIjNU+kFyZZIgU8g/uo3TC8YAFLm3X/F9lWPoFsPNL7rSWoZTyg8Xo7zn8EhdG8b
 jRcQ==
X-Gm-Message-State: AOJu0YyZ+zK8yy+hrSh/42gU8mxVeOdEGDkidxClNequvh63aRWqpq73
 2u/AnXLFBIcpbHKDeRtjXpV2JYIqxRzeG3gUDjranGxtNUBUZQkT2mlZoxwycdN5inAIVoIshxe
 FaPBL9M3iQjccSlq9Ar2AT7bgV3INqDHQJjI2Ca6Xh4D7qpxTJMMAStcsbFU/kgDAViZQPJj6hn
 uxP5b+vJPzwpOotal7KhuJOJ5zmus=
X-Gm-Gg: ASbGnctvWZvS9EBq86ZsQAif1tWgiGDc80mkDNU4dOPQrveOd2ttFEXt4zIqpAG+k/8
 uMQGTgIzxqm6P1O0vaBvEcBrAPO60owHkwCgkixw2vgTagkf55VzzgenRNRhP6A==
X-Received: by 2002:a2e:2a44:0:b0:300:17a3:7af9 with SMTP id
 38308e7fff4ca-3078dfb6f7dmr9994001fa.19.1738071757030; 
 Tue, 28 Jan 2025 05:42:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFknroAgYs9hmFm7muz2mEaAmJCwDP970pbHE5EPpOiFwgJyTi482tca4GTBJHjTruKxVxcZOGC5zBiBBsoX6g=
X-Received: by 2002:a2e:2a44:0:b0:300:17a3:7af9 with SMTP id
 38308e7fff4ca-3078dfb6f7dmr9993921fa.19.1738071756590; Tue, 28 Jan 2025
 05:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20250115161425.246348-1-arbab@linux.ibm.com>
In-Reply-To: <20250115161425.246348-1-arbab@linux.ibm.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 28 Jan 2025 14:42:25 +0100
X-Gm-Features: AWEUYZnq6gMn4VB5JaMvvZYi2xRe5iwfxEq8tRghLmzt4lLsbPuAWp0VhXzkIu8
Message-ID: <CAMXpfWsCHkWiYsm7_e85e6z8eYZc4s8GkO0FbYXicWM4QQDg9A@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-balloon-pci: Allow setting nvectors, so we can
 use MSI-X
To: Reza Arbab <arbab@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch v2 has been successfully tested in s390x. Here the detailed
test steps:

Boot up a VM already containing a memory object
/home/qemu/build/qemu-system-s390x \
...
-m 4G,maxmem=3D20G \
-object memory-backend-ram,id=3Dmem0,size=3D16G,reserve=3Doff \
...

Check the virtio-balloon
(qemu) info balloon
Error: No balloon device has been activated

Check the PCI devices in the guest
[root@localhost ~]# lspci -v
[root@localhost ~]#

Hotplug a virtio-balloon-pci device and query it again.
(qemu) device_add virtio-balloon-pci,id=3Dballoon0
(qemu) info balloon
balloon: actual=3D4096

Deflate the balloon verify the new size
(qemu) balloon 2048
(qemu) info balloon
balloon: actual=3D2048

Check again the PCI devices in the guest
[root@localhost ~]# lspci -v
0001:00:00.0 Unclassified device [00ff]: Red Hat, Inc. Virtio memory balloo=
n
Subsystem: Red Hat, Inc. Device 0005
Physical Slot: 00000000
Flags: bus master, fast devsel, latency 0, IOMMU group 0
Memory at 4001000000000000 (32-bit, non-prefetchable) [virtual] [size=3D4K]
Memory at 4002000000000000 (64-bit, prefetchable) [size=3D16K]
Capabilities: [98] MSI-X: Enable+ Count=3D2 Masked-
Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
Capabilities: [70] Vendor Specific Information: VirtIO: Notify
Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
Capabilities: [50] Vendor Specific Information: VirtIO: ISR
Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
Kernel driver in use: virtio-pci

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Wed, Jan 15, 2025 at 5:16=E2=80=AFPM Reza Arbab <arbab@linux.ibm.com> wr=
ote:
>
> Most virtio-pci devices allow MSI-X. Add it to virtio-balloon-pci, but
> only enable it in new machine types, so we don't break migration of
> existing machine types between different qemu versions.
>
> This copies what was done for virtio-rng-pci in:
> 9ea02e8f1306 ("virtio-rng-pci: Allow setting nvectors, so we can use MSI-=
X")
> bad9c5a5166f ("virtio-rng-pci: fix migration compat for vectors")
> 62bdb8871512 ("virtio-rng-pci: fix transitional migration compat for vect=
ors")
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
> v2:
> - Remove DEFINE_PROP_END_OF_LIST()
> - Declare virtio_balloon_properties as const
>
>  hw/core/machine.c              |  3 +++
>  hw/virtio/virtio-balloon-pci.c | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c23b39949649..8f396ef8035a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,6 +38,9 @@
>
>  GlobalProperty hw_compat_9_2[] =3D {
>      {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
> +    { "virtio-balloon-pci", "vectors", "0" },
> +    { "virtio-balloon-pci-transitional", "vectors", "0" },
> +    { "virtio-balloon-pci-non-transitional", "vectors", "0" },
>  };
>  const size_t hw_compat_9_2_len =3D G_N_ELEMENTS(hw_compat_9_2);
>
> diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pc=
i.c
> index ce2645ba7187..db7e1cb47537 100644
> --- a/hw/virtio/virtio-balloon-pci.c
> +++ b/hw/virtio/virtio-balloon-pci.c
> @@ -35,11 +35,22 @@ struct VirtIOBalloonPCI {
>      VirtIOBalloon vdev;
>  };
>
> +static const Property virtio_balloon_properties[] =3D {
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +};
> +
>  static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error *=
*errp)
>  {
>      VirtIOBalloonPCI *dev =3D VIRTIO_BALLOON_PCI(vpci_dev);
>      DeviceState *vdev =3D DEVICE(&dev->vdev);
>
> +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors =3D 2;
> +    }
> +
>      vpci_dev->class_code =3D PCI_CLASS_OTHERS;
>      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>  }
> @@ -55,6 +66,7 @@ static void virtio_balloon_pci_class_init(ObjectClass *=
klass, void *data)
>      pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_BALLOON;
>      pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
>      pcidev_k->class_id =3D PCI_CLASS_OTHERS;
> +    device_class_set_props(dc, virtio_balloon_properties);
>  }
>
>  static void virtio_balloon_pci_instance_init(Object *obj)
>
> base-commit: 7433709a147706ad7d1956b15669279933d0f82b
> --
> 2.47.1
>
>


