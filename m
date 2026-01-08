Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE6ECF6A88
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdm6M-0007lO-OP; Thu, 08 Jan 2026 04:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdm6L-0007kR-5F
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdm6J-0003Qd-8s
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767863678;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMyjlcggJ8EMWKwRp2jxIjxq1TO88m4Jc6i0eInAljQ=;
 b=UxhqzIcgVjpHqVtJIulv5lEQbzDH2F/1CCAV4XAiz14vwQRkHa4UFsRzKdv8q/dJguF2+a
 JytxGII0bShePK7hLWbxUYG2A4D2BXyR+VZUGCw3HWd8Uue3O1Jf0xS8wVr790c8muq7Ua
 Yri8reSeQ7bDTtXriVwfsI5biXEwBmo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-SGgnYwmZMrqyynpIT46nhA-1; Thu,
 08 Jan 2026 04:14:34 -0500
X-MC-Unique: SGgnYwmZMrqyynpIT46nhA-1
X-Mimecast-MFC-AGG-ID: SGgnYwmZMrqyynpIT46nhA_1767863673
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8675218002C5; Thu,  8 Jan 2026 09:14:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 352B21956048; Thu,  8 Jan 2026 09:14:32 +0000 (UTC)
Date: Thu, 8 Jan 2026 09:14:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, philmd@linaro.org
Subject: Re: [PATCH] hmp-commands-info.hx: Move definition of "info accel"
Message-ID: <aV91daSxVxvCGMCa@redhat.com>
References: <20260108083249.1602654-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108083249.1602654-1-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Jan 08, 2026 at 09:32:49AM +0100, Markus Armbruster wrote:
> Commit c10eb740108 (accel/system: Add 'info accel' on human monitor)
> inserted "info accel" in the middle of "info sync-profile".  Move it
> behind "info sync-profile".

Opps, we have this kind of mistake over & over again. The .hx format
is really horrible and easy to make this mistake with, and makes me
rather wish we could eliminate it :-(



> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp-commands-info.hx | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 41674dcbe1..74c741f80e 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -267,18 +267,6 @@ ERST
>          .cmd        = hmp_info_sync_profile,
>      },
>  
> -    {
> -        .name       = "accel",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show accelerator statistics",
> -    },
> -
> -SRST
> -  ``info accel``
> -    Show accelerator statistics.
> -ERST
> -
>  SRST
>    ``info sync-profile [-m|-n]`` [*max*]
>      Show synchronization profiling info, up to *max* entries (default: 10),
> @@ -294,6 +282,18 @@ SRST
>      being coalesced.
>  ERST
>  
> +    {
> +        .name       = "accel",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show accelerator statistics",
> +    },
> +
> +SRST
> +  ``info accel``
> +    Show accelerator statistics.
> +ERST
> +
>      {
>          .name       = "kvm",
>          .args_type  = "",
> -- 
> 2.52.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


