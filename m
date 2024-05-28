Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD3AC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0kn-000816-Vw; Tue, 28 May 2024 13:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0km-00080i-C5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:36:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0ki-0004IZ-BB
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:36:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f48b825d8cso7894225ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716917807; x=1717522607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xCDiTt6p/0bpo1vXcLmdnlVV+ZcokWvrYX81UhRezBw=;
 b=giaInYFgeJYJ4oeXSXbZ0PFfdGpJ21BlTA4PvZRxrMzcNjjPYdDrAxst712xot6C0f
 Tx3NGZqHDhzuB0VB/f90AWh3IS3zC5cmWQVA+B/oU/aLeMDcQJhhbPyS2aT8RezRZwvL
 X4m52MuCpeS/A5MH/wDHtNrPfdPhB5sE8MmVeKuzJUIa3EwrRaA86+PZihbyEQIWqnoR
 xQloAui6UwuqFSFhONk1BJI54UQNlikSbGLUlahZAiNHmaT9Kf8IAxYi51H6/bJLE/1i
 qTlPL5WDsOzoEEDAFdS91eaT6r83imAQnfEheLELV7ANypFpt81xpyI8HlC5FqA8VuxH
 j6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716917807; x=1717522607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xCDiTt6p/0bpo1vXcLmdnlVV+ZcokWvrYX81UhRezBw=;
 b=sc7xTPn74Wx0kadJk3Uz7JRmiX2ivJnKqfXZ1AJjzRWTQQw/R8R327THiIlIfTBz2p
 orghX0GpwNSpJyvYps8DUDJIMcwBz7yXkvgIQt6HcsUg+6kpKb9FEZ97XC9DBjaf4Kgr
 PVEebQzdvgbKYtGvCwUkb83KkM7E/odpZqC9jlvbE5sKDLZiNjsfk2RJ/nMHU4IPRFl6
 aMBWxnFpzi8G93euMAkOuZD3583/bfa46bPsUK6hZxBtK/eOfOg5pSEjhqtYzza7t+Yw
 PH1J9Hwh049yMtwD6F9Ay2D8zkO4EQUsb0zXcY6rfOwPK3DfNPFLmptZWg5own3Dha20
 ePJg==
X-Gm-Message-State: AOJu0YxB85DAkx/9taGh7mwW3kdRID3IQ5DLuMWHwkeZrPq25VrjbhGK
 HgbNHeNsiTNbn/iGyFjZbROHhziSlUJBLAo3qBGhVEIwfkCzD8f0T+C5bWXdnVe0BWI8D4sOM1f
 7
X-Google-Smtp-Source: AGHT+IGUk6hLhgmOxzQ9+XZJNo/gry6JTEkhnOwORodZfJeGg1xdY61lsma7XQxA3FdxIhZa7RSpaQ==
X-Received: by 2002:a17:902:f686:b0:1f2:f3dc:43ee with SMTP id
 d9443c01a7336-1f4486b95d9mr150095135ad.3.1716917806748; 
 Tue, 28 May 2024 10:36:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970058sm85279235ad.121.2024.05.28.10.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 10:36:46 -0700 (PDT)
Message-ID: <3f1baa61-c623-4b5b-b724-15bb68a2df3f@linaro.org>
Date: Tue, 28 May 2024 10:36:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/67] target/arm: Reject incorrect operands to PLD,
 PLDW, PLI
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-4-richard.henderson@linaro.org>
 <CAFEAcA89_nWDXhXKds3gezUyXdXfO61bMNgSn=em166ufgQAbQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA89_nWDXhXKds3gezUyXdXfO61bMNgSn=em166ufgQAbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/28/24 06:18, Peter Maydell wrote:
> On Sat, 25 May 2024 at 00:25, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> For all, rm == 15 is invalid.
>> Prior to v8, thumb with rm == 13 is invalid.
>> For PLDW, rn == 15 is invalid.
> 
>> Fixes a RISU mismatch for the HINTSPACE pattern in t32.risu
>> compared to a neoverse-n1 host.
> 
> These are UNPREDICTABLE cases, not invalid. In general
> we don't try to match a specific implementation's
> UNPREDICTABLE choices.
> 
> I think we're better off avoiding the mismatch by improving
> the risu patterns to avoid the UNPREDICTABLE cases.

We do plenty of other treatments of UNPREDICTABLE as UNDEF (e.g. STREX).  Why is this case 
any different?


r~

