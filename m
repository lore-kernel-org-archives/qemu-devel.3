Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9B2C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzjm-0004Qu-65; Wed, 16 Jul 2025 06:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubzih-00038T-12
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubzid-0001dx-Hd
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752663034;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dozKJgDd6RGu0xt6mbLW82FDE4IZQplR1LeO0cZYeEE=;
 b=LT8XRLLZdhBeluMbV9pXEkWlog8kpmpgJhqEpQU8nyNiMFU5/BQbiojFKLR406uKgriNJp
 k00W2Mp+zCiVeMQgrJciXINsY4JS8TM2GmQi5qlx2y/4tzeZAH5yYPMCoi1bvqd+Sk/Mh5
 eoK1mLxWu4XFkcwgU9NzI0RDm2jkSo0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-CBxXucT5MrS9Uw55n3MGIQ-1; Wed,
 16 Jul 2025 06:50:31 -0400
X-MC-Unique: CBxXucT5MrS9Uw55n3MGIQ-1
X-Mimecast-MFC-AGG-ID: CBxXucT5MrS9Uw55n3MGIQ_1752663030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF8CC1800283; Wed, 16 Jul 2025 10:50:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.68])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4452B195E772; Wed, 16 Jul 2025 10:50:25 +0000 (UTC)
Date: Wed, 16 Jul 2025 11:50:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org
Subject: Re: [RFC PATCH 1/2] system/os-win32: Remove unused Error** argument
 in qemu_socket_unselect
Message-ID: <aHeD7oWuKE_GKF4j@redhat.com>
References: <20250715083517.47556-1-philmd@linaro.org>
 <20250715083517.47556-2-philmd@linaro.org>
 <aHYXP3XNpZVUug9c@redhat.com> <87tt3cto2s.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt3cto2s.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 12:41:31PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Jul 15, 2025 at 10:35:16AM +0200, Philippe Mathieu-Daudé wrote:
> >> @errp is always NULL. Remove it, as unused.
> >> 
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> ---
> >>  include/system/os-win32.h | 2 +-
> >>  io/channel-socket.c       | 4 ++--
> >>  util/oslib-win32.c        | 6 +++---
> >>  3 files changed, 6 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> >> index 3aa6cee4c23..40712a948c3 100644
> >> --- a/include/system/os-win32.h
> >> +++ b/include/system/os-win32.h
> >> @@ -172,7 +172,7 @@ static inline void qemu_funlockfile(FILE *f)
> >>  bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
> >>                          long lNetworkEvents, Error **errp);
> >>  
> >> -bool qemu_socket_unselect(int sockfd, Error **errp);
> >> +bool qemu_socket_unselect(int sockfd);
> >>  
> >>  /* We wrap all the sockets functions so that we can set errno based on
> >>   * WSAGetLastError(), and use file-descriptors instead of SOCKET.
> >> diff --git a/io/channel-socket.c b/io/channel-socket.c
> >> index 3b7ca924ff3..6ee6217e7ac 100644
> >> --- a/io/channel-socket.c
> >> +++ b/io/channel-socket.c
> >> @@ -454,7 +454,7 @@ static void qio_channel_socket_finalize(Object *obj)
> 
>     static void qio_channel_socket_finalize(Object *obj)
>     {
>         QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(obj);
> 
>         if (ioc->fd != -1) {
>             QIOChannel *ioc_local = QIO_CHANNEL(ioc);
>             if (qio_channel_has_feature(ioc_local, QIO_CHANNEL_FEATURE_LISTEN)) {
>                 Error *err = NULL;
> 
>                 socket_listen_cleanup(ioc->fd, &err);
>                 if (err) {
>                     error_report_err(err);
>                     err = NULL;
> >>              }
> >>          }
> >>  #ifdef WIN32
> >> -        qemu_socket_unselect(ioc->fd, NULL);
> >> +        qemu_socket_unselect(ioc->fd);
> >>  #endif
> >
> > It seems to me like this code should instead be using
> > &error_warn, because the errors are still relevant and
> > potentially a sign of a bug, but we don't want to stop
> > this finalization path.
> 
> Would such a warning be actionable for the user?
> 
> Why is this failure a warning, but the failure right above is an error?
> 
> What are the possible failures?
> 
> On reporting errors with error_report() & friends: doing so within a
> function that uses an Error **errp parameter to return errors is almost
> always wrong.  Can qio_channel_socket_finalize() run within such a
> function?

No finalize() function can ever propagate errors - these are run
transparently when the "unref" drops the last reference count.
So error_report is the best we can manage in finalize functions.

It is actionable for the user in so much as if they see such
warnings, it is sign of a code bug somewhere and this will be
a useful diagnostic to receive in the bug report.

> 
> >
> >>          close(ioc->fd);
> >>          ioc->fd = -1;
> >> @@ -890,7 +890,7 @@ qio_channel_socket_close(QIOChannel *ioc,
> >>  
> >>      if (sioc->fd != -1) {
> >>  #ifdef WIN32
> >> -        qemu_socket_unselect(sioc->fd, NULL);
> >> +        qemu_socket_unselect(sioc->fd);
> >>  #endif
> >
> > Here too, we don't want to stop the close operation early,
> > as we need to 'close()' the FD, but we should diagnose
> > the failure none the less
> 
> Same questions.

Close can propagate errors, but we need a little more careful dance.
We really really really want to still successfully close the underlying
socket FD, and if that causes an error too, we'll prefer to see the
latter error, over this earlier error IMHO. So we should propagate an
error here, but delay propagation until the rest of this method has
run.

> 
> >>          if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_LISTEN)) {
> >>              socket_listen_cleanup(sioc->fd, errp);
> 
> [...]
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


