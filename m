Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E203C5472C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 21:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sigoX-0007be-KV; Mon, 26 Aug 2024 16:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sigoU-0007b2-DF
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:59:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sigoS-0002qp-RR
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:59:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4281c164408so40803305e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724705983; x=1725310783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ANwho6ZYa5O68joBUb6dvP3VDXY3hF1s9SnSMskP6oE=;
 b=aStlCvUZQ097sfLLQnGd/hNyMEaOTuqwLtt8oFtM28RJc4ZSuZaMCXy6MozUf63gDX
 RARKuLAZR4omH00unjHousMSYz+5nuEX1Znfm1R1CYTB3JpbAp/xXhFntWmBL2WA78EJ
 3vp311i5BUTpp3eZ54YBpgLa9PDuHG99xMO639aFAxwMWznVS2juBcG22ieIsy2DgzPi
 hKLWvne/s91bEfX9S1D6rah2zbpKIe2VbAUswuc6FYr81XOOTjlgcEbIepZRrCIQT/gX
 R5B+J5Fppbv3dmd8N0+FMTrS+bsi+AOKHuhfAi3el8VD1chtTfCUKOsxlwJ7ue1WeS6f
 HQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724705983; x=1725310783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ANwho6ZYa5O68joBUb6dvP3VDXY3hF1s9SnSMskP6oE=;
 b=dd2I1dPEFrZSJ0/aN08oqDOATjFgRM76Su2jmm95Iri3BxXRA3cupN+1WZ1ttu3z5z
 4xMatmH5nmVmxLbgzewh/VKyEF0UqJVzr9azt8y4qTI/gkn1sZuDLffJH7UjCqLGhGRH
 im8nhp42Pg1lOkAbxIDmJRIvSnhOJLb8f8kqwlYGyUOszk5C6NKkSFllHwFTbUKiiGaS
 sH/ppH3Hq5QEVfZ/Rb5TCGFbB6GChKMv6xaw8SChOIC6ynw8H+9Cj3Zvof0kfXRCLQys
 LXaq+JyFr2t3hb0ZmhhNz7yJNv9DfKJBtGbmTqe78d/v+Fo/dj63Qij6BLh+UpAUSdVb
 RXYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCuJ8j+r9oNGN3rxNXjUzpb1cDr3IR3QVYhxO2zx/tD9W1WHLDHrDK/+toRlL1uq1RaTrpvmitMjLS@nongnu.org
X-Gm-Message-State: AOJu0Ywo1koW4LTZBrEs4zMDZdU0h6KQotm2e7FwvgizzKRiEl6mfXlE
 sEIkcnFEbTElXGxaDVHWeGlUgv5rlXJrmNQXxBe6CpQ0wrrC6HQe73p8YY3k8Uo=
X-Google-Smtp-Source: AGHT+IFj7PFv3Kt9D00bnXPVFYZGV2nloOQmE9SE2vz9tUX9Y97/YI7QBH3FboPCpaJHaGCpQ4NI5g==
X-Received: by 2002:a05:600c:3ac5:b0:428:18d9:9963 with SMTP id
 5b1f17b1804b1-42b9ade4d5cmr4419915e9.22.1724705982691; 
 Mon, 26 Aug 2024 13:59:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac514e07csm165871085e9.10.2024.08.26.13.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 13:59:42 -0700 (PDT)
Message-ID: <2f484cff-e227-47e3-b570-40e1945cee63@linaro.org>
Date: Mon, 26 Aug 2024 22:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] tests/functional: Convert mips64el Fuloong2e
 avocado test (2/2)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <chenhuacai@kernel.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240824160829.27655-1-philmd@linaro.org>
 <20240824160829.27655-3-philmd@linaro.org>
 <e840b528-c48b-4b5e-9b2b-c7c0a0473ce7@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e840b528-c48b-4b5e-9b2b-c7c0a0473ce7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 26/8/24 11:10, Thomas Huth wrote:
> On 24/08/2024 18.08, Philippe Mathieu-Daudé wrote:
>> Straight forward conversion. Update the SHA1 hashes to
>> SHA256 hashes since SHA1 should not be used anymore nowadays.
>>
>> Add extract_from_deb() method in qemu_test.utils package.
> 
> Should we maybe rather copy the whole LinuxKernelTest class into a new 
> file in the qemu_tests folder, so that all the related tests can simply 
> inherit from that class? That way we would also get the 
> KERNEL_COMMON_COMMAND_LINE handling for free in all the tests that we 
> convert. What do you think?

Except that variable, I'm not sure what can be reused. Most tests
are trivial. Maybe I'll realize after converting a few more :)

We could however have a LinuxKernelConstants class with 
KERNEL_COMMON_COMMAND_LINE if you rather.

