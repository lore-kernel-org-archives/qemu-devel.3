Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42D4C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuMk-0004ju-6F; Wed, 19 Mar 2025 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuuMg-0004ia-SI
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:25:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuuMT-0003Ka-S3
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:25:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a823036so42907525e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742394335; x=1742999135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jtT12Bk+blgcRox9ePrYHjdOJKxMRo01mk5zdQmr9Ho=;
 b=C64J9J3vAR7uUZQ6H2JiWsrCTylT+JQj5cZtPtVfHIKkgDc7VuyG9/msHkO952l2T5
 jn6GNfQcIviJbyhJ4HoftEtnFasoZcfb1G7GCkY03DcV1qfToFfUzSQWeXPLJZGR13FS
 3DTPL8l+V/ZyHGC0tLNPkxgQ5sn3/cpXx3qQzDbCIvBW5+ftGYxHwyMMMD1wM1pSH+07
 ZEVshlnXJ6fGuNTeoVxFxd4DhT0TngHeyjoYoo0JUq9CuiqvJjabvhiqg2ugQSxUal4m
 kQsi339/dmsAGGbtXF6xE6/7SJUdD9u5Y4xybQuS1MppJaB8x+ebJ+vr2jvEed/z2utq
 KFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742394335; x=1742999135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtT12Bk+blgcRox9ePrYHjdOJKxMRo01mk5zdQmr9Ho=;
 b=alcgCHSKHd7evzdtAIsp3nrxmOvYkMkZGRQyBZPW9KHjs2tcv0zBBIFxWZFeStI2XV
 HhJ8973BfPSmLEJaFSI6aDe8dv2PwhCSH5jKtXW1MVCQvJYZf63rPY31rF6Y9ifbyvVG
 1YXVpPmkmETSZbU+hcLaSRkTkRYPPlrMgVxn1zEIo9tmtr/no/si8CvAC+8pgPrJNuTf
 UZ1FWPKjutUpanmyIactqevK9rMXVa7BXmP/cZkLXQw7E07DFHS3wkqE6W4pc7ltkB5M
 Rqk/esGHByrnSMUwncJ0SajAiveJx6OOExDOQ9BMJT6rblXiCWhVZe3WINHIfzfOWPYa
 T1Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQlmiHm00D4YJzrrO88Cx/d5RJdjQ3pIb9ncrEL29QGfpwTpfm3EA/v5zQ/QlpkL72aRWZaDv3iYez@nongnu.org
X-Gm-Message-State: AOJu0YzN+jtR0UwE/TIJ/Tlxw7WOzqr5LUNtKNkm3ngbHwOapSD1or/D
 6xiVbZNTSPet522kYNzGzOgtXRDFb3I5yHohbzwvTrO/ShnNdnClzF1xEwBeugY=
X-Gm-Gg: ASbGncu8NnVhF8dqy3LX/v8cBCd/OYX2oStmsGY/9JmFSHfRRMKlOa7D0C9WsDZQnYg
 Au4+AYVfYfuW9Cf+CbZuyi4ztVZ8xTi0433TpZj2tq2XCWaA62VeMXL8jvG2Jy48AL9rw1i7Q/1
 /EAbX12E9fA5y73ADbTrR4r1B2tEFpegni3hyVuoqkxIWKdaUWoiSr6PvSTv50qQV4tk6mV5KN8
 Tp4awhO3JMEov/kPvemmfxwLAw5LIkSTe3h0Uk9d2Wld92PsSGmzGb2f/NxV9uYHE3Ra/y8cnyB
 txCsogGRBraLJwc0hfZqpaPqpHjjAIEciuWiRF7rd3nHelXAr0dSijpRywHMhKdlrPCOcSNXapc
 ZbdiohpWF7Ho3
X-Google-Smtp-Source: AGHT+IGHi6QCqr5gpfzBss4iX0yNDj6o6n8zF6TnZLOeMu0h0gqjs7t33H7HrQdTtuXx9wKhSDF/LA==
X-Received: by 2002:adf:9599:0:b0:390:f6be:af1d with SMTP id
 ffacd0b85a97d-39973af9a76mr2308792f8f.41.1742394335293; 
 Wed, 19 Mar 2025 07:25:35 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318acfsm21520875f8f.70.2025.03.19.07.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 07:25:34 -0700 (PDT)
Message-ID: <014fe512-6271-4de3-8587-7ceafbc8c6b5@linaro.org>
Date: Wed, 19 Mar 2025 15:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <b2971494-525a-4d39-820d-7bb8905d60d5@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b2971494-525a-4d39-820d-7bb8905d60d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Cc'ing Markus.

On 6/3/25 02:56, Richard Henderson wrote:
> On 3/5/25 07:39, Philippe Mathieu-Daudé wrote:
>> +void legacy_binary_info_init(const char *argv0)
>> +{


>> +    for (size_t i = 0; i < ARRAY_SIZE(legacy_binary_infos); i++) {
>> +        if (!strcmp(legacy_binary_infos[i].binary_name, binary_name)) {
>> +            current_index = i;
>> +            return;
>> +        }
>> +    }


> When testing for errors before and after a patch, I often rename
> the binary, e.g. qemu-system-aarch64-good / qemu-system-aarch64-bad.

I'd not qemu-system-microblazeel-good to match qemu-system-microblaze.

> Leaving it in the same build directory is required in order to let
> it find the uninstalled rom images.
> 
> Is there a way we can preserve something akin to this?
> Do we need to add the -target command-line option that Pierrick mooted?

Not that easy, CLI is evaluated *after* QOM types are registered.
IIUC we'd need to add this as a -preconfig option, Markus is that right?


