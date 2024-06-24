Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76EDC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 18:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLoC0-0005ou-HW; Mon, 24 Jun 2024 14:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLoBy-0005mR-Ba
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:13:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLoBw-0006Hr-CH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:13:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7067a2e9607so1390299b3a.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719252803; x=1719857603; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=To879kbmj98rQJFzRHOG6QT8ykxiEfUK0pRX7VF1lzQ=;
 b=Pbx3XIUDaHH/IW2w/SivbrNYlPOqz7xDGitlWzgCNWeU3dNtVNMCs/Gr7bNaKLoVI6
 eSrCc4YxBAQhodxiRqb2f2LUZyxTn6yE6sWzK8BKow+7B9MQfyFSleAC3jLpDFPGRasW
 hkydJWeDXnB8FVPkTA7ZydP53O/7GjVUz+nCIsMjgBJLBy58oAdOuMfizQ5kyqGFv//9
 PMr9ue2ywbVE+zeuwP2696MZzwzmw4ka0atuYOrChrQPPuoE7YvRdmCD8KUJBfI34ynX
 eIr7EWfEexC+YFV3iJbpoa6B2IqwtiwZ0JcPPz/q4HovRrL0W/IpMO1v9vvlp3sitM2G
 mwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252803; x=1719857603;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=To879kbmj98rQJFzRHOG6QT8ykxiEfUK0pRX7VF1lzQ=;
 b=Z8TDr4zb7ZbpEm0mAJDAB1brXYaUDAwepxVyax+/Gz0z2dascGpAR6K/RZJyFxzkxa
 yFQ4qQhXqUe9wiP2YnvV8AX+TAKh8HqMzExHNNS23XxeJFhnfM6zhJYkYxD/rHipANqk
 YBVsvRPpUxnK50NkqVUtYpTgYRs0NB5t6VgQavAbHba1q5hyw9xBPlFHG5c6+l7anbQu
 NifC2/trGNPZtM/TKPUee7o6MliAwOmZKQHtMzupOTr87aqJejmfeQ57h2GoFl5WfVQA
 sS4Cxr1XPXrIfcYVazE5b3SG0ZkGKqFLnTJen6mS1zDGflwPT8CvuWkkHPwaQA/k1sNn
 y9/A==
X-Gm-Message-State: AOJu0YwprVSG7beZVpTA8JLa3DSpCD8lSu3RiCytEilga5o6m+lVYYuD
 Sm9nKKQdKRo6PJZduCaCjHy3X21G486wz/9DezAfr7fr3dwdgxkwPBIuWX20MV4=
X-Google-Smtp-Source: AGHT+IHVSH/j01uVuXHrMbCXLERFueArHvLTC8+Nl4j7+9uvYrZ3bPUOFxCy+OBwsHqYmNYOn8iWqQ==
X-Received: by 2002:a05:6a20:7b1f:b0:1b4:82eb:61c6 with SMTP id
 adf61e73a8af0-1bcf44391damr5258931637.2.1719252802691; 
 Mon, 24 Jun 2024 11:13:22 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b401:1758:f7d8:1e03:a6d:61a0?
 ([2804:7f0:b401:1758:f7d8:1e03:a6d:61a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7068922cd19sm1812456b3a.107.2024.06.24.11.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 11:13:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] target/arm: Move initialization of debug ID
 registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20240621143903.3598230-1-gustavo.romero@linaro.org>
 <20240621143903.3598230-2-gustavo.romero@linaro.org>
 <CAFEAcA-W6KdKonrzf2UqAVODZLiUJdTzUiNLUeiq+Qe-W-KHQg@mail.gmail.com>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <72424620-6a2e-333d-75ae-3ae9dc0920ab@linaro.org>
Date: Mon, 24 Jun 2024 15:13:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-W6KdKonrzf2UqAVODZLiUJdTzUiNLUeiq+Qe-W-KHQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.232,
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

Hi Peter!

On 6/24/24 10:26 AM, Peter Maydell wrote:
> On Fri, 21 Jun 2024 at 15:39, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> Move the initialization of the debug ID registers to aa32_max_features,
>> which is used to set the 32-bit ID registers. This ensures that the
>> debug ID registers are consistently set for the max CPU in a single
>> place.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   target/arm/cpu.h       |  2 ++
>>   target/arm/tcg/cpu32.c | 30 +++++++++++++++++++++++++++---
>>   target/arm/tcg/cpu64.c |  2 +-
>>   3 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 3841359d0f..d8eb986a04 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -2299,6 +2299,8 @@ FIELD(DBGDEVID, DOUBLELOCK, 20, 4)
>>   FIELD(DBGDEVID, AUXREGS, 24, 4)
>>   FIELD(DBGDEVID, CIDMASK, 28, 4)
>>
>> +FIELD(DBGDEVID1, PCSROFFSET, 0, 4)
>> +
>>   FIELD(MVFR0, SIMDREG, 0, 4)
>>   FIELD(MVFR0, FPSP, 4, 4)
>>   FIELD(MVFR0, FPDP, 8, 4)
>> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
>> index bdd82d912a..b155a0136f 100644
>> --- a/target/arm/tcg/cpu32.c
>> +++ b/target/arm/tcg/cpu32.c
>> @@ -87,6 +87,33 @@ void aa32_max_features(ARMCPU *cpu)
>>       t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
>>       cpu->isar.id_dfr0 = t;
>>
>> +    /* Debug ID registers. */
>> +
>> +    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
>> +    t = 0x00008000;
>> +    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
>> +    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
>> +    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
>> +    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
>> +    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
>> +    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
>> +    cpu->isar.dbgdidr = t;
>> +
>> +    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
> 
> Looks like we should have an initial "t = something" ("t = 0")
> before this line? Otherwise we start the DBGDEVID value
> with the value of DBGDIDR.

I'm setting all the 32 bits here so there is no bit left from previous t value.

But I agree it's better to be explicit here for readability. Done in v3.


>> +    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
>> +    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
>> +    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
>> +    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
>> +    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
>> +    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
>> +    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
>> +    cpu->isar.dbgdevid = t;
>> +
>> +    /* Bits[31:4] are RES0. */
>> +    t = 0;
>> +    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
>> +    cpu->isar.dbgdevid1 = t;
>> +
>>       t = cpu->isar.id_dfr1;
>>       t = FIELD_DP32(t, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
>>       cpu->isar.id_dfr1 = t;
>> @@ -955,9 +982,6 @@ static void arm_max_initfn(Object *obj)
>>       cpu->isar.id_isar4 = 0x00011142;
>>       cpu->isar.id_isar5 = 0x00011121;
>>       cpu->isar.id_isar6 = 0;
>> -    cpu->isar.dbgdidr = 0x3516d000;
>> -    cpu->isar.dbgdevid = 0x00110f13;
>> -    cpu->isar.dbgdevid1 = 0x2;
>>       cpu->isar.reset_pmcr_el0 = 0x41013000;
>>       cpu->clidr = 0x0a200023;
>>       cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
>> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
>> index 0899251eef..71e1bfcd4e 100644
>> --- a/target/arm/tcg/cpu64.c
>> +++ b/target/arm/tcg/cpu64.c
>> @@ -1167,7 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>>
>>       t = cpu->isar.id_aa64isar2;
>>       t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
>> -    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
>> +    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
>>       t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
>>       cpu->isar.id_aa64isar2 = t;
> 
> This indent fixup is unrelated so should really be its own patch.

Got it. Done in v3 so.


Cheers,
Gustavo

