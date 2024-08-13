Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5464CC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtAA-0003pX-Ce; Tue, 13 Aug 2024 11:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdtA8-0003iN-9o
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:10:16 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdtA6-0003My-Bg
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:10:16 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-530e2548dfdso5883981e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723561812; x=1724166612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uGg9TRC34UZ8OSYhe/mEgEPovRZz33hPOpKc1RqbvQ=;
 b=u+63QR8z6tWf2pM/UUAQidTQxme+O7fDHp+lBhOYx3YKySHmW9laYZDr6SReYanNIL
 acpLzFWbSzAxPyzM6EOKiJH9jDufrdOauq29lzwQ/kZWFtroGNuxDcNThpnbqcbLSPHN
 3AkwW16tj2VYnIJgSlVpG7c/LY2hb8vU3aEr3q4rSAEdZVi3WXB5JXnXBRjd0h0+rLHF
 xFZHjH/JKIUBDj60LtK689AfaTC66Qwymt1t84NcG+d2Cp41GFyfmFr36VAjHEKXNYGK
 W8kSF62Lyephr9HBzdQTVmCtK4+83Os5OBkV0wso4fpkOhz6ULPUG7wmn/F1i1yimMkO
 UsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723561812; x=1724166612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uGg9TRC34UZ8OSYhe/mEgEPovRZz33hPOpKc1RqbvQ=;
 b=R5xapYMKGw4W9HtsP5jeFuSbuJ5658k0gPyFjtEPM5IV9///yJZDc2Vr4Lm8WL+Ky3
 pc51Fr2FoPhh9S8r7KA06QXSShK5nnH05ahZUokdywyd+LGVPHxC/V4Qq8LkUrdxbc8c
 pUf6HAip40wIXOpl7qN3+JYfOVLhBqOKk27t00ciHmOi6hCeert6wvQgFMuL9d3O95jw
 2uyLcs3gI/btcJtYcx+ZmpMd/SQO6ox0XnAwfwpyRgE3Z9qxQdCE/E7Nh5Nwfouuof3a
 +tYGMq3ozDDRveDgsh/pIocDpWehgYQhPW8MXAt9/wQZ+ge0DDscWAt9uzIiD58kbhtM
 fi2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ/qRajoWqpY4SNdHXsqWVu5QKyITI2kvp3sOJ1/K9zKq3HXn/EPVtkzI+Tc/QduBlqKXUdDFVsvqIJRF8Iv8qjJ5PfD0=
X-Gm-Message-State: AOJu0YxV5IfU82vrkK4JTbO8xmoPcslUxj1hy6w7w9lSEXV9floIRjwZ
 SMzHovLMXsM9qAS4gT6YgMB4o9hTUflr7nZfF9+zOYsZ/r1z2UIsCxn13Kyyhok=
X-Google-Smtp-Source: AGHT+IEiHM1g9HDzXRTCxYlp+8D1s3fb8cs5xWW15miAIv7zmpCHdAHB2DjcjFs5kXcc/DgXeKd4gw==
X-Received: by 2002:a05:6512:1292:b0:52f:c0ee:3b5f with SMTP id
 2adb3069b0e04-5321364b9bcmr2879945e87.10.1723561811534; 
 Tue, 13 Aug 2024 08:10:11 -0700 (PDT)
Received: from [192.168.5.175] (80.red-88-28-4.dynamicip.rima-tde.net.
 [88.28.4.80]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c7619e7sm232731815e9.31.2024.08.13.08.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 08:10:11 -0700 (PDT)
Message-ID: <1bdbdcbc-29be-424d-9215-fc711b11a1bc@linaro.org>
Date: Tue, 13 Aug 2024 17:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] accel/tcg: Always call tcg_flush_jmp_cache() on
 reset
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>
References: <20240503123456.28866-1-philmd@linaro.org>
 <20240503123456.28866-6-philmd@linaro.org>
 <bd395931-0883-45b0-89fc-8766ffcda9cf@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bd395931-0883-45b0-89fc-8766ffcda9cf@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

Hi Michael,

On 11/8/24 19:43, Michael Tokarev wrote:
> 03.05.2024 15:34, Philippe Mathieu-Daudé wrote:
>> In commit bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
>> we unfortunately restricted the tcg_flush_jmp_cache() to system
>> emulation. Move it to the common tcg_exec_cpu_reset_hold() handler
>> so user emulation gets the jmp_cache initialized when threads
>> are created.
>>
>> Remove the NULL check in tcg_flush_jmp_cache() from commit 4e4fa6c12d
>> ("accel/tcg: Complete cpu initialization before registration") which
>> was a band-aid fix for incorrect commit bb6cf6f016.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Hi!
> 
> Has this change been forgotten, or is it not appropriate anymore?

Not forgotten and still need to be fixed, however unfortunately
this exposed a bug in user-mode SYS_exit_group when using plugins
(see qemu_plugin_disable_mem_helpers call in qemu_plugin_user_exit).

Pierrick is working on it, and I'll rebase this series once his
work gets merged. Next release :/

Regards,

Phil.

