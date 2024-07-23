Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D329EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 00:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3Hk-0004zc-IH; Mon, 22 Jul 2024 20:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sW3Hj-0004up-Ah
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sW3Hh-0000lb-AS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721694100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jol0R5lQVjYele1SssfebiU+r7w98jPaKwDdtGl0KEo=;
 b=ToJgqpmYpzdGJ+0x0bg+r37XFqO9cYThLJOZ+4qb3KDtFN+/2Dj0jUIB3ZKvQp56IUf7rn
 fX7FyrZW8MeRXX04GaOE5VpyDs0J0M5QdNpz6ENQrnh7Ov2V81ZW/UPHnNIPyNVACmY88h
 cdqJ3ntFXrgrkL2yFPD/qX2wG3V51DU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-vZKLCjiLOvqCw7W85rvdJw-1; Mon, 22 Jul 2024 20:21:38 -0400
X-MC-Unique: vZKLCjiLOvqCw7W85rvdJw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3687f5a2480so2738623f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 17:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721694097; x=1722298897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jol0R5lQVjYele1SssfebiU+r7w98jPaKwDdtGl0KEo=;
 b=ChWAy94/G6SE5StZbRQLaHiwE5mfV2bGOvUInkxbD0qGy4JyvgFiHMLdJA1T3+mtzI
 193fMH9ekY+8EUrPpPBudGvkrgJPLrrVSb6tDtuOSGG8hDE1DZkFtfXNeY3LPVRoTu/t
 RKkiS0uUy3Bu1QtCkVysUf4t1mXvXwLxJOlFIdLt7POeQzK9YkeIpITD7nMD3qmdNIbY
 o4olr50HK/HNdimrYnFGDRTWiD5gV+rqcaF2qRNanAIRMjKkQ2sAy+sQbUeTS29zynHv
 Fsgjik6avBS85Q8BzQcOhOZWlCEsHujxKmamoAUbrjrjI+0Wg/ByrjwKFLkNEm7acz/P
 m6uQ==
X-Gm-Message-State: AOJu0YxYZj3+4Id4G2EW8+UukRaDb08/Ys9OVcWwC4psUVVq8Mgo+Y0x
 pHbi85rLUctQt3F54mqNEKJZujWU9tTqO/wM7ieA0yj2JsCakm1ybNNUtn2XAYcRSV/XvZWW7zo
 K2UqRbuMzJwXGjigfpQ2j0Rtqvtbw4MKApobY4vZT0wUgNyVuxhG4
X-Received: by 2002:a5d:6dca:0:b0:367:94a7:12cb with SMTP id
 ffacd0b85a97d-369dee43efemr840815f8f.43.1721694097442; 
 Mon, 22 Jul 2024 17:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk10+cyHrisp27eVvNjOnEhRO/D39XQ3QSmJ/22E8x67l7Hx8aUUTtReJef6/QEJGJ3h7zog==
X-Received: by 2002:a5d:6dca:0:b0:367:94a7:12cb with SMTP id
 ffacd0b85a97d-369dee43efemr840789f8f.43.1721694096760; 
 Mon, 22 Jul 2024 17:21:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5415:9d1e:913c:6f61:614e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cedcdsm9830928f8f.83.2024.07.22.17.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 17:21:36 -0700 (PDT)
Date: Mon, 22 Jul 2024 20:21:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH 0/3] Resolve vt82c686 and piix4 qemu_irq memory leaks
Message-ID: <20240722202107-mutt-send-email-mst@kernel.org>
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240720143745-mutt-send-email-mst@kernel.org>
 <184E18CE-C4DF-4DEA-A20A-84B31833093F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184E18CE-C4DF-4DEA-A20A-84B31833093F@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 22, 2024 at 10:21:30PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 20. Juli 2024 18:38:42 UTC schrieb "Michael S. Tsirkin" <mst@redhat.com>:
> >On Thu, Jul 04, 2024 at 10:58:51PM +0200, Bernhard Beschow wrote:
> >> This series first turns vt82c686's "INTR" pin into a named GPIO for better
> >> comprehensibility. It then continues fixing qemu_irq memory leaks in vt82c686
> >> and piix4 by connecting out IRQs of the south bridges before they get realized.
> >> This approach is already used in the pc machines after it had been discussed at
> >> KVM forum `23.
> >> 
> >> Observe that out IRQs are callbacks such as an INTR IRQ handler in a CPU which a
> >> south bridge wants to trigger. If, as an implementation detail, the south bridge
> >> wants to pass this callback to a child device, such as the PIC, then this
> >> callback must be known to the south bridge before it gets realized. Otherwise
> >> board code had to wire the PIC device itself, breaking encapsulation. This means
> >> that qdev_connect_gpio_out*() has to be called before realize() which this
> >> series implements. Another way to look at it is that callbacks apparently are
> >> resouces such as memory regions which are also populated before realize().
> >> 
> >> Please check if above paragraph makes sense.
> >> 
> >> Best regards,
> >> Bernhard
> >
> >
> >Bernhard, do you intend to resolve Zoltan's comments on this
> >patchset?
> 
> Hi Michael,
> 
> I was hoping for some more comments on the last two commits. These resolve various issues in one go, some of which have been addressed in the past. Since this is apparently a new style to handle out-GPIOs, I'd like to get an OK from the community.
> 
> As Zoltan writes the ideal solution might be to qdev'ify the PIC. This is a bigger task which is more than I intended to do in this series.
> 
> Best regards,
> Bernhard


ATM I'm just looking at whether we can fix any bugs for the coming
release.

> >
> >Thanks!
> >
> >
> >> See also:
> >> * https://lore.kernel.org/qemu-devel/0FFB5FD2-08CE-4CEC-9001-E7AC24407A44@gmail.
> >> com/
> >> * "Remove intermediate IRQ forwarder" patches in
> >> https://lore.kernel.org/qemu-devel/20230210163744.32182-1-philmd@linaro.org/
> >> 
> >> Testing done:
> >> * Boot amigaone machine into Linux
> >> * Boot pegasos2 machine into MorphOS
> >> * Start fuloong2e machine and check that it doesn't abort
> >> * Boot malta machine with https://people.debian.org/~gio/dqib/
> >> 
> >> Bernhard Beschow (3):
> >>   hw/isa/vt82c686: Turn "intr" irq into a named gpio
> >>   hw/isa/vt82c686: Resolve intermediate IRQ forwarder
> >>   hw/isa/piix: Resolve intermediate IRQ forwarder
> >> 
> >>  hw/isa/piix.c       | 13 ++-----------
> >>  hw/isa/vt82c686.c   | 12 ++----------
> >>  hw/mips/fuloong2e.c |  2 +-
> >>  hw/mips/malta.c     |  4 +---
> >>  hw/ppc/amigaone.c   |  8 ++++----
> >>  hw/ppc/pegasos2.c   |  4 ++--
> >>  6 files changed, 12 insertions(+), 31 deletions(-)
> >> 
> >> -- 
> >> 2.45.2
> >> 
> >


