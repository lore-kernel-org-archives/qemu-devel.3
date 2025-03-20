Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819ECC36002
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCDI-0004HY-L9; Thu, 20 Mar 2025 05:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tvCDH-0004HG-75
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tvCD1-0006Im-Rc
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742462941;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Uo8M0qf0fsqfsWF9phV4ivXhot7tTYmzLT6X/vliJW0=;
 b=NjCkqaEUYVJZG1r0Sc6eYbXoFWRGoroFSrlnXLXkcEe/wZYsg+Gehb6sVuE5f8tjauWh7K
 jpn1v3JbHUuhxSze1mgwLEmA0vZEvqNdsmeXBD8oon38EMRc7nMDncjxBGlIo4aTFFdF9Z
 bGBjzSpVJU0jpQ9nh3l0YNcRn1kK/b0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-wMzd6j2wM9K0NISC0BI1jA-1; Thu,
 20 Mar 2025 05:28:57 -0400
X-MC-Unique: wMzd6j2wM9K0NISC0BI1jA-1
X-Mimecast-MFC-AGG-ID: wMzd6j2wM9K0NISC0BI1jA_1742462936
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 938A019560BB; Thu, 20 Mar 2025 09:28:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 255971800946; Thu, 20 Mar 2025 09:28:54 +0000 (UTC)
Date: Thu, 20 Mar 2025 09:28:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Corey Minyard <corey@minyard.net>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] cleanup: Drop pointless label at end of function
Message-ID: <Z9vf05yjMWkwmMVp@redhat.com>
References: <20250319152126.3472290-1-armbru@redhat.com>
 <20250319152126.3472290-4-armbru@redhat.com>
 <CAB9gMfrxe7NWk_1GkudEeWby-ZHaH1xTWD5n7WfK7iz4qKsL6g@mail.gmail.com>
 <87o6xwkerz.fsf@pond.sub.org> <Z9seHbw1IepwkppI@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9seHbw1IepwkppI@mail.minyard.net>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 19, 2025 at 02:42:21PM -0500, Corey Minyard wrote:
> On Wed, Mar 19, 2025 at 08:21:20PM +0100, Markus Armbruster wrote:
> > Corey Minyard <corey@minyard.net> writes:
> > 
> > > Is this official coding style?  I'm not a big fan of having return
> > > statements in the middle of functions, I generally only put them at
> > > the beginning or the end.
> > 
> > There's nothing in docs/devel/style.rst.
> > 
> > I count more than 42,000 return statements with indentation > 4.  These
> > are either within some block, or incorrectly indented.  I'd bet my own
> > money that it's the former for pretty much all of them.
> > 
> > I count less than 130 labels right before a return statement at end of a
> > function.
> > 
> > Based on that, I'd say return in the middle of function is
> > overwhelmingly common in our code.
> > 
> 
> Ok.  It's not a huge deal to me.  I think it's more dangerous to
> have returns in the middle; they are easy to miss and an "out:" at the
> end make it more clear there are returns in the middle.  But that's
> just my opinion.  To make wholesale changes like this I would prefer
> it be in the style guide.  But, I don't want to start a holy war,
> either.  Sigh.

In traditional C, I would agree with you that mid-function 'return's
are often a bad idea, because they complicate free'ing of memory and
tend to actively encourage memory/resource leaks.

With our adoption of g_auto/g_autofree, that problem has been
eliminated across a decently large subset of code. This swings
the balance so that having mid-function 'return's often (but not
always) results in shorter & easier to understand code, with few
leak possiblities, provided g_auto/autofree is sufficient to deal
with all cleanup needs.

There will still be cases where it makes more sense to use 'goto'
for cleanup, since g_auto/autofree is sufficient in all scenarios.

Thus I don't think we should have a rule that strictly dictates
either way. Better to leave it upto author's judgement call as to
which approach results in clearer code for each particular function.
I would still encourage maximising use of 'g_auto/autofree' where
practical.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


