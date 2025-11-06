Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864E3CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 12:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGyyg-0005WP-6v; Thu, 06 Nov 2025 07:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGyyd-0005W2-SL
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGyyZ-00084P-KP
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762431625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5g7ev95xL9/ONFNO0JRDwxk8m2WbwjJDI0tLNKGnff8=;
 b=b0TkoeToxZV/GYPjVzKbNZ8ACV9EjWHG0sNVeYZUO4isPgKoWb4x6E7wnFNSBr6UEhxfws
 ldRwvXxzb8PwyLiJBuq3ob81ubGNY3QP5HduIimKH9zMRcTrmERnePInyV6alozKd3jo3R
 xOHxC+xuo0UvfBLcK6jcN6m2xc2SjnE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-rCh8XxlZPfSfP2xpyVCNFA-1; Thu,
 06 Nov 2025 07:20:22 -0500
X-MC-Unique: rCh8XxlZPfSfP2xpyVCNFA-1
X-Mimecast-MFC-AGG-ID: rCh8XxlZPfSfP2xpyVCNFA_1762431621
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0B93195609E; Thu,  6 Nov 2025 12:20:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.67])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B3C13001E83; Thu,  6 Nov 2025 12:20:19 +0000 (UTC)
Date: Thu, 6 Nov 2025 13:20:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 1/8] qio: Add trace points to net_listener
Message-ID: <aQySgdWUe1LXRNDq@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-11-eblake@redhat.com>
 <aQneugckIJ-skmTr@redhat.com>
 <ehwnhhrnfncvgqgkbqo2ejuecj7jfkowgfzsw26xbi7rt2qqdh@ajudfowin4lm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ehwnhhrnfncvgqgkbqo2ejuecj7jfkowgfzsw26xbi7rt2qqdh@ajudfowin4lm>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 05.11.2025 um 18:18 hat Eric Blake geschrieben:
> On Tue, Nov 04, 2025 at 12:08:42PM +0100, Kevin Wolf wrote:
> > Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:
> > > Upcoming patches will adjust how net_listener watches for new client
> > > connections; adding trace points now makes it easier to debug that the
> > > changes work as intended.  For example, adding
> > > --trace='qio_net_listener*' to the qemu-storage-daemon command line
> > > before --nbd-server will track when the server first starts listening
> > > for clients.
> > > 
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >  io/net-listener.c | 17 +++++++++++++++++
> > >  io/trace-events   |  5 +++++
> > >  2 files changed, 22 insertions(+)
> > > 
> > > diff --git a/io/net-listener.c b/io/net-listener.c
> > > index 47405965a66..0adbc409cf2 100644
> > > --- a/io/net-listener.c
> > > +++ b/io/net-listener.c
> > > @@ -23,6 +23,7 @@
> > >  #include "io/dns-resolver.h"
> > >  #include "qapi/error.h"
> > >  #include "qemu/module.h"
> > > +#include "trace.h"
> > > 
> > >  QIONetListener *qio_net_listener_new(void)
> > >  {
> > > @@ -50,6 +51,7 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
> > >          return TRUE;
> > >      }
> > > 
> > > +    trace_qio_net_listener_callback(listener, listener->io_func);
> > >      if (listener->io_func) {
> > >          listener->io_func(listener, sioc, listener->io_data);
> > >      }
> > 
> > Not necessarily a problem, but I wonder why you decided to have the
> > trace point unconditional here...
> > 
> > > @@ -143,6 +147,9 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
> > >  {
> > >      size_t i;
> > > 
> > > +    if (listener->io_func) {
> > > +        trace_qio_net_listener_watch_disabled(listener, "set_client_func");
> > > +    }
> > >      if (listener->io_notify) {
> > >          listener->io_notify(listener->io_data);
> > >      }
> > 
> > ...while everywhere else you only call it with a non-NULL
> > listener->io_func.
> 
> In the former, the trace is printing out the address of which io_func
> (including NULL) is currently registered when the callback is reached.
> In the case where a single NetListener registers more than one socket
> address, but the user uninstalls their callback after the first client
> to connect, it is still possible that other pending connections have
> still raced, at which point the qio_net_listener_channel_func can
> still fire on those later connections even though there is no longer
> an io_func from the user.  In all the latter cases, I was merely
> tracing when state transitioned between the user installing a handler
> or removing one.
> 
> Unless you think it would be to noisy, I'm game for changing this in
> v2 to have all of the traces be unconditional.  It is potentially
> noisier, but also would aid in spotting how many times a client
> requests no change to the current io_func or lack thereof.

I think being noisy in traces is okay. It's easy enough to filter the
output for non-NULL instances if that's what you need. In debugging I
usually want more data, having too much data is rarely a problem.

> Also worth thinking about: in this patch, I added new traces under the
> names enabled/disabled, with the trace points being reacable from
> multiple locations.  Then in 4/8, when refactoring to consolidate
> duplicate code, the trace points are reduced to a single usage in
> functions named watch/unwatch.  It may be worth rethinking naming to
> have the tracepoint and function names share the same terminology.

Yes, that's a good idea.

Kevin


