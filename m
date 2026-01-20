Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE79D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8dz-0007By-6T; Tue, 20 Jan 2026 05:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8du-0007A6-Gs
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:07:22 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8ds-0003P4-KI
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:07:22 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8768225837so738344466b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768903639; x=1769508439; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=s9iVnPyXyG87BDuEtFgDOA0rNibOfzEHQ0FhtxEPL7M=;
 b=kgn2Sk/oNYXvsRfkKlVJtWL2ThWB+sTfZKtEYkvA6R/na7bR0beUWwKoeHfDBLOCRq
 Kd5UbJn91xNiqDFt1+tkcKdOVwhcjvTTxmrdeDluJLrSkKyjxwzNqepc3Y3vWKEiI0Du
 DGpjAdHiR9wWH6YeAQWqRWJN0txnAMwwr/spI5URdHCjMs2iR1q3HdqA+Fb4nrIdsz+0
 M56y+IET9OiI+d4ZETs7FArPXT0qJsQX9dv9TxiIu9XwCAXhljAmsJfGoP+JNs+iB5Xj
 7e4bDv24dquaUJf5isvBFEoMAU16M/QnwUstzax/5K7YBPw07Nga7n4b82Pyb254X11P
 Yxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768903639; x=1769508439;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s9iVnPyXyG87BDuEtFgDOA0rNibOfzEHQ0FhtxEPL7M=;
 b=voq5rbvyRzga08hX2j9DQ5S2WyCoE+ujbfl4oy3fM/cfo9zVIB8d2+xKjMsOGDLPoW
 2ZqAGTOaNg4fyt9dtx8hhFyIMPBUgNk7h0EnKJgfhE3f1rVTRkXqCArVKdc3HKbmG8Hf
 8HkmA3YMET32ehQMC7Ggi5J4a04otu+sul2ltStPeYgAd7vII30oOmuFXI6pDMhOGYRY
 M7sKy0OT0ixNGFLSWGCmsnkJpFrT4ZK57Tw9Mwc1DzgoKixhPwn+CbyOiB+/vmB1YEu8
 BHjFW9iPzcf32yrABDbop6EKdwk+Zr7tnIGwSzjKX+Jv/cCnj5SjaJiiT/3g+YDGt1uH
 lwHg==
X-Gm-Message-State: AOJu0YwFkEc09Ek4EluQIleko76dbo3zPEYwk63GrIZSYDL8/BphdXBL
 TxZQhIdUjLId2T7N/Ygi7v7kW/P4oQ3s3Ndi+K5XMGMXdhsU8d0uqa+i
X-Gm-Gg: AZuq6aJXv7HiO4gDkvlZEFF8xNrvBy8UjpDbx7xemyGpuOg5fA18tspggFRDRcNInVV
 rDEdpKrrQGeaILhQl3Af9mZZKcy+TVWDf+yNi1xCilYy3uA+O57/xlqyCVxtKPZzyXcIiwOGtNW
 VyXL8iDP3AfNC99DptAVw/5iELmm2mfOv9cbuSJ2H9/vZ+/IaPC7jIn1JiuNDLwY06mnA2ok1ex
 RkAH/ORYRafszUfUlo4n2FGdXsxGssvYy1GWJvzifGw6Z4iGO9de9mvSFqThT7ThXv4jbB+n2D9
 Sxq4gdnpw0v6nERR5AtWk+6F0hQ9Sjph8u5EX+NCaWg0iuAtYlYPahQiuNsR8Pa6YLYwrurNmat
 I2YmU9J17gssZF8qCKlYpDGuYBHAj5LWp/Onnjri2ApCNejzfXgjwumKUlOXLS01ivUVYhAMA0V
 42g+fHOkPk20j76Zszp7+Vpnz2KcaGUrKfhkLGC1urejS2K7Sg7BJyR9KA
X-Received: by 2002:a17:907:6d2a:b0:b87:2410:5956 with SMTP id
 a640c23a62f3a-b8793035670mr1413025066b.47.1768903637964; 
 Tue, 20 Jan 2026 02:07:17 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87ed991b75sm385626866b.1.2026.01.20.02.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 02:07:17 -0800 (PST)
Message-ID: <a7c9e66388d621b26c1e954c9a88ec19c7d88056.camel@gmail.com>
Subject: Re: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Markus Armbruster <armbru@redhat.com>, Eric
 Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Maximilian
 Immanuel Brandtner	 <maxbr@linux.ibm.com>, Szymon Lukasz <noh4hss@gmail.com>
Date: Tue, 20 Jan 2026 11:07:16 +0100
In-Reply-To: <aW9Q62g60J6L4yuI@redhat.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
 <aW9Q62g60J6L4yuI@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2026-01-20 at 09:54 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 20, 2026 at 10:50:04AM +0100, Filip Hejsek wrote:
> > On Mon, 2026-01-19 at 04:27 +0100, Filip Hejsek wrote:
> > > Implement the part of the virtio spec that allows to notify the virti=
o
> > > driver about terminal resizes. The virtio spec contains two methods t=
o
> > > achieve that:
> > >=20
> > > For legacy drivers, we have only one port and we put the terminal siz=
e
> > > in the config space and inject the config changed interrupt.
> > >=20
> > > For multiport devices, we use the control virtqueue to send a packet
> > > containing the terminal size. Note that old versions of the Linux ker=
nel
> > > used an incorrect order for the fields (rows then cols instead of col=
s
> > > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee738=
0b26c7056ddd.
> > >=20
> > > As a result, when using a Linux kernel older than 6.15, the number of=
 rows
> > > and columns will be swapped.
> > >=20
> > > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.c=
om>,
> > > but partially rewritten to fix various corner cases.
> > >=20
> > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > ---
> > >  hw/char/trace-events              |  1 +
> > >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++=
++++++++--
> > >  hw/core/machine.c                 |  4 ++-
> > >  include/hw/virtio/virtio-serial.h |  5 +++
> > >  4 files changed, 83 insertions(+), 3 deletions(-)
> > >=20
> > > [...]
> > >=20
> > > diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/vi=
rtio-serial.h
> > > index 60641860bf..bda6d5312a 100644
> > > --- a/include/hw/virtio/virtio-serial.h
> > > +++ b/include/hw/virtio/virtio-serial.h
> > > @@ -145,6 +145,9 @@ struct VirtIOSerialPort {
> > >      bool host_connected;
> > >      /* Do apps not want to receive data? */
> > >      bool throttled;
> > > +
> > > +    /* Terminal size reported to the guest.  Only used for consoles.=
 */
> > > +    uint16_t cols, rows;
> > >  };
> >=20
> > I found a bug: after a migration, the guest is not informed about the
> > new console size. I see two ways to fix this: either add the cols and
> > rows fields to the migration stream, or always send the console size to
> > the guest after migration, even if it might not have changed. Which do
> > you prefer? Modifying the migration stream is somewhat annoying,
> > because both versions will have to be supported, and also the device
> > still uses legacy save/load functions rather than VMState.
>=20
> On the backend side, I'd consider migration to be equivalent to closing
> and re-opening the backend character device. That should imply sending
> a resize event on  migration completion. I'm surprised the chardev on
> the dst isn't already triggering that when it gets connected, but perhaps
> that is too early & getting lost ?

The virtio device caches the size and doesn't send a resize message if
the size hasn't actually changed.

>=20
> With regards,
> Daniel

