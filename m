Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED792C5AD2C
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsaWm-0007ZR-Ks; Sat, 08 Aug 2026 02:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaWl-0007Xc-Hl; Sat, 08 Aug 2026 02:27:27 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaWj-0003Xc-Kj; Sat, 08 Aug 2026 02:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Pb
 dEA+vhnpl2VJ+/raJBghDAObRHN0ghtfyjioFhu/s=; b=jgJca9ND88jPzPPzQv
 /JHM/DGtw/kNQO1oyzkOJkur3UrZBzS6qG90jGDqxxzk1qdGIJ23O3Wt2IA2NDm/
 wl2uXk8uh32jFi5gRjMdjRFI+BWUnmLQi9wKUyAbpDLPODjZfOssjOh9+xIP6dHM
 T3SOHTFjp46ZYjCE+u3EmXgeA=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgC3_wsky3Zq2MzjLw--.10202S9;
 Sat, 08 Aug 2026 14:22:38 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v3 7/7] hw/riscv: k230: add a noc stub region in K230 board
Date: Sat,  8 Aug 2026 14:22:27 +0800
Message-ID: <20260808062227.66961-8-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808062227.66961-1-dingtao0430@163.com>
References: <20260808062227.66961-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgC3_wsky3Zq2MzjLw--.10202S9
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4xAFWrCr13Ar48Zry5Arb_yoWfKwc_Cr
 18uwn7uFWUCayIyFs8ua1rZrZ0k3yxZ3yktF42qrn5W3ZrZ34DWFZ7KrWDWr4Uuay2yF93
 ZFsruFZxtr1IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuXdjtUUUUU==
X-Originating-IP: [101.204.17.203]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4Q42dGp2yy6XIQAA3i
Received-SPF: pass client-ip=117.135.210.4; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The NOC address was accessed in the k230_unzip driver, but it is currently not in k230.
This commit uses create_unimplemented_device to preset the region.

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Junze Cao <caojunze424@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/k230.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 7fd1ec4c25..ff834d6724 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -234,6 +234,9 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&s->decomp_gzip), i));
     }
 
+    /* Noc stub, the k230 decomp_gzip driver in uboot will access this region */
+    create_unimplemented_device("noc-stub", 0x91302000, 0x1000);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
-- 
2.43.0


