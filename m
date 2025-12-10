Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD60D3E771
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTP76-0005TT-OG; Wed, 10 Dec 2025 13:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTP72-0005Rl-GK
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTP6z-00038T-DZ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765392028;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fC2okjvQPNCerM3jp2jWcvYVb5UofwtwHW7JG29GHpM=;
 b=TfXWH3Dra7uj7d/a7mPIskNGBXyQ6XDKCTfSXzCEboERWtR3JLRMGQO22RHbEJJcFrMDFW
 Ya9J4emKmhbwxrjDDH8/R3DdXX4qSd96tTlvXxr1fUB/q1lia+r7iXcq4jcgogWXZLsrOo
 1ek+u7wqCmA3nyCRF/oDnDp2b2EM428=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-6L-9dZjEOcyEFcKyRpv1MQ-1; Wed, 10 Dec 2025 13:40:26 -0500
X-MC-Unique: 6L-9dZjEOcyEFcKyRpv1MQ-1
X-Mimecast-MFC-AGG-ID: 6L-9dZjEOcyEFcKyRpv1MQ_1765392025
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29e921af9easo2776255ad.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765392025; x=1765996825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fC2okjvQPNCerM3jp2jWcvYVb5UofwtwHW7JG29GHpM=;
 b=eniLa6+VbIUMWMmv+Zp12r9witjCcxUFcN1EzrJSNUFM9dGj6sNYsoohf0O2u6OwD3
 WCE2hLryEzGRlTze/8LRytsjzWd3Wmh/+W4UJseSEeL9VQSrn7yzCwMVwfGI0ikm73yC
 V9dHRRLZMPAhahoz51V8ZNyeJweOSAy2cwLQXr/2bLd+AoLhMw2aPxpAQPwBcuU6L+Fs
 dgSUPsfYB/857w7nsZepoZrwN/f5Gqv2teOClEnZxpSPeDvG3Sr3ELY8fYh4XrttP4M0
 6mOSl8hjiDOePcqv7ehx6HTxv9LDc+B/ihDhYCx0nFsOK+ia+WrShJIO6Me+TR9MpFOp
 oiJw==
X-Gm-Message-State: AOJu0YyzmDTRY/ws8NG9HdqSxrs81Lba/Crs+lJRmFSpUmw0jQ+4gtbM
 gc1NfJ0GSW5DLiVTKs1OXXpnOQbIsTBm5FFI0AS2K/gzk6vKmhaCRGFu6V6S1Couhbu1WmkANaQ
 oPUKV7+rB7znMS9x6bb7+CR3l3wFWKoN19sFyK6+uoFKhyZsRuqsHilsz
X-Gm-Gg: AY/fxX6QJ7AP9ja7h0hBsKHN+dLs2/c0CUi6g6bdXFSq2RIZZthf7WCPtA7jA6vCnwi
 oCfr6QoEl52U2XHhOVUKgZiCZ/3dwaEuadMThEDzjMzXcH2mogeVNp83w/3ODPD60vOjh1MQ3Io
 NnWWAsXihNKUVA4KzMBDZQF5egI6xxsWv82WH6X5o3kxGooqYVZJ289n3WznnKdVhQbbLwKZjhN
 +FwvLUKm+U4zLbkYbdYJ+QORR87XPeF1w59SnKPkB4X0rQ0FB0cPwzE773WF2voWekjsbxmPYIU
 TpH99bGELL/v6hLRs+A8BWapQ5UjeCsoe9ZwZVwFloBd4V7oPY49NGgFRcNgE5Eb6TZnspp+5Ux
 46oUIqMKVtu+gqWWAGXdt4qCuy+CGbpZcm3zV5FxtNYS31kdqjevFbDLwlQ==
X-Received: by 2002:a17:903:1a2c:b0:290:b53b:7456 with SMTP id
 d9443c01a7336-29ec22e3ea4mr32851855ad.5.1765392025536; 
 Wed, 10 Dec 2025 10:40:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH0G3/SxfySL4XfvLn1KP1y62i4y2oVrztOBx9YeOy2s1BhLDF8oExaLXUeDH+xrLDGRRWtQ==
X-Received: by 2002:a17:903:1a2c:b0:290:b53b:7456 with SMTP id
 d9443c01a7336-29ec22e3ea4mr32851685ad.5.1765392025051; 
 Wed, 10 Dec 2025 10:40:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29ee9d38c7fsm773715ad.39.2025.12.10.10.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 10:40:24 -0800 (PST)
Message-ID: <5af3335d-632b-432a-80d8-80ca4d20d06a@redhat.com>
Date: Wed, 10 Dec 2025 19:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 3/4] tests/qtest/libqos: Add SMMUv3 helper library
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-4-tangtao1634@phytium.com.cn>
 <9b2c0429-a8bb-4df4-ad95-492f463cf29f@linaro.org>
 <b184c907-e073-43d0-87b9-cf8c6c23dbed@phytium.com.cn>
 <a361b46f-2173-4c98-a5d3-6b4d2ac004af@linaro.org>
 <41c33694-008e-4ee1-bbe2-1498e9b6c9c7@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <41c33694-008e-4ee1-bbe2-1498e9b6c9c7@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Tao,

On 12/6/25 6:27 AM, Tao Tang wrote:
>
> On 2025/12/6 01:19, Pierrick Bouvier wrote:
>> On 12/5/25 7:03 AM, Tao Tang wrote:
>>> Hi Pierrick,
>>>
>>> On 2025/12/5 07:53, Pierrick Bouvier wrote:
>>>> On 11/26/25 7:45 AM, Tao Tang wrote:
>>>>> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
>>>>> operations. This module encapsulates common tasks like:
>>>>>
>>>>> - SMMUv3 initialization (enabling, configuring command/event queues)
>>>>> - Stream Table Entry (STE) and Context Descriptor (CD) setup
>>>>> - Multi-level page table construction (L0-L3 for 4KB granules)
>>>>> - Support for Stage 1, Stage 2, and nested translation modes
>>>>> - Could be easily extended to support multi-space testing
>>>>> infrastructure
>>>>>       (Non-Secure, Secure, Root, Realm)
>>>>>
>>>>> The library provides high-level abstractions that allow test code to
>>>>> focus on IOMMU behavior validation rather than low-level register
>>>>> manipulation and page table encoding. Key features include:
>>>>>
>>>>> - Automatic memory allocation for translation structures with proper
>>>>>       alignment
>>>>> - Helper functions to build valid STEs/CDs for different translation
>>>>>       scenarios
>>>>> - Page table walkers that handle address offset calculations per
>>>>>       security space
>>>>> - Command queue management for SMMU configuration commands
>>>>>
>>>>> This infrastructure is designed to be used by iommu-testdev-based
>>>>> tests
>>>>> and future SMMUv3 test suites, reducing code duplication and
>>>>> improving
>>>>> test maintainability.
>>>>>
>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>> ---
>>>>>    tests/qtest/libqos/meson.build  |   3 +
>>>>>    tests/qtest/libqos/qos-smmuv3.c | 731
>>>>> ++++++++++++++++++++++++++++++++
>>>>>    tests/qtest/libqos/qos-smmuv3.h | 267 ++++++++++++
>>>>>    3 files changed, 1001 insertions(+)
>>>>>    create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>>>>>    create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>>>>>
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +void qsmmu_single_translation(QSMMUTestContext *ctx)
>>>>> +{
>>>>> +    uint32_t config_result;
>>>>> +    uint32_t dma_result;
>>>>> +    bool test_passed;
>>>>> +
>>>>> +    /* Configure SMMU translation */
>>>>> +    config_result = qsmmu_setup_and_enable_translation(ctx);
>>>>> +    if (config_result != 0) {
>>>>> +        g_test_message("Configuration failed: mode=%u status=0x%x",
>>>>> +                       ctx->config.trans_mode, config_result);
>>>>> +        return;
>>>>
>>>> Is that expected to silently return if we can't configure translation?
>>>
>>>
>>> No, it is not intended to silently return on a failed configuration.
>>> Maybe an assertion is a better choice:
>>>
>>>
>>> config_result = qsmmu_setup_and_enable_translation(ctx);
>>>
>>> g_assert_cmpuint(config_result, ==, 0);
>>>
>>
>> Looks good. We should rely on exit code first, and then on verbose
>> log to find what is the problem.
>>
>>>>
>>>>> +    }
>>>>> +
>>>>> +    /* Trigger DMA operation */
>>>>> +    dma_result = qsmmu_trigger_dma(ctx);
>>>>> +    if (dma_result != 0) {
>>>>> +        g_test_message("DMA failed: mode=%u result=0x%x",
>>>>> +                       ctx->config.trans_mode, dma_result);
>>>>> +    } else {
>>>>> +        g_test_message("-> DMA succeeded: mode=%u",
>>>>> ctx->config.trans_mode);
>>>>> +    }
>>>>> +
>>>>> +    /* Validate test result */
>>>>> +    test_passed = qsmmu_validate_test_result(ctx);
>>>>> +    g_assert_true(test_passed);
>>>>> +
>>>>> +    /* Clean up translation state to prepare for the next test */
>>>>> +    qsmmu_cleanup_translation(ctx);
>>>>> +}
>>>>> +
>>>>> +void qsmmu_translation_batch(const QSMMUTestConfig *configs, size_t
>>>>> count,
>>>>> +                             QTestState *qts, QPCIDevice *dev,
>>>>> +                             QPCIBar bar, uint64_t smmu_base)
>>>>> +{
>>>>> +    for (int i = 0; i < count; i++) {
>>>>> +        /* Initialize test memory */
>>>>> +        qtest_memset(qts, configs[i].dma_iova, 0x00,
>>>>> configs[i].dma_len);
>>>>> +        /* Execute each test configuration */
>>>>> +        QSMMUTestContext ctx = {
>>>>> +            .qts = qts,
>>>>> +            .dev = dev,
>>>>> +            .bar = bar,
>>>>> +            .smmu_base = smmu_base,
>>>>> +            .config = configs[i],
>>>>> +            .trans_status = 0,
>>>>> +            .dma_result = 0,
>>>>> +            .sid = dev->devfn,
>>>>> +            .tx_space = qsmmu_sec_sid_to_space(configs[i].sec_sid),
>>>>> +        };
>>>>> +
>>>>> +        qsmmu_single_translation(&ctx);
>>>>> +        g_test_message("--> Test %d completed: mode=%u sec_sid=%u "
>>>>> +                       "status=0x%x result=0x%x", i,
>>>>> configs[i].trans_mode,
>>>>> +                       configs[i].sec_sid, ctx.trans_status,
>>>>> ctx.dma_result);
>>>>> +    }
>>>>> +}
>>>>
>>>> What is the reason for batching operations?
>>>> We are not in a performance critical scenario for running this test,
>>>> so it's probably better to have distinct calls to single_translation.
>>>
>>>
>>> As described in the previous thread [1] , I plan to split the tests so
>>> that each translation mode is exercised by its own qtest. With that
>>> split in place, there is no real need for a qsmmu_translation_batch()
>>> helper anymore, so I refactor it into a qsmmu_run_translation_case
>>> function and drop the inside for-loop.
>>>
>>
>> All good, indeed removes the need for translation_batch.
>>
>>>
>>> [1]
>>> https://lore.kernel.org/qemu-devel/7370070a-c569-4b77-bd1e-6fc749ba9c90@phytium.com.cn/
>>>
>>>
>>>>
>>>> ...
>>>>
>>>> For the rest of the patch, which is quite consequent, congrats. It's
>>>> hard to review all the setup phase here, but knowing it works with the
>>>> current smmuv3 implementation, that's a good proof that it's working
>>>> as expected.
>>>
>>>
>>> Yes, setting up all this infrastructure did take some time, especially
>>> getting the nested mode page tables right (and Secure state-related
>>> configuration which is still in my local repo).
>>>
>>
>> Feel free to start with the current version, and then you'll add
>> secure state related changes as part of your other series.
>>
>>> I really appreciate that you ran the tests yourself and even checked
>>> with a coverage-enabled build to confirm that it exercises the smmuv3
>>> implementation. Thanks again for the thorough review.
>>>
>>
>> In case someone else wants to reproduce:
>> $ export CFLAGS="--coverage"
>> $ ./configure --target-list=aarch64-softmmu
>> $ ninja -C build
>> $ QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
>>   ./build/tests/qtest/iommu-smmuv3-test
>> $ rm -rf build/coverage_html
>> $ mkdir build/coverage_html
>> $ gcovr \
>>       --gcov-ignore-parse-errors suspicious_hits.warn \
>>       --gcov-ignore-parse-errors negative_hits.warn \
>>       --merge-mode-functions=separate \
>>       --html-details build/coverage_html/index.html \
>>       --filter 'hw/arm/smmu*'
>> $ echo file://$(pwd)/build/coverage_html/index.html
>> # open this in browser by clicking on your terminal
>>
>> If useful for you, you can attach those instructions in your next
>> cover letter, so people can easily reproduce. 

are you ready to maintain that code (esp the lib)? You shall add an
entry in the MAINTAINERS file for those new files I guess.

Eric
>>
>
> Hi Pierrick,
>
> Got it, I’ll keep this series focused on the current non-secure smmuv3
> implementation, and the coverage instructions you shared are very
> helpful — I’ll add them to the next cover letter so that other
> reviewers can easily reproduce the results.
>
> Thanks again for all the detailed review and guidance.
>
> Best regards,
> Tao
>


