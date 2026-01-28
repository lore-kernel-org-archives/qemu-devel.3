Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ED3D3F071
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6l6-0007TY-Dr; Wed, 28 Jan 2026 09:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vl6l0-0007MJ-FJ
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:42:58 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vl6kk-000544-Br
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:42:43 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-894638da330so76902706d6.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1769611361; x=1770216161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8meOxQYWVfq85cBQRY2YXzz7t9j/hDNLBNjbHaogJPc=;
 b=i9YSjK88Re7/L63jWYI/6m+Jo5G4xdkPvU55GoCMBxsV/KEyiTMr4912O3TCUSfkCP
 6+F9VifbQGReOnF3JaTls24s7dlwJkLBeSqEDoDTk1k4v8Sbn5PuAA34STFYAthXSp3s
 JqIGqZKxWFfHERfnSua2DGWPD461nZKf5d3UkY5CAEH/VLjCeW2dzCYFjBNdj12J/IQD
 OLqxBOSBefL+faBr2oxbA8HZ2trHf24Y++BwEK/DdLXsvHF1VQTBhtWParzPO3AQK8Un
 ipPVCU9JrGk4mrGozKjq50+ApMIcR08K/J5eIOPivwBAc8tvEj2GS0ekYRBAyTX8KB4v
 mOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769611361; x=1770216161;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8meOxQYWVfq85cBQRY2YXzz7t9j/hDNLBNjbHaogJPc=;
 b=F4rVuDjep6P3XmRiOH3BtrUVCoxKyL250BoWCnDVcmBLbTTwdYkVYjDgoWDBQnmi9N
 w2U2RVR5aXsEB/edm2jij4l8p2MTR6idaKu2tcSMyeIi8S+FTZHAJ2j8UZ7U9hG3/Wge
 aNh6aEeFq7fBNKuf//J9fT4WXTr4v0Lh4E39OM4/+XOAzfPNPpDv5pzjVYYrcX2VV8Mw
 udo9pIfJXnXTRy2UPQKNKvSzTEff0C0J+ffHKBSplOEmZLmx3dchPu0RO0zFaieRSTz1
 P5BF1Z5AbLVz4jwng7XMg9coj/ubPbHIsuLV/iPzU3buIu0wfFt1nQyIMeM+stNMvDAH
 vpLg==
X-Gm-Message-State: AOJu0YwxS6Rc+NouZceC2e7gKMYFsyrYVilnxH/ieN3dh+FxsohrjgK9
 VFICPimMMT8hpksZ0cxMXBq3q+asQE5TSa3EkOwanMo8fKRWnnvG2THFTu3u7szWVe0=
X-Gm-Gg: AZuq6aJ0RLsgMPTesRLpaOW+D3iahejgE3QfQu42Rcwe7ha62jbJuSCaQHOUglbiM40
 o7axHQWxgX1mYhtbwrLHm9SxUwjp3563lwC3vZFwOwtLOLncaNyoCuDgK6FtluvuTWk0QsaEdpT
 5Pi/RMopPazt4w8GS39bq3+32cnQIc41xXIJXPP86paVqNtaXbeHl8oNXjyVIOnmGS9KqpkEoiR
 DI9wUZfKJsmilyi24mejBx2Wp7emjyBsWOXv2PTlWEBk+egUE3awyI8t7P1wtalqPBZvnh4adCV
 siyBJMibrCqh8iC1/N3uXCyG+ZtbWw25Zbo3/eE+F4NgQPQUZLSk26SOnq7Jbt6M/tgFB/cx/dK
 2hDu7oKuVTILZWCyrd9KnCz5QLDd1khGVT5IrWIWZzKr+KXNKQ9n2lWjRtndxeKk+0VzVuXDKUL
 tOn0M0Oi6zYyg86MSw3Sjh/PzEzlJAjaFqJwCuGLE=
X-Received: by 2002:ad4:5d68:0:b0:880:4310:7e02 with SMTP id
 6a1803df08f44-894cc7f8a47mr80717276d6.21.1769611360850; 
 Wed, 28 Jan 2026 06:42:40 -0800 (PST)
Received: from [192.168.15.23] ([179.118.208.129])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d36a5ca2sm18057636d6.7.2026.01.28.06.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 06:42:40 -0800 (PST)
Message-ID: <97143bc3-b473-4e72-877c-b3bf9a70819d@ventanamicro.com>
Date: Wed, 28 Jan 2026 11:42:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] tests/qtest: Add RISC-V IOMMU bare-metal test
 using iommu-testdev
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf31.google.com
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



On 1/28/2026 9:09 AM, Chao Liu wrote:
> Hi,
> 
> This patch series adds a bare-metal qtest for the RISC-V IOMMU using the
> iommu-testdev framework. The test exercises address translation paths
> without requiring a full guest OS boot.
> 
> Motivation
> ----------
> 
> The existing RISC-V IOMMU qtest (riscv-iommu-test.c) focuses on PCI device
> enumeration and register-level validation:
> - PCI configuration space verification (vendor/device ID)
> - Register reset value checks
> - Queue initialization procedures (CQ/FQ/PQ)
> 
> However, it does not test the actual address translation functionality.
> This new test fills that gap by using iommu-testdev to trigger DMA
> transactions and validate the IOMMU's translation logic.
> 
> Comparison with Existing Test
> -----------------------------
> 
> | Feature               | riscv-iommu-test.c | iommu-riscv-test.c (new) |
> |-----------------------|--------------------|--------------------------|
> | PCI config            | Yes                | No                       |
> | Register reset        | Yes                | No                       |
> | Queue init            | Yes                | Yes (via helper)         |
> | Bare translation      | No                 | Yes                      |
> | S-stage (SV39)        | No                 | Yes                      |
> | G-stage (SV39x4)      | No                 | Yes                      |
> | Nested translation    | No                 | Yes                      |
> | DMA verification      | No                 | Yes                      |
> | Uses iommu-testdev    | No                 | Yes                      |
> 
> The new test provides:
> - Device context (DC) configuration and validation
> - SV39 page table walks for S-stage translation
> - SV39x4 page table walks for G-stage translation
> - Nested translation combining both stages
> - FCTL register constraint validation
> - End-to-end DMA verification

I have a customized environment just to test IOMMU stuff (boot an Ubuntu 
emulated RISC-V host, see if the riscv-iommu works with a PCI net card). 
And even then this kind of test is limited by the amount of stuff the 
current Linux driver is capable of doing. And yet I have to at least 
give it a try with every IOMMU change/fix sent ... This new test will 
give us additional coverage that neither the existing test nor my manual 
testing can provide.

Thank you for the time and effort putting into this work. This is really 
remarkable.

> 
> Note: The current implementation only supports SV39/SV39x4. Support for
> SV48/SV48x4/SV57/SV57x4 can be added in future patches.
> 
> Testing
> -------
> 
> QTEST_QEMU_BINARY=./build/qemu-system-riscv64 \
>    ./build/tests/qtest/iommu-riscv-test --tap -k
> 
> Question for Maintainers
> ------------------------
> 
> The existing riscv-iommu-test.c and the new iommu-riscv-test.c serve
> complementary purposes. Would it be beneficial to merge these two tests
> into a single source file for easier maintenance? This would consolidate
> all RISC-V IOMMU testing in one place while preserving both the
> register-level and translation-level test coverage.

I'll give my non-maintainer opinion because I happen to be the author of 
riscv-iommu-test.c: as long as we preserve the existing tests for both 
files I'm ok with it. Maybe there are code re-use opportunities that 
will be exposed when merging the 2 together.

But I believe this can wait. We should push this upstream first (or at 
least get it queued into the maintainer's tree).


Thanks,
Daniel

> 
> Thanks,
> Chao
> 
> Chao Liu (2):
>    tests/qtest/libqos: Add RISC-V IOMMU helper library
>    tests/qtest: Add RISC-V IOMMU bare-metal test
> 
>   MAINTAINERS                          |   2 +
>   tests/qtest/iommu-riscv-test.c       | 279 +++++++++++++++++++
>   tests/qtest/libqos/meson.build       |   2 +-
>   tests/qtest/libqos/qos-riscv-iommu.c | 400 +++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-riscv-iommu.h | 172 ++++++++++++
>   tests/qtest/meson.build              |   5 +-
>   6 files changed, 858 insertions(+), 2 deletions(-)
>   create mode 100644 tests/qtest/iommu-riscv-test.c
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h
> 
> --
> 2.52.0
> 


