Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAE4D3E76E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTPAC-0006OI-Ep; Wed, 10 Dec 2025 13:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTPA2-0006ND-NP
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTP9z-0003ZV-TZ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765392215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zr7uvmt/71xEwB5JJWgF6aR8P9yGGYRmX+C9qoOaMCA=;
 b=PMs1pvryC8f9+sONQHZZtGVZEgW2WerlcgRmuoox6ttlD9JTqdxQA9Yg5uKZQuwpHWLSyo
 TzZAOWdUx7fG+1y1WvQvP8xrhhjnrTnqbW8zAIh6slaHc7q2g0AkbTuIs47xAZ92gokdMQ
 ZhTARACVcfPoPj32ZVQ1OIsO/Hx/Mak=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-XXrTmHkfMzSd9-V0_01W4Q-1; Wed, 10 Dec 2025 13:43:31 -0500
X-MC-Unique: XXrTmHkfMzSd9-V0_01W4Q-1
X-Mimecast-MFC-AGG-ID: XXrTmHkfMzSd9-V0_01W4Q_1765392211
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-299d221b749so3160855ad.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765392210; x=1765997010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr7uvmt/71xEwB5JJWgF6aR8P9yGGYRmX+C9qoOaMCA=;
 b=n96X1v1Gm5SSK/YRWaW9V4C1C4Wbq8ILBM/OCD/myZ+BzRK9eaQsZY3SI84rsOE2o3
 41kaHMHcXNWnq2ZSA41POlg19wGf1qgoVq+djUdlTMtsCzeoJeCjaO+OI+p/R8DDBbi1
 9kZEOSk5d9HFR9fGb+T+5ShM5phB+C6DhDOpyqQRmbeZW1q2rxIaArydQDp29Wf8AEhU
 Xtd4wLcqvpHaPgkQG/V0MtXJDeUEAVDXZt6b5v2Z+1I6HGIfG81Spc9j1o9LiZ8PEvkz
 fzPZ/2msemqpO5qc5YFf9psCE8653cORXbJ/nNPIr6P7EksTBQBsJ111+cNCcsqpTGDW
 zVCg==
X-Gm-Message-State: AOJu0YxOXZpGxOq008cb5S/kqG0W5o++lOqLLVHjazJLoKqSbn9Ve4rp
 Oye/CDsbe6FI0R5hrvmPHjp0hqNrcCGw6g/tor717OzkFLK/RQlEo/hd1w1VV9mWU03/+zr/xo2
 s/JkMRvYkWoQRbPxTx6e8V4Lu+dY4L4l3wCvez+aL2wCVp2b6C3YKOoLK
X-Gm-Gg: AY/fxX7qa8MBRKROXXdDR++/ZUb4q6psZfhqXMJHHBMhyBa6RovHtx/fT2zpZ7dCyzV
 K2+wUuxXRgFn0ytIJloMsRDxU506dqjIQOgfZ0Vwp99nSGc+X+4gEtdAWRfEua22Bc1zKj04bXv
 vk8E5Pjot1Zxa6OPrf+Zhi+nLrw3OHQ+EFL3EQ3L7EzPYU/DuC6lIlpHIVXRIkrKOwSNl/OpfbK
 cIbTXZjSVS11Z1mT2roVWmSSTadEx58sorBgryUtfURhBeHTEGTBSxi52N11Lo7OexlcFuMegOB
 g+oc/+1fISDRarHPDq8AgCuxbkJTo6Z6OjPSlO6m8WA6j1hjRtDi3OHrZW5UMdIrH17FdJLNS35
 Q5aNmEaDZ/GL1Rcc1T9yZXPAJHauRgvvhQhfsWqxlMaPQV5r8lSYXbAffyg==
X-Received: by 2002:a17:902:ebd1:b0:296:3f23:b909 with SMTP id
 d9443c01a7336-29ec25aaefamr40674825ad.39.1765392210587; 
 Wed, 10 Dec 2025 10:43:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE10V6X8Z/KwEFd/T62QX+LOP3jbBU+yBv9QUA571/PA8CD3dy4oJU4/qINtDG7giF03syQBA==
X-Received: by 2002:a17:902:ebd1:b0:296:3f23:b909 with SMTP id
 d9443c01a7336-29ec25aaefamr40674535ad.39.1765392210187; 
 Wed, 10 Dec 2025 10:43:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29ee9b36c98sm813995ad.8.2025.12.10.10.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 10:43:29 -0800 (PST)
Message-ID: <e95d82af-540f-43b0-9f0c-2e5928192049@redhat.com>
Date: Wed, 10 Dec 2025 19:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 3/4] tests/qtest/libqos: Add SMMUv3 helper library
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-4-tangtao1634@phytium.com.cn>
 <9b2c0429-a8bb-4df4-ad95-492f463cf29f@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9b2c0429-a8bb-4df4-ad95-492f463cf29f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/5/25 12:53 AM, Pierrick Bouvier wrote:
> On 11/26/25 7:45 AM, Tao Tang wrote:
>> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
>> operations. This module encapsulates common tasks like:
>>
>> - SMMUv3 initialization (enabling, configuring command/event queues)
>> - Stream Table Entry (STE) and Context Descriptor (CD) setup
>> - Multi-level page table construction (L0-L3 for 4KB granules)
>> - Support for Stage 1, Stage 2, and nested translation modes
>> - Could be easily extended to support multi-space testing infrastructure
>>      (Non-Secure, Secure, Root, Realm)
>>
>> The library provides high-level abstractions that allow test code to
>> focus on IOMMU behavior validation rather than low-level register
>> manipulation and page table encoding. Key features include:
>>
>> - Automatic memory allocation for translation structures with proper
>>      alignment
>> - Helper functions to build valid STEs/CDs for different translation
>>      scenarios
>> - Page table walkers that handle address offset calculations per
>>      security space
>> - Command queue management for SMMU configuration commands
>>
>> This infrastructure is designed to be used by iommu-testdev-based tests
>> and future SMMUv3 test suites, reducing code duplication and improving
>> test maintainability.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   tests/qtest/libqos/meson.build  |   3 +
>>   tests/qtest/libqos/qos-smmuv3.c | 731 ++++++++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-smmuv3.h | 267 ++++++++++++
>>   3 files changed, 1001 insertions(+)
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>>
>
> ...
>
>> +
>> +void qsmmu_single_translation(QSMMUTestContext *ctx)
>> +{
>> +    uint32_t config_result;
>> +    uint32_t dma_result;
>> +    bool test_passed;
>> +
>> +    /* Configure SMMU translation */
>> +    config_result = qsmmu_setup_and_enable_translation(ctx);
>> +    if (config_result != 0) {
>> +        g_test_message("Configuration failed: mode=%u status=0x%x",
>> +                       ctx->config.trans_mode, config_result);
>> +        return;
>
> Is that expected to silently return if we can't configure translation?
>
>> +    }
>> +
>> +    /* Trigger DMA operation */
>> +    dma_result = qsmmu_trigger_dma(ctx);
>> +    if (dma_result != 0) {
>> +        g_test_message("DMA failed: mode=%u result=0x%x",
>> +                       ctx->config.trans_mode, dma_result);
>> +    } else {
>> +        g_test_message("-> DMA succeeded: mode=%u",
>> ctx->config.trans_mode);
>> +    }
>> +
>> +    /* Validate test result */
>> +    test_passed = qsmmu_validate_test_result(ctx);
>> +    g_assert_true(test_passed);
>> +
>> +    /* Clean up translation state to prepare for the next test */
>> +    qsmmu_cleanup_translation(ctx);
>> +}
>> +
>> +void qsmmu_translation_batch(const QSMMUTestConfig *configs, size_t
>> count,
>> +                             QTestState *qts, QPCIDevice *dev,
>> +                             QPCIBar bar, uint64_t smmu_base)
>> +{
>> +    for (int i = 0; i < count; i++) {
>> +        /* Initialize test memory */
>> +        qtest_memset(qts, configs[i].dma_iova, 0x00,
>> configs[i].dma_len);
>> +        /* Execute each test configuration */
>> +        QSMMUTestContext ctx = {
>> +            .qts = qts,
>> +            .dev = dev,
>> +            .bar = bar,
>> +            .smmu_base = smmu_base,
>> +            .config = configs[i],
>> +            .trans_status = 0,
>> +            .dma_result = 0,
>> +            .sid = dev->devfn,
>> +            .tx_space = qsmmu_sec_sid_to_space(configs[i].sec_sid),
>> +        };
>> +
>> +        qsmmu_single_translation(&ctx);
>> +        g_test_message("--> Test %d completed: mode=%u sec_sid=%u "
>> +                       "status=0x%x result=0x%x", i,
>> configs[i].trans_mode,
>> +                       configs[i].sec_sid, ctx.trans_status,
>> ctx.dma_result);
>> +    }
>> +}
>
> What is the reason for batching operations?
> We are not in a performance critical scenario for running this test,
> so it's probably better to have distinct calls to single_translation.
>
> ...
>
> For the rest of the patch, which is quite consequent, congrats. It's
> hard to review all the setup phase here, but knowing it works with the
> current smmuv3 implementation, that's a good proof that it's working
> as expected. 

That's a huge amount of code indeed. I don't how much we shall review
this test lib but if it needs std review the patch needs to be split to
ease the review. Maybe qtest maintainers can give some guidelines here...

Eric


