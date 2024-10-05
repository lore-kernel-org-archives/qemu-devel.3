Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ABACFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAUQ-0001ko-IK; Sat, 05 Oct 2024 15:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAUO-0001kI-81
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:30:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAUM-0005R6-PZ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:30:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71dc4451fffso3180458b3a.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728156649; x=1728761449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2j42c93AU/c0+ElfCXqZmSDc/j+JWGUrEvEk3/DVVjI=;
 b=QvuurzEOux5y5u3FUaMuJP3mbposMC/XUQtKIoL9stZf1mRLofa76i/UxPx7Qc0yWa
 RgPlo94hbFwtHzY8PE/glX/FO9aloA9iciFqXMI+c1ZayB/H9Ic8mDZYBfOY1oE3R6f3
 LHlYUTBVz0Qd/S7kqZFgePpfVGLn074FP7UufUV8rZJA1h41X7TtoeCjkG6CO3oPpImi
 x4OYmGdGOEmFnmr388bGpCBcicl/FXcJZs85/D1JRvHnBGXonRq2mxX7y/b1ug/cKYhD
 3zbhD6TWc68b6zj0w+jgGItkWdLyvcW0Nym5gIZuR2wRaB2kvV6APYR0sQ2Nh08Gh2p3
 BpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156649; x=1728761449;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2j42c93AU/c0+ElfCXqZmSDc/j+JWGUrEvEk3/DVVjI=;
 b=VypZdd0PjtC+a/k2WbUJJ7Wv+DtvJT7LSMTN252aHIog5h95/+AdXG5EvB1c4Iw4ts
 rppgviIh3moYgt9ftiQrgFKFOjPa2Ccz3pegwuGKIyZCK14/DDb0Hx5O4XZTPIwCf/nA
 ybAZsp79m9Bh+Qtd1IMCDUtMuvZe8ozz1iygx2cBwm+b9+yzlOSTAqCQzZ9qQJPv6bxb
 C5AgWPCU/srn7SNrEzY3Q7nB7KahPyKbFv645KKQmdAriw+YyTmNyc7jTGpcbV3JHSex
 rNjw/mGt7EsmhbJUlZ3myJK67bH/9jw3tzVg2fI3HjW69lEbf89vt2u4Nb5e6MQJC6uo
 wEDw==
X-Gm-Message-State: AOJu0YxkOyXY4OubrB+I4++SmQPoJRfcNYAlmXW6ExikVzpQmX4d2rgu
 vVTXKQbNNuVmikHC5kiiPji+4YbrWzSDKG0w80kkue2XCPRnzs4mpeKOW0BjxP0=
X-Google-Smtp-Source: AGHT+IHZJGBqi0b4/4hQ8ArzqwyO1LRUkv52qEAA/JEDN+5OyDty3GttAsRMNDVwH9G8IbVq/8zR5w==
X-Received: by 2002:a05:6a00:2289:b0:70d:2892:402b with SMTP id
 d2e1a72fcca58-71de23bca32mr11700879b3a.7.1728156649337; 
 Sat, 05 Oct 2024 12:30:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0ce0577sm1802805b3a.88.2024.10.05.12.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:30:48 -0700 (PDT)
Message-ID: <26c361a0-9f24-43e6-aca3-2c08b45beb48@linaro.org>
Date: Sat, 5 Oct 2024 12:30:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] qemu-thread: Introduce QEMU_COND_INITIALIZER
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <20240923162208.90745-8-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-8-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 9/23/24 09:13, Ilya Leoshkevich wrote:
> Allow static initialization of condition variables.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   include/qemu/thread-posix.h | 2 ++
>   include/qemu/thread-win32.h | 2 ++
>   2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

