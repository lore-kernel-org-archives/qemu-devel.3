Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABC7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Afn-0006U6-Ek; Wed, 15 May 2024 05:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1s7Afl-0006Ti-Vc
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:11:41 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1s7Afk-00043g-8v
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:11:41 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-23e78ef3de7so3399071fac.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715764297; x=1716369097; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kRSr0FPNBS06uaJY90nbU69nqRvDiNbITCiGOUP42c=;
 b=JG4ineVhOdsegYlhF7k5qmJmKYolzDbsqi/Yzkb4jB1t6vv3T3yBsXljY2dfIHCqzy
 i+KaHZQXNLM9G+0nitfWnHX+5basMN4YrLjel7oitIzRnh2y9SMZXcSXYyOboOv0FSnj
 fiw9ul21np9FNk5QQ7Xw4fW0gM5QJN0PT9pfl4azXeEFraPuJPq9ORL4OIJ8sbq3N1EJ
 iuou/lQBe77JRxIE5StNZy4SAHsF0zNvj7xrU0OvtwEUJkmzN+sO3/EW516/2TzVdpnR
 ebILCIqcB1CFi06VeTbwkjb78jrgXyhHSxzFEFxE/Dci616gs4unodOE94dkDSC+up6G
 xuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715764297; x=1716369097;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kRSr0FPNBS06uaJY90nbU69nqRvDiNbITCiGOUP42c=;
 b=OLZ8lxtB9Lj1bHm1XAJpz83egiTQXZEmTiI5itAVWaqllckJN5Shn0DiAveyXmnXDT
 SaahSvILtDVMxT5+P+w9NKze9m3xPqw4m5rWfJY+1Rh0IJ+IzT8HMASHVMz4HuSOf88w
 A8rArduWMVJxFgNNyF5/9SuismQAzeNpsCrd/a60oQqFpRGlbtmjPuFolpysxbX/7OxG
 vMmdW7mfh9xgtA3G4fmJv5qEIqVj4tOoATKXVUIvjaHLhwgvMHzI0ADqUt7bI4UCGDYx
 1o1NGqQgiztWk2XkSOXZAoKxK1uH5WYd4tipNi5nSesxjWYRIm56i07eBd6m7W0tCJFb
 G1Sw==
X-Gm-Message-State: AOJu0YwZI0FCZ+Ic0OwqW6q16I9P8ni4/YTejOcYsO8KInZTnuQqlZjy
 YpK7Rjv2vm/bazoAWibaZgKw9nrhW/hPooY+DHOwOGjPgquYZ3vqOHv8PPCAofTlDLhnbOtKRMb
 YxMtDeV43VbWymgRPQzpnGqoevHVwM0F5fw+Q5FqA+f9oVjnn5Gs5R1VBGiNwxXUcKf0byrqelT
 NEhFwwA7cr5bDyzxXGNCvDohyGhHXX6Jv9V0ykTL+r/g==
X-Google-Smtp-Source: AGHT+IF1k45tw7ROKqxjDefYgXyXuBA6qAPuDaO6Vz4Afc10xIA3hxKVD1P7wsZsoD3U45GQGSVzcA==
X-Received: by 2002:a05:6870:7246:b0:241:98e4:5590 with SMTP id
 586e51a60fabf-24198e4a118mr18307142fac.5.1715764297001; 
 Wed, 15 May 2024 02:11:37 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-654f2660b37sm785026a12.28.2024.05.15.02.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:11:35 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/1] target/riscv/kvm.c: Fix the hart bit setting of AIA
Date: Wed, 15 May 2024 17:11:28 +0800
Message-Id: <20240515091129.28116-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-oa1-x2d.google.com
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
---
Changelog
v2:
- update commit message
---
 target/riscv/kvm/kvm-cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 473416649fda..235e2cdaca1a 100644
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
2.17.1


