Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B4BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 00:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUbVG-00076j-F7; Thu, 18 Jul 2024 20:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sUbVF-00075F-4N; Thu, 18 Jul 2024 20:29:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sUbVD-0005Lf-8j; Thu, 18 Jul 2024 20:29:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d56so9546955ad.1; 
 Thu, 18 Jul 2024 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721348977; x=1721953777; darn=nongnu.org;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UdrveFfkoPjZqTrIu5NZhidMPt2ZUmMLu7/z/4vhog=;
 b=kMcQEL/2L9oPE3ktpGO1ew30PX3Gyev13hYy/B2gNgf8FRVG5dMS4L9VhGVfjuL3Ut
 BbTIH5C1MzCv8dzwtrQQNOYSygYEA9VTwXcc1Oi7p32K6nrREb0Gycrhi0t6nvulv0rD
 A8LmaDhF+QD32YP/MMXVthnhK8nxc7gkfXbBLXxQe6D/DGZ2e1UVpmHTLw+EtycvGfGb
 gMxSsSbaL+3bf1cGIYLTJMnMDrLiZ6OH3UQSzZ89JKM3JOiPuVb/2oRFPl9KA2GIDbne
 3xqevLS7ciqzZn6vdVDoard9a17jLBujWKRCtbqoxGRq3AycOwU1+ZgjdfNn0iLFBtwN
 m1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721348977; x=1721953777;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3UdrveFfkoPjZqTrIu5NZhidMPt2ZUmMLu7/z/4vhog=;
 b=kN9rWo3/EqbW18LxGIwSK0q9EBaMgvPgewLoRL3EwC4bbjcRKOlSAIXc+pz0BwpiAP
 LaftGCDXVLrLHcOe0oBXS0u3Ck64++ei9mwUAjhrnkIdyiUVihH5i0UL6V70TUTOxGWG
 g7kkywXtWUkHEX5R8S9r3RS/ht0g510zLwNxUxkBSYiqqQNKtOd0YOLaaPeNqnWvDR8/
 hnxApAVwHcoF3L+SKTElud8Q4YubRcppVR/YB9ymTF3/tC/bBNgrW/ekd+R4MclTzCgd
 jNYRV1LSU3/SsqoF/Io3Y5eqCXX1CSgW5+OpGuKHKXdYGi/GkRR+SjP8HE9VgfXLZslp
 v7lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8giQvwUQlhhWTTen5DN3BzrUPgRCVBQD0NMlJPcshxdB19bOLPBPMmK7OgQPdNtZ377xm1wki3f8BPIlEJmwM5CJ8gB8=
X-Gm-Message-State: AOJu0Yw/us37D3aLo3L8rhToqENVpojc7NVBfdsw7Gbki1mOKEut2Na2
 WDHOpRKSXawWj4KY/7GZpGRS5UbIH0vh3V5X1+dt/MYIKvEYGthb
X-Google-Smtp-Source: AGHT+IH7NrVbbyQEKHNhPw7zAgf2cPyb9jchnelUXum2fFh/WcLXZbN4Ao4fu+xP6pnpQ3K2BWIMcA==
X-Received: by 2002:a17:903:40c3:b0:1f6:f298:e50 with SMTP id
 d9443c01a7336-1fc4e683945mr55438355ad.58.1721348976167; 
 Thu, 18 Jul 2024 17:29:36 -0700 (PDT)
Received: from amjad-pc ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d69e1asm1715195ad.282.2024.07.18.17.29.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Jul 2024 17:29:35 -0700 (PDT)
Date: Fri, 19 Jul 2024 08:29:33 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>, Hanna
 Reitz <hreitz@redhat.com>, =?utf-8?Q?open_list=3Avvfat?=
 <qemu-block@nongnu.org>
Message-ID: <117AB0D4-B3AC-4A8B-84AA-C4085A78B9FE@getmailspring.com>
In-Reply-To: <ZpmxMEj5qZDUhj_h@amjad-pc>
References: <ZpmxMEj5qZDUhj_h@amjad-pc>
Subject: Re: [PATCH v5 4/5] vvfat: Fix reading files with non-continuous
 clusters
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pl1-x62f.google.com
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



On Jul 19 2024, at 8:20 am, Amjad Alsharafi <amjadsharafi10@gmail.com> wrote:

> On Thu, Jul 18, 2024 at 05:20:36PM +0200, Kevin Wolf wrote:
>> Am 12.06.2024 um 14:43 hat Amjad Alsharafi geschrieben:
>> > When reading with `read_cluster` we get the `mapping` with
>> > `find_mapping_for_cluster` and then we call `open_file` for this
>> > mapping.
>> > The issue appear when its the same file, but a second cluster that is
>> > not immediately after it, imagine clusters `500 -> 503`, this will give
>> > us 2 mappings one has the range `500..501` and another `503..504`, both
>> > point to the same file, but different offsets.
>> > 
>> > When we don't open the file since the path is the same, we won't assign
>> > `s->current_mapping` and thus accessing way out of bound of the file.
>> > 
>> > From our example above, after `open_file` (that didn't open
>> anything) we
>> > will get the offset into the file with
>> > `s->cluster_size*(cluster_num-s->current_mapping->begin)`, which will
>> > give us `0x2000 * (504-500)`, which is out of bound for this
>> mapping and
>> > will produce some issues.
>> > 
>> > Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
>> > ---
>> >  block/vvfat.c | 23 ++++++++++++++++-------
>> >  1 file changed, 16 insertions(+), 7 deletions(-)
>> > 
>> > diff --git a/block/vvfat.c b/block/vvfat.c
>> > index b63ac5d045..fc570d0610 100644
>> > --- a/block/vvfat.c
>> > +++ b/block/vvfat.c
>> > @@ -1360,15 +1360,24 @@ static int open_file(BDRVVVFATState*
>> s,mapping_t* mapping)
>> >  {
>> >      if(!mapping)
>> >          return -1;
>> > +    int new_path = 1;
>> >      if(!s->current_mapping ||
>> > -            strcmp(s->current_mapping->path,mapping->path)) {
>> > -        /* open file */
>> > -        int fd = qemu_open_old(mapping->path,
>> > +            s->current_mapping->info.file.offset
>> > +                != mapping->info.file.offset ||
>> 
>> I'm wondering if this couldn't just be s->current_mapping != mapping?
> 
> Actually, you are totally right. Not sure what made me go for this.
> 
> I tried also to test with only checking if the path changed, but it
> fails on some tests. So the offset is important.
> For that reason, checking just the mapping ptr is better since we won't
> have 2 mappings with same file and offset.
> 
> I'll then use this change. Thanks

Should I send a new patch? since most commits are reviewed now

> 
>> 
>> > +            (new_path = strcmp(s->current_mapping->path,
>> mapping->path))) {
>> 
>> If both the path and the offset change, we still want to set
>> new_path, I
>> think. And if we didn't already have a mapping, we also need to open the
>> file.
>> 
>> Actually, setting a variable inside the condition makes it kind of hard
>> to read, so if s->current_mapping != mapping works, we can do the check
>> only in the conditon below:
>> 
>> > +        if (new_path) {
>> 
>> if (!s->current_mapping ||
>>     strcmp(s->current_mapping->path, mapping->path))
>> 
>> > +            /* open file */
>> > +            int fd = qemu_open_old(mapping->path,
>> >                                 O_RDONLY | O_BINARY | O_LARGEFILE);
>> > -        if(fd<0)
>> > -            return -1;
>> > -        vvfat_close_current_file(s);
>> > -        s->current_fd = fd;
>> > +            if (fd < 0) {
>> > +                return -1;
>> > +            }
>> > +            vvfat_close_current_file(s);
>> > +
>> > +            s->current_fd = fd;
>> > +        }
>> > +        assert(s->current_fd);
>> >          s->current_mapping = mapping;
>> >      }
>> 
>> Kevin
>> 
> 

