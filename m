Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0286C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 07:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkJQi-0004jB-P8; Wed, 13 Mar 2024 03:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkJQg-0004hs-Hh
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:53:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkJQe-0005SN-Ut
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:53:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4132a4360b6so15495905e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710316414; x=1710921214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=azNYspdOp7ko/senWpVuiSKGbrkj4mruu7esf+YSOfM=;
 b=Xdf/Epn+euG/FyoQH4G1vkTzat6gIgQ3vzxhbmuhj03gNHSo2pgucDo+yblo3g2nNc
 umCBRiZWXEWYV8KhEJqyTqtVxG7ZhKumnVa4DWDg5gDnSZMWUZgFFMj+dcbSIRqfOoqc
 F9c2ZAyXn8HynjzKN8e+LfyFgUsGe/pMmJfxTxcEF1soRLoLMCHG4yGPfFfQpetR0Xyw
 vWOpJL9SDzZj6U3M1eotz/PfQHigwoRphVJImsiQ/oJMWHPG+ZQruBa7RAhWqO/hHbmS
 lyjqPr3o5MBHKnXAq4hndzdcr/D/j+9dbjR4zftgBcNrbM+7PJ1FAS4ZUDclnuomQEqb
 t9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710316414; x=1710921214;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azNYspdOp7ko/senWpVuiSKGbrkj4mruu7esf+YSOfM=;
 b=bolEFBdwxsSRPHo4mKgOyyPqixl7A8QoEz8q5KU9GC9lJrQY6kOnuapUBGhMArgx3Z
 6p3uMrj54dkvWkNdBs9Ob8v8sc2LbnyFMxNdQarKNv079KgxqnBBvpUj5bgGsnO8P2Wu
 vTsDh9aAhOmjrtm3wnbU4Kkki8QHBwmMWvC1MSbYAb8R1ZlV1xtGWXCdTqzUiyN7gIvA
 UM5ZfgTW5FLkmsJjTojaao40DdiGZY45r0bvr/TYe/mSHmctrautsEEp4m/PL1F71OJI
 IgO30dHeZey3hDMoflgLQ+VAP7pVrtYNYE2tG7XCGO8zXkEBsLBaibNi2OMf+P5J0w/0
 6w4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQObZRaLXIxKz/z7PYhnJfNarNd1T3mtALgbkb8tMv4Ehj3P79H65HQoy+Ig75NBGTmbpMZf/HoBw+YW+YROktpgYpsQA=
X-Gm-Message-State: AOJu0Yxu2xM2TN1SjSnJSIkEr6+9LZ9HgEeKbdRDOXA8kZK+QjNTTJMr
 SCpTxWFFFardtvLFxbMG7I2dep6AEdBxL+pFw9N2xIzByRgY9cWb6SBUxf1myAE=
X-Google-Smtp-Source: AGHT+IHw/lYIOItqCw1q+CF4uj0VOxVHpYAplKC1GBHNHcDeX2DMrswAGsVorzujb3zGUhnCMJFpGw==
X-Received: by 2002:a05:600c:314e:b0:413:e4cf:fdcc with SMTP id
 h14-20020a05600c314e00b00413e4cffdccmr1895772wmo.15.1710316414491; 
 Wed, 13 Mar 2024 00:53:34 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 m29-20020a05600c3b1d00b004134540ae3asm1455091wms.3.2024.03.13.00.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 00:53:34 -0700 (PDT)
Message-ID: <1fd3ffb1-be5f-447a-84ea-385697304fbc@linaro.org>
Date: Wed, 13 Mar 2024 11:53:28 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] plugins: conditional callbacks
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
 <20240312075428.244210-5-pierrick.bouvier@linaro.org>
 <e1618313-4698-4661-b5d5-dcb38f60ed52@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e1618313-4698-4661-b5d5-dcb38f60ed52@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x333.google.com
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

On 3/13/24 01:25, Richard Henderson wrote:
> On 3/11/24 21:54, Pierrick Bouvier wrote:
>> +/**
>> + * enum qemu_plugin_cond - condition to enable callback
>> + *
>> + * @QEMU_PLUGIN_COND_NEVER: false
>> + * @QEMU_PLUGIN_COND_ALWAYS: true
>> + * @QEMU_PLUGIN_COND_EQ: is equal?
>> + * @QEMU_PLUGIN_COND_NE: is not equal?
>> + * @QEMU_PLUGIN_COND_LT: is less than?
>> + * @QEMU_PLUGIN_COND_LE: is less than or equal?
>> + * @QEMU_PLUGIN_COND_GT: is greater than?
>> + * @QEMU_PLUGIN_COND_GE: is greater than or equal?
>> + */
>> +enum qemu_plugin_cond {
>> +    QEMU_PLUGIN_COND_NEVER,
>> +    QEMU_PLUGIN_COND_ALWAYS,
>> +    QEMU_PLUGIN_COND_EQ,
>> +    QEMU_PLUGIN_COND_NE,
>> +    QEMU_PLUGIN_COND_LT,
>> +    QEMU_PLUGIN_COND_LE,
>> +    QEMU_PLUGIN_COND_GT,
>> +    QEMU_PLUGIN_COND_GE,
>> +};
> 
> Do you really need to expose ALWAYS/NEVER?

Not mandatory, but offers possibility to have a condition (based on a 
plugin command line parameter for instance), without using necessarily 
conditional callbacks (if option=off,option=on or other value).

> I guess these are all unsigned?  Would it be clearer to add "U" suffixes?
> 

For now we only have conditional callbacks/inline ops with unsigned type 
(qemu_plugin_u64). Found this to be redundant, but we can always add 
this suffix if you think it's better.

> 
> r~

