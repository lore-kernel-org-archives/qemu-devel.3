Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B56CC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 10:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvZvP-0008Hf-7T; Fri, 21 Mar 2025 06:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tvZvN-0008HD-7n
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tvZvL-0005Fp-2N
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742554100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8QS2K4bdbH/7UaDSAhBGCQIxvyGiZvIGILRO+WO/CA=;
 b=doamEb92rfXWH/O/BFLHaWp83EWtsyd/g0bmRpA8XBvzAZwLFEharU/zo0D6ShveZClUD7
 TzONfol06U7DDBi/vysYc4rZrzzD+VXwxY2EFTWDi2lRn3yheczmrUxZtUGJF+bFxLBWO4
 31wYRWQwlGez5ICwRcf6b9Y7BahiuhU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-NPaQKBGEOh6Mp0cYRT6cfA-1; Fri, 21 Mar 2025 06:48:19 -0400
X-MC-Unique: NPaQKBGEOh6Mp0cYRT6cfA-1
X-Mimecast-MFC-AGG-ID: NPaQKBGEOh6Mp0cYRT6cfA_1742554098
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d22c304adso12693805e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 03:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742554098; x=1743158898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M8QS2K4bdbH/7UaDSAhBGCQIxvyGiZvIGILRO+WO/CA=;
 b=r3afKu5e5wADCfZFopqJfU3ZPlD46yPuZrd07TuGm0fz2U70G/g0CZwWuTFCP/N9Vr
 V9iHRJWpwtySESfw55NIF7U/Gb2y8ahmUdD1lWOCrDz5drOApRDS8lBQ7zuD1yKO8ulw
 QhnCPPiitnqJQQd0oMqwyQ5vaZYhzKPlx9r5g0V/kunV64IdsjcPfUCz7w3CeIo7MwFN
 Fx/8V2AQCCtGF2cRe+alXxM3yA4wRTxfz/NVoeu2FVAcU98UkTeblCnHrXbz/C7es/Kn
 Qb7bD3T2QhDu59nHnagRZl3yCjWTeNDICGXt/ilTY+UR6d/ooh0j7F552iGEAKg0IP3Z
 t+8A==
X-Gm-Message-State: AOJu0YzP0c3IAzgWdP6XsrpMyeW2G3k1x2gLH21LRMA/Qkmv6DhgFVqI
 Apiu8wmmgzxGwaw6AqdF95KMhA2EkeZzaYbukAGuwYLZdC0gKI3gId28cT8Eh5qAgexo7eW6Ghs
 77yAI7PxQW4xaAIvfj22me25E3OIawhnBZbFir3hfJIjvdkyI5yllmXaHn2Zp/nHjo2myNGXsGa
 7bCkkNB4YL7xi+4LgAFma8v/LrKFM=
X-Gm-Gg: ASbGncv9LM5CyzlUjMeykzJVilC4XScjep9+bU1ZefuGMNOB9fMeh0dRPmmyDa7XqVd
 Gs92GEOS2mL3Dh4jovZ39FBZW2bWq2JEbEV0Owy1Kxs0B5AWmwzZdhlzKn+V3H0EvDGEUthMRmn
 M=
X-Received: by 2002:a05:600c:1e8f:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-43d502e4332mr29001425e9.4.1742554097839; 
 Fri, 21 Mar 2025 03:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUAUqwvEAhftSC4CCP/GPPW6LJq4cZOX/mweI1IyXGhmJY9275XzAQ2/9s8P1UC6fcsbXJmd02NuyT0dphAmc=
X-Received: by 2002:a05:600c:1e8f:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-43d502e4332mr29001185e9.4.1742554097344; Fri, 21 Mar 2025
 03:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <CAE8KmOx0KQ7OfbyivQ_256JVRugtJ8ekykxtQw-uz91Uiuv-tg@mail.gmail.com>
 <875xk3bw1i.fsf@suse.de>
In-Reply-To: <875xk3bw1i.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 21 Mar 2025 16:17:59 +0530
X-Gm-Features: AQ5f1JrDZSh6aR4KsV7kdhVSWWjhdTX1TAPZeh0lxrdVB366YWcz5KdJnJSTvQo
Message-ID: <CAE8KmOwHVAnTwUUXVMuGRiLbhELUunVoWQjimcSxS2s8+1VfVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 20 Mar 2025 at 20:15, Fabiano Rosas <farosas@suse.de> wrote:
> Technically both can happen. But that would just be the case of
> file:fdset migration which requires an extra fd for O_DIRECT. So
> "multiple" in the usual sense of "more is better" is only
> fd-per-thread. IOW, using multiple fds is an implementation detail IMO,
> what people really care about is medium saturation, which we can only
> get (with multifd) via parallelization.

* I see. Multifd is essentially multiple threads = thread pool then.

> > Because doing migration via QMP commands is not as
> > straightforward, I wonder who might do that and why.
> >
>
> All of QEMU developers, libvirt developers, cloud software developers,
> kernel developers etc.

* Really? That must be using QMP apis via libvirt/virsh kind of tools
I guess. Otherwise how does one follow above instructions to enable
'multifd' and set number of channels on both source and destination
machines? User has to open QMP shell on two machines and invoke QMP
commands?

> > * So multifd mechanism can be used to transfer non-ram data as well? I
> > thought it's only used for RAM migration. Are device/gpu states etc
> > bits also transferred via multifd threads?
> >
> device state migration with multifd has been merged for 10.0
>
> <rant>
> If it were up to me, we'd have a pool of multifd threads that transmit
> everything migration-related.

* Same my thought: If multifd is to be used for all data, why not use
the existing QEMU thread pool  OR  make it a migration thread pool.
IIRC, there is also some discussion about having a thread pool for
VFIO or GPU state transfer. Having so many different thread pools does
not seem right.

> Unfortunately, that's not so
> straight-forward to implement without rewriting a lot of code, multifd
> requires too much entanglement from the data producer. We're constantly
> dealing with details of data transmission getting in the way of data
> production/consumption (e.g. try to change ram.c to produce multiple
> pages at once and watch everyting explode).

* Ideally there should be separation between what the client is doing
and how migration is working.

* IMO, migration is a mechanism to transfer byte streams from one
machine to another. And while doing so, facilitate writing (data) at
specific addresses/offsets on the destination, not just append bytes
at the tail end. This entails that each individual migration packet
specifies where to write data on the destination. Let's say a
migration stream is a train of packets. Each packet has a header and
data.

     ( [header][...data...] )><><( [header][...data...] )><><(
[header][data] )><>< ... ><><( [header][data] )

Header specifies:
    - Serial number
    - Header length
    - Data length/size (2MB/4MB/8MB etc.)
    - Destination address <- offset where to write migration data, if
it is zero(0) append that data
    - Data type (optional): Whether it is RAM/Device/GPU/CPU state etc.
    - Data iteration number <- version/iteration of the same RAM page
    ...   more variables
    ...   more variables
    - Some reserved bytes
Migration data is:
    - Just a data byte stream <= Data length/size above.

* Such a train of packets is then transferred via 1 thread or 10
threads is an operational change.
* Such a packet is pushed (Precopy) from source to destination  OR
pulled (Postcopy) by destination from the source side is an
operational difference. In Postcopy phase, it could send a message
saying I need the next RAM packet for this offset and RAM module on
the source side provides only relevant data. Again packaging and
transmission is done by the migration module. Similarly the Postcopy
phase could send a message saying I need the next GPU packet, and the
GPU module on the source side would provide relevant data.
* How long such a train of packets is, is also immaterial.
* With such a separation, things like synchronisation of threads is
not connected to the data (RAM/GPU/CPU/etc.) type.
* It may also allow us to apply compression/encryption uniformly
across all channels/threads, irrespective of the data type.
* Since migration is a packet transport mechanism,
creation/modification/destruction of packets could be done by one
entity. Clients (like RAM/GPU/CPU/VFIO etc.) shall only supply 'data'
to be packaged and sent. It shouldn't be like RAM.c writes its own
pakcets as they like, GPU.c writes their own packets as they like,
that does not seem right.

 >> +- A packet which is the final result of all the data aggregation
> >> +  and/or transformation. The packet contains: a *header* with magic and
> >> +  version numbers and flags that inform of special processing needed
> >> +  on the destination; a *payload-specific header* with metadata referent
> >> +  to the packet's data portion, e.g. page counts; and a variable-size
> >> +  *data portion* which contains the actual opaque payload data.

* Thread synchronisation and other such control messages could/should
be a separate packets of its own, to be sent on the main channel.
Thread synchronisation flags could/should not be combined with the
migration data packets above. Control message packets may have _no
data_ to be processed. (just sharing thoughts)

Thank you.
---
  - Prasad


