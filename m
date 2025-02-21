Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5339BC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlOee-0000wS-6A; Fri, 21 Feb 2025 03:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tlOec-0000vo-Jg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tlOea-00025U-IE
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740127498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x6VSM8+JsUf9E9TySSg0sT3aFSEpclvLbYuJNE8s92Q=;
 b=BAOtgmXeal9aTpnteaBtc0WDYZjzuFAS4Q7LQ+a4sFgBro02BLvJMdsF41YjNITBIybQ8P
 3uS4d/MVPW/2rrcKJYwyRyO5UUTyjNK84XjbXah3aOsNg6Ji6gnFdRHn1ETjKE4JIOLLMu
 tdvj1IvCzzVjVEqrRv1tIZTHrxc3jOE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-vAI-8WxZMWSIlf9oLF8Naw-1; Fri, 21 Feb 2025 03:44:55 -0500
X-MC-Unique: vAI-8WxZMWSIlf9oLF8Naw-1
X-Mimecast-MFC-AGG-ID: vAI-8WxZMWSIlf9oLF8Naw_1740127494
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4398ed35b10so9137075e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 00:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740127494; x=1740732294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x6VSM8+JsUf9E9TySSg0sT3aFSEpclvLbYuJNE8s92Q=;
 b=QogTDnJodhayg8mvv05dFjEt6hCfDmSYfS7w3SPBQFDiw15uIEq2xhMgTlRhcpqK6G
 easHQD90x5zPKF/4gotXXC00qYZAKN1kTtbsKYzSzTeGEjoopr/a47je9HxFg/Lb0jnm
 uXqH99ux2vBnf9Cp/EjVNHcQoB4b2OHFGL/V7qmPTmEEHp2/LFNqYkkA/ehe2bFQt90f
 961kRnS/9yl6gKk2fzepOj749jSSColDRjnGYOG/IJ/TYPVyJtSCdAY/+IIvazqH2yxF
 nZtD+sa6h2qQpCv6Cyi7Q6RPggBSBiDlYPkr7nCgNU3b0et9tuMub4zU+aLhaGbbITLN
 NPNA==
X-Gm-Message-State: AOJu0YyYNklRHmdFOBXnOH0VFO2iJoDdsSb7AGd0MUUbM8hJ6znX9lWS
 tODa7Lf7Fy7mkdwea9InvwjudsHM/3sxKQ6hYlqjq0xDYsc3kmZQoUoOo/iWEWvN1RzPHIvzxmA
 18GEADzDsu/2SFItD56WvMXCUcufzsEfKyrHN7f5SHSp9cbrFUu4P3+ujfwl5j/gzhb1vQH1wn6
 C2sKHBRaXnr41pskBfhyLx5/VMTOo=
X-Gm-Gg: ASbGncsdJ2KAcy63jaz9nc1bTIqFf9DoXCTgHuZF9FsQ0SbSEogttFshFCBPtBbYpjU
 ndCq2gDh1iV+hXVbZYLRR7m4NJ4vQwB9Li8VoKYEzscMX91mfkQdIQcy27qjwgpksBrDGPbHYs1
 Q=
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id
 5b1f17b1804b1-439b2b06189mr7445945e9.14.1740127494184; 
 Fri, 21 Feb 2025 00:44:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbNqxumVBDN6WkiVH8vErUgnMjKnHoKgU7gmdjnm3AJ5IR99oM5CpzJzsO4yrvLnHiIoy7OZEylmkmiz+8qco=
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id
 5b1f17b1804b1-439b2b06189mr7445805e9.14.1740127493836; Fri, 21 Feb 2025
 00:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com>
 <87y0y4tf5q.fsf@suse.de>
 <CAE8KmOxYE=10+xjMjH5ZhbMmRJHgxJKHj2wH-nB-qiBSHEVh1w@mail.gmail.com>
 <878qq39vu3.fsf@suse.de>
 <CAE8KmOyy=ybDaRFpFr0DTJWScyjCX+99PKHzLibv6zhtUpw8Ng@mail.gmail.com>
 <87r03t97ep.fsf@suse.de>
 <CAE8KmOyzkLS3zvb7a32CUVJuvS-VEkZwSAfJUZwQqT-xiZLnJw@mail.gmail.com>
 <87jz9k91ri.fsf@suse.de>
In-Reply-To: <87jz9k91ri.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 21 Feb 2025 14:14:36 +0530
X-Gm-Features: AWEUYZkh-h85wn0nzU4v9tJ1WnW51ikORb4u0aOZrqIIcIXx4rR2D6cunSFf8ck
Message-ID: <CAE8KmOwrZMRV26vu8aUaR0nF_wDM1jMh5kC3RkCa1Eui_68nOQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Fabiano,

On Thu, 20 Feb 2025 at 19:06, Fabiano Rosas <farosas@suse.de> wrote:
> This is more or less the handshake idea. Or at least it could be
> included in that work.
>
> I have parked the handshake idea for now because I'm not seeing an
> immediate need for it and there are more pressing issues to be dealt
> with first such as bugs and coordinating the new features (and their
> possible outcomings) that IMO need to be looked at first.

* I see, okay.

> I'm not opposed to that idea. When I started working with migration I
> had the impression that was the direction and that we could put every
> workload in a pool of multifd threads. Now, knowing the code better, I'm
> not sure that's feasible. Specially the dependence on a "main" channel
> seems difficult to do away with. It's also somewhat convenient to have a
> maint thread. But we could still attempt to group extra threads, such as
> what we're doing with the new thread pool in the device state series. At
> least thread management could be done entirely in a separate pool, main
> channel and all.
>

* True. To extend the two QEMUs working in tandem OR the handshake
idea further with the 'main' channel, let's say a user invokes
command:

$ virsh migrate --threads 4 --postcopy --postcopy-after-precopy ...

0) Channel = TCP socket connection between two machines.

1) The 'main' channel is the dedicated _control_ channel; And other
channels are dedicated _data_ channels. So with '--threads 4' option,
QEMU creates a total of 5 (main + 4) channels.

        QEMU-A  -> 'main' channel    -> QEMU-B
        QEMU-A ->  'data' channel-1 -> QEMU-B
        QEMU-A ->  'data' channel-2 -> QEMU-B
        QEMU-A ->  'data' channel-3 -> QEMU-B
        QEMU-A ->  'data' channel-4 -> QEMU-B

    * Each channel is used by a thread of its own.

2) All channels are created _before_ the migration starts and stay
till the end of the migration. No asynchronous channels popping up
during migration, like a 'postcopy' channel now.

3) In the beginning source says 'Let's Precopy' to the destination on
the 'main' channel

         QEMU-A  -> main: Let's precopy  -> QEMU-B
         QEMU-A  <- main: Okay              <- QEMU-B

    And migration data flows from QEMU-A  -> to -> QEMU-B  on the
'data' channels.

        QEMU-A ->  'data' -> -> -> QEMU-B
        QEMU-A ->  'data' -> -> -> QEMU-B
        QEMU-A ->  'data' -> -> -> QEMU-B
        QEMU-A ->  'data' -> -> -> QEMU-B

4) When it's time to switch to Postcopy,  source says 'Let's Postcopy'
to the destination on the 'main' channel

        QEMU-A  -> main: Let's postcopy  -> QEMU-B
        QEMU-A  <- main: Okay                <- QEMU-B

    And migration page requests/data use the same 'data' channels.

        QEMU-A <- <- 'request/data'  -> -> QEMU-B
        QEMU-A <- <- 'request/data'  -> -> QEMU-B
        QEMU-A <- <- 'request/data'  -> -> QEMU-B
        QEMU-A <- <- 'request/data'  -> -> QEMU-B

5) This way:
     - 'main' channel could be used to co-ordinate actions of two QEMUs.
     - All data channels may be used during Postcopy too, instead of
one channel now.
     - There may not be race conditions while creating channels.
     - No differentiation of precopy/multifd/postcopy/preempt etc. channels.

(thinking out loud if that sounds workable)

Thank you.
---
  - Prasad


