Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD6DCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ht6-0002MN-W7; Mon, 22 Sep 2025 10:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0ht4-0002JM-If
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0hsy-0003dH-2w
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758552679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdoxjErS5k8L8Ot4Fx7A55RAeKSSw4BCbqSz5CsEQvs=;
 b=UTIdkUyuakeD5c1BYFd5F0A+eF2Ostzs40POxFtDjH1YvAJGW5HjOgf3wbXRKv1NRJX3wx
 HqqbvOhUPznDkisqfG7BWPqk3+3oJXFuUurSS+mJzQjUamfSr70tX2AVuJHIkkhimJ6BNd
 2KwORPysFaKXxM4JbbGnBWEc3s3TPGo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-_F9WgsJlOmmtUHM802LJVw-1; Mon,
 22 Sep 2025 10:51:16 -0400
X-MC-Unique: _F9WgsJlOmmtUHM802LJVw-1
X-Mimecast-MFC-AGG-ID: _F9WgsJlOmmtUHM802LJVw_1758552675
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A04918004D4; Mon, 22 Sep 2025 14:51:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4068019560BB; Mon, 22 Sep 2025 14:51:12 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:51:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 2/4] docs/code-provenance: make the exception process
 more prominent
Message-ID: <aNFiXQivVJHjn08R@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-3-pbonzini@redhat.com>
 <aNFOFq_H8KjWM-oy@redhat.com>
 <d130989e-3883-410f-b96b-cead1be382ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d130989e-3883-410f-b96b-cead1be382ad@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 22, 2025 at 03:56:51PM +0200, Paolo Bonzini wrote:
> On 9/22/25 15:24, Daniel P. Berrangé wrote:
> > FWIW, I considered that the "exception process" would end up
> > being something like...
> > 
> >   * someone wants to use a particular tool for something they
> >     believe is compelling
> >   * they complain on qemu-devel that our policy blocks their
> >     valid use
> >   * we debate it
> 
> I guess we're here, except for hiding the complaint behind a patch. :)
> 
> >   * if agreed, we add a note to this code-proveance.rst doc to
> >     allow it
> > 
> > 
> > I would imagine that exceptions might fall into two buckets
> > 
> >   * Descriptions of techniques/scenarios for using tools
> >     that limit the licensing risk
> >   * Details of specific tools (or more likely models) that
> >     are judged to have limited licensing risk
> > 
> > it is hard to predict the future though, so this might be
> > too simplistic. Time will tell when someone starts the
> > debate...
> 
> Yeah, I'm afraid it is; allowing specific tools might not be feasible, as
> the scope of "allow Claude Code" or "allow cut and paste for ChatGPT chats"
> is obviously way too large.  Allowing some usage scenarios seems more
> feasible (as done in patch 4).

Agreed, when I say an exception a tool, I would find it highly
unlikely we would do so for such a highly generic tool as
Claude/ChatGPT. That would effectively be removing all policy
limitations.

Rather I was thinking about the possibility that certain very
specialized tools might appear.

The usage scenarios exception seems the much more likely one
in the near future.

> > > What is missing: do we want a formal way to identify commits for which an
> > > exception to the AI policy was granted?  The common way to do so seems to
> > > be "Generated-by" or "Assisted-by" but I don't want to turn commit message
> > > into an ad space.  I would lean more towards something like
> > > 
> > >    AI-exception-granted-by: Mary Maintainer <mary.maintainer@mycorp.test>
> > 
> > IMHO the code-provenance.rst doc is what grants the exception, not
> > any individual person, nor any individual commit.
> > 
> > Whether we want to reference that a given commit is relying on an
> > exception or not is hard to say at this point as we don't know what
> > any exception would be like.
> > 
> > Ideally the applicability of an exception could be self-evident
> > from the commit. Realiyt might be more fuzzy. So if self-evident,
> > then it likely warrants a sentence two of english text in the
> > commit to justify its applicability.
> > IOW, a tag like AI-exception-granted-by doesn't feel like it is
> > particularly useful.
> 
> I meant it as more of an audit trail, especially for the case where a new
> submaintainer would prefer to ask someone else, or for the case of a
> maintainer contributing AI-generated code.  If we can keep it simple and
> avoid this, that's fine (it's not even in the policy, only in the commit
> message).

When a maintainer gives an Acked-by or Signed-off-by tag they
are stating the contribution complies with our policies and
that includes this AI policy.

If a maintainer isn't comfortable with the AI exception
applicability they should not give Acked-by/Signed-off-by,
and/or ask another maintainer to give their own NNN-by tag
as a second opinion.

> What I do *not* want is Generated-by or Assisted-by.

Yes, I don't want to see us advertizing commercial products in
git history

>                                                      The exact model or
> tool should matter in deciding whether a contribution fits the exception.
> Companies tell their employees "you can use this model because we have an
> indemnification contract in place", but I don't think we should care about
> what contracts they have---we have no way to check if it's true or if the
> indemnification extends to QEMU, for example.

Employees likely don't have any way to check that either. They'll
just be blindly trusting what little information their employer
provides, if any. We don't want to put our contributions into an
impossible situation wrt determining compliance. It needs to be
practical for them to make a judgement call.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


