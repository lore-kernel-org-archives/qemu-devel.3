Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5184BC3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 00:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUbM6-0000rb-G4; Thu, 18 Jul 2024 20:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sUbM4-0000qU-HJ; Thu, 18 Jul 2024 20:20:12 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sUbM1-0003Mh-1K; Thu, 18 Jul 2024 20:20:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-78cc22902dcso928318a12.0; 
 Thu, 18 Jul 2024 17:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721348406; x=1721953206; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k6XY/3VCsCDoU9nIkkcXb6sX0Dl0Xw4+fGSeIemQqq4=;
 b=GdZDx4Mik/Lfsupu7QjFs4cfnecpH2pIfPt6l3lxhly9oRRHp7iltyFaWzOjHpjK+R
 qe3b7aEQwVqRXogdSJ4+SpK1GsASknqO2w59PFHqcRgeN1hYXXRf/GIlYk/P/7J/lbwo
 bruJpTCZxXABdHMUKLz/jAxtgkyqY91SgAQPh6z+2AacZxpjT8oUGmoDUolRwPYD6ifc
 rJTruQjCDaU9fc+Swmelqzla3SyNF3sMaJoDAV7zRtxjGrDibzacI2HFEXjRXSz9Kw7J
 1iu1j0c8da4RCP20QDYLXHiMqSuZLg/8TVdXMJmauKcKlhDDR/WtGjOH1kjy4g34lgd0
 TNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721348406; x=1721953206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6XY/3VCsCDoU9nIkkcXb6sX0Dl0Xw4+fGSeIemQqq4=;
 b=vvwNhs6w713pAOueKyrkQpxBtLDPOacLPEG0YcmRpH8RgQjD1udw/QF9+CBKwzmOPM
 j8CQQmJ53T2/cB1dUdNDiXfSe1SMgkM2uRBFCyDcvNNRHocsa6SOFsog1HhV7QG4l9Bz
 a8WHBxtjLrLB2uit9u7qR5hwrATHf/A+b8hqNS4tgIATzbxBCXQYVjRR7v3Do+OYODLa
 lI+FAWHJIRA/Pj+3/djFeX6F5laMKwOUvz5n3EW+5WU0fRQA9zOoZQKpP+L+MAqhuu7U
 qvyTzxcLW/A+LrShkEvV5wKMrlg/AqhIm9C6xMqbjfssd5bwLTjEVInVvbRhlyx7lUxr
 ETmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPPx5I5EHrVw7BDzCOZ3UG5XTUxCoNhFNqV36DgNdKGcpekJwykcMviRXPXT+38ZS1gcYYtpYBgNPEjOZ2Vk1LyEto4cc=
X-Gm-Message-State: AOJu0YyvvqNgkTDhuftRq8Bja7vt9mo+Bcl2RqjVnTVCUT5+fNLu8KFo
 rZIBxGzjaSXQ0QEJG3hFhuR/NepTGnG/mdKdsF1dwW9aJempwLPg
X-Google-Smtp-Source: AGHT+IG1E9lqYuT6EbK5w5cXS5x3LBeJgmjHCZhRuFyeWsUIXQgvHsmDbsZrizN/8fDpfAvzcCXFVA==
X-Received: by 2002:a05:6a20:729a:b0:1c2:8cf4:766c with SMTP id
 adf61e73a8af0-1c3fdcafebcmr7939326637.33.1721348405600; 
 Thu, 18 Jul 2024 17:20:05 -0700 (PDT)
Received: from amjad-pc ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff552708sm117515b3a.129.2024.07.18.17.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 17:20:04 -0700 (PDT)
Date: Fri, 19 Jul 2024 08:20:00 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 4/5] vvfat: Fix reading files with non-continuous
 clusters
Message-ID: <ZpmxMEj5qZDUhj_h@amjad-pc>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
 <9c0be954b608da7d47c6a0c120da332c16798d2a.1718195956.git.amjadsharafi10@gmail.com>
 <ZpkyxA3s_gzQE7gW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpkyxA3s_gzQE7gW@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 18, 2024 at 05:20:36PM +0200, Kevin Wolf wrote:
> Am 12.06.2024 um 14:43 hat Amjad Alsharafi geschrieben:
> > When reading with `read_cluster` we get the `mapping` with
> > `find_mapping_for_cluster` and then we call `open_file` for this
> > mapping.
> > The issue appear when its the same file, but a second cluster that is
> > not immediately after it, imagine clusters `500 -> 503`, this will give
> > us 2 mappings one has the range `500..501` and another `503..504`, both
> > point to the same file, but different offsets.
> > 
> > When we don't open the file since the path is the same, we won't assign
> > `s->current_mapping` and thus accessing way out of bound of the file.
> > 
> > From our example above, after `open_file` (that didn't open anything) we
> > will get the offset into the file with
> > `s->cluster_size*(cluster_num-s->current_mapping->begin)`, which will
> > give us `0x2000 * (504-500)`, which is out of bound for this mapping and
> > will produce some issues.
> > 
> > Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
> > ---
> >  block/vvfat.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/vvfat.c b/block/vvfat.c
> > index b63ac5d045..fc570d0610 100644
> > --- a/block/vvfat.c
> > +++ b/block/vvfat.c
> > @@ -1360,15 +1360,24 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
> >  {
> >      if(!mapping)
> >          return -1;
> > +    int new_path = 1;
> >      if(!s->current_mapping ||
> > -            strcmp(s->current_mapping->path,mapping->path)) {
> > -        /* open file */
> > -        int fd = qemu_open_old(mapping->path,
> > +            s->current_mapping->info.file.offset
> > +                != mapping->info.file.offset ||
> 
> I'm wondering if this couldn't just be s->current_mapping != mapping?

Actually, you are totally right. Not sure what made me go for this.

I tried also to test with only checking if the path changed, but it
fails on some tests. So the offset is important.
For that reason, checking just the mapping ptr is better since we won't
have 2 mappings with same file and offset.

I'll then use this change. Thanks

> 
> > +            (new_path = strcmp(s->current_mapping->path, mapping->path))) {
> 
> If both the path and the offset change, we still want to set new_path, I
> think. And if we didn't already have a mapping, we also need to open the
> file.
> 
> Actually, setting a variable inside the condition makes it kind of hard
> to read, so if s->current_mapping != mapping works, we can do the check
> only in the conditon below:
> 
> > +        if (new_path) {
> 
> if (!s->current_mapping ||
>     strcmp(s->current_mapping->path, mapping->path))
> 
> > +            /* open file */
> > +            int fd = qemu_open_old(mapping->path,
> >                                 O_RDONLY | O_BINARY | O_LARGEFILE);
> > -        if(fd<0)
> > -            return -1;
> > -        vvfat_close_current_file(s);
> > -        s->current_fd = fd;
> > +            if (fd < 0) {
> > +                return -1;
> > +            }
> > +            vvfat_close_current_file(s);
> > +
> > +            s->current_fd = fd;
> > +        }
> > +        assert(s->current_fd);
> >          s->current_mapping = mapping;
> >      }
> 
> Kevin
> 

