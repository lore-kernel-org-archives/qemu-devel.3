Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86815F54ACE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53uA-0002Ej-66; Tue, 24 Mar 2026 11:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w53u7-0002EQ-Rz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w53u3-0003CR-Ji
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774366966;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnwMJ3qGZlzJGkYh/0Y4i23O0OgWs0wimC/Jpa5XtXc=;
 b=OPLuWJ570Ok/9BTwrr93O0CTnp5TgOW4pgDvZ+Hc4ZQNJYyrtDwr9eTYonlPrqkw9pOK0i
 1DZmdbK7zScdGY36I8MHdu3p4It03LNDu83R+22KCfSLwGso9ZZwj0m+ZsKAJR4dgv5SIq
 lt49eS8D1Mb8tOjQR0ljrItkxMc/P4Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-kkDd2KgcNsSNe6OnIb2VNA-1; Tue,
 24 Mar 2026 11:42:44 -0400
X-MC-Unique: kkDd2KgcNsSNe6OnIb2VNA-1
X-Mimecast-MFC-AGG-ID: kkDd2KgcNsSNe6OnIb2VNA_1774366963
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C407018005B0; Tue, 24 Mar 2026 15:42:43 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76039180058B; Tue, 24 Mar 2026 15:42:42 +0000 (UTC)
Date: Tue, 24 Mar 2026 15:42:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 11/60] ui/console-vc: add UTF-8 input decoding with CP437
 rendering
Message-ID: <acKw7t2QmIqvcTLa@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-11-48eb1dcf7b76@redhat.com>
 <acKapSJlHBvEiVHh@redhat.com>
 <CAJ+F1CKicWCcm64SD9DRGXPmu6BJKHpXxYQNHd+rp5YWJziw8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKicWCcm64SD9DRGXPmu6BJKHpXxYQNHd+rp5YWJziw8w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 24, 2026 at 06:17:37PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Mar 24, 2026 at 6:08 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Mar 17, 2026 at 12:50:25PM +0400, Marc-André Lureau wrote:
> > > The text console receives bytes that may be UTF-8 encoded (e.g. from
> > > a guest running a modern distro), but currently treats each byte as a
> > > raw character index into the VGA/CP437 font, producing garbled output
> > > for any multi-byte sequence.
> > >
> > > Add a proper UTF-8 decoder using Bjoern Hoehrmann's DFA.
> > > The DFA inherently rejects overlong encodings, surrogates, and
> > > codepoints above U+10FFFF.  Completed codepoints are then mapped to
> > > CP437, unmappable characters are displayed as '?'.
> >
> > I'm surprised we can't do a charset conversion using GLib APIs ?
> >
> > Do the g_convert family of  APIs (which IIUC wrap the distro iconv)
> > not do what we would want ? If not, would direct use of iconv not
> > be an alternative ?
> >
> 
> I tried to use GIconv but ran into a number of issues, as it doesn't
> operate on character level, but strings. And it uses allocation etc. I
> didn't manage with iconv either.

Looking again, the g_utf8_validate function is /almost/ what we
want, but its API design collapses both "invalid utf8" and
"incomplete character" into the same error return value, so we
can't distinguish them to decide whether to wait for more bytes
or reset the state :-(

So yeah, I can see why this is needed now.

> 
> > It feels pretty wrong to need to embed UTF8 decoding code in
> > QEMU
> 
> Yes, but on a standalone qemu-vnc server, is it more acceptable?

IIUC, this will be linked into regular QEMU too, right ?

> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  ui/cp437.h      |  13 ++++
> > >  ui/console-vc.c |  62 +++++++++++++++++
> > >  ui/cp437.c      | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  ui/meson.build  |   2 +-
> > >  4 files changed, 281 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/ui/cp437.h b/ui/cp437.h
> > > new file mode 100644
> > > index 00000000000..81ace8317c7
> > > --- /dev/null
> > > +++ b/ui/cp437.h
> > > @@ -0,0 +1,13 @@
> > > +/*
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * Copyright (c) QEMU contributors
> > > + */
> > > +#ifndef QEMU_CP437_H
> > > +#define QEMU_CP437_H
> > > +
> > > +#include <stdint.h>

Shouldn't be required, since it is pulled in by osdep.h

> > > +
> > > +int unicode_to_cp437(uint32_t codepoint);

Perhaps better as qemu_unicode_to_cp437 

> > > +
> > > +#endif /* QEMU_CP437_H */


> > > diff --git a/ui/console-vc.c b/ui/console-vc.c
> > > index 8dee1f9bd01..7bbd65dea27 100644
> > > --- a/ui/console-vc.c
> > > +++ b/ui/console-vc.c
> > > @@ -9,6 +9,7 @@
> > >  #include "qemu/fifo8.h"
> > >  #include "qemu/option.h"
> > >  #include "ui/console.h"
> > > +#include "ui/cp437.h"
> > >
> > >  #include "trace.h"
> > >  #include "console-priv.h"
> > > @@ -89,6 +90,8 @@ struct VCChardev {
> > >      enum TTYState state;
> > >      int esc_params[MAX_ESC_PARAMS];
> > >      int nb_esc_params;
> > > +    uint32_t utf8_state;     /* UTF-8 DFA decoder state */
> > > +    uint32_t utf8_codepoint; /* accumulated UTF-8 code point */
> > >      TextAttributes t_attrib; /* currently active text attributes */
> > >      TextAttributes t_attrib_saved;
> > >      int x_saved, y_saved;
> > > @@ -598,6 +601,47 @@ static void vc_clear_xy(VCChardev *vc, int x, int y)
> > >      vc_update_xy(vc, x, y);
> > >  }
> > >
> > > +/*
> > > + * UTF-8 DFA decoder by Bjoern Hoehrmann.
> > > + * Copyright (c) 2008-2010 Bjoern Hoehrmann <bjoern@hoehrmann.de>
> > > + * See https://github.com/polijan/utf8_decode for details.
> > > + *
> > > + * SPDX-License-Identifier: MIT
> > > + */
> > > +#define UTF8_ACCEPT 0
> > > +#define UTF8_REJECT 12

This is an awfully generic define name, could we use something with
QEMU_ as a prefix to avoid risk of clashes with any external headers
we import

> > > +
> > > +static const uint8_t utf8d[] = {
> > > +    /* character class lookup */
> > > +    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> > > +    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> > > +    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> > > +    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> > > +    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,
> > > +    7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,  7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
> > > +    8,8,2,2,2,2,2,2,2,2,2,2,2,2,2,2,  2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
> > > +   10,3,3,3,3,3,3,3,3,3,3,3,3,4,3,3, 11,6,6,6,5,8,8,8,8,8,8,8,8,8,8,8,
> > > +
> > > +    /* state transition lookup */
> > > +     0,12,24,36,60,96,84,12,12,12,48,72, 12,12,12,12,12,12,12,12,12,12,12,12,
> > > +    12, 0,12,12,12,12,12, 0,12, 0,12,12, 12,24,12,12,12,12,12,24,12,24,12,12,
> > > +    12,12,12,12,12,12,12,24,12,12,12,12, 12,24,12,12,12,12,12,12,12,24,12,12,
> > > +    12,12,12,12,12,12,12,36,12,36,12,12, 12,36,12,12,12,12,12,36,12,36,12,12,
> > > +    12,36,12,12,12,12,12,12,12,12,12,12,
> > > +};
> > > +
> > > +static uint32_t utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
> > > +{
> > > +    uint32_t type = utf8d[byte];
> > > +
> > > +    *codep = (*state != UTF8_ACCEPT) ?
> > > +        (byte & 0x3fu) | (*codep << 6) :
> > > +        (0xffu >> type) & (byte);
> > > +
> > > +    *state = utf8d[256 + *state + type];
> > > +    return *state;
> > > +}
> > > +
> > >  static void vc_put_one(VCChardev *vc, int ch)
> > >  {
> > >      QemuTextConsole *s = vc->console;
> > > @@ -761,6 +805,24 @@ static void vc_putchar(VCChardev *vc, int ch)
> > >
> > >      switch(vc->state) {
> > >      case TTY_STATE_NORM:
> > > +        /* Feed byte through the UTF-8 DFA decoder */
> > > +        if (ch >= 0x80) {
> > > +            switch (utf8_decode(&vc->utf8_state, &vc->utf8_codepoint, ch)) {
> > > +            case UTF8_ACCEPT:
> > > +                vc_put_one(vc, unicode_to_cp437(vc->utf8_codepoint));
> > > +                break;
> > > +            case UTF8_REJECT:
> > > +                /* Reset state so the decoder can resync */
> > > +                vc->utf8_state = UTF8_ACCEPT;
> > > +                break;
> > > +            default:
> > > +                /* Need more bytes */
> > > +                break;
> > > +            }
> > > +            break;
> > > +        }
> > > +        /* ASCII byte: abort any pending UTF-8 sequence */
> > > +        vc->utf8_state = UTF8_ACCEPT;
> > >          switch(ch) {
> > >          case '\r':  /* carriage return */
> > >              s->x = 0;

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


