Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33648C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZIu-0001dA-KA; Tue, 19 Mar 2024 09:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmZIm-0001Vx-HC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmZIZ-0006ZM-6c
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710854074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVE5JViJ40Md1+mEJOs3jOjBeakDYIzuCSeE8EVZ9pk=;
 b=JoBKtU8ngFyvvLxMtI8UuRAbjDyEGfd5KsnffSIbcm2VqXjXD51MpHDyVleS0W6wrq2xRT
 HVAyorsIU289Wo5bXcUHOW5rn+KVfLjd1o0EB7uUR4nBcFXuYFKBRCltZatzReVAObqsuT
 rakrV6j/rHLW94ilQoQ28AhxpJMnn6o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-53eoeGSsMW-wE2nURZkkoA-1; Tue,
 19 Mar 2024 09:14:32 -0400
X-MC-Unique: 53eoeGSsMW-wE2nURZkkoA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C40228B6AA4
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:14:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FE49492BD1;
 Tue, 19 Mar 2024 13:14:31 +0000 (UTC)
Date: Tue, 19 Mar 2024 13:14:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/3 for 9.0] Revert "chardev/char-socket: Fix TLS io
 channels sending too much data to the backend"
Message-ID: <ZfmPse9su6yGdfm9@redhat.com>
References: <20240318182330.96738-1-berrange@redhat.com>
 <20240318182330.96738-3-berrange@redhat.com>
 <CAMxuvaz6_pRAaNX8zD-EGdTvhPhGcTEs8n+=tZOAYNLVAAc8hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaz6_pRAaNX8zD-EGdTvhPhGcTEs8n+=tZOAYNLVAAc8hw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 18, 2024 at 11:09:23PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Mar 18, 2024 at 10:23 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > This commit results in unexpected termination of the TLS connection.
> > When 'fd_can_read' returns 0, the code goes on to pass a zero length
> > buffer to qio_channel_read. The TLS impl calls into gnutls_recv()
> > with this zero length buffer, at which point GNUTLS returns an error
> > GNUTLS_E_INVALID_REQUEST. This is treated as fatal by QEMU's TLS code
> > resulting in the connection being torn down by the chardev.
> >
> > Simply skipping the qio_channel_read when the buffer length is zero
> > is also not satisfactory, as it results in a high CPU burn busy loop
> > massively slowing QEMU's functionality.
> >
> > The proper solution is to avoid tcp_chr_read being called at all
> > unless the frontend is able to accept more data. This will be done
> > in a followup commit.
> >
> > This reverts commit 1907f4d149c3589ade641423c6a33fd7598fa4d3.
> 
> Actually 462945cd22d2bcd233401ed3aa167d83a8e35b05 upstream.

Opps, yes, will fix this before I send a pull.

> 
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  chardev/char-socket.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 2c4dffc0e6..812d7aa38a 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -496,9 +496,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
> >          s->max_size <= 0) {
> >          return TRUE;
> >      }
> > -    len = tcp_chr_read_poll(opaque);
> > -    if (len > sizeof(buf)) {
> > -        len = sizeof(buf);
> > +    len = sizeof(buf);
> > +    if (len > s->max_size) {
> > +        len = s->max_size;
> >      }
> >      size = tcp_chr_recv(chr, (void *)buf, len);
> >      if (size == 0 || (size == -1 && errno != EAGAIN)) {
> > --
> > 2.43.0
> >
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


