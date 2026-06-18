Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E0CCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFh1-0007Cs-My; Thu, 18 Jun 2026 12:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waFgu-000793-Ua
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waFgs-0006hF-RN
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781800444;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=491OP5/4QE4OXGmTBj+1bWYZumrZ3zi2Pq9ZNWnUtvc=;
 b=JAcDSSjci15Cy5sCU0OfEF5plp6U72lEbOjq7kFaNv2+o7JRzcY+mwmpzJGhLMgy7XPGlm
 24G/nCNgyCoIpXcnoJozpzDRyzNZk+1Thi1fc1yEXi7k0UeaK3T6in1B8uYmawoFExhfGd
 gd1w+52G7/QSejJ4tpa+WwLUPULpgZs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-rVplfEKzNR-yumbBVfB1aQ-1; Thu,
 18 Jun 2026 12:34:01 -0400
X-MC-Unique: rVplfEKzNR-yumbBVfB1aQ-1
X-Mimecast-MFC-AGG-ID: rVplfEKzNR-yumbBVfB1aQ_1781800440
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91ED2195604D; Thu, 18 Jun 2026 16:34:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1865430000DB; Thu, 18 Jun 2026 16:33:57 +0000 (UTC)
Date: Thu, 18 Jun 2026 17:33:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <ajQd8nRuYau2xVcY@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <20260618112415-mutt-send-email-mst@kernel.org>
 <ajQXrpKNx4NnhUKa@redhat.com>
 <20260618121520-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618121520-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Thu, Jun 18, 2026 at 12:23:46PM -0400, Michael S. Tsirkin wrote:
> thanks! sorry probably just me being dense but some things
> here I don't get. might be worth clarifying:
> 
> On Thu, Jun 18, 2026 at 05:07:10PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Jun 18, 2026 at 11:30:29AM -0400, Michael S. Tsirkin wrote:
> > > > + * The maintainer(s) will develop and/or review patch(es)
> > > > +   for the issue privately, optionally attaching work in
> > > > +   progress fixes to the GitLab issues.
> > > 
> > > attaching how? how do i ask reported to test the fix?
> > > was easy in the email flow.
> > 
> > You can add arbitrary attachments in gitlab issue comments.
> > 
> > > > All patches must
> > > > +   include the issue URL in the commit message(s).
> > > 
> > > you mean the commit message of the patches I presume?
> > > there's no commit at that point.
> > 
> > Well I presume the maintainer will have a local git tree
> > with a work-in-progress commit.
> 
> sorry I don't get it.
> 
> what does it have to do with patches then?
> 
> 
> who cares about my local tree?

If you fix a gitlab issue, the commit must contain the issue URL.
That's normal practice we've followed forever and would now apply
to security fixes too.

> 
> and why is this mentioned twice?

Mentioning twice is a mistake


> > > > The
> > > > +   **"Workflow::In Progress"** label should be assigned when
> > > > +   a maintainer starts working on a fix.
> > > 
> > > That's a bit heavy, and what is "working" anyway.
> > > It's an issue tracker not a planning app.
> > > Don't try to make it one.
> > 
> > Various "Workflow::" labels are already present in our gitlab
> > instance. We don't use them consistently - this text is just
> > a pointer that the're there.
> > 
> 
> maybe "can be assigned" then?

Ok.

> 
> > 
> > > 
> > > 
> > > > + * When a CVE is allocated, it must be recorded as a comment on
> > > > +   the GitLab issue, and the **"CVE::Required"** label replaced by
> > > > +   the **"CVE::Assigned"** label.
> > > 
> > > Recorded as a comment how exactly, in what format?
> > 
> > In plain text.
> 
> yes but in what format?

Literally just  "CVE-2026-1234" anywhere in the commit message as we've
been donig for years.

> > > > + * The maintainer(s) will update the commit message(s)
> > > 
> > > what does it mean to "update the commit message"?
> > 
> > The commit message for the patch the maintainer has in their
> > tree.
> 
> then you mean "before sending a pull request"?

Sure if you want it to be that specific.

> > > > to include
> > > > +   the assigned CVE and issue URL. If multiple commits are required
> > > > +   to fix an issue the CVE must be included in the final commit in
> > > > +   the series, and may optionally be included in all prior commits.
> > > 
> > > And here, included in what format?
> > 
> > The CVE just needs to exist somewhere/anywhere in the commit message.
> > It is common to put it in the first line, or with tags before SoB
> > but it doesn't really matter as long as we have a record of it in
> > the patch.
> 
> Will be really annoying if any tools try to consume this e.g.
> to decide what to backport.
> I suggest deciding on something for these free text fields,
> how important is it to be able to write ❤️❤️❤️CVE-1234💰🔥🎯 really?

I don't think we need to document every single little detail
here, just carry on with what we've already been doing for
commits.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


