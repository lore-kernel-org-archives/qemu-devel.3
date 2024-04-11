Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3912C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1Xm-0001sg-D9; Thu, 11 Apr 2024 17:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1Xh-0001rs-Kt
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:01:10 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1Xg-00074m-2P
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:01:09 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-36a0d09e6ffso1363905ab.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712869267; x=1713474067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sXt29pkqP0UhbjwucKEtZ67MG6cNBqHRgucZb9BU1d8=;
 b=nICLB2NKJRUyu+KvNwh7oh66n56jWTQKgY4CRmJ+mBec7c2HsD3iTlMP0QyobL3RH5
 62fEZRrXw8cIB+FznrVt/tN2In0hLMaLrV/uwZLwE6kBKWOJtcTrG+I2BjjU3EFSgvKn
 3jbUKUevV/nzQbWoQIc8VEOlVomohsDx67mMPe7fCxrUv9GHPeNHMqNL2qu5/RjF+IA6
 TjJ09K3+4hTNpzzx2xAbDdCK76lis9eptt8wj02gHE7zI3LHT9OxkXwbs57+cnIVIWlf
 4Lz1LGIczUWCfkQtvwaNy4wqeqkQ7D8UOrlzUvOX/Z146P0bEBn/z3p7F82AQn6kACC0
 padg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712869267; x=1713474067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sXt29pkqP0UhbjwucKEtZ67MG6cNBqHRgucZb9BU1d8=;
 b=D1dnXj78ns/7Qjn0h3NM9poyrNu1yQf64iWauV7MTiHZ6/mcf3uxWidBcEb/u0hNZ6
 1CgtGeUhx+0b5NbADAJz0duaNz9SZNtiUorIlv3mUcpKwHa1wGFlmzi3LQoO5ajPfEYa
 pBdD7j/POlzmnf5NVnhZcY70Jfs/LGUs8ge8tcwv9i0L3ZLcNervVhwFU5m5mzJKVtBM
 w1wnT1SvTAsqbprNGsVU9jEj3xR2NbX1f+kBTjuaIcehwft7v5WwoQHuzv/bzVGRdjoQ
 mtrQwFJNFSCggUYqM9sVcjI4s2F5ETICG2j0sfR4vvHSxZ8ZY9AqEhuaE9+/ddyFujJZ
 csiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy2UAA5udqXwpWxt8wOFWPLGpBTBzNFcAaL6ljhbaJJ6o1eZuJzu/DpybsJ2dxYXPzDw11BYanChoTUMtWdzkRr4JP4Tc=
X-Gm-Message-State: AOJu0Yzkb6Nae7FU5O+iPNkJD1PWm1fmrdjP0gP9wXTgcb+oHoNHQMQL
 Vnl5ScgFX7he0kY10YRGY4seQHjRt5pUvyvEHYYASNFzh8fkoaG1W+dmz1TZv3I=
X-Google-Smtp-Source: AGHT+IFah+mxvYsqsutRfoW4lbTS2BwnRzvcUwxEK85IbBLctnsJlM1HzV+6MCoYQa/eXLL8bkUW7g==
X-Received: by 2002:a05:6e02:1807:b0:36a:fe3d:157d with SMTP id
 a7-20020a056e02180700b0036afe3d157dmr873898ilv.25.1712869266861; 
 Thu, 11 Apr 2024 14:01:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a631b0f000000b005e857e39b10sm1534453pgb.56.2024.04.11.14.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:01:05 -0700 (PDT)
Message-ID: <2c0fa8d1-ce81-4002-858c-41d5c50093a8@linaro.org>
Date: Thu, 11 Apr 2024 14:01:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] disas/m68k: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411104340.6617-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
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

On 4/11/24 03:43, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   disas/m68k.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

