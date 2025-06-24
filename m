Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C23C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 15:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU5U7-00036V-P5; Tue, 24 Jun 2025 11:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uU5Tz-00036A-Mg
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:22:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uU5Tv-0005EM-0D
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:22:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso426389f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750778560; x=1751383360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ASqQgrMvU6LQ5I9Az2VPslf7VBZGlTuZ5kgSO/qPHY4=;
 b=jQRumI1CJ3QJs8wS+YFLHH1RTToNI4YNpi0QngMYkrhP1H/Nj0fNO4+VOaTCH5ZnUq
 iEi6gnGgP2Grn/lBd6cfRYUFTZBfzONaMWVEOB6YhqC/0wdtF9PNkUc1RFVuJ0eLJ1WZ
 doEBvxUiAvC7hB+U876V7dpL6BYElA4TjWmzI9yxmhcgQWEBfh2pGexC9/YEP2Qi2CER
 KYbVF6i/gY+SWrOBl+O2S5rjIWWh3m5E3p1WV49Nejh5fUPgBPkVpPM+69hf6mfByBRj
 Y/vE7AVFk8DhCmLs9ygHafIfbtSMuDeRSC4T2e1dY0maiMmyvhoLhSN0cmkPLQ/0NEGK
 /gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750778560; x=1751383360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ASqQgrMvU6LQ5I9Az2VPslf7VBZGlTuZ5kgSO/qPHY4=;
 b=dknXXGlKAhzpjKckkIgWS6niSst/Lrh001w2KE//NYqXziNcN1qs2/cI8Gzt/D8tYE
 E6NI7usksPCuGvpBhP/rptDdZdkmRP+oj70Lm6DFssvR7wdJKNo0POwn5LIi94UrSSq/
 zF3K/Eg1VXfd99JPQraPXUuCZG8PZGs+bfRPA3wy8zPuGCuYMKBMsLtrwyJ1iqNXLvUq
 tFZ8B0Oq7jDFZLngQCwutgH61D0/U33R/f8JtPGh3abGR/EwMr7xlmPrC07EnNRVqhiQ
 TU+O37wjBIP26fPjnHp07cno8rOv5g8vrOny1dq0FIv48kKpeGpqZF5SEs0hex1uHzuI
 MSZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeqxHJdVl6Sx1UNstT11aPFa7c4rrwaouTVTIHTn2jUx92a4A3FIg5Y3pPr+fWpitwNN+vvXCgn1Rx@nongnu.org
X-Gm-Message-State: AOJu0Yx/HhWTNKypJiMASi7KX3PP3XxvqZ3UkUb14o7bOMWqELE+oQsc
 Wcfq8Yh9I6CH2EXjtcV+T7pkpLW2SmSIBef/49RKfcpBTKWAZPjqojExO7zAZov5RuY=
X-Gm-Gg: ASbGncvTHFOA9GxMJQimDA7+7YLfHWVXtTeB5ngwOGOH3BpHmv4hR2H3OdJdTsZlosf
 XDcukdSWchLuL5XIJrQyY0JKxtgDwe0ewDMsJbhS1th/SYxrvfvzVfi3pJXMwR+jAKcZ8qNYu4n
 9lQbKXaMtXUojkkkqV6xNQ5LGtz+bQ0DmliNwBfE5R9vq4izwZUe3sDOCl2w88vylZ7tQSBKHeS
 Io1ubVnyBdA6Qg0vZ2A4rRsk5YB+5w5+JN9W7D3a3wx1yLV66lO5WoxjVJyH7GSwoGT4WxFjhfx
 L9x1sA2jTmJF8WI/7+29L/asn2FgcTijOacVgHcABWvRVysWJbPkFSZmoLKIvJCiHBEx/8e+KkH
 z7a4QqNHPI74I3nzoR2l7A/qiNRlxpg==
X-Google-Smtp-Source: AGHT+IGNxxNoOFUljWRu+JD2/OK1aNrTjK0Y7MOrXbys2rRPCHZ9pbpIDQmG/qfl2Od0DBbVSKafjw==
X-Received: by 2002:a05:6000:1ac8:b0:3a4:ee40:715c with SMTP id
 ffacd0b85a97d-3a6d130168fmr16720524f8f.14.1750778560472; 
 Tue, 24 Jun 2025 08:22:40 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80693c6sm2146854f8f.41.2025.06.24.08.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 08:22:39 -0700 (PDT)
Message-ID: <357ed49f-5b38-4b91-b87e-34a6d6ac1964@linaro.org>
Date: Tue, 24 Jun 2025 17:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/s390x: Use preferred API call for IPLB chain write
To: Jared Rossi <jrossi@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: zycai@linux.ibm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623201216.721130-1-jrossi@linux.ibm.com>
 <20250623201216.721130-2-jrossi@linux.ibm.com>
 <4e95f3c7-8748-4cf5-ac21-78cf653bfd40@redhat.com>
 <2d08e53a-4680-499e-b383-9418ad65df8b@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2d08e53a-4680-499e-b383-9418ad65df8b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 24/6/25 15:16, Jared Rossi wrote:
> On 6/24/25 2:27 AM, Thomas Huth wrote:
>> On 23/06/2025 22.12, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> Replace a recently introduced legacy API call with the preferred API 
>>> call.
>>>
>>> fixes: 0927875 (hw/s390x: Build an IPLB for each boot device)
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
>>>   hw/s390x/ipl.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index 2f082396c7..f2606303e6 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -399,8 +399,16 @@ static uint64_t 
>>> s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>>>       uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
>>>       uint64_t len = sizeof(IplParameterBlock) * count;
>>>       uint64_t chain_addr = find_iplb_chain_addr(ipl- 
>>> >bios_start_addr, count);
>>> +    MemTxResult ret;
>>> +
>>> +    ret = address_space_write(&address_space_memory, chain_addr,
>>> +            MEMTXATTRS_UNSPECIFIED, iplb_chain, len);
>>> +
>>> +    if (ret != MEMTX_OK) {
>>> +        error_report("Failed to map IPLB chain.");
>>> +        exit(1);
>>> +    }
>>>   -    cpu_physical_memory_write(chain_addr, iplb_chain, len);
>>
>> By using address_space_memory, you're basically open-coding 
>> cpu_physical_memory_write() here. That does not make too much sense. 
>> If I got Philippe right in https://lore.kernel.org/qemu- 
>> devel/469f3e5a-897a-4456-bd02-185435129ec4@linaro.org/ , he rather 
>> asked about a device specific address space instead. However, that ipl 
>> device does not have its own address space as far as I can see, so 
>> that request does not make much sense here (unless I missed 
>> something). Thus I'd suggest to drop this patch here.

Generic pattern to remove &address_space_memory singleton is to add
a link property to the device, set it in the device Realize handler
(here s390_ipl_realize) and use this device address space instead.

Eventually we'd be able to remove the legacy cpu_physical_memory_write()
API, not re-using it.

I don't know about the IPL device. IIUC s390x is unlikely interested
in heterogeneous emulation, and model design often took API shortcuts,
but if we want the whole codebase to move toward the heterogeneous goal,
we need to strengthen API uses.

My 2 cents anyhow.

Regards,

Phil.

