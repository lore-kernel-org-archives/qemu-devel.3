Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF1AC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYD0S-0005ZW-PE; Wed, 15 Jan 2025 18:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYD0N-0005Yu-Nd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:40:59 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYD0L-0006MT-1e
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:40:58 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21675fd60feso5521715ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736984455; x=1737589255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eU4s+1LjKlD9KbXrZMS0oJ8bcsP+ZYXoZaUXV7g+A9M=;
 b=WnlLD3azBRmjx+sj+2k+E5bkF0Rq6TZot1phPdbzZQ5Ywc4ih5rNNCNFG3TQq8bVnV
 POQk1KaqmOvV3T7RfdnkKehFlpx9TLY+NTbly0J9Ktar9fQknYS5rhrzSfFR901XXJq7
 S/AmmYIPYeSo/uz13Kpa9340SL/HqEtWXi56x7ATAWRlz6rsdOqCTZoXFAKAigGrhijb
 ARc6vdkb6rJEEbKbtwjhYSK4it1jKYcq+kQxvJwzBdIbCpUl+x2Oho8Si2k6ck1jFsKz
 hbpLIpExQbwgdR8ISbbLls4X8kditDJYC+WZF6yWGFAhdT5tg8/nebgkEeg52FlEPsAr
 2tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736984455; x=1737589255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eU4s+1LjKlD9KbXrZMS0oJ8bcsP+ZYXoZaUXV7g+A9M=;
 b=i4Q22jQCy18FtsIYEdYHNCiRqdzF3iHghkzUGvE756AsoN2jeBKG3EOwMLvqQIVKoI
 sDAL1opupFBWaEAkmtH1Bsrqpy9JF+2a0EOEY2PSvPmPtXO4uzpp0UuvJZdN7vSKPleA
 l5qtU0oOL6e2aqCRN5IWfep6rOUhKZ7cba2NsJ2Ug1C3SaNKGYJ4KEESrmNZpZvBsHa3
 KA6gZCiS0g7rYiO2ilwqfwIg3aPkX3pK7HXXxgBJUvZ3+gwiklCDCV1MEPMLegZ+lA9I
 07gbAFCyIKz4U7QpFOS8UcGU346qpxwcQ6JGSn+KLw0OeYGG8MhvO/wKLoe3eiH72EqT
 Tp8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhsYYil91UcOlzlFP++oWkXCCGN7sMJlU/j2FsVlkQZHHUG4xIryX6BDfDT8xaMKWqrHIPf6ii9MMb@nongnu.org
X-Gm-Message-State: AOJu0YwFlgfCfYMyeXTg1V7Co+ylDNEClNpT/qoSqkL4ATYdlV5u6m9U
 bIibkhjT9QIADc2ruBz4amtKZLz0OiuFjLt4z19WfTwVuehzw5Ec632aWxH51uo=
X-Gm-Gg: ASbGncsVqRxoJJmUyHSbZ2iTuePaghe3EcaLhFIKypbtjoBzcTfPphEPwxIrQG7BhR/
 7vnV/zlhiQ78LIBgJX2e78DxXYz43bS8FexAbGZvTRM67xNMs2uQ24qpuZG9150iZr7ye7w7FQr
 hO5ybA8YLlUWTbCBsOcXigdGsoHH5bVFmoE6jo3ozjk5SCjZHTbiLuBvmLN7Lgk/RjcKax1nVnV
 umbaCc8IjLqOZJDyr1XWzZ8yftTzblgo6C40K/q+J2VlmVOm/Yv004DRuJ2uLkNKg0xlgRQBUAm
 EXIPFn/ogwhOKo52bAtHymk=
X-Google-Smtp-Source: AGHT+IE3Hn5YvpJ+8RzUNtzYapaR+sOj2jheCQuaOSmjYB1+kG511yj7V4l/VXGUahLuLCDec3LXpw==
X-Received: by 2002:a17:903:2452:b0:216:6f1e:5799 with SMTP id
 d9443c01a7336-21a83fe4f75mr484166125ad.35.1736984455140; 
 Wed, 15 Jan 2025 15:40:55 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10df7asm87335225ad.47.2025.01.15.15.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 15:40:54 -0800 (PST)
Message-ID: <f05247a6-b4b0-4c06-827a-74b3fe4d4f9f@linaro.org>
Date: Wed, 15 Jan 2025 15:40:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/81] tcg: Add TCGOP_FLAGS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-6-richard.henderson@linaro.org>
 <8ce2bb26-b2c3-4665-bb1a-2576859aaaca@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8ce2bb26-b2c3-4665-bb1a-2576859aaaca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/15/25 13:16, Philippe Mathieu-Daudé wrote:
> On 7/1/25 08:59, Richard Henderson wrote:
>> To be used by some integer operations instead of, or in addition to,
>> a trailing constant argument.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
>> index 5d96cdfc30..e80b1f6efc 100644
>> --- a/include/tcg/tcg.h
>> +++ b/include/tcg/tcg.h
>> @@ -440,6 +440,7 @@ struct TCGOp {
>>   #define TCGOP_CALLO(X)    (X)->param2
>>   #define TCGOP_TYPE(X)     (X)->param1
>> +#define TCGOP_FLAGS(X)    (X)->param1
> 
> I skipped this because there was some code smell around I
> couldn't figure. Hopefully a typo :)

Yes, a typo.  Thankfully this field isn't within these converted opcodes.


r~

