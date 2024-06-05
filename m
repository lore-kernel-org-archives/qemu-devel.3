Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16572C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 12:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEpWf-0007Gg-L3; Wed, 05 Jun 2024 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEpWd-0007GP-Pz
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEpWb-00073L-Li
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717589632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BtdD/GYeOJ96GWTzwwqL7eQrUG0RZ+oWyDBa6ePqoIE=;
 b=FucqGwOGDeQfD4+pUxEZwTdSDTV+BF98q2dHqih13+mEUGilm3D0cx1/cyaZrWuzR4iKpJ
 bVxy+Mxl0cpQvEqRQ4GzFFQMCn+1u6pRHJEo2LQzCWQAlxdtztHLl1yOgJzTBTBcttc9fz
 LE8ketH4NUJB+0D//eQuZ5lXyv2mFMI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193--ReUBx3PPCKUmd3UU-WmFw-1; Wed, 05 Jun 2024 08:13:51 -0400
X-MC-Unique: -ReUBx3PPCKUmd3UU-WmFw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4212a4bb9d7so52682055e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 05:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717589630; x=1718194430;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BtdD/GYeOJ96GWTzwwqL7eQrUG0RZ+oWyDBa6ePqoIE=;
 b=nLUmYEjqeHJYz/wHetVro17ulH3n86sYGDZ7yt8eJqGbeRE0dZXYe+9MCamyMIONGa
 BnXk6puUljHXevYZxiYYDbVlnrysPGE4+uU1UpCvP8kd2U/TQ6RhsGQ9ckf2q5TwkWAt
 ctKnfEM39WZPZDnh28GAhQShKcw/8QyO150QFOhXeedLStWTio0F/4Ni8/VBB16s0D1Z
 fVICPTSHEaPZqinNcq5U25vKF52tQQHlq7s5lAfMnPLH/kKWnnTdZC93i9t/legOmP3n
 dh9PTnLT96XJ2KdghJlYvMKOFjZ+PFkJXyWdA0LSyUjzgLeaURSZYPGp/DIwWkZGbzkA
 9i3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHXyvKC2PFg64GUpoE/TzGbo4rCOBEmItigx9igij3KRZ6yIXAKpIkI02UUfsajgehA3CP0yfEC8knSV+j/N6EYQrTeQ0=
X-Gm-Message-State: AOJu0Yy6Ia1JFMBJQbmroBcOfxlx1uDdcXtzEEEVI+YbPBwM0GnjRvVM
 LtDYESu7XQ4nXc6B9ks+W7YtnlXkBUBecY7DBdlnHvYaeD+MI5BCZFo782HWvmGiYjoNHi3u5hb
 SxF8e1aq2DaZSHk1qgULm5jQFZHlZ1VNJMi8Ljql7T7Xw8UhmqtyT
X-Received: by 2002:adf:f58a:0:b0:35e:f0e:1ba0 with SMTP id
 ffacd0b85a97d-35e8ef07ccamr1886373f8f.19.1717589630339; 
 Wed, 05 Jun 2024 05:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZf7ekgP38xc+IupRJ/jlBPKKOqdcka98i5XWyqDFG1H2FTmC6cf4pn7T4/y/iOwX+4gA3dQ==
X-Received: by 2002:adf:f58a:0:b0:35e:f0e:1ba0 with SMTP id
 ffacd0b85a97d-35e8ef07ccamr1886353f8f.19.1717589629964; 
 Wed, 05 Jun 2024 05:13:49 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bba6sm14347863f8f.104.2024.06.05.05.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 05:13:49 -0700 (PDT)
Message-ID: <791e54a9-8426-43aa-a1cc-9d711504ebd0@redhat.com>
Date: Wed, 5 Jun 2024 14:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] s390x: Add boot device fallback infrastructure
From: Thomas Huth <thuth@redhat.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-5-jrossi@linux.ibm.com>
 <86ad1f68-a67e-4c30-9e65-cad8c607352d@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <86ad1f68-a67e-4c30-9e65-cad8c607352d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 05/06/2024 10.20, Thomas Huth wrote:
> On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Add a routine for loading the next IPLB if a device fails to boot.
>>
>> This includes some minor changes to the List-Directed IPL routine so that the
>> failing device may be retried using the legacy boot pointers before moving 
>> on to
>> the next device.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
> ...
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index a2137449dc..69391557fa 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -144,7 +144,10 @@ static block_number_t 
>> load_eckd_segments(block_number_t blk, bool ldipl,
>>       bool more_data;
>>       memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
>> -    read_block(blk, bprs, "BPRS read failed");
>> +    if (!read_block_nonfatal(blk, bprs)) {
>> +        IPL_assert(ldipl, "BPRS read failed");
>> +        return -1;
>> +    }
>>       do {
>>           more_data = false;
>> @@ -188,7 +191,10 @@ static block_number_t 
>> load_eckd_segments(block_number_t blk, bool ldipl,
>>                    * I.e. the next ptr must point to the unused memory area
>>                    */
>>                   memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
>> -                read_block(block_nr, bprs, "BPRS continuation read failed");
>> +                if (!read_block_nonfatal(block_nr, bprs)) {
>> +                    IPL_assert(ldipl, "BPRS continuation read failed");
>> +                    break;
>> +                }
>>                   more_data = true;
>>                   break;
>>               }
>> @@ -197,7 +203,10 @@ static block_number_t 
>> load_eckd_segments(block_number_t blk, bool ldipl,
>>                * to memory (address).
>>                */
>>               rc = virtio_read_many(block_nr, (void *)(*address), count + 1);
>> -            IPL_assert(rc == 0, "code chunk read failed");
>> +            if (rc != 0) {
>> +                IPL_assert(ldipl, "code chunk read failed");
>> +                break;
>> +            }
>>               *address += (count + 1) * virtio_get_block_size();
>>           }
>> @@ -295,13 +304,22 @@ static void run_eckd_boot_script(block_number_t 
>> bmt_block_nr,
>>                  " maximum number of boot entries allowed");
>>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>> -    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
>> +    if (!read_block_nonfatal(bmt_block_nr, sec)) {
>> +        IPL_assert(ldipl, "Cannot read Boot Map Table");
>> +        return;
>> +    }
>>       block_nr = gen_eckd_block_num(&bmt->entry[loadparm].xeckd, ldipl);
>> -    IPL_assert(block_nr != -1, "Cannot find Boot Map Table Entry");
>> +    if (block_nr == -1) {
>> +        IPL_assert(ldipl, "Cannot find Boot Map Table Entry");
>> +        return;
>> +    }
>>       memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>> -    read_block(block_nr, sec, "Cannot read Boot Map Script");
>> +    if (!read_block_nonfatal(block_nr, sec)) {
>> +        IPL_assert(ldipl, "Cannot read Boot Map Script");
>> +        return;
>> +    }
>>       for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
>>                   bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
>> @@ -319,13 +337,10 @@ static void run_eckd_boot_script(block_number_t 
>> bmt_block_nr,
>>           } while (block_nr != -1);
>>       }
>> -    if (ldipl && bms->entry[i].type != BOOT_SCRIPT_EXEC) {
>> -        /* Abort LD-IPL and retry as CCW-IPL */
>> +    if (bms->entry[i].type != BOOT_SCRIPT_EXEC) {
>> +        IPL_assert(ldipl, "Unknown script entry type");
>>           return;
>>       }
>> -
>> -    IPL_assert(bms->entry[i].type == BOOT_SCRIPT_EXEC,
>> -               "Unknown script entry type");
>>       write_reset_psw(bms->entry[i].address.load_address); /* no return */
>>       jump_to_IPL_code(0); /* no return */
>>   }
>> @@ -492,7 +507,7 @@ static void ipl_eckd(void)
>>               /* LD-IPL does not use the S1B bock, just make it NULL */
>>               run_eckd_boot_script(ldipl_bmt, NULL_BLOCK_NR);
>>               /* Only return in error, retry as CCW-IPL */
>> -            sclp_print("Retrying IPL ");
>> +            sclp_print("LD-IPL failed, retrying device\n");
>>               print_eckd_msg();
>>           }
>>           memset(sec, FREE_SPACE_FILLER, sizeof(sec));
>> @@ -944,5 +959,5 @@ void zipl_load(void)
>>           panic("\n! Unknown IPL device type !\n");
>>       }
>> -    sclp_print("zIPL load failed.\n");
>> +    panic("zIPL load failed.\n");
> 
> Why replacing the sclp_print() here? Wouldn't it be nicer to continue 
> panicking on the calling site instead?

Ok, after looking at the 5th patch, I think I understand it now: panic() is 
not fatal anymore and might restart with the next boot device... not sure 
whether I like that, but let's discuss that on patch 5 instead...

  Thomas


