Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB93C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrsd-0005r4-6g; Fri, 19 Jul 2024 13:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUrsb-0005qF-Rh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 13:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUrsY-0000jb-Me
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 13:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721411928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IMdkuy4ymfEIoPeH32shOBIa6CbGIFrj+bHzv0KyIWI=;
 b=aArfGwyIhX88C2BTJF3B6Oin0335jDONEweXVCK0P/c3BrpBfQRxde2L0il2tWQ4tV4CmY
 jWxczyFlPIDxSKa4D8i3iqVZPFgOqsP4IOZCp1G8WPfg/nZwxMK8gKj7lRbIuM2WTYKf6j
 UrPvwIksW0NRTNH1kudlM2Br32MeLc4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-Jqap6cR7OsyV7cIQPAvojA-1; Fri, 19 Jul 2024 13:58:47 -0400
X-MC-Unique: Jqap6cR7OsyV7cIQPAvojA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-8031d74eb5aso48204939f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 10:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721411927; x=1722016727;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMdkuy4ymfEIoPeH32shOBIa6CbGIFrj+bHzv0KyIWI=;
 b=Kf94rZihcbrCilpNg/ezV0J4XU1or2nanEd1bpXJbfxRcvTRBd0duqahEFYfCiTV3A
 7m4braaBako+Z1gpahw9LQquDdcsYnf0YaSiQGo2VD7GhDjLJMKEk10kRg2eeIprmk+J
 99tu+o3TQhqny8dYkGJ835HFRgwQunNLX2KMwprIePbq+EbKnWQLCjYBvc3d09Kq2Nez
 2HiQDtQLO/UVop9p1bX9SFXNQnQn3cxnPNaB+8ayZFgvTL0LOiAkc4153OD7Ji6lJVF/
 lq+s8reVRfzhG2uNt3sX4ka6VETd4hb4o9sTvmJIKeH9JKBTVvYLZ3E4rNmq+vn0cIRf
 KYmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjtgfl4BrGxBMdLFHnvzOyhjE3knLPJsPYjcF1YDmsHldA+RcBIjpRsRyYoW+fzU6+8cdhLliqz1BUU2l03IiIGAnOaaw=
X-Gm-Message-State: AOJu0YwQ/bHL8nNocElMvE3kxKs6omoomSrQp8TNCPFW/qnJYxAWAD7p
 I+bSm31BwwjwyB0Q9qgVtmlbW1rw0N2v0i/AXhRLOujR6C9ZPzbSEukmN2Gw5cRBZqg2VR56VC6
 0kl40xRLeZYPsuW6XjXaK6eu/iVKQA5u7tiZHObsi8dLdJCe+dZqM
X-Received: by 2002:a5e:df4c:0:b0:80a:4582:ceca with SMTP id
 ca18e2360f4ac-81aa744afc4mr45852739f.3.1721411926656; 
 Fri, 19 Jul 2024 10:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlMqVdsaZny8m0QgxTJd4BfckDhATIgGHJFW5sU3nzgtKdzqPdJ57SjuVYz3VBA5+RIgjgyg==
X-Received: by 2002:a5e:df4c:0:b0:80a:4582:ceca with SMTP id
 ca18e2360f4ac-81aa744afc4mr45850839f.3.1721411926120; 
 Fri, 19 Jul 2024 10:58:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c234405cf7sm406894173.171.2024.07.19.10.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 10:58:45 -0700 (PDT)
Date: Fri, 19 Jul 2024 13:58:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZpqpVDnVROeHg9Bn@x1n>
References: <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
 <ZpAEIvbNr-ANuASV@x1n> <87jzhi1odn.fsf@suse.de>
 <ZpmFT9O-UN30i1F1@x1n> <87frs61jcr.fsf@suse.de>
 <ZpmOmXS2G3f_65xK@x1n> <87cyna1gd6.fsf@suse.de>
 <ZppyVt0LZanF4lIq@x1n> <875xt11fw2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xt11fw2.fsf@suse.de>
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

On Fri, Jul 19, 2024 at 01:54:37PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jul 18, 2024 at 07:32:05PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, Jul 18, 2024 at 06:27:32PM -0300, Fabiano Rosas wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > On Thu, Jul 18, 2024 at 04:39:00PM -0300, Fabiano Rosas wrote:
> >> >> >> v2 is ready, but unfortunately this approach doesn't work. When client A
> >> >> >> takes the payload, it fills it with it's data, which may include
> >> >> >> allocating memory. MultiFDPages_t does that for the offset. This means
> >> >> >> we need a round of free/malloc at every packet sent. For every client
> >> >> >> and every allocation they decide to do.
> >> >> >
> >> >> > Shouldn't be a blocker?  E.g. one option is:
> >> >> >
> >> >> >     /* Allocate both the pages + offset[] */
> >> >> >     MultiFDPages_t *pages = g_malloc0(sizeof(MultiFDPages_t) +
> >> >> >                                       sizeof(ram_addr_t) * n, 1);
> >> >> >     pages->allocated = n;
> >> >> >     pages->offset = &pages[1];
> >> >> >
> >> >> > Or.. we can also make offset[] dynamic size, if that looks less tricky:
> >> >> >
> >> >> > typedef struct {
> >> >> >     /* number of used pages */
> >> >> >     uint32_t num;
> >> >> >     /* number of normal pages */
> >> >> >     uint32_t normal_num;
> >> >> >     /* number of allocated pages */
> >> >> >     uint32_t allocated;
> >> >> >     RAMBlock *block;
> >> >> >     /* offset of each page */
> >> >> >     ram_addr_t offset[0];
> >> >> > } MultiFDPages_t;
> >> >> 
> >> >> I think you missed the point. If we hold a pointer inside the payload,
> >> >> we lose the reference when the other client takes the structure and puts
> >> >> its own data there. So we'll need to alloc/free everytime we send a
> >> >> packet.
> >> >
> >> > For option 1: when the buffer switch happens, MultiFDPages_t will switch as
> >> > a whole, including its offset[], because its offset[] always belong to this
> >> > MultiFDPages_t.  So yes, we want to lose that *offset reference together
> >> > with MultiFDPages_t here, so the offset[] always belongs to one single
> >> > MultiFDPages_t object for its lifetime.
> >> 
> >> MultiFDPages_t is part of MultiFDSendData, it doesn't get allocated
> >> individually:
> >> 
> >> struct MultiFDSendData {
> >>     MultiFDPayloadType type;
> >>     union {
> >>         MultiFDPages_t ram_payload;
> >>     } u;
> >> };
> >> 
> >> (and even if it did, then we'd lose the pointer to ram_payload anyway -
> >> or require multiple free/alloc)
> >
> > IMHO it's the same.
> >
> > The core idea is we allocate a buffer to put MultiFDSendData which may
> > contain either Pages_t or DeviceState_t, and the size of the buffer should
> > be MAX(A, B).
> >
> 
> Right, but with your zero-length array proposals we need to have a
> separate allocation for MultiFDPages_t because to expand the array we
> need to include the number of pages.

We need to fetch the max size we need and allocate one object covers all
the sizes we need.  I sincerely don't understand why it's an issue..

> 
> Also, don't think only about MultiFDPages_t. With this approach we
> cannot have pointers to memory allocated by the client at all anywhere
> inside the union. Every pointer needs to have another reference
> somewhere else to ensure we don't leak it. That's an unnecessary
> restriction.

So even if there can be multiple pointers we can definitely play the same
trick that we allocate object A+B+C+D in the same chunk and let A->b points
to B, A->c points to C, and so on.

Before that, my question is do we really need that.

For device states, AFAIU it'll always be an opaque buffer..  VFIO needs
that, vDPA probably the same, and for VMSDs it'll be a temp buffer to put
the VMSD dump.

For multifd, I used offset[0] just to make sure things like "dynamic sized
multifd buffers" will easily work without much changes.  Or even we could
have this, afaict:

#define MULTIFD_PAGES_PER_PACKET (128)

typedef struct {
    /* number of used pages */
    uint32_t num;
    /* number of normal pages */
    uint32_t normal_num;
    /* number of allocated pages */
    uint32_t allocated;
    RAMBlock *block;
    /* offset of each page */
    ram_addr_t offset[MULTIFD_PAGES_PER_PACKET];
} MultiFDPages_t;

It might change perf on a few archs where psize is not 4K, but I don't see
it a huge deal, personally.

Then everything will have no pointers, and it can be even slightly faster
because we use 64B cachelines in most systems nowadays, and one indirect
pointer may always need a load on a new cacheline otherwise..

This whole cacheline thing is trivial.  What I worried that you worry too
much on that flexibility that we may never need.

And even with that flexibilty I don't understand why you don't like
allocating an object that's larger than how the union is defined: I really
don't see it a problem..  It'll need care on alloc/free, true, but it
should be pretty manageable in this case to me.

> 
> >> 
> >> >
> >> > For option 2: I meant MultiFDPages_t will have no offset[] pointer anymore,
> >> > but make it part of the struct (MultiFDPages_t.offset[]).  Logically it's
> >> > the same as option 1 but maybe slight cleaner.  We just need to make it
> >> > sized 0 so as to be dynamic in size.
> >> 
> >> Seems like an undefined behavior magnet. If I sent this as the first
> >> version, you'd NACK me right away.
> >> 
> >> Besides, it's an unnecessary restriction to impose in the client
> >> code. And like above, we don't allocate the struct directly, it's part
> >> of MultiFDSendData, that's an advantage of using the union.
> >> 
> >> I think we've reached the point where I'd like to hear more concrete
> >> reasons for not going with the current proposal, except for the
> >> simplicity argument you already put. I like the union idea, but OTOH we
> >> already have a working solution right here.
> >
> > I think the issue with current proposal is each client will need to
> > allocate (N+1)*buffer, so more user using it the more buffers we'll need (M
> > users, then M*(N+1)*buffer).  Currently it seems to me we will have 3 users
> > at least: RAM, VFIO, and some other VMSD devices TBD in mid-long futures;
> > the latter two will share the same DeviceState_t.  Maybe vDPA as well at
> > some point?  Then 4.
> 
> You used the opposite argument earlier in this thread to argue in favor
> of the union: We'll only have 2 clients. I'm confused.

Maybe I meant "2 types of clients"?  VDPA will also use the same device
state buffer.

> 
> Although, granted, this RFC does use more memory.

IMHO it's also easier to understand, where any user always has a free
SendData buffer to manipulate, and multifd always has one buffer for each
channel (free or busy).  That is compared to each client needs to allocate
N buffers and we're actually at least leaking "number of multifd channels"
into the client which may not be wanted.

IOW, I wonder whether you're happy with below to drop the union idea:

     struct MultiFDSendData {
         MultiFDPayloadType type;
         MultiFDPages_t ram_payload;
         MultiFDDeviceState_t device_payload;
     };

Then we keep the "(M+N)" usage model, but don't use union and simply forget
about the memory consumption (similar to your original memory consumption
with this, but will be better as long as anything else joins, e.g. vDPA,
because then vDPA will at least share that same buffer with VFIO).

Do you think you would accept this?

> 
> > I'd agree with this approach only if multifd is flexible enough to not even
> > know what's the buffers, but it's not the case, and we seem only care about
> > two:
> >
> >   if (type==RAM)
> >      ...
> >   else
> >      assert(type==DEVICE);
> >      ...
> 
> I don't understand: "not even know what's the buffers" is exactly what
> this series is about. It doesn't have any such conditional on "type".
> 
> >
> > In this case I think it's easier we have multifd manage all the buffers
> > (after all, it knows them well...).  Then the consumption is not
> > M*(N+1)*buffer, but (M+N)*buffer.
> 
> Fine. As I said, I like the union approach. It's just that it doesn't
> work if the client wants to have a pointer in there.
> 
> Again, this is client data that multifd holds, it's not multifd
> data. MultiFDPages_t or DeviceState_t have nothing to do with
> multifd. It should be ok to have:
> 
> DeviceState_t *devstate = &p->data->u.device;
> devstate->foo = g_new0(...);
> devstate->bar = g_new0(...);
> 
> just like we have:
> 
> MultiFDPages_t *pages = &p->data->u.ram;
> pages->offset = g_new0(ram_addr_t, page_count);
> 
> >
> > Perhaps push your tree somewhere so we can have a quick look?
> 
> https://gitlab.com/farosas/qemu/-/commits/multifd-pages-decouple
> 
> > I'm totally
> > lost when you said I'll nack it.. so maybe I didn't really get what you
> > meant.  Codes may clarify that.
> 
> I'm conjecturing that any contributor adding a zero-length array (a[0])
> would probably be given a hard time on the mailing list. There's 10
> instances of it in the code base. The proper way to grow an array is to
> use a flexible array (a[]) instead.

I'm not familiar with flexible array.  What's the difference between:

struct {
    int a[];
};

v.s.

struct {
    int a[0];
};

?

If that works for you, it should work for me.

Or if you really hate the union / zero-sized array thing, it'll still be
nice to me to drop the union but keep using M+N objects model.

Thanks.

-- 
Peter Xu


