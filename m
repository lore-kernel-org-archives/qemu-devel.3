Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFA5C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOgI-0000bx-Cj; Sun, 26 May 2024 20:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOgF-0000am-Sz
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:57:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOgE-0004s6-6V
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:57:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f48bd643a0so4169065ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771457; x=1717376257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Trk/VqSOq8JtCHrzWWeFdORzKwC0HSCtaGIauIbmxck=;
 b=ELW3eRqA08c+Llo7sRYiW7hAU20bXI6Ub55Ghz9gqalI0D0Ka9VxyyoUim1GR+sXDa
 cueaIRwtvvF0yY3Hl2oE+rglMTftrvRTJkK6qzNRdyyJFOIwAlBHuMil2cnfvlKxZU4n
 iITvQPfqdFmXk1ninG6jQKRA8kuhF35QkfPAEZbiqcyrmXET5SjA3nwX5v/agvZOe+zB
 wV4TPqGONniSG1aKmrO01VPPw0k37ix3aJVnW+AS7mpMkosEv+jjOFe9FN1OcMrx6NvG
 KyKUkcTtfsR7aMRaOoYIZyHxlHHfBIgU2j84DU99+937Ei4J2PNJf081XsjCcxXQNCou
 oTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771457; x=1717376257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Trk/VqSOq8JtCHrzWWeFdORzKwC0HSCtaGIauIbmxck=;
 b=d+kidH6Qltz+Kf9ZyDW1NipA/KeT4yTbghZh/G10r8EG4iEAdD6vuXxHbss2IYv4Vi
 Rnv5JjdUPEaT9eR27UdVzb7nmJNT3MDkO42rXethJJo857IbJs1HI2/f5qr1MSNhJV7h
 gX4T4Wbtdlx3Vpd2ooFH4oI2cvgwB13ugdezSIioEsdHkOC5hlG5KxE3aVeZqUWjpsgE
 1aqFkyA+jg1DzibMXfRJJwJ6taOCwZbqzGnxpn3yHgNyMvLW5Ta0mLwhiWor6OI6PiHL
 sNxHhX8qbICgoP9tAFJtdpSjleBYSpe/zj0ItN3WT4+vZEn1gtmHrWw2AdTVjcp6X9Sc
 fMSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpK81r530rBAlVyytEJtjNJK2FPjm5RqeD1SV9p8lM09N1e1HTOm9ugn0rit/pEz9ih4FYBtgMTMlpRQI9VdohwuNrenY=
X-Gm-Message-State: AOJu0Yyj5tn1fPsqFsJXzGBf5M3RIFwyfheH3gkOnAzgc+4XMNs/DkgB
 vDGz5KEWJdUUm83w0IlkD/scqNvunoD4sVTJ/HSpiwqTnjaIatiizzeqP+YEt4Fg5y7T6+B9AHb
 5
X-Google-Smtp-Source: AGHT+IHe/VJ94zOFXRp5wLXimwcFzQ1Oc4i6UCe7ZNfJVmE7rLlhPHTcBLB9ciiNVCI2Z5Wp7xlbkQ==
X-Received: by 2002:a17:902:6845:b0:1ec:5104:c75a with SMTP id
 d9443c01a7336-1f448f2cd70mr76621585ad.41.1716771456566; 
 Sun, 26 May 2024 17:57:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9957ddsm48621395ad.190.2024.05.26.17.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 17:57:36 -0700 (PDT)
Message-ID: <e5f8d608-09be-453f-ac85-e56118e2b7e1@linaro.org>
Date: Sun, 26 May 2024 17:57:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Disable SVE extensions when SVE is disabled
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20240526204551.553282-1-richard.henderson@linaro.org>
 <63ff94b6-98df-4e5e-9c53-7a03c7309cd3@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <63ff94b6-98df-4e5e-9c53-7a03c7309cd3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/26/24 14:06, Marcin Juszkiewicz wrote:
> W dniu 26.05.2024 o 22:45, Richard Henderson pisze:
>> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>
>> Cc: qemu-stable@nongnu.org
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2304
>> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> 
>> ---
>>
>> Marcin added the correct patch to the issue 3 weeks ago, so I'm giving
>> him authorship here.  I only updated the comment a bit.
> 
> I am not fully sure is it everything needed to be honest.
> 
> Value 0x0000 in [3:0] means "The SVE instructions are implemented".
> 
> The way why it works is probably because QEMU keeps "there is no SVE" information 
> separately and do not emulate them.

ID_AA64PFR0_EL1.SVE is the primary indicator for SVE.


r~

