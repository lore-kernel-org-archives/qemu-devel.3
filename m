Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDDEE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 11:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTg5H-0003wh-1N; Fri, 03 Jan 2025 06:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tTg5E-0003vW-R9
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 06:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tTg5D-0000Dq-AE
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 06:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735904591;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GbbnoXYi8vumOwR9t+gdddIUMaxEXsmhheh1fffy3G8=;
 b=CmevW31sYhYg2I0GiMMthK+y10q268Us5bxI+Tm3taasGw1+GmzcMr9XQ21qjDOMV2zRej
 FAe7ts1aTBwaw9ITvFKgk5XaU/3wS/ELbWO3NVTyGWtT82TfrKbhYgUhbUuFacVT0YOcW+
 RGdzPn20TVCQQN6JtWxTvFJaDdegibI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-2tAAdk7lMcC8o4Ri3gdsTQ-1; Fri,
 03 Jan 2025 06:43:07 -0500
X-MC-Unique: 2tAAdk7lMcC8o4Ri3gdsTQ-1
X-Mimecast-MFC-AGG-ID: 2tAAdk7lMcC8o4Ri3gdsTQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63CBC195604F; Fri,  3 Jan 2025 11:43:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF0C21956056; Fri,  3 Jan 2025 11:43:03 +0000 (UTC)
Date: Fri, 3 Jan 2025 11:43:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: update copyright date to the year 2025
Message-ID: <Z3fNRM0SSmYGB_y9@redhat.com>
References: <20250101080116.1050336-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250101080116.1050336-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 01, 2025 at 01:31:16PM +0530, Ani Sinha wrote:
> We are already in January 2025! Update copyright notices.
> 
> Cc: peter.maydell@linaro.org
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  docs/conf.py              | 2 +-
>  include/qemu/help-texts.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/conf.py b/docs/conf.py
> index 164a8ee8b2..31bb9a3789 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -87,7 +87,7 @@
>  
>  # General information about the project.
>  project = u'QEMU'
> -copyright = u'2024, The QEMU Project Developers'
> +copyright = u'2025, The QEMU Project Developers'
>  author = u'The QEMU Project Developers'

How about we make this consistent with the help-texts.h  file
by making it cover the range of dates, as stuff that was authored
in 2024 and before , doesn't magically change its copyright date
to 2025, only new contribs get that.

>  
>  # The version info for the project you're documenting, acts as replacement for
> diff --git a/include/qemu/help-texts.h b/include/qemu/help-texts.h
> index 353ab2ad8b..bc8fab9169 100644
> --- a/include/qemu/help-texts.h
> +++ b/include/qemu/help-texts.h
> @@ -2,7 +2,7 @@
>  #define QEMU_HELP_TEXTS_H
>  
>  /* Copyright string for -version arguments, About dialogs, etc */
> -#define QEMU_COPYRIGHT "Copyright (c) 2003-2024 " \
> +#define QEMU_COPYRIGHT "Copyright (c) 2003-2025 " \
>      "Fabrice Bellard and the QEMU Project developers"
>  
>  /* Bug reporting information for --help arguments, About dialogs, etc */
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


