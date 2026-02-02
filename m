Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ED3E73140
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 07:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmom5-0000Ee-56; Mon, 02 Feb 2026 02:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vmolH-0007VX-BK
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:54:20 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vmol9-0001ex-Tw
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:54:16 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8230c839409so3246994b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 23:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770018847; x=1770623647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r2rz+1WErtcAJvSDmv5VxDGhP4mO2dwl0naGN3/gLak=;
 b=V+QtaGnbEgGCtaUwvezssHDnM80WnORYMu60YDsTQix7uassXjXKg6cRe5O/NHN68t
 PTGj6wbHcwMwFlCvCxxOPneNwj0ys/z6j0hYB8nsQTqcwwKtUpPByyVS2g2gOlhQW9px
 k3E7u9EquIFdstmENb6F5APTF9iOkyGNU3Wq7YQIMQnbzdFDh6EXUrTPoki7iYEUwHTt
 QLnFunWsJk2srWph8XDpi9S558ijlzUW9ARVSfQI2JSlEEuU44U50N3A424u3C4aQm0o
 bM6+xBNquGLMprw9XZaa6neWPBWYyP+ZBCUjsXPO16KKIRDYbwzEDx/LWYZAhxyC8Kn4
 7ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770018847; x=1770623647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2rz+1WErtcAJvSDmv5VxDGhP4mO2dwl0naGN3/gLak=;
 b=m3m4KpjusC4oOHAzvjD74uUE3lamuuMEi4cykPkFvsJjn1eDuR5X0cv9sGh7UHS07h
 6AVDWnYtTERbTp+Cwg8s/NJgWbXBuELQK36s7F15mxULFyC3UXez6r9ZDFU81lBfQHVm
 coPDlYaJo21rz7Ui28OSAXELxYNo7Tn+aWIhQZRChdmpyQHKErRNkYytgFt6dFqq0eFm
 7KR4WRs4TSRKpS6ZhNJ7ywnd5i17vDg0MItUeEipqVbyaMHgwC3atc6ndJQUOyDGgfzT
 54Uxc/FHge/vNitxcRrJ9QSR9zsWmybBPk1qL58hPgJ06+cg8yb0iRPLP3kJolivgx8l
 /TQw==
X-Gm-Message-State: AOJu0Yz2pabSqPMUjcm/yhGLPft9nIdNig6+6ivP4MTLih+bp0srQT6W
 hjX4XVVBS4YFa7eNFEW40QjP6ipQkwx1+a3iqBKj+fDO+yizaQsDBGYju5Dck1w7SXlauXWyDqV
 LNAuna9LITJWtthdLqDQaruvhU0VNq8dFASuflo9ZNri8snscf80BzCBFYZEcOmloAn6WSyP+3Q
 6RzmC7JAEbbDSlj73ZoZTm/oqlTLCsvs1xcKwQ81Zt
X-Gm-Gg: AZuq6aK3rccwCq+GVWV1j1XizAEAMCjUqTf5nvjZbyVwCsPFNMCTr3xJQuxmnklC+Oq
 pzJA/5HkwJaxBL4usU8f48v772dhike6hxijIqYkNXJIgjh1+E2IBXyYRXkkKJghJeqD6IgCbxD
 omxf1e1kRgeRxbjKG8Tmp9u01Q6soDdC+In5DutIS/Qv1O1Ys04i14Lg80VtmiXGTLJOnrBxPls
 alwR47zmy6P/yDsw5GfyoRdh9oVUZLFkV7k5ARNSghvI7wN5Kgpsn5/s8S6sX7xbWSIB9s1lG71
 3ZRV/jjNmryI+ePzW/hqPYtlQsSI07jZRs0RBrrZjRdb5giXmuU8LXJfXgXXFYrxkg/3S2xDtVk
 Z5oAhVLYekUrorycnvOThAC0tXnYLJ1QBBSBVhX7x22EXB4dtd3AsY6BKvoo9oFvHDJjzKk2Q7N
 SlXNgvQ8vTyZx3YhWacvsH8tNVxNWn1tOi
X-Received: by 2002:a05:6a00:1490:b0:81f:5f49:6913 with SMTP id
 d2e1a72fcca58-823ab6a0129mr9663576b3a.30.1770018847155; 
 Sun, 01 Feb 2026 23:54:07 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379bfd7a2sm14507439b3a.39.2026.02.01.23.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 23:54:06 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 0/2] accel/tcg: Pass the access_type to IOMMUMemoryRegion
Date: Mon,  2 Feb 2026 15:53:56 +0800
Message-ID: <20260202075358.2137740-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x442.google.com
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

Since RISC-V wgChecker [1] could permit the access in RO/WO permission, the
IOMMUMemoryRegion could return different section for read & write
access. To support this kind of IOMMUMemoryRegion in the path of CPU access,
address_space_translate*() should also translate access_type to iommu_flags
abd pass to IOMMUMemoryRegion. Thus, IOMMUMemoryRegion can return the 
correct section of specified access_type.

This patch is based on
"[PATCH v2 0/3] Fix iotlb_to_section() for different AddressSpace.".
Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
feature.

[1] RISC-V WG:
https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
[2] RISC-V IOPMP:
https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/

Based-on: <20260128152348.2095427-1-jim.shu@sifive.com>

Jim Shu (2):
  accel/tcg: Pass access_type as an argument of tlb_set_page*()
  accel/tcg: address_space_translate*() will pass the correct
    iommu_flags

 accel/tcg/cputlb.c                   | 17 ++++++++++-------
 include/accel/tcg/iommu.h            |  3 ++-
 include/exec/cputlb.h                | 11 +++++++----
 system/physmem.c                     | 16 +++++++++++-----
 target/alpha/helper.c                |  2 +-
 target/avr/helper.c                  |  2 +-
 target/hppa/mem_helper.c             |  1 -
 target/i386/tcg/system/excp_helper.c |  3 ++-
 target/loongarch/tcg/tlb_helper.c    |  2 +-
 target/m68k/helper.c                 | 10 +++++++---
 target/microblaze/helper.c           |  8 ++++----
 target/mips/tcg/system/tlb_helper.c  |  4 ++--
 target/openrisc/mmu.c                |  2 +-
 target/ppc/mmu_helper.c              |  2 +-
 target/riscv/cpu_helper.c            |  2 +-
 target/rx/cpu.c                      |  3 ++-
 target/s390x/tcg/excp_helper.c       |  2 +-
 target/sh4/helper.c                  |  2 +-
 target/sparc/mmu_helper.c            |  6 +++---
 target/tricore/helper.c              |  2 +-
 target/xtensa/helper.c               |  3 ++-
 21 files changed, 61 insertions(+), 42 deletions(-)

-- 
2.43.0

