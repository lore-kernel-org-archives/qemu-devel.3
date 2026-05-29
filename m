Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6360ECD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuJ0-0007z5-ON; Fri, 29 May 2026 06:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wSuIz-0007yt-Iy; Fri, 29 May 2026 06:19:05 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wSuIx-0001wz-7Z; Fri, 29 May 2026 06:19:05 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gRfTV5pzXz5B100;
 Fri, 29 May 2026 18:18:54 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
 by mse-fl2.zte.com.cn with SMTP id 64TAIjJX060163;
 Fri, 29 May 2026 18:18:46 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Fri, 29 May 2026 18:18:48 +0800 (CST)
X-Zmail-TransId: 2afa6a196808cdc-4c8b2
X-Mailer: Zmail v1.0
Message-ID: <20260529181848378wiq8pXCmbwAZR5_-wZFJd@zte.com.cn>
Date: Fri, 29 May 2026 18:18:48 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIXSBody9yaXNjdi9udW1hLmM6IFN1cHBsZW1lbnQgY3B1IHRvcG9sb2d5IGFyZ3VtZW50cw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 64TAIjJX060163
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 29 May 2026 18:18:54 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A19680E.001/4gRfTV5pzXz5B100
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Supplement RISC-V cpu topology arguments, including support socket
cluster and threads per core.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 hw/riscv/numa.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index 24a803f7fa..8a144925c1 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -239,8 +239,18 @@ const CPUArchIdList *riscv_numa_possible_cpu_arch_ids(MachineState *ms)
     for (n = 0; n < ms->possible_cpus->len; n++) {
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
         ms->possible_cpus->cpus[n].arch_id = n;
+        ms->possible_cpus->cpus[n].props.has_socket_id = true;
+        ms->possible_cpus->cpus[n].props.socket_id =
+            n / (ms->smp.clusters * ms->smp.cores * ms->smp.threads);
+        ms->possible_cpus->cpus[n].props.has_cluster_id = true;
+        ms->possible_cpus->cpus[n].props.cluster_id =
+            (n / (ms->smp.cores * ms->smp.threads)) % ms->smp.clusters;
         ms->possible_cpus->cpus[n].props.has_core_id = true;
-        ms->possible_cpus->cpus[n].props.core_id = n;
+        ms->possible_cpus->cpus[n].props.core_id =
+            (n / ms->smp.threads) % ms->smp.cores;
+        ms->possible_cpus->cpus[n].props.has_thread_id = true;
+        ms->possible_cpus->cpus[n].props.thread_id =
+            n % ms->smp.threads;
     }

     return ms->possible_cpus;
-- 
2.27.0

