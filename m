Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082AFC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 19:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn1tp-000476-M7; Wed, 20 Mar 2024 15:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn1to-00046x-5g
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn1tj-0001YZ-Kh
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710964010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djk084YAJ518mC5MnmRzuLhoi3UjEbI7QyEQ9cE1z78=;
 b=a+lCv1zLHFE/aVVus6P+biYbaJUke38p9RcXkyLLZhTacDxOFq1OmXbb+6IhBdmdXrRr8l
 oANcF8b4Ho3/OQWF7vjwPDblY+FlCwgBZx83sG9GVl+QRa4LZuGZqkNNzcCBw4qGTYBJks
 MtpH6b1MZlYeE9EwTwPxA2K02IPM+FY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-R41w-8rAOgSKzFEMO-LaZg-1; Wed, 20 Mar 2024 15:46:48 -0400
X-MC-Unique: R41w-8rAOgSKzFEMO-LaZg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7830635331bso4526085a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 12:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710964007; x=1711568807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djk084YAJ518mC5MnmRzuLhoi3UjEbI7QyEQ9cE1z78=;
 b=JFbIwtapOEBg1KJ9M9c6HUb158z8pO8GfI50YuJkMIkKT3lzNAWEpKGVR1WlQlmsIC
 rGxC0kJcbRKVBdk+B8UpfHvhzYx70e8fshyl0o43vcJcLVZH2lnJDqEDtKGUK08C6rJn
 k7/3/dc8zxa884gOJ9FgR1FtU5pZgNM6QIjfESutXLjtmykpcAtrI0DQ6N4m/BdLMG+1
 wYwhQqDAybWem9eP2R7MMSZx0p7euFeCIl7l+/LjsW5WiSQU4PRmBS6s5hblF4U+h9NJ
 TCgGQfYEmJqlLYy9c7TrxYtnuqnWL+yjuwu3/h5u2gFlHo4JBK7s4eADD4P/M167rg9W
 OceQ==
X-Gm-Message-State: AOJu0Yzz/ncD1N+8QfRqdjOMYy/tcLPMufOfDfZ/IoAdNoqh6GC0XhY6
 +M2D4KsqRtvTP2PihF3k0BzcBVzw+PASTrkvKbgdX6BlRYSs2Q+6gdyVsFrgSQMinHQVShHcrhW
 BF8Q74USDXNOcBMJOQyYQgI4xjA68J5Onr7TWsx6A9xJsrhjhvPR2
X-Received: by 2002:a37:e107:0:b0:78a:22f0:dbf8 with SMTP id
 c7-20020a37e107000000b0078a22f0dbf8mr2179063qkm.0.1710964007484; 
 Wed, 20 Mar 2024 12:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXhmid+dsCsqHoxiMHpveJT0NePx/GRCty/YFLQ0jTNEvtzNWqGywUy8sAI0Qi6z0UanSX/g==
X-Received: by 2002:a37:e107:0:b0:78a:22f0:dbf8 with SMTP id
 c7-20020a37e107000000b0078a22f0dbf8mr2179042qkm.0.1710964006973; 
 Wed, 20 Mar 2024 12:46:46 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 v7-20020a05620a090700b007887583762csm6842413qkv.94.2024.03.20.12.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 12:46:46 -0700 (PDT)
Date: Wed, 20 Mar 2024 15:46:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/3] migration: Drop unnecessary check in ram's
 pending_exact()
Message-ID: <Zfs9JOBhz-I7D_eI@x1n>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-3-peterx@redhat.com>
 <bc88f4572649084cd38a0880d7e096a939f80b14.camel@linux.ibm.com>
 <ZfsxjS4Phkf34f4J@x1n>
 <7c1f0248465d55ff804c32ed7bb366d4a03abdec.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c1f0248465d55ff804c32ed7bb366d4a03abdec.camel@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 20, 2024 at 08:21:30PM +0100, Nina Schoetterl-Glausch wrote:
> On Wed, 2024-03-20 at 14:57 -0400, Peter Xu wrote:
> > On Wed, Mar 20, 2024 at 06:51:26PM +0100, Nina Schoetterl-Glausch wrote:
> > > On Wed, 2024-01-17 at 15:58 +0800, peterx@redhat.com wrote:
> > > > From: Peter Xu <peterx@redhat.com>
> > > > 
> > > > When the migration frameworks fetches the exact pending sizes, it means
> > > > this check:
> > > > 
> > > >   remaining_size < s->threshold_size
> > > > 
> > > > Must have been done already, actually at migration_iteration_run():
> > > > 
> > > >     if (must_precopy <= s->threshold_size) {
> > > >         qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
> > > > 
> > > > That should be after one round of ram_state_pending_estimate().  It makes
> > > > the 2nd check meaningless and can be dropped.
> > > > 
> > > > To say it in another way, when reaching ->state_pending_exact(), we
> > > > unconditionally sync dirty bits for precopy.
> > > > 
> > > > Then we can drop migrate_get_current() there too.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > 
> > > Hi Peter,
> > 
> > Hi, Nina,
> > 
> > > 
> > > could you have a look at this issue:
> > > https://gitlab.com/qemu-project/qemu/-/issues/1565
> > > 
> > > which I reopened. Previous thread here:
> > > 
> > > https://lore.kernel.org/qemu-devel/20230324184129.3119575-1-nsg@linux.ibm.com/
> > > 
> > > I'm seeing migration failures with s390x TCG again, which look the same to me
> > > as those a while back.
> > 
> > I'm still quite confused how that could be caused of this.
> > 
> > What you described in the previous bug report seems to imply some page was
> > leftover in migration so some page got corrupted after migrated.
> > 
> > However what this patch mostly does is it can sync more than before even if
> > I overlooked the condition check there (I still think the check is
> > redundant, there's one outlier when remaining_size == threshold_size, but I
> > don't think it should matter here as of now).  It'll make more sense if
> > this patch made the sync less, but that's not the case but vice versa.
> 
> [...]
> 
> > In the previous discussion, you mentioned that you bisected to the commit
> > and also verified the fix.  Now you also mentioned in the bz that you can't
> > reporduce this bug manually.
> > 
> > Is it still possible to be reproduced with some scripts?  Do you also mean
> > that it's harder to reproduce comparing to before?  In all cases, some way
> > to reproduce it would definitely be helpful.
> 
> I tried running the kvm-unit-test a bunch of times in a loop and couldn't
> trigger a failure. I just tried again on a different system and managed just
> fine, yay. No idea why it wouldn't on the first system tho.

There's probably still a bug somewhere.  If reproduction rate changed, it's
also a sign that it might not be directly relevant to this change, as
otherwise it should reproduce the same as before.

> > 
> > Even if we want to revert this change, we'll need to know whether this will
> > fix your case so we need something to verify it before a revert.  I'll
> > consider that the last though as I had a feeling this is papering over
> > something else.
> 
> I can check if I can reproduce the issue before & after b0504edd ("migration:
> Drop unnecessary check in ram's pending_exact()").
> I can also check if I can reproduce it on x86, that worked last time.
> Anything else? Ideas on how to pinpoint where the corruption happens?

I don't have a solid clue yet, but more information of the single case
where it reproduced could help.

I saw from the bug link that the cmdline is pretty simple.  However still
not sure of something that can be relevant.  E.g., did you use postcopy
(including when postcopy-ram enabled but precopy completed)?  Is there any
special device, like s390's CMMA (would that simplest cmdline include such
a device; apologies, I have zero knowledge there before today)?

I _think_ when reading the code I already found something quite unusual,
but only when postcopy is selected: I notice postcopy will frequently sync
dirty bitmap while it doesn't really necessarily need to, because
ram_state_pending_estimate() will report all ram as "can_postcopy"; it
means it's highly likely that this check will 99.999% always be true simply
because must_precopy can in most cases be zero:

    if (must_precopy <= s->threshold_size) { <---------------------------- here
        qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
        pending_size = must_precopy + can_postcopy;
        trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
    }

I need to think more of this, but this doesn't sound right at all.  There's
no such issue with precopy-only, and I'm surprised it is like that for years.

-- 
Peter Xu


