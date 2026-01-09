Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23E6D1681A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veAx2-0006Qf-5K; Fri, 09 Jan 2026 06:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1veAwy-0006NZ-H9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1veAws-0005O5-9k
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767959192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWPj3vU2t3wTODadJPf5AGD901cq/tufjmG+KdpOeVU=;
 b=ghIKzqUmmuesVe3tkMAZOw8+/j/ZRYZ3+X5U70IpDCUMi/waWFnqPOuo/hMZGYRvY27a2Z
 cw9yv2E1GdX6RqnFEFgsrH6EGPMDHCCV+BuipKC06BaazsJ/1FUVkIsb71MERaBojJQb5H
 025irhwnxzQnkphnLdvOhYkJTuKL62Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-iXWbRJSwPmqcpYCpby4cbQ-1; Fri,
 09 Jan 2026 06:46:28 -0500
X-MC-Unique: iXWbRJSwPmqcpYCpby4cbQ-1
X-Mimecast-MFC-AGG-ID: iXWbRJSwPmqcpYCpby4cbQ_1767959187
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F4A918005B2; Fri,  9 Jan 2026 11:46:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.39])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2156230002D2; Fri,  9 Jan 2026 11:46:20 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:46:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org,
 qemu-rust@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 02/24] include: define constant for early constructor
 priority
Message-ID: <aWDqie0eYZ8GeQHF@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-3-berrange@redhat.com>
 <d3ca3fb5-e972-4446-b32c-f20fd8825cca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3ca3fb5-e972-4446-b32c-f20fd8825cca@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 09, 2026 at 12:39:59PM +0100, Paolo Bonzini wrote:
> On 1/8/26 18:03, Daniel P. Berrangé wrote:
> > Functions marked with __attribute__((__constructor__)) will be
> > invoked in linker order. In theory this is well defined, but
> > in practice, it is hard to determine what this order will be
> > with the layers of indirection through meson, ninja and the
> > static libraries QEMU builds.
> > 
> > Notably, the order currently appears different between Linux
> > and Windows (as tested with Wine on Linux). This can cause
> > problems when certain QEMU constructors have a dependancy on
> > other QEMU constructors.
> 
> What dependency are you seeing, or introducing?
> 
> In theory QEMU constructors should not have any dependency, as we only use
> them to initialize static data structures (such as the various *_init
> macros).
> 
> Not an objection, but I'd like to understand this better.

See the commit message in patch 2.   Essentially the RCU thread
gets spawned from a constructor, and if anything it does results
in an error_report() call, it will trigger use of monitor APIs
before the monitor constructor has had a chance to run.

IMHO the root problem is that it is pretty dubious for us to be
spawning the RCU thread from a constructor. Constructors should
be limited to minimal initialization of state. Spawning threads
is outside the boundary of what I'd consider reasonable for
a constructor todo. I didn't want try to tackle refactoring the
RCU thread creation though, hence this gross workaround.

> 
> Paolo
> 
> > To address this define a QEMU_CONSTRUCTOR_EARLY constant which
> > provides a priority value that will run before other default
> > constructors. This is to be used for QEMU constructors that
> > are themselves self-contained, but may be relied upon by other
> > constructors.
> > 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   include/qemu/compiler.h | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> > index 1c2b673c05..4c49f52eb0 100644
> > --- a/include/qemu/compiler.h
> > +++ b/include/qemu/compiler.h
> > @@ -194,6 +194,14 @@
> >   # define QEMU_USED
> >   #endif
> > +/*
> > + * A priority for __attribute__((constructor(...))) that
> > + * will run earlier than the default constructors. Must
> > + * only be used for functions that have no dependency
> > + * on global initialization of other QEMU subsystems.
> > + */
> > +#define QEMU_CONSTRUCTOR_EARLY 101
> > +
> >   /*
> >    * Disable -ftrivial-auto-var-init on a local variable.
> >    *
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


