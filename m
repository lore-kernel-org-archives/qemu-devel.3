Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A433FCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsD9-0008O5-Mp; Thu, 23 Oct 2025 06:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBsD8-0008NY-G1
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:06:22 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBsD6-0003cK-5I
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:06:22 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b5a8184144dso106973566b.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761213977; x=1761818777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVomLDbVmARYunsc9Z3lmN1gnQQOyQfCvPbQDLofxi0=;
 b=FwjPghqo54HkVe3mrNY8ehEmLuTQZ0xWUkPIypoyjfC3Z/dupna+JPGlTRotmCMOsF
 c7QbASsNOlZhrbuZTEdvU/Bw0lVy5dxTWR0/6ue4Wt77m1L5fsm3dC+AQXsHo8k5SkzS
 I6aTAoDHPrR39ucReG7iPh9miR/DiKENzso32OMPRlZRqv0HlTF5m76HnCIHTtBze58m
 nl8k20gnKuh3KQ77QD24EWg+B7jQ6H1O15m8EeJxtp2M44F8dS8Pitf73EMrSY87/EQJ
 GFY2nUQq/yilAf0kA96wizqnGY093XNOXQiM+i9TOIV+VpSCu1MISxPCUoh/Rpm/IieP
 Jvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761213977; x=1761818777;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NVomLDbVmARYunsc9Z3lmN1gnQQOyQfCvPbQDLofxi0=;
 b=wtujAuPnFSUyceliCq44MR1xHsz79rOsz2cxwTIz1oAECPRNiQioVvX51wKDEOI+uX
 iqGJsyJShTlPXouHmIwN0/GFNUa/ivyWA9H0ZWdGNjh7gZa9df4bB3YNlCLfdFZUxEyE
 LB+ByP91sa/mrtwPX2N+TT3t1TticSBiHYETYcpdJNDD4UWh+khl1Kb38LmzEVqnD01s
 T3OcIsZm1dupq5hsQ9vruBwwul+Btz7urFhCPdUIdN1YramIDt4EEyHFbUm5fhUd4jKs
 hPQsDbuBX+gsZa0MipHYz5KIA+IJ2hFzn2zeZtSRaonjUvzPEoeIIKAXmuTRj4VgMSW8
 fu5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqUb+/IY5RNZMH+LWIbrzT/UQe+kpKUYd4ePZxBXTekTuwylg1Bsc5fciRjip6cL01IlWlKSEd8Egg@nongnu.org
X-Gm-Message-State: AOJu0YzHsQOS/yEiYw+BV7qUPrs19JODjxElNtBAfJLyBXrbXe/slT9I
 vEff9KdHELuHz2Yn//PoKb37QWVeO1YeU7TslfsplhGuyhvpNrkbMrebEOximL2o4SE=
X-Gm-Gg: ASbGnct06b33x79aEGDyuGi1GGtHxfQMaVnQuf/qvXFmKjagW7u11+nZEWcHPdCYvAE
 GLkdAq28d5I+pMs18pTkEjIe6aNmHshC/Gy+O+u17YMsJDPleZYm0aLdJ4yHWXnte+MVZeoSB53
 bohTK1MC9hEO9GUoeffRIfnHQgowqYZBvOulYLg9aqXKLUNYTQ1EJhSF+ngZXd7fuh7Gmv17QZv
 p8OQMHjPAahziyTQBLyvHQb0yJ7bBKQiJYgJ+7ECz+EN7kNLmDvAUqgtFby/6m/10YfBdR3LOlv
 SBRf2t7OcnJm0rkkUf3+XzSlIbjF4JxBybkd82CWcTEY0dR5W23S7AedRjFTMdFQINPX2vXrqqo
 hcEfUQn1VxaYWOc1VK+qqEXrYAnYAXnMWL09zF5NKqqevjvTM6zXx0rIvnnlEDsiysFc+EJ+b9d
 J2
X-Google-Smtp-Source: AGHT+IGyEkN//H10RUH7q8DN8m8vdD3nU2spnXFCL4TZDwJYOJNEVOmFokAJJhkUd14qPHtryexPQQ==
X-Received: by 2002:a17:906:c155:b0:b42:9840:eac1 with SMTP id
 a640c23a62f3a-b64764e33cbmr2623795066b.49.1761213977013; 
 Thu, 23 Oct 2025 03:06:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d513197d5sm168883366b.34.2025.10.23.03.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 03:06:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55D6F5F8DF;
 Thu, 23 Oct 2025 11:06:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: tangtao1634 <tangtao1634@phytium.com.cn>
Cc: pbonzini@redhat.com,  farosas@suse.de,  lvivier@redhat.com,  Eric Auger
 <eric.auger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Chen Baozi
 <chenbaozi@phytium.com.cn>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC v2 0/2] hw/misc: Introduce a new SMMUv3 test framework
In-Reply-To: <20250930165340.42788-1-tangtao1634@phytium.com.cn> (tangtao's
 message of "Wed, 1 Oct 2025 00:53:38 +0800")
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 23 Oct 2025 11:06:15 +0100
Message-ID: <87v7k6lyp4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

tangtao1634 <tangtao1634@phytium.com.cn> writes:

> From: Tao Tang <tangtao1634@phytium.com.cn>
>
> This patch series (V2) introduces several cleanups and improvements to th=
e smmu-testdev device. The main goals are to refactor shared code, enhance =
robustness, and significantly clarify the complex page table construction u=
sed for testing.
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
>     features (like fault handling, specific translation regimes, etc.)
>     becomes cumbersome.
>
> * Difficult to Debug: It's hard to distinguish whether a bug originates
>     from the SMMU emulation itself, the guest driver, the firmware
>     tables, or the guest kernel's configuration.
>
> * Slow Iteration: The need to boot a full guest OS slows down the
>     development and testing cycle.
>
> The primary goal of this work is to create a lightweight, self-contained
> testing environment that allows us to exercise the SMMU's core logic
> directly at the qtest level, removing the need for any guest-side
> software.

I agree, an excellent motivation.

>
> Our Approach: A Dedicated Test Device
> -------------------------------------
>
> To achieve this, we introduce two main components:
>
> * A new, minimal hardware device: smmu-testdev.
> * A corresponding qtest that drives this device to generate SMMU-bound
>     traffic.
>
> A key question is, "Why introduce a new smmu-testdev instead of using an
> existing PCIe or platform device?"

I curious what the split between PCIe and platform devices that need an
SMMU are. I suspect there is a strong split between the virtualisation
case and the emulation case.

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
> to provide a direct, programmable path for a DMA request to reach the SMM=
U.
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
>     known state.
>
> 2.  Translation Structure Setup: It manually constructs the necessary
>     translation structures in memory, including Stream Table Entries
>     (STEs), Context Descriptors (CDs), and Page Tables (PTEs).
>
> 3.  DMA Trigger: It programs the smmu-testdev to initiate a DMA operation
>     targeting a specific IOVA.
>
> 4.  Verification: It waits for the transaction to complete and verifies
>     that the memory was accessed correctly after address translation by
>     the SMMU.
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

What about other IOMMU's? Are there any other bus mediating devices
modelled in QEMU that could also benefit from the ability to trigger DMA
transactions?

>
>
> Changes from v1 RFC:
> - Clarify Page Table Construction:
> Detailed comments have been added to the page table construction logic. T=
his is a key improvement, as the test setup extensively re-uses the same se=
t of page tables for multiple translation stages and purposes (e.g., nested=
 S1/S2 walks, CD fetch). The new comments explain this sharing mechanism, w=
hich can otherwise be confusing to follow.
>
> - Refactor Shared Helpers:
> The helper functions std_space_offset and std_space_to_str are now moved =
to a common header file. This allows them to be used by both the main devic=
e implementation (hw/misc/smmu-testdev.c) and its qtest (tests/qtest/smmu-t=
estdev-qtest.c), improving code re-use and maintainability.
>
> - Enhance Robustness:
> Assertions have been added to ensure the device operates only in the expe=
cted Non-secure context. Additional conditional checks are also included to=
 prevent potential runtime errors and make the test device more stable.
>
> - Code Simplification and Cleanup:
> Several functions that were redundant with existing macros for constructi=
ng Context Descriptors (CD) and Stream Table Entries (STE) have been remove=
d. This simplifies the test data setup and reduces code duplication.
>
> Other unused code fragments have also been removed to improve overall cod=
e clarity and hygiene.
>
> Tao Tang (2):
>   hw/misc/smmu-testdev: introduce minimal SMMUv3 test device
>   tests/qtest: add SMMUv3 smoke test using smmu-testdev DMA source
>
>  docs/specs/index.rst             |   1 +
>  docs/specs/smmu-testdev.rst      |  45 ++
>  hw/misc/Kconfig                  |   5 +
>  hw/misc/meson.build              |   1 +
>  hw/misc/smmu-testdev.c           | 943 +++++++++++++++++++++++++++++++
>  include/hw/misc/smmu-testdev.h   | 402 +++++++++++++
>  tests/qtest/meson.build          |   1 +
>  tests/qtest/smmu-testdev-qtest.c | 238 ++++++++
>  8 files changed, 1636 insertions(+)
>  create mode 100644 docs/specs/smmu-testdev.rst
>  create mode 100644 hw/misc/smmu-testdev.c
>  create mode 100644 include/hw/misc/smmu-testdev.h
>  create mode 100644 tests/qtest/smmu-testdev-qtest.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

