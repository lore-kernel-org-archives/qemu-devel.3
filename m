Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A750C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlx7-0005SG-A3; Thu, 27 Jun 2024 06:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx1-0005I8-4n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:00 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwr-0001gD-NZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:58 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6eab07ae82bso5512816a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482508; x=1720087308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLCyPqMhz46RMQyVFn3nlk/YPcVVg7QWv/riYPUXA0Q=;
 b=KPk7VPnbbgY29O3yLpxtefZN1rJ7xZ/Bj7YLGr6UqfeFCDoJDccausF2P14L+Mxwq2
 k08ZIHWbVgVrnhTFcq6sZVHRlxaAitVRMARl2MsyGxKSJ6zP3XF9/umHBLr4k4NQDKlz
 Tu952VQ3kYmTApvo06fgzBMT0HFr2RH+SrhqP4XnuN6TbTLWXZeDpsLtTD6CCaHF0R7G
 0e9cIGsMETd/DhsNAihJLJryGvaxS2oYofz6NnhAPhQAKxnrNgBYPerFEOXyJFrNx9ul
 UT2L8qGSEsabnR8V9silJMBbYci0sMgiTFVYOHYTBBaJ1grdFsto6+paeizB5geO3vk5
 YKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482508; x=1720087308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLCyPqMhz46RMQyVFn3nlk/YPcVVg7QWv/riYPUXA0Q=;
 b=rFpLMMqN1e3Yo4VxIjmLsz/y3FYd38+rJU2a5jw6xrUwFW0abhhK1IC2p1Lu47Ns87
 0+8uF4tzugxs50tb8Pdi8j06kFcTgFSZ2yGVKVwijakefB4SBCRu1bIFCKc68Yx8Z52Z
 cpS5NQzcvTYpMM+dUd21qSwIejouO9TSKPpV5gG7Rp+6YTpSC3Ykk481onvkce8MCbve
 45JUw3cDqK4qtxIcYNKEkd07fmfUc1BljsBDEMilenfhSAg30qTuyzlQSXV5UweAznLP
 9bhBuzURn2MQU+v5cY9asGw8vBYV8aWmUMos7xEG9vTrKLbWsClh4xjOJhNM08JRvJhh
 lUkw==
X-Gm-Message-State: AOJu0Yz0rS+xim5IRwFu/pTv/FH9e/fmO0CqjMY89KU9RqgEjl/dl14i
 Z25QP6H0l6QyfIvtjKlYMBHLll6xe2PrJZFS049XXYAu/o+z+H9ZZqozBRrK
X-Google-Smtp-Source: AGHT+IFRsJi8Lk/YkWmZNzyYq1os59XyudwW9DbXAz8UNZbqOp6WG+o9Z93x0Czo5Bhzx8xLQUI1ww==
X-Received: by 2002:a05:6a20:ba20:b0:1bd:19e2:744c with SMTP id
 adf61e73a8af0-1bd19e274e6mr6680379637.4.1719482507949; 
 Thu, 27 Jun 2024 03:01:47 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Chao Du <duchao@eswincomputing.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/32] target/riscv/kvm: define TARGET_KVM_HAVE_GUEST_DEBUG
Date: Thu, 27 Jun 2024 20:00:35 +1000
Message-ID: <20240627100053.150937-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Chao Du <duchao@eswincomputing.com>

To enable the KVM GUEST DEBUG for RISC-V at QEMU side.

Signed-off-by: Chao Du <duchao@eswincomputing.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240606014501.20763-4-duchao@eswincomputing.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configs/targets/riscv64-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index f688ffa7bc..917980e63e 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -1,6 +1,7 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_SUPPORTS_MTTCG=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
-- 
2.45.2


