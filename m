Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A05D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8nU-0005Z3-P4; Tue, 20 Jan 2026 05:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8nA-0005Tv-AD
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:17:01 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8n8-0004WL-Lv
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:16:56 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64b58553449so9174328a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768904213; x=1769509013; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ti4CxLamZiTDxXifFki32VmzGYVlkQanaZh5U5MfuLg=;
 b=T+erJShk7MZCvgJmDz53PvqF7d8dGHiGW1CUJQAcn4pipkbsya3qp6DKjGXH03oTWo
 UJb45CLLVgMyjuHeKFMuzn5Haw0a2UN16XZYtPcxLYYKgdjgE54utDYxGwY1VaeqMy+Q
 wmdILWlo8XBcrJhzHryE2IFBxE3umnUumAPVjj0hC0ZS4FIRsY7Xgs5X+S7Kl6GDUSjq
 IVx/iW+9PVHVgDDqLkYdW/Xo2dTcHPKI2F3o2JY9G4BY5EBajmPTGvUkZnN7b0c6bAtO
 EOrYBYyJIf4pa2vZAarMuZNlX/IMl0l6EjOG0NsV1HpgPB5PxDexeGO2y5Gq2Fem96B/
 qoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768904213; x=1769509013;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ti4CxLamZiTDxXifFki32VmzGYVlkQanaZh5U5MfuLg=;
 b=RJBrfs5ECrrvfgSjIC/6jEe1xoziJkXiHJBzme8A8oJJLSBPsm52vWkLZF+BfhoBA6
 wz3u3zrKgl5SNPeA9h6WJGexG6W6v7n7eBtXm/r5yqk5PVc9X4igOY1wium6t1nXIRLy
 69AZJY527lqscLIqxmOl+JfcjvNNp7jp0TmjhRaEa2qmE1/cY5iZBDC33qrfUYjiWEIG
 hhHaJCI8prrupIMuwiWXYqeJmBflI+jO47c9mFCklLBOmzZ0V9PNOmEWhnrF5uwL3Azh
 Uw3QXo//k8UbN6MNJl28shHpPkqLQsyc6PrORPIX0hSFjCZ+XoHYvvNRynHtlVUy0mRH
 SwEQ==
X-Gm-Message-State: AOJu0YxNmrtbzyds9Yn9DavLu5DpKlOdRL753LqEfTEwI5A5wrSaZT85
 zd8oLi+03T9aTQySsvlRlVMHRW7tEtEOYv8EtyORTRS+v/vaRE9BN5Y/
X-Gm-Gg: AZuq6aJ0f7Fls/WpIg9FQXiZVNEkL+6yojT4IJ50BEUqTM/i1duVkgjIUdo1Lg/Tm0V
 /gIKXChsdvozhb4I+O4tIVaj0zXo38YnF4C2yLY89yMQOjEM6Aet9WkIaX8cyoP4dAOqp5UWNKF
 tbAWiHsYDE5sIohtABN4J8wOzdzfcn2pWpoJkT8MsmU3yU83HymtRkQsCUFxUGC63N5T9ciC2Hm
 beI9zRifX1vIRWkWdpCEGicXi0MZm1RTe7jE4QZIaGSqy1EHbgc4xQ2bGloSNEyHgW5eHezXbgR
 k/gVb5/l3Q+L3LZtCjfwm74x93v8pgER8jhm3d303qrwsqkWRwYdYvySEDE+L3p7lqOrzf9+uxp
 vqhHcIx37YjJGuHJ5C62AFnmNwaI1lSZdgRsQbXN8MOA2OVKwXpJDhzl6HZHpL+eKkuIepRN4El
 kwVw05F+Lp0+A+YdAW0vr/YB2PWUMokjuMMINNFQtcbHd+iw==
X-Received: by 2002:a17:907:6d1b:b0:b87:115c:4a2b with SMTP id
 a640c23a62f3a-b8792f9be9fmr1396930266b.25.1768904212755; 
 Tue, 20 Jan 2026 02:16:52 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a43679sm1345881966b.70.2026.01.20.02.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 02:16:52 -0800 (PST)
Message-ID: <af668f8b21c675fb3f735b1ae9617cc39c57813a.camel@gmail.com>
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
Date: Tue, 20 Jan 2026 11:16:51 +0100
In-Reply-To: <aW9UfOk04QKe6fZA@redhat.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
 <aW9Q62g60J6L4yuI@redhat.com>
 <a7c9e66388d621b26c1e954c9a88ec19c7d88056.camel@gmail.com>
 <aW9UfOk04QKe6fZA@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x532.google.com
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

On Tue, 2026-01-20 at 10:10 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 20, 2026 at 11:07:16AM +0100, Filip Hejsek wrote:
> > On Tue, 2026-01-20 at 09:54 +0000, Daniel P. Berrang=C3=A9 wrote:
> > > On Tue, Jan 20, 2026 at 10:50:04AM +0100, Filip Hejsek wrote:
> > > > On Mon, 2026-01-19 at 04:27 +0100, Filip Hejsek wrote:
> > > > > Implement the part of the virtio spec that allows to notify the v=
irtio
> > > > > driver about terminal resizes. The virtio spec contains two metho=
ds to
> > > > > achieve that:
> > > > >=20
> > > > > For legacy drivers, we have only one port and we put the terminal=
 size
> > > > > in the config space and inject the config changed interrupt.
> > > > >=20
> > > > > For multiport devices, we use the control virtqueue to send a pac=
ket
> > > > > containing the terminal size. Note that old versions of the Linux=
 kernel
> > > > > used an incorrect order for the fields (rows then cols instead of=
 cols
> > > > > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3e=
e7380b26c7056ddd.
> > > > >=20
> > > > > As a result, when using a Linux kernel older than 6.15, the numbe=
r of rows
> > > > > and columns will be swapped.
> > > > >=20
> > > > > Based on a patch originally written by Szymon Lukasz <noh4hss@gma=
il.com>,
> > > > > but partially rewritten to fix various corner cases.
> > > > >=20
> > > > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > > > ---
> > > > >  hw/char/trace-events              |  1 +
> > > > >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++=
++++++++++++--
> > > > >  hw/core/machine.c                 |  4 ++-
> > > > >  include/hw/virtio/virtio-serial.h |  5 +++
> > > > >  4 files changed, 83 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virti=
o/virtio-serial.h
> > > > > index 60641860bf..bda6d5312a 100644
> > > > > --- a/include/hw/virtio/virtio-serial.h
> > > > > +++ b/include/hw/virtio/virtio-serial.h
> > > > > @@ -145,6 +145,9 @@ struct VirtIOSerialPort {
> > > > >      bool host_connected;
> > > > >      /* Do apps not want to receive data? */
> > > > >      bool throttled;
> > > > > +
> > > > > +    /* Terminal size reported to the guest.  Only used for conso=
les. */
> > > > > +    uint16_t cols, rows;
> > > > >  };
> > > >=20
> > > > I found a bug: after a migration, the guest is not informed about t=
he
> > > > new console size. I see two ways to fix this: either add the cols a=
nd
> > > > rows fields to the migration stream, or always send the console siz=
e to
> > > > the guest after migration, even if it might not have changed. Which=
 do
> > > > you prefer? Modifying the migration stream is somewhat annoying,
> > > > because both versions will have to be supported, and also the devic=
e
> > > > still uses legacy save/load functions rather than VMState.
> > >=20
> > > On the backend side, I'd consider migration to be equivalent to closi=
ng
> > > and re-opening the backend character device. That should imply sendin=
g
> > > a resize event on  migration completion. I'm surprised the chardev on
> > > the dst isn't already triggering that when it gets connected, but per=
haps
> > > that is too early & getting lost ?
> >=20
> > The virtio device caches the size and doesn't send a resize message if
> > the size hasn't actually changed.
>=20
> If the size on the dest has not changed vs the size on the src, that's
> fine surely ? We only need to tell the guest a new size if the dst
> was different from the source after migration=20

The current size is compared against previous size on the *dst*. We
don't know the size on the src, because it is not sent in the migration
stream.

Best regards,
Filip

