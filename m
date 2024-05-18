Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238E0C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQL-0006K8-Ll; Sat, 18 May 2024 05:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQI-0006Ih-PZ; Sat, 18 May 2024 05:32:14 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQF-0005hY-Vt; Sat, 18 May 2024 05:32:14 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2b33d011e5dso646344a91.0; 
 Sat, 18 May 2024 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024729; x=1716629529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e5PNlLcRW1kioXsco+dzroCGUPKY3H2iAQmKqceRk9Y=;
 b=LrjpRNtBcW0tLpJj6QIOMZUGQ1D+57haW3TYrzlx7NahKOOaPi7dK1V3a40WGjfFLu
 EIKGRfJBvWw7kEO/LmQtVDNuuznpecl2vhEutjlf+zw9bCgr8LK+zFH+NFu/K6b1L2g6
 dx51hSWiYNknhceYnXmkhb3UUJa60HGMpuAUjjX6m2b/S/bH5QceQGbUUTbdl1aW6TxY
 HCaLZ546NoLqEXFlbr6KdSaw77Rv3XLuckNe9Z1ditsq9p+W+OtlarZia2Md+lqDaJFf
 IfqWUou4OpN1fS3tFHvCdMl6xWBnIyhZX+O/B62lGVR3PsxA9zT+EJ9RSLK47rLRVJBc
 bw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024729; x=1716629529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e5PNlLcRW1kioXsco+dzroCGUPKY3H2iAQmKqceRk9Y=;
 b=oL2XG1MPKHpz6nTskiIrlSDyIK21LnlIXQXghxlrEX3/slUqx/xGBDk3obF67D1ckl
 00edQXr0NqlYWZ6l1z9HPOhHdLGNankN9an9PxNZ1q2Val7gCKVAt/8Y0MJV6WCycvfM
 SVM7ziMa9ecISf5EJUubrpYetTZgmi794Mloq0LzcuCvMs9j+J7HdyBOAM0mrfIM8Ctw
 3UbLrkuR0r2dZ8DOmZHHeT5YiIgyewCkgNRdw8P600V8Ql6XekOPYHsu03R5IAUZRcXZ
 EBbOmlhzAzvKaUg4tgwPIuCQfoiiUBDtcCE6pFlKyQ+wipfDuixWYJVrcrJcTXxifZV6
 wQ9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXavRNdRlIiX60Ab8SHslwfgN2RsMUvoI/UDwnOuhdvNalLtI2gWpIcUHgF1VHlWejRKMflpO+tvQ86mpmPbXfplMGVsXo=
X-Gm-Message-State: AOJu0Yw8VhVvrZzFLm1n2XC65RMtkhUav7B20mpVyoGm0K49ilAe2DAC
 8gs78eZmAieXnO5qIzDVI7/5WLo+jGAtff09OKDsj7PzCk5FP9AHiOEwOw==
X-Google-Smtp-Source: AGHT+IHcx8fLtP3oOrlL9ZLhkzzdP+ev0O5rvzCBhVI2vWCrT9cVGcL7gw3tTcqS0/vrVsFyoXbfIw==
X-Received: by 2002:a17:90a:68c9:b0:2b3:6898:d025 with SMTP id
 98e67ed59e1d1-2bd6038cdabmr1922356a91.9.1716024728872; 
 Sat, 18 May 2024 02:32:08 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 00/14] target/ppc: Various TCG emulation patches
Date: Sat, 18 May 2024 19:31:42 +1000
Message-ID: <20240518093157.407144-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

This is a bunch of instruction and register additions, improved SMT
support, etc. for TCG.

Thanks,
Nick

Nicholas Piggin (14):
  target/ppc: larx/stcx generation need only apply DEF_MEMOP() once
  target/ppc: Remove redundant MEMOP_GET_SIZE macro
  target/ppc: Make checkstop actually stop the system
  target/ppc: improve checkstop logging
  target/ppc: Implement attn instruction on BookS 64-bit processors
  target/ppc: BookE DECAR SPR is 32-bit
  target/ppc: Wire up BookE ATB registers for e500 family
  target/ppc: Add PPR32 SPR
  target/ppc: add helper to write per-LPAR SPRs
  target/ppc: Add SMT support to simple SPRs
  target/ppc: Add SMT support to PTCR SPR
  target/ppc: Implement LDBAR, TTR SPRs
  target/ppc: Implement SPRC/SPRD SPRs
  target/ppc: add SMT support to msgsnd broadcast

 target/ppc/cpu.h                              |  32 +++-
 target/ppc/helper.h                           |   6 +-
 target/ppc/spr_common.h                       |   7 +
 target/ppc/cpu_init.c                         | 145 ++++++++++++++++--
 target/ppc/excp_helper.c                      | 114 ++++++++++----
 target/ppc/misc_helper.c                      |  82 +++++++++-
 target/ppc/translate.c                        | 101 ++++++++++--
 .../ppc/translate/processor-ctrl-impl.c.inc   |   2 +-
 8 files changed, 426 insertions(+), 63 deletions(-)

-- 
2.43.0


