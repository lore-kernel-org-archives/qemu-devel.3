Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552F606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7MUgj5h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO1x7-0005oy-SD; Mon, 02 Nov 2026 19:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xO1x5-0005oA-CX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 19:00:35 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xO1x3-0003jQ-Cu
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 19:00:34 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-ccca948203aso1354139a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 16:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793664031; x=1794268831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I/8xO7WWLvVcc/j7GWGTxlzucdyp7fsNlvZs1y5EimE=;
 b=c7MUgj5hwNfaLQlPrU4Li93jCNAw8cBnbxDyCi/3w+JVLSlceHnJ+656OKcjzQelBn
 SIZgpVbM9QsP8Bbxm2Re1Rx/4Eji3T+UZQ0Ka52bA7wg7hwfLoTfMwd+wji3q6GbTCN+
 SpOuI6tHc26wz0eCrfuA88BMfWeeUEmS5zXwdJJSumD3wnGQoCo1+oqTU73BcZE9lnSG
 YtUiwZy81PRWwzdGdkmAC4xGTF89bcwjPAhWIkGrVb0oH8deSyQ8k8X5/idAG9Uoo6SJ
 mUUKlKakKVV6d9qALHadE7gRpfud8g3u6d7NBOT2iv15Eir5IASO4GC+jl0BCMxiejFR
 6MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793664031; x=1794268831;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I/8xO7WWLvVcc/j7GWGTxlzucdyp7fsNlvZs1y5EimE=;
 b=pp4YD3Qv6uU4p6MAbSYNjfP/4AvIQuZdpqbcKGn2+2rmd2ZowTuV4xCkJERnkwqlL/
 i/Zko7O1a8W39feY7+Wm6p8KLTyjqqCpo0FJP9Kl/lQwTdtjbHVxrRkFRpcoHwHu810D
 MMbrWttVBt8o/SFyOiGWV90UGN3U43JVZ9PSh9RwO9SueoYtkoo7MgVs8ubdMK8hbIWN
 cPfvHpLqxu1Yoa6WeyF9E35aWhYwVScrbp8QMexs3JSN/f3FEzefe/5N5+KtYNReH15Y
 B50d8F2PXMxpFIL3rTbeWfc4bpiLYVEqpxKRlcbvKpV9metqb+wUOosN8mVXMSG/KRpr
 +3kw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU8ofNWsrxchGTMXmYdKj390wJRY3SeDn6SDA6ovzgLUTlGYar4VjZyNgfWp9bQH6ZYmYEUMci64A/@nongnu.org
X-Gm-Message-State: APuU4Z8M0NRHamUx33q7YGh1JsbtzTupJVfsu3/1sQXTo7TKQJHQUGak
 F3DSG8xI8gPCJ/d4A3nyDCuE3XiBRYznkmu//2Rai1Cf1r5tMOhNfadI
X-Gm-Gg: AYBFou34tZjQYfXV80E5AX7NfGQck/xrJPzg7OI+lSf2ku20iJR5/0ER1gLqFlRXKFh
 mdfCrqrk3UHHBGSlL0i1/XYgELDFvFdUluKFxWZ5AJi+TKQQspY3bu294DH7Yn4zgD8m5isrgY0
 KZu3nhlqO62vzkABmh/XuFNle18vxgz2u2WqjPCJWQGMzDFOzUKW/miG/uwiw0UQNHpkycboWrt
 1Tc+oxtYUO3Djl0vAO/19nMaC9waJGTFvUfvy/+nWWnqbZXs1/216cQAJ1qqgcNGJlhp0YC1ZDF
 yU8oSqkrTApxKq/muJ/YVrntRbsBqXvHP8gMb9Vy8iE0CvOAg3EQYi6p8TdM+f5Ra5uK+VvxSNl
 3UZwlRzXMIMavlt2SgNttI91+j2ytwJ/T0brHgAyv8s+BfHpJm6A5fhcE+33tHR2QgBR9G1GqHo
 cZLYW8tWQySqpr9gQvjt/0xw0biPO2Sb9MLOrEbBUzTL7nOxnZrjjsnp8qjyuKdvUFXH2pWiRvL
 itYbqxfQGmOf4dWgz3ab5RoLAfU6MnNz5ohkCQtYknRdPTPaIf0KvzOScav75tN+2ylsMzqZeph
 sCHy9IN5TuEUyMgZgVSPnCnlf5TnbzX24iJoydYXr24vFTa8YK9NCfrep3pc2RWNh+ItyxFSPzM
 nG+A=
X-Received: by 2002:a17:90b:4f8a:b0:3a4:ca46:840f with SMTP id
 98e67ed59e1d1-3ae896f8655mr8988730a91.8.1793664031087; 
 Mon, 02 Nov 2026 16:00:31 -0800 (PST)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c896cc6sm1210944a91.9.2026.11.02.16.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 16:00:30 -0800 (PST)
Message-ID: <f99ab4f9-cf9d-484a-8bd1-d8e3676f8ed3@gmail.com>
Date: Tue, 3 Nov 2026 09:00:24 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/12] hw/ufs: Check the PRDT size against the transfer
 length of the CDB
Content-Language: ko
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 daejun7.park@samsung.com, stanleyjhu@google.com, dridiha98@gmail.com,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, qemu-stable@nongnu.org
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
 <f9e0f4d949a0cec465e5f40ce8721b49b7850371.1793347487.git.jeuk20.kim@samsung.com>
 <92da7631-c19b-43e0-9122-618f98cc102c@tls.msk.ru>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <92da7631-c19b-43e0-9122-618f98cc102c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/2/2026 10:42 PM, Michael Tokarev wrote:
> On 30.10.2026 11:14, Jeuk Kim wrote:
>> From: Daejun Park <daejun7.park@samsung.com>
>>
>> scsi-hd moves as many bytes as the SG list of a request holds, and
>> ufs-lu builds that list from the whole PRDT. When the PRDT is larger
>> than the transfer length in the CDB, a WRITE writes more blocks than
>> the CDB names and a READ reads more. A one-block WRITE(10) at LBA 0
>> with an 8 KiB PRDT also wrote LBA 1, and its response reported no
>> residual. A UFS device transfers what the CDB asks for and reports the
>> rest of the Expected Data Transfer Length as a residual.
>>
>> The commands that scsi-hd emulates had their residual computed against
>> the PRDT too: an INQUIRY with an allocation length of 36, a 4 KiB PRDT
>> and an Expected Data Transfer Length of 4096 reported an overflow of
>> 4294959176 bytes. It now reports an underflow of 4060.
>>
>> When the PRDT is smaller than the transfer length, scsi-hd moved what it
>> holds and the request completed without an error, for example a
>> two-block WRITE(10) with a 4 KiB PRDT. Such a request now fails with OCS
>> MISMATCH DATA BUFFER SIZE, as one without a PRDT does. As in
>> virtio-scsi, the PRDT is compared with the transfer length of the CDB,
>> which for commands that return data is the allocation length, and before
>> scsi-hd checks the CDB.
>>
>> The new ufs_fit_data_buffer() in ufs.c, where the SG list is built from
>> the PRDT, cuts a longer list and reports a shorter one; ufs-lu passes it
>> the transfer length that scsi_req_new() parsed. The HID qtest wrote
>> eight blocks from a one-block buffer, so give it eight blocks. The new
>> long-prdt and short-prdt qtests failed before this change.
>>
>> Fixes: 2a8b36a4967d ("hw/ufs: Support for UFS logical unit")
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>> Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
>> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>   hw/ufs/lu.c            |  20 +++---
>>   hw/ufs/trace-events    |   1 +
>>   hw/ufs/ufs.c           |  35 ++++++++++
>>   hw/ufs/ufs.h           |   1 +
>>   tests/qtest/ufs-test.c | 141 ++++++++++++++++++++++++++++++++++++++++-
>>   5 files changed, 189 insertions(+), 9 deletions(-)
>
> Hi!
>
> This patch is tagged for-stable.  When trying to cherry-pick it to 10.0.x
> series, I notieced the change to ufs-test.c does not apply, this one:
>
>> --- a/tests/qtest/ufs-test.c
>> +++ b/tests/qtest/ufs-test.c
>> @@ -1577,7 +1713,8 @@ static void ufstest_hid(void *obj, void *data, 
>> QGuestAllocator *alloc)
>>           /* WRITE(10) to LBA 0, transfer length 8 sectors = 1 
>> fragment */
>>           WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00
>>       };
>> -    uint8_t write_buf[4096];
>> +    /* The PRDT must hold the eight blocks that the WRITE(10) moves */
>> +    uint8_t write_buf[8 * 4096];
>>       uint8_t read_buf[4096];
>>       int i;
>
> This is because 10.0.x has no UFS HID support.
>
> So, it is not the test itself which does not apply, but modifying 
> parameters
> for another test, which, apparently, triggers this PRDT one.
>
> Without knowing all the details about all hardware specifics involved,
> I can't say for sure what's going on here.  How the two (HID & this
> PRTD change) are related and what should be the test for 10.0.x ?
>
> Thanks!
>
> /mjt


Hi Michael,

The HID test change is only needed because the existing test uses a 4 
KiB PRDT for a WRITE(10) command
that requests 8 blocks (32 KiB). With the new PRDT size validation, this 
would fail.

Since 10.0.x does not have HID support, you can simply omit that hunk 
when backporting the patch.

The new long-prdt and short-prdt tests cover the PRDT size validation 
and should be kept.

Many thanks, as always!
Jeuk



