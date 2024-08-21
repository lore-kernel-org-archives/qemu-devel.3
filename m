Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0C3C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 07:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgg7D-0002o7-FW; Wed, 21 Aug 2024 03:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sgg7C-0002nI-5c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 03:50:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sgg7A-0007Rh-FG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 03:50:45 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5becfd14353so5227816a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724226642; x=1724831442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RHGsgtOtT2umrQLR6AFcY9ClQMq9gzTua8dd6k91t7Y=;
 b=gt7xXTduZs1K+r+Zo4rc4wMTRxfpC9z5QtOGwIGVLo67+VrSEKC2UF2GPuifLF/JIn
 YLcsMwLlgMeCqCK1KeISSWzaKr5GKGtwpP/MJo23j/eR9OgpaEz/lfytaZ65gDyO/mzn
 Vh/0uWG+e5PwOo4l0PlST2nCDY4FpW9qgijr2XfFA4HBCWOHYH+jVEQHAgeY/oIR5WYm
 z+lbg+7dZxLlK798Ofnw6A1/m3Y3jBkuf5va66GN327EL2/ShJjpJUqGbMDu2klDadqv
 g9aPhpunjV0HmQ/KGcw+ILafGDXjym0yYIiaYUn2QSbByz+qLzgoq3EDUj9AcOActXRj
 gHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724226642; x=1724831442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHGsgtOtT2umrQLR6AFcY9ClQMq9gzTua8dd6k91t7Y=;
 b=c0KzOcd3k5gws61KalPofutHhcFzTIzwgUpo9sXhHJ63IhfeWA5qnpYkq8ofy/r9cq
 thb85/DGgnRmmukGm/4y8itpmkWTLtjRaXkf281Ja66lkIlpkokdm0vcrHH7vlNk0THY
 GzIQwER47drZypwXnWvNNCvqJx1/1A71BQrm0AkUdpJq5mMxL1aTDsT8uAWCF9u+jrzB
 8yJ3fhUwAtaFGTThmc11AbEhILF/6aR2utN8/flP8dcobY+M08Vw6WBtltreUG2QeGug
 vLFesAlUsDQMyrKJ4LOwKwmG3joFpTY9KgCZAuYhMb7FT2rZ1R+qQZuN4DO/4kDE3CmJ
 IQMA==
X-Gm-Message-State: AOJu0YwQ5+C1m2I3b2tfjNveo3Q7EqDzn4io6a8PeDcf2QDXca6Ei0ZL
 8yQVFyNl7ypPRHOkq1TXCKvXX+hNDQHZG67R5Pr3TLn2GIBiLeNEmH550bpwt5FYNtunxv0VS/U
 V2uE=
X-Google-Smtp-Source: AGHT+IHOB0z0CBNl1t2RYjlBOwWxzkRYXKkmTnE4K4pEI1YecPdPRAJFwmiJQvg1qAcF7mQ8tpC7Lw==
X-Received: by 2002:a17:907:1b08:b0:a79:fbf0:8106 with SMTP id
 a640c23a62f3a-a866f1268bemr104527966b.6.1724226641727; 
 Wed, 21 Aug 2024 00:50:41 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfb69sm861323366b.88.2024.08.21.00.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 00:50:41 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 yongxuan.wang@sifive.com, dbarboza@ventanamicro.com
Subject: [PATCH] target/riscv/kvm: Fix the group bit setting of AIA
Date: Wed, 21 Aug 2024 09:50:41 +0200
Message-ID: <20240821075040.498945-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Just as the hart bit setting of the AIA should be calculated as
ceil(log2(max_hart_id + 1)) the group bit setting should be
calculated as ceil(log2(max_group_id + 1)). The hart bits are
implemented by passing max_hart_id to find_last_bit() and adding
one to the result. Do the same for the group bit setting.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f6e3156b8d2f..341af901c5b0 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1695,6 +1695,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     uint64_t max_hart_per_socket = 0;
     uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
     uint64_t socket_bits, hart_bits, guest_bits;
+    uint64_t max_group_id;
 
     aia_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_RISCV_AIA, false);
 
@@ -1742,7 +1743,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
 
     if (socket_count > 1) {
-        socket_bits = find_last_bit(&socket_count, BITS_PER_LONG) + 1;
+        max_group_id = socket_count - 1;
+        socket_bits = find_last_bit(&max_group_id, BITS_PER_LONG) + 1;
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
                                 &socket_bits, true, NULL);
-- 
2.45.2


