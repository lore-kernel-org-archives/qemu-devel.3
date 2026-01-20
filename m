Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C80CD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8yn-0007UZ-HG; Tue, 20 Jan 2026 05:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8yl-0007OJ-Qh
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:28:55 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8yj-0006qs-SM
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:28:55 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-653780e9eb3so7782566a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768904932; x=1769509732; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KpuJfy37eSMbV8sr5ye71eYHjvxTdI7bgFvoZVkudGU=;
 b=B1JhXXGty5AwiLvBWKkQkDqRBdYvuClviQDiWak9p5D1exsGQOGe2vu4ISLkfAB0+7
 ozVx8nsuq16GrEUgvF58vcUtPDloyjwys5WD+4e3bMKAwmAaX52ldsc2wnUEuaM+dpY5
 nf5Qk9HwaHDqy+NU3Qh2owwndzD/d5jNrWLyDfQQmW2PsNVE/2FAOTd/0JonE0RrL1E4
 idqyoAGqAmXXprdgVMluctSUpmLLMZYyRS08HzGk7UUImP6nYdO5SwgSS6KApod4Fhir
 v62IP+0uZWYeGelGZRl5rmFYJedJLMl4eoUgnLfzZ9oUcZYDwJk63MnoyiWzDWdBQfXm
 34EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768904932; x=1769509732;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KpuJfy37eSMbV8sr5ye71eYHjvxTdI7bgFvoZVkudGU=;
 b=eoKNHkTT2wf4+IUE/sqlBcLPpYsZftvtC2YBC7TSv080X0Y6zkV53GT2k4NXfibBHw
 xMVAmofZE67LxYYeUK83zmidZy3gFtGDgDTc2fWd2dmucVvUOqLHtO4hDD7xQKu/UdDr
 LH8wtim7AT2iCsQu7oZakAe6vTuLGNYXq9iQMd4qcIYhtKJnHXx7FjhrsLF/k93pbMyW
 Vub8nAyTNYa77rjofgsEMpYMRdu75m1muvmLLch+K4JkWW4LBq/eVDyDEBSbKJE9/iDU
 FrsWmM560MIw3J90+7kO9Wj1dukXhOEk4STDm4yGUcqwyEeDP6GeFmrpItpRLi++e7D4
 3kXA==
X-Gm-Message-State: AOJu0YyY2qF6xYZukWGeVEU8CtE7DUn3NEmxAAhixdepBTcwd+q7z+gm
 y8SJN1jNDXFCpP2yIZi6F2TV4UPsXRcRcLNtl3IDFdDLVe/s8b4NlKcgDkitkA==
X-Gm-Gg: AY/fxX6bDRqxl0NkuU2GopAfZG/aQ1PHA8+BwtZGR01zL3wqZ6aPY73iGnNdYuWY+1v
 jPok0o16OAY+Ti3gmSkAEPzqwaq8Xsow2MMqwrxdWUcfMW1JhY2zboWBG/Fd2dKxmcPe/if0bm2
 ttr2uwV8JbMLvi3Zn64Fzc3rlS/Bmss3X5WLsK6Rcp9hWBLb83sBK/3Vm3mm8Q4xxGARI9T/rz/
 gVoUdsJ+aGGXNKI+sfsQlcEklmqCnWCK2a4P4sJLoPYUaA3oNyKZ5YMGdxS3BLwI52XRo7MwC1O
 hHsec3Ak1/6LFnP7b3HNmhbhGS2uE+6zUlySls3AuipX0r+aaJ0mgvsK8rYofxmlxu7oEI3Tslq
 z0Dvn7lZv0pTjBPafb/mn7VtynjIwiCIpV4m554hhJMo8BxpOX60dCO9TD/jNWB6qW1POgjvUGd
 RuB/E3mQEmt07Nrls0m0QX6FWTU4odXAUQq+mrzJLd+EHfAA==
X-Received: by 2002:a17:907:7287:b0:b74:984c:a3de with SMTP id
 a640c23a62f3a-b880044a5d4mr133377666b.28.1768904931779; 
 Tue, 20 Jan 2026 02:28:51 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169d30sm1382699366b.25.2026.01.20.02.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 02:28:50 -0800 (PST)
Message-ID: <221fc46e1c60599ba3c751865652ce1d47473b84.camel@gmail.com>
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
Date: Tue, 20 Jan 2026 11:28:49 +0100
In-Reply-To: <ae5632be94b0525aacdbf98c5cb994a53a869876.camel@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
 <aW9Q62g60J6L4yuI@redhat.com>
 <a7c9e66388d621b26c1e954c9a88ec19c7d88056.camel@gmail.com>
 <aW9UfOk04QKe6fZA@redhat.com>
 <af668f8b21c675fb3f735b1ae9617cc39c57813a.camel@gmail.com>
 <aW9W55ZBxURMSmip@redhat.com>
 <ae5632be94b0525aacdbf98c5cb994a53a869876.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x536.google.com
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

On Tue, 2026-01-20 at 11:22 +0100, Filip Hejsek wrote:
> On Tue, 2026-01-20 at 10:20 +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Jan 20, 2026 at 11:16:51AM +0100, Filip Hejsek wrote:
> > > On Tue, 2026-01-20 at 10:10 +0000, Daniel P. Berrang=C3=A9 wrote:
> > > > On Tue, Jan 20, 2026 at 11:07:16AM +0100, Filip Hejsek wrote:
> > > > > On Tue, 2026-01-20 at 09:54 +0000, Daniel P. Berrang=C3=A9 wrote:
> > > > > > On Tue, Jan 20, 2026 at 10:50:04AM +0100, Filip Hejsek wrote:
> > > > > > > On Mon, 2026-01-19 at 04:27 +0100, Filip Hejsek wrote:
> > > > > > > > Implement the part of the virtio spec that allows to notify=
 the virtio
> > > > > > > > driver about terminal resizes. The virtio spec contains two=
 methods to
> > > > > > > > achieve that:
> > > > > > > >=20
> > > > > > > > For legacy drivers, we have only one port and we put the te=
rminal size
> > > > > > > > in the config space and inject the config changed interrupt=
.
> > > > > > > >=20
> > > > > > > > For multiport devices, we use the control virtqueue to send=
 a packet
> > > > > > > > containing the terminal size. Note that old versions of the=
 Linux kernel
> > > > > > > > used an incorrect order for the fields (rows then cols inst=
ead of cols
> > > > > > > > then rows), until it was fixed by commit 5326ab737a47278dbd=
16ed3ee7380b26c7056ddd.
> > > > > > > >=20
> > > > > > > > As a result, when using a Linux kernel older than 6.15, the=
 number of rows
> > > > > > > > and columns will be swapped.
> > > > > > > >=20
> > > > > > > > Based on a patch originally written by Szymon Lukasz <noh4h=
ss@gmail.com>,
> > > > > > > > but partially rewritten to fix various corner cases.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > > > > > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > > > > > > ---
> > > > > > > >  hw/char/trace-events              |  1 +
> > > > > > > >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++=
++++++++++++++++++--
> > > > > > > >  hw/core/machine.c                 |  4 ++-
> > > > > > > >  include/hw/virtio/virtio-serial.h |  5 +++
> > > > > > > >  4 files changed, 83 insertions(+), 3 deletions(-)
> > > > > > > >=20
> > > > > > > > [...]
> > > > > > > >=20
> > > > > > > > diff --git a/include/hw/virtio/virtio-serial.h b/include/hw=
/virtio/virtio-serial.h
> > > > > > > > index 60641860bf..bda6d5312a 100644
> > > > > > > > --- a/include/hw/virtio/virtio-serial.h
> > > > > > > > +++ b/include/hw/virtio/virtio-serial.h
> > > > > > > > @@ -145,6 +145,9 @@ struct VirtIOSerialPort {
> > > > > > > >      bool host_connected;
> > > > > > > >      /* Do apps not want to receive data? */
> > > > > > > >      bool throttled;
> > > > > > > > +
> > > > > > > > +    /* Terminal size reported to the guest.  Only used for=
 consoles. */
> > > > > > > > +    uint16_t cols, rows;
> > > > > > > >  };
> > > > > > >=20
> > > > > > > I found a bug: after a migration, the guest is not informed a=
bout the
> > > > > > > new console size. I see two ways to fix this: either add the =
cols and
> > > > > > > rows fields to the migration stream, or always send the conso=
le size to
> > > > > > > the guest after migration, even if it might not have changed.=
 Which do
> > > > > > > you prefer? Modifying the migration stream is somewhat annoyi=
ng,
> > > > > > > because both versions will have to be supported, and also the=
 device
> > > > > > > still uses legacy save/load functions rather than VMState.
> > > > > >=20
> > > > > > On the backend side, I'd consider migration to be equivalent to=
 closing
> > > > > > and re-opening the backend character device. That should imply =
sending
> > > > > > a resize event on  migration completion. I'm surprised the char=
dev on
> > > > > > the dst isn't already triggering that when it gets connected, b=
ut perhaps
> > > > > > that is too early & getting lost ?
> > > > >=20
> > > > > The virtio device caches the size and doesn't send a resize messa=
ge if
> > > > > the size hasn't actually changed.
> > > >=20
> > > > If the size on the dest has not changed vs the size on the src, tha=
t's
> > > > fine surely ? We only need to tell the guest a new size if the dst
> > > > was different from the source after migration=20
> > >=20
> > > The current size is compared against previous size on the *dst*. We
> > > don't know the size on the src, because it is not sent in the migrati=
on
> > > stream.
> >=20
> > Oh, I see what you mean. In that case we should probably use a .post_lo=
ad
> > hook to invalidate the dst cached size in some manner, so that the next
> > update from the backend is forced to be sent to the guest.
>=20
> I think just sending the cached size is simpler.

This fixes it:

@@ -806,6 +806,9 @@ static void virtio_serial_post_load_timer_cb(void *opaq=
ue)
                                port->host_connected);
         }
         vsc =3D VIRTIO_SERIAL_PORT_GET_CLASS(port);
+        if (vsc->is_console) {
+            send_console_resize(port);
+        }
         if (vsc->set_guest_connected) {
             vsc->set_guest_connected(port, port->guest_connected);
         }


Best regards,
Filip

