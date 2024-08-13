Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26682C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 12:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdqT4-0001cM-Uj; Tue, 13 Aug 2024 08:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdqSa-0001ZC-PL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:17:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdqSV-0000MX-Rx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 08:17:06 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6117aso2107101a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723551422; x=1724156222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ge6Dz3VoP6ViJAtrM5PUdz68g+9xNL4aUTYuDgLTzwc=;
 b=hveFwtZe3uU35AZ9P4Uf56GbGhLXifC6ZvmE9IlINhOKLh07bjtHW1bolvvj01VEvn
 nxUlJ9YDNLUTqAKBaa5a21vdX+s2sYkdIdEAgXu9v+6mqy/ntpBF8PwTfVCF0HkN7bh/
 zLlFivW616HeTnGSXewr0egCpYGfXvU1rGAu1XE7shFOI8fS5jD4DVN2RxYBdXTgak9w
 7Hw55xEZz8pFp4KKAt9cj5wUWhV2Bxv2f2WZ//hmL8hoOGdIBk86tUEBvztw3mAP32n8
 +fTfhMyYRJmgNPSWuRu2jSUo9pRZD5ah3oDXorGBDkEwMGPidyDuQnh9MOECcwDGX5F2
 q5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551422; x=1724156222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ge6Dz3VoP6ViJAtrM5PUdz68g+9xNL4aUTYuDgLTzwc=;
 b=vPb+aI+Y0WlKHQrNGXAIgmalrnAvqfMktEe1l6rtfSdJ+wZUyl5j/7lNUZ5Cll7g/v
 hW6tAFz7Onvt5daIA1zGIJlSrK/sXaCGG5/8JDSRbvHGcXAVKzL779V/vyx7IF95gVbZ
 iIgPOrsErPPmNTv/GOWETTDM1TdozFRc0q1N3WaIaWZkkot3enkgRpHjf8U/HS51U1qT
 FF7nFE0Sue5kCnt/v2X2x8b6HAOmMnFjoIx5Gvsv9vvqjxk8RTGRjmekFKC2jgD3cP7N
 AhvONUcxVQA415vqnvuB/ImKzylfT0lef3pvJSrIlT4AnqQeCY7bqVAtH5PTijJ6a8oW
 uLMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKQQKuqDB602DnJdn3MhH+Rgvm9iNH0ylGEen92m9Yebw353W4FvKl3ZViAO2/kiWqEoOQolmAltjFJvPIARJO4zGQCc4=
X-Gm-Message-State: AOJu0YyMdZ5aUB4tWSfrmQQgiG9eEptiH1eopCkMPMh1fhQKnhBSOwSG
 MGOsg/iyqaBrTF/wE5Vg76gTb0AQb9ngJ4yxBUF4iLYFRbSaL51MwDrMvGDA6u8=
X-Google-Smtp-Source: AGHT+IGmGai6NUsmVEh8NypheFo3hp13h5qEYC4P72Hko+cz8f0+kSUbAZNKGcWrryBiJpwNADWC+g==
X-Received: by 2002:a05:6402:26ce:b0:57a:3046:1cd8 with SMTP id
 4fb4d7f45d1cf-5bd44c0cd89mr3223431a12.7.1723551421929; 
 Tue, 13 Aug 2024 05:17:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd196a59ebsm2850932a12.48.2024.08.13.05.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 05:17:01 -0700 (PDT)
Message-ID: <2bde5edc-5508-4c9d-be68-1825353d3a82@linaro.org>
Date: Tue, 13 Aug 2024 14:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 1/2] target/mips: Pass page table entry size in
 bytes to get_pte()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Waldemar Brodkorb <wbx@uclibc-ng.org>
References: <20240813101856.49469-1-philmd@linaro.org>
 <20240813101856.49469-2-philmd@linaro.org>
 <28dd1808-8a10-49a3-b324-be1496cd0aa4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <28dd1808-8a10-49a3-b324-be1496cd0aa4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/8/24 13:02, Richard Henderson wrote:
> On 8/13/24 20:18, Philippe Mathieu-Daudé wrote:
>> In order to simplify a bit, pass the PTE size in
>> bytes rather than bits.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/tcg/sysemu/tlb_helper.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/mips/tcg/sysemu/tlb_helper.c 
>> b/target/mips/tcg/sysemu/tlb_helper.c
>> index 3ba6d369a6..a8caf3ade8 100644
>> --- a/target/mips/tcg/sysemu/tlb_helper.c
>> +++ b/target/mips/tcg/sysemu/tlb_helper.c
>> @@ -592,13 +592,13 @@ static void raise_mmu_exception(CPUMIPSState 
>> *env, target_ulong address,
>>    * resulting in a TLB or XTLB Refill exception.
>>    */
>> -static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
>> +static bool get_pte(CPUMIPSState *env, uint64_t vaddr, unsigned 
>> entry_bytes,
>>           uint64_t *pte)
>>   {
>> -    if ((vaddr & ((entry_size >> 3) - 1)) != 0) {
>> +    if ((vaddr & (entry_bytes - 1)) != 0) {
>>           return false;
>>       }
>> -    if (entry_size == 64) {
>> +    if (entry_bytes == 8) {
>>           *pte = cpu_ldq_code(env, vaddr);
>>       } else {
>>           *pte = cpu_ldl_code(env, vaddr);
> 
> Considering the next patch, where you need to make the MemOpIdx,
> why not pass in the size as MemOp?

Clever.


