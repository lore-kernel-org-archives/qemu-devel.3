Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BCCC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MRT-0005RW-3g; Fri, 10 May 2024 05:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MR9-0005GW-Sv
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:21:07 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MR3-0001St-F6
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:21:02 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e44d32a480so27177611fa.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715332858; x=1715937658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRnh82uHayMdkHsTG+NDVGgdx3/ppV4YAP7s8QgF28I=;
 b=qLsZwwJP270J8zX3c+8VAeis4MlLo9IfPian9Y40nDE8lxo5RYeO3SkoXkT6UxoXZf
 raUsjSPX2391iYaaBQogySmbdHnTkQexBTCsLsK9udW93nkkD5aHq6DGIRJZ1K+N7rmN
 bkHSqY7i1d4SfqO3TpVunlw66EuLf9Mml66N2Go4n1iCbDrM8OngyjEY9BB6J00N4weQ
 HJHvVhgcalcoTggCDEEfMnY44ngKBpkEW5ELbFl4PN8IqIVeYx1ECjPJ9RKeZhh9SUKZ
 sxBkrEDebaNz6hEWiRi88GECeHabAtZ7BfP8qGT5qmBvXPS4K/Pa2q+doPRosc93Zpx2
 W4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715332858; x=1715937658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRnh82uHayMdkHsTG+NDVGgdx3/ppV4YAP7s8QgF28I=;
 b=N5Jyuuwp9LAs+ySpQwiIjwuMI+csLXSvMioh2YDzMmktUytrXnPkblu/Uw0JUbgLBh
 lATN0GQFMgXpHAa+T9p4TO/510LZJzntwdN52KaiVyQEPpjSb48eyAjRXXCxaV2ySSEh
 VkmgohqZ9Ikjoy0zkKtTH+R9Jj72BLCH8HbmSOPOzJ1xxWBzEBhDWh8BfqXwZDGjDQCQ
 xpFPXBXC65Kq+CpXRa2QugHuKLUwKDoVcTTLBuVDvkRUE5bD0YrC7gRMBflak8A2Uw1w
 k7JvTqPLQMGLszR9Rl0iJekAHP9/H5A9MnbJPBRjFM+2I0fmyJ+NcWjlvXX1gjMH1TqF
 zAsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlvaSyh4HKqZ4lsXaccgBLsliniqBRRcxQyeE3zi1rRalJWvjrEUqj7hiuycf4eIH9pAzPDKYcLxXBS2fBK+ZCDPeFocQ=
X-Gm-Message-State: AOJu0YwwSao/HrZWiwsJNGithOvOarw+yQ9eQPX3/453+4lAxZBpSsY9
 C//GmEqj0LeN8qjC/TxbUO7ecSjSMJ5zL0Ux8/LfSNoXsCDUXXtNNWffbiyiTXU=
X-Google-Smtp-Source: AGHT+IFdHH85XAn1HDvaYMRebgDgt3X0/pSc5YYlmf0k/MT58EQ+Bszlqw6z+2TPMpsn9khkBPawEA==
X-Received: by 2002:a05:6512:328e:b0:522:2a1b:2c75 with SMTP id
 2adb3069b0e04-5222a1b2e77mr108293e87.47.1715332858508; 
 Fri, 10 May 2024 02:20:58 -0700 (PDT)
Received: from [192.168.51.227] (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87c25459sm91802025e9.18.2024.05.10.02.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:20:58 -0700 (PDT)
Message-ID: <c27b0759-3a40-42da-88c7-88c3c8c6b245@linaro.org>
Date: Fri, 10 May 2024 11:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix operand size for DATA16 REX.W POPCNT
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240509152526.141855-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240509152526.141855-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/9/24 17:25, Paolo Bonzini wrote:
> According to the manual, 32-bit vs 64-bit is governed by REX.W
> and REX ignores the 0x66 prefix.  This can be confirmed with this
> program:
> 
>      #include <stdio.h>
>      int main()
>      {
>         int x = 0x12340000;
>         int y;
>         asm("popcntl %1, %0" : "=r" (y) : "r" (x)); printf("%x\n", y);
>         asm("mov $-1, %0; .byte 0x66; popcntl %1, %0" : "+r" (y) : "r" (x)); printf("%x\n", y);
>         asm("mov $-1, %0; .byte 0x66; popcntq %q1, %q0" : "+r" (y) : "r" (x)); printf("%x\n", y);
>      }
> 
> which prints 5/ffff0000/5 on real hardware and 5/ffff0000/ffff0000
> on QEMU.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

