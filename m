Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D0606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IoHWbIEP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTduy-0002P5-1W; Wed, 18 Nov 2026 06:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xTdup-0002OI-TM
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 06:33:31 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xTdun-00023E-Tm
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 06:33:27 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so1533224a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 03:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795001604; x=1795606404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+FOjB+5Nw7o9aupcwZsIvfXjeXJgh2wqV9Ep5Aay0cE=;
 b=IoHWbIEPteE9l+m3syQ5ovXgjpj/fFkcqlMrOHRsZWIFJu2t+hIGENgtQ2FRZcmvp6
 3201U5nsLlTrpu9YTJV+MVSElrZ4qwBFmFCzC1l3DslSjGM4VQHZwq1BftoIkpViTIzH
 OSzOBCXJfXp5a4IFac4gJbOJnRbuQCW3eIKreH5nS1sNAVgubDfz5n5offDmRI/UCWMA
 jp0360hxtT+R7pIvXCO1fnkAlDPDysL6niNb6hXIDKcyybNGrp46VxTLvJRjoJYwGR8M
 ixccr6jAXHjDpuUTwxKh9ZCHNGIcl2NqydhUjlVZ4jOq2LHatB9O9NAjJn+3K5eBLgsI
 8dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795001604; x=1795606404;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+FOjB+5Nw7o9aupcwZsIvfXjeXJgh2wqV9Ep5Aay0cE=;
 b=Pn6k1sISV3J1YHX9LFtIu/Bo8M6fN9MyAuTUG6nWsnvUPxdqjx1rvKI7xE5mvOylVG
 aCvBc0aORFZVUWsJ4YjCc8OOrvaGUcu4UeHcVBc2z1VLzsRDmADylx0aZNEUpnaVaF0s
 Q6u1gGJjJ+jKXvsfQWjj3lKM/hZIX1FJsG8nHPkkpTyafvgtYQIkr6sFCpwfRYq6PiC6
 vYajVUAVV4gwOB8GHjlWGGyqgAlD/CqWaQR3C+rw6TdqwMeT8wSsZMgVZO4ZcuDjngJY
 y+8P03KINn660c4X6WLlFgDt1yy4ByGi+8AfQmyI/DAV2JlCUqPSLcYUd/VUEJC0QJYf
 PKUw==
X-Forwarded-Encrypted: i=1;
 AL+hErFD2FIQzxkt5Ntbm8f+EfXRr7x8FNC9T/h6B7hATdudux6RvjiKSNO2RaUhe0vWH94+eNrMlNsS6afk@nongnu.org
X-Gm-Message-State: APuU4Z/WMpXPLtWJyAEujL3f7xHluKe4ruPrygXyMIek4dLFViJqxcmx
 cn+HWg1SJ4Ry59kl72s1lPJR6Hl0eMyhUdZedeb8wX/KKGPPzyY8u+HM
X-Gm-Gg: AYBFou0KvSR297klB0QwFDSTNZeglrtVrpE0LWErWybKLJqOQzbndv7wTr9TERLAEoS
 bWxEu+85U14Q9WR1eK0XlDXctmXHQlpj7n5fKcCUjoznG4GD223TyWcO+8mxDCQGhzJjbBeZO8K
 3fd0nISDAtb5DY/cXVjVjB7Pcs+Wz/VU3OtOb0N0IoUC5Pl1TkasHiwTn7GKO156TO2ABbJEtyU
 F+5DtLx3SirATBR+9bKmg91acPQGv54Q1PWDqg0Bt/elRzAnyZzLmz3l4z6vvdHkubz+KCS9JCV
 VS4lewBBTPUmOopk+33REk/h/gIaSulbwwOCm2OdI3DswC6upiGAgYNPrck5boN1m0yU+oEt6pQ
 z89wLnGsFRP88KIdbUGhVwfQGpjPeFY1i2VKnBJcWQvu8cI1VPk9b6e6iPANklrGhFvSic+zIKt
 y63wiUxKtJfPKvPofi0pktz4jbW38XJUg9WUq8kErcJoIEdgrSZeaC0U+iQCVDSfyF0OI1bO5Jo
 gV7Y+FB9qx9wUaIe+/KEadKR3GtPidZCjVO1wKJmEb7Tkwd9bJfXJEDUl8QXkIpXU9AV/gl/GhE
 sJcOwrf0g09VT1tnlyrh1A2aCdM7gn70QRo=
X-Received: by 2002:a05:6402:e9e:b0:6b8:5eba:f1e0 with SMTP id
 4fb4d7f45d1cf-6b887ead518mr1578235a12.21.1795001603659; 
 Wed, 18 Nov 2026 03:33:23 -0800 (PST)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b88a225b12sm902845a12.28.2026.11.18.03.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 03:33:22 -0800 (PST)
Date: Wed, 18 Nov 2026 11:33:15 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 00/23] target/ppc: Correct Freescale Book E CPU models
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Message-ID: <7D055497-E7EC-4AAE-BA5B-69F4164D78B3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 8=2E November 2026 11:59:59 UTC schrieb Bin Meng <bin=2Emeng@processmis=
sion=2Ecom>:
>This series corrects SPR access, cache and MMU configuration, and
>instruction availability in the Freescale Book E CPU models=2E It also
>fixes host PVR matching and adds system TCG tests for e500mc, e5500
>and e6500=2E
>
>The patches are grouped as follows:
>
>- patch #1-#3 and #5, bug fixes to PIR write access, the MAS5 SPR number
>  and cache block/line sizes (qemu-stable cc'ed)
>- patch #4 and #6, complete e500mc/e5500 L1 cache configuration and
>  remove redundant e6500 cache geometry bits
>- patch #7-#11, register the missing cache, MMU-assist and several
>  control SPRs
>- patch #12-#14, split the PowerISA 2=2E05 instructions into integer and
>  floating-point groups, due to differences seen on e500 series cores
>- patch #15-#17: Add TCG tests for illegal-instruction exceptions, byte
>  comparison and parity results, and FPSCR field-mask handling
>- patch #18-#21, complete the e500 family MMU configuration, correct
>  PID register counts and express MMUCFG/TLBnCFG with named fields
>- patch #22-#23, fix EPCR write width and host PVR revision matching
>  for Book E KVM
>
>Changes in v3:
>- Cover the new system test directories in MAINTAINERS
>- Add the missing SPDX license identifier to the README
>- target/ppc: Build e6500 MMUCFG values from field encodings
>- target/ppc: Complete MMU configuration for e500 family cores
>- target/ppc: Limit e500mc and e5500 to one PID register
>- target/ppc: Express e6500 TLB configuration with named fields
>- target/ppc: Keep embedded processor control within 32 bits
>- target/ppc: Match e500mc/e5500/e6500 host PVR revisions
>
>Changes in v2:
>- Group ISA 2=2E05 features into integer and floating-point flags
>- Use the first free bit for the floating-point group
>- Align flag definitions and comment endings
>- Enable the shared ISA 2=2E05 integer flag on e5500 and e6500
>- Align the FPSCR W/L behavior flag comment ending
>- Rebase the PPC64 test entry onto the Meson variable cleanup
>
>Bin Meng (23):
>  target/ppc: Correct PIR write access on e500 cores
>  target/ppc: Correct the MAS5 SPR number
>  target/ppc: Correct the e500mc and e5500 cache block size fields
>  target/ppc: Complete e500mc and e5500 L1 cache configuration
>  target/ppc: Correct cache line size for e6500
>  target/ppc: Drop redundant e6500 L1 cache geometry bits
>  target/ppc: Register L1CSR2 on e500mc/e5500/e6500 cores
>  target/ppc: Register L2CFG0 and L2CSR1 on e500mc and e5500
>  target/ppc: Register MAS5 and MAS8 on e500mc/e5500/e6500
>  target/ppc: Register PWRMGTCR0 on e6500
>  target/ppc: Register IVOR42 on e6500
>  target/ppc: Split the ISA 2=2E05 instruction feature group
>  target/ppc: Enable byte comparison and parity on e5500 and e6500
>  target/ppc: Ignore FPSCR W/L fields on e500mc, e5500 and e6500
>  tests/tcg/ppc: Add Book E illegal instruction tests
>  tests/tcg/ppc: Test byte comparison and parity on e5500/e6500
>  tests/tcg/ppc: Test FPSCR W/L handling on e500mc/e5500/e6500
>  target/ppc: Build e6500 MMUCFG values from field encodings
>  target/ppc: Complete MMU configuration for e500 family cores
>  target/ppc: Limit e500mc and e5500 to one PID register
>  target/ppc: Express e6500 TLB configuration with named fields
>  target/ppc: Keep embedded processor control within 32 bits
>  target/ppc: Match e500mc/e5500/e6500 host PVR revisions
>
> MAINTAINERS                                |  2 +-
> target/ppc/cpu=2Eh                           | 45 ++++++----
> target/ppc/cpu_init=2Eh                      |  3 +-
> target/ppc/cpu_init=2Ec                      | 99 +++++++++++++++++-----
> target/ppc/translate=2Ec                     | 10 ++-
> target/ppc/translate/fixedpoint-impl=2Ec=2Einc |  6 +-
> target/ppc/translate/fp-impl=2Ec=2Einc         | 14 ++-
> target/ppc/translate/fp-ops=2Ec=2Einc          |  9 +-
> meson_options=2Etxt                          |  4 +
> scripts/meson-buildoptions=2Esh              |  2 +
> tests/tcg/meson=2Ebuild                      |  1 +
> tests/tcg/ppc/meson=2Ebuild                  |  5 ++
> tests/tcg/ppc/system/README                | 24 ++++++
> tests/tcg/ppc/system/boot=2ES                | 92 ++++++++++++++++++++
> tests/tcg/ppc/system/byte-parity=2ES         | 33 ++++++++
> tests/tcg/ppc/system/fpscr=2ES               | 75 ++++++++++++++++
> tests/tcg/ppc/system/isa=2Eout               |  1 +
> tests/tcg/ppc/system/kernel=2Eld             | 18 ++++
> tests/tcg/ppc/system/macros=2Einc            | 56 ++++++++++++
> tests/tcg/ppc/system/meson=2Ebuild           | 39 +++++++++
> tests/tcg/ppc/system/unsupported=2ES         | 31 +++++++
> tests/tcg/ppc64/meson=2Ebuild                |  2 +
> tests/tcg/ppc64/system/meson=2Ebuild         | 33 ++++++++
> 23 files changed, 554 insertions(+), 50 deletions(-)
> create mode 100644 tests/tcg/ppc/meson=2Ebuild
> create mode 100644 tests/tcg/ppc/system/README
> create mode 100644 tests/tcg/ppc/system/boot=2ES
> create mode 100644 tests/tcg/ppc/system/byte-parity=2ES
> create mode 100644 tests/tcg/ppc/system/fpscr=2ES
> create mode 100644 tests/tcg/ppc/system/isa=2Eout
> create mode 100644 tests/tcg/ppc/system/kernel=2Eld
> create mode 100644 tests/tcg/ppc/system/macros=2Einc
> create mode 100644 tests/tcg/ppc/system/meson=2Ebuild
> create mode 100644 tests/tcg/ppc/system/unsupported=2ES
> create mode 100644 tests/tcg/ppc64/system/meson=2Ebuild
>
>---
>base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
>branch: ppc-fsl-booke
>

FWIW: Series:

Acked-by: Bernhard Beschow <shentey@gmail=2Ecom>

