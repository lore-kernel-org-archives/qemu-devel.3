Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60263106FD68
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 02:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0s7A-0000PK-6o; Thu, 12 Mar 2026 22:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0s79-0000Ok-7B
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 22:18:59 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w0s77-0007za-L6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 22:18:58 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2be1ab1fa7dso1465053eec.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773368335; x=1773973135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fn6jVa1MBzK2KXY3md3B2vjjf0P88Mb8DUoKgdguAD8=;
 b=lzHLliwv1vs1N+ZULXJU6HlAmWCKwioW97jwrFCwpqpcgcZsvyas2qFkPIN6YkydHX
 XeNAg4gLRN2XK5qc0P8VemYZx57CXAjIuXmYfzu7lynlmqpk9BJqH1EYm/wD/zQof9FJ
 1cFEWQaXZj5ZNTN+lC1Y7Haqga2BR6rx2kisUZrsol+ry3yjtVeKYAec+y63Zj0dW9jW
 FFFS5ktAi/EqX5vAIH4ASLNii4eWuy6w6v0Au9z45fVv6AvIdj01+QrQTvoCVgiv2/g8
 tLD3g+X1aA5vVxr+MsxnHQ6HE/mnvJdZzAb4A6rHuOtCgUsBcPkWiO98HvrslrVt/OPx
 C9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773368335; x=1773973135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fn6jVa1MBzK2KXY3md3B2vjjf0P88Mb8DUoKgdguAD8=;
 b=gCaCIuWfiSzvtj1K7jEtHGiihdItSzk+yF+DJepIlDNlOHwDr3BkdhzYonaDDiV0no
 sjCyPjswUZcjtT90g9E7V4+ilvG6eNjyPZLtpB0pWkso0mic2ViT2bG42RNoFaxXHsOD
 bifv3SmD5EqlVbmWIzmIhGF6yzNQ6rVjhgOhoEWKegMZawAh7GIPIiwmtRgj7jKucn1C
 l/Phm5YlIM8ckVsnsYZMw4dFubGysrR4zeJ6g4kBPcc3mPCHQw7TYZhsszdpFwAT1iZR
 ZCHJTbfFBG5/JHs/EsOXOzsY+hME9fyevc52CKx9eDPepXWV36U8yTFF4TVvE793skTx
 GAQw==
X-Gm-Message-State: AOJu0YxGPmvSNtdnEke3uUAz6gnxkYw0VqfpJILPN7jZb4Za8VeurcbC
 Y95cXs2NFsjuzjES/CdEu8IRFi7pu++3rgOrnFLvQACuePCRylFSVq6xy0kV4NwN
X-Gm-Gg: ATEYQzztZqsLP2Cz52GAo9SKw8J9SDH/fpy0BqmxcssXp5qV/gcBf9Ix0RY2/GuSjuh
 W/jaogstN+HvnaPkgh61+8k7ajpefLV3fUT1WzzO1olVnLgOGHIw/BWfDrmWE6hgeq7nY9ntdy4
 JCxTLvXR1PiCjTgTGFdZ0kjQdXOwy6fRbvsHJkk2OdQgJ8H3TocjTI1qR3BzmrqvV9HEBPfZd6n
 YUlNe2BNv4auwkXEtog1tacjof+rYVJqTIVZnz5WAts4/uS03VYRLGF/4ChdugPYZeog1/0nsC9
 YkYkr99FSMYs3aSZtStfF+trwNZu9YDv2WvoBXe7/aLt1dSKyOv4oafv50bY7JTuC+M6VMkIyeJ
 DuUvFlbexDXEjazKP3xIhKfrHKrkAmflRv3csfTOrek9v3sFsV3h22LbOVkaFZJCSglMSghAnw9
 foCGLEY2kBcgmsYpKcF4j7bAZf0GRNrXNc6O1+cYVE+i6/ECrjXrU=
X-Received: by 2002:a05:7301:10c4:b0:2b8:c1b4:9cb7 with SMTP id
 5a478bee46e88-2bea5523f59mr911958eec.22.1773368335242; 
 Thu, 12 Mar 2026 19:18:55 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:588a:39d7:d008:37c2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3eec52sm796218eec.14.2026.03.12.19.18.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 19:18:54 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v2 0/3] target/arm: ISV=0 data abort emulation library
Date: Thu, 12 Mar 2026 23:18:47 -0300
Message-ID: <20260313021850.42379-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309214852.92545-1-lucaaamaral@gmail.com>
References: <20260309214852.92545-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When a guest triggers a data abort with ISV=0 (e.g. STP, LDP, SIMD/FP
load/store, writeback addressing, atomics, exclusives), the ESR syndrome
does not carry the access size or target register, so the hypervisor
cannot emulate MMIO without decoding the faulting instruction.

v1 handled this inside HVF with a hand-written decoder.  Based on review
feedback from Mohamed Mediouni and Peter Maydell, v2 restructures the
implementation as:

  - A shared emulation library in target/arm/emulate/ with a decodetree
    decoder (a64-ldst.decode), usable by any hypervisor backend.

  - A callback-based interface (struct arm_emul_ops) that abstracts
    register and memory access, keeping the library hypervisor-agnostic.

  - HVF and WHPX backends wired as the first two consumers.

Instruction classes handled (DDI 0487):
  - Load/store pair: STP, LDP, STNP, LDNP, STGP, LDPSW (C3.3.14-16)
  - SIMD/FP load/store pair and single (C3.3.10, C3.3.14-16)
  - All immediate addressing: unscaled, post/pre-index, unsigned offset
  - Register offset addressing with extend (C3.3.9)
  - Exclusives: STXR, LDXR, STXP, LDXP (C3.3.6)
  - Atomics: LDADD, LDCLR, LDEOR, LDSET, LDSMAX/MIN, LDUMAX/MIN, SWP
  - Compare-and-swap: CAS, CASP (C3.3.1)
  - LDRAA/LDRAB with FEAT_PAuth (C6.2.121)
  - PRFM, DC maintenance (as NOPs)

Intentionally omitted (not observed in ISV=0 MMIO traps during testing):
  - AdvSIMD structure loads/stores (LD1/ST1 etc.)
  - MTE load/stores (FEAT_MTE)
  - 128-bit atomics (FEAT_LSE128)
  - MOPS (FEAT_MOPS)

KVM NISV handling is a natural follow-up -- it requires similar
arm_emul_ops callbacks using KVM vcpu ioctls.

v1 -> v2:
  - Moved from HVF-specific inline decoder to shared library
    in target/arm/emulate/ (Mohamed Mediouni)
  - Added decodetree decoder for structured instruction parsing
    (Peter Maydell)
  - Made hypervisor-agnostic; wired HVF and WHPX (Peter Maydell)
  - Added CASP register-pair validation (odd/r31 -> UNHANDLED)
  - Added unit tests (19 test cases)
  - Split into 3 patches for reviewability

Lucas Amaral (3):
  target/arm: add AArch64 ISV=0 instruction emulation library
  tests: add unit tests for ISV=0 emulation library
  target/arm: wire ISV=0 emulation into HVF and WHPX

 target/arm/emulate/a64-ldst.decode | 293 ++++++++++++
 target/arm/emulate/arm_emulate.c   | 738 +++++++++++++++++++++++++++++
 target/arm/emulate/arm_emulate.h   |  55 +++
 target/arm/emulate/meson.build     |  16 +
 target/arm/hvf/hvf.c               |  94 +++-
 target/arm/meson.build             |   1 +
 target/arm/whpx/whpx-all.c         |  86 +++-
 tests/unit/meson.build             |   1 +
 tests/unit/test-arm-emulate.c      | 540 +++++++++++++++++++++
 9 files changed, 1820 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/emulate/a64-ldst.decode
 create mode 100644 target/arm/emulate/arm_emulate.c
 create mode 100644 target/arm/emulate/arm_emulate.h
 create mode 100644 target/arm/emulate/meson.build
 create mode 100644 tests/unit/test-arm-emulate.c

-- 
2.52.0


