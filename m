Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38C8C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 04:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulh5t-0004xq-Fp; Tue, 12 Aug 2025 00:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulh5r-0004xQ-0y
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:58:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulh5l-00064k-EP
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:58:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b913b7dbe3so29312f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 21:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754974706; x=1755579506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XtV47jOYd0pfwJ02xLr5PUN1R1ZRoqD2/4YJUm5Fnpw=;
 b=g834SnXvGFqNfcc6zFVD0EoUeSGy1jk23mnlan0tQgDXB3S6c5t6zwO61iOxBLv7gX
 u73OPZswdO5zl+wAqfYvYTx8JDBaPpev6Nt+lt+iaMu9cxqkwZvrLfimbNLEBQFXBBYQ
 LNI/fz91YTOt1vqPr1l2bxw0DiZDmbJYPg13gIeLTu3Rz/YEcFLFy7ED7oS8c9ss6ArC
 AGlTArW38p/DhG2wQBWSmgYN/gRqs/2q7GyAsld9XfQAfQvOsiQfBVKXdDl8p9TPY5N0
 DutaPTV8UompSWyAHvej46oH83zK29tZqG1CoRH5WadAocYYpYAjP9mj6hNukJOfQKpu
 ZBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754974706; x=1755579506;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XtV47jOYd0pfwJ02xLr5PUN1R1ZRoqD2/4YJUm5Fnpw=;
 b=osmRRd0qsjHm4MPP4N/zypO6vm1Sievwlgr/9LGaz5d+NHNGdDHEBBfA0F+LyPc4Zo
 GpstSevomrsVJ1JAFr1IcghQl/XYjuSoiU1+C616/3PUSJxHJNeaSmlqRncEpzG0V1iR
 iG0NPcbh27GRkE/7Ut8UiQox9Lwc8XnxmwH86aipnmxO99qZNnh9mi5sLcJa6Qt0ipZa
 E77vT5WppL8XJF9RF+m1ZDGi5qaRRlrUytHujvgu2k2gUtyB3dx7osm5YLNIoqwhwLlO
 1op594I6Fo4B2KF2kcnXzUJKXD8FpX7/z5AUiH5hqxcdWaufWOa/DotLUqeji9p9PpYn
 ZE5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3TSTOvWP8QW6gL6NUost32z6NMkhnJuL3gYpU3SlMDUR+hPqjPlllSc/d2p53+zpjyXYcypOFu8bc@nongnu.org
X-Gm-Message-State: AOJu0YzHcxdWfCzZ0uNecWsuLi+RhwBDoEz8V7JDDwBD5iTWy/0J4YQ4
 Abukgcu4iX68cgOABTmLPd3QvsamGKu23PEf9c+V8Tb7EfgzrGs6ro24jJUMSzi6WjnZSqO4+Bc
 HKhxB
X-Gm-Gg: ASbGncsf3c9jE5hA5mwwQ8pb32Vatl8XA8YTk/TO3CdInFEVKzgPtWg/MuYk+aGzVYJ
 kbROAgod8/UnUTrXbvLKzuRfyUpWI76VQqa09durXowUh5iYsl9WRixLqTyuKfj63iz2NqCdHk0
 GcmhXxcuppfKMmppnEoP6OI+TmV59/S2yjCL2Z3jf+L4mQehqxFrbIYWP3jY/gWLULgCciBx5Gs
 X5vtKM7ODpfO+2p5Iwbdi8Y3B7hHcKIj+0LkEwxBND2v4NHfF22C7blWQpKp3aQo97lZ1WL5AEl
 MejEAp7yO/Ept8916FUtLZVNJl8yJ0M+i2g93UCbJxMZrH71Ve8r/XS1th/izA9sqn1FxkMSE+d
 3dU+jhJpFYWBS1KEIRz1igSVxCCPkkWaxmNjVfmk7/uJ4VcjzFbKWL05eED2cJ3jLTg==
X-Google-Smtp-Source: AGHT+IFZbBwticS4mpRf5MkGiv95D/0ePz44UTHQTw1jWed+ABPpoHQKqNvwHI2Tl6mCChv7aypyYA==
X-Received: by 2002:a05:6000:188f:b0:3b8:d3cc:8dc with SMTP id
 ffacd0b85a97d-3b900b5040amr12186888f8f.28.1754974705912; 
 Mon, 11 Aug 2025 21:58:25 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b911469bffsm1753439f8f.36.2025.08.11.21.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 21:58:25 -0700 (PDT)
Message-ID: <2cc56fd3-7992-4c06-bed2-353aa15ba5b5@linaro.org>
Date: Tue, 12 Aug 2025 06:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] target/arm: Introduce
 arm_hw_accel_cpu_feature_supported()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-6-philmd@linaro.org>
 <2e5d40ac-927f-4109-b285-c0635b959066@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2e5d40ac-927f-4109-b285-c0635b959066@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 12/8/25 02:35, Richard Henderson wrote:
> On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
>> Introduce arm_hw_accel_cpu_feature_supported() helper,
>> an accelerator implementation to return whether a ARM
>> feature is supported by host hardware. Allow optional
>> fallback on emulation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/cpu.h     | 12 ++++++++++++
>>   target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
>>   target/arm/kvm.c     | 22 ++++++++++++++++++++++
>>   3 files changed, 54 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index dc9b6dce4c9..5136c4caabf 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -2507,6 +2507,18 @@ static inline ARMSecuritySpace 
>> arm_secure_to_space(bool secure)
>>   }
>>   #if !defined(CONFIG_USER_ONLY)
>> +
>> +/**
>> + * arm_hw_accel_cpu_feature_supported:
>> + * @feat: Feature to test for support
>> + * @can_emulate: Whether Allow to fall back to emulation if @feat is not
>> + *               supported by hardware accelerator
>> + *
>> + * Hardware accelerator implementation of cpu_feature_supported().
>> + */
>> +bool arm_hw_accel_cpu_feature_supported(enum arm_features feat,
>> +                                        bool can_emulate);
> 
> internals.h.

OK, but since hw/intc/arm_gicv3_hvf.c calls host_cpu_feature_supported,
the other one has to stay in "cpu.h" (see
https://lore.kernel.org/qemu-devel/20250808070137.48716-5-mohamed@unpredictable.fr/).

