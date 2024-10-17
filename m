Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D73D2126D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1NB6-00028T-41; Thu, 17 Oct 2024 05:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1NB5-000287-0L
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1NB3-0008N9-Do
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729158736;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRCZu92U+3lT4QZfQdKJZNnd4n6WwOeUzsWnG0liseA=;
 b=XLrceho+SX9/GNYiqhSSaoyu9FmyGdzBmvA7biNzfGoP5a2wWaEtpvc9wRePe8tXxyfRar
 tUFzMZTp1tnt47Cleps9j5d6eRKpWqQBFRK39jB6Ib4cnlmB3KROVDm0Xtaw3W8882ZDzO
 orKJSFigebceAkybXNjBsYg8PIaCQfc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-1bRzhTVeOmK3Zi-zVEnIjQ-1; Thu,
 17 Oct 2024 05:52:14 -0400
X-MC-Unique: 1bRzhTVeOmK3Zi-zVEnIjQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E82C51956069; Thu, 17 Oct 2024 09:52:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D08CD19560A7; Thu, 17 Oct 2024 09:52:09 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:52:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Brad Smith <brad@comstyle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr_ Lureau <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] meson.build: Remove ncurses workaround for OpenBSD
Message-ID: <ZxDeRtTWpsvxN3WI@redhat.com>
References: <ZwnvT4srOStQopOr@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwnvT4srOStQopOr@humpty.home.comstyle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Cc'ing qemu-trivial

On Fri, Oct 11, 2024 at 11:38:55PM -0400, Brad Smith wrote:
> meson.build: Remove ncurses workaround for OpenBSD
> 
> OpenBSD 7.5 has upgraded to ncurses 6.4.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  meson.build | 2 +-
>  ui/curses.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/meson.build b/meson.build
> index 4ea1984fc5..22e7629d81 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1374,7 +1374,7 @@ iconv = not_found
>  curses = not_found
>  if have_system and get_option('curses').allowed()
>    curses_test = '''
> -    #if defined(__APPLE__) || defined(__OpenBSD__)
> +    #ifdef __APPLE__
>      #define _XOPEN_SOURCE_EXTENDED 1
>      #endif
>      #include <locale.h>
> diff --git a/ui/curses.c b/ui/curses.c
> index ec61615f7c..4d0be9b37d 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -38,7 +38,7 @@
>  #include "ui/input.h"
>  #include "sysemu/sysemu.h"
>  
> -#if defined(__APPLE__) || defined(__OpenBSD__)
> +#ifdef __APPLE__
>  #define _XOPEN_SOURCE_EXTENDED 1
>  #endif


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


