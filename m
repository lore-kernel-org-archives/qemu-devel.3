Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B132DC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 10:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uho-0001v5-AK; Fri, 17 May 2024 06:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7uhm-0001tB-Hv
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7uhj-00041v-Py
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715941246;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fqlupgtD5NjBl5O4T/wLswLljoFlVWaxihdpMTkit14=;
 b=Dmeu0g2HmJFtWtl37p48Gzjvunz+RQa8ZDvTjdZWOGBzGKZYB20/ufpWt81wJB5CSbOR3K
 Bzvd/q52opFx413ZbxokR/iXWmC11yq4VwgZv9SS+LAMu7ZDLcZ/+D3NofeZFpCYf3OfA7
 /EzyoaLjlVDWXJrQwiENdkZRZldS0to=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-ozyPgEdsOlizjJe3gt5SDg-1; Fri,
 17 May 2024 06:20:44 -0400
X-MC-Unique: ozyPgEdsOlizjJe3gt5SDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 945B329ABA1D;
 Fri, 17 May 2024 10:20:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CF07200B4D0;
 Fri, 17 May 2024 10:20:42 +0000 (UTC)
Date: Fri, 17 May 2024 11:20:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] ui/sdl2: Allow host to power down screen
Message-ID: <ZkcveOHUV6sfGvK7@redhat.com>
References: <20240512095945.1879-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240512095945.1879-1-shentey@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cc stable - candidate for backport perhaps.

On Sun, May 12, 2024 at 11:59:45AM +0200, Bernhard Beschow wrote:
> By default, SDL disables the screen saver which prevents the host from powering
> down the screen even if the screen is locked. This results in draining the
> battery needlessly when the host isn't connected to a wall charger. Fix that by
> enabling the screen saver.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  ui/sdl2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 4971963f00..0a0eb5a42d 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -874,6 +874,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>      SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>  #endif
>      SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
> +    SDL_EnableScreenSaver();
>      memset(&info, 0, sizeof(info));
>      SDL_VERSION(&info.version);
>  
> -- 
> 2.45.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


