Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933EAC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 14:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUoDa-0006FH-S9; Fri, 19 Jul 2024 10:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUoDZ-0006Eg-0s
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUoDW-00085G-KB
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721397853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BMeld+8ua+5L+XCMcUa/v1b9mzhwsb+dNksvCBMMBy8=;
 b=FR8MKK5Yu+St2IZpG8RtQu1406quR1cYT19da8+XupbHthcrGy0XIPKvSInvruEODdn+C/
 NBzWG0gDX4a/OoGcKVrHlKBsjbBBa6dQ3MtACs5+r2OPjYvstEy9oTgh9eMz3JQj75/6F9
 TFrb7PUKwXwFFmHjoawZ6+wZar5cUzo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-dEcKpEeaOsCbmI1sR1NT0g-1; Fri, 19 Jul 2024 10:04:09 -0400
X-MC-Unique: dEcKpEeaOsCbmI1sR1NT0g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b7a47a271cso3928336d6.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 07:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721397849; x=1722002649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMeld+8ua+5L+XCMcUa/v1b9mzhwsb+dNksvCBMMBy8=;
 b=BGpuc6m9kf6KN4+Q8qsDwng48Hp6ikNI6z4+soLbr+muRNwvm02bza9jfuRGTurZNG
 8j5kS8mE1mQVkZxdaPm1DCONEwRqB53MgP1S9oRYs747ZdQD+wf3rN8Jv0ZWPmneoaoa
 uUBkqF5H41/Fuf4ttbmcEErIXhdWbDalWEFqMFnPzxyGyfbBpkUe35vFKrkSX71dIlEb
 sahu5jX5fh2OLCLU2gcr0VFZ/bS6548tb39m7uX+HukUqeUL+DZnBBPV6IDGNZAQ0/7X
 x4GD+hBuGoS+M1Xl8KE0yNGw/xGousdJF0FTQlcZtnHB0CcACl2NYuvBFm9MquP0GBy6
 Mi3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU6HWgJo5GPC0ll+1SMGsiKddPr/UmSKXkSwMNHXtQ0H9UhfHqQv9gS49VaCNi6AxAPxrjM9wWds0rLe3ziHZpzYRPKJw=
X-Gm-Message-State: AOJu0YwaGw4NZr0CLMWgilyo7/38KohkOg+DFfwuidUppHF/pSvm7gK7
 CgTDHE8LMW+v6YGH/B0GGXH8jb+vA+V+PNa9ItTzIJsMblJBNmk28EQHzFiLAV9Iy1W/R/+uHxC
 SVCZ30oGmXKwUNh9HXLQNzLzONWkt+tFtd0iGUNsf67iDuZfB2fD9
X-Received: by 2002:a05:6214:3da0:b0:6b5:dd7d:919b with SMTP id
 6a1803df08f44-6b94f015475mr320406d6.4.1721397848713; 
 Fri, 19 Jul 2024 07:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwX0REU7wi15WGRLtjx1k/osPkCkMGLQObVJ9n5t+RlBLedQyJI4PKAjXkaLuo+9rYNudCxw==
X-Received: by 2002:a05:6214:3da0:b0:6b5:dd7d:919b with SMTP id
 6a1803df08f44-6b94f015475mr320126d6.4.1721397848077; 
 Fri, 19 Jul 2024 07:04:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac7bdbbcsm7476106d6.2.2024.07.19.07.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 07:04:07 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:04:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZppyVt0LZanF4lIq@x1n>
References: <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
 <ZpAEIvbNr-ANuASV@x1n> <87jzhi1odn.fsf@suse.de>
 <ZpmFT9O-UN30i1F1@x1n> <87frs61jcr.fsf@suse.de>
 <ZpmOmXS2G3f_65xK@x1n> <87cyna1gd6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyna1gd6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 18, 2024 at 07:32:05PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jul 18, 2024 at 06:27:32PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, Jul 18, 2024 at 04:39:00PM -0300, Fabiano Rosas wrote:
> >> >> v2 is ready, but unfortunately this approach doesn't work. When client A
> >> >> takes the payload, it fills it with it's data, which may include
> >> >> allocating memory. MultiFDPages_t does that for the offset. This means
> >> >> we need a round of free/malloc at every packet sent. For every client
> >> >> and every allocation they decide to do.
> >> >
> >> > Shouldn't be a blocker?  E.g. one option is:
> >> >
> >> >     /* Allocate both the pages + offset[] */
> >> >     MultiFDPages_t *pages = g_malloc0(sizeof(MultiFDPages_t) +
> >> >                                       sizeof(ram_addr_t) * n, 1);
> >> >     pages->allocated = n;
> >> >     pages->offset = &pages[1];
> >> >
> >> > Or.. we can also make offset[] dynamic size, if that looks less tricky:
> >> >
> >> > typedef struct {
> >> >     /* number of used pages */
> >> >     uint32_t num;
> >> >     /* number of normal pages */
> >> >     uint32_t normal_num;
> >> >     /* number of allocated pages */
> >> >     uint32_t allocated;
> >> >     RAMBlock *block;
> >> >     /* offset of each page */
> >> >     ram_addr_t offset[0];
> >> > } MultiFDPages_t;
> >> 
> >> I think you missed the point. If we hold a pointer inside the payload,
> >> we lose the reference when the other client takes the structure and puts
> >> its own data there. So we'll need to alloc/free everytime we send a
> >> packet.
> >
> > For option 1: when the buffer switch happens, MultiFDPages_t will switch as
> > a whole, including its offset[], because its offset[] always belong to this
> > MultiFDPages_t.  So yes, we want to lose that *offset reference together
> > with MultiFDPages_t here, so the offset[] always belongs to one single
> > MultiFDPages_t object for its lifetime.
> 
> MultiFDPages_t is part of MultiFDSendData, it doesn't get allocated
> individually:
> 
> struct MultiFDSendData {
>     MultiFDPayloadType type;
>     union {
>         MultiFDPages_t ram_payload;
>     } u;
> };
> 
> (and even if it did, then we'd lose the pointer to ram_payload anyway -
> or require multiple free/alloc)

IMHO it's the same.

The core idea is we allocate a buffer to put MultiFDSendData which may
contain either Pages_t or DeviceState_t, and the size of the buffer should
be MAX(A, B).

> 
> >
> > For option 2: I meant MultiFDPages_t will have no offset[] pointer anymore,
> > but make it part of the struct (MultiFDPages_t.offset[]).  Logically it's
> > the same as option 1 but maybe slight cleaner.  We just need to make it
> > sized 0 so as to be dynamic in size.
> 
> Seems like an undefined behavior magnet. If I sent this as the first
> version, you'd NACK me right away.
> 
> Besides, it's an unnecessary restriction to impose in the client
> code. And like above, we don't allocate the struct directly, it's part
> of MultiFDSendData, that's an advantage of using the union.
> 
> I think we've reached the point where I'd like to hear more concrete
> reasons for not going with the current proposal, except for the
> simplicity argument you already put. I like the union idea, but OTOH we
> already have a working solution right here.

I think the issue with current proposal is each client will need to
allocate (N+1)*buffer, so more user using it the more buffers we'll need (M
users, then M*(N+1)*buffer).  Currently it seems to me we will have 3 users
at least: RAM, VFIO, and some other VMSD devices TBD in mid-long futures;
the latter two will share the same DeviceState_t.  Maybe vDPA as well at
some point?  Then 4.

I'd agree with this approach only if multifd is flexible enough to not even
know what's the buffers, but it's not the case, and we seem only care about
two:

  if (type==RAM)
     ...
  else
     assert(type==DEVICE);
     ...

In this case I think it's easier we have multifd manage all the buffers
(after all, it knows them well...).  Then the consumption is not
M*(N+1)*buffer, but (M+N)*buffer.

Perhaps push your tree somewhere so we can have a quick look?  I'm totally
lost when you said I'll nack it.. so maybe I didn't really get what you
meant.  Codes may clarify that.

-- 
Peter Xu


