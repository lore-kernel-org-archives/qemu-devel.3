Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86463C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEtEI-0008WE-0c; Wed, 05 Jun 2024 12:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEtEH-0008W5-4X
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:11:13 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEtEF-0001qY-De
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:11:12 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c1fccb7557so3548027a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717603869; x=1718208669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kzdUr1TxEpYrUEI64YeD7LZlU+wsD0N91PL2OufUtx4=;
 b=AgLrlP1BaKxdNtJE/UOePKEeQ73ebDZT/+J0Q6Rf83PyNsBly1AtnSVf/dakbBYU2t
 9bVm/TKNjXipdeipuQ7NJAOgpDoInc1T2bTZnqYVxw8BDVQLOwUOxQSARBtiZ7Nghgm2
 o2FtYqQjGnqTiSrhL+xh9zeGPmfrB3YzV4Dn5bNPhB5Wu3C8+2i4R8teVwQu8twDZABD
 LrEMp70LfhjY5nNCbaObtTWGUmWrsCV4G9I2/qONwpFFJLwoLbt9jrGQ1H1SxDKWsZ1e
 ZmXiJIFS0pexGW8xjaYSU+3zPm0N8gZ9acXbaKcXkLYMOR4EP4nuBxH5coecJxrisboi
 9jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717603869; x=1718208669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kzdUr1TxEpYrUEI64YeD7LZlU+wsD0N91PL2OufUtx4=;
 b=qjeMGu+b8v+QCaoeAGeo3tS3aiOdOCkuUcfv+0rJz6HM5Oa6OIsaaFIHsjSxdAQHWJ
 5sJG4ySBVhEYVAikeg+6YYwIU6vIOQ9F775V+Qu/oZkvlm1jalQlIRbphU27osKUD9JZ
 VAql1NtBfKVAy/cfWLTFAnMc8I/e0qyIKmg0J7qP/jexc5quRF2LdrFO624HlPiCMZRu
 UvgJaTgqnJZSN4zXIj6HRt0/gH5hPWuYSRwEUtZrUkcg88cyZDmH2i2ftaJcGOSP+652
 AYUSSng74ocZXq4WSYeUzlNeNwaTKEkGAPJpU4yjIRLeRLAbwzOYmFoxQdKCcIMsZwse
 0p6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE4iLDRxt4rdYD+Cg77mBZ4sBiU1/YmznSk0JNKukazp9uxxThhNoBvFUrVcb62jgJdiN3zaXTze7xxB0a4YgwUJliVKg=
X-Gm-Message-State: AOJu0Yx3B8ihKL3peZqQDUQ/CkCp560KK8mO75DlHxntkEIXGrON0mVo
 s69MbV1TL/qs5ReZHd2xo5bxzpsQgLRC88GHHuTD4Y2mBWO6KoVDVUXLhGQ/oT4AcH6SyM+EEx9
 t
X-Google-Smtp-Source: AGHT+IFlEdP1/TtKEsuIx+QZqv1WV+sNhYhb80OETKvn7kJOKpHR2ngQwzKbIXycv/x95hkZRHWgqw==
X-Received: by 2002:a17:90b:194e:b0:2c1:424c:1759 with SMTP id
 98e67ed59e1d1-2c27db4acbbmr3780097a91.36.1717603869082; 
 Wed, 05 Jun 2024 09:11:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806cfa62sm1637151a91.48.2024.06.05.09.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 09:11:08 -0700 (PDT)
Message-ID: <b24f7b87-143b-4ef7-a65d-e1cf0738e4f4@linaro.org>
Date: Wed, 5 Jun 2024 09:11:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/37] target/sparc: Implement MWAIT
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-36-richard.henderson@linaro.org>
 <8e2e8cff-fee8-4188-86d8-55dc1ff5520f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8e2e8cff-fee8-4188-86d8-55dc1ff5520f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 6/5/24 02:27, Philippe Mathieu-Daudé wrote:
> On 26/5/24 21:42, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/sparc/insns.decode |  1 +
>>   target/sparc/translate.c  | 11 +++++++++++
>>   2 files changed, 12 insertions(+)
> 
> 
>> +static void do_wrmwait(DisasContext *dc, TCGv src)
>> +{
>> +    /*
>> +     * TODO: This is a stub version of mwait, which merely recognizes
>> +     * interrupts immediately and does not wait.
> 
> If icount is used, do we need to consume some instructions from the budget?

Pardon?  There's nothing special about this.
One insn will be consumed from the budget.


r~

