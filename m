Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181CED43374
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 15:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t94s3-0005qQ-6u; Thu, 07 Nov 2024 10:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t94s0-0005nD-0X
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t94rx-0006NO-RX
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730994984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+qiUT8/RDcGAByQY4ZTsiQuiI5K5w/4LN6Uj2E9ogA=;
 b=V+UfKyr3JoYn90mvqYb5c1xkh+0ox4thutZZNPseACr3C8jtY5P4atQk6ULODlGrU3Jnfu
 2QpdsN+QtXMRv12wHgZpaKisZsU/ORErdq8xATrCbK18a6TEby/NdV9USug2hzuH9Gn0eu
 uUsSQnhywAm+Zq1+GlhNfRlwgeUZtoc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-JhqbQ82FNf-MFlEFIhuzSw-1; Thu, 07 Nov 2024 10:56:20 -0500
X-MC-Unique: JhqbQ82FNf-MFlEFIhuzSw-1
X-Mimecast-MFC-AGG-ID: JhqbQ82FNf-MFlEFIhuzSw
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d3728e52dcso15309366d6.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 07:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730994980; x=1731599780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+qiUT8/RDcGAByQY4ZTsiQuiI5K5w/4LN6Uj2E9ogA=;
 b=RfhAovf6yAD6d0Bb1FusSIvWvh6Ixu7pwpo68UxiplqN/E+LOB23ME7z6nedCAbRXF
 DVtazhAmIOnXGok9Xj9xVqcvB15br6gh9Ez6dO4ofsHJlCq0VDZ3RLjrK9W2tS2ogln7
 /bLYLviq+2xcJOwUCJGz0EaKhPT0muoF2uL0wkzq2DKMLrhPv4nmW5Yh2kTS/15/37sh
 qohIEBNKfUBcJr26BudXerDOohgUTiJh1RwpTgnaVdY4n0keC1RlQeLKtkRrxrZz7t/M
 wRtYvFj+RjegP6VVKEO+skmZXRXWYA/yb+Nyd7aqZEwgDz8wZMaTjHbKpzGLJNwJrSli
 rYCw==
X-Gm-Message-State: AOJu0YyevgravNi/P2jVZvBzTb4RR8fjpu9Z/Oyq8Pfq37CT45eAdjcC
 3WyiuOkM9j4hHItZXgFlSJShuIwZvTBp9jfIaUXaWxOkX4wjTmK1RgnldvWj/RtfqGVRN0Hu6gx
 I7WNGFA63CvoJ450gqmtqDq/Lz/lj449UeqiTcarnlxbjVeTOnfEt
X-Received: by 2002:a05:6214:448f:b0:6c3:5496:3e06 with SMTP id
 6a1803df08f44-6d39cf9cd5dmr5510236d6.10.1730994980364; 
 Thu, 07 Nov 2024 07:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnM3csAY5ojr2XW8wp7XgE0WA6Tsj4z4BaLKTlKqWT8esnpRaRcn2YvdGORhrqu/LAXKEuGw==
X-Received: by 2002:a05:6214:448f:b0:6c3:5496:3e06 with SMTP id
 6a1803df08f44-6d39cf9cd5dmr5509866d6.10.1730994979877; 
 Thu, 07 Nov 2024 07:56:19 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3966303dbsm8721716d6.98.2024.11.07.07.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 07:56:19 -0800 (PST)
Date: Thu, 7 Nov 2024 10:56:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <ZyzjIYEUW5Bomq7v@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <ZyuSjp2rImbm6ByN@x1n>
 <CAE8KmOz9SHFt=TdQXGXADVLp2t-95wSEWjDZ-XaMYzznPpz0zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOz9SHFt=TdQXGXADVLp2t-95wSEWjDZ-XaMYzznPpz0zQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 07, 2024 at 05:22:05PM +0530, Prasad Pandit wrote:
> On Wed, 6 Nov 2024 at 21:30, Peter Xu <peterx@redhat.com> wrote:
> > IIUC we can't simply change it to this.  We can do this with a compat
> > property and we can start sending a magic in the preempt channel, but then
> > the code still needs to keep working with old binaries of QEMU, so in all
> > cases we'll need to keep the old complexity for quite a while.
> 
> * I see...sigh.
> 
> > Handshake, in my mind, will use a totally separate path, then the hope is
> > we'll move to that with more machine types and finally obsolete / remove
> > this path.
> 
> * I need to check how 'separate path' works.

The plan is handshake will only happen on the main channel, and that
includes waiting all the channels to be established.  There, each channel
may need to have its own header, it could be a new handshake header that
whatever migration channel will start to establish, so it's named channels
and dest qemu handshake logic can "understand" which channel is which, and
properly assign those channels in the handshake.c logic, for example.

On src, now we kick off migration by migration_should_start_incoming()
returns true, only relying on "whether qemu have all the channels ready".
The handshake code can do more, so it checks more, then after all handshake
ready it can directly invoke migration_incoming_process() in the separate
path, to which stage it also needs to guarantee channel establishment.

We'll need to keep this path though for "if (!migrate_handshake())". 

> 
> > But note again that I still think your goal of enabling multifd + postcopy
> > may not require that new flag yet, simply because after 7.2 qemu will
> > connect preempt channel later than the main channel.  I think logically
> > QEMU can identify which channel is which: the preempt channel must be
> > established in this case after both main thread and multifd threads.
> 
> * You mean, instead of relying on magic bytes, we check if both 'main
> channel' and 'multifd channels' already exist, then the incoming
> connection is assumed to be for the 'postcopy preempt' channel?

Exactly.

So we keep the fact that we should only peek() if multifd is enabled at
least.  Then in your case even postcopy is also enabled, it won't connect
the preempt channel until very late (entry of postcopy_start()), and it'll
only connect if it receives a PONG first (migration_wait_main_channel()).
That means dest has all multifd+main channels ready otherwise no PONG will
generate.  This makes sure we'll never try to peek() on preempt channel
(which may hang) as long as it's always the latest.

I think 7.1 will keep working even if it behaves differently (it connects
preempt channel earlier, see preempt_pre_7_2), because the 1st requirement
in the new code (and also, in the old code) you will also only peek() if
multifd enabled first, while multifd cannot be enabled before with
postcopy/preempt or it was already a mess, so we can imagine old users only
enable either multifd or postcopy.

Thanks,

-- 
Peter Xu


