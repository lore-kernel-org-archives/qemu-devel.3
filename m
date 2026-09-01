Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9769EC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SCZ-0000Zc-A6; Tue, 01 Sep 2026 13:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1SCX-0000Yu-Dc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1SCV-0005WS-Iz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788283390;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/ffUOUEi3kHWNW69YTwLD/LMWHV6LMaVk5HsLAZjlw=;
 b=TZRH9P2/zaErkYfd5ySNYPjwpszRgvqP5nmhW8CbrQ/csSxPJKQ4ngCVoRhsRLaoPSf5uw
 GuDxJDi2658il1wuagBDh+z/BnCNPJfO42u9oFbnxk574QdImdZjZDwDsoQCwplX/mB5Jh
 Pu91aHysU1hTrHORxXxA0OAKPR9Z7yM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-lMc5vSaFP86QWA2TMnDaxQ-1; Tue,
 01 Sept 2026 13:23:07 -0400
X-MC-Unique: lMc5vSaFP86QWA2TMnDaxQ-1
X-Mimecast-MFC-AGG-ID: lMc5vSaFP86QWA2TMnDaxQ_1788283386
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 004131808993; Tue,  1 Sep 2026 17:23:06 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50D3C18001D0; Tue,  1 Sep 2026 17:23:04 +0000 (UTC)
Date: Tue, 1 Sep 2026 18:23:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 2/6] io/channel-websock: send an HTTP 400 when the
 greeting has no space
Message-ID: <apcJ9QHhPjxq55tb@redhat.com>
References: <20260831100151.914178-1-den@openvz.org>
 <20260831100151.914178-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831100151.914178-3-den@openvz.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 31, 2026 at 12:01:47PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> qio_channel_websock_extract_headers() returns 0 without queueing a
> response when the request line contains no space, unlike every sibling
> check which jumps to bad_request. encoutput stays empty, yet
> qio_channel_websock_handshake_read() still reports success and the
> caller arms a G_IO_OUT watch to flush nothing.
> 
> Flushing that empty buffer is where QEMU crashes. Any client can
> trigger it before authentication on a VNC websocket port:
> 
>   printf 'stats\r\nx\r\n\r\n' | nc $host $port
> 
> Fixes: 07e95cd529af ("io: fully parse & validate HTTP headers for websocket protocol handshake")

"bad_request" was introduced in f69a8bde29354493ff8aea64cc9cb3b531d16337
which intended to fix 07e95cd529af, but missed that one return statement.
So I'd suggest "Fixes: f69a8bde29", or even both commits.

> Cc: qemu-stable@nongnu.org
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  io/channel-websock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 1929abf56a..66c91ed2a2 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -230,7 +230,7 @@ qio_channel_websock_extract_headers(QIOChannelWebsock *ioc,
>      tmp = strchr(buffer, ' ');
>      if (!tmp) {
>          error_setg(errp, "Missing HTTP path delimiter");
> -        return 0;
> +        goto bad_request;
>      }
>      *tmp = '\0';
>  
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


