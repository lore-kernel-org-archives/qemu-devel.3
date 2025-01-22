Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E149C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taWFr-0006yi-LQ; Wed, 22 Jan 2025 03:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taWFm-0006uY-Gj
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:38:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taWFj-0000k2-Su
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:38:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso75615175e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 00:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737535102; x=1738139902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CfYJLQU1nbRa4fINMBMM9iwWTJQ+3oWHm92lV+T+K50=;
 b=bB8+MOiuA20sL5TEDDBDt+pMHvVO/+dzVCKIHe5qGc5/335RLRJzG+qsVWHUk1CNlC
 4bFLJBLww3e8LD5Nb+OIi8VsCz6XynbSbrzV7bpmSrHq5iKn40LppK5vcvrLkVGNNJl0
 NYoZJv/X6bOXL+g1ZeoZ60tazepytP4gXK/emGKpYxD+qFZK8W4y/3p2MosvJ/U3Xk3B
 X0G0cSJn4G2QZz71lzQ76O6sKVwdj15W+OvWB/BgIjj7fzEKSx7rWgE0fcCq505GDPv+
 eFqqqFklF0BQxDPuMfLQlX9mFqNg7zYy0MLzyqEZuyAr113opU0mTM0M0ilgrc4x4rlI
 2Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737535102; x=1738139902;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CfYJLQU1nbRa4fINMBMM9iwWTJQ+3oWHm92lV+T+K50=;
 b=qGVHxIUjjDYNVlXgJkhSobpoOwtxwOgeNtSZyLyDa9MjC/ddT2Hjdi3qnCdGTqp3DJ
 MeaziGMMwVg4RefQSXutOrvVUvrltljFH9gdEukgJ772ggfE3oXxzpqjGT9upGMTLNmD
 +g2Do0U2QvuAE49/gUEVwJs77uM+zJ/ei76Y/5zGcT+nA0EJaq7rxrI/icZDghVgWK1r
 5cxjcTMN8ovER10rBE/yA+kNMKZwaogRtcu/m0wLggHMTdwKft7eH8eetAwtcZ+VHE0+
 lgTXKyaCBKHH3w3q6OGhPJmzDN7XuRDv7R9yTQFYPE7axHxgUt6muDvU2RC8e8xWXTuG
 0V4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZjItoLaYYaRkjRgIkJnkCQhy1F5fGsoWNjrohHixXkTH3HeFl1el9arhSWtPcH9e7bID1B3bHxAGl@nongnu.org
X-Gm-Message-State: AOJu0YzO+w/mW7OiT1IW6xNbnKXZxD9JU2570FLs58HvDfFPfF8x1QlZ
 3ui7IaLCGyH8WUsduFRHrB3omF58A74ryzuyQmC+i9a5oGudasOIE6e3OHu4T0w=
X-Gm-Gg: ASbGncv89ENXoaRPmXs7Opu4L9sC4utbL333sLqg/ohbft94E0/4OYGSGfjfQVmxKOK
 m14PjD8M495cGvkzPKGYK5dKdqz+I3PJYs6Ls6EkQqCGOVb9JEGC/lAy3j5k7lWaXzuEDzXzFsZ
 DMe2BJ9IGuEWUOxRDobfO8wFXO3mSqTL1BaytkEGTnIIAftjHHATEP39IRksFBeuZpCsyuOftYN
 13987fuoIaAaaljCCvqQJqbEX0VjBRVN9CL3z0GWywSTGd/kNjiovZ8cdQ3HSTbA4Eh6oYa22kS
 AYBd3cPUZWazHP9m/YWVYhpZcXtNW3hd5lsDjA==
X-Google-Smtp-Source: AGHT+IEanfFpshCO+ip8R0ZZ0uHY/MUCUVbwa6WLVFzq8Of/TCiHetYVstVZTa24KM9eD8PK/aMYkQ==
X-Received: by 2002:a05:600c:4e93:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-438913df89fmr192119805e9.15.1737535102048; 
 Wed, 22 Jan 2025 00:38:22 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31ae97dsm15876475e9.22.2025.01.22.00.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 00:38:21 -0800 (PST)
Message-ID: <9bb8aa7b-a464-4dfc-9c76-7ab50d195b2f@linaro.org>
Date: Wed, 22 Jan 2025 09:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] Add support for emulation of CRC32 instructions
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Aleksandar Rakic <rakicaleksandar1999@gmail.com>, qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@linaro.org, berrange@redhat.com,
 Yongbok Kim <yongbok.kim@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
 <20241112164130.2396737-3-aleksandar.rakic@htecgroup.com>
 <d136993d-48bc-4283-9de0-c956b5cac302@linaro.org>
Content-Language: en-US
In-Reply-To: <d136993d-48bc-4283-9de0-c956b5cac302@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 22/1/25 08:27, Philippe Mathieu-Daudé wrote:
> On 12/11/24 17:41, Aleksandar Rakic wrote:
>> Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
>> Reuse zlib crc32() and Linux crc32c().
>>
>> Cherry-picked 4cc974938aee1588f852590509004e340c072940
>> from https://github.com/MIPS/gnutools-qemu
>>
>> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
>> Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
>> ---
>>   target/mips/helper.h             |  2 ++
>>   target/mips/meson.build          |  1 +
>>   target/mips/tcg/op_helper.c      | 26 ++++++++++++++++++++++++++
>>   target/mips/tcg/rel6.decode      |  5 +++++
>>   target/mips/tcg/rel6_translate.c | 14 ++++++++++++++
>>   target/mips/tcg/translate.c      | 25 +++++++++++++++++++++++++
>>   target/mips/tcg/translate.h      |  3 +++
>>   7 files changed, 76 insertions(+)
> 
> 
>> diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
>> index d6989cf56e..5074338aa5 100644
>> --- a/target/mips/tcg/rel6.decode
>> +++ b/target/mips/tcg/rel6.decode
>> @@ -16,11 +16,16 @@
>>   &r                  rs rt rd sa
>> +&special3_crc       rs rt c sz
>> +
>>   @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
>> +@crc32              ...... rs:5 rt:5 ..... c:3 sz:2 ......   
>> &special3_crc
>>   LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
>>   DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
>> +CRC32               011111 ..... ..... 00000 ... .. 001111  @crc32

Are these really available on MIPS64? (Looking at MD00087 Revision 6.05)

> Interestingly the disassembly for that is in tree, hidden in commit
> 99029be1c28 ("target/mips: Add implementation of GINVT instruction")...


