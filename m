Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707F8D10BFC
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 15:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4ikA-0006ma-Rw; Sat, 26 Oct 2024 11:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4ik9-0006mF-Iz
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 11:30:21 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4ik8-00029M-0u
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 11:30:21 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so2218319a12.1
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729956618; x=1730561418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfTxuFqUmiwYmDr3LFyoT61E5mTITZq9TJQV8nyVuNc=;
 b=J6ngp2Ht1tBsjLyD9eOYgtLEwIjqUtqliau/jyPThoXEjIRmvck03k5gLE7APm+Vq6
 zegcorIhRcOAOegJxDImq+r2yjf/BFYAcL0SML9kgJ7RYmAhrozrpzrMZWlkREIisefd
 t18NFYT6rZeOXMkUzeQIl3KB1Oz6nlDeZhR4lKwqchVniqVIKWyQJAMSfkorAef+EtGr
 qJUxxfPPi+pwPOJP6WOTQvuqpWkXU4hrg/zeG3TZRCdWUE8b2nNYcz+urZNa20btsY62
 aN7bhc7eXGnC29M5ecMSh+9/I+Vvo+Rwwr1ucpsYT2H1yLW0ruhr+/3QOgXxoTsLKIKm
 9FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729956618; x=1730561418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfTxuFqUmiwYmDr3LFyoT61E5mTITZq9TJQV8nyVuNc=;
 b=hjwlR3Gez71TFiriXj1mNk3LuJAhadIQfIzKampB2K5PYOLrWVaAfoNRf7nccv3UOv
 33edQUf53AcZbTDkEpui2rwDpk1bNFuP/9EOc2gvO716JGgJ7gVYZe7uhBh1OopsqTIH
 QyW9A4LFMuFfkZK+Bjrr0y5VhT3Rwx1G/2VRyB9p4vvsBJX+sc92f4L2gDjAi8TBcFJ9
 uUZxMb1iCsLBuSEh6avE/mAGTVVhzdE6mPvCmtw23VDft3EKaAW96+Q4U3V8YMo1KuIz
 lihSSRJ6YNiVsSw6wHnNN65HCAJsrF/DyQFFYilthAiV1oqJU7shH+/6ZVVS1jJfO3FD
 seHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9pNk4S0IKrwZSR8f4YXNucSE2Ec+DhfGwddFKy75Bgrlsan5o+rk7Qpfh/bAWmgTWoh2vWqLiwEOX@nongnu.org
X-Gm-Message-State: AOJu0Yx0+gu1J9Y3gUIFkzIkCe25EWsco5lM8fNfzJJuBpgd964FnMts
 njXOgc74bKl1zoMyLWpMYm9UtnyTcMJNd1FY7zlgmlu2JvSc2wMNvl7eAydv4N3QAKVJ/0UAOF1
 F
X-Google-Smtp-Source: AGHT+IGRT/tL2+3gwGKAA5rl1y+iwANlu4EsfIvL6DJHh1d8m+oSbifO+d22V+kZ6kFYIF7wREGqYw==
X-Received: by 2002:a05:6a21:1707:b0:1d9:d8d:d0a4 with SMTP id
 adf61e73a8af0-1d9a83a913emr3921305637.9.1729956617865; 
 Sat, 26 Oct 2024 08:30:17 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8495cabsm2906087a12.0.2024.10.26.08.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2024 08:30:16 -0700 (PDT)
Message-ID: <5c894c2c-0b63-4b18-8c6c-07e65e703cae@linaro.org>
Date: Sat, 26 Oct 2024 12:30:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] target/mips: Convert Loongson [D]MULT[U].G opcodes
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
References: <20230831203024.87300-1-philmd@linaro.org>
 <20230831203024.87300-8-philmd@linaro.org>
 <47fa4915-4bc9-665a-5679-4dafc03a5c62@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <47fa4915-4bc9-665a-5679-4dafc03a5c62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 31/8/23 21:29, Richard Henderson wrote:
> On 8/31/23 13:30, Philippe Mathieu-Daudé wrote:
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Convert the following opcodes to decodetree:
>>
>> - MULT.G - multiply 32-bit signed integers
>> - MULTU.G - multiply 32-bit unsigned integers
>> - DMULT.G - multiply 64-bit signed integers
>> - DMULTU.G - multiply 64-bit unsigned integers
>>
>> Now that all opcodes from the extension have been converted, we
>> can remove completely gen_loongson_integer() and its 2 calls in
>> decode_opc_special2_legacy() and decode_opc_special3_legacy().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> +    if (is_double) {
>> +        if (TARGET_LONG_BITS != 64) {
>> +            return false;
>> +        }
>> +        check_mips_64(s);
>> +    }
> 
> This preserves existing behaviour vs
> 
>> -#if defined(TARGET_MIPS64)
>> -    case OPC_DMULT_G_2E:
>> -    case OPC_DMULT_G_2F:
>> -        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
>> -        break;
>> -    case OPC_DMULTU_G_2E:
>> -    case OPC_DMULTU_G_2F:
>> -        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
>> -        break;
>> -#endif
> 
> this ifdef.  But it doesn't seem quite right.
> 
> It's a behaviour change between qemu-system-mips and qemu-system-mips64 
> for the same cpu. Returning false allows another insn to match instead.  
> But we have identified the insn, it just isn't legal.

Indeed.

> Anyway, aren't all of these loongson cpus 64-bit?

The Loongson-1 cores family is 32-bit but AFAICT it doesn't implement
the Loongson Extension, which appeared with the Loongson-2 family,
which is 64-bit. QEMU only implement the Loongson-2/3 families, both
64-bit.

I'll post a cleanup patch on top, since this series is already fully
reviewed.

Thanks!

Phil.

