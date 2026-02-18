Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14232E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 10:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsf5D-0001Rj-4P; Wed, 18 Feb 2026 05:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsf5A-0001PH-WF
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsf58-0002yz-1X
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771411617;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/gS1bfakrMHEcgC2UCvlDrBeRvIx432WANeWWdviwg=;
 b=cVg37bpMsMjrlYGi04WAsqytrg4L/B24KsDORb453nuDGpX7oCFOYzfW6PgizCrhNd20B+
 U5+x7mtZ8go1JT/Hn5ufW8COcxK7mSg5pov30MrRtaXH6VIB8CD2rZToH4qZ/WSm5gfKIH
 6Q7XLvZSjeHxJHf6of4sf9/Irr4qPZQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-cqYfNNgxP2ix4GYMyqQDbQ-1; Wed,
 18 Feb 2026 05:46:54 -0500
X-MC-Unique: cqYfNNgxP2ix4GYMyqQDbQ-1
X-Mimecast-MFC-AGG-ID: cqYfNNgxP2ix4GYMyqQDbQ_1771411612
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56370180057E; Wed, 18 Feb 2026 10:46:52 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D90B1955F43; Wed, 18 Feb 2026 10:46:46 +0000 (UTC)
Date: Wed, 18 Feb 2026 10:46:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 03/27] include: define constant for early constructor
 priority
Message-ID: <aZWYkm8ma6sI3gkg@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-4-berrange@redhat.com>
 <87342yflt8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87342yflt8.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 18, 2026 at 10:22:27AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
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
> >
> > To address this define a QEMU_CONSTRUCTOR_EARLY constant which
> > provides a priority value that will run before other default
> > constructors. This is to be used for QEMU constructors that
> > are themselves self-contained, but may be relied upon by other
> > constructors.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> I'm no fan of doing non-trivial work in constructors.  We discussed
> possible alternatives in review of v5.  This is an opinion, not a
> demand.  And Paolo's opinion counts a lot more here.

I think that it is worth exploring the alternative idea, but not
as part of this series which is already getting way longer than
I would like. This constructor usage is trivially removed later
if we get there.

> 
> > ---
> >  include/qemu/compiler.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> > index 1c2b673c05..4c49f52eb0 100644
> > --- a/include/qemu/compiler.h
> > +++ b/include/qemu/compiler.h
> > @@ -194,6 +194,14 @@
> >  # define QEMU_USED
> >  #endif
> >  
> > +/*
> > + * A priority for __attribute__((constructor(...))) that
> > + * will run earlier than the default constructors. Must
> > + * only be used for functions that have no dependency
> > + * on global initialization of other QEMU subsystems.
> > + */
> > +#define QEMU_CONSTRUCTOR_EARLY 101
> > +
> >  /*
> >   * Disable -ftrivial-auto-var-init on a local variable.
> >   *
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


