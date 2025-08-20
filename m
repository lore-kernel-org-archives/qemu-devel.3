Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5233FCA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 20:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoppB-0000W9-Vb; Wed, 20 Aug 2025 16:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uopp8-0000Vh-OZ
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:54:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uopp6-0001pa-Fq
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:54:22 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61868d83059so2405360a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755723258; x=1756328058; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/7ZIznsp4+zzPNuB98P2wZda4folxrfP1xoYrA30R0=;
 b=G3iG7il2xYptZQUIZnZq3o7t5M3Y8Jsw8s5bR99bq8TeT/EwKdUnaIG4NDUT8y0HDa
 BlIj1Yb8XADVXGJ6XSRVwW1vR1ByaFYMfmzI75uqn1eMs20WhyS8S415u1oTp04XK2gT
 vUnK8J5D6zj/TvnE3XQfm/QfJE2sMozb/EgEeFVpzj2jergYcRej7kXiAcYsjye5sVkg
 9F33ElXyRNSsjonfRvn/ajfVflsJT0pOrKDbKD3DQXyFuvqvA3KXWVfpq+3+2YevjmZJ
 nkQd+qA+S75YdgMWErm4Tsjiv3fuqQtDAJbyMs5jec336xa0nobtozAg8yGyAb14kC0B
 rQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755723258; x=1756328058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/7ZIznsp4+zzPNuB98P2wZda4folxrfP1xoYrA30R0=;
 b=sZIzWOaOy582Z/yxZwx5XDmci7zA8ZJzANAmoIslFLloN81dUKG03XwINkwWgMyggc
 ce6HYzshM7+N3CaV37WopPcyNElELaZEm26VA6gIg6GxrdIgNmvjere6qJOkjT8bH5Zw
 /QEAGDVMrFQmh/vQ39sjGCwrlYOaH8e9MCnahF+dyaWSLzHOo9TAaD6+xVB/6Yux39hu
 v558jXuH6yJ1YrXlHNTPldfI3bipV2LpWZfVbx/LKSg/SMosbUDVr7ylQUDgqmZRd15+
 N9wY/wuZ3yDhFPTGQRkE2Caljd+nTNoEwNssW6yrvUZ2Kl5RbuGQerXs37xg+E9OzR8k
 1MoA==
X-Gm-Message-State: AOJu0YwR5YMFOgFwIz12mf2JKsMhCxl9mkyRUig5sozyzczNqPnzWfCz
 8jWLmWDLrERFgKJeBxqCbuqC9W+KN2rF4PK5EPYpIUVGNMO32H6Qyu/lOSMcMkmQkJ1NnIvGOTE
 Yr8CGVGZ07XTOnArcGeS2Tfc16zPG47XcyaF1VXlO3Q==
X-Gm-Gg: ASbGncsZR/KYfCozX3uEjZMQE0uePZZMkwl4CuC7Ts1Cn5dcJaICjvD2xGgGplmnOBf
 aMmpaZZ54eiAW1yNMgqGh8XjEx5pLbJt02kZcVS70AScz6cwpPvTEVfpeT7QlhBJ/G6xanrbIQM
 FV2h7oZbr4F0Hu5HV7e2riIqP67cgN1xcgYrQijYtNuATEPx4b1XBJbTxZXLt4u/6jzYZwbB8xE
 49lndXH
X-Google-Smtp-Source: AGHT+IEuQJwIZMoc/DE7+0lSf9X32N/VJk7jKe26HQqE4hIyvCvD+NEFuTvBQGgn0AH+xw035fogur1gFnvCrMvc2Vo=
X-Received: by 2002:a17:906:d542:b0:afd:f9a7:418f with SMTP id
 a640c23a62f3a-afe02a85682mr69031466b.1.1755723258221; Wed, 20 Aug 2025
 13:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250820195632.1956795-1-alex.bennee@linaro.org>
In-Reply-To: <20250820195632.1956795-1-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 20 Aug 2025 23:53:52 +0300
X-Gm-Features: Ac12FXzHCUsI4DmAJTGxIQ01eqT1VrDhIfB6fhkDEPkggXzlNhj_gu2T1SJkcpI
Message-ID: <CAAjaMXZf6t6RSa_3xbL2LLbH30wc4WTWCYztJwHpFwAW-WirpQ@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/virtio: rename vhost-user-device and make user
 creatable
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 20, 2025 at 10:57=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
> We didn't make the device user creatable in the first place because we
> were worried users might get confused. Rename the device to make its
> nature as a test device even more explicit. While we are at it add a
> Kconfig variable so it can be skipped for those that want to thin out
> their build configuration even further.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  docs/system/devices/vhost-user.rst            | 20 +++++++------------
>  include/hw/virtio/vhost-user-base.h           |  2 +-
>  ...ice-pci.c =3D> vhost-user-test-device-pci.c} | 17 +++++++---------
>  ...user-device.c =3D> vhost-user-test-device.c} |  9 +++------
>  hw/virtio/Kconfig                             |  5 +++++
>  hw/virtio/meson.build                         |  5 +++--
>  6 files changed, 26 insertions(+), 32 deletions(-)
>  rename hw/virtio/{vhost-user-device-pci.c =3D> vhost-user-test-device-pc=
i.c} (77%)
>  rename hw/virtio/{vhost-user-device.c =3D> vhost-user-test-device.c} (87=
%)
>
> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vho=
st-user.rst
> index 35259d8ec7c..bddf8df5ed5 100644
> --- a/docs/system/devices/vhost-user.rst
> +++ b/docs/system/devices/vhost-user.rst
> @@ -62,26 +62,20 @@ platform details for what sort of virtio bus to use.
>  The referenced *daemons* are not exhaustive, any conforming backend
>  implementing the device and using the vhost-user protocol should work.
>
> -vhost-user-device
> -^^^^^^^^^^^^^^^^^
> +vhost-user-test-device
> +^^^^^^^^^^^^^^^^^^^^^^
>
> -The vhost-user-device is a generic development device intended for
> -expert use while developing new backends. The user needs to specify
> -all the required parameters including:
> +The vhost-user-test-device is a generic development device intended
> +for expert use while developing new backends. The user needs to
> +specify all the required parameters including:
>
>    - Device ``virtio-id``
>    - The ``num_vqs`` it needs and their ``vq_size``
>    - The ``config_size`` if needed
>
>  .. note::
> -  To prevent user confusion you cannot currently instantiate
> -  vhost-user-device without first patching out::
> -
> -    /* Reason: stop inexperienced users confusing themselves */
> -    dc->user_creatable =3D false;
> -
> -  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
> -  rebuilding.
> +  While this is a useful device for development it is not recommended
> +  for production use.
>
>  vhost-user daemon
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhos=
t-user-base.h
> index 51d0968b893..387e434b804 100644
> --- a/include/hw/virtio/vhost-user-base.h
> +++ b/include/hw/virtio/vhost-user-base.h
> @@ -44,6 +44,6 @@ struct VHostUserBaseClass {
>  };
>
>
> -#define TYPE_VHOST_USER_DEVICE "vhost-user-device"
> +#define TYPE_VHOST_USER_TEST_DEVICE "vhost-user-test-device"
>
>  #endif /* QEMU_VHOST_USER_BASE_H */
> diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-tes=
t-device-pci.c
> similarity index 77%
> rename from hw/virtio/vhost-user-device-pci.c
> rename to hw/virtio/vhost-user-test-device-pci.c
> index f10bac874e7..d6a9ca2101d 100644
> --- a/hw/virtio/vhost-user-device-pci.c
> +++ b/hw/virtio/vhost-user-test-device-pci.c
> @@ -18,13 +18,13 @@ struct VHostUserDevicePCI {
>      VHostUserBase vub;
>  };
>
> -#define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> +#define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci"
>
> -OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
> +OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_TEST_DEVICE_PC=
I)
>
>  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Erro=
r **errp)
>  {
> -    VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> +    VHostUserDevicePCI *dev =3D VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
>      DeviceState *vdev =3D DEVICE(&dev->vub);
>
>      vpci_dev->nvectors =3D 1;
> @@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClas=
s *klass,
>      VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
>      PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
>
> -    /* Reason: stop users confusing themselves */
> -    dc->user_creatable =3D false;
> -
>      k->realize =3D vhost_user_device_pci_realize;
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>      pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> @@ -51,15 +48,15 @@ static void vhost_user_device_pci_class_init(ObjectCl=
ass *klass,
>
>  static void vhost_user_device_pci_instance_init(Object *obj)
>  {
> -    VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(obj);
> +    VHostUserDevicePCI *dev =3D VHOST_USER_TEST_DEVICE_PCI(obj);
>
>      virtio_instance_init_common(obj, &dev->vub, sizeof(dev->vub),
> -                                TYPE_VHOST_USER_DEVICE);
> +                                TYPE_VHOST_USER_TEST_DEVICE);
>  }
>
>  static const VirtioPCIDeviceTypeInfo vhost_user_device_pci_info =3D {
> -    .base_name =3D TYPE_VHOST_USER_DEVICE_PCI,
> -    .non_transitional_name =3D "vhost-user-device-pci",
> +    .base_name =3D TYPE_VHOST_USER_TEST_DEVICE_PCI,
> +    .non_transitional_name =3D "vhost-user-test-device-pci",
>      .instance_size =3D sizeof(VHostUserDevicePCI),
>      .instance_init =3D vhost_user_device_pci_instance_init,
>      .class_init =3D vhost_user_device_pci_class_init,
> diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-test-de=
vice.c
> similarity index 87%
> rename from hw/virtio/vhost-user-device.c
> rename to hw/virtio/vhost-user-test-device.c
> index 3939bdf7552..1b98ea3e488 100644
> --- a/hw/virtio/vhost-user-device.c
> +++ b/hw/virtio/vhost-user-test-device.c
> @@ -1,5 +1,5 @@
>  /*
> - * Generic vhost-user-device implementation for any vhost-user-backend
> + * Generic vhost-user-test-device implementation for any vhost-user-back=
end
>   *
>   * This is a concrete implementation of vhost-user-base which can be
>   * configured via properties. It is useful for development and
> @@ -25,7 +25,7 @@
>   */
>
>  static const VMStateDescription vud_vmstate =3D {
> -    .name =3D "vhost-user-device",
> +    .name =3D "vhost-user-test-device",
>      .unmigratable =3D 1,
>  };
>
> @@ -41,16 +41,13 @@ static void vud_class_init(ObjectClass *klass, const =
void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    /* Reason: stop inexperienced users confusing themselves */
> -    dc->user_creatable =3D false;
> -
>      device_class_set_props(dc, vud_properties);
>      dc->vmsd =3D &vud_vmstate;
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>
>  static const TypeInfo vud_info =3D {
> -    .name =3D TYPE_VHOST_USER_DEVICE,
> +    .name =3D TYPE_VHOST_USER_TEST_DEVICE,
>      .parent =3D TYPE_VHOST_USER_BASE,
>      .class_init =3D vud_class_init,
>  };
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 7648a2d68da..10f5c53ac09 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -126,3 +126,8 @@ config VHOST_USER_SCMI
>      bool
>      default y
>      depends on VIRTIO && VHOST_USER && ARM
> +
> +config VHOST_USER_TEST
> +    bool
> +    default y
> +    depends on VIRTIO && VHOST_USER
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 3ea7b3cec83..48b9fedfa56 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -22,7 +22,7 @@ if have_vhost
>      system_virtio_ss.add(files('vhost-user-base.c'))
>
>      # MMIO Stubs
> -    system_virtio_ss.add(files('vhost-user-device.c'))
> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_TEST', if_true: files(=
'vhost-user-test-device.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files(=
'vhost-user-gpio.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('=
vhost-user-i2c.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('=
vhost-user-rng.c'))
> @@ -30,7 +30,8 @@ if have_vhost
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files=
('vhost-user-input.c'))
>
>      # PCI Stubs
> -    system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhos=
t-user-device-pci.c'))
> +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_=
TEST'],
> +                         if_true: files('vhost-user-test-device-pci.c'))
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_=
GPIO'],
>                           if_true: files('vhost-user-gpio-pci.c'))
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_=
I2C'],
> --
> 2.47.2
>
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

