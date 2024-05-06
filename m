Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E22C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3stf-0006tv-Fa; Mon, 06 May 2024 03:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3stN-0006qO-Dc
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:36:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3stL-0003Lh-BY
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:36:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41bab13ca4eso10348085e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714980964; x=1715585764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YFnYVa5Z9A3Ixu3zalShu0+hblIDFvee9LCFlf1WZho=;
 b=zl4ecdU0EU9kT+hc8JIChkn+OFbKKAZ2JsJAnto/7oDXbyJp/DwV30VginrjNwvd/D
 JbcUdPiYwxJANyCj+VV8mONNJYsslnbMCWybMu6D5LCY0VAs0mzAyEYgdDAktkpNBind
 hRPWhOcRxemAD6QN0tZvSugldghlCiRDlkpXu/AwengwJw2HtILgY/FkdhLLa1CmiO0C
 IwVgLzlz19n99lPYnH76sKeA8qQ5ABPWZr01bmlMdBDgn4zVa25uzI4Bp2OC3DYK0z5h
 Mep62kmdrubpNtfblrpokG4XtxdjOdiVN4QaVdk3dzIFlWh4wG+SdmlC44VkHgyELmWL
 V7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714980964; x=1715585764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YFnYVa5Z9A3Ixu3zalShu0+hblIDFvee9LCFlf1WZho=;
 b=brEDWRfhl4sOdLUFQlZg4dNli/78rMTbTAUFukglg+v2pN7mq5jpciK5P8/3Dz4jll
 WcQeTsOrlzZtOB1fH4YRLo3CcfmtHBDHZv1DNZNUi0le963W2EfQL/0NhiWNQO+vdfgO
 ATQTjYJO8gtww9ryeC55CVKQGgDBISIBzaVpBt2wIAAgG8ivN5QxdUH8Jsv/to6L+H/k
 gmMJftX4LcuAgggFaxAQvKpdJzabJzoSgwCr4FLXzIRWvJT81pWGwAD/M/iWh7jR+txn
 1UefA6qt5kwT8p7jWgVi0zx6CQl4wqHz2JfKR0RglV5IH5pTKQRYUskHxA2/MxT4Scmu
 kPgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt0o9EsRzWHiFFinbNmHy7uPpZiAGBN3BA6rS8MsVNOo+kSNgwiaVg9IRqiV90gs4CYDsy2Y90EPg2jvQGsFW3yk/wLUw=
X-Gm-Message-State: AOJu0Yyo4iN2FhxpggsSR2iyFsFdFUE3j1UYmZQbfS6E6C8T84iJNZXO
 JEwKOvP0dd4vJftXkvF4aA/hQGHJkWpb9zgVfr5znV0lpliuYh8DwexrxfOj2to=
X-Google-Smtp-Source: AGHT+IGonj0xw/F4WwfLCTnFKHjYMelkdAaAD6/J1aWx9gs+ohDyLSOTB6IdAnaPtvjmJBHdaabZ6A==
X-Received: by 2002:a05:600c:45cd:b0:418:f826:58c3 with SMTP id
 s13-20020a05600c45cd00b00418f82658c3mr7565747wmo.15.1714980964656; 
 Mon, 06 May 2024 00:36:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 fl25-20020a05600c0b9900b0041e9c1d6f4esm5819108wmb.48.2024.05.06.00.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 00:36:04 -0700 (PDT)
Message-ID: <1bf7ccb0-49e0-41d0-8600-4db47c2d2e34@linaro.org>
Date: Mon, 6 May 2024 09:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/npcm7xx: remove setting of mp-affinity
To: Richard Henderson <richard.henderson@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, kfting@nuvoton.com, wuhaotsh@google.com
References: <20240504141733.14813-1-dorjoychy111@gmail.com>
 <de22b9fc-6d8c-47aa-a192-878904efd3db@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <de22b9fc-6d8c-47aa-a192-878904efd3db@linaro.org>
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

On 4/5/24 16:32, Richard Henderson wrote:
> On 5/4/24 07:17, Dorjoy Chowdhury wrote:
>> The value of the mp-affinity property being set in npcm7xx_realize is
>> always the same as the default value it would have when arm_cpu_realizefn
>> is called if the property is not set here. So there is no need to set
>> the property value in npcm7xx_realize function.
>>
>> Signed-off-by: Dorjoy Chowdhury<dorjoychy111@gmail.com>
>> ---
>>   hw/arm/npcm7xx.c | 3 ---
>>   1 file changed, 3 deletions(-)

Implicitly in
https://lore.kernel.org/qemu-devel/20231212162935.42910-31-philmd@linaro.org/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

