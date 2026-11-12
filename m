Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDD606A32E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CtbqgBav;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bu6zhZMn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRW6T-0004qU-Cq; Thu, 12 Nov 2026 09:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xRW62-0004lA-RG
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xRW60-0005lp-Jx
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794494891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kVFg1wJnXeJYs/OADxMjPV1R6VPneTbOhMOqPW5i2hg=;
 b=CtbqgBavgoHRdEF19yDhVnlGbvwPil4yQmps0YRkAjo6RO4Hp/3OeC/0CMBs0qkjnKpKnD
 6jTx08ij06AYLzll7p4nxnh4Z/vKzZi9M6+iWZcr44j1bHf3Xv61sqcEyAmOM3yWuXiff6
 zbZPph85Q9k62DTtNXlDzB5KAK1moGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-6cUSEG0dNdmEmxPWHbPq5A-1; Thu, 12 Nov 2026 09:48:09 -0500
X-MC-Unique: 6cUSEG0dNdmEmxPWHbPq5A-1
X-Mimecast-MFC-AGG-ID: 6cUSEG0dNdmEmxPWHbPq5A_1794494889
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso25643915e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794494888; x=1795099688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kVFg1wJnXeJYs/OADxMjPV1R6VPneTbOhMOqPW5i2hg=;
 b=Bu6zhZMnU3naHB+9SDcK4Sy8Fh193pdmx+tBOpUNzDtMJ4JjHMsNlqgRuBXrV17Ewn
 RsEit5/P2Q3kdG8+GJzUYpegdNHAILGuC8OcGtizIX1f42cmxrXvkz95ecTShRe5iGup
 T4ar9iTlxepHHKkxwt+T/ID11R8LxDcq+wqtJ85CUnkVlALpkhWjg4EMyCtPOuA/ofeR
 KKAILSPOOJh9DjBCrRVEoVNipN8H1Fp4QSeywPFcvmlxggsulh9832EwoUlZCDtEnGc7
 Cv56terqOy1oGLo8069ZJOInKhI30oCQARr5b5Qdn3E+Wcy4y7yUUgI2joyN9w4qSLSt
 T+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494888; x=1795099688;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kVFg1wJnXeJYs/OADxMjPV1R6VPneTbOhMOqPW5i2hg=;
 b=d2bTPe8P9R6Yx4qk3OFB/lZivfMRT+eWgu4XA2iRBSyG1MKGuTaIDfpOMNJ3jfkBUQ
 vK3cMPeJ9P1b7ZQnN1+z1d5EJHVqmN/HOsLagIjJQb5B7V9jQVZHO6CSlTRHmOzh1wXV
 KGvWMjkxPEYBbjwHyV2we2xgZD4E7rRJx1kDEv5lOv0KwZZPzvIXjIZzbYA7ENEe+jQB
 d0dYcCEm1WDlzu/msh67YiDafpaYiAyPSCxyjLGMhhwHSTi5M3ily0utmo34xFFMDxIq
 /GB/JS40K8Gk15rY9UbMroVL+9phuwHB5dlSDNPn/SbxZb9Go2lnh+JvdktgRwP4fb9D
 kcHw==
X-Gm-Message-State: APuU4Z+LvqPae31LETSloeY8rQb4Yiejn39yjWBSlstGD92w7Xf03eKU
 xkeQ5opUR02Y71FgvGXkI0h6Apjzl4EZJ+6iBJg6l1mEh/VDu/BGHdszrPtV5f6xsA8GgAGNxoY
 R62pqw7OOdv/CRmZfMnUgfBNfL3EIIG0Ktt09okpmp6Iw1cw+rcXWcF+x
X-Gm-Gg: AYBFou0mKQ9NgpHlF7KWcm2jUMFAueuTYUwSj9cBOsi7UvThDdTdu22SEIJxYwoV7jU
 5SHIpSCxPl0U1MD3L1BjkmOe83FKi8WvCQr5UrJunrrC2M56+ntZaAH0NzNKT6NURrauCL5pfpn
 g5A+Y9dJdodW/O+FAs/pskALdPBxhuX0S4llzQBy5jiNxKcr5OvQhs9LF37Zy+fdtggJXlE8KXc
 7owvHyyk0xT3qxAYwZJXO636wFPsfm2kL39yQ+/o/THlTo9PBSSwkvMOcIoProhgGOnEKjYcOfJ
 C3iXrt0pPC5YnZrm2hxtTMW8ZacV3TFxHcArA8sQwOog3g6TtykL1sadsb0lwu1hu9b638ygz3h
 LuU5ZpVojOUlzv3BCqI5ddy92T6P1kg==
X-Received: by 2002:a05:600d:84ca:20b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4ba493b3412mr65614695e9.9.1794494888591; 
 Thu, 12 Nov 2026 06:48:08 -0800 (PST)
X-Received: by 2002:a05:600d:84ca:20b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4ba493b3412mr65614395e9.9.1794494888184; 
 Thu, 12 Nov 2026 06:48:08 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983600bc9asm15991724f8f.29.2026.11.12.06.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 06:48:05 -0800 (PST)
Message-ID: <f9993d4e-eb21-413f-b2da-9b9f3052bfab@redhat.com>
Date: Thu, 12 Nov 2026 15:48:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/vhdx: Add alignment checks for region tables
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>
References: <20261112092201.74651-1-thuth@redhat.com>
 <avW12msUi9dongBJ@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <avW12msUi9dongBJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 12.11.26 um 13:49 schrieb Kevin Wolf:
> Am 12.11.2026 um 10:22 hat Thomas Huth geschrieben:
>> According to the VHDX specification:
>>
>>   "The FileOffset and Length fields specify the 64-bit byte offset and 32-bit
>>    byte length of the object within the file. The values must be a multiple of
>>    1 MB, and FileOffset must be at least 1 MB."
> 
> This requires that the offset (not length) is at least 1 MB...
> 
>> Thus let's add a sanity check to avoid that bad things could happen later.
>>
>> Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
>> Reported-by: Daniel Wade <danjwade95@gmail.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Use QEMU_IS_ALIGNED() as suggested by Eric
>>
>>   block/vhdx.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/block/vhdx.c b/block/vhdx.c
>> index 8013a90a1a4..21270988b5a 100644
>> --- a/block/vhdx.c
>> +++ b/block/vhdx.c
>> @@ -566,6 +566,16 @@ vhdx_open_region_tables(BlockDriverState *bs, BDRVVHDXState *s)
>>   
>>           vhdx_region_entry_le_import(&rt_entry);
>>   
>> +        /*
>> +         * According to the VHDX spec, offset and length must be multiple
>> +         * of 1 MiB and length must be at least 1 MiB.
>> +         */
>> +        if (!QEMU_IS_ALIGNED(rt_entry.file_offset, MiB) ||
>> +            !QEMU_IS_ALIGNED(rt_entry.length, MiB) || !rt_entry.length) {
> 
> ...but the comment and code do the opposite and check only that the
> length is at least 1 MB, leaving FileOffset (which was the actual
> requirement) unchecked.

D'oh, stupid me! I was apparently sloppy when reading the spec, sorry! 
(though a zero length likely also does not make much sense...)

>>
>> +            ret = -EINVAL;
>> +            goto fail;
>> +        }
>> +
>>           /* check for region overlap between these entries, and any
>>            * other memory regions in the file */
>>           ret = vhdx_region_check(s, rt_entry.file_offset, rt_entry.length);
> 
> I'm also wondering if the check shouldn't be in vhdx_region_check()
> instead, which we're already calling here.
I considered that, too, but finally decided against it since 
vhdx_region_check() seemed rather about overlapping regions... but if you 
prefer, I can also move it there.

  Thomas


