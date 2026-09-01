Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FC1C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1U9G-0003Au-C2; Tue, 01 Sep 2026 15:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1x1U9B-0003AN-Sr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:27:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1x1U99-00081a-Va
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:27:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgZAS3737592
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 19:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=GSa9ZNLhw19JRHSn3oFYZNIAIjfRQiGZbcC
 SeH5hYl4=; b=VkkaXHru4nAlfbDBCsHqgcABfl3n+r3uz8V6JJxBTpyFKSQyh7t
 A2KbF12Ho9Ph8xBNMgzwsFq4kBJJSHU+lQ1aZAHCZCRCqPAsOhuI7/dC+2DVCz6o
 +aIryypbpyQBFvNVoRpvfDaso0sLdbEGifK7U6lXmq2JFA09F2YTdOKryKhtXbvr
 EkJ04s9Aq0kJ/rq2O7oECFgAXSFoWtslB3SowowIXkng440Zd0zPAE5Pz3ZMCEqm
 qZPtG9+Z2kp4EyrqCDO1Y2mCtv5dFA4yxPoa1mLKqBv5OEGFKAkcJ7NZRrd7yY0n
 +Vw1W4de5qOx//bDy+0LeFK+CufkmcHU0Pw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt1rch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 19:27:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so319705a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788290866; x=1788895666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GSa9ZNLhw19JRHSn3oFYZNIAIjfRQiGZbcCSeH5hYl4=;
 b=IL5Jz0wuzpbeiFQ9vG7LuClT+NImhFK42hRNXnpQ0QE7Eo884dbpCHeg0KG8epFbo3
 hx1yIMRPrlcT4JG0s4JkpH1iBEt+Ow49DojHZu9zj7BJeRxW+CsDHAkMxHzF+6IxAIeG
 +od28x9ooKJ8jKdoaUC4F51RRq2QO2F4hWLlw83CUlLLGu7XI0G3joADKPKL1mJVDD7w
 JNoqwerQFGI3XokcAINfGEtmq83S2m8iijPeyEtywcm87UOuaP6qHn7eIEOujah0HYA9
 QHIrSzfppjGkwS/qesRWwZGflaviyQxer7ujXTG/GRmrDMCXdKgPnBT2riwFlshRUFxu
 SC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788290866; x=1788895666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GSa9ZNLhw19JRHSn3oFYZNIAIjfRQiGZbcCSeH5hYl4=;
 b=by7XSlKh0fFezLfgTjcjeMjzzQl4ZG4s6+U9KjXNKd9XKgFbCUt33BlYqKPXk4OGSb
 tBBhlz+JTplQ442FUushlmenfaO2ecn25W20eHc0/ITjZsHRGlODzzhjIzd2Ol7Ki8s6
 r4F60FesEMPdb47XQuVcrGG0mEx853+oxcML1OWBS+ftWY4poRi5TUG2uBYlRkCWz25H
 qjSgSD0WL22aIzoRCgOwx7v+heX4aY1JZxs5pvAe+XjyaUj+gTkC0Xn5kNIiGc6y6gvq
 vQQh0o/l3AIfdh3Bx3toa2WHc6CSYqhDaJMiL6nzvCRtKrDu0ZKkMEKPZQOlyIu8TR2v
 aMXA==
X-Gm-Message-State: AFuF++luGuy09bjMFUJccMgdYMKFj1X/uOUf3w5WTSeF8l34wPu8fEz/
 CNkTdejKGw6MRKn6C8afyFqvukpGHwQmCxt0Z39sxvr8u0wKSLOZi6mEJn4gDaMXyGnoGEudln8
 4ohLiZGYkbPR9hphbJKVX/uP2LePTag2IdJhwNKOpFUpUAzUrDSdgDzkQKkPH1/bafQ==
X-Gm-Gg: AYBFou031k2l6Yl3M3mtlNeTnU11FY1NUQaj5PoR2LD8T5NoalfCxJVY9vwFSFsrPr9
 rlmnBWdKddo17tjMs2dT41yXpzUoUF5a0k+NgKlK1kOSfNg+w/4mDBcCmJJvYhYDmn3noxd4n+i
 eJd1NZx0xf79DEfSiS27Jrrdrwl/CafA0VzMHOtT+/mPmd5kiVDYkocQoNleLjLcMyfnHzR+XBw
 m1CFtAWWDSyFHS8WewWMuCsSwCh0RemuhU+RnKLTH4nHxr/d1Rn5o5L5LEj1m/W+QgOOiuttzYI
 ZXFkchVO/2DNETIZ9fR8JwL2Ov7JzQwHJqzonbKzF4YKAlI3wPM/p/RKN+Ab+icTJn2VHv+9Ddb
 D4lQdj0tZPKRvbZiQZoGR1yuaNFruiPw4OPGLV6YYmNklvS9atUUzqxBbY9rQ4iM=
X-Received: by 2002:a17:90a:10c9:b0:39a:e002:f192 with SMTP id
 98e67ed59e1d1-39ae00301efmr2375567a91.22.1788290865962; 
 Tue, 01 Sep 2026 12:27:45 -0700 (PDT)
X-Received: by 2002:a17:90a:10c9:b0:39a:e002:f192 with SMTP id
 98e67ed59e1d1-39ae00301efmr2375509a91.22.1788290865373; 
 Tue, 01 Sep 2026 12:27:45 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430e9eb4dasm1040240c88.2.2026.09.01.12.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:27:45 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH] target/hexagon: add OPEN/READ/CLOSE DIR semihosting operations
Date: Tue,  1 Sep 2026 12:27:43 -0700
Message-Id: <c186b1bbca79df01c96ffb1f21e1dadf83e01698.1788290677.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3MSBTYWx0ZWRfX4s1ngNRmXOZi
 WuTSe6AV9aPHeDdAuJwEDq5jaXFeZLJtl54Q234dKM+kw6AEbyMkFi6vYj6FD8VYk0WPAK01Xfd
 JcoTEXprrKYoH8dVrvFJF3E+MVfidfZY8fJL8TPr90t+y5nkdAp6DtHBWsIuI98cFHgN0RC2FTZ
 3+aGzxtCAAm/yDmvTBrs343S5MZcyuQ21QGFY4A1nZUQIg5ahtGKowOun/gsyXkvDWlr0RHzKMT
 kNqzsXPqxWWDMbrHdADAqea2DuYhvlOLLPhqGuRUdTmu1l+G9t5oDM/VwrVqBmiAZZ//Y85iyr4
 hx4aVAduCL3Eqxy0hHlthM8ARUKkgVYrShdfhELj2/i9QQDjMoxaQoIGLkDWrszdAUBInRGMxSk
 l/H1A1f8aEmaDB2/dhsExWYen7bMTtVEqMaxBaNJ3HY+KRRd5+gBYNAg0IiPvproToGk8L+cgF3
 AIimZQEnimF/Um0ZUAA==
X-Proofpoint-ORIG-GUID: wIOxMj3TdfrhmEPrTDJ6E8-WNe7KBuQd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3MSBTYWx0ZWRfX5Di76wg2yDHb
 9hLqBGdpr/QpiXdMpB+MYfZctJDZoayVKeMoknXCHV8kOlF8fhuYwRqTw/25a5b49cgbNPL1i6p
 f0P9mFoPzxOcd0OHPODuDCG86yvPbxk=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a972733 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZqwpFZGFjbu7oiqBlvAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: wIOxMj3TdfrhmEPrTDJ6E8-WNe7KBuQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010171
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Baremetal Hexagon programs use semihosting to enumerate host
directories via OPENDIR, READDIR, and CLOSEDIR calls. The list of
open directory handles are global to all CPUs, so that guest
index values map back to host DIR pointers across calls.

Also add functional tests for the new semihosting ops.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---

Note: based on https://lore.kernel.org/qemu-devel/cover.1787586642.git.matheus.bernardino@oss.qualcomm.com/
The added test was verified on Ubuntu x86-64, Debian PowerPC
(big-endian) and Windows.

 hw/hexagon/hexagon_dsp.c                  |  7 ++
 hw/hexagon/virt.c                         |  7 ++
 target/hexagon/cpu.h                      |  1 +
 target/hexagon/hexswi.c                   | 83 +++++++++++++++++++++++
 tests/functional/hexagon/test_systests.py |  9 +++
 5 files changed, 107 insertions(+)

diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index 2198436a44..4c6aad886e 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -141,6 +141,13 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
 
     for (int i = 0; i < machine->smp.cpus; i++) {
         hex_subsys_realize_cpu(hms, DEVICE(cpus[i]), (i == 0));
+        CPUHexagonState *env = &cpus[i]->env;
+        if (i == 0) {
+            env->g_dir_list = g_malloc0(sizeof(GList *));
+        } else {
+            CPUHexagonState *env0 = cpu_env(qemu_get_cpu(0));
+            env->g_dir_list = env0->g_dir_list;
+        }
     }
 }
 
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 64d8366d27..3b6a072c00 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -344,6 +344,13 @@ static void virt_init(MachineState *ms)
 
     for (int i = 0; i < ms->smp.cpus; i++) {
         hex_subsys_realize_cpu(&vms->parent_obj, DEVICE(cpus[i]), (i == 0));
+        CPUHexagonState *env = &cpus[i]->env;
+        if (i == 0) {
+            env->g_dir_list = g_malloc0(sizeof(GList *));
+        } else {
+            CPUHexagonState *env0 = cpu_env(qemu_get_cpu(0));
+            env->g_dir_list = env0->g_dir_list;
+        }
     }
 
     fdt_add_cpu_nodes(vms);
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index c50fbb3f72..fd2cb96cd2 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -145,6 +145,7 @@ typedef struct CPUArchState {
     uint32_t tlb_lock_count;
     uint32_t k0_lock_count;
     uint64_t t_cycle_count;
+    GList **g_dir_list;
 #endif
     uint32_t next_PC;
     target_ulong new_value_usr;
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index a50ab22554..cb2a289dd5 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -30,6 +30,9 @@
 #include "semihosting/guestfd.h"
 #include "system/runstate.h"
 
+/* We start from 1 as 0 is used to signal an error from opendir() */
+static const int DIR_INDEX_OFFSET = 1;
+
 /* non-arm-compatible semihosting calls */
 #define HEXAGON_SPECIFIC_SWI_FLAGS \
     DEF_SWI_FLAG(OPEN,             0x01) \
@@ -644,6 +647,86 @@ static void sim_handle_trap0(CPUHexagonState *env)
     }
     break;
 
+    case HEX_SYS_OPENDIR:
+    {
+        DIR *dir;
+        char buf[BUFSIZ];
+        int rc = 0, err = 0;
+        int i = 0;
+
+        do {
+            hexagon_read_memory(env, swi_info + i, 1, &buf[i], retaddr);
+            i++;
+        } while ((i < BUFSIZ) && buf[i - 1]);
+
+        if (buf[i - 1]) {
+            err = ENAMETOOLONG;
+        } else {
+            dir = opendir(buf);
+            if (dir != NULL) {
+                *env->g_dir_list = g_list_append(*env->g_dir_list, dir);
+                rc = g_list_index(*env->g_dir_list, dir) + DIR_INDEX_OFFSET;
+            } else {
+                err = errno;
+            }
+        }
+        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
+        break;
+    }
+
+    case HEX_SYS_READDIR:
+    {
+        struct dirent *host_dir_entry = NULL;
+        int dir_index = swi_info - DIR_INDEX_OFFSET;
+        DIR *dir = g_list_nth_data(*env->g_dir_list, dir_index);
+        uint32_t rc = 0, err = 0;
+
+        if (dir) {
+            errno = 0;
+            host_dir_entry = readdir(dir);
+            if (host_dir_entry == NULL) {
+                err = errno;
+            }
+        } else {
+            err = EBADF;
+        }
+
+        if (host_dir_entry) {
+            uint32_t guest_dir_entry = env->gpr[HEX_REG_R02];
+            hexagon_write_memory(env, guest_dir_entry, 4, host_dir_entry->d_ino,
+                                 retaddr);
+            for (int i = 0; i < sizeof(host_dir_entry->d_name); i++) {
+                hexagon_write_memory(env, guest_dir_entry + 4 + i, 1,
+                                     host_dir_entry->d_name[i], retaddr);
+                if (!host_dir_entry->d_name[i]) {
+                    break;
+                }
+            }
+            rc = guest_dir_entry;
+        }
+        common_semi_cb(cs, rc, err);
+        break;
+    }
+
+    case HEX_SYS_CLOSEDIR:
+    {
+        DIR *dir;
+        int ret = -1, err = 0;
+        int dir_index = swi_info - DIR_INDEX_OFFSET;
+
+        dir = g_list_nth_data(*env->g_dir_list, dir_index);
+        if (dir != NULL) {
+            ret = closedir(dir);
+            if (ret != 0) {
+                err = errno;
+            }
+        } else {
+            err = EBADF;
+        }
+        common_semi_cb(cs, ret, ret == 0 ? 0 : err);
+        break;
+    }
+
     case HEX_SYS_COREDUMP:
         coredump(env);
         break;
diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
index f36e015f50..c354fd20ca 100755
--- a/tests/functional/hexagon/test_systests.py
+++ b/tests/functional/hexagon/test_systests.py
@@ -7,6 +7,7 @@
 import re
 import time
 import unittest
+from pathlib import Path
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
@@ -90,5 +91,13 @@ def test_access(self):
     def test_semihost(self):
         self.run_console_pattern("semihost", "PASS", "-append", "arg1", "arg2")
 
+    def test_dirent(self):
+        testdir = Path(self.scratch_file("_testdir_dirent"))
+        testdir.mkdir()
+        files = [".", "..", "file1", "file2"]
+        for f in files:
+            testdir.joinpath(f).touch()
+        self.run_console_pattern("dirent", " ".join(files), "-append", str(testdir))
+
 if __name__ == "__main__":
     QemuSystemTest.main()
-- 
2.37.2


