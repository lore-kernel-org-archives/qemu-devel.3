Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1812FC25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 11:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7vTO-0006ME-Um; Fri, 17 May 2024 07:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7vTM-0006Lo-T7
 for qemu-devel@nongnu.org; Fri, 17 May 2024 07:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7vTK-0005vY-Tn
 for qemu-devel@nongnu.org; Fri, 17 May 2024 07:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715944197;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zg0gJ8ywyNLJxJW9QmmRqgfcmywXByuLeReyojf4yD0=;
 b=JWv9h2jxIHOI4HgnMZmfAq9vn6rjtJZ3gEF2upTV7X7B2rDIFjQMepbTigR7G2e/HejNVO
 nUoT619RA3ZD/AjQU29sgNCn4jYbokIc4jmp+UeOwtd49Cu5iu0SZ71NEKyfH/0eG8pT9s
 1Fsr21oWhW6MilMPrNevFER4F3X5TLg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-m9X2TeWcN8KXXXtum5pqdQ-1; Fri, 17 May 2024 07:09:54 -0400
X-MC-Unique: m9X2TeWcN8KXXXtum5pqdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFAC7803785;
 Fri, 17 May 2024 11:09:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D75A20268F0;
 Fri, 17 May 2024 11:09:49 +0000 (UTC)
Date: Fri, 17 May 2024 12:09:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/3] docs: introduce dedicated page about code
 provenance / sign-off
Message-ID: <Zkc6-3AYZG-4p8ay@redhat.com>
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-2-berrange@redhat.com>
 <20240516132438-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516132438-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 16, 2024 at 01:33:01PM -0400, Michael S. Tsirkin wrote:
> On Thu, May 16, 2024 at 05:22:28PM +0100, Daniel P. Berrangé wrote:
> > Currently we have a short paragraph saying that patches must include
> > a Signed-off-by line, and merely link to the kernel documentation.
> > The linked kernel docs have a lot of content beyond the part about
> > sign-off an thus are misleading/distracting to QEMU contributors.
> > 
> > This introduces a dedicated 'code-provenance' page in QEMU talking
> > about why we require sign-off, explaining the other tags we commonly
> > use, and what to do in some edge cases.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/devel/code-provenance.rst    | 212 ++++++++++++++++++++++++++++++
> >  docs/devel/index-process.rst      |   1 +
> >  docs/devel/submitting-a-patch.rst |  19 +--
> >  3 files changed, 215 insertions(+), 17 deletions(-)
> >  create mode 100644 docs/devel/code-provenance.rst
> > 
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > new file mode 100644
> > index 0000000000..7c42fae571
> > --- /dev/null
> > +++ b/docs/devel/code-provenance.rst
> > @@ -0,0 +1,212 @@
> > +.. _code-provenance:
> > +
> > +Code provenance
> > +===============
> > +
> > +Certifying patch submissions
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The QEMU community **mandates** all contributors to certify provenance of
> > +patch submissions they make to the project. To put it another way,
> > +contributors must indicate that they are legally permitted to contribute to
> > +the project.
> > +
> > +Certification is achieved with a low overhead by adding a single line to the
> > +bottom of every git commit::
> > +
> > +   Signed-off-by: YOUR NAME <YOUR@EMAIL>
> > +
> > +The addition of this line asserts that the author of the patch is contributing
> > +in accordance with the clauses specified in the
> > +`Developer's Certificate of Origin <https://developercertificate.org>`__:
> 
> Why are you linking to this one?

The kernel doesn't have a standalone copy of the text, it is just
inline in the middle of their huge SubmittingPatches document.
We don't want to mislead people into thinking we're following
the kernel's patch submision rules in general, instead define
our own clear policy. 


> It's slightly different from kernel, with copyright and prohibition to change it.

That difference is not of any consequence. The probhition
aganist changing makes sense, to protect the value of the
"Developer Certificate of Origin" term to have a fixed
meaning.

The 4 clauses that you must certify against are all identical
to the kernel's copy, which is what matters.

> there's also a bit more text in the kernel, e.g. the rule against
> anonymous contributions.

Yes, we should clarify our intent in this respect, per the other
part of this thread around what we interpret "real name" to
mean for QEMU.


> > diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> > index 83e9092b8c..2cc4d53ff6 100644
> > --- a/docs/devel/submitting-a-patch.rst
> > +++ b/docs/devel/submitting-a-patch.rst
> > @@ -322,23 +322,8 @@ Patch emails must include a ``Signed-off-by:`` line
> >  
> >  Your patches **must** include a Signed-off-by: line. This is a hard
> >  requirement because it's how you say "I'm legally okay to contribute
> > -this and happy for it to go into QEMU". The process is modelled after
> > -the `Linux kernel
> > -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__
> > -policy.
> > -
> > -If you wrote the patch, make sure your "From:" and "Signed-off-by:"
> > -lines use the same spelling. It's okay if you subscribe or contribute to
> > -the list via more than one address, but using multiple addresses in one
> > -commit just confuses things.
> 
> 
> I gather you no longer see value in discussing this use-case?
> Maybe mention in commit log, why.

I should have preserved this phrase in the new doc.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


