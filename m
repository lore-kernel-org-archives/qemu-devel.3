Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EC5C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0yv-00047T-9V; Tue, 25 Jun 2024 03:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sM0yt-000476-MR
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sM0yr-0007B9-Vp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719301964;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9BLfO/gD0AlxX0haHkXVg0oUYpArG6enGccampreuEE=;
 b=HDvAxKFz0boJlLsLX6bDBRXBQqAGiSd4biJ106CCGGgtrOx7Scc4HyJ8cWYMw2w0NcMWsh
 FEHl9THYzCeEUuXeTiwi0eE4UYLNAbivV+uxccDZt0zI9J72ptlrjmQiwnnocVit5ce6xc
 CFe0/982CUtTVLj9i0ZtdXAw+A7pMmE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-_7ZMuGUdOZqRlhSdrUcdPw-1; Tue,
 25 Jun 2024 03:52:41 -0400
X-MC-Unique: _7ZMuGUdOZqRlhSdrUcdPw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A41A19560B1; Tue, 25 Jun 2024 07:52:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 017B919560BF; Tue, 25 Jun 2024 07:52:37 +0000 (UTC)
Date: Tue, 25 Jun 2024 08:52:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Felix Wu <flwu@google.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Roman Kiryanov <rkir@google.com>
Subject: Re: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
Message-ID: <Znp3QTTrlHDhwRA_@redhat.com>
References: <20240624205647.112034-1-flwu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240624205647.112034-1-flwu@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On Mon, Jun 24, 2024 at 08:56:47PM +0000, Felix Wu wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> to use the QEMU headers with a C++ compiler.
> 
> Signed-off-by: Felix Wu <flwu@google.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  include/qemu/atomic.h   |  8 ++++++++
>  include/qemu/atomic.hpp | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 include/qemu/atomic.hpp
> 
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index 99110abefb..aeaecc440a 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -20,6 +20,13 @@
>  /* Compiler barrier */
>  #define barrier()   ({ asm volatile("" ::: "memory"); (void)0; })
>  
> +#ifdef __cplusplus
> +
> +#ifndef typeof_strip_qual
> +#error Use the typeof_strip_qual(expr) definition from atomic.hpp on C++ builds.
> +#endif
> +
> +#else  /* __cpluplus */
>  /* The variable that receives the old value of an atomically-accessed
>   * variable must be non-qualified, because atomic builtins return values
>   * through a pointer-type argument as in __atomic_load(&var, &old, MODEL).
> @@ -61,6 +68,7 @@
>          __builtin_types_compatible_p(typeof(expr), const volatile unsigned short), \
>          (unsigned short)1,                                                         \
>        (expr)+0))))))
> +#endif  /* __cpluplus */
>  
>  #ifndef __ATOMIC_RELAXED
>  #error "Expecting C11 atomic ops"
> diff --git a/include/qemu/atomic.hpp b/include/qemu/atomic.hpp
> new file mode 100644
> index 0000000000..5844e3d427
> --- /dev/null
> +++ b/include/qemu/atomic.hpp

snip

IMHO we don't want to see this code in QEMU - we are a C project, not a
C++ project.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


