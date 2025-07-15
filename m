Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54DCC83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbT8-0006yX-WB; Tue, 15 Jul 2025 04:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubbSf-0006tm-2w
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubbSa-0000Q6-QA
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752569783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knwSLB+BX+IZKliRbEus3Z1Vk4BcIyODlJqhb0gL8IY=;
 b=RIBarEMloD8dcXHAkkzofHKWe3l4Re6YNrSXo7f9i4gmaX8CfYx0nFZA6XUsTqKDG10K0D
 TLR5X/crM029kYBhxUUAVpkKLu8gwMIrnVSGBas8AcUghiDQb6ItBkv00a3zeyTyP5HPEy
 3InS4PfnCeCUEEWZ9Yw6v11+4Jt3MxM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-kpl1abrZPTu0S1AVTiTl1w-1; Tue,
 15 Jul 2025 04:56:19 -0400
X-MC-Unique: kpl1abrZPTu0S1AVTiTl1w-1
X-Mimecast-MFC-AGG-ID: kpl1abrZPTu0S1AVTiTl1w_1752569778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7284195609F; Tue, 15 Jul 2025 08:56:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B79019560A3; Tue, 15 Jul 2025 08:56:12 +0000 (UTC)
Date: Tue, 15 Jul 2025 09:56:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-block@nongnu.org
Subject: Re: [RFC PATCH 2/2] system/os-win32: Remove unused Error** argument
 in qemu_socket_select
Message-ID: <aHYXqRUPOVbyw0mN@redhat.com>
References: <20250715083517.47556-1-philmd@linaro.org>
 <20250715083517.47556-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715083517.47556-3-philmd@linaro.org>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 10:35:17AM +0200, Philippe Mathieu-Daudé wrote:
> @errp is always NULL. Remove it, as unused.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/system/os-win32.h |  2 +-
>  util/aio-win32.c          |  2 +-
>  util/oslib-win32.c        | 13 +++++--------
>  3 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index 40712a948c3..47882bc2f49 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -170,7 +170,7 @@ static inline void qemu_funlockfile(FILE *f)
>  
>  /* Helper for WSAEventSelect, to report errors */
>  bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
> -                        long lNetworkEvents, Error **errp);
> +                        long lNetworkEvents);
>  
>  bool qemu_socket_unselect(int sockfd);
>  
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index 6583d5c5f31..9c2f0fb86e7 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -121,7 +121,7 @@ void aio_set_fd_handler(AioContext *ctx,
>  
>          QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
>          event = event_notifier_get_handle(&ctx->notifier);
> -        qemu_socket_select(fd, event, bitmask, NULL);
> +        qemu_socket_select(fd, event, bitmask);

This should likely be &error_abort, as we never expect this
to fail AFAICT.


> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 7ac3482d449..fed5ab14efb 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -292,21 +292,18 @@ char *qemu_get_pid_name(pid_t pid)
>  
>  
>  bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
> -                        long lNetworkEvents, Error **errp)
> +                        long lNetworkEvents)
>  {
>      SOCKET s = _get_osfhandle(sockfd);
>  
> -    if (errp == NULL) {
> -        errp = &error_warn;
> -    }

This pre-existing code should never have existed - the caller should
have decided this reporting policy by passing in &error_warn.

> -
>      if (s == INVALID_SOCKET) {
> -        error_setg(errp, "invalid socket fd=%d", sockfd);
> +        error_setg(&error_warn, "invalid socket fd=%d", sockfd);
>          return false;
>      }
>  
>      if (WSAEventSelect(s, hEventObject, lNetworkEvents) != 0) {
> -        error_setg_win32(errp, WSAGetLastError(), "failed to WSAEventSelect()");
> +        error_setg_win32(&error_warn, WSAGetLastError(),
> +                         "failed to WSAEventSelect()");
>          return false;
>      }
>  
> @@ -315,7 +312,7 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


