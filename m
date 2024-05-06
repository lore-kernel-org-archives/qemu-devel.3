Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF7CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3v7u-000639-VT; Mon, 06 May 2024 05:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v7r-00062l-TA
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:59:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v7q-0002GB-2p
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:59:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34de61b7ca4so1213954f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714989551; x=1715594351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RM2AUVZhCrZRBdwl2qu154tGUSj3YdbWUJhDj2uZ1jg=;
 b=UTFAWyEAGZ5nEnihNL3OAUC3g1FuJa+MhVKNYyASTWIAtaFBatdQGktxyF1v07ItlZ
 H7F7fl8eI2XNE6ntqSsgx89Oy4HyGWq7A0/dXIdW+ZxlGy2lvD0Kt4UQUB1obHqESwk5
 Gd6EW/7SfFatv/3aSY+skxnbHUMZs9zC4RtWT7H8dimwndufBv5RqNie2xOdNEXWkoYW
 GQUR+XGUBBzWklis5AfRC/7u8YigMNsFqUJTi2hL6Jsn5Q2eu29YKTpOTDR+if4G7fKZ
 Hcg3AQOmfx9EMsO4dTOiFRi5lqq+8xyxVB3H8ZkFzmbCBYmWybosel3Pq4yJIqLRGclQ
 T6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714989551; x=1715594351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RM2AUVZhCrZRBdwl2qu154tGUSj3YdbWUJhDj2uZ1jg=;
 b=MemF0C5V6hjsqVtrW996Ws2iDTNzmS9GvxoOtJhhlfitT4GFtJ2tHCjL0ZsBlAeGB5
 xrsvA8ZGgodEd4EAhb2joQsHi5E8oRdfmi+buSGHSSACFMrJfuFAF/f+j9wZnaMW6tif
 jjK75UsJ9lt84GsQALka7u2V/6ucyeCFH8tSZTm4OHZRdbkE6MWFuMM/xir53hoNMCXX
 IkIBX68aIJAGvxNigLY/ESfFc6X2QD0ErelFUW4/8Zg0I65TRThBZYMI4NfYgVuIvtLv
 mt2E8Gb4aD9CAGHhYE2wTMMCqu2ICCmbSAddTHrS7hau1MPrPafyJWvRHKnsUzf8omZj
 1T1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5injitVPZVfU1gNAsnNSW0VfRqw2HdpvGhV8Va6h7iLrvEaKzYF1ezPwNeTvMd27rn3LQtobZGNS925JaBC/voKUQ4SA=
X-Gm-Message-State: AOJu0YwpBYBQrTJAq0TeP4LFdOnkztc3We5zTHlEr7paNvjXBvRcKx7M
 iZBwY52lRgIzINfX4QuzMVgC5M/a7pWancgmjT1MTI0fJSwbuV+LzZrhvPsVjCg=
X-Google-Smtp-Source: AGHT+IGQhLat87LYAh2IwfqAZwyzJJcGQTjnVUUxq0f0jcHzkbbN/ooQNq+MPvlN954LLRpUdApp6w==
X-Received: by 2002:a5d:456e:0:b0:34d:8d55:739a with SMTP id
 a14-20020a5d456e000000b0034d8d55739amr9345620wrc.57.1714989551149; 
 Mon, 06 May 2024 02:59:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 f3-20020adfb603000000b0034dced2c5bdsm10269498wre.80.2024.05.06.02.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:59:10 -0700 (PDT)
Message-ID: <d4008042-6f68-42f6-8ade-fbb0ba115a33@linaro.org>
Date: Mon, 6 May 2024 11:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/17] xen: Add xen_mr_is_memory()
To: David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-15-edgar.iglesias@gmail.com>
 <0263b7e8-5800-4f5a-9dc5-bc2b4fbbbbfe@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0263b7e8-5800-4f5a-9dc5-bc2b4fbbbbfe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/5/24 09:26, David Hildenbrand wrote:
> On 30.04.24 18:49, Edgar E. Iglesias wrote:
>> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>>
>> Add xen_mr_is_memory() to abstract away tests for the
>> xen_memory MR.
>>
>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>> ---
> 
> [...]
> 
>>   #endif
>> diff --git a/system/physmem.c b/system/physmem.c
>> index ad7a8c7d95..1a5ffcba2a 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2227,7 +2227,7 @@ static void *qemu_ram_ptr_length(RAMBlock 
>> *block, ram_addr_t addr,
>>            * because we don't want to map the entire memory in QEMU.
>>            * In that case just map the requested area.
>>            */
>> -        if (block->offset == 0) {
>> +        if (xen_mr_is_memory(block->mr)) {
>>               return xen_map_cache(block->mr, addr, len, lock, lock,
>>                                    is_write);
>>           }
> 
> I'd have moved that into a separate patch, because this is not a simple 
> abstraction here.

Yes please, maybe using Stefano review comment in the description.

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


