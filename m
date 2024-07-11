Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E601C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 20:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS0OB-0005ge-8Z; Thu, 11 Jul 2024 16:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sS0O9-0005fh-LK
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 16:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sS0O7-00070j-7b
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 16:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720729652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=01koe63NOESbMKNmcD3GJ8d3Q4rIdMp2I0steVZkUCw=;
 b=aZhnKsyh8htBtbHjNis1/UrQ2nI93pMbK+qiF3xbkFbShp1pNRdGpqKhVypheosZ3zRLfA
 z4ePPIT+cydQDK43Y7IKCnu1R42Mh4UNKmh4InpfZfesxSXU5qA0gADR+pRIDk3mMAX7o6
 Jg/q0KHpnxbglXDThm2kpD+NYcl6H3g=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-JfXEn4nyOjK8svWUsR_d3w-1; Thu, 11 Jul 2024 16:27:31 -0400
X-MC-Unique: JfXEn4nyOjK8svWUsR_d3w-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e03a7a44cf1so381625276.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 13:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720729650; x=1721334450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01koe63NOESbMKNmcD3GJ8d3Q4rIdMp2I0steVZkUCw=;
 b=jqCKv8+S27aOXPnj21YcaG3eWp8BTsYrBPHqE3e+H/7N2uxA8SHR9flqrFt1Hf0H9F
 a77AjXeOsyLzSWJe1Gs1aexJNIt/st1xayjgMocn4Fur9+3Bjam+jc6NudA4sKTa6unH
 hxeskecsSAnP02FaMUaOe6d09uH5lX8Yt71XllBxAEtVSMzckjQ/NVAsra7x3eUVEKrv
 8znxp+WIqM+mFRUpNYieNgVBR6jq7RoNTZgSVgxz+GOuNDE+sFs0y+6VBiQc/IueB24y
 IkL2QXm0S1rCucmZwMYj66P0uC0qQLrpywdmH6Ti+xQgLF/FVv39LaXO0LChJDkZRZ3g
 Fcig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlghs4o1DkDOMV5/fHYVQFGN38Y2bAJ01UPGZdfCQued8AiTsAtsGPmlrvPBcIvTWBcC7ToAv9tYVjSjh/HMQ2z8qNdNg=
X-Gm-Message-State: AOJu0YwW1adDeiELZztO0n6DQE9BqUohM1cMcCBNqfKDMnVWv0Bf+kFN
 r06zFQ/+Q1ymSCBx+6HbuUWTZ35FYo8QDrV1Pti+zRhRqbP2dwWdQQI/5JfC96uK7yZaEl0u/kg
 YdNE7SsHI0p1ZdC7CvSpAuTL2NbJVn+0XcNHYC/TyUdQCnLrxrdwL
X-Received: by 2002:a81:9212:0:b0:630:8881:1508 with SMTP id
 00721157ae682-65ca82332d8mr29177367b3.1.1720729650329; 
 Thu, 11 Jul 2024 13:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Ki33amIHwaLboeH/4hqnV90Vi+PP0sg36m1ZMmH7trT7vIHLSlYgYSNOtnGrHukEc1LeWg==
X-Received: by 2002:a81:9212:0:b0:630:8881:1508 with SMTP id
 00721157ae682-65ca82332d8mr29177277b3.1.1720729649936; 
 Thu, 11 Jul 2024 13:27:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f1902924asm327827585a.69.2024.07.11.13.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 13:27:29 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:27:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZpBAL3U6G46OBGEN@x1n>
References: <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
 <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
 <ZpAEIvbNr-ANuASV@x1n> <87bk33en41.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bk33en41.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 11, 2024 at 04:37:34PM -0300, Fabiano Rosas wrote:

[...]

> We also don't flush the iov at once, so f->buf seems redundant to
> me. But of course, if we touch any of that we must ensure we're not
> dropping any major optimization.

Yes some tests over that would be more persuasive when it comes.

Per my limited experience in the past few years: memcpy on chips nowadays
is pretty cheap.  You'll see very soon one more example of that when you
start to look at the qatzip series: that series decided to do one more
memcpy for all guest pages, to make it a larger chunk of buffer instead of
submitting the compression tasks in 4k chunks (while I thought 4k wasn't
too small itself).

That may be more involved so may not be a great example (e.g. the
compression algo can be special in this case where it just likes larger
buffers), but it's not uncommon that I see people trade things with memcpy,
especially small buffers.

[...]

> Any piece of code that fills an iov with data is prone to be able to
> send that data through multifd. From this perspective, multifd is just a
> way to give work to an iochannel. We don't *need* to use it, but it
> might be simple enough to the point that the benefit of ditching
> QEMUFile can be reached without too much rework.
> 
> Say we provision multifd threads early and leave them waiting for any
> part of the migration code to send some data. We could have n-1 threads
> idle waiting for the bulk of the data and use a single thread for any
> early traffic that does not need to be parallel.
> 
> I'm not suggesting we do any of this right away or even that this is the
> correct way to go, I'm just letting you know some of my ideas and why I
> think ram + device state might not be the only data we put through
> multifd.

We can wait and see whether that can be of any use in the future, even if
so, we still have chance to add more types into the union, I think.  But
again, I don't expect.

My gut feeling: we shouldn't bother putting any (1) non-huge-chunk, or (2)
non-IO, data onto multifd.  Again, I would ask "why not the main channel",
otherwise.

[...]

> Just to be clear, do you want a thread-pool to replace multifd? Or would
> that be only used for concurrency on the producer side?

Not replace multifd.  It's just that I was imagining multifd threads only
manage IO stuff, nothing else.

I was indeed thinking whether we can reuse multifd threads, but then I
found there's risk mangling these two concepts, as: when we do more than IO
in multifd threads (e.g., talking to VFIO kernel fetching data which can
block), we have risk of blocking IO even if we can push more so the NICs
can be idle again.  There's also the complexity where the job fetches data
from VFIO kernel and want to enqueue again, it means an multifd task can
enqueue to itself, and circular enqueue can be challenging: imagine 8
concurrent tasks (with a total of 8 multifd threads) trying to enqueue at
the same time; they hunger themselves to death.  Things like that.  Then I
figured the rest jobs are really fn(void*) type of things; they should
deserve their own pool of threads.

So the VFIO threads (used to be per-device) becomes migration worker
threads, we need them for both src/dst: on dst there's still pending work
to apply the continuous VFIO data back to the kernel driver, and that can't
be done by multifd thread too due to similar same reason.  Then those dest
side worker threads can also do load() not only for VFIO but also other
device states if we can add more.

So to summary, we'll have:

  - 1 main thread (send / recv)
  - N multifd threads (IOs only)
  - M worker threads (jobs only)

Of course, postcopy not involved..  How's that sound?

-- 
Peter Xu


