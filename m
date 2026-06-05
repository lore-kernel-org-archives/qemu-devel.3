Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74C6CD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVRAY-0001ds-5i; Fri, 05 Jun 2026 05:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVRAW-0001dV-B6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 05:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVRAU-0007PM-6X
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 05:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780652924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnynHs6gNo+XwqxoPPR3QX778bVmYIhaiU1Ai52w7K4=;
 b=VBoIpxNZljpIz3crxGAduBPFAb6YxalVFFsdmqIHQDxfY2fcH1now681GpYuEf0tMIVNG5
 ishJzySQOVSmRf5oJ+I1IStkiqtQwjLz/NboFmGsWRcyD6Lb45aKdqD6aSCzJSAbJ0oABS
 qd297sU0X+3dSzFS3NlH1mLc0PXJpHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-vaTZatheN86LFWe40sgDCw-1; Fri, 05 Jun 2026 05:48:42 -0400
X-MC-Unique: vaTZatheN86LFWe40sgDCw-1
X-Mimecast-MFC-AGG-ID: vaTZatheN86LFWe40sgDCw_1780652921
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so14039265e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780652921; x=1781257721; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SnynHs6gNo+XwqxoPPR3QX778bVmYIhaiU1Ai52w7K4=;
 b=gdUHZTMLpiPsmCGqmzsCHIx1u3G85JIYkR5GqbSpDRz8HiDOl/SOLXz1BBLhI9qPgS
 9lzfRQeICpLxO3knqRbFaN4ZerKHzO2bK4qB//Kw0d6EcH4DUP0igeMhM8wOpDX9zLJs
 1wYLVRGVOt0TRbb3p9Ksf5Yx8AbYlHScchmmsMD7oJ/jrhUFj3DxtXTabQIKCnQiqnyL
 aVvlnyEmbv8bf4RKQ4u94hN2MYCmLfdBeXPkJyOiW3mpp02UpHWZ299yh/lymICS8bDo
 0aX/paxdIEHOf8u2MGxcp7aBJMHPETe0Y8rfx/lL3jsWevyCW4Fav6w6DI7O3jhVQu8Y
 IRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652921; x=1781257721;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SnynHs6gNo+XwqxoPPR3QX778bVmYIhaiU1Ai52w7K4=;
 b=e8j42hoQVeKoj8P4unVInaaZSLxFlczbqpsg4u1bWO0GOuZ2kJEMzK6fNARBH3R/Oo
 Kw1za6ZaiLIUQRb3kij333E7OrfXT0sX1jv8d9R/jZR3BdroO1kRvBViQai03hCdHvrY
 VKiY8Ia23iJcgGn2piGhXWxosjgYRLJ57uV5WXg+rMhcpc1dO8aZZ/3x6EFnGEY6xt+X
 QI4f8/G5npIVfvJcCkMQ3fj3J6ky0O/Y0eAeUSl1jq3At/fXyee0cvAgx/feltbWHrlO
 0S8RRW1j4RTqFFeOwl6ap3s0HXgRjshXPM/7uEIxvC78csTW5chqyIt3Ik7xmDTuPqOE
 IJnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jKFjBBOWWzXgycAiuitQDEKBCurHEJ8ON3Gvv+46Y9aTAZWFS0e8Vk9P+03/AJdldmhlbi7L9tl3d@nongnu.org
X-Gm-Message-State: AOJu0YxUAytPy1zEIaFyLWY9P1MEnbV40zc3TG9HmMbbOjsos6ATDuki
 GbWv1gQsuvfr65EaaXGdNhAVTwsvzrp8O8nQNhy7i+sxBRSHGu1+j0IXOSiRiXrdezGCFa6DB6F
 t72Cm23SieqGksF6KAReZcV4LWDHPe1AtWcwD7dzsRAJS9gjaLswqRG1o
X-Gm-Gg: Acq92OFDipkpNaLOHKnoiUnDpIPZaLWlO+bU4HJNraPwXYDx1oczprWRnkyPpEuPrqu
 KT0zEYlUYyU78T967yiDfI94UIvZOCKv1mJG4bqgnAWz35skEhrtL2rsCJQ1l+xZeg71Mo3wM3e
 JIFYaXNFoSRZRSEo0ZV8/UPrFteR6UO6QqH9HnUED3HXuwKoXcmlX6G5ueqnPfvnmHHPIosmSUK
 BvXC2uuDQOLyJN3qjn8vS/1dDNuuG6HM7XRyF4+Lb9vsGvARL+07Q4aJtCQK2/I3MuyOOliY67f
 bwlAMulAACjKGUwvq7bs2sPJbsLhaUb7cEbumVI4eInygbvkISIS5OFqiLSLrfGUA76P2gHJTAq
 WFIA2AvwJ9KLjAo23rqLaaJDI37Xmmvt9tXVBRj/r5Mzt2Lv068IrNng=
X-Received: by 2002:a05:600c:c16f:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-490c25fc0d5mr39943755e9.21.1780652921191; 
 Fri, 05 Jun 2026 02:48:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c16f:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-490c25fc0d5mr39943135e9.21.1780652920618; 
 Fri, 05 Jun 2026 02:48:40 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d2d11asm44975845e9.1.2026.06.05.02.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:48:39 -0700 (PDT)
Date: Fri, 5 Jun 2026 05:48:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260605054212-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <aiBqT1KfI-qowr4L@redhat.com>
 <CAHFMJ7veDE+i89Kh-SaQOL3019W2YC9_o7DeQtDL-YKGxGGHVQ@mail.gmail.com>
 <aiKUHBiQNqvhqxr8@redhat.com>
 <20260605051949-mutt-send-email-mst@kernel.org>
 <aiKZQ2VVnERuUKt0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiKZQ2VVnERuUKt0@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Fri, Jun 05, 2026 at 10:39:15AM +0100, Daniel P. Berrangé wrote:
> On Fri, Jun 05, 2026 at 05:25:36AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jun 05, 2026 at 10:17:16AM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Jun 04, 2026 at 12:37:58PM +0200, Paolo Bonzini wrote:
> > > > Il mer 3 giu 2026, 19:54 Daniel P. Berrangé <berrange@redhat.com> ha
> > > > scritto:
> > > > 
> > > > > The AI policy should just
> > > > > make a point that we expect to be communicating with people not
> > > > > bots pretending to be people.
> > > > >
> > > > 
> > > > Yes, it's better to have that stated clearly.
> > > > 
> > > > > True but we also need a rule. The spirit is better explained elsewhere
> > > > > > (and also, building consensus on spirit vs. a rule are two different
> > > > > > things).
> > > > >
> > > > > Do we have a better elsewhere in this case ?  It is a point specifically
> > > > > about intent of the AI policy rule.
> > > > 
> > > > 
> > > > The rule in this draft says 20 lines, tests, mechanical changes and docs.
> > > > The spirit is what is in the commit message, basically to maximize the
> > > > benefit and limit the possible damage?
> > > 
> > > Putting "the spirit" in the commit message is essentially /dev/null to
> > > anyone reading the policy later.
> > > 
> > > > > See my reply to Peter elsewhere in the thread. I agree with your
> > > > > > concerns for both docs and discretion, but I had specific uses in mind
> > > > > > that I'd like to allow.
> > > > > >
> > > > > > For docs:
> > > > > > - create tutorials and/or feature documentation based on functional tests
> > > > >
> > > > > That doesn't sound too appealing to me. Reverse engineering docs or
> > > > > tutorials from our functional tests is exactly the kind of thing that feels
> > > > > likely to result in volumous text of marginal value which will have a large
> > > > > burden on reviewers.
> > > > >
> > > > 
> > > > At the same time this can be helpful for maintainers themselves? Let's also
> > > > look at this from the point of view of producing better output, not just
> > > > from that of being on the receiving end of slop. Especially for docs I have
> > > > a hard time imagining people sending out whole new "manuals"... The
> > > > bugfixes rule ironically seems the most dangerous to me from the
> > > > Dunning-Krueger point of view.
> > > > 
> > > > My question is: do we want disclosure for anything is created with the help
> > > > of LLMs, even if only small parts survive untouched? I think so, because a
> > > > lot more, even if edited, would still be originally from AI. But then it's
> > > > important to have rules allowing it and a way to track it.
> > > 
> > > IMHO need unconditional disclosure, because the use of the LLM impacts
> > > the license of the code. QEMU is traditionally expected to be GPLv2+
> > > licensed for all new code, but there's the train of thought that LLM
> > > code is public domain.
> > > If it gets human editting afterwards we can
> > > consider that the human edits are GPLv2+ licensed, but IMHO we still
> > > want to know the origins.
> > 
> > Wait that's a big ask.
> > 
> > DOC explicitly does not ask if code might be available anywhere else
> > under any other license. Just that contributor can contribute under GPL.
> > If it's public domain then the human can license is under GPL.
> 
> For new files, in checkpatch we validate that SPDX-License-Identifier
> is explicitly set as GPL-2.0-or-later. Contributors are expected to
> justify any divergence in the commit message.
> 
> I've seen guidance that SPDX-License-Identifier for AI output code
> should NOT state a license, under the theory it is public domain.

Not state a license? Recommended by a lawyer? Seen where? Why?

> If it is human editted though, I would expect it to overrule this
> guidance and explicitly state GPL-2.0-or-later in the SPDX tag
> unless the contributor wants to explicitly put their own edits
> under public domain too.
> 

Yes.  So far we just asked:

  (b) The contribution is based upon previous work that, to the best
      of my knowledge, is covered under an appropriate open source
      license and I have the right under that license to submit that
      work with modifications, whether created in whole or in part
      by me, under the same open source license (unless I am
      permitted to submit under a different license), as indicated
      in the file; or


this:
	 unless I am permitted to submit under a different license
applies to public domain works.


> Ultimately QEMU is a copyleft project as a whole and IMHO we should
> prioritize retaining that for as large a portion of the codebase is
> is practical.

But of course. We can make this explicit too: that
contributing it should be under GPL and/or implies licensing it under GPL.


> > > > It would definitely be intended for merge. There's a lot of boilerplate
> > > > code in the Rust bindings, for example, that is voluminous but *mostly*
> > > > lacks creativity---the creative part basically can be described by the
> > > > spec/docs and should already clear the low bar required for originality,
> > > > even if the code is automatically generated. I included a couple examples
> > > > in my reply to Peter.
> > > 
> > > So we know there are examples which are probably low risk from a license
> > > POV, but which are massively larger than 20 lines of code. This just
> > > makes me more uncomfortable with the 20 line rule as the definition of
> > > the policy - we know that rule is wrong / undesirable from the start and
> > > needs this exception to make it viable.
> > 
> > So 20 lines or mechanical changes? what is considered mechanical will be
> > decided by maintainers, contributor should check with them up front.
> 
> If we are wanting to allow mechanical changes / boilerplate, then we
> should express that in the policy such that the policy can be reasonably
> understood without having to ask permission / questions ahead of time. 
> 
> With regards,
> Daniel

Indeed but what is mechanical is a matter of taste.


> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


