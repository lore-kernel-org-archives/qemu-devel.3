Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE1FEF99EA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5Tz-0002rs-8C; Fri, 13 Feb 2026 21:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5Tx-0002qa-8J
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:34:05 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5Tt-0002yp-6A
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:34:03 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a871daa98fso11044575ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771036439; x=1771641239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mliHk88umJ1aUO06hXwpfitUtVd2IuWQCBUA5+HDINM=;
 b=Otr53juzNoyWc6s+1ztH3JPfvwOijpjzCtbu6PbHGah5m/Es3CHohJTgheCGhRLEzD
 OT3tX88RqqFNX8skPtITDUs3GehuG6vfW1s4oDfSek2211OUhCISvcfu/Vv+XQxh5+KY
 FvSoz4ajC3glQyuaoYhBLHj8JAMzYy1Aa0vV5Y+lFgMMsbB9VQbgNQYdppyOtxEM+myU
 baKPvQA3p6WKLEgsVgv7MTKHMsU5jjucjuy0/r0MAtiFvok/TtrJ6PSgEqCzKaCiSHvK
 ed5plQ3oDE/VKpaDYnGP0Uc4W6XtrRQtohEg5DtY1qESwl+29CwyY472QFEseUNZddod
 vhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771036439; x=1771641239;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mliHk88umJ1aUO06hXwpfitUtVd2IuWQCBUA5+HDINM=;
 b=NtjVDqQc8ocAD0ZYTShkJ7TXXhfSOsiB4h0Y1/89NuSyoUGIiICGutr+/9UwrJiB8T
 Bmrsrn3NU2Dq66WkTncckPG0kFCG9y7zNpOonCllqBA94xIzFvc8CEVKpYrlQDVdb5D5
 bgWvpv8iMCNg8wAewMgpYDHKl3+IULX18WWaxrEjfETzQE5NUV5eB0TltwgjJTYC4KB8
 wrk4KA5m2FeUp94l3a1d9o7mKIuU0zOxsH+3Nwp/KKbN6ynQwKP3iwrl0x/LhlpOLfUh
 COYMW/y8m/ry5JYIW6/jQKXzvPuD8BhaU68kbitLvq8VY5Cj9N7BRMaSe67QqssNgwQh
 cWCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRbw9KwAI4CrEU9zwz6WuQ24n8vIoLKoy3jz8+TU/UurqvboBMRUlCZfKlLBIrNDjLFqtP2LxYDNNA@nongnu.org
X-Gm-Message-State: AOJu0Yydi0hGuiPszQo2PzZGmBbGi1pCpvmeIPHAhPAUhjlrSGjK8NvP
 Ub0vCt3HnGEiOM5zABA9LLyNOQaw1MoExiPN2E0Hbx+PrC6OstPHc6jYX2rcBJQDNLM=
X-Gm-Gg: AZuq6aJFMjuhmRrvh9I7eexuC7/K5DCXHoJN0GxrXNMKjMLyk0HUDMESh/ZihtCIUPb
 NLlfy4L6t43lazYRiG0vMk1Edk3aA2o5ExcEhZMo9vP/yZGodGmifHfGoPcpilo2L469HwsMsc2
 FVdY/aumjRWL9sBz+/v7l7v9vxdyNtGPV9LAfZH1dn3iD4ICLqOdW4IUWD9q032JxS1tqazP86p
 CzgA5ltQ9uKcBwBp7BEQ9PXKtT9SlGq6vy/Sc6OUK8kSLObGs6fGNSHdqYjl3CFUUJYUK0r05jg
 ZgKGagNW3gYG8jAKrWLVMnuF3asGkHkB1QvuWC2zkNQgeT2oWUEi2ZAPA5FVlkWJwW+lI6bnuO9
 2bbnXflszs3lcL6tKVl5lKpJXBTgKGnTydmBmLKNfZcFfCc7ccvYJQzSixvVjw0eDO36eEQtlL4
 O7TiVXln29EwMpX9/n9Ba4OXBTUZgOvF9ae6RoYdc0Z2zxOVoF9oAGZ9cgzM6CZ5rCuXnE6o/ir
 pJ2Xrc=
X-Received: by 2002:a17:902:f64e:b0:2aa:eed5:c5b4 with SMTP id
 d9443c01a7336-2ad1751998emr11830265ad.38.1771036439447; 
 Fri, 13 Feb 2026 18:33:59 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a713e8bsm5389515ad.28.2026.02.13.18.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 18:33:59 -0800 (PST)
Message-ID: <db8843cc-d164-499d-8445-fe5a5d7df892@linaro.org>
Date: Fri, 13 Feb 2026 18:33:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within
 MacFrameBuffer
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260214021240.58657-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/13/26 6:12 PM, Philippe Mathieu-Daudé wrote:
> The MACFB_DISPLAY_APPLE_21_COLOR mode is not specific to the Q800
> machine. Check and set it once in the MacFB DeviceRealize handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/display/macfb.c | 4 ++++
>   hw/m68k/q800.c     | 5 -----
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

