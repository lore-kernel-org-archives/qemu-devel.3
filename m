Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBEBCD1292
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 02:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsZO5-0003oE-2t; Thu, 04 Apr 2024 22:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rsZO4-0003o6-Cg
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 22:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rsZO1-000477-29
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 22:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712284373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TboPRuW2vLziGReAQmpdc0/MtuuFEyszromN2Pae3U=;
 b=hg65UQbV67LTS6A83RDw6q+jpWX7Oy681f54rSl7zuW2WnaYjRm396LvTjLOxyKjx8ZiM5
 j0jYGiFHR/UQpXSQ7IAB+vKfuQbmHTKvhH7H26b24T+EeeDXw8v02VjfdCAlOIm5FyxA8F
 YtuXrw9TI3BnwljynitmcREWPQVcPRQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-nClEtGGzOqCUosnCcHXnDg-1; Thu, 04 Apr 2024 22:32:51 -0400
X-MC-Unique: nClEtGGzOqCUosnCcHXnDg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4311dd10102so5312101cf.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 19:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712284371; x=1712889171;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/TboPRuW2vLziGReAQmpdc0/MtuuFEyszromN2Pae3U=;
 b=E4X0njfoc7fdkkvrg+8+2UXRPVBYtPolWrpXhJ6bX89fxbruF3AwYq5kCT+A/V3Fgf
 oyRHFKBvTp/CzEJup1H3FSsJtf/Oy/FE0TeO+YtXc7LRRTEOuU9FLIrHcE1gEbca0Drq
 RyGXY+Qa98LGO4er9El4/UUNASlLjT0NasZ7GCeIoaCYtoOGpx9Bp0D9YmERh71lIOdC
 SWhYF3ZZamz99Se0aQzu3G/21+BPC81gR39Xx3B2rUeKlrhsGOBnJHUf3o5Mi4ZdqZqf
 R9Y2miuWnUgo/mPwdaGUsILtNkGnB+h/YhWcmRClfCLf/Wd0p5qKy6NOlFQ7dMhtQs7l
 06pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlVFGM80EcQchhPjagMzRXY7m54iKRc72QpPmHZ3Tz5qa0KGB/ODzRWWTkX9cv+SU5LYbgNwX79tBLelS6nZTaAyCOTkA=
X-Gm-Message-State: AOJu0Yw7303BLXRUBUMe1MfnYrWn0gNnXd0g37e/migYTQx7Aimleyvm
 9E22B0IU5+BEBZrITuWh3idOJcxdTqY0chHkmiHl+t0aQ2JrV4lROdCGFhXKzD6wjgEXezqG2XK
 L5GM0/lF7BWa6p2JPBnBEmXOkg144E9hRlbh1B3J8pbncMw7/ogGR
X-Received: by 2002:a05:620a:24cb:b0:78b:ead0:4e98 with SMTP id
 m11-20020a05620a24cb00b0078bead04e98mr190178qkn.5.1712284371117; 
 Thu, 04 Apr 2024 19:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0L4gDsjeRYNylBI2aFqB+8FgloSA/UHlBnm9So1fvOycw9jOgktP3+4NhB9b6Edft+mw1tA==
X-Received: by 2002:a05:620a:24cb:b0:78b:ead0:4e98 with SMTP id
 m11-20020a05620a24cb00b0078bead04e98mr190154qkn.5.1712284370470; 
 Thu, 04 Apr 2024 19:32:50 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 y14-20020a05620a09ce00b0078a3a448228sm268422qky.85.2024.04.04.19.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 19:32:50 -0700 (PDT)
Date: Thu, 4 Apr 2024 22:32:49 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Message-ID: <Zg9i0e9YI3cwUnOB@x1n>
References: <20240404100550.17777-1-wei.w.wang@intel.com>
 <Zg61FnuPPAYAJs45@x1n>
 <DS0PR11MB6373FB3A707271E6E158258ADC3C2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <757123c0-c4f9-4332-adb7-e6296ab8d54a@intel.com>
 <Zg8UB900V4NpTwNG@x1n>
 <DS0PR11MB637365DD124863C6C0DC995EDC032@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB637365DD124863C6C0DC995EDC032@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Apr 05, 2024 at 01:38:31AM +0000, Wang, Wei W wrote:
> On Friday, April 5, 2024 4:57 AM, Peter Xu wrote:
> > On Fri, Apr 05, 2024 at 12:48:15AM +0800, Wang, Lei wrote:
> > > On 4/5/2024 0:25, Wang, Wei W wrote:> On Thursday, April 4, 2024 10:12
> > > PM, Peter Xu wrote:
> > > >> On Thu, Apr 04, 2024 at 06:05:50PM +0800, Wei Wang wrote:
> > > >>> Before loading the guest states, ensure that the preempt channel
> > > >>> has been ready to use, as some of the states (e.g. via
> > > >>> virtio_load) might trigger page faults that will be handled through the
> > preempt channel.
> > > >>> So yield to the main thread in the case that the channel create
> > > >>> event has been dispatched.
> > > >>>
> > > >>> Originally-by: Lei Wang <lei4.wang@intel.com>
> > > >>> Link:
> > > >>> https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@i
> > > >>> ntel
> > > >>> .com/T/
> > > >>> Suggested-by: Peter Xu <peterx@redhat.com>
> > > >>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> > > >>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > >>> ---
> > > >>>  migration/savevm.c | 17 +++++++++++++++++
> > > >>>  1 file changed, 17 insertions(+)
> > > >>>
> > > >>> diff --git a/migration/savevm.c b/migration/savevm.c index
> > > >>> 388d7af7cd..fbc9f2bdd4 100644
> > > >>> --- a/migration/savevm.c
> > > >>> +++ b/migration/savevm.c
> > > >>> @@ -2342,6 +2342,23 @@ static int
> > > >>> loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
> > > >>>
> > > >>>      QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
> > > >>>
> > > >>> +    /*
> > > >>> +     * Before loading the guest states, ensure that the preempt channel
> > has
> > > >>> +     * been ready to use, as some of the states (e.g. via virtio_load) might
> > > >>> +     * trigger page faults that will be handled through the preempt
> > channel.
> > > >>> +     * So yield to the main thread in the case that the channel create
> > event
> > > >>> +     * has been dispatched.
> > > >>> +     */
> > > >>> +    do {
> > > >>> +        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
> > > >>> +            mis->postcopy_qemufile_dst) {
> > > >>> +            break;
> > > >>> +        }
> > > >>> +
> > > >>> +        aio_co_schedule(qemu_get_current_aio_context(),
> > > >> qemu_coroutine_self());
> > > >>> +        qemu_coroutine_yield();
> > > >>> +    } while
> > > >>> + (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done,
> > > >>> + 1));
> > > >>
> > > >> I think we need s/!// here, so the same mistake I made?  I think we
> > > >> need to rework the retval of qemu_sem_timedwait() at some point later..
> > > >
> > > > No. qemu_sem_timedwait returns false when timeout, which means sem
> > isn’t posted yet.
> > > > So it needs to go back to the loop. (the patch was tested)
> > >
> > > When timeout, qemu_sem_timedwait() will return -1. I think the patch
> > > test passed may because you will always have at least one yield (the
> > > first yield in the do ...while ...) when loadvm_handle_cmd_packaged()?
> > 
> > My guess is that here the kick will work and qemu_sem_timedwait() later will
> > ETIMEOUT -> qemu_sem_timedwait() returns -1, then the loop just broke.
> > That aio schedule should make sure anyway that the file is ready; the preempt
> > thread must run before this to not hang that thread.
> 
> Yes, misread of the return value. It still worked because the loop broke at
> the "if (mis->postcopy_qemufile_dst)" check.
> 
> Even below will work:
> do {
>     if (mis->postcopy_qemufile_dst) {
>         break;
>      }
> ...
> } while (1);
> 
> I still don’t see the value of using postcopy_qemufile_dst_done sem in the code though
> It simplify blocks the main thread from creating the preempt channel for 1ms (regardless
> of the possibility about whether the sem has been be posted or not. We add it for the case
> it is not posted and need to go back to the loop).

I think it used to only wait() in the preempt thread, so that is needed.
It's also needed when postcopy is interrupted and need a recover, see
loadvm_postcopy_handle_resume(), in that case it's the postcopy ram load
thread that waits for it rather than the main thread or preempt thread.

Indeed if we move channel creation out of the preempt thread then it seems
we don't need the sem in this path.  However the other path will still need
it, then when the new channel created (postcopy_preempt_new_channel) we'll
need to identify a "switch to postcopy" case or "postcopy recovery" case,
only post the sem when the former.  I think it might complicate the code,
I'll think again tomorrow after a sleep so my brain will work better, but I
doubt this is what we want to do at rc3.

If you feel comfortable, please feel free to send a version that you think
is the most correct so far (if you prefer no timedwait it's fine), and make
sure the test works the best on your side.  Then I'll smoke it a bit during
weekends. Please always keep that in mind if that will be for rc3 it should
be non-intrusive change, or we keep it slow for 9.1 and we don't need to
rush.

Thanks,

-- 
Peter Xu


