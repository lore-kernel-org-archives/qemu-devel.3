Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190DDD37E39
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 14:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2BA-0003jv-FO; Wed, 14 Jan 2026 09:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2B6-0003eF-OH
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 09:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2B4-0003lY-0R
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 09:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768402131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuHWBrIE+N4lpLy6KIiPAgxtjH7yjjBVzntq36vTn/M=;
 b=ALHJLfEAQQx/19i75tsHLPb8gWx6qIuWMMF45oebc5VtdcwE8p/S7IJ6gfwSzrf8fQbxi7
 2myrD1ICvdFzHLPq9mTDhvw5ecfcgMJkVTEeMWfEQnis/aKO4tc8dBNYX1pgTtLiEiBri0
 cqsyqZnJlbhht8WdXzBFcy58VpGBAUg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-Ifb-0ko3O3-7LFx5K6vxfA-1; Wed, 14 Jan 2026 09:48:50 -0500
X-MC-Unique: Ifb-0ko3O3-7LFx5K6vxfA-1
X-Mimecast-MFC-AGG-ID: Ifb-0ko3O3-7LFx5K6vxfA_1768402129
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8887c0d3074so232789696d6.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 06:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768402129; x=1769006929; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MuHWBrIE+N4lpLy6KIiPAgxtjH7yjjBVzntq36vTn/M=;
 b=NJmM+RL7oe0Mb5/431RD74kuMoLILeTLBMjTWtDacnU/w2l2VjEGPUqyi8rom90shV
 TjCnMIaenKp37ZbnbaO0jm1jwMyd4ZOGDl2wMnOa5+ax6nSO01KArs1KnCry13t+BKF9
 U90ikSWfCHZUut1gDG8/pqdNuopqfTcN3FDfJFpF2+ju5ajaZUvM0bTXbGkiCrTBJQoy
 /uQyFGq1Iodp75q86dhfkjYWLQpb1rh5JDZyVm/f9GHLTomlfeXJJdabKNDsqXy4Lnuw
 msd3LcQVOFAJMTy8B4vL7lYRQtV20fZIMBaD0Y1PQC2vST2GkhHYgyzmur+zIrBkKsmQ
 rOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768402129; x=1769006929;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MuHWBrIE+N4lpLy6KIiPAgxtjH7yjjBVzntq36vTn/M=;
 b=GwIXJ8zdRkwaGIFNtAnmU/M71+AfziWcVTnsQVugiDJQ9OniS24nhf+rmoCWxZoRgH
 MeulaX2qoPxyIwy1W+UbyVEj4/n2WLmIOXYYkcFeL0lN7GYdYZ2SxBBGtAqNVHEZLu+T
 BFocGRU3zyRqGpUYqMWAVlRrsorMqbAtM+eUZ3iBQqg2uMf6rv684vRdq25/Q7KXUYZr
 Vs+3ND3hH6XMk7u2uaYtZ6SvVs0eZdDgQCE/nJxu2puYO8nJXc+3JFb1XIHgf4/05B4B
 i5reDL1O9gLDjc4uiRY+md3PkkmDcMsplXsPLf8RLtMny04pXuWk8Gq/3QBZBx2vcBb6
 ta/g==
X-Gm-Message-State: AOJu0YyONi/b7qe7OpZJD9bC1turSXVwe/pf6Q082K5vqHyb53arSHWa
 Iz4BpbBin7SpMSujgnkfBx8KGj9jZUHxdz9SMUzcetBvgfX9fIPg3s7evuVne4POHeX/gyZ5R6y
 7r540f3abpXHTFXt+i/vVbXQKlohp6rKaR9J5kCCWxyBosK7XcRfRyEMM
X-Gm-Gg: AY/fxX5gIxlyLdUDWFpSMnFF2VXNdX2bY4SbQv+HBTdZSxturnL9BOuxomvc3QwCY1N
 f+8moefGx/HSpMfksYksC9q/CRDcNO+gYRpJbgzY10EVDUJZaUzWv2BJrnc8aIxnEahP4yxeo3h
 wlYtlNuJZ6A1GA3n/jXfT081kE5JhzYOyqZmt/FyUWFLv8OPCrFawY0VcBDq3GWQl3JmsDQyeNw
 Z0vu+vXz1Bq6w0vZ1BGwUOxnHGQBc/8N89Rgk6TRy612wvSSTU+8MUY+kVE/GErkMS/ZEGab5L8
 +kTCUqtaqVsyI8ai4amiEmYa32YmIB2dL69Hi/zDfOT0Hb1hQfYf0pKJU4nN78FvvBnAMbyb+1w
 LZ+w=
X-Received: by 2002:a05:6214:508e:b0:880:38ba:a4d9 with SMTP id
 6a1803df08f44-8927445deb6mr34549106d6.67.1768402129192; 
 Wed, 14 Jan 2026 06:48:49 -0800 (PST)
X-Received: by 2002:a05:6214:508e:b0:880:38ba:a4d9 with SMTP id
 6a1803df08f44-8927445deb6mr34548606d6.67.1768402128429; 
 Wed, 14 Jan 2026 06:48:48 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890772682besm178620686d6.50.2026.01.14.06.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:48:48 -0800 (PST)
Date: Wed, 14 Jan 2026 09:48:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aWesz4NEj0gCiU3D@x1.local>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <aWZk7udMufaXPw-E@x1.local> <3e46b0-69676d00-4d-1a5e27c0@252361837>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e46b0-69676d00-4d-1a5e27c0@252361837>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jan 14, 2026 at 11:16:52AM +0100, Marco Cavenati wrote:
> Hi Peter,

Hi, Marco,

> 
> This is great to hear! I’m happy you’re taking the time to propose and
> mentor this. I’m definitely interested in seeing what comes out of it,
> thanks for putting me in the loop.
> 
> Regarding your proposed Fast Snapshot Load, it’s certainly more widely
> applicable and doesn’t require new QMP commands or extensive configurations
> (beyond mapped-ram), compared to what I had in mind. I think it will be
> beneficial for our use case regardless.
> 
> I’d still be interested in trying to improve it further using dirty
> tracking at some point, to ignore pages that haven’t been written between
> two loadvm of the same snapshot. This would probably apply only to legacy
> snapshot though, as file migration expects a clean QEMU process.

Logically, maybe we don't need to forbid migrate_incoming to only work with
a clean QEMU, because internally it's the same to snapshot load.  We'll
need some special care on zero pages but I don't see a major blocker yet.

Said that, IMHO for your use case I still wonder if the shmem idea would
still be worth exploring, or if you have explored but maybe found some high
overhead on booting QEMU every time?  That's what I mentioned here:

https://lore.kernel.org/all/aB4rhlVGCSk7IwoE@x1.local/

I wished that would work out already, or maybe you've tried it and it was
too slow for you.

Your use case is indeed special, if the dirtied pages are normally not
much, the most efficient way to do this is only record the pages changed
from the snapshot and rollback only those pages, plus all device states.

That's not a traditional "snapshot" concept, more like a "checkpoint" and
"restore", where now in migration we have CPR taking that term already..

  https://www.qemu.org/docs/master/devel/migration/CPR.html

But your case is slightly different from functionality, so that it will
happen completely within a single QEMU instance.

So far, it sounds like a new QMP function v.s. snapshot save/load or
"migrate" / "migrate_incoming" to me, because it shouldn't need to record a
VM image, but VM diff (for rollback only).  The bitmap you need here will
also be attached to the VM diff (again, not VM image, because a rollback
doesn't require a full image).

Not sure if that's what you want, though.  Anyway, IMHO anything like that
need to be justified first with above shmem idea not performing as well in
the first place.

> 
> I’m not sure if I’m still eligible for GSoC; otherwise, I would have
> applied myself :)

I'm not sure how this will work out yet.. if there'll be a student working
on it I'll make sure anything to be posted to have you in the loop.

Also, if it will work out, I'd expect we'll set the goal for the student to
start with the very simple, e.g. no multifd support and maybe starting with
one type of mem (anonymous?), we'll see.  There might be gaps to what may
start to help in your use case too.

Anyway, feel free to jump in anytime to share your thoughts.

Thanks,

> 
> Best,
> Marco
> 
> (removing people from CC to reduce noise)
> 
> On Tuesday, January 13, 2026 16:29 CET, Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Jan 05, 2026 at 04:47:22PM -0500, Stefan Hajnoczi wrote:
> > > Dear QEMU and KVM communities,
> > > QEMU will apply for the Google Summer of Code internship
> > > program again this year. Regular contributors can submit project
> > > ideas that they'd like to mentor by replying to this email by
> > > January 30th.
> > 
> > There's one idea from migration side that should be self-contained, please
> > evaluate if this suites for the application.
> > 
> > I copied Marco who might be interested on such project too at least from an
> > user perspective on fuzzing [1].
> > 
> > [1] https://lore.kernel.org/all/193e5a-681dfa80-3af-701c0f80@227192887/
> > 
> > Thanks,
> > 
> > === Fast Snapshot Load ===
> > 
> > '''Summary:''' Fast loadvm process based on postcopy approach
> > 
> > We have two common ways to load snapshots: (1) QMP "snapshot-load", or QMP
> > "migrate_incoming" with a "file:" URI. The idea to be discussed here should
> > apply to either form of loadvm, however here we will focus on "file:"
> > migration only, because it should be the modern and suggested way of using
> > snapshots nowadays.
> > 
> > Load snapshot currently requires all VM data (RAM states and the rest
> > device states) to be loaded into the QEMU instance before VM starts.
> > 
> > It is not required, though, to load guest memory to start the VM. For
> > example, in a postcopy live migration process, QEMU uses userfaultfd to
> > allow VM run without all of the guest memory migrated. A similar technique
> > can also be used in a loadvm process to make loadvm very fast, starting the
> > VM almost immediately right after the loadvm command.
> > 
> > The idea is simple: we can start the VM right after loading device states
> > (but without loading the guest memory), then QEMU can start the VM. In the
> > background, the loadvm process should keep loading all the VM data in an
> > atomically way. Meanwhile, the vCPUs may from time to time access a missing
> > guest page. QEMU needs to trap these accesses with userfaultfd, and resolve
> > the page faults.
> > 
> > After loading all the RAM state, the whole loadvm procedure is completed.
> > 
> > This feature needs to depend on mapped-ram feature, which allows offsetting
> > into the snapshots to find whatever page being asked by the guest vCPUs at
> > any point in time.
> > 
> > This feature may not be very help in VM suspend / resume use cases, because
> > in those cases the VM was down previously, normally it's fine waiting for
> > the VM to be fully loaded. However, it might be useful in some other cases
> > (like, frequently loading snapshots).
> > 
> > '''Links:'''
> > * https://wiki.qemu.org/ToDo/LiveMigration#Fast_load_snapshot
> > 
> > '''Details:'''
> > * Skill level: advanced
> > * Language: C
> > * Mentor: Peter Xu <peterx@redhat.com>, peterx (on #qemu IRC)
> > 
> > -- 
> > Peter Xu
> >
> 

-- 
Peter Xu


