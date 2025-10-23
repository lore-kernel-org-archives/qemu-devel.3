Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0541FCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBrFj-00038H-62; Thu, 23 Oct 2025 05:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vBrFg-00035s-VK; Thu, 23 Oct 2025 05:04:56 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vBrFe-00045E-8a; Thu, 23 Oct 2025 05:04:56 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnCSw7_looZVpAA--.32950S2;
 Thu, 23 Oct 2025 17:04:48 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB32eag7_lojwBnAA--.38881S2;
 Thu, 23 Oct 2025 17:04:39 +0800 (CST)
Message-ID: <ee9e6c20-55c0-4636-a8d1-f616ad31a9e7@phytium.com.cn>
Date: Thu, 23 Oct 2025 17:04:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] hw/misc: Introduce a new SMMUv3 test framework
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB32eag7_lojwBnAA--.38881S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWj5PBkB+gAJsO
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3WrW8Jw4kZw4rWFW5Ww4DJwb_yoWxCF4rpF
 Z3Wa4ayF48JFn7Cr1xAw40vFy5Xws3Jw4UCr1fKw1xu3sxCFyvqFyxK34FyF95J39YvF1I
 vw4Utr1kWan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gentle ping.

Any feedback on this patch series would be appreciated.


V2: 
  https://lore.kernel.org/qemu-devel/20250930165340.42788-1-tangtao1634@phytium.com.cn/

V1: 
  https://lore.kernel.org/qemu-devel/20250925153550.105915-1-tangtao1634@phytium.com.cn/


On 2025/10/1 00:53, tangtao1634 wrote:
> From: Tao Tang <tangtao1634@phytium.com.cn>
>
> This patch series (V2) introduces several cleanups and improvements to the smmu-testdev device. The main goals are to refactor shared code, enhance robustness, and significantly clarify the complex page table construction used for testing.
>
> Motivation
> ----------
>
> Currently, thoroughly testing the SMMUv3 emulation requires a significant
> software stack. We need to boot a full guest operating system (like Linux)
> with the appropriate drivers (e.g., IOMMUFD) and rely on firmware (e.g.,
> ACPI with IORT tables or Hafnium) to correctly configure the SMMU and
> orchestrate DMA from a peripheral device.
>
> This dependency on a complex software stack presents several challenges:
>
> * High Barrier to Entry: Writing targeted tests for specific SMMU
>      features (like fault handling, specific translation regimes, etc.)
>      becomes cumbersome.
>
> * Difficult to Debug: It's hard to distinguish whether a bug originates
>      from the SMMU emulation itself, the guest driver, the firmware
>      tables, or the guest kernel's configuration.
>
> * Slow Iteration: The need to boot a full guest OS slows down the
>      development and testing cycle.
>
> The primary goal of this work is to create a lightweight, self-contained
> testing environment that allows us to exercise the SMMU's core logic
> directly at the qtest level, removing the need for any guest-side software.
>
> Our Approach: A Dedicated Test Device
> -------------------------------------
>
> To achieve this, we introduce two main components:
>
> * A new, minimal hardware device: smmu-testdev.
> * A corresponding qtest that drives this device to generate SMMU-bound
>      traffic.
>
> A key question is, "Why introduce a new smmu-testdev instead of using an
> existing PCIe or platform device?"
>
> The answer lies in our goal to minimize complexity. Standard devices,
> whether PCIe or platform, come with their own intricate initialization
> protocols and often require a complex driver state machine to function.
> Using them would re-introduce the very driver-level complexity we aim to
> avoid.
>
> The smmu-testdev is intentionally not a conformant, general-purpose PCIe
> or platform device. It is a purpose-built, highly simplified "DMA engine."
> I've designed it to be analogous to a minimal PCIe Root Complex that
> bypasses the full, realistic topology (Host Bridges, Switches, Endpoints)
> to provide a direct, programmable path for a DMA request to reach the SMMU.
> Its sole purpose is to trigger a DMA transaction when its registers are
> written to, making it perfectly suited for direct control from a test
> environment like qtest.
>
> The Qtest Framework
> -------------------
>
> The new qtest (smmu-testdev-qtest.c) serves as the "bare-metal driver"
> for both the SMMU and the smmu-testdev. It manually performs all the
> setup that would typically be handled by the guest kernel and firmware,
> but in a completely controlled and predictable manner:
>
> 1.  SMMU Configuration: It directly initializes the SMMU's registers to a
>      known state.
>
> 2.  Translation Structure Setup: It manually constructs the necessary
>      translation structures in memory, including Stream Table Entries
>      (STEs), Context Descriptors (CDs), and Page Tables (PTEs).
>
> 3.  DMA Trigger: It programs the smmu-testdev to initiate a DMA operation
>      targeting a specific IOVA.
>
> 4.  Verification: It waits for the transaction to complete and verifies
>      that the memory was accessed correctly after address translation by
>      the SMMU.
>
> This framework provides a solid and extensible foundation for validating
> the SMMU's core translation paths. The initial test included in this
> series covers a basic DMA completion path in the Non-Secure bank,
> serving as a smoke test and a proof of concept.
>
> It is worth noting that this series currently only includes tests for the
> Non-Secure SMMU. I am aware of the ongoing discussions and RFC patches
> for Secure SMMU support. To avoid a dependency on unmerged work, this
> submission does not include tests for the Secure world. However, I have
> already implemented these tests locally, and I am prepared to submit
> them for review as soon as the core Secure SMMU support is merged
> upstream.
>
>
> Changes from v1 RFC:
> - Clarify Page Table Construction:
> Detailed comments have been added to the page table construction logic. This is a key improvement, as the test setup extensively re-uses the same set of page tables for multiple translation stages and purposes (e.g., nested S1/S2 walks, CD fetch). The new comments explain this sharing mechanism, which can otherwise be confusing to follow.
>
> - Refactor Shared Helpers:
> The helper functions std_space_offset and std_space_to_str are now moved to a common header file. This allows them to be used by both the main device implementation (hw/misc/smmu-testdev.c) and its qtest (tests/qtest/smmu-testdev-qtest.c), improving code re-use and maintainability.
>
> - Enhance Robustness:
> Assertions have been added to ensure the device operates only in the expected Non-secure context. Additional conditional checks are also included to prevent potential runtime errors and make the test device more stable.
>
> - Code Simplification and Cleanup:
> Several functions that were redundant with existing macros for constructing Context Descriptors (CD) and Stream Table Entries (STE) have been removed. This simplifies the test data setup and reduces code duplication.
>
> Other unused code fragments have also been removed to improve overall code clarity and hygiene.
>
> Tao Tang (2):
>    hw/misc/smmu-testdev: introduce minimal SMMUv3 test device
>    tests/qtest: add SMMUv3 smoke test using smmu-testdev DMA source
>
>   docs/specs/index.rst             |   1 +
>   docs/specs/smmu-testdev.rst      |  45 ++
>   hw/misc/Kconfig                  |   5 +
>   hw/misc/meson.build              |   1 +
>   hw/misc/smmu-testdev.c           | 943 +++++++++++++++++++++++++++++++
>   include/hw/misc/smmu-testdev.h   | 402 +++++++++++++
>   tests/qtest/meson.build          |   1 +
>   tests/qtest/smmu-testdev-qtest.c | 238 ++++++++
>   8 files changed, 1636 insertions(+)
>   create mode 100644 docs/specs/smmu-testdev.rst
>   create mode 100644 hw/misc/smmu-testdev.c
>   create mode 100644 include/hw/misc/smmu-testdev.h
>   create mode 100644 tests/qtest/smmu-testdev-qtest.c
>


