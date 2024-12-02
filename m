Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BB2D10DDD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI2zN-0005NX-M7; Mon, 02 Dec 2024 04:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tI2zM-0005ND-0e
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:45:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tI2zJ-0007Ao-Ad
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733132703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOg6/JgICJkBT7w3F/DKQWvo3YOGeykTVX+p6Nh7wXA=;
 b=gKSqLZ+tROBJiVQlbVtOt1OuuNso96X+TqgdVkU62BGtgDC3eWLANB6PAv99xIOf7wb5rM
 1zmCYebhCTXuikC+iH/m2YipeJ05+8Yql14qYdTiInITheX7Im/l4e6JsL2RFrhXSXgeLn
 KxQ0k0SChksnNVgHTokFIMuAjuhBvac=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-bzhxT3BGOFqMTX699_2tsg-1; Mon, 02 Dec 2024 04:44:59 -0500
X-MC-Unique: bzhxT3BGOFqMTX699_2tsg-1
X-Mimecast-MFC-AGG-ID: bzhxT3BGOFqMTX699_2tsg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434941aa9c2so21786495e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 01:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733132698; x=1733737498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOg6/JgICJkBT7w3F/DKQWvo3YOGeykTVX+p6Nh7wXA=;
 b=e/lPmLiPiQZfzut7xgxVRreoZVMYCsbd22p2MBSQzAqHoT0Sfz+sUZ3Ga9wj20shur
 BbMfu8L0cCgpyJ6k4Ya143XI4RnruQQDX+khq49PhMzOOqqaX85966nDEeKJM9gGrUGb
 wINqAF1V5DOJd724TQyDvAvSVl5lpdxAJ9auf3CxNAzWypLvPD0OS0Uknwe5fb7CfidG
 mNEbh0+st9z6e6ipIKeUuHJbzYbjz41MxFVmv2V5QAWQ60FF8dj9XpPTS8qLfA1LzZhM
 voGpa38PVN69O+k2IL5/dnBHQ5fBmrsLE1IIkjRucRtEa2mzVze8zUdb4WpMYewJtUsW
 ub7w==
X-Gm-Message-State: AOJu0YyVyHFmbV1JoNYqqJSHIOVdC9g8d0H1sKxCD1JAyOagLpPmjGc0
 QDnpVumAhL/ODYiBYfPybZ4Uy4tqnB0kBJ5kH+/oqC4bA2mhaAYg+cFN8lQsiy3lZeh9gMh8v5f
 KJrY9jJQJQmPBpaAij/QTSRwIvSn+cK+fNppG9DuxToWLq7laq6YMTx6bbNACvp84v/bw6b/LqH
 ksutxnAvk3iRJrIocqr3De5VVx2SQ=
X-Gm-Gg: ASbGncukERjKWia0STe3ywgDmY10lgAdCannu6NZcleVumsfYkZUBn3dz8ZjKzFirCj
 XsObKWx7gAY7hzAbkClIOT+nWBh21WlvoQg==
X-Received: by 2002:a05:600c:3591:b0:434:a529:3b87 with SMTP id
 5b1f17b1804b1-434a9dc37f2mr234658545e9.10.1733132698062; 
 Mon, 02 Dec 2024 01:44:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7PHMvTmmYDuqDddqIr142KMIJDZKfcjcw2oc+cCz5bXPbTVnIPDeqQqNwNNQB3OO1OVWXKYz1P13WWw7I1zo=
X-Received: by 2002:a05:600c:3591:b0:434:a529:3b87 with SMTP id
 5b1f17b1804b1-434a9dc37f2mr234658225e9.10.1733132697649; Mon, 02 Dec 2024
 01:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com>
 <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
 <875xo8n4ue.fsf@suse.de>
 <CAE8KmOzfaxzxTCMoF6miOG5fYFaikmz7sm9UeuAe6u1Optz8fg@mail.gmail.com>
 <87y113jy18.fsf@suse.de>
In-Reply-To: <87y113jy18.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 2 Dec 2024 15:14:41 +0530
Message-ID: <CAE8KmOygGSr=DuWdeVppgxq9UN2XG0fmMEV+nO=Q=QXQb4m8oA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Fabiano,

On Thu, 28 Nov 2024 at 18:50, Fabiano Rosas <farosas@suse.de> wrote:
>>> We currently have a mess of conditionals to achieve the correct
>>> combination of multifd local flushes, where we sync the local
>>> (send/recv) multifd threads between themselves, and multifd remote
>>> flushes, where we put a flag on the stream to inform the recv side to
>>> perform a local flush.
...
> >> +    if (do_local_flush) {
> >> +        ret = multifd_ram_flush_and_sync();
> >> +        if (ret < 0) {
> >> +            return ret;
> >> +        }
> >> +    }
> >> +
...
> >> +    /* Put a flag on the stream to trigger a remote flush */
> >> +    if (do_remote_flush) {
> >> +        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> >> +        qemu_fflush(f);
> >> +    }
> >> +
> >> +    if (do_local_flush) {
> >> +        multifd_recv_sync_main();
> >> +    }
...
>These syncs are all related and we'd like to be able to reason about
> them in a single place, not in several little pieces all over the place.
> When a new feature comes up, like it did when mapped-ram was introduced,
> we don't want to go around having to squint at conditionals to know whether
> it applies to the new case or not.
>
> Also, ram.c is not the place for open-coded multifd code. The same
> mapped-ram example applies: having to add if (migrate_mapped_ram())
> throughout the ram code was a pain and we had some iterations of
> flipping the logic until we got it right.

* I see. If it is the larger complexity of how multifd threads do
flush/sync, not just about long conditionals with 3-4 sub-expressions,
I think this can be done separately, instead of as part of this patch
series.

> There is no fflush() going on here. This code is about the multifd
> flush, which sends the remaining data from MultiFDPages_t and the
> multifd sync, which synchronizes the multifd threads. That qemu_fflush
> is just to make sure the destination sees flag on the stream.

* Yes, there is no fflush(3) call. I mentioned fflush(3) as indicative
of the operation performed. ie. the description above reads the same
as what fflush(3) does to streams.

      "...fflush() forces a write of all user-space buffered data for
the given output or update stream via the  stream's  underlying write
function."

In the multifd case we are sending remaining data from MultiFDPages_t
buffers onto the respective channels IIUC. The
multifd_send_sync_main() function sets the 'p->pending_sync' field and
when it is set miltifd_send_thread() function calls

      ret = qio_channel_write_all(p->c, (void *)p->packet,
                                            p->packet_len, &local_err);

multifd_send_sync_main() also has 'flush_zero_copy', but that only
happens when using --zerocopy option is used -> $ virsh migrate
--zerocopy  ...

> There is no flush on the receive side. The RAM_SAVE_FLAG_MULTIFD_FLUSH
> flag is there to indicate to the destination that at that point in the
> stream the source has done a flush + sync operation and the destination
> should sync it's threads as well.

* The comment around where 'RAM_SAVE_FLAG_MULTIFD_FLUSH' gets written
above, says -> "...trigger remote flush."

* We seem to use terms 'flush' and 'sync' quite freely and
interchangeably. ie. variables (ex: do_local_flush) and constants are
named with _FLUSH and functions and fields are named as _sync_main()
and &p->pending_sync.

        if (do_local_flush) {
            multifd_send/_recv_sync_main();    <= do the 'flush' and
'sync' mean the same thing here?
        }

Even in multifd_ram_flush_and_sync() routine, it is named with _flush_
and eventually multifd_send() sets the '&p->pending_job' variable to
true. There is no field in MultiFDSendParams structure named with
'flush'. It defines 'pending_sync' and 'sem_sync'.

* Such free usage of these terms is bound to create confusion. Because
while reading code the reader may relate flush with fflush(3) and sync
with fsync(2) calls/operations. It will help if we use these terms
more judiciously.

* Coming back to the issue of simplifying multifd threads 'flush or
sync' operation:
   1. I think it can be done separately, outside the scope of this patch series.
   2. Must we tie the flush/sync operations with specific spots? Isn't
there any other way, where we call multifd_*_sync() unconditionally,
without any side-effects? As I see it, we have those conditions,
because of the side-effects.

Thank you.
---
  - Prasad


