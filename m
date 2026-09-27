Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35D4C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAsPA-0002eR-H3; Sun, 27 Sep 2026 13:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAsP9-0002eJ-5Y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:11:11 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAsP7-0002Ry-0j
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790529067; x=1791133867; i=deller@gmx.de;
 bh=JCcOJDCtiy5nmciz8s+/3+KC+AFjAJGlpX82oX0g5X0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gUxSqLdFSA69Z5zkUc280x0I1tJD0SM3EgBGPK5we7oGgK6T4OTZ3+E8R4JCjdP2
 28NXWM8Ze5kTOwIVknIr+kW6AnWyykDUwBWBQTlTC/Lk9XRPGqQ0uNvKtQd7N4nNd
 WcFarEg+YFK4+URdcgKRVJPJbFT7zmC3FRJ26e3i8tV8Q9IszrXfur52pTsUkDNi5
 CGuXJ1JguFJUmRZMxykgxaIdR0Bg90z6JwXMDbWELM608DFnywK2aaLjZjhR97NTo
 pchEgY0boAWfRk2NEF4CWRXU+D0DBvI26OS2Wt8q/aJZCHp7+27zIMtc4Hh9ZfaNl
 3W7enqluaNGuS4Yatw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1xM5dB41MZ-00IxVK; Sun, 27
 Sep 2026 19:11:07 +0200
Message-ID: <b183de1f-b6a2-4733-ad1e-a5c47df0328c@gmx.de>
Date: Sun, 27 Sep 2026 19:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] usb/hid: add enhanced wheel mouse report
 descriptor and packet size
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Lambertz <patch@thomaslambertz.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
 <20260331170823.72511-3-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260331170823.72511-3-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/gIJiytfU58/htJdPO+5gKxNcRn0oY/IfKCXtZYrnG0ocNC3dia
 qu7cs/h/RkDmnkCSb6wLi3XBmXM3p03pJfr7BpI9etAdDAoJk0E8p2F4KYC5fH+XRYhTwKa
 qRWPuXs5QgypeQM40o5q0BpyCjtmZKezNHdpx87yMlEFsArz+LuF39uzVHfM42etdfa6WF0
 MjBhJeLqNIpnZR6eoKrow==
UI-OutboundReport: notjunk:1;M01:P0:sBVr1GQb7zY=;KtD5TBCRvjTXiNAxnQl74Oz7FFD
 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
 daEJYqeynDCvVoo4eDwjhef2TVXl9Xz/YpxK/A=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/31/26 19:08, Soumyajyotii Ssarkar wrote:
> Build on top of the simple mouse HID report descriptor with an enhanced =
version
> that supports report IDs and feature reports for high resolution mouse
> wheel control. As per the documentation structure.
>=20
> Check: https://download.microsoft.com/download/b/d/1/bd1f7ef4-7d72-419e-=
bc5c-9f79ad7bb66e/wheel.docx
>=20
> Changes:
> - Increase HID descriptor length from 52 to 144 bytes
> - Add report IDs (0x01 input, 0x02 feature)
> - Implement feature reports for wheel/pan resolution multipliers
> - Add AC Pan (horizontal scroll) usage
> - Increase endpoint packet size from 4 to 6 bytes for pan byte
>=20
> This enables guests to configure resolution multipliers (+-1, +-4, +-8, =
+-16)
> to control scroll acceleration and precision.
>=20
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> ---
>   hw/usb/dev-hid.c | 126 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 95 insertions(+), 31 deletions(-)
>=20
> diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
> index ae19d60203..49e23c2319 100644
> --- a/hw/usb/dev-hid.c
> +++ b/hw/usb/dev-hid.c
> @@ -93,7 +93,7 @@ static const USBDescIface desc_iface_mouse =3D {
>                   0x00,          /*  u8  country_code */
>                   0x01,          /*  u8  num_descriptors */
>                   USB_DT_REPORT, /*  u8  type: Report */
> -                52, 0,         /*  u16 len */
> +                144, 0,        /*  u16 len */
>               },
>           },
>       },
> @@ -101,7 +101,7 @@ static const USBDescIface desc_iface_mouse =3D {
>           {
>               .bEndpointAddress      =3D USB_DIR_IN | 0x01,
>               .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
> -            .wMaxPacketSize        =3D 4,
> +            .wMaxPacketSize        =3D 6,
>               .bInterval             =3D 0x0a,
>           },
>       },
> @@ -124,7 +124,7 @@ static const USBDescIface desc_iface_mouse2 =3D {
>                   0x00,          /*  u8  country_code */
>                   0x01,          /*  u8  num_descriptors */
>                   USB_DT_REPORT, /*  u8  type: Report */
> -                52, 0,         /*  u16 len */
> +                144, 0,        /*  u16 len */
>               },
>           },
>       },
> @@ -132,7 +132,7 @@ static const USBDescIface desc_iface_mouse2 =3D {
>           {
>               .bEndpointAddress      =3D USB_DIR_IN | 0x01,
>               .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
> -            .wMaxPacketSize        =3D 4,
> +            .wMaxPacketSize        =3D 6,
>               .bInterval             =3D 7, /* 2 ^ (8-1) * 125 usecs =3D=
 8 ms */
>           },
>       },
> @@ -454,33 +454,97 @@ static const USBDesc desc_keyboard2 =3D {
>   };
>=20
>   static const uint8_t qemu_mouse_hid_report_descriptor[] =3D {
> -    0x05, 0x01,		/* Usage Page (Generic Desktop) */
> -    0x09, 0x02,		/* Usage (Mouse) */
> -    0xa1, 0x01,		/* Collection (Application) */
> -    0x09, 0x01,		/*   Usage (Pointer) */
> -    0xa1, 0x00,		/*   Collection (Physical) */
> -    0x05, 0x09,		/*     Usage Page (Button) */
> -    0x19, 0x01,		/*     Usage Minimum (1) */
> -    0x29, 0x05,		/*     Usage Maximum (5) */
> -    0x15, 0x00,		/*     Logical Minimum (0) */
> -    0x25, 0x01,		/*     Logical Maximum (1) */
> -    0x95, 0x05,		/*     Report Count (5) */
> -    0x75, 0x01,		/*     Report Size (1) */
> -    0x81, 0x02,		/*     Input (Data, Variable, Absolute) */
> -    0x95, 0x01,		/*     Report Count (1) */
> -    0x75, 0x03,		/*     Report Size (3) */
> -    0x81, 0x01,		/*     Input (Constant) */
> -    0x05, 0x01,		/*     Usage Page (Generic Desktop) */
> -    0x09, 0x30,		/*     Usage (X) */
> -    0x09, 0x31,		/*     Usage (Y) */
> -    0x09, 0x38,		/*     Usage (Wheel) */
> -    0x15, 0x81,		/*     Logical Minimum (-0x7f) */
> -    0x25, 0x7f,		/*     Logical Maximum (0x7f) */
> -    0x75, 0x08,		/*     Report Size (8) */
> -    0x95, 0x03,		/*     Report Count (3) */
> -    0x81, 0x06,		/*     Input (Data, Variable, Relative) */
> -    0xc0,		/*   End Collection */
> -    0xc0,		/* End Collection */
> +    0x05, 0x01,     /* Usage Page (Generic Desktop) */

You are reformatting the lines here by moving the comments.
Please do that in an own patch, or keep the position of the comments for y=
our code as well.

Otherwise the patch looks good.

Helge

> +    0x09, 0x02,     /* Usage (Mouse) */
> +    0xA1, 0x01,     /* Collection (Application) */
> +
> +    0x09, 0x02,     /* Usage (Mouse) */
> +    0xA1, 0x02,     /* Collection (Logical) */
> +
> +    0x85, 0x01,     /* Report ID (0x01) */
> +    0x09, 0x01,     /* Usage (Pointer) */
> +    0xA1, 0x00,     /* Collection (Physical) */
> +
> +    0x05, 0x09,     /* Usage Page (Button) */
> +    0x19, 0x01,     /* Usage Minimum (1) */
> +    0x29, 0x05,     /* Usage Maximum (5) */
> +    0x15, 0x00,     /* Logical Minimum (0) */
> +    0x25, 0x01,     /* Logical Maximum (1) */
> +    0x95, 0x05,     /* Report Count (5) */
> +    0x75, 0x01,     /* Report Size (1) */
> +    0x81, 0x02,     /* Input (Data,Var,Abs) */
> +
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0x75, 0x03,     /*  Report Size (3) */
> +    0x81, 0x01,     /*  Input (Const) */
> +
> +    0x05, 0x01,     /*  Usage Page (Generic Desktop) */
> +    0x09, 0x30,     /*  Usage (X) */
> +    0x09, 0x31,     /*  Usage (Y) */
> +    0x95, 0x02,     /*  Report Count (2) */
> +    0x75, 0x08,     /*  Report Size (8) */
> +    0x15, 0x81,     /*  Logical Minimum (-127) */
> +    0x25, 0x7F,     /*  Logical Maximum (127) */
> +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> +
> +    /* Vertical wheel logical collection */
> +    0xA1, 0x02,     /*  Collection (Logical) */
> +
> +    0x85, 0x02,     /*  Report ID (0x02) */
> +    0x09, 0x48,     /*  Usage (Resolution Multiplier) */
> +    0x15, 0x00,     /*  Logical Minimum (0) */
> +    0x25, 0x01,     /*  Logical Maximum (1) */
> +    0x35, 0x01,     /*  Physical Minimum (1) */
> +    0x45, 0x04,     /*  Physical Maximum (4) */
> +    0x75, 0x02,     /*  Report Size (2) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0xB1, 0x02,     /*  Feature (Data,Var,Abs) */
> +
> +    0x85, 0x01,     /*  Report ID (0x01) */
> +    0x09, 0x38,     /*  Usage (Wheel) */
> +    0x35, 0x00,     /*  Physical Minimum (0) */
> +    0x45, 0x00,     /*  Physical Maximum (0) */
> +    0x15, 0x81,     /*  Logical Minimum (-0x7f) */
> +    0x25, 0x7F,     /*  Logical Maximum (0x7f) */
> +    0x75, 0x08,     /*  Report Size (8) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> +
> +    0xC0,           /*  End Collection */
> +
> +    /* Horizontal wheel logical collection */
> +    0xA1, 0x02,     /*  Collection (Logical) */
> +
> +    0x85, 0x02,     /*  Report ID (0x02) */
> +    0x09, 0x48,     /*  Usage (Resolution Multiplier) */
> +    0x15, 0x00,     /*  Logical Minimum (0) */
> +    0x25, 0x01,     /*  Logical Maximum (1) */
> +    0x35, 0x01,     /*  Physical Minimum (1) */
> +    0x45, 0x04,     /*  Physical Maximum (4) */
> +    0x75, 0x02,     /*  Report Size (2) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0xB1, 0x02,     /*  Feature (Data,Var,Abs) */
> +
> +    0x35, 0x00,     /*  Physical Minimum (0) */
> +    0x45, 0x00,     /*  Physical Maximum (0) */
> +    0x75, 0x04,     /*  Report Size (4) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0xB1, 0x01,     /*  Feature (Const) */
> +
> +    0x85, 0x01,     /*  Report ID (0x01) */
> +    0x05, 0x0C,     /*  Usage Page (Consumer Devices) */
> +    0x0A, 0x38, 0x02,   /*  Usage (AC Pan) */
> +    0x15, 0x81,     /*  Logical Minimum (-0x7f) */
> +    0x25, 0x7F,     /*  Logical Maximum (0x7f) */
> +    0x75, 0x08,     /*  Report Size (8) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> +
> +    0xC0,           /*  End Collection */
> +
> +    0xC0,           /*  End Collection (Physical) */
> +    0xC0,           /*  End Collection (Logical) */
> +    0xC0            /*  End Collection (Application) */
>   };
>=20
>   static const uint8_t qemu_tablet_hid_report_descriptor[] =3D {
> --
> 2.53.0


