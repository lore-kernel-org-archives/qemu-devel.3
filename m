Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148A5CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 08:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvWol-0007Wb-9Q; Mon, 08 Sep 2025 04:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uvWoG-0007U6-Tm
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 04:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uvWo0-0007I6-63
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 04:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757318437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ja+3yR70Q+hQ4a+9Yh37JwEh7Nyhn+eAqeAhiE65AcY=;
 b=CoZJxK1W3Ji5BWyi1yF8vwTgWaBKg8VoGo2p8DNlpw6ugE4uyaR57uiyMFSQbI1pz+aWkf
 UWR0eyI82420+DiC56LZTujeW/NthrofWCYIhs4QPcI9Fyrm3WVk/CCTB01XzJZIxbUPee
 5LBQt2QgGwbH+wg0jgHV8Ce7+e15Q1Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-fiFgSisMON-ltZJlXBBq_Q-1; Mon, 08 Sep 2025 04:00:35 -0400
X-MC-Unique: fiFgSisMON-ltZJlXBBq_Q-1
X-Mimecast-MFC-AGG-ID: fiFgSisMON-ltZJlXBBq_Q_1757318435
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329ee69e7deso3988728a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 01:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757318435; x=1757923235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ja+3yR70Q+hQ4a+9Yh37JwEh7Nyhn+eAqeAhiE65AcY=;
 b=P6bZypWldQfxiorHnwZshLshtB+XsSxJWnFW7zkWPjhRFv6bC8IrLaXvKfPoQaapA0
 XQlxjiopBEnvcTPRVAS2hRHSWbwEYN9+jgIoR9RAOrIlE6t62zu6UcJ6sLe0h/TCWPUc
 /keMpVc6ydxRyN/eTizfhIIx6zOS/LgHNF9z+kzdg6j+ENI+Y6aJ0/5W2i0VreoekFZ7
 wy8drhx9KDGWaPXIBH4XoysDYr+/W8GKcJE0KorYGuY1ZO+owNGunaSaKNlq7QXfcqmo
 p/0Kdew+MAz+DpeDhMxFcPI3/ujURtlUtvxhe16/C2eXDgYAf6Sf2JD9MOY6Nj3/VM15
 /gHQ==
X-Gm-Message-State: AOJu0YyqhA7qy81aR/Xc69JNeGO3dqRXau4+dVvZrPDvh8GNU9K2px+d
 U555hn+Aw8jBZxPX8aydxTf8nFg02Ykdkz2XdYdpWNbphKGLOlOirV6zHOTa7nTbRkcPGWQ+rTQ
 Rbg1X6adf59WQXqoNd55nB62QVGRrgWzvcdiDbQFfAgNUeV+BaBYWiGlCmmIoVcr9E6gZYtaq4x
 mI+RYtED61UEBqDGaEVLo9If+q6G+6GSc=
X-Gm-Gg: ASbGnctYQtdHKui9mi66fms425M6Me2xhXK0a3UhEUgKgd8vm1DiXxzfS+QHLZKi+q/
 K/WJd+0d5ERBvg3hAxm4BJAS96mLsX4Q8Y+3z3Iag4DQjnlVFCOYQu+KjZxc0BE5iVFXw7jzPXJ
 tq8FCgL7AgvFrPIios
X-Received: by 2002:a17:90b:1c12:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-32d43fb9c1emr9150022a91.37.1757318434493; 
 Mon, 08 Sep 2025 01:00:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf19YkQCQi5jQyEATU+7wrMGSgX4vmC7DGEWqsdATl+D+obREmVAxvZPwatGFp0MTsla2mqQyEHFz/U6RwAmw=
X-Received: by 2002:a17:90b:1c12:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-32d43fb9c1emr9149958a91.37.1757318433849; Mon, 08 Sep 2025
 01:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250901105948.982583-1-alex.bennee@linaro.org>
In-Reply-To: <20250901105948.982583-1-alex.bennee@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 8 Sep 2025 10:00:22 +0200
X-Gm-Features: AS18NWD2tope3iQLnoo740cUHqt8xp1Fkp28hSFRH4PTbstoqybq4uG3btwmR6w
Message-ID: <CADSE00Jio7_06cS42CDcsHuGqp2t_Gbxw_S643ykyaJSVwb-pA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/virtio: rename vhost-user-device and make user
 creatable
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 1, 2025 at 1:01=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> We didn't make the device user creatable in the first place because we
> were worried users might get confused. Rename the device to make its
> nature as a test device even more explicit. While we are at it add a
> Kconfig variable so it can be skipped for those that want to thin out
> their build configuration even further.
>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-ID: <20250820195632.1956795-1-alex.bennee@linaro.org>
>
> ---
> v1
>   - add review tags, ready to merge
> v2
>   - keep the -base name on TYPE_VHOST_USER_TEST_DEVICE_PCI
> ---
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

Thanks for the patch, the changes look good to me!

This seems like a great opportunity to have tests using this device.
What are your thoughts on also adding a QTest that instantiates this
test device? It could potentially go in vhost-user-test.c or a new
file to verify the generic vhost-user functionality.

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
> index f10bac874e7..b4ed0efb50f 100644
> --- a/hw/virtio/vhost-user-device-pci.c
> +++ b/hw/virtio/vhost-user-test-device-pci.c
> @@ -18,13 +18,13 @@ struct VHostUserDevicePCI {
>      VHostUserBase vub;
>  };
>
> -#define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> +#define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci-base=
"
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


