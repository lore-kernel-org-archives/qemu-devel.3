Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A96EC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNhq-0003Ge-ST; Mon, 27 Jul 2026 11:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1woNhp-0003GL-1h; Mon, 27 Jul 2026 11:57:29 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1woNhm-0006LU-EX; Mon, 27 Jul 2026 11:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2F
 XGlexUjp3rmMW8yjmTyo1Xxm+AZE4UUZylNvp3/dU=; b=lBJXKNyICDVzf2RM1E
 zN3WVcD1wVylnqUkUTjY5wVrUHRM4nGc2U2wENaxwgajuad3yBM+rRX2SbVg016P
 vnUgRF6oX5CEYwgtk75dVcOeqToqO3aaRClhMqVM7iwjTVvZT3ply9KeiKqQZFdl
 kPd1qazCLNrATond+zVLyk/Ps=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wC3HpHQf2dqJpF_Kw--.27173S9; 
 Mon, 27 Jul 2026 23:57:08 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 7/7] hw/riscv: k230: add a noc stub region in K230 board
Date: Mon, 27 Jul 2026 23:57:02 +0800
Message-ID: <20260727155702.36484-8-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727155702.36484-1-dingtao0430@163.com>
References: <20260727155702.36484-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3HpHQf2dqJpF_Kw--.27173S9
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4xAFWrCr13Ar48Zry5Arb_yoWfWrX_Cr
 y8uwn7WFW8CFWSkFZ8ua1rZrs09397X3y8tr42qrn5W3W7Z34DGFZ7trWDWr4UZayjkF93
 ZFsruFZxtr1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZCzutUUUUU==
X-Originating-IP: [119.4.23.14]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-hSJx2pnf9QPxgAA3L
Received-SPF: pass client-ip=220.197.31.4; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


