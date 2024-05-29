Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD05C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJAE-0001m7-3V; Wed, 29 May 2024 09:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJAC-0001k4-PD
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJAB-0004DX-2p
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716988578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APT3KEyKu0SwI7IlkMP4Pbut9W49r+Ap4Km2fcuRGSY=;
 b=ZnGrV5oX0nbBK1T68Vdw78ET2+ygTHgdPrTndu4yUii30Qhbx2oOTcSfQ9d2uHHA4lERQo
 svojzGybBtxXcdvGbS1nk1XUNHyp/OuuW3T4YzAYR7iICPA/HmsXMDDgDbvuL3hsoQ1wMb
 zWNymZRH2u58t1Sk6Ub3aWBBFZZwIv8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-LsnPwoVsOGOflNqklHXpxA-1; Wed, 29 May 2024 09:16:16 -0400
X-MC-Unique: LsnPwoVsOGOflNqklHXpxA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4201f100188so11616755e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716988573; x=1717593373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APT3KEyKu0SwI7IlkMP4Pbut9W49r+Ap4Km2fcuRGSY=;
 b=UjH5CR4Qy3er2HyDn9tslPHIqoCyfNyw0d3S8bcIewGBQa6xX0pbXkFYorpz3a+U/8
 dujxaMmY6Ii5kk+8Qa+Yu7KPV7S9ORa19DDcEKdHmpyAAUWaNxdntJt9aL5+9aZTFGO6
 goS1uePeEbPBKpLqCHoxI4cEgtbwI6O02RodiUMYQr+paeB55xSnoDJQJx7tISdj+Byq
 NDOWSPn3GHbggv2XCGO1sVblKShO7kHn8c9QRGgYAqV3fM96423gHLK/8MxNg1siIMoe
 hC20xD5uSge0Dvfh3Q5bO+diGzUDHiXG+uzy4pzdlsFn2WVSIDy9zmMsHahd40883WdB
 cUJQ==
X-Gm-Message-State: AOJu0Yx80F2zy1vn6rS3c3Uu9OvHNrcdFH8scMjhaB7AUD1GMvFdu2Bz
 R3hHwxc9m3NUMvMdw8Do/v4zpQX/e126i6bzTTFVN7iye6RWKiZhFAFfFdW/WRGlO4i4dp4DFra
 l5Mlf+6SwXjW8Cl7YCYDIslGLVN1GW4SN9XUhCCZeXskP4+ERqqn0KYfDNeYy
X-Received: by 2002:a7b:cb90:0:b0:41f:ef1e:7312 with SMTP id
 5b1f17b1804b1-421089f4f38mr102268225e9.14.1716988573487; 
 Wed, 29 May 2024 06:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE95n9EDnu+LFZGujLiuI/4hDLhYf9AO5RGUOLlfkMFrcFtjyzLJgR163Qd1RSvMemj4yRg5w==
X-Received: by 2002:a7b:cb90:0:b0:41f:ef1e:7312 with SMTP id
 5b1f17b1804b1-421089f4f38mr102268015e9.14.1716988573122; 
 Wed, 29 May 2024 06:16:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f598d7sm208768225e9.23.2024.05.29.06.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 06:16:08 -0700 (PDT)
Date: Wed, 29 May 2024 15:16:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 04/23] hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
Message-ID: <20240529151606.143932db@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-5-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-5-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 29 May 2024 07:15:20 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> XHCI_FLAG_SS_FIRST was only used by the pc-i440fx-2.0 machine,
> which got removed. Remove it and simplify various functions in
> hcd-xhci.c.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/usb/hcd-xhci.h     |  3 +--
>  hw/usb/hcd-xhci-nec.c |  2 --
>  hw/usb/hcd-xhci-pci.c |  1 -
>  hw/usb/hcd-xhci.c     | 42 ++++++++----------------------------------
>  4 files changed, 9 insertions(+), 39 deletions(-)
>=20
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 1efa4858fb..fe16d7ad05 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -36,8 +36,7 @@ typedef struct XHCIStreamContext XHCIStreamContext;
>  typedef struct XHCIEPContext XHCIEPContext;
> =20
>  enum xhci_flags {
> -    XHCI_FLAG_SS_FIRST =3D 1,
> -    XHCI_FLAG_ENABLE_STREAMS,
> +    XHCI_FLAG_ENABLE_STREAMS =3D 1,
>  };
> =20
>  typedef enum TRBType {
> diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
> index 5d5b069cf9..0c063b3697 100644
> --- a/hw/usb/hcd-xhci-nec.c
> +++ b/hw/usb/hcd-xhci-nec.c
> @@ -41,8 +41,6 @@ struct XHCINecState {
>  static Property nec_xhci_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO=
),
> -    DEFINE_PROP_BIT("superspeed-ports-first", XHCINecState, flags,
> -                    XHCI_FLAG_SS_FIRST, true),
>      DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
>      DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index cbad96f393..264d7ebb77 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -242,7 +242,6 @@ static void qemu_xhci_instance_init(Object *obj)
>      s->msix     =3D ON_OFF_AUTO_AUTO;
>      xhci->numintrs =3D XHCI_MAXINTRS;
>      xhci->numslots =3D XHCI_MAXSLOTS;
> -    xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
>  }
> =20
>  static const TypeInfo qemu_xhci_info =3D {
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ad40232eb6..b6411f0bda 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -541,18 +541,10 @@ static XHCIPort *xhci_lookup_port(XHCIState *xhci, =
struct USBPort *uport)
>      case USB_SPEED_LOW:
>      case USB_SPEED_FULL:
>      case USB_SPEED_HIGH:
> -        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
> -            index =3D uport->index + xhci->numports_3;
> -        } else {
> -            index =3D uport->index;
> -        }
> +        index =3D uport->index + xhci->numports_3;
>          break;
>      case USB_SPEED_SUPER:
> -        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
> -            index =3D uport->index;
> -        } else {
> -            index =3D uport->index + xhci->numports_2;
> -        }
> +        index =3D uport->index;
>          break;
>      default:
>          return NULL;
> @@ -2779,11 +2771,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr re=
g, unsigned size)
>          ret =3D 0x20425355; /* "USB " */
>          break;
>      case 0x28: /* Supported Protocol:08 */
> -        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
> -            ret =3D (xhci->numports_2<<8) | (xhci->numports_3+1);
> -        } else {
> -            ret =3D (xhci->numports_2<<8) | 1;
> -        }
> +        ret =3D (xhci->numports_2 << 8) | (xhci->numports_3 + 1);
>          break;
>      case 0x2c: /* Supported Protocol:0c */
>          ret =3D 0x00000000; /* reserved */
> @@ -2795,11 +2783,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr re=
g, unsigned size)
>          ret =3D 0x20425355; /* "USB " */
>          break;
>      case 0x38: /* Supported Protocol:08 */
> -        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
> -            ret =3D (xhci->numports_3<<8) | 1;
> -        } else {
> -            ret =3D (xhci->numports_3<<8) | (xhci->numports_2+1);
> -        }
> +        ret =3D (xhci->numports_3 << 8) | 1;
>          break;
>      case 0x3c: /* Supported Protocol:0c */
>          ret =3D 0x00000000; /* reserved */
> @@ -3349,13 +3333,8 @@ static void usb_xhci_init(XHCIState *xhci)
>      for (i =3D 0; i < usbports; i++) {
>          speedmask =3D 0;
>          if (i < xhci->numports_2) {
> -            if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
> -                port =3D &xhci->ports[i + xhci->numports_3];
> -                port->portnr =3D i + 1 + xhci->numports_3;
> -            } else {
> -                port =3D &xhci->ports[i];
> -                port->portnr =3D i + 1;
> -            }
> +            port =3D &xhci->ports[i + xhci->numports_3];
> +            port->portnr =3D i + 1 + xhci->numports_3;
>              port->uport =3D &xhci->uports[i];
>              port->speedmask =3D
>                  USB_SPEED_MASK_LOW  |
> @@ -3366,13 +3345,8 @@ static void usb_xhci_init(XHCIState *xhci)
>              speedmask |=3D port->speedmask;
>          }
>          if (i < xhci->numports_3) {
> -            if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
> -                port =3D &xhci->ports[i];
> -                port->portnr =3D i + 1;
> -            } else {
> -                port =3D &xhci->ports[i + xhci->numports_2];
> -                port->portnr =3D i + 1 + xhci->numports_2;
> -            }
> +            port =3D &xhci->ports[i];
> +            port->portnr =3D i + 1;
>              port->uport =3D &xhci->uports[i];
>              port->speedmask =3D USB_SPEED_MASK_SUPER;
>              assert(i < XHCI_MAXPORTS);


