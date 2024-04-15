Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B047C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 06:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwGD1-0002yD-Rx; Mon, 15 Apr 2024 02:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1rwGCz-0002xY-U3
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 02:52:53 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1rwGCy-0004aX-8L
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 02:52:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e651a9f3ffso2686045ad.1
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 23:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1713163970; x=1713768770; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTcCQdUvjp2hbnjbDYmBwM5NCyK6LP1p76vlGeR6wsw=;
 b=iulNVCjBVcsXXOX2gNAdGqNUzYB/dz+pCSQ1dl3igizP8E8qwTuKElG+x2hlZBFV4n
 16aD094CTsKuDPZMmdt7PQImZIjhAsemOobnyvTyJQ8WsjNEj6+HJhzR9gzqP+uKvOit
 dfeCCWcU0IBDwd+cU6k8Q4wk49Y/Kti+AAfnagLcacYmz7bVw0TyUp3mpuooTYmnA3Qj
 AEou0aXMdVoS9EwfXrUYz55ggA+/WzNCWfVSax3D2Y7a4/4TRQ81K8MichNd9bi77wY1
 s/5HKfw72JHqUG/cG9xrJljI+v34NxzCxlSesGL4lbrwbR+QYIfZK7zCgi8R6BKNiq7d
 pT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713163970; x=1713768770;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTcCQdUvjp2hbnjbDYmBwM5NCyK6LP1p76vlGeR6wsw=;
 b=fm5YHuhpkNKixK8v4D7R/dGj6XZGYf39HVrtTL5sZ/YY2Ps6TIDqKYLqtw1ECUxkxC
 eEO9WS8qLmBlrP8z3JExLJAzq/24+0IEyTADWfIUMNDNhJl6CwuGAgWQScpCsbMv6ATu
 +Qe8u/AW0yAaSKwO/0ENPguD/NB41tghBuT4nrVx6IWlNEWTyJVqmc93V4jTDRBd6NkL
 8C45waIvBUqkWU8pKyRj4gwAAXpIjTVnGMV2nHKO8fXw17kFUwLKAZPB5dtVgNsyZS7M
 UoHevKuiRVsfh7W54KyZgEPgPiGMwucjhABdkOdGi3a7zuZWsfncP8pzHmU4ziRR0EvU
 RhQw==
X-Gm-Message-State: AOJu0YyXMjFMA7zb6Z7GWn+5neL+J9/DRmi81NDlcCQlvqFWtZOJXRoT
 LxXkRHVbw6a7wmffFFDezb3Knsj93K/2M7r6cCTVsk1A4UN22CTU8IDMqa9m1Hr5GG6w/6AvjUu
 sEKw70qj6ygyh8MWMl+FO2Y0B0NVsDKONlUxZGxfsZ5L4jNwTifxbBTB3nIysQd39FLCll6IAC3
 HsAVNBtHzC7NnuMDh4LN7d6WNbHSA3fQpBnv5qqcEUOaea
X-Google-Smtp-Source: AGHT+IHuj1udC5yzyDkvK5bH6sWXvRQRDFmC9qWucyK3jxf2LP6ciBmKufIDxWWa5C34csmXaJFnJQ==
X-Received: by 2002:a17:902:7402:b0:1e6:3577:190e with SMTP id
 g2-20020a170902740200b001e63577190emr2443553pll.24.1713163970331; 
 Sun, 14 Apr 2024 23:52:50 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 jb12-20020a170903258c00b001e2a3014541sm7182394plb.190.2024.04.14.23.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 23:52:50 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/1] target/riscv/kvm.c: Fix the hart bit setting of AIA
Date: Mon, 15 Apr 2024 14:52:43 +0800
Message-Id: <20240415065245.25455-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The hart bit setting is different with Linux AIA driver[1] when the number
of hart is power of 2. For example, when the guest has 4 harts, the
estimated result of AIA driver is 2, whereas we pass 3 to RISC-V/KVM. Since
only 2 bits are needed to represent 4 harts, update the formula to get the
accurate result.

[1] https://lore.kernel.org/all/20240307140307.646078-1-apatel@ventanamicro.com/

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/kvm/kvm-cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80f1..388c4ddaa145 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1642,7 +1642,14 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         }
     }
 
-    hart_bits = find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1;
+
+    if (max_hart_per_socket > 1) {
+        max_hart_per_socket--;
+        hart_bits = find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1;
+    } else {
+        hart_bits = 0;
+    }
+
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                             KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
                             &hart_bits, true, NULL);
-- 
2.17.1


