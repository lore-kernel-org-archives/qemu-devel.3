Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CDFD3F08E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 16:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8NW-0000oQ-9f; Wed, 28 Jan 2026 11:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vl8N1-0000gP-P3
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:26:24 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vl8Mz-0008Jk-Td
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:26:19 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81f4e136481so3594390b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769617576; x=1770222376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x2UPlA47KT0VyI5qioe1jeqhj+3mfqHvvxkrehWiLY=;
 b=LWALRqsbcGhEMZulwUd1gjKMqyCLImIGGubwhf6uzKgNQQxLtFQx5hlSsaSHpp6bbC
 nEWSCJaRONwKC/bKP6PMq2YHDIAToWNxxeqB1sT7szDZeFKaK0UOTVnQl4yKPBcyBbT/
 PEQD/8sGdglnD6aPekp4y8tqx+ZQFN4wzPWTekqXkCjjA6C3OeC+DspHs9DXkgPFDSvZ
 6ACBYomzO39Qm3Kc19ZMWf0zY/NlMYQCMR0166vE3aB2GMrAGg8KBPfnbEvKLYHogENG
 T5XR5K6yKCxNbA8m9ij3dQmvKkSPd2qVm1Wg8AvrpTEj7eEmpo/4+ALz+jZoQPqpimZS
 P0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769617576; x=1770222376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2x2UPlA47KT0VyI5qioe1jeqhj+3mfqHvvxkrehWiLY=;
 b=TeZOYBRyFqNxs+PyU5/bHiejzvr5yeQxj3sQ32GzS4vKPEM9OOUK7VjhUNLpPJ82XL
 ixDFsyYdVK6zf6DqmSr3CibvA0Ivk74xnOGPGt/LhvWo4ypbYOzAmVEd+tgoKDQP0+mW
 Nh884XCLw0QKMX++sGp7kJ4Lp0qnjz0lBHjOY5fzWEOXbL4TXg42RRwSfICLU0kYqYoX
 p0RJ/guIqu5iTVtqz7XNMOihL+VBLYFyIgssIJNuTXCrJrq/81MRTiwkWiCR4bCTFtqL
 OQzHJXIwqFlrpj9QvlDv9OwW7ADO+JlXSk6mUruSSu+b8OHxS05MH6tRFKqWiODQPF6u
 sCxQ==
X-Gm-Message-State: AOJu0YyC2PuCaAj89RXtArpR2QsjHfHrDAareopQt+DAAE2yqU+GzWUx
 OZg+i4NAzBNXiS0sd/gRbHC7EzHCcH7bOzYr2co4W4QVamykcweBGIBK
X-Gm-Gg: AZuq6aIlrR28EO0caDypPJNNKGG8fobketgsE6uBmXl42pul4AgWkreGeM2a9oS89jm
 8M7mL1hrxtFGA249TLMoV/1mlT5WxpshNTTs5soKuRoeBbVNpb6IU01DNSuvolXiJxy9T+sQokl
 5SNre0cFqGSr/nSA2gnHI7Yc8uRW6Wrwo7Y3dgQbyMDjQddwXUCPByTnQyMVDJjM2Mta8ETDCuj
 LP2NMn9oZLVyUmdvR2/3ar7MfSdVDsau3YsCWcH0iUkXPrlO0WKyVHGzR9AfhIu6nibOVr6lAEb
 wMRmAE3NIWUD2kseUSug8WEhtntZ/ItYjiwsehA1HWQHSj8fXOIGQpm9H7RtuBZ28N0sygglFiL
 9+ouRzZSDRcgqeKaGThSitcC8FnWPV7lF3zclVfYkvX9EJKs02PKYMefphLO1zoDr3JSKpW1Dsn
 FKUFQeYZaNIj3xTYBbkFUKBDCiuJC4o6bjerUUaHJOeRL8FxIkHaGOFreujOY6NIahxU4=
X-Received: by 2002:a05:6a20:7486:b0:38d:ed39:35a0 with SMTP id
 adf61e73a8af0-38ec6547714mr5741400637.61.1769617575732; 
 Wed, 28 Jan 2026 08:26:15 -0800 (PST)
Received: from [192.168.1.4] ([183.195.22.224])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642487f1f5sm2818275a12.0.2026.01.28.08.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 08:26:15 -0800 (PST)
Message-ID: <4a717b95-e7c7-4a9a-b98f-37df63602a2a@gmail.com>
Date: Thu, 29 Jan 2026 00:25:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] tests/qtest: Add RISC-V IOMMU bare-metal test
 using iommu-testdev
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
 <97143bc3-b473-4e72-877c-b3bf9a70819d@ventanamicro.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <97143bc3-b473-4e72-877c-b3bf9a70819d@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

Thanks for the review and the kind words!

On 1/28/2026 10:42 PM, Daniel Henrique Barboza wrote:
>
>
> On 1/28/2026 9:09 AM, Chao Liu wrote:
>> Hi,
>>
>> This patch series adds a bare-metal qtest for the RISC-V IOMMU using the
>> iommu-testdev framework. The test exercises address translation paths
>> without requiring a full guest OS boot.
>>
>> Motivation
>> ----------
>>
>> The existing RISC-V IOMMU qtest (riscv-iommu-test.c) focuses on PCI device
>> enumeration and register-level validation:
>> - PCI configuration space verification (vendor/device ID)
>> - Register reset value checks
>> - Queue initialization procedures (CQ/FQ/PQ)
>>
>> However, it does not test the actual address translation functionality.
>> This new test fills that gap by using iommu-testdev to trigger DMA
>> transactions and validate the IOMMU's translation logic.
>>
>> Comparison with Existing Test
>> -----------------------------
>>
>> | Feature               | riscv-iommu-test.c | iommu-riscv-test.c (new) |
>> |-----------------------|--------------------|--------------------------|
>> | PCI config            | Yes                | No                       |
>> | Register reset        | Yes                | No                       |
>> | Queue init            | Yes                | Yes (via helper)         |
>> | Bare translation      | No                 | Yes                      |
>> | S-stage (SV39)        | No                 | Yes                      |
>> | G-stage (SV39x4)      | No                 | Yes                      |
>> | Nested translation    | No                 | Yes                      |
>> | DMA verification      | No                 | Yes                      |
>> | Uses iommu-testdev    | No                 | Yes                      |
>>
>> The new test provides:
>> - Device context (DC) configuration and validation
>> - SV39 page table walks for S-stage translation
>> - SV39x4 page table walks for G-stage translation
>> - Nested translation combining both stages
>> - FCTL register constraint validation
>> - End-to-end DMA verification
>
> I have a customized environment just to test IOMMU stuff (boot an Ubuntu emulated RISC-V host, see if the riscv-iommu works with a PCI net card). And even then this kind of test is limited by the amount of stuff the current Linux driver is capable of doing. And yet I have to at least give it a try with every IOMMU change/fix sent ... This new test will give us additional coverage that neither the existing test nor my manual testing can provide.
>
> Thank you for the time and effort putting into this work. This is really remarkable.
>
I'm glad this patch series can help us better test the RISC-V IOMMU.
The iommu-testdev framework makes it possible to exercise translation
paths directly without booting a full guest OS, which should make
regression testing much faster and more deterministic.
>>
>> Note: The current implementation only supports SV39/SV39x4. Support for
>> SV48/SV48x4/SV57/SV57x4 can be added in future patches.
>>
>> Testing
>> -------
>>
>> QTEST_QEMU_BINARY=./build/qemu-system-riscv64 \
>>    ./build/tests/qtest/iommu-riscv-test --tap -k
>>
>> Question for Maintainers
>> ------------------------
>>
>> The existing riscv-iommu-test.c and the new iommu-riscv-test.c serve
>> complementary purposes. Would it be beneficial to merge these two tests
>> into a single source file for easier maintenance? This would consolidate
>> all RISC-V IOMMU testing in one place while preserving both the
>> register-level and translation-level test coverage.
>
> I'll give my non-maintainer opinion because I happen to be the author of riscv-iommu-test.c: as long as we preserve the existing tests for both files I'm ok with it. Maybe there are code re-use opportunities that will be exposed when merging the 2 together.
>
> But I believe this can wait. We should push this upstream first (or at least get it queued into the maintainer's tree).
>
>
I share the same view. That's exactly why I didn't merge them directly
in this series - the two tests serve different purposes (register-level
vs translation-level), and keeping them separate for now makes the
review process cleaner. We can explore merging opportunities later once
this is upstream.

Thanks,
Chao
> Thanks,
> Daniel
>
>>
>> Thanks,
>> Chao
>>
>> Chao Liu (2):
>>    tests/qtest/libqos: Add RISC-V IOMMU helper library
>>    tests/qtest: Add RISC-V IOMMU bare-metal test
>>
>>   MAINTAINERS                          |   2 +
>>   tests/qtest/iommu-riscv-test.c       | 279 +++++++++++++++++++
>>   tests/qtest/libqos/meson.build       |   2 +-
>>   tests/qtest/libqos/qos-riscv-iommu.c | 400 +++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-riscv-iommu.h | 172 ++++++++++++
>>   tests/qtest/meson.build              |   5 +-
>>   6 files changed, 858 insertions(+), 2 deletions(-)
>>   create mode 100644 tests/qtest/iommu-riscv-test.c
>>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
>>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h
>>
>> -- 
>> 2.52.0
>>
>

