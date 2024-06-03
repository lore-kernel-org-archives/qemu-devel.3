Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBADC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5iC-0001ba-66; Mon, 03 Jun 2024 07:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5i5-0001Be-NQ; Mon, 03 Jun 2024 07:18:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hq-0006XE-1e; Mon, 03 Jun 2024 07:18:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b42d1caso31644135ad.0; 
 Mon, 03 Jun 2024 04:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413497; x=1718018297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okL/u9Yr4I1gdpYP+OUmz0dGlxU1P8AIMDXGmwEB0cY=;
 b=DmNQcPw9JMc7Zjf7bAm5ShfxecBWkiYyYza9zBgBdRvtz7PAC+cCEDAoOacwLEs5PW
 aq2ClBxCBRDQUymOJZP+Cd1U52/BqgdY25nDtbFgd6G7iT5Dc8n1ySIQsZR0uUS83HT6
 MDlxxsLW1aBmp75EE9BqQpSZqhkzPo9JG8UGXHPBQ4KWOf1Yeu4m/DJGhgC5M15BkHh0
 HWBWEzxkJDi9Dhi/MClpEWy1HYcg2615skm0lz5R7Fc9i1xg/IQwveT/a7RR0TWw/n0e
 QiY8jlko/yyxlJkuv+WtAQdvgAowZtLzxp4LEGCrvoZECd2+Fopy2hgxND/cDA/s2d3C
 gycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413497; x=1718018297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okL/u9Yr4I1gdpYP+OUmz0dGlxU1P8AIMDXGmwEB0cY=;
 b=tPxO6NMFRyIEEOheYw9xKzhmw5xNf9taeWiE6qRNp6DnDjDtmNrwleF0EcAt/8Cleg
 kcla8pGZQ8aVL3ajmLOl77Rhp7NGGW/lMzCQ6ivJ7rYpthZwSD4rbOGMB3gHCnh4xvKU
 ceornvnP94BJZQO9LPWez/qkwdbiyPd8ejCByYVxUA8gF2RgLUMVhdhep/hLPFrQAcYB
 J63Mqb1tKRH9PQvr6NA76M6Ufwrvvy9zSqQ8ztOskr4XIWnBnFiUmnmuz/P2RwXoW5Sz
 /rfqNotYWdBS658+npnkynHXBkW3GR5QGHabk5RJU+hmFWjiuFw04c8TY3faJl9Pbbrp
 TKRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW36U3uFmwywMM8Wmcc5qYo5vcscijERMwLG/4W1piFxAAHmfBVUj+4sPeCi1GZIZpM63uRIuyos1viQKNZLbkcahDhL7uK
X-Gm-Message-State: AOJu0YzOec6wxoNraNpVuiDkCXaThfn1QMKEQ2BtREPQgLJtO+ibouiT
 XJ/bY/g8uuj6nI7qiMfGWFQtmJlne8JvUqR/AE//JDqkXBX2FInNqHTPXQ==
X-Google-Smtp-Source: AGHT+IEwm17AaeWkVnSCEdgpsmu7Zlp9BB/vFh3ccCz8f25QhWn3K+LpdbcBjyy38V5B8kMNRoZEgw==
X-Received: by 2002:a17:902:da86:b0:1f6:8dc8:184d with SMTP id
 d9443c01a7336-1f68dc81aeemr2121805ad.23.1717413496938; 
 Mon, 03 Jun 2024 04:18:16 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:18:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 25/27] target/riscv/kvm.c: Fix the hart bit setting of AIA
Date: Mon,  3 Jun 2024 21:16:41 +1000
Message-ID: <20240603111643.258712-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

In AIA spec, each hart (or each hart within a group) has a unique hart
number to locate the memory pages of interrupt files in the address
space. The number of bits required to represent any hart number is equal
to ceil(log2(hmax + 1)), where hmax is the largest hart number among
groups.

However, if the largest hart number among groups is a power of 2, QEMU
will pass an inaccurate hart-index-bit setting to Linux. For example, when
the guest OS has 4 harts, only ceil(log2(3 + 1)) = 2 bits are sufficient
to represent 4 harts, but we passes 3 to Linux. The code needs to be
updated to ensure accurate hart-index-bit settings.

Additionally, a Linux patch[1] is necessary to correctly recover the hart
index when the guest OS has only 1 hart, where the hart-index-bit is 0.

[1] https://lore.kernel.org/lkml/20240415064905.25184-1-yongxuan.wang@sifive.com/t/

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240515091129.28116-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 473416649f..235e2cdaca 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1777,7 +1777,14 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
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
2.45.1


