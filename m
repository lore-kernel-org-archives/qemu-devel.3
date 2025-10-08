Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3BACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RbK-0002r4-Ed; Wed, 08 Oct 2025 06:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6RbH-0002qp-UK
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6RbD-0007RK-8M
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759920044;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ek8lD6TdCz1DHYEDDMhtIXXWWIRyhBy2l13RyAUyucg=;
 b=Aj7mg6UGb4P6lJc/bWi/ZVlPYnzZ8jvMOgJTJbJCE/09nMiLYsVHXqsdD0+H1jaqctHyur
 f3ODgUJN4l8fjCIrKFSM8RkkY+4C583xL5cnyjfdJ4R2jxkbDdbgsUjjTWLelbkcpxAW2r
 CyR8pCOOP8iQGy1/7+l+8QZHFHLJPOQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-uxr1exJXM9GsVLO8fGo-cA-1; Wed,
 08 Oct 2025 06:40:39 -0400
X-MC-Unique: uxr1exJXM9GsVLO8fGo-cA-1
X-Mimecast-MFC-AGG-ID: uxr1exJXM9GsVLO8fGo-cA_1759920038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43E841800584; Wed,  8 Oct 2025 10:40:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0283A1800446; Wed,  8 Oct 2025 10:40:33 +0000 (UTC)
Date: Wed, 8 Oct 2025 11:40:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 0/6] tracetool: add mypy --strict checking [AI discussion
 ahead!]
Message-ID: <aOY_nawkW8K7XxDv@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Oct 08, 2025 at 08:35:39AM +0200, Paolo Bonzini wrote:
> Comparing the results from RightTyper and AI, both tools benefit from human
> help: the dead code removal which I mentioned, the small cleanups in patch 1,
> the final manual fixes for the remaining (mostly trivial) errors.  But at
> least in this case, AI is a winner:
> 
> - it left basically no unannotated code: fixing the above errors was enough
>   to pass "mypy --strict", unlike RightTyper which needed a little more work
>   due to its profiling-based nature and a few other limitations (see patch 5).
> 
> - most importantly, trying various other tools that didn't work, as well as
>   figuring out how to use RightTyper, took a couple hours more.  Surprising
>   as it was, I could not find any static type inferencing tool for Python;
>   neither pytype nor pyre worked for me.  This is also why I think this
>   is not apples to oranges, but a fair comparison between AI-based and
>   regular tooling.

FWIW, there was a third possible option here, a sort of hybrid...

   prompt> find me tools that can add python type annotatinos to code
   prompt> show me how to invoke tool <blah> on the QEMU codebase.
   prompt> run the tool <blah> on the QEMU code, run mypy tests and
           commit the result

that would probably have saved the hours learning how to use RightTyper
making it more competitive with the pure AI approach.

> After the diffstat, you can find a diff from this series to the version
> based on Claude Code.  It's impossible to be 100% objective but,
> besides being functionally equivalent, I don't think either would be
> identifiable as written by an LLM, by a person, by a tool+human combo,
> or even by a good type inferencing tool (if it existed).

AFAICS the diff there is either whitespace changes, or a differing
style for  importing a module vs importing a name from a module.

Whitespace we should be enforcing with 'black' formatting rules.
For import style, I'd say that's an irrelevant difference.

IOW, I'd call the two patches identical for any practical purposes.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


