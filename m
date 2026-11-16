Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9FE606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORVTtgY7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwE6-00073t-G4; Mon, 16 Nov 2026 07:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xSwE1-00073U-8w
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 07:54:22 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xSwDz-00061w-7C
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 07:54:20 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c50933bdf4bso637457166b.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 04:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794833655; x=1795438455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8p01ZYaAeroUErZXTwYE9BUt20eELDh6b6vImR35pZo=;
 b=ORVTtgY7zlPZTGDdNk9UeI3izbNkeIos+zi9zc8FaqynRSOEg3xdPcAB4Ho5/nCXRr
 UIPsPsgh9+ARkR96Y3EgV+RdfLY1lB85KBjYRILm47LHvNi3D+VisNb1jmMINOV8o2xJ
 AsxTnQjLbMGYg3kly9vmEK9TQqH+AtN5qWAf5Y6wh2cVTNfLWqV2bssondpYpDL/s/hz
 uFm3NoU95V3CX5aJZfdTpA3Snq2kpseYGiPJxRXhMZIpO1P4YxmKEWphtyFJFvw4jtL6
 Hjp8J+ZIiybPgzrVcRUsLqs4l/D+or+5Qn47AyiBTQNXl3DkhyQolZrvgegA53wrGe0G
 XtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794833655; x=1795438455;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8p01ZYaAeroUErZXTwYE9BUt20eELDh6b6vImR35pZo=;
 b=IoJlnSU1jvdniYGIexZOks7dvvUWWONZk0F5vXJmi9ixXFgU7c95pPntzmg2I2YEZa
 y4HlR+Upw1RVHDkn41OTHiSR2QQvlm9F8xAO6LDFHGoSWLP4c/YyeWHu8US7hfHmIA8O
 1M8wY1mTjRM3nqbTXd0j0MfIpfozCdKHtzQSDfmTdj9cX/4vmJEp/9DO/GtVFN4oljYt
 ynj6z9oYQoHeXuj/fbyB0zmsdKhiv5aq3EfRkqsTJ9F7MfECX49uwTDY3q5VBSaupUpU
 W1H54izcOVN44lP4EbcXqHDr43OyQ/Olyj8B2m+7n53arNPiyDm0nelSQVqtP5JGEWG2
 kuLw==
X-Gm-Message-State: APuU4Z+pBPw1PW2yV096RzyUACuPXToPZK73C8NUgVIMWl1zVNoK2bQd
 0Eh1TU1qZlxTkx/9hEDVc0xyFhXvuoe26iysHGQbOnlgCZPz1SuFBs35
X-Gm-Gg: AYBFou0zSH3yTUe/obBumgi3NESpp+WMZxGGlUYdQwT7WRaDpFoOIuffWzb48duDE3I
 CasQCL0R87Q0uJJjYLX0+fyZ7dF4USyYnNV9+rJmb/3p1PpctpsDCzSDDS2CJNKOHZ1xU3aQqNU
 U80bxIsvLt4bxGhVPTYTeWcokXbDumKb4D8sjxvL2wGA4CxEROvGzfA37cPp5r5X4ZpC5rhm9b+
 mnzNvQAImN1D6XfaFwUJnBAfexOixaN3ZUUYc7quZJv6Gs785DOrk6QPZ0ILutmdhKoeBKgkfOt
 HrrauD6SHDaqoslbMJgMGAl8FDjHiZt1kCsPv7UpUY95ZIFkVVTGWu3E7BGxWLp65NEuKbgBSJF
 37846r0XxOXJ1w+d1aBs9hh/2//stgQuPtDYKWFY/sxPAyTEuTh2yFvxLZVcmlEDyGPWPefBTvK
 WCTkaj54w7YKohUzt493TJGZdr31HunPl473lNtbqe9iMOiaZEHouzakzPbGiFZKRH5DDlaVNbo
 9NXe3KLKmfeOspPiACfC1optP1Q2har+6GOnQzcdimVdcoW5wBY32lZf9x1iJK4QAJRMn3vMgCT
 kstVLztq80z1LFd7GVgoIpp63K5VUaG3GiiEcrRt2+0tHIXnJYHl1SsrDSMKzmjJIQp7x7gDxUO
 9uX3pCkJ4i1wU6RVcDi/Y
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id
 a640c23a62f3a-c50963856f2mr867899666b.15.1794833654351; 
 Mon, 16 Nov 2026 04:54:14 -0800 (PST)
Received: from ehlo.thunderbird.net
 (business-090-187-110-129.90.187.pools.vodafone-ip.de. [90.187.110.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5a281sm413466266b.51.2026.11.16.04.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 04:54:13 -0800 (PST)
Date: Mon, 16 Nov 2026 12:03:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bin.meng@processmission.com>
CC: QEMU <qemu-devel@nongnu.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 00/23] target/ppc: Correct Freescale Book E CPU models
In-Reply-To: <CAEUhbmWFfi+ycKbN5SiKbtUyrygTXY0O3KnXG4yGngZ=iyGr_g@mail.gmail.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
 <CAEUhbmWFfi+ycKbN5SiKbtUyrygTXY0O3KnXG4yGngZ=iyGr_g@mail.gmail.com>
Message-ID: <5F527386-CC3A-46D7-B3C7-7F4261E39136@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 16=2E November 2026 01:34:29 UTC schrieb Bin Meng <bmeng=2Ecn@gmail=2Ec=
om>:
>On Sun, Nov 8, 2026 at 8:04=E2=80=AFPM Bin Meng <bin=2Emeng@processmissio=
n=2Ecom> wrote:
>>
>> This series corrects SPR access, cache and MMU configuration, and
>> instruction availability in the Freescale Book E CPU models=2E It also
>> fixes host PVR matching and adds system TCG tests for e500mc, e5500
>> and e6500=2E
>>
>> The patches are grouped as follows:
>>
>> - patch #1-#3 and #5, bug fixes to PIR write access, the MAS5 SPR numbe=
r
>>   and cache block/line sizes (qemu-stable cc'ed)
>> - patch #4 and #6, complete e500mc/e5500 L1 cache configuration and
>>   remove redundant e6500 cache geometry bits
>> - patch #7-#11, register the missing cache, MMU-assist and several
>>   control SPRs
>> - patch #12-#14, split the PowerISA 2=2E05 instructions into integer an=
d
>>   floating-point groups, due to differences seen on e500 series cores
>> - patch #15-#17: Add TCG tests for illegal-instruction exceptions, byte
>>   comparison and parity results, and FPSCR field-mask handling
>> - patch #18-#21, complete the e500 family MMU configuration, correct
>>   PID register counts and express MMUCFG/TLBnCFG with named fields
>> - patch #22-#23, fix EPCR write width and host PVR revision matching
>>   for Book E KVM
>>
>> Changes in v3:
>> - Cover the new system test directories in MAINTAINERS
>> - Add the missing SPDX license identifier to the README
>> - target/ppc: Build e6500 MMUCFG values from field encodings
>> - target/ppc: Complete MMU configuration for e500 family cores
>> - target/ppc: Limit e500mc and e5500 to one PID register
>> - target/ppc: Express e6500 TLB configuration with named fields
>> - target/ppc: Keep embedded processor control within 32 bits
>> - target/ppc: Match e500mc/e5500/e6500 host PVR revisions
>>
>> Changes in v2:
>> - Group ISA 2=2E05 features into integer and floating-point flags
>> - Use the first free bit for the floating-point group
>> - Align flag definitions and comment endings
>> - Enable the shared ISA 2=2E05 integer flag on e5500 and e6500
>> - Align the FPSCR W/L behavior flag comment ending
>> - Rebase the PPC64 test entry onto the Meson variable cleanup
>>
>> Bin Meng (23):
>>   target/ppc: Correct PIR write access on e500 cores
>>   target/ppc: Correct the MAS5 SPR number
>>   target/ppc: Correct the e500mc and e5500 cache block size fields
>>   target/ppc: Complete e500mc and e5500 L1 cache configuration
>>   target/ppc: Correct cache line size for e6500
>>   target/ppc: Drop redundant e6500 L1 cache geometry bits
>>   target/ppc: Register L1CSR2 on e500mc/e5500/e6500 cores
>>   target/ppc: Register L2CFG0 and L2CSR1 on e500mc and e5500
>>   target/ppc: Register MAS5 and MAS8 on e500mc/e5500/e6500
>>   target/ppc: Register PWRMGTCR0 on e6500
>>   target/ppc: Register IVOR42 on e6500
>>   target/ppc: Split the ISA 2=2E05 instruction feature group
>>   target/ppc: Enable byte comparison and parity on e5500 and e6500
>>   target/ppc: Ignore FPSCR W/L fields on e500mc, e5500 and e6500
>>   tests/tcg/ppc: Add Book E illegal instruction tests
>>   tests/tcg/ppc: Test byte comparison and parity on e5500/e6500
>>   tests/tcg/ppc: Test FPSCR W/L handling on e500mc/e5500/e6500
>>   target/ppc: Build e6500 MMUCFG values from field encodings
>>   target/ppc: Complete MMU configuration for e500 family cores
>>   target/ppc: Limit e500mc and e5500 to one PID register
>>   target/ppc: Express e6500 TLB configuration with named fields
>>   target/ppc: Keep embedded processor control within 32 bits
>>   target/ppc: Match e500mc/e5500/e6500 host PVR revisions
>>
>>  MAINTAINERS                                |  2 +-
>>  target/ppc/cpu=2Eh                           | 45 ++++++----
>>  target/ppc/cpu_init=2Eh                      |  3 +-
>>  target/ppc/cpu_init=2Ec                      | 99 +++++++++++++++++---=
--
>>  target/ppc/translate=2Ec                     | 10 ++-
>>  target/ppc/translate/fixedpoint-impl=2Ec=2Einc |  6 +-
>>  target/ppc/translate/fp-impl=2Ec=2Einc         | 14 ++-
>>  target/ppc/translate/fp-ops=2Ec=2Einc          |  9 +-
>>  meson_options=2Etxt                          |  4 +
>>  scripts/meson-buildoptions=2Esh              |  2 +
>>  tests/tcg/meson=2Ebuild                      |  1 +
>>  tests/tcg/ppc/meson=2Ebuild                  |  5 ++
>>  tests/tcg/ppc/system/README                | 24 ++++++
>>  tests/tcg/ppc/system/boot=2ES                | 92 ++++++++++++++++++++
>>  tests/tcg/ppc/system/byte-parity=2ES         | 33 ++++++++
>>  tests/tcg/ppc/system/fpscr=2ES               | 75 ++++++++++++++++
>>  tests/tcg/ppc/system/isa=2Eout               |  1 +
>>  tests/tcg/ppc/system/kernel=2Eld             | 18 ++++
>>  tests/tcg/ppc/system/macros=2Einc            | 56 ++++++++++++
>>  tests/tcg/ppc/system/meson=2Ebuild           | 39 +++++++++
>>  tests/tcg/ppc/system/unsupported=2ES         | 31 +++++++
>>  tests/tcg/ppc64/meson=2Ebuild                |  2 +
>>  tests/tcg/ppc64/system/meson=2Ebuild         | 33 ++++++++
>>  23 files changed, 554 insertions(+), 50 deletions(-)
>>  create mode 100644 tests/tcg/ppc/meson=2Ebuild
>>  create mode 100644 tests/tcg/ppc/system/README
>>  create mode 100644 tests/tcg/ppc/system/boot=2ES
>>  create mode 100644 tests/tcg/ppc/system/byte-parity=2ES
>>  create mode 100644 tests/tcg/ppc/system/fpscr=2ES
>>  create mode 100644 tests/tcg/ppc/system/isa=2Eout
>>  create mode 100644 tests/tcg/ppc/system/kernel=2Eld
>>  create mode 100644 tests/tcg/ppc/system/macros=2Einc
>>  create mode 100644 tests/tcg/ppc/system/meson=2Ebuild
>>  create mode 100644 tests/tcg/ppc/system/unsupported=2ES
>>  create mode 100644 tests/tcg/ppc64/system/meson=2Ebuild
>>
>> ---
>
>Ping for review?

Hi Bin,

thanks for taking care of the e500 CPU models! Back in the days when I bec=
ame maintainer of the e500 machines, I deliberately didn't volunteer for th=
e CPUs since I don't have the bandwidth to do it=2E So go ahead, I'm fine w=
ith the changes=2E

Best regards,
Bernhard

