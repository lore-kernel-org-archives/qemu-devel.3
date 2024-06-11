Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA62CC27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 16:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH4Gu-0003jB-4x; Tue, 11 Jun 2024 12:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sH4Gt-0003iX-CH; Tue, 11 Jun 2024 12:22:55 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sH4Gr-000199-6Y; Tue, 11 Jun 2024 12:22:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so44689895ad.1; 
 Tue, 11 Jun 2024 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718122971; x=1718727771; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pv6PISvr2XUjNP+uegBuVeg22kS4wy5UCX42VcqVPyE=;
 b=VruFGIW04GtZCKWYsqeooEd5fdYg6TkCbIZJfj7rz+haBM2oZpPC5AtUP4VyigXic8
 sb8BotfDrW0RWuLIFb7T/tsUZIyAeQotpQi5u5wTcUlr/LBEYDd/NGdcRYP8sMOGuej8
 f8mCH3Yg8ISybHXA82dC65LgnFLS8kF8Gr4ITTc3WFjIjB54mU13CMtRJDU+kFTR/xrV
 gMpI4kCaG8/aFuiX72BnMK0cMWiKEb9R3Hm+BMctUqY3SbwuqxWA+IYu6+ROmBOjOeZf
 M/dVCyoskrBgAT4IOopCDoUHaa0ZpP5Q2XXprx63rT8zHEmrN09x8thPIsdo8q5TkUkK
 a8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718122971; x=1718727771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pv6PISvr2XUjNP+uegBuVeg22kS4wy5UCX42VcqVPyE=;
 b=W/biZa8sOVAHvHj5g5OxTAoVbnAIa88xNKYJJyhe/kSvGItFdQ1kD5dkL0Z8ND2l+k
 swO9w9OLjCPYOl0ztHDvGN+ST7zHl3Vim+XyO5KNyIm4dzLIb26lb3GHJ6WLRmL1/tCR
 KsvdwnEk6gyCHRGTFCrKBh5eItFZEzZdNsYKafR9UadOsdEqd9rFrvWxtCCG1N7ZucZv
 nzUFubxKy6tvF+H8mOKalJVl4PZxxCo32KLlztTVrHN63xNH2pGXRMl5PF1aYfnAkiBI
 /A+arB8wtcqIVqJG474l0z4tGTUaqhGkJ3CEDnkaEgn3zRtEbryHn2RMWwLIkkwjD0co
 k+sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW89YcEZBk/oguYSKxcGdzoW/GKn4E/VAXmpLApTtJdSBv7yt4Mx3w0a8EfqdGZ/5FCQMAsimos6ki1komwMldELCs4t6w=
X-Gm-Message-State: AOJu0YxZkQoekwY7q8kB/G2GCz9gP7ND3YvIEjaxumxhNM4k5SiycbRL
 Jqw4fmTYlFt+wZUbWvzTretNaeLeLrzw5LvUh4YBGEVMrg4U8jKz
X-Google-Smtp-Source: AGHT+IGcRaPZMY67r++uJl+bV52tllnmRcPeEJaQ+B7lNf5lbkU8hlLucITVw1esAHwyOz0dVvnC/A==
X-Received: by 2002:a17:902:d487:b0:1f6:612b:96eb with SMTP id
 d9443c01a7336-1f6d0395667mr150622815ad.50.1718122970642; 
 Tue, 11 Jun 2024 09:22:50 -0700 (PDT)
Received: from amjad-pc ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6e7858544sm74870125ad.75.2024.06.11.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:22:50 -0700 (PDT)
Date: Wed, 12 Jun 2024 00:22:46 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 2/4] vvfat: Fix usage of `info.file.offset`
Message-ID: <Zmh51luVeRY6H-Qp@amjad-pc>
References: <cover.1717549035.git.amjadsharafi10@gmail.com>
 <a4ae80b8307284a8b30f0267171cca850f12dc42.1717549035.git.amjadsharafi10@gmail.com>
 <Zmcup6IVpHW3sRP5@redhat.com> <ZmhDl7ob8G62FtZb@amjad-pc>
 <ZmhfnSIe30da03uN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmhfnSIe30da03uN@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 11, 2024 at 04:30:53PM +0200, Kevin Wolf wrote:
> Am 11.06.2024 um 14:31 hat Amjad Alsharafi geschrieben:
> > On Mon, Jun 10, 2024 at 06:49:43PM +0200, Kevin Wolf wrote:
> > > Am 05.06.2024 um 02:58 hat Amjad Alsharafi geschrieben:
> > > > The field is marked as "the offset in the file (in clusters)", but it
> > > > was being used like this
> > > > `cluster_size*(nums)+mapping->info.file.offset`, which is incorrect.
> > > > 
> > > > Additionally, removed the `abort` when `first_mapping_index` does not
> > > > match, as this matches the case when adding new clusters for files, and
> > > > its inevitable that we reach this condition when doing that if the
> > > > clusters are not after one another, so there is no reason to `abort`
> > > > here, execution continues and the new clusters are written to disk
> > > > correctly.
> > > > 
> > > > Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
> > > 
> > > Can you help me understand how first_mapping_index really works?
> > > 
> > > It seems to me that you get a chain of mappings for each file on the FAT
> > > filesystem, which are just the contiguous areas in it, and
> > > first_mapping_index refers to the mapping at the start of the file. But
> > > for much of the time, it actually doesn't seem to be set at all, so you
> > > have mapping->first_mapping_index == -1. Do you understand the rules
> > > around when it's set and when it isn't?
> > 
> > Yeah. So `first_mapping_index` is the index of the first mapping, each
> > mapping is a group of clusters that are contiguous in the file.
> > Its mostly `-1` because the first mapping will have the value set as
> > `-1` and not its own index, this value will only be set when the file
> > contain more than one mapping, and this will only happen when you add
> > clusters to a file that are not contiguous with the existing clusters.
> 
> Ah, that makes some sense. Not sure if it's optimal, but it's a rule I
> can work with. So just to confirm, this is the invariant that we think
> should always hold true, right?
> 
>     assert((mapping->mode & MODE_DIRECTORY) ||
>            !mapping->info.file.offset ||
>            mapping->first_mapping_index > 0);
> 

Yes.

We can add this into `get_cluster_count_for_direntry` loop.
I'm thinking of also converting those `abort` into `assert`, since
the line `copy_it = 1;` was confusing me, since it was after the `abort`.

> > And actually, thanks to that I noticed another bug not fixed in PATCH 3, 
> > We are doing this check 
> > `s->current_mapping->first_mapping_index != mapping->first_mapping_index`
> > to know if we should switch to the new mapping or not. 
> > If we were reading from the first mapping (`first_mapping_index == -1`)
> > and we jumped to the second mapping (`first_mapping_index == n`), we
> > will catch this condition and switch to the new mapping.
> > 
> > But if the file has more than 2 mappings, and we jumped to the 3rd
> > mapping, we will not catch this since (`first_mapping_index == n`) for
> > both of them haha. I think a better check is to check the `mapping`
> > pointer directly. (I'll add it also in the next series together with a
> > test for it.)
> 
> This comparison is exactly what confused me. I didn't realise that the
> first mapping in the chain has a different value here, so I thought this
> must mean that we're looking at a different file now - but of course I
> couldn't see a reason for that because we're iterating through a single
> file in this function.
> 
> But even now that I know that the condition triggers when switching from
> the first to the second mapping, it doesn't make sense to me. We don't
> have to copy things around just because a file is non-contiguous.
> 
> What we want to catch is if the order of mappings has changed compared
> to the old state. Do we need a linked list, maybe a prev_mapping_index,
> instead of first_mapping_index so that we can compare if it is still the
> same as before?

I think this would be the better design (tbh, that's what I thought 
`first_mapping_index` would do), though not sure if other components
depend so much into the current design that it would be hard to change.

I'll try to implement this `prev_mapping_index` and see how it goes.

> 
> Or actually, I suppose that's the first block with an abort() in the
> code, just that it doesn't compare mappings, but their offsets.

I think, I'm still confused on the whole logic there, the function
`get_cluster_count_for_direntry` is a mess, and it doesn't just
*get* the cluster count, it also schedule writeouts and may
copy clusters around.

> 
> > > 
> > > >  block/vvfat.c | 12 +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/block/vvfat.c b/block/vvfat.c
> > > > index 19da009a5b..f0642ac3e4 100644
> > > > --- a/block/vvfat.c
> > > > +++ b/block/vvfat.c
> > > > @@ -1408,7 +1408,9 @@ read_cluster_directory:
> > > >  
> > > >          assert(s->current_fd);
> > > >  
> > > > -        offset=s->cluster_size*(cluster_num-s->current_mapping->begin)+s->current_mapping->info.file.offset;
> > > > +        offset = s->cluster_size *
> > > > +            ((cluster_num - s->current_mapping->begin)
> > > > +            + s->current_mapping->info.file.offset);
> > > >          if(lseek(s->current_fd, offset, SEEK_SET)!=offset)
> > > >              return -3;
> > > >          s->cluster=s->cluster_buffer;
> > > > @@ -1929,8 +1931,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
> > > >                          (mapping->mode & MODE_DIRECTORY) == 0) {
> > > >  
> > > >                      /* was modified in qcow */
> > > > -                    if (offset != mapping->info.file.offset + s->cluster_size
> > > > -                            * (cluster_num - mapping->begin)) {
> > > > +                    if (offset != s->cluster_size
> > > > +                            * ((cluster_num - mapping->begin)
> > > > +                            + mapping->info.file.offset)) {
> > > >                          /* offset of this cluster in file chain has changed */
> > > >                          abort();
> > > >                          copy_it = 1;
> > > > @@ -1944,7 +1947,6 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
> > > >  
> > > >                      if (mapping->first_mapping_index != first_mapping_index
> > > >                              && mapping->info.file.offset > 0) {
> > > > -                        abort();
> > > >                          copy_it = 1;
> > > >                      }
> > > 
> > > I'm unsure which case this represents. If first_mapping_index refers to
> > > the mapping of the first cluster in the file, does this mean we got a
> > > mapping for a different file here? Or is the comparison between -1 and a
> > > real value?
> > 
> > Now that I think more about it, I think this `abort` is actually
> > correct, the issue though is that the handling around this code is not.
> > 
> > What this `abort` actually does is that it checks.
> > - if the `mapping->first_mapping_index` is not the same as
> >   `first_mapping_index`, which **should** happen only in one case, when
> >   we are handling the first mapping, in that case
> >   `mapping->first_mapping_index == -1`, in all other cases, the other
> >   mappings after the first should have the condition true.
> > - From above, we know that this is the first mapping, so if the offset
> >   is not `0`, then abort, since this is an invalid state.
> 
> Yes, make sense.
> 
> > This is all good, the issue is that `first_mapping_index` is not set if
> > we are checking from the middle, the variable `first_mapping_index` is
> > only set if we passed through the check `cluster_was_modified` with the
> > first mapping, and in the same function call we checked the other
> > mappings.
> 
> I think I noticed the same yesterday, but when I tried to write a quick
> patch that I could show you and that would update first_mapping_index in
> each iteration, I broke something. So I decided I'd first ask you what
> all of this even means. :-)
> 
> > From what I have seen, that doesn't happen since even if you write the
> > whole file in one go, you are still writing it cluster by cluster, and
> > the checks happen at that time.
> 
> Well, we do trigger the condition, but I suppose updating
> first_mapping_index in each loop iteration is really the way to go if
> you think the same.

Indeed, I did a quick change, modifying the loop to always go through
and set the `first_mapping_index` for the first mapping fixes the issue
and we can put the `abort` back in place.

I'll also modify the check to instead be 
`mapping->first_mapping_index < 0 && mapping->info.file.offset > 0`
This will make it clear that this applies only to the first mapping.

> 
> Kevin
> 

