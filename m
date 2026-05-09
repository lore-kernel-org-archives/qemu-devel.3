Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B8CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 15:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLjBM-00088t-Pl; Sat, 09 May 2026 11:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLjBH-00087O-7o
 for qemu-devel@nongnu.org; Sat, 09 May 2026 11:01:28 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLjBF-00078h-AD
 for qemu-devel@nongnu.org; Sat, 09 May 2026 11:01:26 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbd23bc684so1801333a34.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778338883; x=1778943683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LRSs61uOZyy3QFNA5dmqwjJoY4JmEZKzzakUWRijlcU=;
 b=RYCa+CnjjYywsYCqLZjoqDt+iboaKjg8GAjccNqrBVkc8d6GKH9O0SFFGG3XXEIXyO
 XMNXDmr4qPtUqug5MRxafeTuF1BBxgZ2/GBvLhp2OR0sNzlQo0Zpk8sS1FbwUQWsFOz3
 hu1J+8zGBxyhh4vfWvCgwffXJOmQGDc1dG6fQ65mG+cHc66y8vCfyKp3aK4Av0tnFbv7
 i77xhf7V1vjX/PPtWWzRfiAxjBtI0ej/miCnZTmcc58LjBMqnQJDK4esuyUFUMfexTwC
 SNWeMAr5nJwTH9kN7EyojQPBZ+jjbZWXrSh1SpG5RF+8Uj+hiqmrNBjY5NsOd3bjJlDO
 h1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778338883; x=1778943683;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRSs61uOZyy3QFNA5dmqwjJoY4JmEZKzzakUWRijlcU=;
 b=shttS9wm5cLCsrqQ3UJChHFPBLpqzDYmS5J3N4zIX3ywTeG/yp+BLTa42uEu+a5gvi
 vslLu2VE7GTTLmMA/dePHhK4s5GLDl2EP36u0bBG1Kw1pRD9UuTaGwznC52JfUp4wbXS
 A12GMD+npMsKtIYL3+5nxme/w6WCmq2UYbH5h0w5ZYqOtpHM4yj27AJMD17hcRqQkeV4
 uNJsu/siM6E8zxQ3sSNOtd1vsc7DQQwbV5a220Zm6lc72JqRsGJ7B9hw0A9lPpOJ+8Zs
 lYzkfvzrmM+xzTduqsLeAr+hADMhn8y1jyW6QNJDBWE5nbKBKkd/43BElxlqdDB4bawx
 SvnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8P0r/kfKQuRxcJC/mzIRRHr5KmGVCx1kKEOgAGCB0jdWLxU2sSnnjBW/2ld7EFK+pWDy84yp+Gr8D2@nongnu.org
X-Gm-Message-State: AOJu0Yy+FPlcrDZYwUfv8c1Zek5s7d33MlYvOH4FOAjiRxV8Oj51673G
 g8vqJHfMVDnkLNvcDK4VunUJAm+3bffFcoZ7DYtr/w13/+dKVxATAL1udSsy8I57AkM=
X-Gm-Gg: Acq92OEQ/TVR3t9GI6KCi+00q9UyshItU1l5cxxEr0JJ8qEgtPU+kDqWyaDcqWMLYOG
 caWG6zymvswbBKAS0Uef+yr8rbSPicoaj3WW4mDyCIhUuF/2aZINzM4zFRES4/J4QNJl4CMZiyG
 6oeWGlPzzmHJqFT0vZzXH3s87aFJFjOl7e2k7orRlO0j236JlE+CJF5XsFhysF3i6Bc+Kkq5Y9O
 TexldmO5so0LRNY6L4Pqt4Gdo3xQzEe6FCc+aheFe7IEnZcL9clBGIw1nmHRRZkWOvd4F6F7yL0
 m/wDz7crJsOkcViZh+j1C9SYsWvSDR9YI/LZSiPacMJENUkYr82ezRFL+npd3dbR/PdAajt7V5B
 XvIGHHe/o4v8KaatDaGnfYQeFqz5M+n5lQoGI37TE8wQdhZIiUv3eNSNI26b6/woN7OOz/woWhq
 4xOAHrNZaal+LW6KJAorA+SdZYl9C1M0DZSiaMlp3HmR3RIo1OwDDr7WrFqf6ghBpTqWVvdJl9/
 o8JrIHPa2sm1VrHDQJ2
X-Received: by 2002:a05:6830:2a10:b0:7db:d229:d51e with SMTP id
 46e09a7af769-7e381f98af6mr1817088a34.12.1778338883026; 
 Sat, 09 May 2026 08:01:23 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:88d3:58e4:a68b:b30c?
 ([2600:381:c938:6375:88d3:58e4:a68b:b30c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d50611sm3205140a34.16.2026.05.09.08.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 08:01:22 -0700 (PDT)
Message-ID: <b60572e5-6a5b-4477-a16a-ba20d0585716@linaro.org>
Date: Sat, 9 May 2026 10:01:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] target-info: extract target_info() definition in
 target-info-init.h
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
 <20260509005453.3984184-4-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509005453.3984184-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 5/8/26 19:54, Pierrick Bouvier wrote:
> +#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME

I guess avoiding TARGET_NAME can wait until we actually build a single binary.

> +typedef struct TargetInfoQomTarget {
> +    TargetInfoQom parent;
> +} TargetInfoQomTarget;
> +
> +typedef struct TargetInfoQomTargetClass {
> +    TargetInfoQomClass parent_class;
> +} TargetInfoQomTargetClass;
> +
> +OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)

Since neither the object nor class are actually used; you don't need these.

> +static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
> +{                                                                           \
> +    TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
> +    klass->parent_class.target_info = &ti_var;                              \
> +}                                                                           \

This belongs in vl.c as target_info_parent_type.class_base_init.

> +static const TypeInfo target_info_qom_target_type_info = {                  \
> +    .name = TYPE_TARGET_INFO_TARGET,                                        \
> +    .parent = TYPE_TARGET_INFO,                                             \
> +    .instance_size = sizeof(TargetInfoQomTarget),                           \
> +    .class_size = sizeof(TargetInfoQomTargetClass),                         \
> +    .class_init = target_info_qom_class_init,                               \
> +    .abstract = false,                                                      \
> +};                                                                          \

This reduces to just name, parent, and class_data.
You don't need sizes, class_init, or abstract.


r~

