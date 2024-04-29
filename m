Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA10DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 20:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Y1b-0001qo-RG; Mon, 29 Apr 2024 16:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Y1a-0001qf-9w
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:54:58 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Y1Y-0005XZ-Ka
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:54:58 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57232e47a81so8101141a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714424094; x=1715028894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Pla6+xi6JFxC/uJrR6u5eMRsm1tO/3dnmtgFbeSQoI=;
 b=ncBBHEFhxPlnb+kUggV6LIVZMScP48o3oV4yr++W4Cz8k/WTVfRXb1SOLPMfcD3U91
 EH2GKfVnIngJSJQUJ8cwpwseGvylUN9MR4w4DU4SX3OsMEtrDrLNxQdw/ZLXZf7syOvv
 A9e3/6f4lRrzmycLYJHm/OvnBPkMV7BjGKPleKoVwoxnyyeYYzHkpD5EJK6db1MZazDo
 D0xvXaMpJotfCDshGx4N962EaQEYIzAkbpzGYq2+osyflFgMLvGMxqgZoqKDdf+3lR6m
 yopP+gjx834pJWJY3xLMY4J/DCe8vSbdaLaiuCGvzhDpfpTf2FTopQw3470yqGCdghlK
 9pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714424094; x=1715028894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Pla6+xi6JFxC/uJrR6u5eMRsm1tO/3dnmtgFbeSQoI=;
 b=YpuQAD6PAt7G84ZC/h+t9rEuvnmbYtr7RvbIWeMwSGXQj/INT6+uF9ZYh717751dmh
 jN0bUI9w//IjcHE1B8vcjZIgWDDb6Ktug4CKUSxnFzWyfaGu8dWx8mQcn3gHZZzWVpOQ
 cUtncPlDHAiuAXiTeZdyr+zQG1Qg/FNyjY5DOLrpP0QB87ONoJZyBBemIoPHfZOrafQA
 jtPEmm7mnJIv2yprKz7PjAKzRI8JqK2MNx9un103VIdSQ3ohCxubSDuo9YAuTWBhd+3Q
 kbsLSS+beppGz8f8n4jf0XHzGysqLyuTqF7kgRlxEu/HEkZjnZc/CirEh/zWkdEnlyAQ
 yunw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWey0bwRN34C5ODeYmAt8kllm3RJhPZIuHJMD2SSzt6ZKl94SYBywc2XQZTglmdr5UZMTefpgu9G5BLcsfY+jprQ9PKLkk=
X-Gm-Message-State: AOJu0YxbsYrcGmpuHT7Oe0hfuk6a978ABXVSNg0a0pfP5Hw1iD6x1ccz
 qF0wNC8x7pyeGyGjrfr5xrfhozPyG6VkBR8ZvKCB1ls0K1q1EI7ZuLA+UuswHnE=
X-Google-Smtp-Source: AGHT+IFURTwiME4mV0LDl5HPY4FSXY+L1EsfEZ4oUhL5oS+WRwlAtYj7w0EIRhKwwFDarNpaQjDk/A==
X-Received: by 2002:a50:d5c4:0:b0:572:2fdf:b965 with SMTP id
 g4-20020a50d5c4000000b005722fdfb965mr734219edj.7.1714424094228; 
 Mon, 29 Apr 2024 13:54:54 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 cs14-20020a0564020c4e00b005723e8610d2sm5236254edb.77.2024.04.29.13.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 13:54:53 -0700 (PDT)
Message-ID: <fbd4c7c2-fe6c-415e-813a-a29b05b1a11f@linaro.org>
Date: Mon, 29 Apr 2024 22:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] accel/tcg: Move plugin fields to
 CPUNegativeOffsetState
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-15-philmd@linaro.org>
 <8e0091a1-474f-40a4-acba-ffe4e956f9eb@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8e0091a1-474f-40a4-acba-ffe4e956f9eb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 29/4/24 16:42, Richard Henderson wrote:
> On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/core/cpu.h  | 22 ++++++++++------------
>>   include/qemu/plugin.h  |  2 +-
>>   accel/tcg/plugin-gen.c |  8 +++++---
>>   hw/core/cpu-common.c   |  2 +-
>>   plugins/core.c         |  8 ++++----
>>   5 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index beb37342e9..ef8b85b6fe 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -342,9 +342,18 @@ typedef union IcountDecr {
>>    * CPUNegativeOffsetState: Elements of CPUState most efficiently 
>> accessed
>>    *                         from CPUArchState, via small negative 
>> offsets.
>>    * @can_do_io: True if memory-mapped IO is allowed.
>> + * @plugin_mem_cbs: active plugin memory callbacks
>> + * @plugin_state: per-CPU plugin state
>>    */
>>   typedef struct CPUNegativeOffsetState {
>>       CPUTLB tlb;
>> +#ifdef CONFIG_PLUGIN
>> +    /*
>> +     * The callback pointer are accessed via TCG (see 
>> gen_empty_mem_helper).
>> +     */
>> +    GArray *plugin_mem_cbs;
>> +    CPUPluginState *plugin_state;
> 
> While plugin_mem_cbs is accessed by tcg generated code, plugin_state is 
> not.
> I would move plugin_state to cpu->accel.

Good idea.


