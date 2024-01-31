Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2E0C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVBaY-00016c-3Q; Wed, 31 Jan 2024 09:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVBaW-00016G-IB
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:29:16 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVBaU-0004di-Iq
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:29:16 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2cf206e4d56so59789481fa.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 06:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706711353; x=1707316153; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IuoI5t/OtRuBVBB+aVI08uzFjjRlaULBl5ySCAhNRmA=;
 b=HW9OpBxzE90+5+uNk2IB/FY7ldke8kRvraQ5KBRfXIZhX8h++pZSeULsSB4A0ZOk60
 nszPeF6AOAUoBlpMHU/VRXOs0kEsOUvNTkbroTj6y1NW/yNUGymQIRx0HJfsmHSGrV20
 Sh5dXJRJ+0reWJbzw+JgNKZPXjRMVQNuXo+nkVkqpWi9ZJYiqqpiHlc8FjKsnbzNhRSE
 scf0HPmeD6f30hm3F8xGVpzdfAliiVSy6131qdpHJz7idyUa6N2YSNwUjHCgze02/H1w
 PF9TofKnGGxTFy+fyUMbK4HoRXYdgekV/1svBZOe5bBFZns7EoBc1LIsJYnFauXHnRYi
 y8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706711353; x=1707316153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IuoI5t/OtRuBVBB+aVI08uzFjjRlaULBl5ySCAhNRmA=;
 b=V+XhxL5SX2HITgMi2KeYI2ZCdALUO3cllyFYA4HWQ6oe8GZO9b9I0VT2O55Oz7lRIU
 tMfSHNCxHB8yugkivk6kFSDTklpOOcWQfdzVLQnpCeuzXw5S9FAS7PrqF//jPuf8Ii8F
 Uo7J6SiddBVQV7MEprcZ36wELV5KOhhol5CDaDysZRs6RskmU8DmHC7xxzYa5qZupie8
 XElQsnvG2AUXFM3O+/4rSD/fPKidcfu1z8kn+A5DHCfXM0eYTI24X9lXUAg1z88o+zxU
 mV13nTyqfCRTdBqMgAAKvLFO+qc9fDCJUJw1RZ/qmT5RpkUhEypWS46beAvicQ8tTWhG
 7pgg==
X-Gm-Message-State: AOJu0YxdLoZZkwnGA3dTxVHIZ0r0Pgi/ZsPor875JdiXA6QTuv84UA3z
 +f0XHfYSrIm1cmTYC8wv6GIydfT1rYmN/EdK8vrPUy57l4g0MZsc/iHSiEagRnDcMFkcWEWnb6U
 /oiSjutaKoHGiv3sbzz379exlvFHzz1X3nZWmoQ==
X-Google-Smtp-Source: AGHT+IHPVoT2eSlPjQZQ1GWlX0CQP8/BLcGo3sN1AkNbXGk5PQu/Esb2j4fM4EFG73XKa5wyS7w723zjbL91NyS2FBY=
X-Received: by 2002:a2e:b0e7:0:b0:2cd:7a4b:99f with SMTP id
 h7-20020a2eb0e7000000b002cd7a4b099fmr1255185ljl.48.1706711352565; Wed, 31 Jan
 2024 06:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20240126173228.394202-1-dwmw2@infradead.org>
 <20240126173228.394202-30-dwmw2@infradead.org>
 <d3f5d8a7-a224-4269-9f17-5f411266ba64@redhat.com>
In-Reply-To: <d3f5d8a7-a224-4269-9f17-5f411266ba64@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jan 2024 14:28:41 +0000
Message-ID: <CAFEAcA-0A59S5WKM_SoxL4WGwPPSLNs_A2R2+2iHtuTCuBMCxw@mail.gmail.com>
Subject: Re: [PATCH v4 29/47] hw/arm/stellaris: use qemu_find_nic_info()
To: Thomas Huth <thuth@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Song Gao <gaosong@loongson.cn>, 
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jason Wang <jasowang@redhat.com>, Jia Liu <proljc@gmail.com>, 
 Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Magnus Damm <magnus.damm@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 31 Jan 2024 at 12:14, Thomas Huth <thuth@redhat.com> wrote:
>
> On 26/01/2024 18.25, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > Rather than just using qemu_configure_nic_device(), populate the MAC
> > address in the system-registers device by peeking at the NICInfo before
> > it's assigned to the device.
> >
> > Generate the MAC address early, if there is no matching -nic option.
> > Otherwise the MAC address wouldn't be generated until net_client_init1()
> > runs.
> >
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > ---
> >   hw/arm/stellaris.c | 30 ++++++++++++++++++++++--------
> >   1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> > index d18b1144af..34c5a86ac2 100644
> > --- a/hw/arm/stellaris.c
> > +++ b/hw/arm/stellaris.c
> > @@ -1028,7 +1028,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
> >       DeviceState *ssys_dev;
> >       int i;
> >       int j;
> > -    const uint8_t *macaddr;
> > +    NICInfo *nd;
> > +    MACAddr mac;
> >
> >       MemoryRegion *sram = g_new(MemoryRegion, 1);
> >       MemoryRegion *flash = g_new(MemoryRegion, 1);
> > @@ -1051,12 +1052,22 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
> >        * need its sysclk output.
> >        */
> >       ssys_dev = qdev_new(TYPE_STELLARIS_SYS);
> > -    /* Most devices come preprogrammed with a MAC address in the user data. */
> > -    macaddr = nd_table[0].macaddr.a;
> > +
> > +    /*
> > +     * Most devices come preprogrammed with a MAC address in the user data.
> > +     * Generate a MAC address now, if there isn't a matching -nic for it.
> > +     */
> > +    nd = qemu_find_nic_info("stellaris_enet", true, "stellaris");
> > +    if (nd) {
> > +        memcpy(mac.a, nd->macaddr.a, sizeof(mac.a));
> > +    } else {
> > +        qemu_macaddr_default_if_unset(&mac);
> > +    }
> > +
> >       qdev_prop_set_uint32(ssys_dev, "user0",
> > -                         macaddr[0] | (macaddr[1] << 8) | (macaddr[2] << 16));
> > +                         mac.a[0] | (mac.a[1] << 8) | (mac.a[2] << 16));
> >       qdev_prop_set_uint32(ssys_dev, "user1",
> > -                         macaddr[3] | (macaddr[4] << 8) | (macaddr[5] << 16));
> > +                         mac.a[3] | (mac.a[4] << 8) | (mac.a[5] << 16));
>
> Out of scope of your patch, but I wonder why we didn't use
> qdev_prop_set_macaddr() with an according MAC address property for this
> device...?

Partly because this code originates from 2007 and
qdev_prop_set_macaddr() only arrived in 2009. When I did
a basic qdev conversion in 2021 (commit 4bebb9ad4e4) I
just did a simple change from "directly set fields in the
device state struct" to "set fields in the device state
struct via some qdev properties".

But also because the device we're setting these fields on isn't
an ethernet device -- it's a "system control" device with a bunch
of registers, including two which have no effect on the hardware
behaviour but which by convention usually have the MAC address in
them. So as an interface to the system control device it does make
some sense to have it be "what are the values of these two 'user'
registers" ?

(qdev_prop_set_macaddr() and the associated mac address property
seem a bit odd -- qdev_prop_set_macaddr() is called from exactly
one place, and it takes an array of bytes, marshalls them into
an ASCII string representation, sets the property, and then the
property setter parses them back out of ASCII and into an array
of bytes again...)

thanks
-- PMM

