Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KztvrV0T;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GwHBkVT7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRQqg-00027y-2h; Thu, 12 Nov 2026 04:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xRQqV-0001we-Dw
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:11:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xRQqS-00023d-VF
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794474707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lbRa2LZY4A1Zvcd4q6Yxkm5unXef8gjy3F5yGN81Hlo=;
 b=KztvrV0TusAWWe8Gp/iyRZrwXcV/oTDj/6WUdfvc+L0CCPejIZFZ3AAvlxzmD90UfUf6hk
 AHjBQ60Md/ZuiinKb4cals/YWbQK8yEgDIzVvBpA0yMp+/UgBKXmaCXxTdVtDyRu1ifSJo
 BBgSfa6jiHdq31C/J6sMgRHA7qBEYdA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-zwCw9vrVMDiVNX4l103UHw-1; Thu, 12 Nov 2026 04:11:45 -0500
X-MC-Unique: zwCw9vrVMDiVNX4l103UHw-1
X-Mimecast-MFC-AGG-ID: zwCw9vrVMDiVNX4l103UHw_1794474705
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-490c69dc02bso3478830f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 01:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794474704; x=1795079504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lbRa2LZY4A1Zvcd4q6Yxkm5unXef8gjy3F5yGN81Hlo=;
 b=GwHBkVT71nItHJathMl5YM0sAh6hfEd02uCxSmuQR8sfrAVrGaEVSOzVmtHWCaRVqH
 he8x3OCKVqMGXipYcCoDlv3K2Ft5NvqLK+5aC+KhVTaME7VxTnN50b2s7Y+BOe2H1TDC
 k/YLozR+kvG2C8BIM1lqkhqlKhQvRJra0bODpILHzYwVxo+0DpDFsZzgeRZT8BF5z7Lp
 /QoCdhMYEcr+AC5Lk6Rv0bvKdkx4KP8gVV2py4StdQqMVFD67RXI5tT04mEQ+F1y30dN
 IRFdo/84kZinyW2kY98gKZO7uRH3JTMeKvHMsUKlS1eZg90HQ7xXHGuR2hfE+kHDAdmT
 6j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794474704; x=1795079504;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbRa2LZY4A1Zvcd4q6Yxkm5unXef8gjy3F5yGN81Hlo=;
 b=2u4DHIww+XxXql+ex29iLxPV1dDUMWyUTjnrQUw0f1EAyldCW+2iCtNbRPuWwVcxQV
 gK9zz/yqE8wpSo/ffjfBhHVfWy52M35K4DptFKMXaLEmasJcX17c+bA22uzmQvPZ5Hqp
 Qe/rVzDvm3DFc1Rtz+NZ+Ox8BKFJ5HmhW3bBAuZoyPvR0ux9SnyFyE8CFQDS8Pw6cFpU
 MtxM5l6j5qL4uDqQJ1FHJxfU5v9GSKh4oxTNzPTAHc6+yGKMWSlY67TeqyzTQ/Cih94g
 vGe9l78h6D/J2oZzdrLqGyOoK22Cpd92raVfsFUNlu/xmNOI/juFEJ/4MhhOQTmhcfhG
 lpEw==
X-Forwarded-Encrypted: i=1;
 AL+hErFe3RZdYeuz16mRts3+PAzV8Jx/n2Tc1Sd2nC+BgHbQIwzROpY8ryICGMUXR2NpOmDTpbZpFc15hPPp@nongnu.org
X-Gm-Message-State: APuU4Z9vLtasv6TWjW8XwlBoOP25/UMOzDpXlLwbL5HYvIgEFK6fFttZ
 tBhJRRE8wK8J9ac1HBvFHf5GrFEcBZIpZitZsOj/NaIy+OzQNxpvN9OC2O2HZQeWXaoiViG9cwF
 i6XEmj3aoDqM95xxrWqCXxe5Ss0bgDR1kz4AqqgRiDJB5FiDRrSARLwhs
X-Gm-Gg: AYBFou2N/rubT7PYdvpiavTdwGBt2i2CAsmMqx5G5zTo3cR5YXWrizhAO/f9TWmYE1C
 4rHgt5XvhwLHYAwW8VjVtpe/FxmY/4NPN6JMMQIpBJN92eLBOZtvwmVJyo2GIE4MXpXUZOFQ4xu
 Hd3jbBNKFZmaLdnuZ1Y2HpF9AFTcXUVEC+QEAC4hJRrss1TBjQK6lLkTQp8ezqFW/EYIm5Bks2U
 45qqtbI0X9iQHK7ak20MKmptVxbog7uM/J96KutdLUK6d7w+Ii0LqeUx2q8KYWYJCM/pwWKZUgq
 T4ifiTRPDo4YIWnUlEBH1NpIkg+np3/3oo5gCwces/Z3/57mmIzgP/slR9IOH2Mt1Xp2RdqI+c0
 cny3UxObj2MdbQ1gMbmGMWGf+s8kN+nuy3RPtkpb7xGel
X-Received: by 2002:a05:6000:1acb:b0:48f:ead0:631a with SMTP id
 ffacd0b85a97d-499c7d085d2mr8533062f8f.47.1794474704588; 
 Thu, 12 Nov 2026 01:11:44 -0800 (PST)
X-Received: by 2002:a05:6000:1acb:b0:48f:ead0:631a with SMTP id
 ffacd0b85a97d-499c7d085d2mr8533011f8f.47.1794474704103; 
 Thu, 12 Nov 2026 01:11:44 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365cd06fsm15563218f8f.40.2026.11.12.01.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 01:11:42 -0800 (PST)
Message-ID: <fc21f869-64c4-469a-9bcb-cbd723fce8b0@redhat.com>
Date: Thu, 12 Nov 2026 10:11:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/vhdx: Add alignment checks for region tables
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20261111161442.329763-1-thuth@redhat.com>
 <avTQnxm1bMJ6WbDQ@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <avTQnxm1bMJ6WbDQ@redhat.com>
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

Am 11.11.26 um 21:32 schrieb Eric Blake:
> On Wed, Nov 11, 2026 at 05:14:42PM +0100, Thomas Huth wrote:
>> According to the VHDX specification:
>>
>>   "The FileOffset and Length fields specify the 64-bit byte offset and 32-bit
>>    byte length of the object within the file. The values must be a multiple of
>>    1 MB, and FileOffset must be at least 1 MB."
>>
>> Thus let's add a sanity check to avoid that bad things could happen later.
>>
>> Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
>> Reported-by: Daniel Wade <danjwade95@gmail.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   block/vhdx.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/block/vhdx.c b/block/vhdx.c
>> index 8013a90a1a4..f5beace56f5 100644
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
>> +        if ((rt_entry.file_offset & (MiB - 1)) ||
>> +            (rt_entry.length & (MiB - 1)) || rt_entry.length < MiB) {
> 
> Would QEMU_IS_ALIGNED() be better than open-coding the math here?
That looks nicer, indeed. I'll send a v2...

  Thanks,
   Thomas


