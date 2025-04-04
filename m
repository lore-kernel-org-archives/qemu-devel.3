Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EEFC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 11:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0f3H-0006G0-Ms; Fri, 04 Apr 2025 07:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0f3C-0006Ez-0N
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0f38-0005Fh-Gf
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743765444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJqLOwMqIcOXgULc4mZsm6AWXBnV4Zr7A2/PlAKloqo=;
 b=DO3PGX/CU6WRb8syPEBrLq6SiE8FHEsoeagzpYDDqNpSQ0FufXi4DNtNeBYg5WN+z8RyFO
 MKUbnnw2HARqNCdK9/iOiob684ccr65IKcKadA+0q7MDun47325+RzKf5Abew4fjJanF2m
 g6AbhBl4hJEJI76pouciveLue787snQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-ARX2ucHiM3qFEPRKAyoI3g-1; Fri, 04 Apr 2025 07:17:21 -0400
X-MC-Unique: ARX2ucHiM3qFEPRKAyoI3g-1
X-Mimecast-MFC-AGG-ID: ARX2ucHiM3qFEPRKAyoI3g_1743765440
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-391459c0395so915498f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 04:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743765440; x=1744370240;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bJqLOwMqIcOXgULc4mZsm6AWXBnV4Zr7A2/PlAKloqo=;
 b=jW4NSEKGL2x6SR0+PynkUOdpheEWBYZELzfUC67lm+4ysMnMeLJ13nIk2UHtazaghm
 3FOTbI0OoizbFC4y24I70fjo3KlqrCVfYhr3t2Cyw2XQWnBIYvS8APbXwSPaPiQfWcKj
 bzyVdWRMGB4+RWWLiJr9i2NgGm7mXXOqWDOkH2WSgMzmfOzLODKHeeZy1918NxT2vj4W
 YboKsrHvXAoCr1Q5+Pyt1/Sf320Ak5uDi/cdLDI82oNnLik8NKAuGPinJms9TvuGjN5k
 U/X9wDnBqP3xgJhnCBzae/GkVXtPLJ4nalPkjHuMVe79RgakX4/UDdrKtRJVNWvRmuQm
 4KfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPlObubpGdNFD8I4RC2pxZBwQchdmLqLRE5t3oNbs/G4U2rlZnIgqI5Hx0z0GBd2ybY/RPnCYxBL/V@nongnu.org
X-Gm-Message-State: AOJu0YzjQOUbSvM+LOakvM4/CN1RgaXESqSZGM/g/Dt9N6t5Jbz+AuRw
 +Blm3ZijAiJYrJjpMbxbHpYjK756f2cXKUptmB0OpAyxC2xDqtA/E0QP4In1bhdxZkC+k1hFQTn
 ATQFdIw9s4ErWlPx8iDH9B3xqyhDaHAiM2MMZE9BXfme+IyZBw9Bj
X-Gm-Gg: ASbGncuiUu8pu1FeJ+XnSs/d3kP3w59qdssqAo7OKoHEsk/BwhfgxFao9T5vc7Kzvmt
 oHF64UdP9dDqsp6LZ5NwV4t2Oc9PLd2U9OxhimF+56u0FwUUyDCHESvu+cssncy2y5z3dpR/48M
 7r0oawx2zapr9avT+8EECVKTxn4kV+rY/Ql+ekVF7Pl4OAbskiYXg31rPMt7z0PU/foayxiSPk4
 N3tkTGWHiPvzhn/NdAC2zAxHOsENNl26FzrKP9TaX+y3ZLfHvy9Jj3D0+y+BG9k4g3T6gqebiMc
 T3ZOLkyefyKVf+yF9rTJQMncKN9fqxs0XCbcxKWwjdeSfdNnMMGPhgAWwGaNliFUO4mVlMAVUcx
 lvnTFN0Oml7O/AWfUNcPuh+y2FohL/DrQJt/w2iN67nLw
X-Received: by 2002:a05:6000:1a8d:b0:390:fe8b:f442 with SMTP id
 ffacd0b85a97d-39cba93cf68mr2286013f8f.54.1743765440364; 
 Fri, 04 Apr 2025 04:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE131E6heT0VyIW0nS8hTDOrXevoJQlcrxhB4Z9BYIlJDl3G2fl3SjjPO8w6QnQVASn9kuRXQ==
X-Received: by 2002:a05:6000:1a8d:b0:390:fe8b:f442 with SMTP id
 ffacd0b85a97d-39cba93cf68mr2285988f8f.54.1743765439869; 
 Fri, 04 Apr 2025 04:17:19 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342babfsm43648225e9.1.2025.04.04.04.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 04:17:18 -0700 (PDT)
Message-ID: <68d0bd72-3a72-4370-8178-45dda9889a56@redhat.com>
Date: Fri, 4 Apr 2025 13:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] fuse: Copy write buffer content before polling
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160635.118812-1-hreitz@redhat.com> <20250327144731.GA37458@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250327144731.GA37458@fedora>
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

On 27.03.25 15:47, Stefan Hajnoczi wrote:
> On Tue, Mar 25, 2025 at 05:06:35PM +0100, Hanna Czenczek wrote:
>> Polling in I/O functions can lead to nested read_from_fuse_export()
> "Polling" means several different things. "aio_poll()" or "nested event
> loop" would be clearer.

Sure!

>> calls, overwriting the request buffer's content.  The only function
>> affected by this is fuse_write(), which therefore must use a bounce
>> buffer or corruption may occur.
>>
>> Note that in addition we do not know whether libfuse-internal structures
>> can cope with this nesting, and even if we did, we probably cannot rely
>> on it in the future.  This is the main reason why we want to remove
>> libfuse from the I/O path.
>>
>> I do not have a good reproducer for this other than:
>>
>> $ dd if=/dev/urandom of=image bs=1M count=4096
>> $ dd if=/dev/zero of=copy bs=1M count=4096
>> $ touch fuse-export
>> $ qemu-storage-daemon \
>>      --blockdev file,node-name=file,filename=copy \
>>      --export \
>>      fuse,id=exp,node-name=file,mountpoint=fuse-export,writable=true \
>>      &
>>
>> Other shell:
>> $ qemu-img convert -p -n -f raw -O raw -t none image fuse-export
>> $ killall -SIGINT qemu-storage-daemon
>> $ qemu-img compare image copy
>> Content mismatch at offset 0!
>>
>> (The -t none in qemu-img convert is important.)
>>
>> I tried reproducing this with throttle and small aio_write requests from
>> another qemu-io instance, but for some reason all requests are perfectly
>> serialized then.
>>
>> I think in theory we should get parallel writes only if we set
>> fi->parallel_direct_writes in fuse_open().  In fact, I can confirm that
>> if we do that, that throttle-based reproducer works (i.e. does get
>> parallel (nested) write requests).  I have no idea why we still get
>> parallel requests with qemu-img convert anyway.
>>
>> Also, a later patch in this series will set fi->parallel_direct_writes
>> and note that it makes basically no difference when running fio on the
>> current libfuse-based version of our code.  It does make a difference
>> without libfuse.  So something quite fishy is going on.
>>
>> I will try to investigate further what the root cause is, but I think
>> for now let's assume that calling blk_pwrite() can invalidate the buffer
>> contents through nested polling.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/export/fuse.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 465cc9891d..a12f479492 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -301,6 +301,12 @@ static void read_from_fuse_export(void *opaque)
>>           goto out;
>>       }
>>   
>> +    /*
>> +     * Note that polling in any request-processing function can lead to a nested
>> +     * read_from_fuse_export() call, which will overwrite the contents of
>> +     * exp->fuse_buf.  Anything that takes a buffer needs to take care that the
>> +     * content is copied before potentially polling.
>> +     */
>>       fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
> It seems safer to allocate a fuse_buf per request instead copying the
> data buffer only for write requests. Other request types might be
> affected too (e.g. nested reads of different sizes).

I don’t think anything else is affected, but I absolutely agree that it 
would be more obviously safe to have a dedicated buffer for each request.

However, I decided to do it this way so I wouldn’t negatively affect 
performance before converting to coroutines – I felt it would be a bit 
unfair.  But if you think that’s alright, I’m happy to use a dedicated 
buffer per request!

>
> I guess later on in this series a per-request fuse_buf will be
> introduced anyway, so it doesn't matter what we do in this commit.

Kind of; this one is CC-ed to qemu-stable (the rest is not), so it does 
matter for stable releases.

Hanna

>
>>   
>>   out:
>> @@ -624,6 +630,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>>                          size_t size, off_t offset, struct fuse_file_info *fi)
>>   {
>>       FuseExport *exp = fuse_req_userdata(req);
>> +    void *copied;
>>       int64_t length;
>>       int ret;
>>   
>> @@ -638,6 +645,14 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>>           return;
>>       }
>>   
>> +    /*
>> +     * Heed the note on read_from_fuse_export(): If we poll (which any blk_*()
>> +     * I/O function may do), read_from_fuse_export() may be nested, overwriting
>> +     * the request buffer content.  Therefore, we must copy it here.
>> +     */
>> +    copied = blk_blockalign(exp->common.blk, size);
>> +    memcpy(copied, buf, size);
>> +
>>       /**
>>        * Clients will expect short writes at EOF, so we have to limit
>>        * offset+size to the image length.
>> @@ -645,7 +660,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>>       length = blk_getlength(exp->common.blk);
>>       if (length < 0) {
>>           fuse_reply_err(req, -length);
>> -        return;
>> +        goto free_buffer;
>>       }
>>   
>>       if (offset + size > length) {
>> @@ -653,19 +668,22 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
>>               ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
>>               if (ret < 0) {
>>                   fuse_reply_err(req, -ret);
>> -                return;
>> +                goto free_buffer;
>>               }
>>           } else {
>>               size = length - offset;
>>           }
>>       }
>>   
>> -    ret = blk_pwrite(exp->common.blk, offset, size, buf, 0);
>> +    ret = blk_pwrite(exp->common.blk, offset, size, copied, 0);
>>       if (ret >= 0) {
>>           fuse_reply_write(req, size);
>>       } else {
>>           fuse_reply_err(req, -ret);
>>       }
>> +
>> +free_buffer:
>> +    qemu_vfree(copied);
>>   }
>>   
>>   /**
>> -- 
>> 2.48.1
>>
>>


