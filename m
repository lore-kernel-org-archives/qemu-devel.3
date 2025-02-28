Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A8FC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxb2-0001tY-BN; Fri, 28 Feb 2025 05:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxb0-0001su-Vu
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxaz-0002sn-91
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iFqhwqKt5z+mF764zzB2HkTX/p696HTKDSuKcdbiYFI=;
 b=L5yd6QYEILwO8l3B7ydv1WRXyeeL9j61rKvgejE2p0s5mOqSWMaHOpOUeJl3ZTfwhfM5cn
 1AWpQdkmUAjZC6Dcb/iUxdmoZCWfP/e54X8wkO93xXnNKukC7rWmEr3s1dWSpxfJg+5wZV
 Vn5sRzXKeTOTLwaE//l2LirrWVRPeSQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-_0RvH6BrN4S2WM7h1Ufo2g-1; Fri, 28 Feb 2025 05:27:50 -0500
X-MC-Unique: _0RvH6BrN4S2WM7h1Ufo2g-1
X-Mimecast-MFC-AGG-ID: _0RvH6BrN4S2WM7h1Ufo2g_1740738470
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390eefb2913so322235f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738469; x=1741343269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iFqhwqKt5z+mF764zzB2HkTX/p696HTKDSuKcdbiYFI=;
 b=bPRXB8jxX4ZMIOxeKlE6zNZF988wc4SisEjg2XhbXXruTZKyMZ6OFwSvIamf6jvbg0
 Axv8oAtyvkq+NZyyvyP9F0FhZF041ta0uWRg6VFY9c5mHbXmGLWmGniSMpHtkDwKBmHr
 tdYVUe5aRcu8JcaIQu7Qo01Sbakh3UVYP7i8bvtfBlhkqT7Gbea0RvCwM5s1AGT38bx3
 o0HnP7zL+uTE1nSTMr+SyAro5io+dhGIw7aYcNAhvZF948lX9sPG1BNhB8LC8YI0af8X
 GjkUTNm71ho+RMJV7n7ZSMfXUdjUWYHF7SoIiDW5FOnNDptMtVJK+Vjul/PoRU2mCzHc
 0Xeg==
X-Gm-Message-State: AOJu0Ywwufdn1J2MzwavM9ina9AqKiHPoxDOvTdQQpCwMLNHrRYJ/5pI
 BNEP5qM+wBn6oyjeDoQP0j1dLvNGvtD6aPEU59flGEduMiCt7+ynDGCpCqHYV0VE9un2I/VWaRA
 IpubQBZm9GRGcBJfco+hkJJyqGp//Fulad+TIbooGlzlWwH0NrPU7j0Q/NX67EQ7EigGuLWU1cx
 A0HEE1zlxRhNKC/NabPvl6Vb8+Gdc7PJzr4gvEGfE=
X-Gm-Gg: ASbGncshJKpK9ulKTzWFKC4u/oWMIfpRYW/MCGj/hrRvXswxTdzuqtv0WS/4UkKcGeg
 qY4SqVM/RqoxRQewLQ2lvaMo4KJTsU+cDGRiCJjxzvjnTJqq/YYQIFinbJfRVtaHp5vEBMkzNjN
 Jq6qujAt54lFgkMXewoLJHcLp2AjTksaYHP/2Wl781qIaABxDnkW0jCUQKx8KT2+h1y8GuUzEnW
 /VAeafwfuQbV8eMjBJmN1hcr2Sh1kFBwfjyLAPF5wfmCGB23MRt85BmkcQThgboqbAl9jyyJv27
 H0ME5vliFh55F3LpDdFU
X-Received: by 2002:a05:6000:1543:b0:390:efc3:1eac with SMTP id
 ffacd0b85a97d-390efc320d4mr1499671f8f.39.1740738468930; 
 Fri, 28 Feb 2025 02:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyGkVmZ0qp1JX3NA5AA9WDA6IibDZ+Tstf91CYpVuBQL8YHpvSzvOFN126ZrABf7BdZ+FlRQ==
X-Received: by 2002:a05:6000:1543:b0:390:efc3:1eac with SMTP id
 ffacd0b85a97d-390efc320d4mr1499647f8f.39.1740738468452; 
 Fri, 28 Feb 2025 02:27:48 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a5b96sm4785148f8f.29.2025.02.28.02.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:27:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH v2 00/22] target/riscv: declarative CPU definitions
Date: Fri, 28 Feb 2025 11:27:24 +0100
Message-ID: <20250228102747.867770-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

As in v1, what I really wanted to achieve was removing RISC-V's
use of .instance_post_init; that's because RISC-V operate with an
opposite conception of .instance_post_init compared to everyone
else: RISC-V wants to register properties there, whereas x86 and
hw/pci-bridge/pcie_root_port.c want to set them.  While it's possible
to move RISC-V's code to instance_init, the others have to run after
global properties have been set by device_post_init().

The way to get there is to make CPU definitions entirely declarative.
Previously, multiple instance_init functions each override the properties
that were set by the superclass, and the code used a mix of subclassing
and direct invocation of other functions.  Now, instead, after .class_init
all the settings for each model are available in a RISCVCPUDef struct,
and the result is copied into the RISCVCPU at .instance_init time.
This is done with a single function that starts from the parent's
RISCVCPUDef and applies the delta stored in the CPU's class_data.

Apart from the small reduction in line count, one advantage is that
more validation of the models can be done unconditionally at startup,
instead of happening dynamically if a CPU model is chosen.

Based-on: <20250218165757.554178-1-pbonzini@redhat.com>

Paolo

v1->v2:
- merged "remove target/riscv: remove unused macro DEFINE_CPU"
- max SATP mode refactoring moved to its own series
- included a couple of Philippe's patches from his "const class_data" series
- RISCVCPUDef initializers all declared as const

Paolo Bonzini (20):
  target/riscv: introduce RISCVCPUDef
  target/riscv: store RISCVCPUDef struct directly in the class
  target/riscv: merge riscv_cpu_class_init with the class_base function
  target/riscv: move RISCVCPUConfig fields to a header file
  target/riscv: add more RISCVCPUDef fields
  target/riscv: convert abstract CPU classes to RISCVCPUDef
  target/riscv: do not make RISCVCPUConfig fields conditional
  target/riscv: convert profile CPU models to RISCVCPUDef
  target/riscv: convert bare CPU models to RISCVCPUDef
  target/riscv: convert dynamic CPU models to RISCVCPUDef
  target/riscv: convert SiFive E CPU models to RISCVCPUDef
  target/riscv: convert ibex CPU models to RISCVCPUDef
  target/riscv: convert SiFive U models to RISCVCPUDef
  target/riscv: th: make CSR insertion test a bit more intuitive
  target/riscv: generalize custom CSR functionality
  target/riscv: convert TT C906 to RISCVCPUDef
  target/riscv: convert TT Ascalon to RISCVCPUDef
  target/riscv: convert Ventana V1 to RISCVCPUDef
  target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
  target/riscv: remove .instance_post_init

Philippe Mathieu-Daudé (2):
  target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL
  target/riscv: Convert misa_mxl_max using GLib macros

 target/riscv/cpu-qom.h            |   2 +
 target/riscv/cpu.h                |  27 +-
 target/riscv/cpu_cfg.h            | 160 +-----
 target/riscv/cpu_cfg_fields.h.inc | 165 ++++++
 hw/riscv/boot.c                   |   2 +-
 target/riscv/cpu.c                | 909 ++++++++++++++----------------
 target/riscv/csr.c                |   2 +-
 target/riscv/gdbstub.c            |   6 +-
 target/riscv/kvm/kvm-cpu.c        |  23 +-
 target/riscv/machine.c            |   6 +-
 target/riscv/tcg/tcg-cpu.c        |  10 +-
 target/riscv/th_csr.c             |  30 +-
 target/riscv/translate.c          |   2 +-
 13 files changed, 632 insertions(+), 712 deletions(-)
 create mode 100644 target/riscv/cpu_cfg_fields.h.inc

-- 
2.48.1


