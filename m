Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF80C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gjf-0002F5-Qq; Fri, 04 Apr 2025 09:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0gjZ-0002Ar-RI
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0gjX-0003l9-Gn
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743771903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4jQZLN18CiAvOXa3JKAm5xYViLMgAYKDp0GBZRLJRXg=;
 b=igHpzLoXgr8z4PJx59SUHjb0yj9gsnspz5TLCpMjujjvwuDapewL+lBNlBgKYa0Jr3sW3R
 x7lI/dzuyq4vNfFThmu/55sbkKHN3GhxDwHfIz5jpwM2m7qYwtZXwkHou5Oo0lz/bz4p0P
 uuRU0G8w6JUg2aOAUYzyDoFKDqC6u1w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-DgO-osNFN82uBCY65C_ClQ-1; Fri, 04 Apr 2025 09:05:02 -0400
X-MC-Unique: DgO-osNFN82uBCY65C_ClQ-1
X-Mimecast-MFC-AGG-ID: DgO-osNFN82uBCY65C_ClQ_1743771901
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131851046so1004716f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743771901; x=1744376701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4jQZLN18CiAvOXa3JKAm5xYViLMgAYKDp0GBZRLJRXg=;
 b=UriU3e8kqMfhiEs2Zi2QOPwBOSf5HM9E1BJTcHTSc82j7OY+Whejw548Hx+xXXZszv
 im20TUq0pw3947Yuho2xKB39NhOBXa7WlnyEZpIRB7gBNA9o8oNWu0ACAQCumur27MLP
 2bqKdHgx548rj4L3klCzGfEXwHfSmMuS7lSFiytnWBLL4/2rEBZujsdfBoij3k+3fP0X
 1Y84xqrUuVHan5+mHJYc2Xk9lNbzlMtzDdBg5pcvWqqT6WTJ0qBh8Onzv7CyCD8cSGYp
 0QAj3ZBxVaI7dQDjWB2PjtLkdaZm675TJ6thQIxiCnYLEQzj3ywRDDrW1hZ4Fp0iCOip
 q8zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrjkTWhnJK8uR2CqZPPFmbYHSR6BoNwbLincPrCy3gADfNo9y3Gp4T8dGZdccb4Yvg62XksFtepllN@nongnu.org
X-Gm-Message-State: AOJu0YyhtoZvGRp2TSzuGHpeYYW7JrooDP7nvJbe8dkR0ictvoT7NudX
 6P/JXpZmyBBeFcBe1ePDmwo8/axtKe2XF69N8vbzhJ2AOGfp1Wf5O2FDZfGCoekonOzsSEnoTYZ
 tN24i6aTQj0hdVbB2JGjXvR8fZ7N9ebn/QbiXg1dskQ8qi6aM46qh
X-Gm-Gg: ASbGncsNXMmcBoDGTdx82yj/isztn7yuWZcDoIbzjVMdd1QyCZ8T9unkg3AQoT8ELvd
 9mHV1DaY5JDqCzrN/7KAsknaGtAWuhVEUtumf5idQdl94gCYGyGJLzi3QwN7bMngoqK66UK3kQV
 xZcYCYiAppLCRJrOEum3+MeGyo0X0lA7TGcHJ8YtoVHSVfeexFxTe8XU+j2k9eTD+ybnLn9zIT4
 +KEKBuUO5c+4YMb57vwSaY+Twd9h5lGv75Lci1P17kmWPNDNetgbwp1SAWoMsasFSVLumpxDI9K
 QgNfl0bQc17C4oeEpGnrlkPwODHia05nfwAfPspG0mqKvmbIyw8E50kpMwhjYtrUfOdj12khyi0
 oN0RFe0iGz1VJRsGv8MhiMJfQqzfrV6+vbwr5LeDMq6NR
X-Received: by 2002:a05:6000:186f:b0:39c:266c:136d with SMTP id
 ffacd0b85a97d-39d07bcce91mr2526088f8f.12.1743771900316; 
 Fri, 04 Apr 2025 06:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkEVePEhxKHrk6b48yj87syspZVmKQmkRXsRRje7Hci6Xp7UhvX1cSbkDJH2H0QgjmDwlmkg==
X-Received: by 2002:a05:6000:186f:b0:39c:266c:136d with SMTP id
 ffacd0b85a97d-39d07bcce91mr2526023f8f.12.1743771899796; 
 Fri, 04 Apr 2025 06:04:59 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096bb2sm4370930f8f.12.2025.04.04.06.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 06:04:59 -0700 (PDT)
Message-ID: <0e51c2e8-f15a-4a4d-9a42-52e8475662c8@redhat.com>
Date: Fri, 4 Apr 2025 15:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] fuse: Increase MAX_WRITE_SIZE with a second buffer
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-14-hreitz@redhat.com>
 <w3zwzqyhnkkoayjsfj3ozfmipsynwdevl5my4ra4g7gxqlbeni@lesuztmxb5bc>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <w3zwzqyhnkkoayjsfj3ozfmipsynwdevl5my4ra4g7gxqlbeni@lesuztmxb5bc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 01.04.25 22:24, Eric Blake wrote:
> On Tue, Mar 25, 2025 at 05:06:55PM +0100, Hanna Czenczek wrote:
>> We probably want to support larger write sizes than just 4k; 64k seems
>> nice.  However, we cannot read partial requests from the FUSE FD, we
>> always have to read requests in full; so our read buffer must be large
>> enough to accommodate potential 64k writes if we want to support that.
>>
>> Always allocating FuseRequest objects with 64k buffers in them seems
>> wasteful, though.  But we can get around the issue by splitting the
>> buffer into two and using readv(): One part will hold all normal (up to
>> 4k) write requests and all other requests, and a second part (the
>> "spill-over buffer") will be used only for larger write requests.  Each
>> FuseQueue has its own spill-over buffer, and only if we find it used
>> when reading a request will we move its ownership into the FuseRequest
>> object and allocate a new spill-over buffer for the queue.
>>
>> This way, we get to support "large" write sizes without having to
>> allocate big buffers when they aren't used.
>>
>> Also, this even reduces the size of the FuseRequest objects because the
>> read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
>> the requests we support are not quite so large (except for >4k writes),
>> so until now, we basically had to have useless padding in there.
>>
>> With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
>> is easily met and we can decrease the size of the buffer portion that is
>> right inside of FuseRequest.
>>
>> As for benchmarks, the benefit of this patch can be shown easily by
>> writing a 4G image (with qemu-img convert) to a FUSE export:
>> - Before this patch: Takes 25.6 s (14.4 s with -t none)
>> - After this patch: Takes 4.5 s (5.5 s with -t none)
> Hmm - 64k is still small for some tasks; with qcow2, you can have
> clusters up to 2M, and writing a cluster at a time seems to be a
> reasonable desire.

What do you mean specifically?  Do you think it’s reasonable from a 
performance point of view, or for potential atomicity, or...?

> Or in other storage areas, nbdcopy (from libnbd)
> defaults to 256k and allows up to 32M, or we can even look at lvm that
> defaults to extent size of 4M (although with lvm thin volumes,
> behavior is more like qcow2 with subclusters in that you don't have to
> allocate the entire extent at once).

The problem I see is that other back-ends can probably read the request 
header, figure out how much memory they need, and allocate the buffer.  
That doesn’t work with FUSE, you got to read the whole request at once.

> Maybe it makes sense to have this as a hierarchichal spillover (first
> level spills over to 64k, second level spills over to 2M or whatever
> ACTUAL maximum you are willing to support)?

Sounds quite complicated, so the question is what we’d want this for, 
whether it’d be worth it.

I also wonder whether rate-limiting should come into play at some 
point.  FUSE doesn’t require network, so a user could submit the same 2M 
buffer many times, and thus, without itself having to allocate a lot of 
memory, cause big memory allocations in qemu(-storage-daemon)...

>
> Or you can feel free to ignore my comments on this patch - allowing
> 64k instead of 4k is ALREADY a nice change.
>
>> @@ -501,7 +547,20 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
>>           goto no_request;
>>       }
>>   
>> -    ret = RETRY_ON_EINTR(read(fuse_fd, q->request_buf, sizeof(q->request_buf)));
>> +    /*
>> +     * If handling the last request consumed the spill-over buffer, allocate a
>> +     * new one.  Align it to the block device's alignment, which admittedly is
>> +     * only useful if FUSE_IN_PLACE_WRITE_BYTES is aligned, too.
> What are typical block device minimum alignments?  If 4k is typical,
> then it should be easy to make FUSE_IN_PLACE_WRITE_BYTES be 4k.

Yes, but no.  We’d have to allocate request_buf such that for WRITE 
requests, the data in it would be aligned, i.e. after the header. We 
cannot split it (one part for the FUSE headers, one part for the data), 
because that might break up non-WRITE requests, which would make them 
hard to handle.

Locally, I have a version of this series that does introduce a function 
to allow allocating buffers such that an offset within them is aligned; 
but in the end I didn’t see much of a performance difference, so I 
decided to send this simpler version instead.

Hanna

> If
> 64k is typical, we're already doomed at being aligned.  Is being
> unaligned going to cause the block layer to add bounce buffers on us,
> if the block layer has a larger alignment than what we use here?
>
>> @@ -915,17 +983,25 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
>>   }
>>   
>>   /**
>> - * Handle client writes to the exported image.  @buf has the data to be written
>> - * and will be copied to a bounce buffer before yielding for the first time.
>> + * Handle client writes to the exported image.  @in_place_buf has the first
>> + * FUSE_IN_PLACE_WRITE_BYTES bytes of the data to be written, @spillover_buf
>> + * contains the rest (if any; NULL otherwise).
>> + * Data in @in_place_buf is assumed to be overwritten after yielding, so will
>> + * be copied to a bounce buffer beforehand.  @spillover_buf in contrast is
>> + * assumed to be exclusively owned and will be used as-is.
> Makes sense, although it leads to some interesting bookkeeping.  (I'm
> wondering if nbd would benefit from this split-level buffering, since
> it supports reads and writes up to 32M)
>


