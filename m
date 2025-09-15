Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9ACCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 22:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyHdD-0004kQ-ES; Mon, 15 Sep 2025 18:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyHd2-0004jq-8o
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:24:56 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyHaz-0004m4-A0
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:24:50 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-afcb7322da8so180846666b.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757974965; x=1758579765; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=skklARrPmD4M6aZRsTLvMkkhok/6vzLeO8WV41uLebk=;
 b=PccTMBCTaj/SK2AYTM5EgAXHtc5chsrJO+Y7Zk7rIRt358XQ21Q+VjQTKrIw1DQpjI
 QsR5l7Yqpfh6rVGHmLBYqlOYEN+aK4xatowFeWH6pKRPSoOjueWqj1rskcUBIT4zydkl
 RoH1p5Y72XOmTT5Dw7yxz/vf803/spDx5XAib8ObxfOXHM74ol3B0ivQymsykKps3YCd
 1yWCWUW4h5a6AKxdMxQmsy1diu7Ic3y6GyCKi9gH/2s6NbH8H/m1y4YMN+ZKNZH9gqTP
 jdLBDXwP7/kkRr9ptmnREXubIrBRNWo2O9rfnxFKKQOQvER2v5W0xuTFMyuJu+UNn0Z5
 Xrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757974965; x=1758579765;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=skklARrPmD4M6aZRsTLvMkkhok/6vzLeO8WV41uLebk=;
 b=EmtTFLBD02MA6/jcgD6wQ47rB1C6N28OfJejbPTuNuf8xTTcZnUa4ww60ln6PniDEs
 /rp9CXOwMSXYkLqeFZwGoUGYa8VxDEIlKQrAN6LewQPVvurcqZwVdEFTytYTKUaedDZx
 Ni7VvdmLVJmKqOerDPRWW4GMjP/6x8Ab2c05x/nsexefNDoEfW7sFkcG8A8pH2CAnVDc
 H/So0QaMEqECW3+Q9k1UqtkX7hEweJFz+EFfv6/RDdPViOTrxXTc7LV3fsx/Vjw2kSQ9
 haZVrC9h1y5XJW2hCHKWoH3GVMu6Wsc2pdhjSTdkmzAThkPXVqxs0svdcSTZTrSz0qnY
 UQQA==
X-Gm-Message-State: AOJu0YwutMZCFEhiLYtrnD1V5LA/8vD6ENZlvDjDWg1/hR135YLRc5Pf
 1T4HyJUwKeAQ/0zwbl+TqGKovtrldlyTQ0HSyLCSvh0zVtX12IErYGTrcveqJtvW
X-Gm-Gg: ASbGnctwe1paHTf2IBNZxQmv6CbaxjwnXxk2wRGYTRZ5SXkxmLWcWF5mwNHGtt4a3c2
 HDBqkOMyU1ykW+PtF+Ibt5rgfzZZlZxQBTv5fibaNcBVX6SnclIz/45oxK0YKoiNV1qeg9X/Aw7
 KQukLlQmFAUcjcll69onTbmp7/LjKRy1Gu6Akb3re5gCH/wCj1SYYncp0xGvxnwQW6yrCMcr9N4
 ivOFjvtRhwFyPCT+XWXKXYSbThb86KOMISArUh+eglfs3a7lak2BR5sWj3Cg+I1wmsuBo6N7qtp
 ONOAFxRm/ZMidX403CcCJ3wlL2f0g6zhWQvbqkZ83Yp6pYfcze08tXiFu2vThVM6QpMfk7zVTmy
 FOpWdoMYPSDdRPwHKwzIdSOJkeDydf4ZbBWAYy7oLYQxqsiu0TIX/WdbKgRd2
X-Google-Smtp-Source: AGHT+IHYo/aqIMEjT999Hl0YmvMX2oO1r5AknvcOV2r6W25f8zVTTI9bnW0w0MGKBcJieCx94/pLjg==
X-Received: by 2002:a17:907:9717:b0:b07:88ef:fe1c with SMTP id
 a640c23a62f3a-b07c386a791mr1415668366b.44.1757974964845; 
 Mon, 15 Sep 2025 15:22:44 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b32f20dcsm1017713266b.90.2025.09.15.15.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 15:22:44 -0700 (PDT)
Message-ID: <ffa90309f0ce8c81836e5e7074d67ae76033b67f.camel@gmail.com>
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
Date: Tue, 16 Sep 2025 00:22:43 +0200
In-Reply-To: <87cy7s1auw.fsf@pond.sub.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-7-7925e444afc4@gmail.com>
 <871pob7ot7.fsf@pond.sub.org>
 <64d6252959750b8da6f3bc4ac7c738b10463bf6d.camel@gmail.com>
 <87cy7s1auw.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x62c.google.com
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

On Mon, 2025-09-15 at 08:35 +0200, Markus Armbruster wrote:
> Filip Hejsek <filip.hejsek@gmail.com> writes:
>=20
> > On Fri, 2025-09-12 at 16:01 +0200, Markus Armbruster wrote:
> > > Cc: libvirt
> > >=20
> > > Filip Hejsek <filip.hejsek@gmail.com> writes:
> > >=20
> > > > From: Szymon Lukasz <noh4hss@gmail.com>
> > > >=20
> > > > The managment software can use this command to notify QEMU about th=
e
> > > > size of the terminal connected to a chardev, QEMU can then forward =
this
> > > > information to the guest if the chardev is connected to a virtio co=
nsole
> > > > device.
> > > >=20
> > > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > > ---
> > > >  chardev/char.c | 14 ++++++++++++++
> > > >  qapi/char.json | 22 ++++++++++++++++++++++
> > > >  2 files changed, 36 insertions(+)
> > > >=20
> > > > diff --git a/chardev/char.c b/chardev/char.c
> > > > index b45d79cb9b57643827eb7479257fdda2cf6b0434..6e3ade98614c949be80=
41ec5905a490ff536dee9 100644
> > > > --- a/chardev/char.c
> > > > +++ b/chardev/char.c
> > > > @@ -1269,6 +1269,20 @@ bool qmp_add_client_char(int fd, bool has_sk=
ipauth, bool skipauth,
> > > >      return true;
> > > >  }
> > > > =20
> > > > +void qmp_chardev_resize(const char *id, uint16_t cols, uint16_t ro=
ws,
> > > > +                        Error **errp)
> > > > +{
> > > > +    Chardev *chr;
> > > > +
> > > > +    chr =3D qemu_chr_find(id);
> > > > +    if (chr =3D=3D NULL) {
> > > > +        error_setg(errp, "Chardev '%s' not found", id);
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    qemu_chr_resize(chr, cols, rows);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Add a timeout callback for the chardev (in milliseconds), retur=
n
> > > >   * the GSource object created. Please use this to add timeout hook=
 for
> > > > diff --git a/qapi/char.json b/qapi/char.json
> > > > index f0a53f742c8bee24c377551803a864fd36ac78cf..0a26c5eee6b71bc5de1=
27a91b253cc69a9fe8ce6 100644
> > > > --- a/qapi/char.json
> > > > +++ b/qapi/char.json
> > > > @@ -874,6 +874,28 @@
> > > >  { 'command': 'chardev-send-break',
> > > >    'data': { 'id': 'str' } }
> > > > =20
> > > > +##
> > > > +# @chardev-resize:
> > >=20
> > > This name doesn't tell me what is being resized.  PATCH 04 uses
> > > "winsize", which is better.  The (losely) related SIGWINCH suggests
> > > "window change" or "window size change".  Below, you use "terminal
> > > size".
> >=20
> > How about chardev-console-resize? That would match the name of the
> > virtio event (VIRTIO_CONSOLE_RESIZE).
>=20
> Not bad.  It could become slightly bad if we make devices other than
> "consoles" make us of it.  Would that be possible?

I don't think the size has any meaning for devices that are not
connected to a console, although the code does not care whether it
actually is a console and simply has a size for every chardev.

I guess I could also rename it to chardev-window-resize
or chardev-set-window-size. Let me know if you prefer one of these.


> > > > +#
> > > > +# Notifies a chardev about the current size of the terminal connec=
ted
> > > > +# to this chardev.
> > >=20
> > > Yes, but what is it good for?  Your commit message tells: "managment
> > > software can use this command to notify QEMU about the size of the
> > > terminal connected to a chardev, QEMU can then forward this informati=
on
> > > to the guest if the chardev is connected to a virtio console device."
> >=20
> > How about:
> >=20
> >    Notifies a chardev about the current size of the terminal connected
> >    to this chardev. The information will be forwarded to the guest if
> >    the chardev is connected to a virtio console device.
>=20
> Works for me.
>=20
> > > > +#
> > > > +# @id: the chardev's ID, must exist
> > > > +# @cols: the number of columns
> > > > +# @rows: the number of rows
> > >=20
> > > Blank lines between the argument descriptions, bease.
> > >=20
> > > What's the initial size?
> >=20
> > 0x0
>=20
> A clearly invalid size.  I guess it effectively means "unknown size".
> Should we document that?

Probably. 0x0 is I think also the default size in the Linux kernel, but
I don't think the Linux kernel documents this. Another question is if
the 0x0 size should be propagated to the guest over virtio. I think it
should be, although the virtio spec says nothing about 0x0 size.

I'm not sure what is the right place to document this.

> > > Do we need a way to query the size?
> >=20
> > I don't think it is necessary. What would be the usecase for that?
>=20
> I don't know, but it's my standard question when I see an interface to
> set something without an interface to get it.  Its purpose is to make us
> think, not to make us at the get blindly.

I guess it might be useful for debugging. If the size is not propagated
correctly, one might query it to find out on which side the problem is.

> > > > +#
> > > > +# Since: 10.2
> > > > +#
> > > > +# .. qmp-example::
> > > > +#
> > > > +#     -> { "execute": "chardev-resize", "arguments": { "id": "foo"=
, "cols": 80, "rows": 24 } }
> > > > +#     <- { "return": {} }
> > > > +##
> > > > +{ 'command': 'chardev-resize',
> > > > +  'data': { 'id': 'str',
> > > > +            'cols': 'uint16',
> > > > +            'rows': 'uint16' } }
> > > > +
> > > >  ##
> > > >  # @VSERPORT_CHANGE:
> > > >  #

