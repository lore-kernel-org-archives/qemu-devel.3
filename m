Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B08CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjN-0006Rq-55; Tue, 16 Jun 2026 06:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjA-000638-Kf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:09 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQj9-0003mr-7a
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:04 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36b8d414666so2695966a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604541; x=1782209341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywv1Eitj0Dtkzkc45YArwuUkBcmzxPNgkwxhdE319cA=;
 b=MmbD1sq/ZzMjIrwFVAXIrghP2gxsA3VxHcaLNSSQ48SM6JrGaJDT4GOwp7xhkpxWmg
 B6PzZdFUTOh0auMlLee5fspN28l75esdJmk6GBkFqRvpmUWptSDHYLM3RaEL7rIM7AXR
 vOctPfmzHNBSRtzMjF6anOcKwDFjBH4KjoNpUlZKgY3VhHndwrCEUYiW1t4yyfk+x2UJ
 bUN0bNbUjQwYaIiUll5r4d7ZiiYU6RS4Xgo53CzHl0Buziq3MQcYkUMhDCFSP2auzuhJ
 Ash3uhhHUtc3ykGkmQ0NVlcuXA0RAT6W0XWmk89lYyqeHxrqhcMqrg7+0Llaiso+kk4K
 2+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604541; x=1782209341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ywv1Eitj0Dtkzkc45YArwuUkBcmzxPNgkwxhdE319cA=;
 b=MgSIvQNEpBztxov6WR4SWnlpXt/SaIC9vuoRu3sDLFR974BCyIBI+yxaolTIoiRYmf
 YwgTDvOjUCv7PcBhVMPndfIE6t8UQ82+GeIpflUsca8j0qZis3wCDSAFeT5aW3JWQJ1B
 untuvKYLF/fYziBUxiQCKoghPamXPWJT9rMi7uiD5Zfu7sHFfpcHh9bN+YdygRVN9SBv
 JvsM0OaLY6r3GFEYbVZRmwSV5PP+/lvbJNgLm5vVMkOr4ZWdPQLGLukAIwajkFhmaN7G
 QL+Ng2MUuSKvz0yMIYrravR4iiKHAkv1hrtDmZ4tBuUkOjtZPCbeDwonMWMxCzfAOMWR
 xuww==
X-Gm-Message-State: AOJu0YyHCkPJADpeTuprubKcCkkpLP7mxiRR7GV+SYLdJNQ4/QQ7CKCL
 QxfsMCpNHcWWzmIe5bwLS9fwzdd1kHfskPQHT7mLoN8w7atqGZMBFz0+TZTzKsgV
X-Gm-Gg: Acq92OHE1ROuvgMFRaPjTnllAy+Ow/it4ual3fwO9acygk3cPQjjUq7FapGS1yjrhvz
 84qKnOkGzNnbS6b5iNC9YH5Cquvak5as8HlE2raTgsODqktV2iCW0AY8mPDj4BczgmffK9JToBG
 Qp82SaKzoM4so4Yv4w1Yyqjw73Z060JHKJ0zmd7aw8OW5KzpWy+djXMX6BCUTTaohZZ/n20pe/g
 DbTJ9RrePLKDZzOHdPF60AERjTSc9qyU2rVOYt45DceG6Px29CjNRXuj2JcGVqEEbi1tm6DFbpv
 +7dj0fxtkoEgmQxueuGrD1ELElds6yVcdyLojTUd/ndYnzfQ9oWvoRTrZn+yamnBBdQSYBVdM9P
 es2spI+q3wX14S3Z/y9AmwDstlaqfrIJZ9KlpI81aBOfJTl3BaPDiLHq63dKba2cCEqUk9dnmh6
 +02TBjAHhhRBcyAshLLg6fTjikG9QKNZwlU+JGvhh0
X-Received: by 2002:a17:90b:3c02:b0:366:3517:1a95 with SMTP id
 98e67ed59e1d1-37c52203244mr3286798a91.0.1781604541265; 
 Tue, 16 Jun 2026 03:09:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Xuemei Liu <liu.xuemei1@zte.com.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 59/83] hw/riscv/numa.c: Supplement cpu topology arguments
Date: Tue, 16 Jun 2026 20:05:02 +1000
Message-ID: <20260616100527.1939565-60-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260529181848378wiq8pXCmbwAZR5_-wZFJd@zte.com.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


