Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F73C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPqd-0007Yg-DO; Mon, 12 May 2025 05:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqV-0007YN-VG
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqT-0000fD-DM
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qv7R4Liw7RDeIkUt3mAbKKK1CcscpAbyIQp6Wo2A0As=;
 b=aGh/yVufvRFaRjP4LmyIOhBBsMvtkoWIeuLSDZeIqudBFHDIThvF6kblaRzEUCEVtXKtPo
 YFIF7e46Lc5jL2eNtDclTxKQdGl5Dt3vyu3aEC+XCNEudZT68jK1JNj3VpPkDwLmyAn/yk
 RMW2FeXGCBeyAtev0O8KzfAPlE+CYTI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-w9WfpTxSNn-Hd5g3NSgPrQ-1; Mon, 12 May 2025 05:53:09 -0400
X-MC-Unique: w9WfpTxSNn-Hd5g3NSgPrQ-1
X-Mimecast-MFC-AGG-ID: w9WfpTxSNn-Hd5g3NSgPrQ_1747043588
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad2200eb1d0so189421266b.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043587; x=1747648387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qv7R4Liw7RDeIkUt3mAbKKK1CcscpAbyIQp6Wo2A0As=;
 b=l9sL0rwVWYdJMvKTWP2sVD5vwYEmW5/5HPBzDyiSMQenlRdh1tyy8CSF/2CMVTrteA
 2zShL/pj3IilVdCvsUw9oRplxvUIST5KOGsKadNBOcA/Oqg2T86emgSTmiAQO87lK2a6
 2TwR1ZpCGmX7g0N+P66Tx6FMB21ASC9kJLg8iQfyjeI1My62YklIggg9Y0AeolcHfVHe
 mRgl7i++y58H7oEBSjv/PclAOxUlmEO2fR25fgJxTS73JJiZdZTl2rr8VNFqG6oyY01l
 CLY9P9AAVN+Q4rorRFK16F0Pk6Nvtk9n3APl/BE5L8E1NKKEr5apQiXxwE/Egi2oI/Dh
 gC9w==
X-Gm-Message-State: AOJu0Yw0XV8r7OTlT8iTNaMO+RdWl6a9sP1onKWfmeuMTSpr67xy8ULa
 hAYULy7ck/M811OpmiIwBvXoFaqQHvJuk39a9BSB0oN/bamSqBzfxCglZyqLy03+YvaHZX+IYso
 NquQQrXlvih6AU+pyMZdqcSzf4A6AzNCwi0hYdvTFueD5uZWr//p6c4ETpYEhbZ3dxvprAdOHsy
 +bmo7x6AID4cGlokKJE+1EAUHVkFHV5+PNWlFM
X-Gm-Gg: ASbGnctG0kUSMQ2Aui+4MQlxeJ+OZalWFxDp6d0WpOpkZEbjBJHDCZaCHUY2t8cUauI
 yJNG8FJohaXKLhZdt5VDwRjwYaCCwQxA19AsHEBMWZeFyrldd4rNa3RD+9lMn3kghHrMyQ9IKS7
 ncIgqp8UJszQVRnVgHEOQKQpwuVJiOESu1nKkcpjVjMYihFrEcJ+pWi1PVgtrtPl6LWw5xdy5XJ
 b3JQWEDHk5Vvz3EHAAl/+E7W5qpze53lCgzLQ9/nJ/M7xTTnhTvszRoxGMp+qd3W2eilGyYaocf
 Dw8pXDITmhEoQiPJ5sHAc6jpGfd82gBbFn8TjvlpcgcqdKg=
X-Received: by 2002:a17:907:7b04:b0:ad1:fab8:88ab with SMTP id
 a640c23a62f3a-ad219085c07mr1088387266b.29.1747043587621; 
 Mon, 12 May 2025 02:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGirQNVxPCK67r1wqO0mpN9rPKbFvree93m+FbHXHH4GL6MgFnqPYZk3ymXHgxXSQOYDvnuZQ==
X-Received: by 2002:a17:907:7b04:b0:ad1:fab8:88ab with SMTP id
 a640c23a62f3a-ad219085c07mr1088385666b.29.1747043587231; 
 Mon, 12 May 2025 02:53:07 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c81bfsm595597766b.33.2025.05.12.02.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH v5 00/26] target/riscv: SATP mode and CPU definition overhaul
Date: Mon, 12 May 2025 11:52:00 +0200
Message-ID: <20250512095226.93621-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Same as v4, with suggestion from Richard to avoid parentheses---which also
fixes the issue with kvm-cpu.c reported by Daniel Barboza.  KVM/RISC-V is
now covered in CI and passes with this version.

Paolo

Paolo Bonzini (26):
  target/riscv: assert argument to set_satp_mode_max_supported is valid
  target/riscv: cpu: store max SATP mode as a single integer
  target/riscv: update max_satp_mode based on QOM properties
  target/riscv: remove supported from RISCVSATPMap
  target/riscv: move satp_mode.{map,init} out of CPUConfig
  target/riscv: introduce RISCVCPUDef
  target/riscv: store RISCVCPUDef struct directly in the class
  target/riscv: merge riscv_cpu_class_init with the class_base function
  target/riscv: move RISCVCPUConfig fields to a header file
  target/riscv: include default value in cpu_cfg_fields.h.inc
  target/riscv: add more RISCVCPUDef fields
  target/riscv: convert abstract CPU classes to RISCVCPUDef
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
  qom: reverse order of instance_post_init calls

 include/qom/object.h              |    3 +-
 target/riscv/cpu-qom.h            |    2 +
 target/riscv/cpu.h                |   42 +-
 target/riscv/cpu_cfg.h            |  178 +----
 target/riscv/cpu_cfg_fields.h.inc |  170 +++++
 hw/riscv/boot.c                   |    2 +-
 hw/riscv/virt-acpi-build.c        |   14 +-
 hw/riscv/virt.c                   |    5 +-
 qom/object.c                      |    8 +-
 target/riscv/cpu.c                | 1014 +++++++++++++----------------
 target/riscv/csr.c                |   11 +-
 target/riscv/gdbstub.c            |    6 +-
 target/riscv/kvm/kvm-cpu.c        |   27 +-
 target/riscv/machine.c            |    2 +-
 target/riscv/tcg/tcg-cpu.c        |   13 +-
 target/riscv/th_csr.c             |   30 +-
 target/riscv/translate.c          |    2 +-
 17 files changed, 734 insertions(+), 795 deletions(-)
 create mode 100644 target/riscv/cpu_cfg_fields.h.inc

-- 
2.49.0


