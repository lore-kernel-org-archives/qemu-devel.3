Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24CCD1039B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 17:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOJdC-000356-JQ; Wed, 26 Nov 2025 12:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vOJdA-00034N-Id
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 12:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vOJd7-00087G-SM
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 12:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764179315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJDNF2yfl9e53TkZtw74stO5OGoklx7BCjI92TpK1QU=;
 b=Y08g957Vn1uh/eSWlJCqTMKDdlc5BqGIP1Pf3zENbY2X5h+WeInz7/zfnSq/Yu8uzz33q6
 Ror+4Qg+WypSVlgUFpkbKkC9C8TBzukSWWGT0QtM7HIVpfNdqHBbW0Rdx8vM2gQXKsPBkP
 gsgH/G4zCfF34jK4lThB8v3iC7+2mtk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-uzKjSZTjPa2rBLO2aRA1XA-1; Wed, 26 Nov 2025 12:48:31 -0500
X-MC-Unique: uzKjSZTjPa2rBLO2aRA1XA-1
X-Mimecast-MFC-AGG-ID: uzKjSZTjPa2rBLO2aRA1XA_1764179311
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88236bcdfc4so3916d6.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764179311; x=1764784111; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YJDNF2yfl9e53TkZtw74stO5OGoklx7BCjI92TpK1QU=;
 b=ALyPGpTm5BirNmJ7tI9TZXtR8hZpMnFrPA6jxbQgNPWJFYVw4OK/6ygKP/TVEJ6QMe
 CSjLnj4KBVvZeDZRmdAEq9jNNpho5XSrQI7jIiS8ENJoqmox9FOzPsWhg1nTpTEJ/tjH
 IHhvMcx5Cm8pNMJnKuaRvVZgXDGPlgTSTUyZTlLCTsMKIuXpiTbZBuZrHWjK1evB/im9
 35ENG0qae+p09tNl/fxkvwgKyG8cnNLWFmvdlZh7wrlQdJIVDp6OPVMlZIQB6ZFN1HaM
 0bXgAIpBDwD6dGMOgAVxwXPXx7+EHXFRqlTlTeJSmOEA75z5Rf7F0mRYssFKZ0pqkRPx
 uQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764179311; x=1764784111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJDNF2yfl9e53TkZtw74stO5OGoklx7BCjI92TpK1QU=;
 b=SzRtqMKoj9FsMRJuhg6+lnf0tMh789k9ERjIDEYiuHEgGzjqJLgcVRUw9SOyJP/IC6
 3SF4Q4O86QpAG4XC6jdycwxTd39h0kHLvH9Pz5Khd/VSQ0uPFN/TB26pWgfXVgt/7nh7
 Nxkf3jZxytaXF8Kp34OS5cOd8a19JwBOxKfgaled60CegrEZlOKYkvy4L3iOP6lByhe8
 B+oMTZEt5kLkmuMn6UqiuklS7IMVoswUCfwsOX610foQbjWaLweEabioKpqbHYZC40va
 v722o3UQ1a5i+TLU1RKN9wSYH/NV+Je8UMEeNldxBf+IWfJ3x+fiKrUdQRJrxbwtBjPg
 FQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY5ycdhjWzXb0KqxjfCadGPZ4Sm4nHO/Pcvg7IMExIQ1GdUn97IlAjBU2F5iymZj3tD0LW4t23uYHp@nongnu.org
X-Gm-Message-State: AOJu0YzRAL7MpQE3JLucXcjmFnJpUp/Kn/WDjnF+/6ibQmclabRCx26o
 ow9gdS+I/AvIfuwzrCi+tu7UgQP9KY7DHzHLWxU8SIUXGt+jAoj89im21HJ3NmarFkhOIe+peKo
 it3yzW4hufS+8YwjKigMpjq/4q2we7o4dk2fvKYn6/TMcsxWVhjpv5Xh5
X-Gm-Gg: ASbGncuTBChPaQ3MWBlUm5320yBNSCPhdeE3/vJwUWM6qq7HCoHbdbUH7nydtil+f91
 60lbAQWAFaKaIDFADxi9FdgAbrnv2GNaZgnRLFEUhya9+8MmH2oH9HEPYrIaXyuWUUhRIIRIsyL
 bGWepnLx9o4IDFmX+PJjC+iUPWFJTO7pruO7ePz3HCzEHjFngU2r9YKgrfaZvb9Nk68RQW7Zkul
 FMYqZVnDSnEdiwIBetGyyelUfD77h0WAD/Gm0LLlla8SH9TgvlQHg4JUJmL+3oimEM8mrD+EN5p
 QbIdRGCf3vpmIxTNKDj4WzkF6GFtN2//eI52/LeL+SEgj9dDNhWC/dKLqI+ZoZAoTzvHAMt1LCd
 bXQk=
X-Received: by 2002:a05:6214:234f:b0:880:486d:18dc with SMTP id
 6a1803df08f44-8863afb4d8fmr113758916d6.58.1764179310652; 
 Wed, 26 Nov 2025 09:48:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt+nIpmsxf3JMIKGfhWOh6QQ6D1LPqYoKFxYut6YuugVf50sIgywin7NKeNytfMbvioL6Ecw==
X-Received: by 2002:a05:6214:234f:b0:880:486d:18dc with SMTP id
 6a1803df08f44-8863afb4d8fmr113758336d6.58.1764179310007; 
 Wed, 26 Nov 2025 09:48:30 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e446463sm147686876d6.11.2025.11.26.09.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 09:48:29 -0800 (PST)
Date: Wed, 26 Nov 2025 12:48:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Pawel Zmarzly <pzmarzly0@gmail.com>, qemu-devel@nongnu.org,
 michel@michel-slm.name
Subject: Re: [PATCH] migration: fix parsing snapshots with x-ignore-shared flag
Message-ID: <aSc9bPKAOpU8NzVN@x1.local>
References: <20251125174649.257457-1-pzmarzly0@gmail.com>
 <aSYE_rdMhH36KBxf@x1.local> <87tsyheqpv.fsf@suse.de>
 <aSYt4MUUESAcThrr@x1.local> <87o6opdksw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6opdksw.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 26, 2025 at 09:45:35AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Nov 25, 2025 at 06:40:12PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Tue, Nov 25, 2025 at 05:46:49PM +0000, Pawel Zmarzly wrote:
> >> >> Snapshots made with mapped-ram and x-ignore-shared flags are
> >> >> not parsed properly.
> >> >> 
> >> >> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
> >> >> ---
> >> >>  migration/ram.c | 5 +++++
> >> >>  1 file changed, 5 insertions(+)
> >> >> 
> >> >> diff --git a/migration/ram.c b/migration/ram.c
> >> >> index 29f016cb25..85fdc810ab 100644
> >> >> --- a/migration/ram.c
> >> >> +++ b/migration/ram.c
> >> >> @@ -4277,6 +4277,11 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
> >> >>          id[len] = 0;
> >> >>          length = qemu_get_be64(f);
> >> >>  
> >> >> +        if (migrate_ignore_shared()) {
> >> >> +            /* Read and discard the x-ignore-shared memory region address */
> >> >> +            qemu_get_be64(f);
> >> >> +        }
> >> >> +
> >> >>          block = qemu_ram_block_by_name(id);
> >> >>          if (block) {
> >> >>              ret = parse_ramblock(f, block, length);
> >> >> -- 
> >> >> 2.52.0
> >> >> 
> >> >
> >> > Thanks for the patch, though the u64 was parsed in parse_ramblock()
> >> > instead.  Would you consider refactoring that function instead?
> >> 
> >> There's actually not much going on in terms of "parsing" in
> >> parse_ramblock(). I think we could move the migrate_ignore_shared() from
> >> the end of the function to before the mapped-ram check().
> >
> > Yes, that's also what I meant if it wasn't clear.. it was parsed into a
> > hwaddr, and it was used to verify the addresses match.
> >
> > If that check is needed for ignore-shared blocks, then these checks should
> > also apply when mapped-ram is enabled on top of whatever ramblock got
> > ignored during migration.
> >
> 
> Right, because ignore_shared implies putting the MR address in the
> stream, but there is still the matter of whether the pages will actually
> be read on the destination.
> 
> Should ram_save_setup() use RAMBLOCK_FOREACH_NOT_IGNORED instead of
> RAMBLOCK_FOREACH_MIGRATABLE? I don't immediately see why not...

Yes what you said makes sense, even if we may need to change more than
that..

Currently we'll dump the total amount of mem first before dumping the
ramblocks, that is this line:

        qemu_put_be64(f, ram_bytes_total_with_ignored()
                         | RAM_SAVE_FLAG_MEM_SIZE);

RAMBLOCK_FOREACH_MIGRATABLE() is used in ram_bytes_total_with_ignored(),
hence we need to keep using it for the loop later or the total size will
stop matching..

So if we change, then we'll at least also need to change there.  Either of
such change will be an ABI change.. that goes back to the "common migration
challenge" on compatibilities of old snapshot taken to be loadable on new
QEMUs..  Sad. :(

> 
> > Since the discussion started, I am actually not sure if we do this all
> > right for two things..
> >
> > (1) When mapped-ram is enabled, do we actually need to setup those
> >     ramblocks in mapped_ram_setup_ramblock()?
> >
> >     That is, when a ramblock returns migrate_ram_is_ignored()==true, IIUC
> >     we don't need to allocate bitmap or page chunks for it?
> >
> >     We likely don't need to change this easily, because this will change
> >     file format.. I'm also not sure if this is a major issue, logically
> >     when ignore-shared is used we normally shouldn't need mapped-ram.. vice
> >     versa.  So I may need to better understand the use case first on
> >     enabling the two..
> >
> 
> Thanks, Peter. A keen eye, as usual. I was searching for this reasoning
> when looking at the code, but it missed me.
> 
> I looked back at the very first version of fixed-ram, which wasn't
> authored by me and there is indeed no mention or expectation of handling
> shared ram. So I think this is at this point unspecified.
> 
> What is the current impact of having those pages in? We're "just"
> wasting cycles writing to the file, AFAICS. We'd better, at least,
> sanitise that part to avoid the extra work.

We do not write to those chunks.. See:

static void pss_find_next_dirty(PageSearchStatus *pss)
{
    RAMBlock *rb = pss->block;
    unsigned long size = rb->used_length >> TARGET_PAGE_BITS;
    unsigned long *bitmap = rb->bmap;

    if (migrate_ram_is_ignored(rb)) {
        /* Points directly to the end, so we know no dirty page */
        pss->page = size;
        return;
    }
    ...
}

So essentially those blobs (bitmap + page chunks) will be reserved but kept
as-is, afaict.  RAM iterator jumps over them.

Likely that's a good news, at least what you raised as concern isn't a
problem so far, it's only the image storage that will be wasted keeping
them zeros.

> 
> > (2) Is the check proper on validating mr->addr didn't change?
> >
> >     This is a question on the check itself when ignore-shared enabled,
> >     with/without mapped-ram enabled.  That is, I question whether this
> >     check is useful or valid at all:
> >     
> >     if (migrate_ignore_shared()) {
> >         hwaddr addr = qemu_get_be64(f);
> >         if (migrate_ram_is_ignored(block) &&
> >             block->mr->addr != addr) {
> >             error_report("Mismatched GPAs for block %s "
> >                          "%" PRId64 "!= %" PRId64, block->idstr,
> >                          (uint64_t)addr, (uint64_t)block->mr->addr);
> >             return -EINVAL;
> >         }
> >     }
> >
> 
> I agree with all you say below, but I think an earlier question would
> be: why put the address on the stream in the first place? Is this just
> hardening of some sort?

Yep; that's how I see it too, only that the checks are actually not
safe or at least causing more trouble than help..

Side note: not sure if you noticed, the 2nd check was removed here:

    commit b17fbbe55cba95ad323b27c2f9f3e22eb6364d4b
    Author: Peng Tao <tao.peng@linux.alibaba.com>
    Date:   Fri Jun 14 14:35:13 2019 +0800

    migration: allow private destination ram with x-ignore-shared

That commit was to enable some share=off memory loading from a share=on
memory snapshot use case, which is pretty interesting.

> 
> The commit the introduces the feature has me wondering:
> 
> fbd162e629 ("migration: Add an ability to ignore shared RAM blocks")
> 
>   during save:
>   
>   +        if (migrate_ignore_shared()) {
>   +            qemu_put_be64(f, block->mr->addr);
>   +            qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
>   +        }
> 
>   during load:
>   +    if (ramblock_is_ignored(block)) {
>            error_report("block %s should not be migrated !", id);
>            return NULL;
>        }
> 
> If we know it's ignored, why send anything at all? (also, "to ignore"
> has a meaning, we should stick to it)

If we do not have the compatibility issue to consider, I agree with you
that all over ram.c we should only care about "not-ignored", rather than
"migratable".

Now we need to evaluate how bad it is with the current status quo, and
whether we will need a property enabling new streams doing the right thing.
So we can choose to keep this as-is, but introduce a flag only if necessary
and confident we should remove this overhead.

> 
> >     In the error, it said "GPA", but mr->addr isn't GPA.. it's the offset
> >     of the MR within the MR's parent container MR..  So if the parent is
> >     the root MR / system_memory, then it is the GPA, however I don't see it
> >     guaranteed..
> >
> 
> Looking at the initial commit, I think this is all sanity check, maybe
> to ensure some sort of stream compatibility. Or to make sure the stream
> is stateful and we're not confusing an ignored block with an
> (incorrectly) ignored one.
> 
> >     My gut feeling is we almost always rely on proper QEMU cmdlines anyway
> >     to make migration work.  I wonder if we should just remove this check
> >     (in case it might break when mr's parent isn't the root MR).
> >
> 
> I believe it's ok to remove the check. I wish we had a compatible way to
> remove handling of ignored blocks altogether, but I guess this u64 is
> now on the stream forever?

Yes. :(

> 
> > This is irrelevant of this specific fix, so it doesn't need to block a
> > repost..
> 

-- 
Peter Xu


