Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F4CCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHSl-000807-8v; Wed, 27 May 2026 12:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSHSf-0007zl-AY
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSHSb-0004MV-PT
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779900624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMiQCQp0FtKRT3C19cxmKaRxd7UV34XTqGZIYaYWWUY=;
 b=jIwD8cS4rht4XQRlOzlkRR3UNFEi0pxsodtuwNrW5JCnmr65BuC6e+c13DIQlXUNUQsEQZ
 ujp7B/Sre+m9Z+95f5/L89xDH5xdNhrReW2UM9N+mfM6M2nLLsnpIKfj6atMUZEK+ItkAk
 y7iuzQLTmEbFL31N9uO3wAa3ruJ8XdQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-caeJamKhNMGsusFIeRSj8w-1; Wed,
 27 May 2026 12:50:20 -0400
X-MC-Unique: caeJamKhNMGsusFIeRSj8w-1
X-Mimecast-MFC-AGG-ID: caeJamKhNMGsusFIeRSj8w_1779900619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D663618002DD; Wed, 27 May 2026 16:50:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4DE730001BB; Wed, 27 May 2026 16:50:16 +0000 (UTC)
Date: Wed, 27 May 2026 18:50:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <ahcgxpvXFoPE0C-X@redhat.com>
References: <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <ahcE-pDc_7tTrsz3@redhat.com>
 <20260527123942-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527123942-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 27.05.2026 um 18:41 hat Michael S. Tsirkin geschrieben:
> On Wed, May 27, 2026 at 04:51:38PM +0200, Kevin Wolf wrote:
> > Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:
> > > On Wed, May 27, 2026 at 4:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > Commit messages for AI-assisted changes
> > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > >
> > > > When AI/LLM tools produce or substantively shape your patch, add an
> > > > ``AI-used-for:`` trailer.  The text of the trailer could be one or more
> > > > of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> > > > explanation in parentheses::
> > > >
> > > >      AI-used-for: tests, docs
> > > >      AI-used-for: code
> > > >      AI-used-for: code (refactoring)
> > > >      AI-used-for: code (prototype)
> > > >      AI-used-for: research
> > > >
> > > > The trailer is intended as a clarification of your DCO obligations as
> > > > well as to guide reviewers.  It is not intended for minimal presence
> > > > such as autocomplete or asking for a pre-review of the patch, and it
> > > > does not remove your responsibility to understand the changes that you
> > > > are submitting.
> > > 
> > > Why invent something new here when Assisted-by: is used elsewhere
> > > and is likely more familiar to other users.
> > 
> > Because Assisted-by: gives different information, which at least to me
> > isn't really interesting at all. It's much more interesting to me if the
> > code I'm looking at is generated, or if you only generated the tests.
> 
> I personally am interested to know which models work better than others.
> Contributions are about reputation not just code.  I'll learn which
> models produce better output, just like I learn to trust specific
> contributors better.

You don't see how well the model worked. What you see is filtered by the
submitter, and the policy we're discussing is specifically made to make
sure that bad results never reach the list.

Even for things that do reach the list, Assisted-by: doesn't tell you
how much of the submission is AI-generated and it also doesn't tell you
if it's "I used model X and a simple prompt gave me the perfect result
in the first attempt" or "I used model X and it took me two days of back
and forth and eventually I just rewrote most of it, but there are a few
AI-generated lines left".

So what you should trust is the contributor, not an Assisted-by: tag.

Kevin


