Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF84CEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 21:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzM2i-0005Mk-EY; Sun, 08 Mar 2026 17:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzM2d-0005LT-J5
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:52:05 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzM2Y-0005ii-OF
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:52:03 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439a89b6fd0so7702718f8f.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773006714; x=1773611514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svpbkY05sqtNQbwztgak8AUdlK/lA4vwHpUlNIcrfb0=;
 b=cPwh6xKJOTWU+WEC3EzhWsUILIGQzdSFgZ/Vqnii1N3b8hmnmZxDxOYK5dBv5EHpbC
 BBtq7Gg2+ClQCOaQPW8w6Q8gMIyZ09/futXPNQ42mEOGVaXIBHjN8CKQYwNrwMRVhSsM
 7RSdOcs+1rg9Jn8RV8763CmjBlDKtmRvmw4NrV0joQvCOD5nhTdX2pGcJuR4DBfQP1bm
 rZMaKOo9t6GXrPE/C3t5rONyb/9hf4rrj09p2se8gqtssXm2tbS0U1S3QjIgNLfpLRNF
 0PCcU1ByF6nHi8naBEpdx43R1NgpCQxKVENVcrV7SGXkUCFil4PS8PZIj1iQF8ppRWBB
 xVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773006714; x=1773611514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svpbkY05sqtNQbwztgak8AUdlK/lA4vwHpUlNIcrfb0=;
 b=wuFYmLPi+opvgsEDNxH0QqTyFgA6if8lbPW1JdFnCDIHeTBzLovQLxHtlhyA25Xphh
 eDdF3P67wbbZsiOf8lb1vkOv8aW9NA9jUWJ/TPP2Z4zwrlSdKS7XG50GRRTTLoOjP6J4
 qsfhzR9bS0hSZixFYGr3eRvAIseMTplzcpYmPtYPcauCzW5PmWAp2fXhehLcfj1TCBKY
 qpukU2R+EpZcaM8KIOxcUdyQSXc30FKb5SrrkmO3ViJmENMiPwtpeOnwjLgcBnOHhdbe
 346iqxYwGbxkH5vHplAEjAAOz3PbgfFVpcs+jusHTC98Y4FzwjsJ5DctMCz/znGV/a5Z
 +RwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMiOAHqd8d3hXsOIJZNWn7/MprLqiEEodho48sDwhOzbC/XDOkLaIJmfgV74AA5G39lUUtVNTDGGPh@nongnu.org
X-Gm-Message-State: AOJu0YwfbzHWMr0MyizAhUkgUXvksxRIRticHpsQVlcyQcJFU5ZHRrhH
 1dVPAK7JW4VX6tI5sF/9QOGuIU0nVtKfvSy7KodaRzVqA5LsqdeDVnEtZy8TA6S5NJ0=
X-Gm-Gg: ATEYQzx49X1rAAB126OCjlVrceSvMlHwLJXWbeD3lgANQqZoMWmnSD12AOyb80Pk/zp
 ZCuVJh/IAxxZhPtvSt2CJ2jj1rm/gxtfhphfTdWM0dnTmkkf20T8HsOAqlmEiAiWwaEe9MH5VSO
 SJTawTByG3vGacg0mRzAc/yqU6NUU473M6bp1mlJoUiHUXPOqevpCg8j4YbwgQuPX2TQXIjO4qy
 zV1FDdIoMc4p1dQokGqn3o99NCGlVB62qF+wu/LtNkbP0qqtU+4UYSEfB/FZzgWVDObavz5zuFj
 R8Ou5b1jgxKjpTD1T1PN6X85dcHUpKAAi7xwZ2ZsQpwoMGlpcZP6zhCf5L0oKmCT2eCdEqgeuCU
 to1Fk/onN2CKKKFs52NRBABXDnBC7X/kyfTQAzcfC5wzHL/xcdU1u0+SvwKWGfHb7rqbgLtchXx
 r6xt0jnRvZDV4UL01dbXYjnlmPmjIZEO0nQMhhUsZZWgnj+CLtGroqRKz5XNrs8+FJYw==
X-Received: by 2002:a05:6000:24c9:b0:439:cc06:e134 with SMTP id
 ffacd0b85a97d-439da6632bcmr16180455f8f.24.1773006713595; 
 Sun, 08 Mar 2026 14:51:53 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm19660765f8f.27.2026.03.08.14.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 14:51:52 -0700 (PDT)
Message-ID: <f91dfd2d-dffc-4905-98f7-9fde3cbd887b@linaro.org>
Date: Sun, 8 Mar 2026 22:51:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audio: Fix macOS JACK Audio Connection Kit
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260307114923.75394-1-philmd@linaro.org>
 <5083100.31r3eYUQgx@weasel>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5083100.31r3eYUQgx@weasel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/26 14:06, Christian Schoenebeck wrote:
> On Saturday, 7 March 2026 12:49:23 CET Philippe Mathieu-Daudé wrote:
>> Since commit 8f68a33ad46 we get on macOS:
>>
>>    Audio backends
>>      CoreAudio support               : YES
>>      PipeWire support                : NO
>>      JACK support                    : YES 1.9.22
>>
>>    ../audio/jackaudio.c:654:12: error: unused function 'qjack_thread_creator'
>> [-Werror,-Wunused-function] 654 | static int
>> qjack_thread_creator(jack_native_thread_t *thread,
>>          |            ^~~~~~~~~~~~~~~~~~~~
>>
>> This is simply due to a missing #ifdef'ry change. Update
>> so we can use the new qemu_thread_set_name() exposed by
>> commit 46255cc2be9.
>>
>> Fixes: 8f68a33ad46 ("audio: make jackaudio use qemu_thread_set_name")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
> 
> Nit: the commit title could have been a bit more precise, e.g. fix use of
> qjack_thread_creator() on macOS.
> 
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Queued via hw-misc updating subject, thanks.

