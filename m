Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0224BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 15:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXMbj-0005Zm-L6; Fri, 26 Jul 2024 11:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sXMbf-0005Tn-L6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 11:11:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sXMbd-0004gi-NE
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 11:11:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so16890615e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722006699; x=1722611499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Xls7OtqHm8jAae+wQ69UEFGfX7RpeLw5Zu+ZpRqCF0=;
 b=bp5p46Ft4RfQvYyLjvFkC80ht1zBRNYIbrhgEcocRFH7p6vcJWShedZp/cHuqdRp/u
 zgIKoMAamzJOZ5FKSwGejTJKjyaEhLTFP5xRh4Ivxsyctgdo1OWvqQxtFaTwwj194PjN
 87EibQX/jlGPwPdSrUPQ6OFDpLdzg0/4d5NhGO8JSshdPZqrmjD/voHmeRUhO28Vl7Sc
 pNj1CaQLOtmGBfyD8kuy6UViisf53PNXFemv9/hKW9Tax+m3twq8EEQsSyFjgpHZMZsn
 D+O4HZ8rRd7X31t+VqE8ZpBYB+hptFTU0jnXrTXfG7LYRRiA47I0NunjvvyUAzoLTpaG
 Sjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722006699; x=1722611499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Xls7OtqHm8jAae+wQ69UEFGfX7RpeLw5Zu+ZpRqCF0=;
 b=MbKYaY8X2BkOck7KFZ40sCAW34aD1sTPxrOHKzQl1TdVuBQlRGfvKqa19U0UxfBE4B
 tym+YoR2OurtbFB/UxDtcc0iopWA5MvgVvBEV0SIaYX53nw5zyz3jhAGp0cho/8Qc6wc
 sEB7hhVvJsnjTzh6g6OZ6CQ4gi9VkkcOy9gIgd/nP2JnRBJ/LpK6D2jbujB1D1sNbNfi
 kxW99E3APIcggkQnJVzbLHhXFtzn3FA8KY3kco3pWh18OA5GdG1WSuICeIpB83ffkQaO
 TVQpR7qZxmqlVYq8gjNY3Csc1frbFHB8Zd5dA3C2ZAOCme9Z957GqmbMdRi14lck4bvv
 OTcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/fkJvq8vEtArPrQUJpzvAhcMLcuUdiiTkMz+p9HW76aokxb/hWFmUMxnwMD4qhrKghDEhgYFnktPT1MzSy4dWvFSob+o=
X-Gm-Message-State: AOJu0Ywtd89sEtuO+WgUioCJCWYW9ao8dwpQOfoKzUf95RAR0PiJk+9s
 +iYYkndVaSmTzQp3LybFENVNH34zWrtoRFb19mHGZJb45AGH4x5nfNwVTRf6g9Q=
X-Google-Smtp-Source: AGHT+IHDl5U0KPrf/CBNanL7EM+cdQt0H6NRVi3FlyNU+wlz+Fxdr+UI7VIbEP5RGLGbyUFzo2DsSQ==
X-Received: by 2002:a05:600c:4f92:b0:426:67f0:b4f3 with SMTP id
 5b1f17b1804b1-42806bd9f0dmr37368425e9.26.1722006699165; 
 Fri, 26 Jul 2024 08:11:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f941352asm122626935e9.41.2024.07.26.08.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 08:11:38 -0700 (PDT)
Message-ID: <4e6446fd-582f-4d0c-b59a-c62034583099@linaro.org>
Date: Fri, 26 Jul 2024 17:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Fix helper_lddir() a CID
 INTEGER_OVERFLOW issue
To: Michael Tokarev <mjt@tls.msk.ru>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org, lixianglai@loongson.cn, maobibo@loongson.cn
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@redhat.com, qemu-stable <qemu-stable@nongnu.org>
References: <20240724015853.1317396-1-gaosong@loongson.cn>
 <25d30b4f-1589-43aa-b99c-fa6fc8529336@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <25d30b4f-1589-43aa-b99c-fa6fc8529336@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/7/24 12:12, Michael Tokarev wrote:
> 24.07.2024 04:58, Song Gao wrote:
>> When the lddir level is 4 and the base is a HugePage, we may try to 
>> put value 4
>> into a field in the TLBENTRY that is only 2 bits wide.
>>
>> Fixes: Coverity CID 1547717
>> Fixes: 9c70db9a43388 ("target/loongarch: Fix tlb huge page loading 
>> issue")
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/tcg/tlb_helper.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/loongarch/tcg/tlb_helper.c 
>> b/target/loongarch/tcg/tlb_helper.c
>> index d6331f9b0b..97f38fc391 100644
>> --- a/target/loongarch/tcg/tlb_helper.c
>> +++ b/target/loongarch/tcg/tlb_helper.c
>> @@ -525,6 +525,7 @@ target_ulong helper_lddir(CPULoongArchState *env, 
>> target_ulong base,
>>           if (unlikely(level == 4)) {
>>               qemu_log_mask(LOG_GUEST_ERROR,
>>                             "Attempted use of level 4 huge page\n");
>> +            return base;
>>           }
>>           if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
> 
> 
> Is it qemu-stable material (for 9.0.x series)?

If this applies cleanly, then yes.


