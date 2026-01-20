Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62389D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8sy-0003U3-7f; Tue, 20 Jan 2026 05:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8sw-0003Tj-Nm
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:22:54 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8su-0005jD-Rb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:22:54 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b876798b97eso821322066b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768904571; x=1769509371; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oq7fsUuRO4MmNqlHZ9B4+NQGT8x6AY0TzIBWqhdUJw8=;
 b=ZYWuwKay5VSrp1b5z1GG1KHTL6wlw8CKfpn3PsMI70Z8YN9dTn1ZP82YUhfKwLsqo3
 riB/4bc9DgmlwdkD/gaLS5PA9ZJMn0chq9F3lMVxTLK22gZFRb2VdWtKwC6R3hr4PyMS
 f2XXOdFuXJwD5BiVQT6rFeWin3Kz3bE8NmQj0WdziInWV5DYSEshVFOz9klYodQvamCv
 qU35jbCmNs4baQ+QAUZkDDb9E/qySM6GZJ/vjyMUiuYDSXpuhSNdBhiRlgw8ZwQeQpo+
 9JYEYY+FmOVSf851yf326bQ9yM7TDuR9/WrIquf4vv44QmHIrHhHRrH9H308Ukdf2a8S
 nrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768904571; x=1769509371;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oq7fsUuRO4MmNqlHZ9B4+NQGT8x6AY0TzIBWqhdUJw8=;
 b=CD3+ygAV1FOhu18CgT8YdWwKwtiXngSWkb9n2F4/9lmw9Qi3CsjePUeE/UcOilYUMX
 W2LY9pT3U0ylT4B3xnVqK9XAaqCHTkNR7XKqpz665l7xNTrx2/EHzM/W95113xp2TOhp
 0cPhseIKp6xwfPTAEVkQoGZXTaagZKgSpFVn1AyZpqUYiUy1RDw07MxDNxZEAqQC/mzY
 YwWumdQvJFEc2IQ391Q/SSLfONCKGaCOcFgO7zNE59KBteQ5/+2D7x4C6Fe8p6SBfNaw
 mUzOYbbl1ubndNN+DSSJZXCNoV1eaEqmTkI+fobLpkja7HV1daSAlCsJp2B/fAOXTPTU
 OpIA==
X-Gm-Message-State: AOJu0YyQdn1iZNH4f+J6CT4b93MXxIb7teUX9F5FgDmb21YmlDwu7Hf1
 fV+4Q2gijfyLBehb/ALB/rlMAiWceC5JeWU2ebj/RcfkZb9GaTEGa1ll
X-Gm-Gg: AY/fxX4i2KVd9/y2WyD66z0tafDcoVk4kpHyuuwKsZbhX89XLskzSYGydzeftkivXfK
 wjQIc616raQxRDe4elvPTDq/w4o8WTOmO00T1Rpols/9vENL/07ihBMAZZVTlvKYcbkAgoRxlea
 GGFiM58BTO48bliiGTM2qJ+u1oEbA64Km1rnUTyeNhGOPewBTBHlIioNkTgrj3F/70UVYclHg7J
 3kFlv2ka5YoMcc65AvyC7TvigtWZUivNKa6DpUrYQwPTeSFK8Q2goUvN747ldKIbTS7aCtLU6xh
 7beKYCYnWvsWEmfA/PUjjgv8raFVHEwEWIgrS5SzxZo6jtLKUzA7aUGIIn/ZU9uyeKGkQy1wJca
 kpPVF5EgDS/TKN1LlI8zvG7mc+RWpm8tsn15xg3KC7jHP5BKC/3Luu9qPG09kBnwxGHE+Ol/nCa
 hE6rnT3AMb4tT35NcIMoQGykaf1lG5YEtJ5cDWekCISELUNg==
X-Received: by 2002:a17:907:869e:b0:b86:fd46:724 with SMTP id
 a640c23a62f3a-b88003e0601mr134815266b.13.1768904570632; 
 Tue, 20 Jan 2026 02:22:50 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e9dcsm1382217666b.6.2026.01.20.02.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 02:22:50 -0800 (PST)
Message-ID: <ae5632be94b0525aacdbf98c5cb994a53a869876.camel@gmail.com>
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
Date: Tue, 20 Jan 2026 11:22:49 +0100
In-Reply-To: <aW9W55ZBxURMSmip@redhat.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
 <aW9Q62g60J6L4yuI@redhat.com>
 <a7c9e66388d621b26c1e954c9a88ec19c7d88056.camel@gmail.com>
 <aW9UfOk04QKe6fZA@redhat.com>
 <af668f8b21c675fb3f735b1ae9617cc39c57813a.camel@gmail.com>
 <aW9W55ZBxURMSmip@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x62a.google.com
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

On Tue, 2026-01-20 at 10:20 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 20, 2026 at 11:16:51AM +0100, Filip Hejsek wrote:
> > On Tue, 2026-01-20 at 10:10 +0000, Daniel P. Berrang=C3=A9 wrote:
> > > On Tue, Jan 20, 2026 at 11:07:16AM +0100, Filip Hejsek wrote:
> > > > On Tue, 2026-01-20 at 09:54 +0000, Daniel P. Berrang=C3=A9 wrote:
> > > > > On Tue, Jan 20, 2026 at 10:50:04AM +0100, Filip Hejsek wrote:
> > > > > > On Mon, 2026-01-19 at 04:27 +0100, Filip Hejsek wrote:
> > > > > > > Implement the part of the virtio spec that allows to notify t=
he virtio
> > > > > > > driver about terminal resizes. The virtio spec contains two m=
ethods to
> > > > > > > achieve that:
> > > > > > >=20
> > > > > > > For legacy drivers, we have only one port and we put the term=
inal size
> > > > > > > in the config space and inject the config changed interrupt.
> > > > > > >=20
> > > > > > > For multiport devices, we use the control virtqueue to send a=
 packet
> > > > > > > containing the terminal size. Note that old versions of the L=
inux kernel
> > > > > > > used an incorrect order for the fields (rows then cols instea=
d of cols
> > > > > > > then rows), until it was fixed by commit 5326ab737a47278dbd16=
ed3ee7380b26c7056ddd.
> > > > > > >=20
> > > > > > > As a result, when using a Linux kernel older than 6.15, the n=
umber of rows
> > > > > > > and columns will be swapped.
> > > > > > >=20
> > > > > > > Based on a patch originally written by Szymon Lukasz <noh4hss=
@gmail.com>,
> > > > > > > but partially rewritten to fix various corner cases.
> > > > > > >=20
> > > > > > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > > > > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > > > > > ---
> > > > > > >  hw/char/trace-events              |  1 +
> > > > > > >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++=
++++++++++++++++--
> > > > > > >  hw/core/machine.c                 |  4 ++-
> > > > > > >  include/hw/virtio/virtio-serial.h |  5 +++
> > > > > > >  4 files changed, 83 insertions(+), 3 deletions(-)
> > > > > > >=20
> > > > > > > [...]
> > > > > > >=20
> > > > > > > diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/v=
irtio/virtio-serial.h
> > > > > > > index 60641860bf..bda6d5312a 100644
> > > > > > > --- a/include/hw/virtio/virtio-serial.h
> > > > > > > +++ b/include/hw/virtio/virtio-serial.h
> > > > > > > @@ -145,6 +145,9 @@ struct VirtIOSerialPort {
> > > > > > >      bool host_connected;
> > > > > > >      /* Do apps not want to receive data? */
> > > > > > >      bool throttled;
> > > > > > > +
> > > > > > > +    /* Terminal size reported to the guest.  Only used for c=
onsoles. */
> > > > > > > +    uint16_t cols, rows;
> > > > > > >  };
> > > > > >=20
> > > > > > I found a bug: after a migration, the guest is not informed abo=
ut the
> > > > > > new console size. I see two ways to fix this: either add the co=
ls and
> > > > > > rows fields to the migration stream, or always send the console=
 size to
> > > > > > the guest after migration, even if it might not have changed. W=
hich do
> > > > > > you prefer? Modifying the migration stream is somewhat annoying=
,
> > > > > > because both versions will have to be supported, and also the d=
evice
> > > > > > still uses legacy save/load functions rather than VMState.
> > > > >=20
> > > > > On the backend side, I'd consider migration to be equivalent to c=
losing
> > > > > and re-opening the backend character device. That should imply se=
nding
> > > > > a resize event on  migration completion. I'm surprised the charde=
v on
> > > > > the dst isn't already triggering that when it gets connected, but=
 perhaps
> > > > > that is too early & getting lost ?
> > > >=20
> > > > The virtio device caches the size and doesn't send a resize message=
 if
> > > > the size hasn't actually changed.
> > >=20
> > > If the size on the dest has not changed vs the size on the src, that'=
s
> > > fine surely ? We only need to tell the guest a new size if the dst
> > > was different from the source after migration=20
> >=20
> > The current size is compared against previous size on the *dst*. We
> > don't know the size on the src, because it is not sent in the migration
> > stream.
>=20
> Oh, I see what you mean. In that case we should probably use a .post_load
> hook to invalidate the dst cached size in some manner, so that the next
> update from the backend is forced to be sent to the guest.

I think just sending the cached size is simpler.

Best regards,
Filip

