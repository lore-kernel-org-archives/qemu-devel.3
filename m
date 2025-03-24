Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3893C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 11:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twflH-00059T-LU; Mon, 24 Mar 2025 07:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1twflG-000599-Ak
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 07:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1twflE-0005qQ-5c
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 07:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742814866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qBDGSLfeRp8NOuPa+ChfE3PkHcB2AZvg1fetL+05X6A=;
 b=SzFpqFgFFneZZdcXlVhHI8L18n1crmrpIx5eIzlmSVfrb2Tj/DiiOsG5MlEgyAyM9kSru5
 2X8SYvx18yHwtw84wzdnqacm7rSL8Wd57II2MxrqSH2j96XxpgoD0oHLUOxwPml9Ljj0u/
 m8cxXxfiMRv3+QR4ZAUdFnAXqKrUk34=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-3t74ZT97PR2k-tR_Z2wDOA-1; Mon, 24 Mar 2025 07:14:23 -0400
X-MC-Unique: 3t74ZT97PR2k-tR_Z2wDOA-1
X-Mimecast-MFC-AGG-ID: 3t74ZT97PR2k-tR_Z2wDOA_1742814862
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d01024089so30887365e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 04:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742814862; x=1743419662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBDGSLfeRp8NOuPa+ChfE3PkHcB2AZvg1fetL+05X6A=;
 b=oE2VueganBq6kpPntY/E9mPeNvsrT0Mj8BwQO3eNT730dFELAM6vwP+5RVZu0vnHB2
 tIbaYsLJO8iEDcByuQpmlf9QOZisfuLxXsm/T9PU1nawAx2bNcVb0KPZep+ZJdrkwViK
 QT4gkvelcadL2obOxnJYkk7dBsZpyQaVJScJiGZMZfbpa2N+tmIewuWpP154UXUYdcLR
 F6ezddHekrFZxqexBly5JcjBK9W65MPcTWiVA22n/12ySBffUTqFJJWqV9L6QH+Ffhz4
 RK4r5Frc7SOd6VyP3YcFHhcSuTD52ldD3r59OkBEMdPS4smuD8wJWzQfL2yuc7my73nZ
 neIw==
X-Gm-Message-State: AOJu0YxXHZTmXuPU2rwadfcNAuoAcWZGG8pZlX/NyzL5vx9kahG94uv0
 CgZTimFf7aVIC3snqB0yWaSt7Vv16tKigYxNG28N+d15nLZfe0V3aG2x4M5FgIWr7vyR9GELenL
 BcwzJPmx8HYwZR/NZZak+AofAS/V1QLm4MLXPRDCwGIg+hx3mTbia2SBAYgUT/NW7rHp8N6uRuA
 5ZCGaGDJZ9VuZOF1I8AV2WHCTOF3A=
X-Gm-Gg: ASbGnctiaMyrOxac3xjspm+TK/CUmdjzlgDES3HDrBAHzNVZkTlhO8OlOo8AcZsAYwi
 ER3DF+5t3j9xkrjGl8NdkWwA2k+chHoHlkNXmiw7zxxKAFZoi/yfMwtrPAeQS53pcPu6J1Knsxg
 ==
X-Received: by 2002:a05:600c:4e91:b0:43c:fffc:7855 with SMTP id
 5b1f17b1804b1-43d50a0dae9mr109930975e9.15.1742814862101; 
 Mon, 24 Mar 2025 04:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoZDz0q3aC5h+X5bUfp1tha/Pi2K7AoK9Wf/7dbw4VMYud7eCVH9iMDVT5eUdmLykZCDYglcoav/7EUy4mNlI=
X-Received: by 2002:a05:600c:4e91:b0:43c:fffc:7855 with SMTP id
 5b1f17b1804b1-43d50a0dae9mr109930665e9.15.1742814861656; Mon, 24 Mar 2025
 04:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <CAE8KmOx0KQ7OfbyivQ_256JVRugtJ8ekykxtQw-uz91Uiuv-tg@mail.gmail.com>
 <875xk3bw1i.fsf@suse.de>
 <CAE8KmOwHVAnTwUUXVMuGRiLbhELUunVoWQjimcSxS2s8+1VfVg@mail.gmail.com>
 <87wmcia3an.fsf@suse.de>
In-Reply-To: <87wmcia3an.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 24 Mar 2025 16:44:03 +0530
X-Gm-Features: AQ5f1JrftF65oJipGQXnIbsN6KyWBJvrJkOFJ-fkAt4mz79oVUSay3wXe6pF_bc
Message-ID: <CAE8KmOwqhats07V8YWrg63e6vToB6Y8x4zeG1uj+5ya=qUdu3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi,

On Fri, 21 Mar 2025 at 19:34, Fabiano Rosas <farosas@suse.de> wrote:
> Well, I can't speak for everyone, of course, but generally the less
> layers on top of the object of your work the better.

* Yes, true.

> There are several ways of accessing QMP, some examples I have lying
> around:
>
> ==
>   $QEMU ... -qmp unix:${SRC_SOCK},server,wait=off
>
>   echo "
>        { 'execute': 'qmp_capabilities' }
>        { 'execute': 'migrate-set-capabilities','arguments':{ 'capabilities':[ \
>        { 'capability': 'mapped-ram', 'state': true }, \
>        { 'capability': 'multifd', 'state': true } \
>        ] } }
>        { 'execute': 'migrate-set-parameters','arguments':{ 'multifd-channels': 8 } }
>        { 'execute': 'migrate-set-parameters','arguments':{ 'max-bandwidth': 0 } }
>        { 'execute': 'migrate-set-parameters','arguments':{ 'direct-io': true } }
>        { 'execute': 'migrate${incoming}','arguments':{ 'uri': 'file:$MIGFILE' } }
>        " | nc -NU $SRC_SOCK
> ==
> (echo "migrate_set_capability x-ignore-shared on"; echo
> "migrate_set_capability validate-uuid on"; echo "migrate
> exec:cat>migfile-s390x"; echo "quit") | ./qemu-system-s390x -bios
> /tmp/migration-test-16K1Z2/bootsect -monitor stdio
> ==
> $QEMU ... -qmp unix:${DST_SOCK},server,wait=off
> ./qemu/scripts/qmp/qmp-shell $DST_SOCK
> ==
> $QEMU ...
> C-a c
> (qemu) info migrate

* Interesting. Initially I tried enabling multifd on two hosts and
setting multifd channels via QMP, but then quickly moved to virsh(1)
for its convenience.

> I think we all agree that having different sets of threads managed in
> different ways, is not ideal.

* Yes.

> The thing with multifd is that it's very
> important to keep the performance and constraints of ram migration. If
> we manage to achieve that with some generic thread pool, that's
> great. But it's an exploration work that will have to be done.

* Yes.

> >> Unfortunately, that's not so
> >> straight-forward to implement without rewriting a lot of code, multifd
> >> requires too much entanglement from the data producer. We're constantly
> >> dealing with details of data transmission getting in the way of data
> >> production/consumption (e.g. try to change ram.c to produce multiple
> >> pages at once and watch everyting explode).

* Hmmn, I think that's where a clear separation between migration and
client could help.

> But then there's stuff like mapped-ram which wants its data free of any
> metadata because it mirrors the RAM layout in the migration file.

* I'm not sure how it works now OR why it works that way. But shall
have a look at it.

> I generally like the idea of having the size of the header/data
> specified in the header itself. It does seem like it would allow for
> better extensibility over time. I spent a lot of time looking at those
> "unused" bytes in MultiFDPacket_t trying to figure out a way of
> embedding the size information in a backward-compatible way. We ended up
> going with Maciej's idea of isolating the common parts of the header in
> the MultiFDPacketHdr_t and having each data type define it's own
> specific sub-header.
>
> I don't know how this looks like in terms of type-safety and how we'd
> keep compatibility (two separate issues) because a variable-size header
> needs to end up in a well-defined structure at some point. It's
> generally more difficult to maintain code that simply takes a buffer and
> pokes at random offsets in there.

* I'm not sure if the header size would vary as much.

> This is all in the end client-centric, which means it is "data" from the
> migration perspective. So the question I put earlier still remains, what
> determines the kind of data that goes in the header and the kind of data
> that goes in the data part of the packet? It seems we cannot escape from
> having the client bring it's own header format.

* Yes. Actually that begs the question - Why do we need the migration
and client headers? The answer might differ based on how we look at
things.

Guest State
     |
     +---pcie-root-ports[0..15] -> [0...2GB]
     |
     +---Timer -> [0...1MB]
     |
     +---Audio -> [0...1MB]
     |
     +---Block -> [0...2GB]
     |
     +---RAM -> [0...128GB]
     |
     +---DirtyBitmap -> [0...4GB]
     |
     +---GPU -> [0...128GB]
     |
     +---CPUs[0...31] -> [0...8GB]
     ...
     |
     + (above numbers are for example only)

     [Host-1: Guest State]    <== [Migration] ==>    [Host-2: Guest State]

* Migration should create this same 'Guest State'  tree on the
destination Host-2 as:
     0. Whole guest state (vmstate) is a list of different nodes with
their own state as above.
     1. Migration core on the source side would iterate over these
nodes to call the respective  *_read() function to read their 'state'.
     2. Migration core would transmit the read 'state'  (as 2MB/4MB
data blocks) to the destination.
     3. On the destination side - Migration core needs to know where
to store/write/deliver the received 2MB/4MB data blocks.
          - This is where the migration header would help, to identify
which *_write() function to call.
     4. The respective *_write() function would then write (or
overwrite) the received block at the specified 'offset' within its
state.

* Let's say 'Migration Core' is similar to the TCP layer. Irrespective
of the application protocol (ftp/http/ssh/ncat(1)) TCP behaves the
same. TCP layer identifies where to deliver received data by its port
and connection numbers. TCP layer does not care which program is
running at a given port. Similarly 'Migration core' could read data
from Host-1 and write/deliver it on the Host-2, irrespective of
whether it is a RAM or GPU or any other state block.

* To answer the question, what goes in the header part: is the minimum
information required to identify where to write/deliver the data
block. As with application protocols, that information could be
embedded in the data block itself as well. In which case migration
header may not be required OR it may store bits related to the threads
OR bandwidth control OR accounting etc. depending on their purpose.

* Migration core could:
    - Create/destroy threads to transmit data
    - Apply compression/decompression on the data
    - Apply encryption/decryption on the data
    - Apply bandwidth control/limits across all threads while transmitting data

> Right, so we'd need an extra abstraction layer with a well defined
> interface to convert a raw packet into something that's useful for the
> clients. The vmstate macros actually do that work kind of well. A device
> emulation code does not need to care (too much) about how migration
> works as long as the vmstate is written properly.

* Yes.

Thank you.
---
  - Prasad


