Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A5CECD997
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo72s-0006bl-AC; Thu, 05 Feb 2026 16:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo72q-0006bG-QK
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:37:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo72p-000390-6U
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:37:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so1147201f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770327465; x=1770932265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/M2lI7gJNCBake4bReUSurZNxhRaSAmoOGQ1qLUuO0=;
 b=BClQHye23ApQFmut2VK/13lxl0xfTw3Yq0KBZxeiqyvxauXHHS5i+ElGiHv9NWhXvB
 Q3N08TyzrQqrVvGxxUY6d3Je80xvsIEI/EsZVeOhPabrsbXdnfTtAdSh/OdGrLmrqAJV
 8DRZz4jeSVUEDS+9/ZAXV0gedp85JeXyf+7OWDb08qYuTraM4GCCJASbs20XheS3iREX
 Y2R+/eEVrWwGDcHDJXU5oU2tvj7qSqiuPuFmeYbZPFBu+wlbQjjxYDPs9KyjR641A+Lp
 vBAdKwBCGMalhqH9uL2r0sq9TJ6lM7iyRXBWKhkVDVtQv1Yzk4fC2nar7GvuuKIym3pH
 Vbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327465; x=1770932265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/M2lI7gJNCBake4bReUSurZNxhRaSAmoOGQ1qLUuO0=;
 b=Xdcls9xtKcxNQ1E+brJWtUO72Ify8sNM6pQDZXfTmY9r8ut2k9wnsSz92OowE9D7SS
 mA6x0SDyIH+H4qv2gWaOAtUzNEmgWUUVbdiFCd12KG5OiRF8URtJco4gT3KtJDTP3AVX
 dasNe9n6J6k8LrcXijFLRXiLe2S03gwrftVYlySNDSQf6cpm1tcVS+j7sIlIgiBlYhyZ
 GcKKBRj2yai2m4FQWmDfjJwgPJhOlhN3OQU2l9G5qxrDV9tAVCXwwpAG0NriypPwpIpK
 sV+5IaN+foUPxemL5AypUihz3Bb53Jz0VPpfavNCx3MCy/VgTfk/IDdgwCu3s0248GOT
 Swvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgw0t8lEuVe83VJ/pn1QA+Y6/s31W3aot8bRKplXymWPjET9VRDKNL8uYrWy5N/s3UEzCw9HCp+Gwz@nongnu.org
X-Gm-Message-State: AOJu0YwhE/v5qGikQk1Kk/QVdK6/nv6ghz8VMNLTwayo8o/TYCeSFRIR
 omLFrW7ZIqQwkodSCGrk4j8dICD3ZaprIn4L9S/29CGsUDZ7gJpijFMZRvat5qvgPmk=
X-Gm-Gg: AZuq6aIFm033grUxPBZeLu49s9LX2ay9gnX5/RZTVxkX9CqBmBRmrVBTzM1JSTyrRSw
 3BMxyvY6qhZcNc8x8PTl9UDtbMe0TBxsIHyI0mHal+DVm1H7g8zyXds8y8G0vJrFtgqtiUuns1a
 0YLn/PXVr2MfHbbYPAZdEu4eWAg4v88cMATk0jZx/ayRooB9YYHgl0r17M99jY2au8emWCzubyZ
 iO512Jnr+/HXsOm9BGBJUukdBjrKa8EqlZSRfuxXEhvqSpi7HTBOOWlwdh2frmICq3Pre+iWvKV
 WxQEpWDmIUCLD2PDb2q5HChR/vi0V1Rsk1FjOFVs9ItL0rZCPuy3upNvkVUCvr9wp88FBNinbRY
 mhP21S6413TuoPDQ8vmi0nBDzZ0QYgCzusSNq+VdtGwWFHscbuABIyxBtaTaKmDYIWg4uoeDeux
 yeQXC+biKKqGUo17x5JsFnNdhlJ/mQaPe/xdsXvlxfXUAI6aeaRx5uNg==
X-Received: by 2002:a05:6000:1ac7:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-4362934c4famr1043305f8f.33.1770327465056; 
 Thu, 05 Feb 2026 13:37:45 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362974b176sm1175899f8f.37.2026.02.05.13.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 13:37:44 -0800 (PST)
Message-ID: <4eb5b630-dad5-4cd8-97a6-d1d4a3499400@linaro.org>
Date: Thu, 5 Feb 2026 22:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] target/s390x: Replace %target_ulong -> %vaddr
 where appropriate
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-4-philmd@linaro.org>
 <2827f8b28c4a654cb1b37eaf1313a1d63fb58f05.camel@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2827f8b28c4a654cb1b37eaf1313a1d63fb58f05.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Eric,

On 5/2/26 22:23, Eric Farman wrote:
> On Wed, 2026-02-04 at 19:27 +0100, Philippe Mathieu-Daudé wrote:
>> Use the %vaddr type for virtual addresses.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/s390x-internal.h  | 5 +++--
>>   target/s390x/helper.c          | 2 +-
>>   target/s390x/mmu_helper.c      | 6 +++---
>>   target/s390x/tcg/excp_helper.c | 3 ++-
>>   4 files changed, 9 insertions(+), 7 deletions(-)


>> @@ -376,9 +377,9 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
>>   bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
>>   /* Special access mode only valid for mmu_translate() */
>>   #define MMU_S390_LRA        -1
>> -int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>> +int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
>>                     target_ulong *raddr, int *flags, uint64_t *tec);
>> -int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>> +int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
> 
> I think this one should remain target_ulong, and become hwaddr in the next patch, no?

Without s390x background, I don't understand well what real addresses
are. IFAICT the single caller s390_cpu_tlb_fill() provides a virtual
address. But then indeed mmu_real2abs() consumes a hwaddr as real addr.

> 
>>                          target_ulong *addr, int *flags, uint64_t *tec);
>>   
>>   

