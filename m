Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8218C02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 10:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXeIA-0007Eg-2t; Tue, 14 Jan 2025 05:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tXeI8-0007EJ-ER
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tXeI6-00057m-QQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736851016;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+wIij7lE88opCM2d11tIf70zHjCeycRbizhStjyX3II=;
 b=fdygmSylOc8snX6UfbEOXYGAzLI6/hNjcwxdCpRlMl4QV8YQ7aawOQCFMs/QOz1yss4kKY
 t3mM0afN5E4ZaJwxxzv6+p6fHmZt4qOVoQtBP0kMvxWnd1qgttdTgGpsYo7wJWBFh9PFnP
 d3U9h1FQ0n39Dd76aD3fEKKT+UKxU8o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-7EQ6iFcsMl-HNx-pHz168w-1; Tue,
 14 Jan 2025 05:36:54 -0500
X-MC-Unique: 7EQ6iFcsMl-HNx-pHz168w-1
X-Mimecast-MFC-AGG-ID: 7EQ6iFcsMl-HNx-pHz168w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D55641954B0E
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 10:36:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C369819560A3; Tue, 14 Jan 2025 10:36:51 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:36:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 1/8] qapi: golang: Generate enum type
Message-ID: <Z4Y-QG5qWMRI7alY@redhat.com>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <20250110104946.74960-2-victortoso@redhat.com>
 <878qrdkcag.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qrdkcag.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 14, 2025 at 09:52:23AM +0100, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
> 
> > This patch handles QAPI enum types and generates its equivalent in Go.
> > We sort the output based on enum's type name.
> 
> Any particular reason for sorting?
> 
> The existing backends generate output it source order, on the (bold?)
> assumption that developers care to pick an order that makes sense.

Even if that assumption is valid (and I question whether it really is),
what makes sense to a QEMU maintainer is not the same as what makes
sense to a consumer of QEMU.

Our approach to file splitting is fairly arbitrary

First, we've got a split across sub-systems, except where we don't.

Sometimes one subsystem splits into many files. eg block.json vs
block-core.json vs block-export.json

Sometimes we just pull something into a standalone file even when it
is not really a subsystem just common code. eg sockets.json

Sometimes we have a split because its convenient for QEMU linux-user
vs system compilation & ELF linker needs. eg misc.json vs misc-target.json 

At best we can say that the split of files is intentionally done for the
convenience of the QEMU maintainers. This is irrevelant (and harmful)
for anyone who isn't a QEMU maintainer, which covers any consumer of the
Go code.

IMHO it is also a bug that this file split leaks out into our existing
QAPI docs.


Then when adding to files, sometimes people append to the end of a
file, sometimes it is injected in the middle. I can't say that is an
intentional/concious ordering decision.

The overall result is that wearing my hat of a consumer of QEMU, when
looking at the QAPI schema there is no discernable ordering.


Given the source ordering is not useful, there are two choices

 * Sort to have declarations before use as primary key, and then
   alphabetical as a secondary sort key

 * Sort alphabetically as the primary key

Fortunately the Go compiler has no requirement for forward declarations.
Sorting declarations before use also doesn't really have much effect on
most declarations, so the first option ends up 90% alphabetical sorted
anyway. Might as well just go the whole way and do pure alphabetical
sorting.

Comparing the enums code in "source order":

  https://gitlab.com/victortoso/qapi-go/-/blob/qapi-golang-v1-by-tags/pkg/qapi/enums.go

vs alphabetical order:

  https://gitlab.com/victortoso/qapi-go/-/blob/qapi-golang-v3-by-tags/pkg/qapi/enums.go

the improvement is massive IMHO.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


