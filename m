Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D198CD98F5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFH7-0001Z8-0p; Thu, 18 Jun 2026 12:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waFH1-0001Yh-ID
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waFGz-0003hG-Ir
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781798839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3vkQqkGfMk4kTHU5LUliLqZxi7z7Uckn5lF+wT/3XSc=;
 b=dE8ug8DRW5v10VjTBNE/s/56m9nNrFGoDsivZ94V1HE46X8SIHLLv1+c9VW+WMdge4vLO4
 L/qd5jXPY2FTkrmB1c3KkpNbCoQJSPV2e2a2cfKRiYdHwW8j7Q86UA3Do0t5k2vGg4yZdG
 plqf36V3gWXnaHbdrrUWo0x8Bo/HFcs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-52Cj2YlzNvO1PenRzapK8w-1; Thu,
 18 Jun 2026 12:07:17 -0400
X-MC-Unique: 52Cj2YlzNvO1PenRzapK8w-1
X-Mimecast-MFC-AGG-ID: 52Cj2YlzNvO1PenRzapK8w_1781798836
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89A0E1956040; Thu, 18 Jun 2026 16:07:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 189561800664; Thu, 18 Jun 2026 16:07:13 +0000 (UTC)
Date: Thu, 18 Jun 2026 17:07:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <ajQXrpKNx4NnhUKa@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <20260618112415-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618112415-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 18, 2026 at 11:30:29AM -0400, Michael S. Tsirkin wrote:
> > + * The maintainer(s) will develop and/or review patch(es)
> > +   for the issue privately, optionally attaching work in
> > +   progress fixes to the GitLab issues.
> 
> attaching how? how do i ask reported to test the fix?
> was easy in the email flow.

You can add arbitrary attachments in gitlab issue comments.

> > All patches must
> > +   include the issue URL in the commit message(s).
> 
> you mean the commit message of the patches I presume?
> there's no commit at that point.

Well I presume the maintainer will have a local git tree
with a work-in-progress commit.

> > The
> > +   **"Workflow::In Progress"** label should be assigned when
> > +   a maintainer starts working on a fix.
> 
> That's a bit heavy, and what is "working" anyway.
> It's an issue tracker not a planning app.
> Don't try to make it one.

Various "Workflow::" labels are already present in our gitlab
instance. We don't use them consistently - this text is just
a pointer that the're there.



> 
> 
> > + * When a CVE is allocated, it must be recorded as a comment on
> > +   the GitLab issue, and the **"CVE::Required"** label replaced by
> > +   the **"CVE::Assigned"** label.
> 
> Recorded as a comment how exactly, in what format?

In plain text.

> 
> > + * The maintainer(s) will update the commit message(s)
> 
> what does it mean to "update the commit message"?

The commit message for the patch the maintainer has in their
tree.


> > to include
> > +   the assigned CVE and issue URL. If multiple commits are required
> > +   to fix an issue the CVE must be included in the final commit in
> > +   the series, and may optionally be included in all prior commits.
> 
> And here, included in what format?

The CVE just needs to exist somewhere/anywhere in the commit message.
It is common to put it in the first line, or with tags before SoB
but it doesn't really matter as long as we have a record of it in
the patch.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


