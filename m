Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA44BC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXE0-0003vf-DR; Fri, 06 Jun 2025 09:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXDt-0003ui-5l
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXDr-00049m-92
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749216900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZ74hc4iEj411NfV/46/lfwIMMQ4WTft/lCCfGK9Vo0=;
 b=fTw0uzQeaGMVwXbBoPrcs950wSFNpLtHzWIj5SzlwHmRUbc2/uolYRo+M+Lo9PJpUitsRM
 n7u83Xl0nYiaoJJbUKPDl48MdFp3RlhO5SgApQiiOFogzEe8C9OfJG3VN6lEopefuRi3Wv
 Gdh0/MhcwwIKveq+5FRSTlsSKjH4osM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-cg7r87KyMyOJzwV5uPNooQ-1; Fri, 06 Jun 2025 09:34:59 -0400
X-MC-Unique: cg7r87KyMyOJzwV5uPNooQ-1
X-Mimecast-MFC-AGG-ID: cg7r87KyMyOJzwV5uPNooQ_1749216898
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a523ce0bb2so1243835f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749216898; x=1749821698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZ74hc4iEj411NfV/46/lfwIMMQ4WTft/lCCfGK9Vo0=;
 b=PofKUO4k8xUXypKvMZaBYdPP6xVzy0cQ/D3CrOS1UIqgwkGKo6MP+aESSgltKX1TW3
 GzS12XBDz2oyVYDRqB/aGkYQWjIYJuBImGUVerT59SJCJ0yTkQHydBpUG0gktYaJMUwF
 LePfMEJo+oQFdBAKCvQMsCfojxi1mSvHCVgFCuc7Sq771XFgLdAC0ReJb2D6dVHwErDE
 oJwrNmbj/avzmczS2Q6kPN9tdcgvejgzA0xeHLKn/M5RPVV1leNldYrGrJ9MUXKT19eO
 z/gaCowYdkXa9GgNMzUt1bRRJ/oQFdh9Ogg5sQWlu1VR/AfxIIQuwAZxsdZVQyosQ+an
 96aQ==
X-Gm-Message-State: AOJu0YwSBTlt3W6sv3Nk5cSXmNgsCjimr2xGARgRNqUz1+p6PU7Cy5g0
 AIGEMHlVyeKjfvwRwnzlR9QL3deT/ug8Y7oEgy7ye/qXlsuXr84gVe3XQ1IQYkNFoNsEOIGWmQr
 Z/vgTyF4oOxv2M5KejOCFq97aDhh0jD+Y+KKCzFaGy8ALmzVrfnya07LE
X-Gm-Gg: ASbGnctRK3hzw/H+pPElwKu6/0F0OOIKwuE2lSJz32MlbCycT9CqfLP6JzKQrl/abES
 Xxgi6NF1fw7W99edFBpkspgxAKAU1O9vMt4a01cEIOnN57eLk6akoHT/gujxGQO3msNu3WB4GUS
 G/+MCkmhSaW+L+06cCycnRUom0c//5S3P3nG7+v2uqt4lbss+CQ1gjlgm0A2tOWMmAco1wIQqCG
 vr3vRU4XfTj+makizCDqDJKa5oZTVZgxjP6eBpC3c95X3pvD7jtJj5pzedEzIg70iFmwTmLF/8Q
 jmTGsIfihe1RFadacqd3Vw8iFmyP1xgw
X-Received: by 2002:a05:6000:18ab:b0:3a3:7baf:f06a with SMTP id
 ffacd0b85a97d-3a531ce1060mr2698467f8f.37.1749216897820; 
 Fri, 06 Jun 2025 06:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvoC4NGYCkXGuJ3tsDdZySd/58lhnaDHDoozhnfUYtqke6GUp29x88s4mSdDkqM8csOLZrLw==
X-Received: by 2002:a05:6000:18ab:b0:3a3:7baf:f06a with SMTP id
 ffacd0b85a97d-3a531ce1060mr2698453f8f.37.1749216897432; 
 Fri, 06 Jun 2025 06:34:57 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244f0cbsm1875524f8f.81.2025.06.06.06.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:34:57 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:34:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 17/18] hw/pci-bridge/gen_pcie_rp: Remove
 GenPCIERootPort::migrate_msix field
Message-ID: <20250606153455.53803404@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-18-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-18-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu,  1 May 2025 23:04:55 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The GenPCIERootPort::migrate_msix boolean was only set in
> the hw_compat_2_9[] array, via the 'x-migrate-msix=3Dfalse'
> property. We removed all machines using that array, lets
> remove that property and all the code around it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_=
root_port.c
> index d9078e783bf..831d21225e9 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -35,8 +35,6 @@ struct GenPCIERootPort {
>      PCIESlot parent_obj;
>      /*< public >*/
> =20
> -    bool migrate_msix;
> -
>      /* additional resources to reserve */
>      PCIResReserve res_reserve;
>  };
> @@ -66,13 +64,6 @@ static void gen_rp_interrupts_uninit(PCIDevice *d)
>      msix_uninit_exclusive_bar(d);
>  }
> =20
> -static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
> -{
> -    GenPCIERootPort *rp =3D opaque;
> -
> -    return rp->migrate_msix;
> -}
> -
>  static void gen_rp_realize(DeviceState *dev, Error **errp)
>  {
>      PCIDevice *d =3D PCI_DEVICE(dev);
> @@ -121,16 +112,13 @@ static const VMStateDescription vmstate_rp_dev =3D {
>          VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
>          VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
>                         PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> -        VMSTATE_MSIX_TEST(parent_obj.parent_obj.parent_obj.parent_obj,
> -                          GenPCIERootPort,
> -                          gen_rp_test_migrate_msix),
> +        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,
> +                     GenPCIERootPort),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> =20
>  static const Property gen_rp_props[] =3D {
> -    DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort,
> -                     migrate_msix, true),
>      DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort,
>                         res_reserve.bus, -1),
>      DEFINE_PROP_SIZE("io-reserve", GenPCIERootPort,


