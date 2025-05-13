Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B9AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmvB-00076t-Ts; Tue, 13 May 2025 06:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEmvA-000714-5f
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEmv8-0001vI-CA
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747132293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8iuDoVUKmba4R8nSTe6+wX/Mku81yEFf9qrmeNuvU0=;
 b=QLcFMf+yZDv1/QEUGEenOtZEZFXoC3bWknClehaxfD4BDB4u86KJ6SqqnhszERP7WoV6M2
 l8JgGO8dDY3VOABSeLA5rLutvQhmFwoBbx/8IOiab0u70ChQWfayI9T5uEX6uZuUpmUK3b
 One9MHUCQ22hjPxLo1k3ObiisQ5njJI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-wCrGJwYtMdOzrtLA9Cezow-1; Tue, 13 May 2025 06:30:18 -0400
X-MC-Unique: wCrGJwYtMdOzrtLA9Cezow-1
X-Mimecast-MFC-AGG-ID: wCrGJwYtMdOzrtLA9Cezow_1747132217
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so35830795e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747132217; x=1747737017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8iuDoVUKmba4R8nSTe6+wX/Mku81yEFf9qrmeNuvU0=;
 b=LFG1z1xBKgInRZThvqEmf/V29sJLtOFjcC5zffMFDKtwqnvpzif/1WPNzA6Mi6Tuxz
 p77zIeDjJLQOl+wuBTwcID8WFlvz43x3CW11HVb8IG8Q5T0kUlntvynH+qDtfoKxXQ/p
 bj6i00eur1t8GUVR0MVfE+cbkksYCvARxrdO1MXwMVVFR+CSq6ms18yjAEuUZBWU6DIE
 NRUXVbURMk8zrwU2gUP0/a2uPkKtgsaVEr+R/YWXkA55klK3L3/Ob+q5bhTs7FYgM8Fq
 3eZn4kYsvtmCbPGTPEo+CXEOI/l+Ks7u2lnYpnzO0qlX6EN9amyAfVWHimkTiZlAVxOk
 xXow==
X-Gm-Message-State: AOJu0YwPMZAWb94LSeic6Y/M6QObWeKHKqfb1N9WOPp1cUAkttdGgxHg
 pI+T/cD99eXK6ezYDDaEgS7jSirrzzuO4T7/5ZnG/4TwzNQsJnY5k+EOVyLUVSbBZCInS9ekwug
 wR+MUhvjVNKKi40YAn9zdQWaI+OUoc7OEhVfexR7tsxxs8/gsC6xu
X-Gm-Gg: ASbGncvWGfcsMUuTOIXxRN1uqNitldfHLPaXO176m+cD5z3renhwEbkVvQNofqgIM5y
 hda3l0g/DZWtTU7xox5XSUySWYU1YlOYRalRiHgVZiVBfxwZIbccmlXZ1O+6Vu9x7nHDyuFjOh7
 Y+zhX65Ma5Belkkj22VKWH3xxiAMc6bpewIolT6UhZBXs4Bifv5pBwP1QBLuK74uKV5BSko6Udc
 gFamp7+eE1X6lmsAUNOWVknSTAN+pBtuxZ+gtr2Z5qmZrkdTPf0JnEywoTYM0iJRrh6+IJl2ABA
 hUbnKsYMQADV6VxnuqcjkliD96vdNHs2
X-Received: by 2002:a05:600c:3e8c:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-442d6ddec16mr137058875e9.29.1747132217491; 
 Tue, 13 May 2025 03:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWH2SlPJhTSYnfcP8ynqc1cV83KOO/vg2sWk6ss3ErHbO0veyJed2wklFPjNGmKZ6c9j4PTQ==
X-Received: by 2002:a05:600c:3e8c:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-442d6ddec16mr137058455e9.29.1747132217110; 
 Tue, 13 May 2025 03:30:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aecb0sm208576865e9.28.2025.05.13.03.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 03:30:16 -0700 (PDT)
Date: Tue, 13 May 2025 12:30:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v4 25/27] hw/virtio/virtio-pci: Remove
 VirtIOPCIProxy::ignore_backend_features field
Message-ID: <20250513123014.763837de@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-26-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-26-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  8 May 2025 15:35:48 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The VirtIOPCIProxy::ignore_backend_features boolean was only set
> in the hw_compat_2_7[] array, via the 'x-ignore-backend-features=3Don'
> property. We removed all machines using that array, lets remove
> that property, simplify by only using the default version.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/virtio/virtio-pci.h | 1 -
>  hw/virtio/virtio-pci.c         | 5 +----
>  2 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pc=
i.h
> index f962c9116c1..9838e8650a6 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -149,7 +149,6 @@ struct VirtIOPCIProxy {
>      int config_cap;
>      uint32_t flags;
>      bool disable_modern;
> -    bool ignore_backend_features;
>      OnOffAuto disable_legacy;
>      /* Transitional device id */
>      uint16_t trans_devid;
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 8d68e56641a..7c965771907 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1965,8 +1965,7 @@ static void virtio_pci_device_plugged(DeviceState *=
d, Error **errp)
>       * Virtio capabilities present without
>       * VIRTIO_F_VERSION_1 confuses guests
>       */
> -    if (!proxy->ignore_backend_features &&
> -            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)=
) {
> +    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
>          virtio_pci_disable_modern(proxy);
> =20
>          if (!legacy) {
> @@ -2351,8 +2350,6 @@ static const Property virtio_pci_properties[] =3D {
>                      VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
>      DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
> -    DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
> -                     ignore_backend_features, false),
>      DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_ATS_BIT, false),
>      DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,


