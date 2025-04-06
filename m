Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC372C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2X-0002uP-21; Sun, 06 Apr 2025 03:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K29-0002ri-Vd
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K27-0001ys-Mu
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743922986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tIqBeBBCQzxQ5jfWX4iNL0+26m8LfRzKLaojChAm/WM=;
 b=WIipmsLw0udSVKSKQcUv3zlA0bXwYjF/BK6tWkTY4dTrMgMCBEUScZEcN9qJLAhDZfc6e9
 1oKaFXEq/nHezkznnn37A2O0YP4g5qOmsJmKcrvPiH0UIGl9GFzharROqQU+tczCKZdZyT
 B3BAV+ButQPLqJFb1J1s2fHOAHhvKcU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-rE3ZDILnPaOOADoL4-qPuA-1; Sun, 06 Apr 2025 03:03:04 -0400
X-MC-Unique: rE3ZDILnPaOOADoL4-qPuA-1
X-Mimecast-MFC-AGG-ID: rE3ZDILnPaOOADoL4-qPuA_1743922984
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391315098b2so1362003f8f.2
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743922983; x=1744527783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIqBeBBCQzxQ5jfWX4iNL0+26m8LfRzKLaojChAm/WM=;
 b=exXCJr9tiIe92kUDmHUHCJqh3xivtvfUx4nNO05DSjIU/KpqAY02TIZBR/ycPOhKjr
 ZOVgXEm4NlAMrv8CghTGY7rlWKiRdULmhYJOrfs9/hOfcuVt4cb155P37WrrQ71cEIQA
 d8+6KO9+cQAawL2x3puCm8EeADo9EHohMZfnE2Q2AZIvZxbA/Z0MeGmEcoHqZzU+UTpD
 qbUXVal7qSOLXP7uk8vRKJc1LkUkTTIqoTK+NO3xQSpBSRVAcFTYsKGaa0cwploEOSMv
 0SZfW6TKKBXm/J4yxOAfRTlqesyWurMziNhDgtG4s/5ggoihXMvTuA44vYzQ3ZFhE6+1
 67Bg==
X-Gm-Message-State: AOJu0YwejZlVhdGBjbDhqIK5M7l4PhB6wCvmeOgR1bd6HkxmDkvDZGcN
 WUjQiPCO0AMXufBxYqN9VzvmCm/2k4Bc8oSMlkHK83VTcshqwX7db4aRiCZ4ErtAutuVTrEj3u4
 kyzwISfxPjO+r717KVgMLjPBLrIdrOADGtSXnsMwlY3gExZLCF+x2bk7kfzSDcSg+GEYTb0Wfsm
 2aowxrytfJvF47VFNqF+IjlBvRXtYxcgB4TRKA
X-Gm-Gg: ASbGncu7skcvR4uoMf86bt00zl20kGWoEV0BrQPnqFBn3va1rMBMOI6zypfbjN1tjE1
 /a1Prc2tZjF/NgRZO1u/GesAuGx7skycjMCM6srM1RHshhN6aGlLVZFSAYzWoDebJeTIE1ZNJSV
 QvoPpfKcLLACMzCoz7ufqtfeJ8BCdeGU1X0gt2d2Ll/ba3/tbsioz7M4sF+o2uC0BllivyHgu59
 IZ1jmLWeRUfPfqLMueujPMMZk32F81CTqx2wn5EEfgo5zv/41qSlTTnavZ1Rwmf4QjBYzsm9kab
 Xowa1a5M6vwrSzVgyw==
X-Received: by 2002:a5d:584c:0:b0:391:3f4f:a169 with SMTP id
 ffacd0b85a97d-39cb35a8e8cmr6857245f8f.32.1743922983261; 
 Sun, 06 Apr 2025 00:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkR/R3i3FTIQHZyPfknDvJZFjLF14qn+DPcnu0FVXxI29YjE4eGoCxM1xQwwakXjbADR+IJw==
X-Received: by 2002:a5d:584c:0:b0:391:3f4f:a169 with SMTP id
 ffacd0b85a97d-39cb35a8e8cmr6857226f8f.32.1743922982910; 
 Sun, 06 Apr 2025 00:03:02 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020dacfsm8747942f8f.72.2025.04.06.00.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 02/27] target/riscv: assert argument to
 set_satp_mode_max_supported is valid
Date: Sun,  6 Apr 2025 09:02:29 +0200
Message-ID: <20250406070254.274797-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Check that the argument to set_satp_mode_max_supported is valid for
the MXL value of the CPU.  It would be a bug in the CPU definition
if it weren't.

In fact, there is such a bug in riscv_bare_cpu_init(): not just
SV64 is not a valid VM mode for 32-bit CPUs, SV64 is not a
valid VM mode at all, not yet at least.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a2..fffd263a799 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -445,6 +445,8 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
             cpu->cfg.satp_mode.supported |= (1 << i);
         }
     }
+
+    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
 }
 
 /* Set the satp mode to the max supported */
@@ -1505,7 +1507,9 @@ static void riscv_bare_cpu_init(Object *obj)
      * satp_mode manually (see set_satp_mode_default()).
      */
 #ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV64);
+    set_satp_mode_max_supported(RISCV_CPU(obj),
+        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
+        VM_1_10_SV32 : VM_1_10_SV57);
 #endif
 }
 
-- 
2.49.0


