Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A320D41D69
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjgZ-00032l-Q0; Thu, 11 Dec 2025 11:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgY-00031L-8T
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:34 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgW-0003sj-MF
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:34 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29e1b8be48fso2708985ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471111; x=1766075911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lk8mKIx3WYKHU6gWwMQA7MPD/XOYh9HzD6vfmzyrQ9I=;
 b=HUnyIa4Kw23j+ei5WSJ95znxX+6qHRmwolXqdFUM9tcDq4/+njWu1D5olGNi5yNo01
 NGWha+ngyvDNTnZs5Nho3ypnLshJM61pab6iwiFDLy0TP60/X1R1RyUV/Nz0PQl38qCe
 +IW+rLTFwHTJNF5kDThMd1afkTkLyvzmvwOQVpUi3bVDb9gPXo++7BYcIP9u1W7WAFjJ
 syeaAQD/ux21PZCSMOUEGxPWG3eCIWyLE3TjjAM1+xCEdVgcwgOhnayqlZY6axoVwoWL
 nGiEPbah9a2JBzN5EuWHG7iCPjyWKcpH87b6nkyEM2KWZeAtrNM73665oLyj+yZijjvI
 7jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471111; x=1766075911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lk8mKIx3WYKHU6gWwMQA7MPD/XOYh9HzD6vfmzyrQ9I=;
 b=PnHz/uRXi2f32UP+B05RwFrs2bAvttsrFxL8pl2nf53XhSxIYHZ3NGcLQB58imXjZE
 WKo255owuPuUgCSLme9FBE7htsXFpPHOJOndspM6M60AWptntaU/DGf7y1/K46sdt7nm
 ssVx/HpqAzLjFHzdqHGMyGUtwtrSnt1QAaHzU699764BUWQj00ZUTMEPcRiyH5ELU4Xg
 dtKQaEjNf/gFgTb4dqrEv/bOQ+f4JC+TMlWVrAzjDsQLrQxROsIFKaObrY1ZR5/+TYZr
 jvslBAv4bTMYcPqxT7gSyqRz5rCjm2fIVjeXKWA4VBgORNCdVZAw3LHP0bVx0meUJA3P
 EzmQ==
X-Gm-Message-State: AOJu0Yweyw7limAEtfsRdS0+xuMreQRmuvkMsyUSQff1Q7f9+mvRQiac
 R0GobGa9mnKDJ4bnJATuqJtJnZ+TOnEu60myDkG7CmKHl4qQNbH94GdNfAh1yVKhc2mqs8Bmqkw
 MkwAsYuSwE8+6rMSK7+ke8b9rr6M8HL9zPwPyfejsV2ruhGQJ93KE55ntZpwFkUPmqsK+WIMrBW
 9S/8v+mN/ytU5BJs3E2hKk2Slk0AseJsJI70f0v6yF2Ms=
X-Gm-Gg: AY/fxX7AP6y/EeJbN4Aq1SUWgt79yFy9e4vU1B/Tvi+rz9nm80plebJF/0Viaya5X07
 6zChsPjZKMATnY82VjAgeOUUu5ocKzFyVPsqcxA+CVJEECDDyHCLbV1fg+GeE7/021vjgb+91CI
 94sNS6wTyDZS0cinIqeYvdX4H9Ho1eQQ3pjodz/YGQj5WI04I75bku34d7H7wfK7UxcxE8FNPCS
 Uvnf/94wokTLG4y14DuPjFsr8akxFHUdk8rUA2ggTijcBDXwqfcTasWLfm2HR/V8gunScMnC/vj
 qXo8N8OXgIKETjHIzF+39y/gq/8YwlxNsyAPxpEl/8Zl5E+J/AGm3K9FhXO0wn5rD8y7WBcCiWO
 h2zzGktHuNVRY+kdmQNxQHvvM40vTm41zOvvejEXx8E4E4tDK/HlM4rJchPw1YmZQlXh/g49byW
 gndBWsRzYaJGdTOV5VIGHYKk06tOQEiilCuMoJNQ==
X-Google-Smtp-Source: AGHT+IFc2Zag/H6Vom6UW+GXvvrqAiCIXXymSMSYpUGmerx4T0q/aumF4WGP5tGdpCAxInYPWkOrlw==
X-Received: by 2002:a17:903:b86:b0:298:481c:cbd4 with SMTP id
 d9443c01a7336-29ec22f0ac3mr73136785ad.26.1765471110653; 
 Thu, 11 Dec 2025 08:38:30 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016c63sm28962965ad.48.2025.12.11.08.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:38:30 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 0/6] Fix Zjpm implementation
Date: Fri, 12 Dec 2025 00:38:19 +0800
Message-ID: <20251211163826.3998266-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62e.google.com
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

From: Frank Chang <frank.chang@sifive.com>

The current Zjpm implementation has the following issues:

1. The address is shifted before obtaining the correct PMLEN value.
2. riscv_pm_get_pmm() does not handle effective privilege mode correctly.
3. mstatus.MPRV does not affect virtual-machine load/store instructions.
4. Sign extension for virtual-machine load/store instructions (HLV.* and
   HSV.*) must be performed when vsatp.MODE != Bare.

This patchset fixes the above issues and also renames
riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm(), as the helper
is only used when checking the PMM configuration for virtual-machine
load/store instructions, rather than for VS/VU modes.

Changelog:

v3:
  * Move riscv_cpu_eff_priv() to the header file and declare it as a
    static inline function.
  * Fix the MXR check bugs pointed out by Radim Krčmář.

v2:
  * Check effective privilege mode in riscv_pm_get_pmm().
  * Fix pointer masking for virtual-machine load/store instructions
    (HLV.* and HSV.*).
  * Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm().

Frank Chang (5):
  target/riscv: Add a helper to return the current effective priv mode
  target/riscv: Fix pointer masking PMM field selection logic
  target/riscv: Fix pointer masking for virtual-machine load/store insns
  target/riscv: Rename riscv_pm_get_virt_pmm() to
    riscv_pm_get_vm_ldst_pmm()
  target/riscv: Fix pointer masking translation mode check bug

Yong-Xuan Wang (1):
  target/riscv: fix address masking

 target/riscv/cpu.h         |  41 +++++++++++++-
 target/riscv/cpu_helper.c  | 110 +++++++++++++++++++++++++++----------
 target/riscv/internals.h   |   8 +--
 target/riscv/tcg/tcg-cpu.c |   4 +-
 4 files changed, 124 insertions(+), 39 deletions(-)

--
2.43.0


