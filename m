Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C9DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 16:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rywpI-00081P-5f; Mon, 22 Apr 2024 12:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rywp3-00080P-3q
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 12:47:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rywp0-00012Q-Q1
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 12:47:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ed20fb620fso3870056b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713804432; x=1714409232; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aJLrmmDZ1b1wEEBqlhG5LMFF9PxxIOoGYxCH76bhZ0=;
 b=DaeOi1mPM1pontLTpxB7i94nYE1OcrzDUm4wBDedAnbhBiVJ5oWaCgAi//7fVuNH5a
 Myd2IM6NrklZjRZGOrWlj4K/xx4Ymp4DPLPXPXLdVOE9aMt1W4TW37hT83ONMoXs8Dvq
 qGs50nKt73Cz3EFS+IEPgZZghlU1J5iFg4xOUA2qmn6H+YGTVcWs2XE4IdmXlp8JKBvK
 QFjrQ8tWphpSO+iyos0TLAzoAT/6nFOMj2Yim3pw15L8PSZ6XZu+cbGi9JoyN1S3KIIV
 S/pA3BhUUuJzq9q5w7dT8KtxvA7Nit7OFxYhQn55KHnXNY6KBzJ9IqBNWSHLVoENPee+
 vkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713804432; x=1714409232;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4aJLrmmDZ1b1wEEBqlhG5LMFF9PxxIOoGYxCH76bhZ0=;
 b=ciuuPCoGW+lJSCG3R/M3zLgTccKGMyI3TLMmPzdza8Z7LOZf9Yg9TKeF611jrdw4HF
 D+gS73jAy4qHMHTpdWAMhdshK8OTnLs6ajZElvJgo2gFHyRhSsbFB6CjT6qY5/ATobfN
 wZPQ9b/m4u6SaqLyIpvWj2QCzWVQrPTcnoVj4tZ+86GJAn3YirpQNta3Xj2B+dg879HM
 L7aGXnHzx5mNohOc6JR3eJ6PkoORDiabV7eZrxnGo8WSJU5HQME61WPpd6FpPlA2hC74
 +sS3JNe7lD2x99QJ0U0Rx5PlcOxOoMPxKIax0Du97o4cr8q3ry+P/fP5wuCvTbLCsuB0
 Fjhg==
X-Gm-Message-State: AOJu0Yy4gjbtcgE6wdV+EV2rFph4qJLCKNxilR8mwyv9zh3zZKYI45hl
 LKupUr1kzCvWW4iooI8m1/89A0y2q5U3bFjTUPQFXhy7qC6nfMSziMjfIlTh9Qc=
X-Google-Smtp-Source: AGHT+IHjoNSiNApXmt1qn9xPUHwOYpKmEyEUgLIlorcgYEnGxB2ouNIjz1jsdNy624j7fvtiWGAkGw==
X-Received: by 2002:a05:6a21:3989:b0:1a7:51f1:f778 with SMTP id
 ad9-20020a056a21398900b001a751f1f778mr12507775pzc.37.1713804432283; 
 Mon, 22 Apr 2024 09:47:12 -0700 (PDT)
Received: from [192.168.0.102] ([177.139.3.212])
 by smtp.gmail.com with ESMTPSA id
 f33-20020a056a000b2100b006ecee611c05sm8058930pfu.182.2024.04.22.09.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 09:47:11 -0700 (PDT)
Subject: Re: [PATCH 0/6] Add ivshmem-flat device
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 lvivier@redhat.com, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 pbonzini@redhat.com, anton.kochkov@proton.me, richard.henderson@linaro.org,
 peter.maydell@linaro.org, Bill Mills <bill.mills@linaro.org>
References: <20240222222218.2261956-1-gustavo.romero@linaro.org>
 <87wmqp3xug.fsf@pond.sub.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <a28f3657-c827-7a0d-a8da-b82d17d17577@linaro.org>
Date: Mon, 22 Apr 2024 13:47:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87wmqp3xug.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.335,
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

Hi Markus,

Thanks for interesting in the ivshmem-flat device.

Bill Mills (cc:ed) is the best person to answer your question,
so please find his answer below.

On 2/28/24 3:29 AM, Markus Armbruster wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
> [...]
> 
>> This patchset introduces a new device, ivshmem-flat, which is similar to the
>> current ivshmem device but does not require a PCI bus. It implements the ivshmem
>> status and control registers as MMRs and the shared memory as a directly
>> accessible memory region in the VM memory layout. It's meant to be used on
>> machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g.,
>> lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring a tiny
>> 'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
>> memory-constrained resource targets.
>>
>> The patchset includes a QTest for the ivshmem-flat device, however, it's also
>> possible to experiment with it in two ways:
>>
>> (a) using two Cortex-M VMs running Zephyr; or
>> (b) using one aarch64 VM running Linux with the ivshmem PCI device and another
>>      arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.
>>
>> Please note that for running the ivshmem-flat QTests the following patch, which
>> is not committed to the tree yet, must be applied:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html
> 
> What problem are you trying to solve with ivshmem?
> 
> Shared memory is not a solution to any communication problem, it's
> merely a building block for building such solutions: you invariably have
> to layer some protocol on top.  What do you intend to put on top of
> ivshmem?

Actually ivshmem is shared memory and bi-direction notifications (in this case a doorbell register and an irq).

This is the fundamental requirement for many types of communication but our interest is for the OpenAMP project [1].

All the OpenAMP project's communication is based on shared memory and bi-directional notification.  Often this is on a AMP SOC with Cortex-As and Cortex-Ms or Rs.  However we are now expanding into PCIe based AMP. One example of this is an x86 host computer and a PCIe card with an ARM SOC.  Other examples include two systems with PCIe root complex connected via a non-transparent bridge.

The existing PCI based ivshmem lets us model these types of systems in a simple generic way without worrying about the details of the RC/EP relationship or the details of a specific non-transparent bridge.  In fact the ivshmem looks to the two (or more) systems like a non-transparent bridge with its own memory (and no other memory access is allowed).

Right now we are testing this with RPMSG between two QEMU system where both systems are cortex-a53 and both running Zephyr. [2]

We will expand this by switching one of the QEMU systems to either arm64 Linux or x86 Linux.

We (and others) are also working on a generic virtio transport that will work between any two systems as long as they have shared memory and bi-directional notifications.

Now for ivshmem-flat.  We want to expand this model to include MCU like CPUs and RTOS'es that don't have PCIe.  We focus on Cortex-M because every open source RTOS has an existing port for one of the Cortex-M machines already in QEMU.  However they don't normally pick the same one.  If we added our own custom machine for this, the QEMU project would push back and even if accepted we would have to do a port for each RTOS.  This would mean we would not test as many RTOSes.

The ivshmem-flat is actually a good model for what a Cortex-M based PCIe card would look like.  The host system would see the connection as PCIe but to the Cortex-M it would just appear as memory, MMR's for the doorbell, and an IRQ.

So even after we have a "roll your own machine definition from a file", I expect ivshmem and ivshmem-flat to still be very useful.

[1] https://www.openampproject.org/
[2] Work in progress here: https://github.com/OpenAMP/openamp-system-reference/tree/main/examples/zephyr/dual_qemu_ivshmem


Cheers,
Gustavo

