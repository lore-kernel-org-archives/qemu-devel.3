Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49E0C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0ew-00081z-KL; Tue, 11 Jun 2024 08:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sH0eu-00081D-3I; Tue, 11 Jun 2024 08:31:28 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sH0er-0000pf-Vm; Tue, 11 Jun 2024 08:31:27 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f717ee193fso7388905ad.0; 
 Tue, 11 Jun 2024 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718109084; x=1718713884; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EseZrSS/EzqecSk6v570Hyl8GLP8lFPrIDlOarKrA5g=;
 b=QiXLIjJ+A/te3Bp7Q0VLwHYWvls70JcTrnQtB6AL7o8ksk7cwoVxQXaJnilOgwIGUh
 ImyIo7LkZXbXWDWu1iNe4/OlW7iOxRPIlotewfOSw14UWO7K6j4TPCfCvXbZ5k+RnGmS
 6uMZx2sUZjVF5Lto/jWu/1KAhpqevGIt7BVfxMdbbqxAgl66hRrkZqpSbynE0ljhLU9/
 UIZ6esxBYv+ZUctea3Zh4xpt97ZlvJruZdBLl17TFHVoT+ZFBbmkaaRbF4L9i8ETLm3x
 unkOaebDJ4iYzVKgaxaZZ3Z8GEGH7suypej0/BjfOAp+oluE5k0ji6LYXy2D7bwkD6Ls
 pU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718109084; x=1718713884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EseZrSS/EzqecSk6v570Hyl8GLP8lFPrIDlOarKrA5g=;
 b=L3AxbrBOL0CYRPLP0HgyfnX1ieYK5/02/VIGbQsF08mZjGOBvBLzNLjJlm0Jk/4gw+
 9A5njNJ8QiV5NLBIt9j/aIU8eEkF/HslJknMVxmqWKavgRNTXubk886WOFGfx5cDrU4x
 bFvDpva6+IvUtSG9yT/Abpwi8kffDYY+2beuzxjOF27id58D2t6N9PjHHoOUVOYVj1Es
 Kkv/vM/lG89bZ4IU6ocAu1FqbRifzK9ZShPv6rQ111IbpW7+4SVfWVMq/5nvEx44cjq8
 eCu+TJt6As8pCeMPkOxZT8WcgX4WPEQriqQ7+612kVX4poz5hdTHJrNczxIgaXDtRhMl
 h/vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwcqrQRvUOEvMWsiDNSmdZKUxHQvN9Hv1ZB4/HUMAuG8dxjUOj344/+leECHgWLaAjrz3iu/3Jfh6nvwJsC5HETJuIskY=
X-Gm-Message-State: AOJu0YywPXuWrAQxrrEH7VnwWtmjoimR2Zg63G0x2JSh+livDagAad4J
 EBEEwLdnSOL0J/1DVXpylPPJRb3/UpOdRBwCvYxhVDlqepd0+a4d
X-Google-Smtp-Source: AGHT+IHKf0jJkOjBG94OQZNb5o0Q090g0byn5FZ7K7c/D010Ds6jvhwPfKEXqKKZiEEnvxAxa3UwNA==
X-Received: by 2002:a17:903:41d0:b0:1f6:607e:16c6 with SMTP id
 d9443c01a7336-1f6d036c634mr157837405ad.42.1718109083611; 
 Tue, 11 Jun 2024 05:31:23 -0700 (PDT)
Received: from amjad-pc ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6e11e6608sm78001445ad.136.2024.06.11.05.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 05:31:23 -0700 (PDT)
Date: Tue, 11 Jun 2024 20:31:19 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 2/4] vvfat: Fix usage of `info.file.offset`
Message-ID: <ZmhDl7ob8G62FtZb@amjad-pc>
References: <cover.1717549035.git.amjadsharafi10@gmail.com>
 <a4ae80b8307284a8b30f0267171cca850f12dc42.1717549035.git.amjadsharafi10@gmail.com>
 <Zmcup6IVpHW3sRP5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmcup6IVpHW3sRP5@redhat.com>
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

On Mon, Jun 10, 2024 at 06:49:43PM +0200, Kevin Wolf wrote:
> Am 05.06.2024 um 02:58 hat Amjad Alsharafi geschrieben:
> > The field is marked as "the offset in the file (in clusters)", but it
> > was being used like this
> > `cluster_size*(nums)+mapping->info.file.offset`, which is incorrect.
> > 
> > Additionally, removed the `abort` when `first_mapping_index` does not
> > match, as this matches the case when adding new clusters for files, and
> > its inevitable that we reach this condition when doing that if the
> > clusters are not after one another, so there is no reason to `abort`
> > here, execution continues and the new clusters are written to disk
> > correctly.
> > 
> > Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
> 
> Can you help me understand how first_mapping_index really works?
> 
> It seems to me that you get a chain of mappings for each file on the FAT
> filesystem, which are just the contiguous areas in it, and
> first_mapping_index refers to the mapping at the start of the file. But
> for much of the time, it actually doesn't seem to be set at all, so you
> have mapping->first_mapping_index == -1. Do you understand the rules
> around when it's set and when it isn't?

Yeah. So `first_mapping_index` is the index of the first mapping, each
mapping is a group of clusters that are contiguous in the file.
Its mostly `-1` because the first mapping will have the value set as
`-1` and not its own index, this value will only be set when the file
contain more than one mapping, and this will only happen when you add
clusters to a file that are not contiguous with the existing clusters.

And actually, thanks to that I noticed another bug not fixed in PATCH 3, 
We are doing this check 
`s->current_mapping->first_mapping_index != mapping->first_mapping_index`
to know if we should switch to the new mapping or not. 
If we were reading from the first mapping (`first_mapping_index == -1`)
and we jumped to the second mapping (`first_mapping_index == n`), we
will catch this condition and switch to the new mapping.

But if the file has more than 2 mappings, and we jumped to the 3rd
mapping, we will not catch this since (`first_mapping_index == n`) for
both of them haha. I think a better check is to check the `mapping`
pointer directly. (I'll add it also in the next series together with a
test for it.)

> 
> >  block/vvfat.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/block/vvfat.c b/block/vvfat.c
> > index 19da009a5b..f0642ac3e4 100644
> > --- a/block/vvfat.c
> > +++ b/block/vvfat.c
> > @@ -1408,7 +1408,9 @@ read_cluster_directory:
> >  
> >          assert(s->current_fd);
> >  
> > -        offset=s->cluster_size*(cluster_num-s->current_mapping->begin)+s->current_mapping->info.file.offset;
> > +        offset = s->cluster_size *
> > +            ((cluster_num - s->current_mapping->begin)
> > +            + s->current_mapping->info.file.offset);
> >          if(lseek(s->current_fd, offset, SEEK_SET)!=offset)
> >              return -3;
> >          s->cluster=s->cluster_buffer;
> > @@ -1929,8 +1931,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
> >                          (mapping->mode & MODE_DIRECTORY) == 0) {
> >  
> >                      /* was modified in qcow */
> > -                    if (offset != mapping->info.file.offset + s->cluster_size
> > -                            * (cluster_num - mapping->begin)) {
> > +                    if (offset != s->cluster_size
> > +                            * ((cluster_num - mapping->begin)
> > +                            + mapping->info.file.offset)) {
> >                          /* offset of this cluster in file chain has changed */
> >                          abort();
> >                          copy_it = 1;
> > @@ -1944,7 +1947,6 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
> >  
> >                      if (mapping->first_mapping_index != first_mapping_index
> >                              && mapping->info.file.offset > 0) {
> > -                        abort();
> >                          copy_it = 1;
> >                      }
> 
> I'm unsure which case this represents. If first_mapping_index refers to
> the mapping of the first cluster in the file, does this mean we got a
> mapping for a different file here? Or is the comparison between -1 and a
> real value?

Now that I think more about it, I think this `abort` is actually
correct, the issue though is that the handling around this code is not.

What this `abort` actually does is that it checks.
- if the `mapping->first_mapping_index` is not the same as
  `first_mapping_index`, which **should** happen only in one case, when
  we are handling the first mapping, in that case
  `mapping->first_mapping_index == -1`, in all other cases, the other
  mappings after the first should have the condition true.
- From above, we know that this is the first mapping, so if the offset
  is not `0`, then abort, since this is an invalid state.

This is all good, the issue is that `first_mapping_index` is not set if
we are checking from the middle, the variable `first_mapping_index` is
only set if we passed through the check `cluster_was_modified` with the
first mapping, and in the same function call we checked the other
mappings.

From what I have seen, that doesn't happen since even if you write the
whole file in one go, you are still writing it cluster by cluster, and
the checks happen at that time.

> 
> In any case it doesn't seem to be the case that the comment at the
> declaration of copy_it describes.
> 
> >  
> > @@ -2404,7 +2406,7 @@ static int commit_mappings(BDRVVVFATState* s,
> >                          (mapping->end - mapping->begin);
> >              } else
> >                  next_mapping->info.file.offset = mapping->info.file.offset +
> > -                        mapping->end - mapping->begin;
> > +                        (mapping->end - mapping->begin);
> >  
> >              mapping = next_mapping;
> >          }
> 
> Kevin
> 

