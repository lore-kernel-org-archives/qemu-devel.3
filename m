Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3E8C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 13:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA8RJ-0003Hc-WD; Thu, 23 May 2024 09:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sA8RH-0003EU-A0
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:24:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sA8RF-00018V-KB
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:24:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ec69e3dbcfso19546025ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716470696; x=1717075496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SDoJHl6R7aJ1pxBSoVxVFwdD4/9Qoh01icZ746iiZ7M=;
 b=tJv2SKAszGwHRPQAUjMi6nSlSws4ax3w42RjHdzhp365fS7TH7u48jy0nYzAhXJKiL
 p67Gqwh5u2MO3pxQikU0FCbXt7eyHn8kCtnTAdKaLlCn2JZiRd2oTVbO540tmMDwr93o
 zrntJu2NO9i4gSQsz15tboBhZ5DJw47pLS1e93qMZbY6y/+ZpwvoPf5sdizJsqCfKTFL
 jx2ZpOR/YwzqoS9Gg/15WYOfoKtoqrBtLZ2Wcozj+EAhNNBtEd2OKf9kaG4NjkRxL0sw
 W+odvFstCAZ+NHJ9nIWn1Ddt4Gw+YiOMlXU6PsXFeFCTNdCbJgYZWs5XEefnepdyiZ1L
 N7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716470696; x=1717075496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SDoJHl6R7aJ1pxBSoVxVFwdD4/9Qoh01icZ746iiZ7M=;
 b=ZrT9LI4239PdmZaIUJNmP8tcOEEl0j2aL19GsuM3hJVJ4mFwrVNpoE7v6xYS4CJ9rb
 CrVpBFJuDTrZk7VH0ZRYgTeWDWAbXjjr9aecIeW+1BYakV3FRk7mf0YMERDzTOFrYLck
 pX8Ae7j0MXlP4CdiFnrD3FwgXuz60+KfkwBEPXXHtGmhj8W5aZ79vSsqqrqUivp/gT4e
 odkPCeNm1NpCAXt31+iPzSIvc5YoPyRqVZSxIneVFiSi7xIAjFeyX/gilSw29EJ2vcE3
 7hcYhiW5OE3h8kCnbP0Kz9hcQi4fj4RTgPsbluGOSyIl+GSmwDbY5kVFaX02c0Wgugk8
 29qg==
X-Gm-Message-State: AOJu0YwPYP4zZ25EWn42qV7PydbZjCRWr1VWfAFUyV9fjXxSoRlTuwSV
 Q/kjVeQTbKkfWgTgjepfXT/nxYRIgEUGiB/PjUKXyl+ufQ/pmiGQXzLNg3MfE8k=
X-Google-Smtp-Source: AGHT+IGwhdPm7TKbyuyBGO66SWYotPG9WUEZsDg23uESWvB4JJdGaXB2IfAny7R8GO90t8tfZ9IK1w==
X-Received: by 2002:a17:903:228f:b0:1eb:5682:1ec0 with SMTP id
 d9443c01a7336-1f31c9ed2cbmr58534935ad.45.1716470696029; 
 Thu, 23 May 2024 06:24:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f30e2996ecsm48655175ad.161.2024.05.23.06.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 06:24:55 -0700 (PDT)
Message-ID: <0aaa7dd4-5e43-41b6-8404-61f2643adfdd@linaro.org>
Date: Thu, 23 May 2024 06:24:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/57] target/arm: Convert FMULX to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-13-richard.henderson@linaro.org>
 <CAFEAcA_j-iV_r5WA35ULULeqFN99iPJZwrFkYUH7pwCSNsG1fA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_j-iV_r5WA35ULULeqFN99iPJZwrFkYUH7pwCSNsG1fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/23/24 06:00, Peter Maydell wrote:
> On Mon, 6 May 2024 at 02:05, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Convert all forms (scalar, vector, scalar indexed, vector indexed),
>> which allows us to remove switch table entries elsewhere.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> @@ -671,3 +694,25 @@ INS_general     0 1   00 1110 000 imm:5 0 0011 1 rn:5 rd:5
>>   SMOV            0 q:1 00 1110 000 imm:5 0 0101 1 rn:5 rd:5
>>   UMOV            0 q:1 00 1110 000 imm:5 0 0111 1 rn:5 rd:5
>>   INS_element     0 1   10 1110 000 di:5  0 si:4 1 rn:5 rd:5
>> +
>> +### Advanced SIMD scalar three same
>> +
>> +FMULX_s         0101 1110 010 ..... 00011 1 ..... ..... @rrr_h
>> +FMULX_s         0101 1110 0.1 ..... 11011 1 ..... ..... @rrr_sd
>> +
>> +### Advanced SIMD three same
>> +
>> +FMULX_v         0.00 0111 010 ..... 00011 1 ..... ..... @qrrr_h
> 
> 
> Looking more closely, shouldn't this be 1110 in the second nibble, not 0111 ?

Yep.

r~


