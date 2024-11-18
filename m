Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFE9D591AA
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5kC-00088J-DB; Mon, 18 Nov 2024 12:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tD5k8-00087C-U8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tD5k7-0005Xp-8U
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731951654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPebO9DOHT+/ZSSTHi4HkSIT8b97mrJIo/sLsV85sZ8=;
 b=Djxmbh7cjrhwHny2MsvSaFUiTiRp+0iwuYYveHcX3CdoYSi4rgiNrDCEvN4MsmQNjTQZVa
 wGIY9RAMtY73IWtQIXo4uhl/4DkdzVUr0jlJXhRNHT+dJdls4LGkSYWYF4IE7kN1QtRx31
 2bY+pMhvTSX+M79+8IwtXkvMcmgEfqQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-VbryvYnhOSay0IdW-sZi_A-1; Mon, 18 Nov 2024 12:40:52 -0500
X-MC-Unique: VbryvYnhOSay0IdW-sZi_A-1
X-Mimecast-MFC-AGG-ID: VbryvYnhOSay0IdW-sZi_A
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315dd8fe7fso22566245e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731951651; x=1732556451;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UPebO9DOHT+/ZSSTHi4HkSIT8b97mrJIo/sLsV85sZ8=;
 b=I27WLMkY/VMd8U4ORgQECOYPR9VjdbtjoHP8/GRLYZaHo0cQxwwkV/mDCbn1GJEzPV
 WCS+1w0RZMg1RtdACWEhRfFTso+fGG5W35SoiRucNPRrKJ/g3TpoQKPtyz+Kr+0dPuKo
 hGmsd0QBcNVNh8mn0asdpgnjUk4oXQHpP2TIsdjrcHrxcO14t+fkpoIw/l3q4CLBmy4g
 AzZFyKki66nbJGcgYsy4nxis4dF2vkkPeK5SZL4L4CX8491tNqSQa8tgYfJRaYCxW3vA
 aoaFynKUNOlcRwls9kN0aw9TJVVQ17QrCye6Z4SCV1ZM50JYrT/Qn38N04jSGyutGVuy
 YLzw==
X-Gm-Message-State: AOJu0YxwpgXPu+61F0Uki1IKGG/+SEoukvi+vF/BnGKQmnKOqVFoum3A
 Onu01RdHv7RXkOQij+jrKcrsd4NcbjiOXZ+cqzA4fP3VBxKJf+LLaQrFZ+cofxgHtTTE29p+XiM
 XksSHBnEd0yvMwkpe1T2QJ+7qYIlXISdhQWb3foh/+11DE2TUZ+co
X-Received: by 2002:a05:600c:5013:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-432df793ce7mr124788275e9.32.1731951651063; 
 Mon, 18 Nov 2024 09:40:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7GCvudkuP1haz122ydvMsndq4KxuYJ3F5hM/sh9uLdRiGfO0/MG46r8YMoIcyMYF2t5maiQ==
X-Received: by 2002:a05:600c:5013:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-432df793ce7mr124788075e9.32.1731951650724; 
 Mon, 18 Nov 2024 09:40:50 -0800 (PST)
Received: from fedora ([85.119.46.36]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab788a2sm161789735e9.11.2024.11.18.09.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 09:40:50 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2] vpc: Read images exported from Azure correctly
In-Reply-To: <itnfgqpjggu6jlkhaci32wz3d35o4wvwkbyys5j5qwsxumnjya@2zsfsx4rt2fe>
References: <20241118143646.33377-1-vkuznets@redhat.com>
 <itnfgqpjggu6jlkhaci32wz3d35o4wvwkbyys5j5qwsxumnjya@2zsfsx4rt2fe>
Date: Mon, 18 Nov 2024 18:40:48 +0100
Message-ID: <877c90qw2n.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Mon, Nov 18, 2024 at 03:36:46PM +0100, Vitaly Kuznetsov wrote:
>> It was found that 'qemu-nbd' is not able to work with some disk images
>> exported from Azure. Looking at the 512b footer (which contains VPC
>> metadata):
>> 
>> 00000000  63 6f 6e 65 63 74 69 78  00 00 00 02 00 01 00 00  |conectix........|
>> 00000010  ff ff ff ff ff ff ff ff  2e c7 9b 96 77 61 00 00  |............wa..|
>> 00000020  00 07 00 00 57 69 32 6b  00 00 00 01 40 00 00 00  |....Wi2k....@...|
>> 00000030  00 00 00 01 40 00 00 00  28 a2 10 3f 00 00 00 02  |....@...(..?....|
>> 00000040  ff ff e7 47 8c 54 df 94  bd 35 71 4c 94 5f e5 44  |...G.T...5qL._.D|
>> 00000050  44 53 92 1a 00 00 00 00  00 00 00 00 00 00 00 00  |DS..............|
>> 00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>> 
>> we can see that Azure uses a different 'Creator application' --
>> 'wa\0\0' (offset 0x1c, likely reads as 'Windows Azure') and QEMU uses this
>> field to determine how it can get image size. Apparently, Azure uses 'new'
>> method, just like Hyper-V.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> Alternatively, we can probably make 'current_size' the default and only use
>> CHS for 'vpc '/'qemu'.
>> ---
>>  block/vpc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/block/vpc.c b/block/vpc.c
>> index d95a204612b7..b67798697c15 100644
>> --- a/block/vpc.c
>> +++ b/block/vpc.c
>> @@ -321,6 +321,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>>       *      'qemu'  :  CHS              QEMU (uses disk geometry)
>>       *      'qem2'  :  current_size     QEMU (uses current_size)
>>       *      'win '  :  current_size     Hyper-V
>> +     *      'wa\0\0':  current_size     Azure
>>       *      'd2v '  :  current_size     Disk2vhd
>>       *      'tap\0' :  current_size     XenServer
>>       *      'CTXS'  :  current_size     XenConverter
>> @@ -330,6 +331,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>>       *  that have CHS geometry of the maximum size.
>>       */
>>      use_chs = (!!strncmp(footer->creator_app, "win ", 4) &&
>> +               !!memcmp(footer->creator_app, "wa\0", 4) &&
>
> While this is literally correct (a string literal with 3 characters
> spelled out includes the implicit NUL byte; sizeof("wa\0") == 4), it
> is a bit odd to see a memcmp() of 4 bytes against a literal containing
> only 3 characters, especially when the comments above spelled it out
> with four characters.  For the sake of avoiding further confusion, it
> might be nice to use memcmp() against explicit 4-byte patterns for all
> of the strings (not just the Azure witness).

Yea, it's just that we already have

    !!memcmp(footer->creator_app, "tap", 4))

down below so I decided to stick to the style :-)

>
>>                 !!strncmp(footer->creator_app, "qem2", 4) &&
>>                 !!strncmp(footer->creator_app, "d2v ", 4) &&
>>                 !!strncmp(footer->creator_app, "CTXS", 4) &&
>
> I also don't know if it would be any easier to read by creating a
> `static const char table[][4] = { "qemu", "qem2", "wa", ...}` (where
> you don't have to write any explicit \0, because the compiler is
> guaranteed to NUL-pad short strings into the char[4] table entry) and
> then write a loop over each entry in the table, rather than having to
> spell out a separate strncmp/memcmp line for each string in the table.

I like the idea but I'm still trying to understand whether we need to
keep adding new entries there or just flip the default and say that only
'vpc ' and 'qemu' are legacy and deserve CHS.

-- 
Vitaly


