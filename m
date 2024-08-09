Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01CCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 04:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scHLV-00086E-RH; Fri, 09 Aug 2024 00:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1scHLT-0007y9-P6; Fri, 09 Aug 2024 00:35:20 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1scHLS-00057D-33; Fri, 09 Aug 2024 00:35:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so1395993b3a.1; 
 Thu, 08 Aug 2024 21:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723178116; x=1723782916; darn=nongnu.org;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7+4eLiWAAn14YgZ1Gl6AE7pfREKF/ytxZyOaRYYe2g=;
 b=f5Xq0/uekIwajLkAV+J5sCL7/uO9v89RoAADkNJ5Yk6i1c63+gMeEOZ+i2LfABsSZD
 X/K1g6KL+QCFHh/KjIcNz21AYj+yUSETSjkbdAevmzABpTC0NQQtKNcngiEorlm5CAAr
 rcEn2BNEOBzotU9b75w4vIsjjtvLk6T9WZX0XDP1OCuwU/2aZt7qT3QsU8q358WpS6s1
 MyYs1Qx+JMFWr+2lL2qziJnKH2vXtgP3rwyW7XldzclzwchdneyMJ11KWDqXuD6Yrl7i
 Z1yc7a6Om5TYNev0a7m7c+nDSMZQGg5gWk+UChNs4fLmSBxFVRq0ymy1L9TDLGLObKn2
 e6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723178116; x=1723782916;
 h=content-disposition:content-transfer-encoding:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7+4eLiWAAn14YgZ1Gl6AE7pfREKF/ytxZyOaRYYe2g=;
 b=RZn9l6xzVeqmgxtJ4ocdKMa3I1hKlH5BQN4HIcjdiR6xBZgLozFMJ+RXwOxnANztfb
 z7GczjJCcDLyI1E7GSkpP1GDufq2fdx1E3tsf6S1jS3yFmxRfnZzECWn9KNyxxklYOJV
 QUNV0/kcNvRqpTutT8RqdDtxAFxgCiX3CI7+W4ccVwwZ6eXpkjRelk2u9KxWIShbv89g
 t9bUpFpnGyaLIG7konLzlfZSFgOv/sz97m21yZj/gnlIJzRCiC6FQwjjjjIJxJbhQjE8
 +Pb+arGv/uvGSuwAhTvI8i2NNdNrgUM+OTUFuCDDx2u/Tg2l1asM8rQ23/O4xN0CQ2dE
 MQZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtITpZUMPwL4Hy0F4kmupXBzO5tVqzxevB+idfXALxfscDSUiQriRzn0+nEShgLvjHj7LnaKiMCoC6YXOQU9Tl62wGjTo=
X-Gm-Message-State: AOJu0YwKwAlU8Jc+vkwsc18W+lh1pm8zHHyinJQAeen/DwSjBt8KIdLB
 3jKyEms4+P/nYgSzG3NjY/fxzbrgvZXjHSRAxQ46InZVUSTZQ3WolfE61Ts3IDE=
X-Google-Smtp-Source: AGHT+IHG4IEboBh8Iq7niEJPBY+6h4Cn4hd7qXp4gQ8CBkVvgFi7ugICVZBYacjsf8Z6/Kw050t6mw==
X-Received: by 2002:a05:6a21:6704:b0:1c4:985a:acc4 with SMTP id
 adf61e73a8af0-1c8a00e322emr567417637.46.1723178115494; 
 Thu, 08 Aug 2024 21:35:15 -0700 (PDT)
Received: from amjad-pc ([192.228.221.130]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b3fb1sm132392875ad.288.2024.08.08.21.35.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Aug 2024 21:35:15 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:35:12 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>, Hanna
 Reitz <hreitz@redhat.com>, =?utf-8?Q?open_list=3Avvfat?=
 <qemu-block@nongnu.org>
Message-ID: <C49DCC19-6844-4398-A934-9FE5C6DCE1FB@getmailspring.com>
In-Reply-To: <ZrCn1Sn64slzK4-m@redhat.com>
References: <ZrCn1Sn64slzK4-m@redhat.com>
Subject: Re: [PATCH v6 4/5] vvfat: Fix reading files with non-continuous
 clusters
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pf1-x435.google.com
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



On Aug 5 2024, at 6:22 pm, Kevin Wolf <kwolf@redhat.com> wrote:

> Am 20.07.2024 um 12:13 hat Amjad Alsharafi geschrieben:
>> When reading with `read_cluster` we get the `mapping` with
>> `find_mapping_for_cluster` and then we call `open_file` for this
>> mapping.
>> The issue appear when its the same file, but a second cluster that is
>> not immediately after it, imagine clusters `500 -> 503`, this will give
>> us 2 mappings one has the range `500..501` and another `503..504`, both
>> point to the same file, but different offsets.
>> 
>> When we don't open the file since the path is the same, we won't assign
>> `s->current_mapping` and thus accessing way out of bound of the file.
>> 
>> From our example above, after `open_file` (that didn't open anything) we
>> will get the offset into the file with
>> `s->cluster_size*(cluster_num-s->current_mapping->begin)`, which will
>> give us `0x2000 * (504-500)`, which is out of bound for this mapping and
>> will produce some issues.
>> 
>> Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
>> ---
>>  block/vvfat.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index b63ac5d045..d2b879705e 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -1360,15 +1360,17 @@ static int open_file(BDRVVVFATState*
>> s,mapping_t* mapping)
>>  {
>>      if(!mapping)
>>          return -1;
>> -    if(!s->current_mapping ||
>> -            strcmp(s->current_mapping->path,mapping->path)) {
>> +    if (s->current_mapping != mapping) {
>>          /* open file */
>>          int fd = qemu_open_old(mapping->path,
>> -                               O_RDONLY | O_BINARY | O_LARGEFILE);
>> -        if(fd<0)
>> +                            O_RDONLY | O_BINARY | O_LARGEFILE);
>> +        if (fd < 0) {
>>              return -1;
>> +        }
>>          vvfat_close_current_file(s);
>> +
>>          s->current_fd = fd;
>> +        assert(s->current_fd);
>>          s->current_mapping = mapping;
>>      }
>>      return 0;
> 
> Now we're reopening the file even if the mapping is actually referring
> to the same file that was already open. So the result should be correct,
> but wasteful in what is probably a common case.
> 
> However, this version of the patch simplified things enough that I think
> I finally see what we really want:
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index e3a83fbc88..8ffe8b3b9b 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1369,8 +1369,9 @@ static int open_file(BDRVVVFATState*
> s,mapping_t* mapping)
>             return -1;
>         vvfat_close_current_file(s);
>         s->current_fd = fd;
> -        s->current_mapping = mapping;
>     }
> +
> +    s->current_mapping = mapping;
>     return 0;
> }

Ah, that indeed fixes it with such a simple change haha.

> 
> That should be all that is needed, and it passes your test case.
> 
> I don't usually do this, but since time is running out for QEMU 9.1,
> I'll just replace the code of this patch with the above and go ahead
> with that. If you think it's wrong, let me know and we'll fix it on top
> of this series.
> 
> Kevin
> 
> 

Thanks for that, and for publishing this. Looks good.

Amjad

