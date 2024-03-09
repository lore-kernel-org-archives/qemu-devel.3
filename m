Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CF9C54E5D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj3FC-0003Sv-Vt; Sat, 09 Mar 2024 15:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3FA-0003SJ-4G
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:24:32 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3F8-0003lE-L9
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:24:31 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so2330393b3a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710015869; x=1710620669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ayaSpTZhb2VmSE/UMFn/OJtKT05eq7WtYScKvaXvgY4=;
 b=D7h79xqttgOy34dMYGSmW2FwMiQsnkeqYF1R4KviWfiPZEQRICyn6mw8o7CwLEbVup
 945e7iGcFjRpCK3xGiqQxtDpMHrwB15JGoceYEGhrLFMdBO4UvzxQqz2vwrIOG8Y9l3T
 9GH8getFGhJzInvRqiHFOiO5/245o0I2AagTdSyBXigLhrA7/iZb5zJ5cFTrFgTHEu2H
 BeoADx+hD/Dujcks6xGtfIAgk2XVil9k71YoOiCS5EAsEyNbpQ3UcfFzn1piihXPAeg4
 1pW6PhjpPfpHUbJMzLS2XUC51+M2lFE/c6r3aFItsSuXzeh44OVhDRizcJrsBHcaz1pP
 Vb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710015869; x=1710620669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ayaSpTZhb2VmSE/UMFn/OJtKT05eq7WtYScKvaXvgY4=;
 b=gMBLTQnAVKDzUzdGndPNPKxEPIcwVHHxncGWLzP4bVualw8nIjneIpfiDrWDUiQWUF
 V5jkMECT4wPxSBTpAX9echiiE1fMezxBrp+6Cn4TwqmCXwJfceK0bjQItWR/m6Egl9mB
 nW9dvCtwEf5IP+eUdIdVoV/SylwX3t438jRwkomm9xVuwyrHERysBbno2weXm/okeaeF
 U8xtTyF9ItG0Vjsql8iOSCuhoA4/E0xYGccGdFoJJtGWWV9kb8WA2vjfq1Kx5INpyXZz
 Dp09KRyoVV0jSQnIPJZWZPgdwUfHZ2UH7jblY6KTHNRiRsC4g4hu+A1baSR66KiWkUSJ
 DTRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuPXXteV1dgoAk+c13T0CV5tz0pvDzzaFxrIuLUydLh3xdalSHCvENnvPPcv04saTD/QvzabTlP3MCkcAFjlEIhLEC250=
X-Gm-Message-State: AOJu0YwVFl+dvqc9RkeL0PscXaIGCtC0c1Xe8WmZsGGq7U91zrpyvaYY
 hK7U+kR24nPgiOZixv1s6aYSp1XjoagSo/5qhr2N1EW7gdkvUiU8LHXM+XwfoCY=
X-Google-Smtp-Source: AGHT+IFN6UxqgR8DLBuVcIqjo0dguIX7pbkVZsK2PX7yuWvbgt1oysj3pTEt0uI6pvtks6ZD4eGSew==
X-Received: by 2002:a05:6a00:2d0c:b0:6e6:88ee:8429 with SMTP id
 fa12-20020a056a002d0c00b006e688ee8429mr28120pfb.11.1710015868735; 
 Sat, 09 Mar 2024 12:24:28 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 hq18-20020a056a00681200b006e60c08cbcasm1614912pfb.50.2024.03.09.12.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 12:24:28 -0800 (PST)
Message-ID: <ac17a1cd-0179-45e2-9a51-ab6f5149239c@ventanamicro.com>
Date: Sat, 9 Mar 2024 17:24:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] riscv: set vstart_eq_zero on mark_vs_dirty
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
 <fe056cad-e711-445a-be26-9a0625ae0665@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <fe056cad-e711-445a-be26-9a0625ae0665@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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



On 3/9/24 17:14, Richard Henderson wrote:
> On 3/8/24 11:53, Daniel Henrique Barboza wrote:
>> - patch 7 (patch 3 from v7): do not remove brconds from scalar move
>>    insns
>>
>>    trans_vmv_s_x() and trans_vfmv_s_f() does not have a helper that will
>>    handle vstart >= vl for them, so they need their brcond.
>>
>> - patches 4 and 5 from v7: dropped. We're not removing all brconds, so
>>    we can't get rid of cpu_vstart and cpu_vl.
> 
> Not important for the bug fix, but for future cleanup:
> 
> (1) Use movcond to for these moves instead of brcond.
> 
> (2) Use explicit load/store in these two places where cpu_vstart and cpu_vl are still in use.
> 
> (3) Now there are no tcg globals that are modified by the vector helpers, which means that they can all be marked TCG_CALL_NO_WG, and any that never exit via exception may be marked TCG_CALL_NO_RWG.  This may reduce register allocator spill/fill across the affected helpers.

Nice. I'll mark it as a TODO to get it done after we get this series merged.


Thanks,

Daniel

> 
> 
> r~

