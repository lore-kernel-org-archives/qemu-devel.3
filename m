Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6211FC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twSrR-0006L4-6I; Sun, 23 Mar 2025 17:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSrP-0006Ku-1h
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:27:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSrN-0006vK-K6
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:27:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso2190688f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765276; x=1743370076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GOiwyU8iXW1E0AGgwlajsGzj3M7qb4bITzndtHD3p28=;
 b=Xso+4fGVVl/9kMxdvnH5xylVGNvwAxndrnKLQHViFqVjq6BmliGdVz1OFArEFP3jnB
 cthCLpOHQGzj6GlH23olzOQcRBjpbQU631wJIKUDapB/cS8M9MkS+C01Q/fsNHv0TWRd
 3TU9D7iDzmEw814iOUD0YqCd30iwFBlK9AYwrk0yYndvg3Qrn0g9r4U1BmzZhPc6M3SW
 CWLfy1lFjqJlkh8zkNd6AIrE4TjOQet9ye/MENBSiEKqHzZ0Jm3/rBLBMCZOCVPA4kHa
 NbLHrUfDDDKk7cNTvUsIIOhq/VrFv6165cXdzvxHm/wqNCd+/Z5NCwpTmSDYmLCXAic4
 /0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765276; x=1743370076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOiwyU8iXW1E0AGgwlajsGzj3M7qb4bITzndtHD3p28=;
 b=ba236FNGh9hX3dDJhp/PQDZ8lYxKmj1D6CrctrGdy7El76LXxo141614SoSzUuEN6c
 m6pljJPaEvwvXdWd3Tiv7XL3yZ3tf+Z6lERjmcV9pxprUQnlmbi4ZikzXbxTSMRlOX4O
 okXthvdsnxMNIDonGHBfGW2MtVNfC0mSvvTIM1z8FYEne+5jmXx1kJAyvPA1IdDEth/2
 sSl7dXdJ+Kosss7ZMU3NAs0plctVFr2FVtIXMARhY9DmXB/KqDmcu/0ref5tIz7bxpj+
 7hHVrbJl7SSSbz5PeoBql4vfybatwRZ4ha7CIR+hVMkf9CUz6gxcI3hgEE8hTm9aGyZF
 YEPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMjCtw4dJMcYJ5fuXmhsdlGl6xPBgMoJtitZAuX5qqM/7iCDmiFMJ7EJv0vgc8Q8lTvgE1kUQ5DizI@nongnu.org
X-Gm-Message-State: AOJu0YwnAsM10jN6b9MTPa03zDjhlQT1BLZ+lkYeovcaLfeIADSQ633R
 Rmj+9LOYpbqj3FnH6Gl25C3AqMnRlJga1MSojnK/IMumm1MgyZV8MnKqf/g1qXQ=
X-Gm-Gg: ASbGncsHoqpl5JZ6qgrzFbyRWv24tXcJ69w88guL9nnmbP10a3YYS49N/v/u9Ust/uH
 xytgI3TC6PcM1aDKCTJJkk/Gn+s6C3F3hvRMme/ZV7Qslhs+xX9IT6ZXwi2r7pNm0hilh3UCzIp
 OvZm+Lff/l1Hu+70FgNdwp/yHvdCEYdVdon97LIdWOozmNE8jg3KY8oxn2WLwit/r3tLgjyghop
 Ynspj1kztKxe/bgU3K72W/vSqSoQkDldrgVne1pQVs65f/EY0bITQubQs2BUdzgvwf3QDP591qY
 ab/Y/ftAhrQgJ1vJSUHPYZAhWoDqQM4ClIIDDZPD1Gc9jEy7zOwV2uBsRR9CSBBbJL24iSAQYiR
 S4+hYLSiErmASH8il4Q==
X-Google-Smtp-Source: AGHT+IHNjHyfnwiiFGPUqRYk7EcAitsPwV8Rq2LN8oNxVHSjmMvo+8U36G0O6p62k471Fya76Xn4cQ==
X-Received: by 2002:a05:6000:4021:b0:38d:d7a4:d447 with SMTP id
 ffacd0b85a97d-3997f92d2famr7932760f8f.34.1742765275574; 
 Sun, 23 Mar 2025 14:27:55 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43e35sm150004325e9.14.2025.03.23.14.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:27:55 -0700 (PDT)
Message-ID: <b3c8078d-e1ce-4750-bb2a-d938ca2b6078@linaro.org>
Date: Sun, 23 Mar 2025 22:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] target/avr: Remove OFFSET_CPU_REGISTERS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250323173730.3213964-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 23/3/25 18:37, Richard Henderson wrote:
> This define isn't really used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.h    | 2 --
>   target/avr/helper.c | 3 +--
>   2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


