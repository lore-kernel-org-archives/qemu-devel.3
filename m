Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0CDCD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 19:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUV9W-0003rS-5t; Tue, 02 Jun 2026 15:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUV9U-0003qu-Km
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 15:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUV9S-0002r1-JF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 15:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780429909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xMfVwINepOmViYIvNgMpykGSmbUAr2HE8FtTMWi6j94=;
 b=K0TcPphMgWabeaV6ib0ziLn2w8+ItTffLB9wTyPc+RcIGFjmWDaMF+tj5jV5OhhfuF5qH6
 ce4wGn0QY6WgakM3uH+7QNKGN1v9bKcAx/eHJwd6ezzfOgPRWI+IfMP9mxRlGZNjA/uR9T
 Vyb9EmzOnwE+15BAtvBrhIIHN/1+7QQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-fhtXyfyyNOGDuB6ovoXFAA-1; Tue, 02 Jun 2026 15:51:47 -0400
X-MC-Unique: fhtXyfyyNOGDuB6ovoXFAA-1
X-Mimecast-MFC-AGG-ID: fhtXyfyyNOGDuB6ovoXFAA_1780429907
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157929bf8fso385606785a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780429907; x=1781034707; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xMfVwINepOmViYIvNgMpykGSmbUAr2HE8FtTMWi6j94=;
 b=o4Kgmf103g3djlzQNtC5EdGw2L1MakXr0xnEXUoUS3CQpMj9wMsSgBkXTZOTkCy102
 Aq3YrsVVGgjbQofNnj6ISS1HvKJMOwEwTukMl9QQCzzeUn43j1n5sphi2pEYPrk7hznj
 nWnWySJybdB3cVWkPr8aFVzLoJTmY5KVMLhly1nw5hRBcHTftCWUgpzB2v/AYHEo9DHw
 iyohNMDusHnqXk+7Q/sH8xh2BkEOvifmdM1T3Iqf3pbvD65+FnM7tEsUBeDdUSgMTV3u
 HkYPepxZycAMQlYQzONVpvdy45xbruWaXtihS/Ks9Tpal8J1JLAHrYCDs+RwR2akhlpy
 PRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780429907; x=1781034707;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xMfVwINepOmViYIvNgMpykGSmbUAr2HE8FtTMWi6j94=;
 b=AEM61ZwPSKLXpbjCY8xPoLX6diq+rFgQye8EhOjN0oYR0xiGLOW6a6nJ9W0k6dYXGi
 dvT44SCxIXF6sjXzIRwodMPPgCKiwsEvc5P21AVDVLX78+5fn0dSxhmjP0NvenH36w14
 VQoGYa+k5A6ty9NgG2TCXI+DI5YlB/CHh3PCXH7h2C61hRvwd3kiWUq6x3Sv9gVmFTKE
 S0ZDHLbTUb7K4P1qwlMiN4qDoy/kUE5rwlPtaUaH1+D+4FjLpCG1LP6bN/ULDt0mKP/b
 0QTijBhrfgiuoXJTWw+8mnUfGZm8ygWgEe+fur5q7GHcJqxzkM8QohqSYsoCAsI99/C5
 hhiw==
X-Gm-Message-State: AOJu0YwMsnTJDWCQXI0d/5rT9hIA5nLsfQL4vM1CvG1AJwk8N0L+E9LX
 47DHCWOY/5rjyxPfswYzkrTLrt6oGl1jVu1sLvrIvZVivNnPJ8NbRBAkoWK/oximw3YKtIF3d6E
 f2+xBi9fEezLfQ5jTUGirrL/8TZAJFqqln9YmePboOzC0Lj2crXEWitpc
X-Gm-Gg: Acq92OFPB4XW6PlL3lTuYEITJ4l9odSG5+IYO58DvTRViJOlFdiq8Db/L8/rVFhmoJf
 IZQ6X1VQmU1dBU+mpGMi6I7tKD9OMxqBJK7QTCwCSr8EO8mwK8I2BsB0eWn+Az4EsbMAH8EAuWg
 18FXkbGDJQI0ndtGDxlPgG+V6A/n/JHH5qu9DZNjsgWaqFjIdvmdcbEAMgG7x2Is+Cq5aam3hDi
 3Ka+NNW6R6M03HKmq9Xs1BhJYsLEAuuUsmJJXcMG9fu96CvO1Iz9hvdPh4cDg81jAg8FBwskdm+
 yaLLJ3xlnRL9CmOWpFKNWhBGIpTAI+zu8N5kKPjWMdIiVei5nBXzOPsySMYtxGxGL+aFlZ50Our
 gf3Fa3yvyEmoQwWciEpt9AdO1gQ==
X-Received: by 2002:a05:620a:4482:b0:909:c82b:9756 with SMTP id
 af79cd13be357-9158a659573mr92381685a.5.1780429906833; 
 Tue, 02 Jun 2026 12:51:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:909:c82b:9756 with SMTP id
 af79cd13be357-9158a659573mr92374185a.5.1780429905934; 
 Tue, 02 Jun 2026 12:51:45 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37cab6sm35366885a.22.2026.06.02.12.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 12:51:45 -0700 (PDT)
Date: Tue, 2 Jun 2026 15:51:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] memory/ramblock: Fix clear of mru_block on possible race
 condition
Message-ID: <ah80T6aIns82fspH@x1.local>
References: <20260601205900.1067714-1-peterx@redhat.com>
 <36749195-2c49-4f9c-8445-2e67b2097676@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36749195-2c49-4f9c-8445-2e67b2097676@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 02, 2026 at 01:25:02PM +0900, Akihiko Odaki wrote:
> On 2026/06/02 5:59, Peter Xu wrote:
> > The race condition was not reported in any real bug, but I found it while
> > reviewing some relevant chnages from Akihiko [1].  It's not clear if
> > there's any way to reproduce it, so far it's only theoretical.  Hence
> > there's also no Fixes tag attached.  There's also no need to copy stable
> > until we have a solid reproducer.
> > 
> > Currently, mru_block might still points to ramblocks that are removed if
> > below race condition happens:
> > 
> >    Reader A                              Writer
> >    --------                              ------
> >    rcu_read_lock()
> >    walk list, find block X
> >                                          QLIST_REMOVE_RCU(X)
> >                                          qatomic_set(&mru_block, NULL)
> >                                          call_rcu(X, reclaim_ramblock)
> >    qatomic_set(&mru_block, X)  <----------- overwrites NULL
> >    rcu_read_unlock()
> >                                          grace period ends, X freed
> > 
> >    Reader C
> >    --------
> >    rcu_read_lock()
> >    qatomic_rcu_read(&mru_block) -> X
> >    Read X's block->offset ...  <----------- UAF
> > 
> > To fix it, we can introduce a nested RCU free for reset of the mru_block
> > field, and only free the ramblock until the 2nd RCU call.
> > 
> > Since QEMU always: (1) dequeue the RCU node before invoking the
> > function, (2) reset all fields in rcu_head in the call_rcu1() call, nested
> > RCU will work all fine like what's used in this patch.
> > 
> > [1] https://lore.kernel.org/r/5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp
> > 
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > Based-on: <5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp>
> > 
> > Since there's no reproducer, I didn't verify the problem as-is.  What I did
> > is I ran this through some high concurrency "make check -jN" (8 processes
> > with 4 cores pinned, hence 8*N make-check threads running concurrently on 4
> > physical cores), I didn't see any regression.
> > ---
> >   system/physmem.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 9e1ac13e82..1697568fa7 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -2590,6 +2590,21 @@ static void reclaim_ramblock(RAMBlock *block)
> >       g_free(block);
> >   }
> > +static void reclaim_ramblock_prepare(RAMBlock *block)
> > +{
> > +    /*
> > +     * 1st round rcu free guarantees the last reader that can access this
> > +     * ramblock is gone.  Reset this field making sure it will never point

[1]

> > +     * to the ramblock being freed.
> 
> Somewhat nitpicking, but I would call this the first grace period rather
> than “rcu free”. call_rcu() itself does not free anything; it schedules a
> callback to run after a grace period, which is what matters here.

Sure, I'll fix the wording.

> 
> > +     */
> > +    qatomic_set(&ram_list.mru_block, NULL);
> > +    /*
> > +     * Note: this is an intended nested use of rcu_head.  If needed, we can
> > +     * provide two rcu_heads for ramblock.
> > +     */
> > +    call_rcu(block, reclaim_ramblock, rcu);
> > +}
> > +
> >   void qemu_ram_free(RAMBlock *block)
> >   {
> >       g_autofree char *name = NULL;
> > @@ -2607,10 +2622,11 @@ void qemu_ram_free(RAMBlock *block)
> >       name = cpr_name(block->mr);
> >       cpr_delete_fd(name, 0);
> >       QLIST_REMOVE_RCU(block, next);
> > +    /* First attempt of reset, see reclaim_ramblock_prepare() for the 2nd */
> >       qatomic_set(&ram_list.mru_block, NULL);
> 
> I think it would be better to remove this for simplicity.
> 
> mru_block is cleared later anyway, so this does not affect correctness. The
> only practical effect is that qemu_get_ram_block() may be slower during the
> first grace period.
> 
> Conceptually, it is simpler to describe the two grace periods as serving two
> distinct purposes, rather than as two attempts to clear mru_block. With the
> early clear removed, readers do not first need to understand that the first
> grace period leaves the first clear ineffective; they can instead focus on
> how it makes the later clear effective.

It was my intention to keep this, because then it's easier to justify
"nobody has access to the ramblock being removed".

If with this line removed here, it means after the first grace period (say,
reaching reclaim_ramblock_prepare()), RCU readers can still access the
ramblock, essentially because before reclaim_ramblock_prepare() clearing
mru_block even if the block is not visible on ram_list it's still visible
when a cache hit happens.

But I agree removal of this line shouldn't involve correctness issues,
because qemu_get_ram_block() when having a mru_block cache hit, will always
return the block directly:

[2]

    block = qatomic_rcu_read(&ram_list.mru_block);
    if (block && addr - block->offset < block->max_length) {
        return block;
    }

And it will never reach the "found:" label later to update mru_block again.
But that's obscure.

So it's a niche use of it, but keeping this line to reset makes this
justification slightly easier (corresponds to the comment at [1] above).

I can also remove this line, but then I'll need to enrich comment
explaining case [2] above.  We'll also need to be careful on not changing
that behavior in qemu_get_ram_block().

Thanks,

> 
> Regars,
> Akihiko Odaki
> 
> >       /* Write list before version */
> >       qatomic_store_release(&ram_list.version, ram_list.version + 1);
> > -    call_rcu(block, reclaim_ramblock, rcu);
> > +    call_rcu(block, reclaim_ramblock_prepare, rcu);
> >       qemu_mutex_unlock_ramlist();
> >   }
> 

-- 
Peter Xu


