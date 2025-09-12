Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9570FCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 18:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux8EN-000129-Ry; Fri, 12 Sep 2025 14:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1ux8EJ-00010v-76
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:10:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1ux8EH-0003A2-7p
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:10:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3e34dbc38easo1285855f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757700635; x=1758305435; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9si+Uf804w0ESTyCjG5Lqt/5LJ22vn1+nXootdMN2Xg=;
 b=fO9HHRzVlAUlVynDzJWHZLORZRvtPjGGj0ALrw/+EnR2hhT8YJLzPVhgXdPEpairt9
 yh4A84O10zIcrqAmuLrPEXNnumigc0NQVG7E6KC5Sh9/uz8Z/9suMjTuzr+ptF7PBozW
 RGif2R0LbrARRKgyF/4U4avG40L4Gpxp6AUxDAwK3PuHLRmTS6IVKjubOz49owTxobkg
 h5rFMNu9C/L0OQtuVEUjbiM53SObqp1DP1nzKcWygrnM8bayi8rWOcuzl80oNZRgmaSw
 by8GzW5pgSHxEfpy51joB6YYZP6bqNpsSt8evbOMLARcJp/81lz8Wq/Sra8DyMTYfkN6
 DH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757700635; x=1758305435;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9si+Uf804w0ESTyCjG5Lqt/5LJ22vn1+nXootdMN2Xg=;
 b=ZYoH9o7DrVLGJKjPUldFC300sJaNxZVKlwoB52m2reY3XmddefvCE8CkRMoOnOUNpY
 dGqrOnyAhDnS5vebJqoS3P56W1yDSanLtvka2/NXCX7Zm9ILp5PEkazbGVtF1ndExaUI
 GvRAhf+O+9QKED3Z34/L+8CGbAMFtbEWWFeV37fpZhoWQ/9XUSDw1jhQo/q6/dbidA1t
 VZAv/l81U+OGHCID8VIoNUJUDyN+oOh37I72mcFb0m9+pg9mZtNoW/w4EXWQ+S1jzOQJ
 0akieWKsITfVIUA0ZxMGYCNpd0KYf4OQ7OEHEZJgY4bPHb7uja4SSyCrH/xg9ySVMReW
 1TLg==
X-Gm-Message-State: AOJu0YyUipjcDfXtY35V94tp2QhDqsffla00ZDXD1mO6QPDI0zxhgITG
 K2n9GEhOXPiaUfdSQcUDiJxOS6f2s4pUgP4DeAUoSnaqQfwn7Qm7wTB1
X-Gm-Gg: ASbGncvYWIFJX7D51fa5Z20Gp13XwBAXxUNdsD83lDBVAy4pOAedbIr8Yvha/YKnJSN
 NUh2/SjW8V5MbfLuuC0yp10jkT1WSq8nbtM2xOr/+k0yRj4aX2gabGkMojo6wo+SiXVcjSNzOzN
 FycO2cgzEnzU1sSeQRNzL159tlWC1Tvf98UxxkcBCzCDH3jlI7BURZ1j83P9J8WMychDHJ2mza+
 yiqtiGHTTj3ZJOiP71N38w9yvdv5Z/vPBZojlLquZRGQq3dikAquNVXstzv94YuZVQt7DBVzmKE
 DxNl2XMa/nTViDCwmOHOa2qE4e1HFmrPlwzy6PgjDvutcdKBGPsNsI5dqOaV9ztbn3MMeAG0Gtv
 QavwfKSjjKGBQxiyBwqfc+/1c3s5jxOKNbui9Qhqq6enfvDArLlHj0EOTtg==
X-Google-Smtp-Source: AGHT+IHad27V1PDDJoCsBu9AkDA7dU+1+ZJ1byS3oYPF3qRo/cU2RXcHs4girUwqKjl2p02GXjWlfg==
X-Received: by 2002:adf:a355:0:b0:3e7:67fd:56e1 with SMTP id
 ffacd0b85a97d-3e767fd5917mr2659873f8f.54.1757700634859; 
 Fri, 12 Sep 2025 11:10:34 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607d77b2sm7630794f8f.45.2025.09.12.11.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 11:10:34 -0700 (PDT)
Message-ID: <64d6252959750b8da6f3bc4ac7c738b10463bf6d.camel@gmail.com>
Subject: Re: [PATCH v4 07/10] qmp: add chardev-resize command
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Eric Blake	 <eblake@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum	
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Szymon Lukasz <noh4hss@gmail.com>, Daniel
 =?ISO-8859-1?Q?P=2EBerrang=E9?=	 <berrange@redhat.com>,
 devel@lists.libvirt.org
Date: Fri, 12 Sep 2025 20:10:32 +0200
In-Reply-To: <871pob7ot7.fsf@pond.sub.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-7-7925e444afc4@gmail.com>
 <871pob7ot7.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42e.google.com
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

On Fri, 2025-09-12 at 16:01 +0200, Markus Armbruster wrote:
> Cc: libvirt
>=20
> Filip Hejsek <filip.hejsek@gmail.com> writes:
>=20
> > From: Szymon Lukasz <noh4hss@gmail.com>
> >=20
> > The managment software can use this command to notify QEMU about the
> > size of the terminal connected to a chardev, QEMU can then forward this
> > information to the guest if the chardev is connected to a virtio consol=
e
> > device.
> >=20
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > ---
> >  chardev/char.c | 14 ++++++++++++++
> >  qapi/char.json | 22 ++++++++++++++++++++++
> >  2 files changed, 36 insertions(+)
> >=20
> > diff --git a/chardev/char.c b/chardev/char.c
> > index b45d79cb9b57643827eb7479257fdda2cf6b0434..6e3ade98614c949be8041ec=
5905a490ff536dee9 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -1269,6 +1269,20 @@ bool qmp_add_client_char(int fd, bool has_skipau=
th, bool skipauth,
> >      return true;
> >  }
> > =20
> > +void qmp_chardev_resize(const char *id, uint16_t cols, uint16_t rows,
> > +                        Error **errp)
> > +{
> > +    Chardev *chr;
> > +
> > +    chr =3D qemu_chr_find(id);
> > +    if (chr =3D=3D NULL) {
> > +        error_setg(errp, "Chardev '%s' not found", id);
> > +        return;
> > +    }
> > +
> > +    qemu_chr_resize(chr, cols, rows);
> > +}
> > +
> >  /*
> >   * Add a timeout callback for the chardev (in milliseconds), return
> >   * the GSource object created. Please use this to add timeout hook for
> > diff --git a/qapi/char.json b/qapi/char.json
> > index f0a53f742c8bee24c377551803a864fd36ac78cf..0a26c5eee6b71bc5de127a9=
1b253cc69a9fe8ce6 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -874,6 +874,28 @@
> >  { 'command': 'chardev-send-break',
> >    'data': { 'id': 'str' } }
> > =20
> > +##
> > +# @chardev-resize:
>=20
> This name doesn't tell me what is being resized.  PATCH 04 uses
> "winsize", which is better.  The (losely) related SIGWINCH suggests
> "window change" or "window size change".  Below, you use "terminal
> size".

How about chardev-console-resize? That would match the name of the
virtio event (VIRTIO_CONSOLE_RESIZE).

> > +#
> > +# Notifies a chardev about the current size of the terminal connected
> > +# to this chardev.
>=20
> Yes, but what is it good for?  Your commit message tells: "managment
> software can use this command to notify QEMU about the size of the
> terminal connected to a chardev, QEMU can then forward this information
> to the guest if the chardev is connected to a virtio console device."

How about:

   Notifies a chardev about the current size of the terminal connected
   to this chardev. The information will be forwarded to the guest if
   the chardev is connected to a virtio console device.

> > +#
> > +# @id: the chardev's ID, must exist
> > +# @cols: the number of columns
> > +# @rows: the number of rows
>=20
> Blank lines between the argument descriptions, bease.
>=20
> What's the initial size?

0x0

> Do we need a way to query the size?

I don't think it is necessary. What would be the usecase for that?

> > +#
> > +# Since: 10.2
> > +#
> > +# .. qmp-example::
> > +#
> > +#     -> { "execute": "chardev-resize", "arguments": { "id": "foo", "c=
ols": 80, "rows": 24 } }
> > +#     <- { "return": {} }
> > +##
> > +{ 'command': 'chardev-resize',
> > +  'data': { 'id': 'str',
> > +            'cols': 'uint16',
> > +            'rows': 'uint16' } }
> > +
> >  ##
> >  # @VSERPORT_CHANGE:
> >  #

