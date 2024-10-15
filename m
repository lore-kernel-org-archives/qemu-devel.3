Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738DAD216B9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iim-0007gV-BB; Tue, 15 Oct 2024 10:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0iik-0007fx-DW
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:40:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0iii-0006Bz-Sf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:40:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c8b557f91so44386935ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729003219; x=1729608019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sgVVr8AOW6g5csJ3f+5fZgDDNiRtMxSGDiqjO51EeNI=;
 b=RF3WA1aXaFZXk1ln4Y3Ttpc9OcqqwilQ9zGujvIyHj4CUj802D/10HC+uAn/0V6Dwl
 fleAJVUBJzEbUNt5BefSlA8FPmiWfs92g7pqsvfXCWSzMTCToxzVdeppsw/kZl0i2Dv+
 N8gl1+G/iez7dZxmo4D+thcl7uW1A4TCF0uw14pYadPRNO3+ILejgteI9epHpskvOUjf
 IApuoAAt81PyJYSaSD1Hf/kams52+RW3NrWEMgWt1e5eAPASjqTUrrSfJHHHPlc9FBD9
 vwJDme23aojVfXN/ZDTE0MnN3HO7gOju6rQXNlDXoeaG27mkBvXbRywmCk1HLew4rNEj
 J8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003219; x=1729608019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgVVr8AOW6g5csJ3f+5fZgDDNiRtMxSGDiqjO51EeNI=;
 b=m4HryiGoeCg7sB+CtkDbLElKdrjwa8yZwJ1zJGRdpp0UuS9ONDHpBFeqIWkzNyznbo
 6xnPkN2uX6XOYG5Eoc0YJLp88e0JkLpGym3pq2l8KkMm0Plg4sZ5qBUD2dtg00StqKFJ
 hDYvLbfFViSlGPyOmYEgmyB5qIrKnNzG+8z2psxyxyvkaQsgwiPjblbRQUR+BD+ozkqg
 w+IM0cf0oHvws35yPu0UHTWnHJrfN5tTTVzeuOiYocg+AaVER1AaCAhDFQvMPjg/3mqt
 ySJ4MosFLcQYcEpFA47zVYUFougWxmsxpq6oRYWYHBISYk88VToygnob83rik49xa+OU
 zOIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzzw6AWltgkVBbE53fszs0H2Tg0G7G7HIWDc66Fu9zFYLqWM/kf0sjGlfBQEE01KaEVki5YwEKfNP/@nongnu.org
X-Gm-Message-State: AOJu0Ywjm4ZKeLYRvKKvi7fuM641bEDUDFdBKvYSqTYyZ9jFNZn2mmSC
 tYUbv/jsb3RcyIoRIWMtqRk1QSLO+2P8Ltjjac3mKXtNms+Vu76OqKPD0MTr/Mc=
X-Google-Smtp-Source: AGHT+IHg1FnI0ltz4Pr+cJQSK2LcrMUgQ7USk9I1dTk63Y1Jt5nsKn3lxFVdVYpioK3trmLz0Iw1Wg==
X-Received: by 2002:a17:902:e5c2:b0:20c:d2e4:dc33 with SMTP id
 d9443c01a7336-20d27e9ac61mr7655795ad.14.1729003219354; 
 Tue, 15 Oct 2024 07:40:19 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84534sm12806695ad.9.2024.10.15.07.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:40:18 -0700 (PDT)
Message-ID: <926da796-8146-4672-92f9-dd79c3bd51b6@linaro.org>
Date: Tue, 15 Oct 2024 11:40:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove unused MEMOP_IDX() macro
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241014232235.51988-1-philmd@linaro.org>
 <1574ce74-3339-40f6-b484-47bdcd891eca@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1574ce74-3339-40f6-b484-47bdcd891eca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
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

On 14/10/24 21:09, Richard Henderson wrote:
> On 10/14/24 16:22, Philippe Mathieu-Daudé wrote:
>> MEMOP_IDX() is unused since commit 948f88661c6 ("target/mips:
>> Use cpu_*_data_ra for msa load/store"), remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   target/mips/tcg/msa_helper.c | 8 --------
>>   1 file changed, 8 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, patch queued.


