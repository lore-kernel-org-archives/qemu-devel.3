Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A312CC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsgQ-0002Fu-G8; Fri, 02 Aug 2024 09:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsgO-00027u-JS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:51:00 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsgN-0007kN-03
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:51:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70eec5f2401so5349181b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722606657; x=1723211457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+SP8gCi3n4QYtDs0BpWrKmxu7C+O9ZP4XqePPh7v0o=;
 b=C3YEZWBjaLAC1kegLVs6beBL/kkUH0bTPEeNMb0bt4ryakG0PiU64ky/bHY7oBa3ji
 68xuEGJO+F2o2RqzKofQ+09W15OGaf5OQuQGbVoxZI+B08Zeqg8DCm4by29/xXnCNtzG
 JB0p16bOwnRw9fiWQYHKIW0n5/ugCRgzODA1jXy6Htg8jz3PdL/iRHMBrp8ZopxDBkoT
 NGmHn7n1vLRo0uI7xIPcP0zLHakhGa+o2lEjDGaUaGIN/zxwjhMkaVC7U0YRnXoioOhr
 kPdYlHtpd6s5t1hgiy5VWl+u+kf2cX1XwjWnenRchCOHl4UcuLx1C8EBOI9t1AqTwJry
 K3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722606657; x=1723211457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+SP8gCi3n4QYtDs0BpWrKmxu7C+O9ZP4XqePPh7v0o=;
 b=Dg4yO4Wq5jWrkqDX9BdCnkektFh16yvaPeBs4WC4x0yJWrEEXwNnISveRM61SyZqyK
 d0qPcp7o1lb3tk+d5D6Y/gKuUPSLU8bRkC1eRxGjLzh4A2pHOiFH88iNCmCCSUaEhvD3
 1zdSA0jLrjl+DbNHeoWqAle+7Kyh5GQVb7PIi26CTBSetUudXMWpT5+/NuHHzYRABffU
 tIdx0TIcutl4FzstUqeFUZ0LNb+8z+RooQu+15uU8clAGJ96OHI1GUzcbVvwEUp13hP2
 427WrQRswASWGksLWfv4o/vtzlLY07T+PeUnjGshaZfieJxs0x07aHtfUBueX36HWeli
 p3Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJMg6faS0lqjhUdWBLbugOqrGW/5ei4CI9TZKO05T8Txoa1laIE8xEWZIVUUxpm2gSiSBuRd1UwOZ+xIbQLKQlPEUffr8=
X-Gm-Message-State: AOJu0YyVx+m93Lh9fqnHfaKtc4nnN4XuEWNrtUr2xyXw5BU0s1p340pu
 42tuYy5W6FuDMyAjtqrqQV9YoTt3zlEbJNA76/eA57N58/HoY/3RKpkupNQKbHM=
X-Google-Smtp-Source: AGHT+IGc0AcqCWNsflf9yCyWTuEAUlCYGbuwqP6bKqIgKdwpXZkmIfWiZfg9+OaOQmib4e2u1wMWfA==
X-Received: by 2002:a05:6a21:6d83:b0:1c4:6e7d:2ae8 with SMTP id
 adf61e73a8af0-1c699572d62mr4787992637.11.1722606657364; 
 Fri, 02 Aug 2024 06:50:57 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff590608b2sm17136835ad.152.2024.08.02.06.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:50:57 -0700 (PDT)
Message-ID: <46af1474-abb0-4e47-a522-942456dc56f5@linaro.org>
Date: Fri, 2 Aug 2024 23:50:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] bsd-user: Add RISC-V 64-bit Target Configuration
 and Debug XML Files
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-19-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-19-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Warner Losh<imp@bsdimp.com>
> 
> Added configuration for RISC-V 64-bit target to the build system.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   configs/targets/riscv64-bsd-user.mak | 4 ++++
>   1 file changed, 4 insertions(+)
>   create

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

