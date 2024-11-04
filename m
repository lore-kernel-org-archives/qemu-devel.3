Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409CBD132A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tBq-0006On-KO; Mon, 04 Nov 2024 04:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7tBo-0006ON-VK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7tBm-0003qa-PM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730711756;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DK+d0fi7OAA1IW6t/kAIfcjny1ikLgn8KATZ+gPzCdE=;
 b=GrY6D1NI3tD7vGA9I+xv4WoG5kBiOAM43zVklm3JOMoaUvGfWr4I/ml1LP1vkLSP17Cmq5
 O00lee2zeFIbZ5BVJZ7xlKgzOXVbgy2h6dExDvLXHqGxvlmLr6YWo+toW+xxFOeeJlJWyf
 4NgmEtMf/H4lQOiPY3L5ziSIe9QwRbg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-ugZbYRiHO56jTN7mErTWLw-1; Mon,
 04 Nov 2024 04:15:52 -0500
X-MC-Unique: ugZbYRiHO56jTN7mErTWLw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63DA81955D45; Mon,  4 Nov 2024 09:15:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.152])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 376D719560A2; Mon,  4 Nov 2024 09:15:49 +0000 (UTC)
Date: Mon, 4 Nov 2024 09:15:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: jansene@google.com, stefanha@redhat.com, mads@ynddal.dk,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/tracetool:Use posix paths in trace event
 generation
Message-ID: <ZyiQTQC7l0qgLE1j@redhat.com>
References: <20241101205616.3332303-1-roqueh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101205616.3332303-1-roqueh@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Fri, Nov 01, 2024 at 08:56:16PM +0000, Roque Arcudia Hernandez wrote:
> On windows machines the path seperator is '\\' (backslash) which causes
> the tracetool generator to output line information in the source code
> with the '\\' character. This in turn confuses the compiler, causing
> build breaks.
> 
> We now will always use posix paths, so the paths will use a '/'
> (forward) slash.
> 
> Signed-off-by: Erwin Jansen <jansene@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  scripts/tracetool/__init__.py       | 3 ++-
>  scripts/tracetool/backend/ftrace.py | 5 +++--
>  scripts/tracetool/backend/log.py    | 5 +++--
>  scripts/tracetool/backend/syslog.py | 6 +++---
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index bc03238c0f..ccab820532 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -15,6 +15,7 @@
>  import re
>  import sys
>  import weakref
> +from pathlib import Path
>  
>  import tracetool.format
>  import tracetool.backend
> @@ -55,7 +56,7 @@ def out(*lines, **kwargs):
>      for l in lines:
>          kwargs['out_lineno'] = out_lineno
>          kwargs['out_next_lineno'] = out_lineno + 1
> -        kwargs['out_filename'] = out_filename
> +        kwargs['out_filename'] = Path(out_filename).as_posix()
>          output.append(l % kwargs)
>          out_lineno += 1
>  
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
> index baed2ae61c..940c9be980 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -12,7 +12,8 @@
>  __email__      = "stefanha@redhat.com"
>  
>  
> -import os.path
> +from os.path import relpath
> +from pathlib import Path

There is no need to use os.path here - the Path object has
the 'relative_to' method.

>  
>  from tracetool import out
>  
> @@ -47,7 +48,7 @@ def generate_h(event, group):
>          args=event.args,
>          event_id="TRACE_" + event.name.upper(),
>          event_lineno=event.lineno,
> -        event_filename=os.path.relpath(event.filename),
> +        event_filename=Path(relpath(event.filename)).as_posix(),
>          fmt=event.fmt.rstrip("\n"),
>          argnames=argnames)
>  
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> index de27b7e62e..626840eef7 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -12,7 +12,8 @@
>  __email__      = "stefanha@redhat.com"
>  
>  
> -import os.path
> +from pathlib import Path
> +from os.path import relpath
>  
>  from tracetool import out
>  
> @@ -55,7 +56,7 @@ def generate_h(event, group):
>          '    }',
>          cond=cond,
>          event_lineno=event.lineno,
> -        event_filename=os.path.relpath(event.filename),
> +        event_filename=Path(relpath(event.filename)).as_posix(),
>          name=event.name,
>          fmt=event.fmt.rstrip("\n"),
>          argnames=argnames)
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
> index 012970f6cc..32e4bba4f9 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -11,8 +11,8 @@
>  __maintainer__ = "Stefan Hajnoczi"
>  __email__      = "stefanha@redhat.com"
>  
> -
> -import os.path
> +from os.path import relpath
> +from pathlib import Path
>  
>  from tracetool import out
>  
> @@ -43,7 +43,7 @@ def generate_h(event, group):
>          '    }',
>          cond=cond,
>          event_lineno=event.lineno,
> -        event_filename=os.path.relpath(event.filename),
> +        event_filename=Path(relpath(event.filename)).as_posix(),
>          name=event.name,
>          fmt=event.fmt.rstrip("\n"),
>          argnames=argnames)
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


