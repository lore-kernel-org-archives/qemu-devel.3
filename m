Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA21D35686
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 06:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkzD7-0004a3-NL; Wed, 28 Jan 2026 01:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vkzCz-0004Xh-4O
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 01:39:22 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vkzCw-0006VU-7j
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 01:39:20 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82310b74496so3079917b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769582356; x=1770187156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HkxLL4Tn69p33wJwaqGeXLDsLdUlfwXoi+NcqvjYhPE=;
 b=UGDG/mp8fXUAJl0WVtoCGha7iu84K8CLylzdn1GJccCCSf5A4JMsRBOmxjQKAx/Qib
 Q7sTpCFHGkWHliWp+kid7l1eRDc5fYPEIwSdGvr/yn3tDNTQ+zEmqz3rKr2PPY7+RyPq
 DyhuI09K7vozmbC9i/UAK0wvJnJyvL1RcFYX/2u6L5rbE6qlIR2Bu7AEmforYt2vH+X2
 1AKR32bZts+Rk1uygLaiuY5dJnY42az3gOctwebtGJPyMXYuCa7YyXPqI4RjNa6ekX5k
 EHZa2oO6KhaZLFhCnuMf83g04KvluRWE8knc96sG5guyQ+lNxR66ej9QNh40RVPc9W/w
 12zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769582356; x=1770187156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkxLL4Tn69p33wJwaqGeXLDsLdUlfwXoi+NcqvjYhPE=;
 b=cL8JwQmkIaYD4P7JQw9lnZ7pC9shzEg3LBGnxKuCVsQDHU+JlRffr9pGsh2b6IR8cz
 UOJzdVfQOgc+n6w/oodAyvLbDNvU9w1JJP+7Sby9BuuFwAcnGt2K6iMAV2BCImHp3tsk
 8mNu9G8ak1H+FH3tLjnhxGQvU3ppBHD4tthNsiKuC5eRdVScYp0nyUav54t/ohzvHZYy
 ULvnn8IWiSkCuOxwOcsF+Ke7V25vKw/hpqYtSUnmZvFrGAgSvpNKbBiK6TB+WyyrZ8Dq
 giCHS/76LG3DhdwY/Z8DtQfxyHPD3fotuicRSR14SJS9ZLsOKDLwnz5Y5Z7F5oQCYYlb
 bJWQ==
X-Gm-Message-State: AOJu0YzhdUqSR/cpNp7wA8dJV0Srz2rwCFpUD49vrf4STop9k1Iby+QS
 VSzp62FC5k7KI/s9cMK7tdNH/ck0wqP6Jc+cWStFZd8QnQ4S6F9c2ZcnPHqMPrqrmORz2imEwsX
 /dFInitBh83h8CoWVoyfqdRnhbFOy5VzbodocKt6qAxJrGU75UMKyQvNuGMLcRzNWDbSuvh03DG
 IDWHsQViOl4A5ngUyGYai8aEPLd2aV/YOtF1tCSA==
X-Gm-Gg: AZuq6aI7FZIuLQMrM4TzZs0EV/GNK6OPM8feV6+fem4EyPip299TqmBeml5aM79yIWd
 pG8D+UuqWHKL7XQyT7EEUJl0BsQmlRz6oC/XM1aZFvUCnSLzv8ATkS0LgKewcLS4HogsJN0LZMq
 CX3lIFs3Vn18OLZBof9YI8dZlST1p+nzKt1n8S4KVcluxj10AJ73JkexK/R7W6MR2aV5OfzzYUx
 9FhE3eCNp9vsx3IhoPYQtLrBIQzS5Fmu4+ybap8dvgSpKmpMkzudn1xaGh5ll4Ti6DHL3zt7gnM
 ZDGPH8c411LR2fviJM0fpVMH33/OgW3p816KVuR95UWnmVjK8hLd68S2hpgdZLaxJtvvLE9Of5G
 WOZVkmFVJ82HRw6Lg4Qu3/DRLh/6IbjGAgMwVLJzHZdkfzGQmGjohzH4XqspLQGhC+kr7diGJF3
 FW1XybZn2tyzqK4vYM78GiwybggXEbeMPM
X-Received: by 2002:a05:6a21:2d46:b0:35b:b97f:7bd2 with SMTP id
 adf61e73a8af0-38ec6289547mr3807252637.10.1769582355500; 
 Tue, 27 Jan 2026 22:39:15 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642487f1f5sm1244736a12.0.2026.01.27.22.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 22:39:15 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 0/2] Fix iotlb_to_section() for different AddressSpace
Date: Wed, 28 Jan 2026 14:39:05 +0800
Message-ID: <20260128063907.2066100-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Current 'iotlb_to_section()' API only finds the sections from CPU's
AddressSpace but not other AddressSpaces. However, If address space
translation is over IOMMUMemoryRegion, like ARM MPC device, it could
return section from other AddressSpaces, which will break
'iotlb_to_section()'.

To fix this bug, store complete MemoryRegionSection pointer in
CPUTLBEntryFull, and we can directly use section pointer in it w/o need
of 'iotlb_to_section()' API.

Besides ARM MPC device, the upcoming RISC-V wgChecker [1] and RISC-V IOPMP [2]
devices also require this bugfix.

[1] RISC-V WG:
https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
[2] RISC-V IOPMP:
https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/

Jim Shu (2):
  accel/tcg: Fix iotlb_to_section() for different AddressSpace
  system/physmem: Remove the assertion of page-aligned section number

 accel/tcg/cputlb.c        | 32 +++++++++++++++-----------------
 include/accel/tcg/iommu.h | 15 ---------------
 include/exec/cputlb.h     |  2 +-
 include/hw/core/cpu.h     | 12 +++++++-----
 system/physmem.c          | 31 -------------------------------
 5 files changed, 23 insertions(+), 69 deletions(-)

-- 
2.43.0


