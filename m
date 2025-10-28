Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3131ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDe9q-0004GV-PT; Tue, 28 Oct 2025 03:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDe9n-0004F7-SN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:30:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDe9j-0004gR-Pv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:30:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4770e7062b5so16685765e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761636607; x=1762241407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xyANYjjV10UDF+T50gbCHcgIpok8er4K0zkDpNe+6BE=;
 b=sQQZZ5cCXb/UFVe+kJPzuVS1oTG94CFmHhduYAirC77RcuXRmBRFYYYWTjXniF7fVg
 l3eiajh1+7H7zNZerpPVU9Bup6wpL4stmT+BMlilMRTzqdayBALmYjreyOoLDblSyS20
 JAm1XNuXic8bbY9ZK5bXywwFCJNDK34JuMXOAstGTZozWdvCXbnbUb4T/ZNk2wxOwARp
 5OHxTZcNttPf4JltUYenxaK7wCJdev66F34b4maPXkF4gIADmORnenL8iAZzrkErYo5o
 ECtuUcqtzp+44Y2JbgMDV5GBCS6W0fW5Wo5pbzftHcMnNpbQNnXVdCP34/umxENxpFTz
 CzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761636607; x=1762241407;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xyANYjjV10UDF+T50gbCHcgIpok8er4K0zkDpNe+6BE=;
 b=dnalU/xJPrP6wy46F6jFxLlej4Uaeb8RfJKvSl4P0qSzt/9vL66C+EejfQrxIfX2uN
 usfTXNYxM5BblOD6PiN1CV8Bb0wmUiE1xt58Bbv49Zd4xiBM4F48+FOEznuBxVqOGLkD
 XJWKQJTT5En8T94ctOlyUyS+KzypeIa77MSsr0xkhEagR+NZFjuF3XBnkSJ634Sb2Pys
 gXWHbuJqvZcIgkXjei7zL2zGzIJHj8ykbxNE60FL9WoDBRusJqLBIW8UeyAGWCKn7Af4
 3SDi764WikcKT9E6HUzqOa7XeIM8fQZVB4pguUqJ2IvrDvBAM8kYgXn50Fo6UNEvr1mN
 35lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWbg/uHd7vd1+q/shgBUyKWiFzl5oaDIO+ntSKL7gmxroLpTJbrUsg+At8Dw5w9tEdzwz9493Ol6jR@nongnu.org
X-Gm-Message-State: AOJu0YzAvI4mz5FKizfL8xCw30W7pI3Cv4tZ4HQ24jIIAo1uHMMYA4lC
 Xr4YtpxlxvqGWZEhlDLhQFe+BzEZi5yG52a1W07qeYe4MDcNxOrghsipFWhhCgO+y9Q=
X-Gm-Gg: ASbGncs9BDmnUXv0rawj3derClzHm4fPg6hXDc0jqRfQfa3wybSVKhIiU+8KrK5oyZP
 Rljh3C13GGJqh8XqIxqVX+oBRpFUWGCk8eWanF/MA68DUwxqRYVm9K2pJmDtQ/KjUpLwfSlmvGJ
 YYYo+vzDkRJGuGyRUwjTYWooz0eZG0PRrAnXgKPAW4OcJZ/OWhRyk7HVjHIW3yxIZSqI0J8oiMy
 XIA5Ch0uv88G0w9oTNA2rf8WFYefVoAwJiQH+/ish0JBUROTlhAKpmO/Bd0rCPojMSm7fsxPpHT
 L9h6dH+N1hY/gVKddzCeXEDx316eKY8XPGdtn+6GjUCchRupa3PuelKwsjPJgd2NXskSDGY7NdZ
 1YAoUJ0DdXr3+b9ywUdmpv/xa8AX4RcKkZKUyXWEel5pdAPlq1qzJDNbMIv+3e67zSAVd8Jgjlj
 RFmfkZSotSknFSyevu7+TAB0xVoa+Thfk9lcqPWbgZWu6rx7dcipK850ejW9s=
X-Google-Smtp-Source: AGHT+IGWwA5aNxg66a258JPgA6nMcB3QbaRr5u+YdqLeRzNisvJhtLoYaa0W4GcO6pN2HA97IO+ujw==
X-Received: by 2002:a05:600c:3111:b0:475:df09:c253 with SMTP id
 5b1f17b1804b1-47717e7f27amr16943725e9.38.1761636606991; 
 Tue, 28 Oct 2025 00:30:06 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd489e6dsm176806665e9.6.2025.10.28.00.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 00:30:06 -0700 (PDT)
Message-ID: <5f16773a-e7f6-445a-a69e-ddeb62e61760@linaro.org>
Date: Tue, 28 Oct 2025 08:30:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ppc: Fix memory leak in get_cpu_state_data()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Shivang Upadhyay <shivangu@linux.ibm.com>, peter.maydell@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 sourabhjain@linux.ibm.com
References: <20251028065815.84156-1-shivangu@linux.ibm.com>
 <20251028065815.84156-2-shivangu@linux.ibm.com>
 <94cebbf2-5883-4fa7-9b86-f8bf0f3332c1@linaro.org>
In-Reply-To: <94cebbf2-5883-4fa7-9b86-f8bf0f3332c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 28/10/25 08:12, Philippe Mathieu-Daudé wrote:
> Hi Shivang,
> 
> On 28/10/25 07:58, Shivang Upadhyay wrote:
>> Fixes coverity (CID 1642024)
>>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Link: https://lore.kernel.org/qemu-devel/ 
>> CAFEAcA_Bm52bkPi9MH_uugXRR5fj48RtpbOnPNFQtbX=7Mz_yw@mail.gmail.com/
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_fadump.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
>> index 883a60cdcf..49d2f862a1 100644
>> --- a/hw/ppc/spapr_fadump.c
>> +++ b/hw/ppc/spapr_fadump.c
>> @@ -453,7 +453,7 @@ static FadumpRegEntry 
>> *populate_cpu_reg_entries(CPUState *cpu,
>>   static void *get_cpu_state_data(uint64_t *cpu_state_len)
>>   {
>>       FadumpRegSaveAreaHeader reg_save_hdr;
>> -    FadumpRegEntry *reg_entries;
>> +    g_autofree FadumpRegEntry *reg_entries;
> 
> g_autofree pointers have to be NULL-initialized. I don't remember why,
> likely CPP warnings.

Ah, see for example commit c8f48b120b3:

   As mentioned in docs/devel/style.rst "Automatic memory deallocation":

   * Variables declared with g_auto* MUST always be initialized,
     otherwise the cleanup function will use uninitialized stack memory

and for full context, commit 821f2967562 ("docs: document use of
automatic cleanup functions in glib").

