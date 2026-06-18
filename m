Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4978ECD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waG21-00077q-J3; Thu, 18 Jun 2026 12:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waG1w-00076w-Lx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waG1r-000692-8K
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781801745;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5SGWD4RQbjQ3TSHTyU1KuoKTbtUOD/jo3R3IjtmFeA=;
 b=fQfm0sm160UeGRTPB4I/bMrMMCc2EDGdnuU1hKkNhZLYwgY3SIUY+Ccqey90mJmxRTifjV
 +0I0tkF/e23FEHm8TrDBQKZz5Z1z/oc1D6dbh420T0hX8wNz2B6PEAbMJ+kb3yqjB3ekcT
 TsurkWD+Xg2HALhgkBnaXq/b0Ag3OYw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-GKOyxbxINN2GVeXMDl3dBA-1; Thu,
 18 Jun 2026 12:55:43 -0400
X-MC-Unique: GKOyxbxINN2GVeXMDl3dBA-1
X-Mimecast-MFC-AGG-ID: GKOyxbxINN2GVeXMDl3dBA_1781801743
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6D371955D99; Thu, 18 Jun 2026 16:55:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2409E1800652; Thu, 18 Jun 2026 16:55:39 +0000 (UTC)
Date: Thu, 18 Jun 2026 17:55:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <ajQjCHvJTqpvPzqz@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <20260618112415-mutt-send-email-mst@kernel.org>
 <ajQXrpKNx4NnhUKa@redhat.com>
 <20260618121520-mutt-send-email-mst@kernel.org>
 <ajQd8nRuYau2xVcY@redhat.com>
 <20260618123451-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618123451-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Thu, Jun 18, 2026 at 12:39:31PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 18, 2026 at 05:33:54PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Jun 18, 2026 at 12:23:46PM -0400, Michael S. Tsirkin wrote:
> > > thanks! sorry probably just me being dense but some things
> > > here I don't get. might be worth clarifying:
> > > 
> > > On Thu, Jun 18, 2026 at 05:07:10PM +0100, Daniel P. Berrangé wrote:
> > > > On Thu, Jun 18, 2026 at 11:30:29AM -0400, Michael S. Tsirkin wrote:
> > > > > > + * The maintainer(s) will develop and/or review patch(es)
> > > > > > +   for the issue privately, optionally attaching work in
> > > > > > +   progress fixes to the GitLab issues.
> > > > > 
> > > > > attaching how? how do i ask reported to test the fix?
> > > > > was easy in the email flow.
> > > > 
> > > > You can add arbitrary attachments in gitlab issue comments.
> > > > 
> > > > > > All patches must
> > > > > > +   include the issue URL in the commit message(s).
> > > > > 
> > > > > you mean the commit message of the patches I presume?
> > > > > there's no commit at that point.
> > > > 
> > > > Well I presume the maintainer will have a local git tree
> > > > with a work-in-progress commit.
> > > 
> > > sorry I don't get it.
> > > 
> > > what does it have to do with patches then?
> > > 
> > > 
> > > who cares about my local tree?
> > 
> > If you fix a gitlab issue, the commit must contain the issue URL.
> > That's normal practice we've followed forever and would now apply
> > to security fixes too.
> 
> Ah. You want a Fixes: tag maybe? Let's say so pls then.
> 
> > > 
> > > and why is this mentioned twice?
> > 
> > Mentioning twice is a mistake
> > 
> > 
> > > > > > The
> > > > > > +   **"Workflow::In Progress"** label should be assigned when
> > > > > > +   a maintainer starts working on a fix.
> > > > > 
> > > > > That's a bit heavy, and what is "working" anyway.
> > > > > It's an issue tracker not a planning app.
> > > > > Don't try to make it one.
> > > > 
> > > > Various "Workflow::" labels are already present in our gitlab
> > > > instance. We don't use them consistently - this text is just
> > > > a pointer that the're there.
> > > > 
> > > 
> > > maybe "can be assigned" then?
> > 
> > Ok.
> > 
> > > 
> > > > 
> > > > > 
> > > > > 
> > > > > > + * When a CVE is allocated, it must be recorded as a comment on
> > > > > > +   the GitLab issue, and the **"CVE::Required"** label replaced by
> > > > > > +   the **"CVE::Assigned"** label.
> > > > > 
> > > > > Recorded as a comment how exactly, in what format?
> > > > 
> > > > In plain text.
> > > 
> > > yes but in what format?
> > 
> > Literally just  "CVE-2026-1234" anywhere in the commit message as we've
> > been donig for years.
> 
> I suspect what we've been doing for years no longer scales or
> we'd keep doing what we've been doing?
> 
> 
> We desperately need something that is consumable by tooling,
> and I just do not see how is a tool going to figure out
> "this seems to be unrelated CVE-123" is irrelevant.

It depends who you mean by "we" here ? From an upstream POV I don't
think we care. We ship fixes in master. While it would be nice to
have stable releases with all security fixes backported, we have
never promised/offered that and with the volume we see, I don't
think we should try to add such a promise either.

IOW, consuming CVE fixes is largely a downstream problem. I'd
recommend they start from the gitlab issues with Kind::Security
and CVE::Assigned tags present, but beyon that its upto them.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


