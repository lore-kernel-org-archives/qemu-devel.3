Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE0FD4335D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92g6-0007Ch-CP; Thu, 07 Nov 2024 08:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t92g2-0007CL-OM
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:35:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t92g0-0005Am-Uh
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730986556;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/aR6y2tjJL6IXlIhnTJKHhulJoqcqRwdo+yRMUw40I=;
 b=iIFsxPQQmIkqk2GV2PpjR/RHk6g3Lwyf2iB/p1toECKORJbK4Zylq4qbGKsHpX9oxz/G3U
 fAcDdJ+UBlOnH9rLIyHLs/+jKUMZQZNeLsplm0WVNhW8LZ6iOoTN2vdGXs/XavbzYD3ttZ
 4BUZfxrvQWgyv8aZnVgSy85fdJGRCh4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-WRFoXci-MvKwtuQG-dhHOA-1; Thu,
 07 Nov 2024 08:35:53 -0500
X-MC-Unique: WRFoXci-MvKwtuQG-dhHOA-1
X-Mimecast-MFC-AGG-ID: WRFoXci-MvKwtuQG-dhHOA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5966619776D2
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2024 13:35:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53D4C196BC17; Thu,  7 Nov 2024 13:35:49 +0000 (UTC)
Date: Thu, 7 Nov 2024 13:35:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Victor Toso <victortoso@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: [RFC PATCH v2 0/8] qapi: add generator for Golang interface
Message-ID: <ZyzCMVYHM2F72oMa@redhat.com>
References: <20220617121932.249381-1-victortoso@redhat.com>
 <ZyyZugciNAYmVjeP@redhat.com> <87r07njk4e.fsf@pond.sub.org>
 <Zyy7XGTRuCS0yGgI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zyy7XGTRuCS0yGgI@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Thu, Nov 07, 2024 at 01:06:36PM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 07, 2024 at 01:36:49PM +0100, Markus Armbruster wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > Bringing this thread back from the dead, since I had an in-person
> > > discussion on a key question below at KVM Forum this year and want
> > > to record it here.
> > 
> > [...]
> > 
> > > To recap the situation
> > >
> > >  * The license of the code generator itself does not determine the
> > >    license of the output generated code
> > 
> > For instance, GNU Bison is GPLv3+, but the parts the generator emits
> > (the parser skeleton) come with a special exception.
> > 
> > Such exceptions need to be granted by the copyright holder.  As long as
> > the code generating Go is not a derived work, the copyright holder
> > situation should be simple enough to make this practical.
> > 
> > >  * The license of the inputs to the code generator, may or may
> > >    not, determine the license of the output generated code depending
> > >    on use context
> > >
> > > The primary input to the code generator is the QAPI schema, which is part
> > > of QEMU and thus licensed GPL-2.0-or-later.
> > >
> > > The QAPI schema includes both the API definitions AND the API documentation
> > > text.
> > >
> > > We can make the case that as the QEMU public interface, consuming the
> > > API definitions in the QAPI schema for the purpose of generating code
> > > is "fair use", and thus the output generated code does NOT need to
> > > match the GPL-2.0-or-later license of the QAPI schema. We can choose
> > > the code license, and a maximally permissive license looks appropriate.
> > 
> > Having this argument confirmed by an actual expert seems advisable.
> 
> IANAL, but .... :-)

> My proposition is that, in most cases, comments are not used by
> the "compilation", or "code generation" phase. They are seen by
> the "parsing" phase only and thus dont contribute to the contents
> of the output binary code.


> None the less, we have raised this position/viewpoint with experts
> for a second opinion.

Another thought or two...

From a QEMU community POV we have no license problem no matter what,
so from a legal POV this risk free for us.

The licensing question is purely one for application developers consuming
our work who want to avoid GPL for some reason.

Lets say my interpretation is wrong, or even that it is right, but the
app developers disagree, or are none the less unhappy in some way. What
impact would this have for QEMU ?

Code generation is practically free once the generator is written, so we
just run it twice, storing the output in git on different branches with
parallel tags, once with comments and once without. eg

The "main" branch (and associated versioned vX.Y.Z tags) in qemu-go-qapi.git
provide the full QAPI go source + copied QAPI comments under MIT-0 AND
GPL-2.0-or-later

The "minimal" branch (and associated vX.Y.Z-minimal tags) in qemu-go-qapi.git
provide only the  QAPI go source, without any comments under MIT-0 only.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


