Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5A9CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0mw-0001Xu-Ep; Fri, 12 Sep 2025 06:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux0mu-0001Wu-Rw
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux0mm-00037B-CM
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757672020;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0WAF4058LshVFQkMEgHvZR8a5DBdwSgQC4z2fq1IKE=;
 b=GggomHn33yHBT3ImfNgBp0vD15/g6X6fBYN6ZDAoYIrO7phs9rz09xHHWaeZx2rTURqcEf
 AawQBPnW5TPpSfBMOMnX+eIEAYUsf67H/yE4yCMnyGgAmR1pBzrsryVv/1fm1eO40KpOHj
 iD8hJvHJvEqygemYKdFvFvzfjAcfdpM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-OTu2ebPuNP6hJOlcwx9MXQ-1; Fri,
 12 Sep 2025 06:13:37 -0400
X-MC-Unique: OTu2ebPuNP6hJOlcwx9MXQ-1
X-Mimecast-MFC-AGG-ID: OTu2ebPuNP6hJOlcwx9MXQ_1757672016
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED8301955D9D; Fri, 12 Sep 2025 10:13:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25B8A1954126; Fri, 12 Sep 2025 10:13:33 +0000 (UTC)
Date: Fri, 12 Sep 2025 11:13:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 08/12] util/oslib-win32: Revert warning on
 WSAEventSelect() failure
Message-ID: <aMPySq3b6FLndWQp@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-9-armbru@redhat.com>
 <aKRe6pTbdU0OZ85I@redhat.com> <87segvyhcv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87segvyhcv.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Tue, Sep 09, 2025 at 01:50:56PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Aug 08, 2025 at 10:08:19AM +0200, Markus Armbruster wrote:
> >> qemu_socket_select() and its wrapper qemu_socket_unselect() treat a
> >> NULL @errp as &error_warn.  This is wildly inappropriate.  A caller
> >> passing NULL specifies that errors are to be ignored.  If warnings are
> >> wanted, the caller must pass &error_warn.
> >> 
> >> I'm not familiar with the calling code, so I can't say whether it will
> >> work after WSAEventSelect() failure.  If it doesn't, then this should
> >> be an error.  If it does, then why bother the user with a warning that
> >> isn't actionable, and likely confusing?
> >> 
> >> The warning goes back to commit f5fd677ae7cf (win32/socket: introduce
> >> qemu_socket_select() helper).  Before that commit, the error was
> >> ignored, as indicated by passing a null @errp.  Revert to that
> >> behavior.
> >> 
> >> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  util/oslib-win32.c | 4 ----
> >>  1 file changed, 4 deletions(-)
> >> 
> >> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> >> index b7351634ec..136a8fe118 100644
> >> --- a/util/oslib-win32.c
> >> +++ b/util/oslib-win32.c
> >> @@ -296,10 +296,6 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
> >>  {
> >>      SOCKET s = _get_osfhandle(sockfd);
> >>  
> >> -    if (errp == NULL) {
> >> -        errp = &error_warn;
> >> -    }
> >
> > This makes sense, but I'd want the callers to be using warn_report
> > instead. Ideally some (but not all) of the callers would propagate
> > the error, but this isn't practical with the QIOChannel create
> > watch function usage. I'd want to keep Error *errp on this function
> > though, and have warn_report as a sign to our future selves that
> > this is still not ideal.
> 
> The direct callers are qio_channel_create_socket_watch(),
> aio_set_fd_handler().  Callers via qemu_socket_unselect() are
> qio_channel_socket_finalize(), qio_channel_socket_close(),
> qemu_socket_set_block().
> 
> All but qio_channel_socket_close() cannot fail.  Would you like me to
> make them pass &error_warn, because warning is less bad than silence
> there?
> 
> qio_channel_socket_close() can fail, but it ignores
> qemu_socket_unselect() failure.  What do you want me to do there?

I think the overriding important thing is that we /must/ try to
close(), and if close() succeeds claim the whole qio_channel_socket_close
was successful. So I guess I'd say that &error_warn should be passed
from all callers.

> 
> >> -
> >>      if (s == INVALID_SOCKET) {
> >>          error_setg(errp, "invalid socket fd=%d", sockfd);
> >>          return false;
> >> -- 
> >> 2.49.0
> >> 
> >> 
> >
> > With regards,
> > Daniel
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


