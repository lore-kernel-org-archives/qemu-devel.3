Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF83E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 17:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYSKs-0000O1-2j; Wed, 24 Dec 2025 12:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vYSKq-0000NQ-VT
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 12:07:40 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vYSKo-0007me-IS
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 12:07:40 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so6066732b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 09:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766596057; x=1767200857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YE+tSS7IqHovaO5lWdvQAvJFPXmQE6W5fRcFccALirk=;
 b=Z0Isnc6KauKFllBiSFrnZzIHh0pfLpfFWwUFZlLMitlRtVE8Dwa+gbO5NR2mSfK/62
 WZlMLDCvawgGqcLtXQsVM+n3q4gAo0wPB2pQ9VQ1sc5UVIWO0QaCBAVvV+Fm5b0RPe/k
 FvxOfkpANXQPgPOSvDiriwK8CHh3QVTGKTK8MkiqA76u8eCRe8JEXrMo2ece2bWbtyXB
 8t10RpRyYEH+QQH+pKeBypCtSSb2LeKnhUl0P6GbFi7XSifOjnqLBL+7OzvyjfrCdkea
 NXEshyhv2vbt1n34XiP9S53vUk3yzpBIQ47xgVBp8sf3yJZGEJhI/S3129w8t4KXwnw5
 9jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766596057; x=1767200857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YE+tSS7IqHovaO5lWdvQAvJFPXmQE6W5fRcFccALirk=;
 b=QInuKBnjc+82A48nIuU7il1lpKUtmSV4wiHesE+5HuGYgWSUtGXFHfuk5Wh1HS1On/
 +t6N6nwomOCxiGVDmtArN+S7kyJpTp2qwqh0KhNZ/OdeyimaWRYKhwcGrEpCL4ijeD+G
 yNBj34vIkdm2f14dUEk+9IY5p/ZEaJWXMXjtCUaFJuqQSVdJjYaWtZ6Z5owrgnpv1dJu
 1ZRdVk0nAHSmHZ1Re6LHL96FDduiyGqDmsGFVpWsBfRdC/aILtBf4Grv974ppLiJM8bF
 NuBRdDfK99bLnRYFnviTM5GilV3QQSZ2/SZTbUw5yGnONQK71e5nLqAf/SWOnKYrFwIS
 ODNg==
X-Gm-Message-State: AOJu0YwNp9Lt4PTVMO/0rll/JeXJdBchISC1BWMY+z3xHRFaw11JIpEF
 rQ28n9icVHD7j6l8o5cXJnsSmNiuWzQwl1v4so1Gni31ZVWTbuvqDf4H/jJu3NG3/I+CNY2YMHJ
 xTYrW
X-Gm-Gg: AY/fxX4F39IlH7iIPE9RpdiHN6rX4aKP2hnRbxXcU6MMfy0jtnp7sjfSn45Kj/oo1Ir
 ncL+GYA6wZhhPi+ig8e/ZujfInCRN6/fsPIy69+3XVTA4qrH0hSR6CUPUPixtBgAbpb82qe2SSh
 RtUY80N/3fbIhIk6D9ojFn2yzyYy7W3B1GowRbP6lZWXVoFO1Tn+dgPYHLC/K1i2a4KzRJ6swTm
 j5fEdKzppWrpxljX5LMUL3lJgqDOoIUwiR30jdpFHTtBzMBj0HaT2pYZ01dQp2swfHNMPIKumm0
 y3WddqdAtI9G7eS9vafpOkKMzMoNRqt1Azaz8rNmPw2TzTwFZr0YS5fUHXQdIrAQ9VFxuXFBUzo
 n9smrNnEY1LCXHcLU1758IfXtETIKW1ipBCv86HpQkyMGXshNSa9w2bPo7p9OR7aeqs3V1SCi1g
 ILw8DqVWOq0yFoomE4KsWxrd+6Rpmucp2qCWVX4Eo1ye/rM645ANdbmVw=
X-Google-Smtp-Source: AGHT+IHzIVOYvvzI/77k0xo0qw4enny/F91N3BmeyZJLHBi/RUhTnWc0HiGRtXOeXLphjgTRYzpMTQ==
X-Received: by 2002:a05:6a20:3ca6:b0:334:8759:5016 with SMTP id
 adf61e73a8af0-376a85d3dc8mr17535298637.28.1766596056651; 
 Wed, 24 Dec 2025 09:07:36 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7961b4d0sm14839335a12.5.2025.12.24.09.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Dec 2025 09:07:35 -0800 (PST)
Message-ID: <d13a730f-c108-4bca-9845-6aceaca76bb2@linaro.org>
Date: Wed, 24 Dec 2025 09:07:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 0/7] hw/misc: Introduce a generalized IOMMU test framework
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 12/23/25 7:46 PM, Tao Tang wrote:
> Changes since v7: Following Pierrick’s feedback, this version fixes the
> uint64_t formatting issue
> (switching to PRIx64 to avoid %lx mismatches on non-LP64 platforms). I also
> validated the series with Pierrick’s qemu-ci workflow, and all jobs passed;
> the CI run is available at:
> 
> https://github.com/hnusdr/qemu/actions/runs/20476259310
> 
> Motivation
> ----------
> 
> Currently, thoroughly testing IOMMU emulation (e.g., ARM SMMUv3) requires
> a significant software stack. We need to boot a full guest operating
> system (like Linux) with the appropriate drivers (e.g., IOMMUFD) and rely
> on firmware (e.g., ACPI with IORT tables or Hafnium) to correctly
> configure the IOMMU and orchestrate DMA from a peripheral device.
> 
> This dependency on a complex software stack presents several challenges:
> 
> * High Barrier to Entry: Writing targeted tests for specific IOMMU
>      features (like fault handling, specific translation regimes, etc.)
>      becomes cumbersome.
> 
> * Difficult to Debug: It's hard to distinguish whether a bug originates
>      from the IOMMU emulation itself, the guest driver, the firmware
>      tables, or the guest kernel's configuration.
> 
> * Slow Iteration: The need to boot a full guest OS slows down the
>      development and testing cycle.
> 
> The primary goal of this work is to create a lightweight, self-contained
> testing environment that allows us to exercise the IOMMU's core logic
> directly at the qtest level, removing the need for any guest-side software.
> 
> Our Approach: A Dedicated Test Framework
> -----------------------------------------
> 
> To achieve this, we introduce three main components:
> 
> * A minimal hardware device: iommu-testdev
> * A reusable IOMMU helper library: libqos/qos-smmuv3
> * A comprehensive qtest suite: iommu-smmuv3-test
> 
> The iommu-testdev is intentionally not a conformant, general-purpose PCIe
> or platform device. It is a purpose-built, highly simplified "DMA engine"
> designed to be analogous to a minimal PCIe Root Complex that bypasses the
> full, realistic topology (Host Bridges, Switches, Endpoints) to provide a
> direct, programmable path for a DMA request to reach the IOMMU. Its sole
> purpose is to trigger a DMA transaction when its registers are written to,
> making it perfectly suited for direct control from a test environment like
> qtest.
> 
> The Qtest Framework
> -------------------
> 
> The new qtest (iommu-smmuv3-test.c) serves as the "bare-metal driver"
> for both the IOMMU and the iommu-testdev. It leverages the libqos helper
> library to manually perform all the setup that would typically be handled
> by the guest kernel and firmware, but in a completely controlled and
> predictable manner:
> 
> 1.  IOMMU Configuration: It directly initializes the SMMU's registers to a
>      known state using helper functions from qos-smmuv3.
> 
> 2.  Translation Structure Setup: It uses the libqos library to construct
>      the necessary translation structures in memory, including Stream Table
>      Entries (STEs), Context Descriptors (CDs), and Page Tables (PTEs).
> 
> 3.  DMA Trigger: It programs the iommu-testdev to initiate a DMA operation
>      targeting a specific IOVA with configurable attributes.
> 
> 4.  Verification: It waits for the transaction to complete and verifies
>      that the memory was accessed correctly after address translation by
>      the IOMMU.
> 
> This framework provides a solid and extensible foundation for validating
> the IOMMU's core translation paths. The current test suite covers:
> 
> - Stage 1 only translation (VA -> PA via CD page tables)
> - Stage 2 only translation (IPA -> PA via STE S2 tables)
> - Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
> 
> The infrastructure is designed to be extended to support additional
> security spaces and IOMMU features.
> 
> 
> Testing:
> --------
> QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
>    ./build/tests/qtest/iommu-smmuv3-test --tap -k
> 
> 
> If you want to check coverage report, please follow instructions below
> which are shared by Pierrick in previous review [1]
> 
> # install gcovr if not already installed, `sudo apt install gcovr`
> # on ubuntu for example
> $ export CFLAGS="--coverage"
> $ ./configure --target-list=aarch64-softmmu
> $ ninja -C build
> $ QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
>    ./build/tests/qtest/iommu-smmuv3-test
> $ rm -rf build/coverage_html
> $ mkdir build/coverage_html
> $ gcovr \
>        --gcov-ignore-parse-errors suspicious_hits.warn \
>        --gcov-ignore-parse-errors negative_hits.warn \
>        --merge-mode-functions=separate \
>        --html-details build/coverage_html/index.html \
>        --filter 'hw/arm/smmu*'
> # check the version of gcovr if meeting some unsupported options error.
> # Upgrading to 8.4 version may resolve the error.
> $ gcovr --version
> $ pip install --user --upgrade gcovr
> $ echo file://$(pwd)/build/coverage_html/index.html
> # open this in browser by clicking on your terminal
> 
> [1] https://lore.kernel.org/qemu-devel/a361b46f-2173-4c98-a5d3-6b4d2ac004af@linaro.org/
> 
> 
> Major Changes from v7 to v8:
> -----------------------------
>    - Fix uint64_t formatting issue by using PRIx64 for portability
>    - Validate the series with Pierrick's qemu-ci workflow; all jobs passed
>    - This series is also saved in github repo [5]
> [5] https://github.com/hnusdr/qemu/tree/iommu-testdev-v8-community
> 
> 
> Major Changes from v6 to v7:
> -----------------------------
>    - Split the smmuv3-common.h work into smaller patches
>      (registerfields conversion, NSCFG bits, helper setters)
>    - Add MAINTAINERS entries for iommu-testdev and qos-smmuv3 helpers
>    - Tighten documentation wording and update the DMA test pattern value
>    - Simplify qtest PCI device discovery and rename QSMMU_IOVA constant
>    - This series is also saved in github repo [4]
> 
> [4] https://github.com/hnusdr/qemu/tree/iommu-testdev-v7-community
> 
> 
> Major Changes from v5 to v6:
> -----------------------------
>    - Split batch testing into individual test cases per translation mode
>    - Removed cleanup functions and related codes or comments
>    - Improved error handling with explicit assertions
>    - Add coverage build and test instructions shared by Pierrick
>    - Keep Reviewed-by and Tested-by from Pierrick's review
>    - This series is also saved in github repo [2]
> 
> [2] https://github.com/hnusdr/qemu/tree/iommu-testdev-v6-community
> 
> 
> Major Changes from v4 to v5:
> -----------------------------
>   - Remove a duplicated patch that was accidentally included in v4.
> 
> 
> Major Changes from v3 to v4:
> -----------------------------
> 
> 1. Added shared smmuv3-common.h so both the device and libqos consume the same
>     STE/CD/register definitions as Alex suggested [3]
> 2. Slimmed iommu-testdev down to a pure DMA trigger with a tighter MMIO
>     contract (new doorbell helper, simplified attributes/errors).
> 3. Updated `qos-smmuv3` and the qtest so they include the common header,
>     honor per-test expected results, and rely solely on the streamlined device
>     interface.
> 4. Compacted changes of v2 to v3.
> 
> [3] https://lore.kernel.org/qemu-devel/87zf8jk244.fsf@draig.linaro.org/
> 
> 
> Major Changes from v2 to v3:
> -----------------------------
> 
> 1. Generalization/Renaming: rebranded `smmu-testdev` → `iommu-testdev` (code,
>     headers, docs) to reflect the broadened scope.
> 2. Separation of concerns: iommu-testdev is now a pure DMA trigger; all
>     SMMUv3-specific setup (STE/CD/page tables, multi-mode support, space offsets)
>     lives in `qos-smmuv3.{c,h}` and is consumed by the new qtest.
> 3. Improved modularity & coverage: the stacked design (device + helper + qtest)
>     made it straightforward to add S1/S2/Nested tests, a cleaner config system,
>     and clearer validation logic.
> 4. Code/documentation quality: added tracepoints, better error handling/naming,
>     and refreshed `docs/specs/iommu-testdev.rst` with the new layout.
> 
> Future Work
> -----------
> 
> The current implementation focuses on basic translation path validation
> in the Non-Secure address space. Future extensions could include:
> 
> * Multi-space testing (Secure, Root, Realm) for SMMUv3
> * Support for other IOMMU types (Intel VT-d, AMD-Vi, RISC-V IOMMU)
> 
> 
> Tao Tang (7):
>    hw/arm/smmuv3: Extract common definitions to smmuv3-common.h
>    hw/arm/smmuv3-common: Define STE/CD fields via registerfields
>    hw/misc: Introduce iommu-testdev for bare-metal IOMMU testing
>    hw/arm/smmuv3-common: Add NSCFG bit definition for CD
>    hw/arm/smmuv3-common: Add STE/CD set helpers for repeated field setup
>    tests/qtest/libqos: Add SMMUv3 helper library
>    tests/qtest: Add SMMUv3 bare-metal test using iommu-testdev
> 
>   MAINTAINERS                     |  13 +
>   docs/specs/index.rst            |   1 +
>   docs/specs/iommu-testdev.rst    | 112 ++++++
>   hw/arm/smmuv3-internal.h        | 255 +------------
>   hw/misc/Kconfig                 |   5 +
>   hw/misc/iommu-testdev.c         | 271 ++++++++++++++
>   hw/misc/meson.build             |   1 +
>   hw/misc/trace-events            |  10 +
>   include/hw/arm/smmuv3-common.h  | 423 +++++++++++++++++++++
>   include/hw/misc/iommu-testdev.h |  68 ++++
>   tests/qtest/iommu-smmuv3-test.c | 121 ++++++
>   tests/qtest/libqos/meson.build  |   3 +
>   tests/qtest/libqos/qos-smmuv3.c | 633 ++++++++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-smmuv3.h | 256 +++++++++++++
>   tests/qtest/meson.build         |   1 +
>   15 files changed, 1919 insertions(+), 254 deletions(-)
>   create mode 100644 docs/specs/iommu-testdev.rst
>   create mode 100644 hw/misc/iommu-testdev.c
>   create mode 100644 include/hw/arm/smmuv3-common.h
>   create mode 100644 include/hw/misc/iommu-testdev.h
>   create mode 100644 tests/qtest/iommu-smmuv3-test.c
>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h
> 

Thanks for updating, all CI is green now.

On my side, it's all good and ready to be merged. Let's see if 
maintainers have final comments to do.

Regards,
Pierrick

