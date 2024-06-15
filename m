Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5154CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 12:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sISqs-0004IV-Qd; Sat, 15 Jun 2024 08:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sISqn-0004HI-9z
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 08:49:45 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sISqi-0004gn-SG
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 08:49:45 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-79767180a15so209525885a.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1718455779; x=1719060579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HV5mNCPZ77jnQ76VSFRbcQCZ23m+iPLIdn02i78mfRQ=;
 b=kZXlIuFUmwpCWL5pPcophWUSyacEVZjz0OG+HQdgftGdgG7k1NhnrJR+qsCiRFZnI+
 q7Mb3uMoBBmoOa1PwCh9b+jMDC79wlNGG9+DhSEDCTvqjS2pOqYS8FO39ts3lokteIbU
 PpumTS/GEbB1URL9SyG0xfOU48Mj0wcOcmQZwAsezJbdvQboeznIDeKEqF2fZOT/9/8M
 HJTVT2DLhzz9XQMazU9NcFJadHwurm0V6GUAevhbbFR1yt9qj37iLl95QWi1TP7LpAgy
 de2Fs8wjyUKdsXUqogA9O+0RG2+wYBjU1V744Rj6DFQgmPswXPvOpcDaDPHsWensKGPX
 Co7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718455779; x=1719060579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HV5mNCPZ77jnQ76VSFRbcQCZ23m+iPLIdn02i78mfRQ=;
 b=Cj240Wtr98NUKKuV4slS5UQ05C2HQao25Ku9c/vJbleIRbATPL2pj1kNDC2f/uj31s
 iduPKrV0sDXMHrI/X81EAR5dvfe6VWR0makRW3T6vG/UV88JVSbboRni6pjAASlHGHjY
 +at8p8XeTTw93VXDvKIT0GyaSAielffF2FWE184SoOyaU7LnDnGD+SoDLr4vNHydIF+I
 OF5oNb2A8IpUo+xJIedcW8bve16PEhvOsU8qvoSao8tHYtuV6raJSdUxY8gsXkHzDkH8
 F76N5+NUh4ZPz1FzvHaKKDZImT2gDlu/2DLgOm3MGkNp8HKPMBdh8rLex95v0PXhS9lk
 8U3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRcui08Z0jjmZE41PoAQSs5AcvmiWr8piX8/GEx2eFigkES0NZjU0e6IU20nDFG3t0C6umljf47VeVUONrJcu/9xfSbtU=
X-Gm-Message-State: AOJu0YzugFfssrqII2w/TaD4JuQiIompGUDkkkv2xijU9/7v06ax8yeU
 zzYlapn6B9q4Xmk9Qs3OhFZzqpvhMqy8blU+hOacEnqFEpurAC8tqoaCHvGQNA==
X-Google-Smtp-Source: AGHT+IGEYqnOazYI3rYCcv/HHvaj6TBBKZprvJguP6T49B7gNr7UPPHPQZ4jcY8UDBMwQu7sN2TRIg==
X-Received: by 2002:a05:620a:240b:b0:795:9ebb:fc16 with SMTP id
 af79cd13be357-798d269429emr568266385a.59.1718455778788; 
 Sat, 15 Jun 2024 05:49:38 -0700 (PDT)
Received: from [192.168.86.22] ([136.56.85.135])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abe6b292sm240385385a.132.2024.06.15.05.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jun 2024 05:49:38 -0700 (PDT)
Message-ID: <e4134c3b-a2c8-421e-9aec-ad9d11e66d3a@cs.unc.edu>
Date: Sat, 15 Jun 2024 08:49:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] Move tcg implementation of x86
 get_physical_address into common helper code.
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-6-porter@cs.unc.edu>
 <50b39d95-be52-447a-ac57-c1478597a768@linaro.org>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <50b39d95-be52-447a-ac57-c1478597a768@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/7/24 1:03 PM, Richard Henderson wrote:
> On 6/6/24 07:02, Don Porter wrote:
>> Signed-off-by: Don Porter <porter@cs.unc.edu>
>> ---
>>   target/i386/cpu.h                    |  42 ++
>>   target/i386/helper.c                 | 515 +++++++++++++++++++++++++
>>   target/i386/tcg/sysemu/excp_helper.c | 555 +--------------------------
>>   3 files changed, 562 insertions(+), 550 deletions(-)
>
> Why do you want to move this code out of a tcg specific file?
> I think this is definitely wrong. 

I want to share the get_physical_address() code with 
x86_cpu_get_phys_page_attrs_debug().

I assume that newly shared code should migrate into a common file, but 
happy to adopt another strategy.

Best,

Don


