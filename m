Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E12FD62060
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 09:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDKlL-0000ws-82; Tue, 19 Nov 2024 04:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKlH-0000wc-Br
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKlE-0004Jc-So
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732009383;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TK9cB4WfRO3mG3NVJxMfDENbfeF/Fct913yasg6X9BE=;
 b=VdGvdASfrEAz3MpFC+Ze6Wo2ed87lqSWBK4kHjW4mfH7ipmnCda0hU6108xK7woZqTNM9m
 9PXgXXh0NajsH+0pqgdgVqI2s/7bSCZcrfuLi9KahTfuSnrpAAcUHEng18cVsJTYtPl5mF
 d5Rqx8XUsfEbbS/KF+zXa1HS6qI5RfQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-9jcjO0NjM8CSnxJJXN-SeA-1; Tue,
 19 Nov 2024 04:43:00 -0500
X-MC-Unique: 9jcjO0NjM8CSnxJJXN-SeA-1
X-Mimecast-MFC-AGG-ID: 9jcjO0NjM8CSnxJJXN-SeA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19EA319541A0; Tue, 19 Nov 2024 09:42:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0514419560A3; Tue, 19 Nov 2024 09:42:50 +0000 (UTC)
Date: Tue, 19 Nov 2024 09:42:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/5] qom: Add TYPE_CONTAINER macro
Message-ID: <ZzxdlQJE-8nyWb0w@redhat.com>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118221330.3480246-2-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Nov 18, 2024 at 05:13:26PM -0500, Peter Xu wrote:
> Provide a macro for the container type across QEMU source tree, rather than
> hard code it every time.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qom/object.h | 3 ++-
>  hw/arm/stellaris.c   | 2 +-
>  qom/container.c      | 4 ++--
>  qom/object.c         | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 43c135984a..8162a1ef17 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -25,7 +25,8 @@ typedef struct TypeInfo TypeInfo;
>  typedef struct InterfaceClass InterfaceClass;
>  typedef struct InterfaceInfo InterfaceInfo;
>  
> -#define TYPE_OBJECT "object"
> +#define  TYPE_OBJECT                 "object"
> +#define  TYPE_CONTAINER              "container"

nitpick - 1 space too many before "TYPE_", and it is not worth
trying to vertically align "object" and "container", just leave
the existing line for TYPE_OBJECT unchanged.



>  
>  typedef struct ObjectProperty ObjectProperty;
>  
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 376746251e..6d518b9cde 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1053,7 +1053,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
>      flash_size = (((board->dc0 & 0xffff) + 1) << 1) * 1024;
>      sram_size = ((board->dc0 >> 18) + 1) * 1024;
>  
> -    soc_container = object_new("container");
> +    soc_container = object_new(TYPE_CONTAINER);
>      object_property_add_child(OBJECT(ms), "soc", soc_container);
>  
>      /* Flash programming is done via the SCU, so pretend it is ROM.  */
> diff --git a/qom/container.c b/qom/container.c
> index 455e8410c6..cfec92a944 100644
> --- a/qom/container.c
> +++ b/qom/container.c
> @@ -15,7 +15,7 @@
>  #include "qemu/module.h"
>  
>  static const TypeInfo container_info = {
> -    .name          = "container",
> +    .name          = TYPE_CONTAINER,
>      .parent        = TYPE_OBJECT,
>  };
>  
> @@ -37,7 +37,7 @@ Object *container_get(Object *root, const char *path)
>      for (i = 1; parts[i] != NULL; i++, obj = child) {
>          child = object_resolve_path_component(obj, parts[i]);
>          if (!child) {
> -            child = object_new("container");
> +            child = object_new(TYPE_CONTAINER);
>              object_property_add_child(obj, parts[i], child);
>              object_unref(child);
>          }
> diff --git a/qom/object.c b/qom/object.c
> index 9edc06d391..214d6eb4c1 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1739,7 +1739,7 @@ Object *object_get_root(void)
>      static Object *root;
>  
>      if (!root) {
> -        root = object_new("container");
> +        root = object_new(TYPE_CONTAINER);
>      }
>  
>      return root;
> @@ -1755,7 +1755,7 @@ Object *object_get_internal_root(void)
>      static Object *internal_root;
>  
>      if (!internal_root) {
> -        internal_root = object_new("container");
> +        internal_root = object_new(TYPE_CONTAINER);
>      }
>  
>      return internal_root;
> -- 
> 2.45.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


