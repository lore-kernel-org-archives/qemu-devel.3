Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394EAC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx5Mf-0005PM-78; Tue, 25 Mar 2025 10:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tx5Mc-0005PA-Ot
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:34:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tx5Mb-0002Zw-7j
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:34:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso114830685ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742913283; x=1743518083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4tANRWR6rCezFKi0rNGPblrcZy4LnuJAvLq6/bKy180=;
 b=c2cYiBZgc7uKZ1jDsMsQwPjOgcOYjQDHqc+Ayvs/R2btZ2hlqLQFXrQ9HTifbsBHjy
 Pkco5brsUEDNDoxtP7Ew/FxX0REcmu3D/u2W0Z9FVoqlTEeNTboBXbUEx84qq8U1WfJU
 mVZWQxlU50CrcM0QZNdQUrHTg5qgD/q9rlGB2Wmi8rrGCCd72H2cugrrG8r8HZVxm4Dh
 sv5FsMf7b8jKvvjJwA2I93ShG9oNnJONOU1Eu1vNwy3D95iHKVwrN+VbMohMjaDoaN05
 6F3tVUtAMPhGUHrDNO/WG+fIDp7o+CM2I5ZToRwd8eQHbbS6vMj5j3IgNmpuobCnzmaK
 2+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742913283; x=1743518083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4tANRWR6rCezFKi0rNGPblrcZy4LnuJAvLq6/bKy180=;
 b=t8K302pQ+Jt5C6bXRhki7KBxkFlOaWcM10CMCqwWr/p3GvUD3dBCqjPhnYnDzlssi3
 eXSaect1vaAVGyFflfV1VKAVUls/A1Q86DCEq0UvPGVNSE7zbqGzfJKzwpB66KEx2Pyf
 5mQruLjXDuLF1/mvMazz46Uu0L4HZ6ZWpoalWxZPgr4tGlB9bwUPkyAeArhvPojrn+ye
 C0SC8Ht7P7+50sVtO6U1ne2SVmAYrgpzdb/ZuERqVA+xrweWU0e2nnUrUgJ0eWd0vBmM
 GQltd03wwptP+/yzRXlNmtTCG7kSLQJjfuVBDfCD/BPTyW6WDb60JY2s/WylvWWZ3zPw
 B1jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnwbbsu2jHvTKK0ci9MInqtl1vJekadHDCsEaBvOw+0GlAWNsC8WOrPMFzceGnpAoQ9VhqfbR/FBd5@nongnu.org
X-Gm-Message-State: AOJu0YxCcdC8+VrjZrZACibHjKVOIVpTm3hlYhcTYk1/0j6zGxgbqy+K
 9PD0E9cc4kv7pbT6/K+/T0hQ5ccXaYuxuv+gOul5eLVPt3+MWoT9zgqCEFlbclk=
X-Gm-Gg: ASbGncuYg/8QC1TeRZDHN3sU9mQ9+Tb1D0IwsBDYl4DJ8JQfzOIAGd7fFhtbsPqsjbD
 TAO2IEv+ytiUcuigh62gPemqr7LasTYA7Y/yTsipn6Xdu5qijGdTvDIBp3r7hb3ysJoRqoazhsT
 9Qd3SQtBVP5E3NbID8Ddy1HduH6PkzGrnz2ACBz9RP5rwkd0sIKADd3AQ/W05LSbX5ZsaSBgvFf
 w+vvAo7c0RjSRLkpMZ7NBz++16f7HRikVFUAPzJUC5Wu/WZsBFXEX0n856E6qn6g93YyhIJiuFl
 dAiDLJeQGUCt3j+h7Ierlkmzgp+npEHNIg5ypK2lCxTKoCYFos6d1nbjzA==
X-Google-Smtp-Source: AGHT+IG1p5yDETxh98r9349xUtGGZgYUt20C5xBTs7B1RB1rS9QVw/s319WJ9o8+wE/ay6UkW2aNiA==
X-Received: by 2002:a05:6a21:339a:b0:1f5:51d5:9ef3 with SMTP id
 adf61e73a8af0-1fe42f995edmr23611776637.20.1742913283305; 
 Tue, 25 Mar 2025 07:34:43 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a283b33esm7778345a12.35.2025.03.25.07.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:34:42 -0700 (PDT)
Message-ID: <d3da05a2-a01b-49bd-8d25-4128a408ed03@linaro.org>
Date: Tue, 25 Mar 2025 07:34:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] target/avr: Move cpu register accesses into system
 memory
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-6-richard.henderson@linaro.org>
 <fcd2d092-f37d-4912-97e2-a55c475e0540@linaro.org>
 <7df3dc8f-c4ad-47fc-96b7-7ddad3274d51@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <7df3dc8f-c4ad-47fc-96b7-7ddad3274d51@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/25/25 06:48, Richard Henderson wrote:
> On 3/24/25 18:07, Pierrick Bouvier wrote:
>> A simple nit, maybe we could define constant for register names. This way, it can be used
>> in the two switch for read/access.
> 
> Which constant?
> 
>     - The absolute address (0x58-0x5f)
>     - The i/o port address (0x38-0x3f)
>     - or the region offset (0-7)
> 
> ?  That's where I got stuck and didn't add such.
> 

Something like:

#define RAMPD 0
...
#define SREG 7
#define REG_IOPORT_BASE_ADDR 0x38
#define REG_BASE_ADDR 0x58

And in the switch, we can substract base addresses, so only cases 0..7 
are left.

I don't have a strong opinion on names, just thought seeing those 2 
address constants + register offset is useful and makes intention clearer.

>> By the way, are there other architectures where cpu registers are mapped in memory like AVR?
> 
> Not that I know of.
> 
> 
> r~


