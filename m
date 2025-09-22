Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE14CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gkT-0004Pd-1q; Mon, 22 Sep 2025 09:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0gkI-0004Ow-Nw
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0gkE-00085B-La
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758548296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/AgysdKxt1SKkQk5V+ElEe7Zh26j2yawQ4kJ0l1uI8=;
 b=SJdfJ/j0sg4cqrFQ+VWsCYTTSqWRedqITKu3hNTtSVax0qQYG+UkKabWmb2k5QGjD76t77
 SxRkXFY7KMOlRfs5S2p0sPvXhP42WjZp84Y8i/WrCSeCkisRRkSF1LGTaXjq1vhWdlloMg
 itsArp1bBstv2Z5RW8Ua2cZmHk1C224=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-6n5EtJkFP2maKqH2sDSuDg-1; Mon,
 22 Sep 2025 09:38:12 -0400
X-MC-Unique: 6n5EtJkFP2maKqH2sDSuDg-1
X-Mimecast-MFC-AGG-ID: 6n5EtJkFP2maKqH2sDSuDg_1758548291
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA5961800285; Mon, 22 Sep 2025 13:38:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2D9D1800452; Mon, 22 Sep 2025 13:38:09 +0000 (UTC)
Date: Mon, 22 Sep 2025 14:38:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 3/4] docs/code-provenance: clarify the scope of AI
 exceptions
Message-ID: <aNFRPj539UbRkLSE@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-4-pbonzini@redhat.com>
 <874isuod28.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874isuod28.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 22, 2025 at 02:02:23PM +0100, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Using phrasing from https://openinfra.org/legal/ai-policy (with just
> > "commit" replaced by "submission", because we do not submit changes
> > as commits but rather emails), clarify that the maintainer who bestows
> > their blessing on the AI-generated contribution is not responsible
> > for its copyright or license status beyond what is required by the
> > Developer's Certificate of Origin.
> >
> > [This is not my preferred phrasing.  I would prefer something lighter
> > like "the "Signed-off-by" label in the contribution gives the author
> > responsibility".  But for the sake of not reinventing the wheel I am
> > keeping the exact works from the OpenInfra policy.]
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  docs/devel/code-provenance.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > index d435ab145cf..a5838f63649 100644
> > --- a/docs/devel/code-provenance.rst
> > +++ b/docs/devel/code-provenance.rst
> > @@ -334,6 +334,11 @@ training model and code, to the satisfaction of the project maintainers.
> >  Maintainers are not allow to grant an exception on their own patch
> >  submissions.
> >  
> > +Even after an exception is granted, the "Signed-off-by" label in the
> > +contribution is a statement that the author takes responsibility for the
> > +entire contents of the submission, including any parts that were generated
> > +or assisted by AI tools or other tools.
> > +
> 
> I quite like the LLVM wording which makes expectations clear to the
> submitter:
> 
>   While the LLVM project has a liberal policy on AI tool use, contributors
>   are considered responsible for their contributions. We encourage
>   contributors to review all generated code before sending it for review
>   to verify its correctness and to understand it so that they can answer
>   questions during code review. Reviewing and maintaining generated code
>   that the original contributor does not understand is not a good use of
>   limited project resources.
> 
> It could perhaps be even stronger (must rather than encourage). The key
> point to emphasise is we don't want submissions the user of the
> generative AI doesn't understand.
> 
> While we don't see them because our github lockdown policy auto-closes
> PRs we are already seeing a growth in submissions where the authors seem
> to have YOLO'd the code generator without really understanding the
> changes.

While I understand where the LLVM maintainers are coming from, IMHO
their proposed policy leaves alot to be desired. 80% of the material
in the policy has nothing to do with AI content. Rather it is stating
the general contribution norms that the project expects to be followed
regardless of what tools may have been used.

I think perhaps alot of the contributions norms are previously informal
and learnt on the job as you gradually acclimatize to participation in
a specific project, or first learning about open source in general.

This reliance on informal norms was always somewhat of a problem, but
it is being supercharged by AI. It is now much more likely to see project
interactions from less experienced people, who are relying on AI tools
to provide a quick on-ramp to the project, bypassing the more gradual
learning experience.


As an example of why the distinction between AI policy and general
contribution policy matters, consider the great many bugs / security
reports we've had based off the output of static analysis tools.

Almost none of this was related to AI, but the people submitting
them often failed on basic expectations such as sanity checking
what the tool claimed, or understanding what they were reporting,
or understanding why they're changing the code they way they did.

If we don't already have our "contribution norms" sufficiently
clearly documented, we should improve that independently of any
AI related policy.  The AI related section in our docs should
merely refer the reader over to our other contribution policies
for anything that isn't directly related to AI.


We do have a gap wrt to bug reporting where I think we should document
an expectation that any use of automated tools in the bug report must
be diclosed, whether those tools are AI or not. This should apply to
any static analysis tool.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


