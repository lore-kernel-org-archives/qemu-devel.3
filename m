Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21EBC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjeO-0004jB-QK; Fri, 17 Jan 2025 05:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYjeM-0004cS-31
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:32:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYjeI-0005Y8-MJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737109940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6zq2jtYKo1LOyV5JL+vA74nZFGCjc53R41fTQ/inXMw=;
 b=cTPqj4VRjyQ5QV6B7d+tX/wJDwPnl31jrKRmop2MoWmn4LomYnWB4ft3qAsOrE5D43zeOT
 SvrJjB+wj73Gv0SSuF7Jp/AbHZ2PpDS2x6Vfjo3Oq3KKTRvTIpb0ZSVtk40H11pX4g3iRB
 3/jpLm2UfJ+oR+QaWpnN7GDAMm2/AgQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-jAGSp6tePbWcnIGoRCKIwQ-1; Fri,
 17 Jan 2025 05:32:19 -0500
X-MC-Unique: jAGSp6tePbWcnIGoRCKIwQ-1
X-Mimecast-MFC-AGG-ID: jAGSp6tePbWcnIGoRCKIwQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 492EE19560B0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:32:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AEFB19560AD; Fri, 17 Jan 2025 10:32:16 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:32:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 0/8] qapi-go: add generator for Golang interfaces
Message-ID: <Z4oxrUkIWNDJtwan@redhat.com>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <874j22ooza.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874j22ooza.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 13, 2025 at 01:52:25PM +0100, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
> 
> > This patch series intent is to introduce a generator that produces a Go
> > module for Go applications to interact over QMP with QEMU.
> >
> > The initial Goal is to have a Go module that works as intended and can
> > be improved upon. I'd consider initial releases to be alpha while we
> > work with utilities tools and libraries on top of this.
> >
> > The generated code should reside in a separated Git repository, similar
> > to python-qemu-qmp.
> >
> > Applications should be able to consume this under qemu.org
> > namespace (e.g: import "qemu.org/go/qemu"), see Daniel's suggestion:
> > https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg07024.html
> >
> > This is the third iteration:
> > v2: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04785.html
> >
> > I've pushed this series in my gitlab fork:
> > https://gitlab.com/victortoso/qapi-go/
> >
> > The fork contains some tests, including tests that were generated from
> > QAPI's own examples from another generator created for testing, if you
> > are interested in it:
> > https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04946.html
> >
> > I've generated the qapi-go module over each commit of this series, see:
> > https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-patch
> >
> > I've also generated the qapi-go module over QEMU tags: v9.1.0, v9.2.0:
> > https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v3-by-tags
> >
> > --
> >
> > Sorry that its been awhile between v2 and v3, I had to prioritize other
> > things. I hope to get this back on track in 2025.
> >
> > Cheers,
> > Victor
> >
> > * Changes:
> >
> > On generated go:
> >  - the output should be formatted as gofmt/goimports tools (Daniel)
> >
> >  - Included QAPI's documentation too (Daniel), see:
> >    https://lists.gnu.org/archive/html/qemu-devel/2024-11/msg01621.html
> >     
> >  - Commands and Events should Marshal directly (Andrea)
> >
> > On python script:
> >  - rebased: now uses QAPISchemaBranches, QAPISchemaAlternatives
> >
> >  - use textwrap as much as possible (Andrea)
> >
> >  - lots of changes to make the output like gofmt does
> >
> > Victor Toso (8):
> >   qapi: golang: Generate enum type
> >   qapi: golang: Generate alternate types
> >   qapi: golang: Generate struct types
> >   qapi: golang: structs: Address nullable members
> >   qapi: golang: Generate union type
> >   qapi: golang: Generate event type
> >   qapi: golang: Generate command type
> >   docs: add notes on Golang code generator
> >
> >  docs/devel/index-build.rst          |    1 +
> >  docs/devel/qapi-golang-code-gen.rst |  548 +++++++++
> >  scripts/qapi/golang.py              | 1645 +++++++++++++++++++++++++++
> >  scripts/qapi/main.py                |    3 +
> >  4 files changed, 2197 insertions(+)
> >  create mode 100644 docs/devel/qapi-golang-code-gen.rst
> >  create mode 100644 scripts/qapi/golang.py
> 
> This is series adds a backend that slots in cleanly, i.e. without any
> changes to the core.  That makes it as low-risk to merge as it gets.
> 
> I'd like an Acked-by for the generated Go from someone familiar the kind
> of software that could use it.

In my other (huge) reply to this thread I tried to provide that
analysis by imagining how I would want to consume a QEMU API in
Go, creating an example application and trying to see how well
it fits with this design.

> The -* files are all one pair of files per module (the things pulled in
> with include directives), if any.  We do this to avoid "touch the QAPI
> schema, recompile the world."
> 
> The generated Go is monolithic.  No "recompile the world" problem with
> Go?

IIUC, the intent is that we dn't generate the go code as part of the
regular QEMU build. IOW, most of the time it would be generate once
against a release tag. If someone was actively working on QAPI schema
on git master, at the same time as developing a Go application, they'll
have a bit more of a repeated compile penalty. I'm not convinced that's
a big enough common case to worry about modularizing though.

> golang.py is somewhat big.  Whether splitting it up along the lines of
> the C backend would improve things I can't say.  No need to worry about
> that now.

With the monolothic go code, generated once per release tag, Go is
going to be reusing cached previously compiled objects most of the
time. I think that's likely to be good enough.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


