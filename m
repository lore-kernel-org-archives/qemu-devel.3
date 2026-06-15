Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7D4CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7W-0003cY-Na; Mon, 15 Jun 2026 15:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD63-0002Ow-6r
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD5z-0001AP-2R
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxOms781835
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yzn3qiSePtn
 w0NdxwaJmJsTzmyovlVn+lcKr9UC3cRU=; b=cEL5k2kBNFMMHWle+V8KeIoyMu6
 +oW7+ztlHjRGfuY9RxsB8xT6RRyDXYFMCW3+FBQKL6rvrJ6LaPMA7Jkb43FF2WU2
 l2P9ZirRNri3qj7HmtF+EufdAfJURAefKeKvk8S47Y9Tr8gO2L/0+khBi3OAU8hR
 RB+etZqHDBM2yOmAdPwTPv+snFoeVfz4iZN4xRdvtBL34IZkYye1mtuncgHR1dei
 6NOJ1npZeiy67beXkPvJsliMB4ZxB9ObSpbIh6iJiLOkObtnyIiUTmwZM0ejXANr
 yaDd0T56G6mHClU6ye6REw3rjEqDgWVQNMpwB1JkwRGNWinEvZti7KgCAWg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjtnqs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:37 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso3914753c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552137; x=1782156937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzn3qiSePtnw0NdxwaJmJsTzmyovlVn+lcKr9UC3cRU=;
 b=IbyM+saULMr9VY7OXtxqD2OZz0cDmjrs3jCEBvjGDp4qezqb1LjmMRiCwSyDkjfl7i
 ZAGgyQitRLs83yuZekluJYQ0D/gJLYkFxRWTy5aGom8pKPRw50dt9hXmAzZnyKx3Pvrf
 tk9sr1YfF7oKqp1HQrNkh/IGfortYU64AkytWUG6W8L66z7SumyLXXhmj9qbm+BpPeS6
 MFtAzUdAVZ0FUn6cSDZHvrAjbqscP0il44uNu+NsSu8jQPySf3f+K01gN6rU7hwKlmi0
 Rg8EwMP3dDm98ljZKz1gWNgZ0Fhh483ZMbS27/kpqF6Nf7DUQQFPuphjj9cHA9T9zMH2
 w83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552137; x=1782156937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzn3qiSePtnw0NdxwaJmJsTzmyovlVn+lcKr9UC3cRU=;
 b=Qizxj1h8AgRDDZscbJbFv3/Y4iAEaWDXeWYRaueqT5bYrhSarOXM5kQkd4kC/SQPD8
 6lfCm2beDE9aUpKrlUQE8/lbygmMniMI5TW9d1EpnpVs9MZkPLVVknMxoBTPcbhJpIlW
 2F9B/vcYzvAhXxWemxYIj74Q1wzv1vKOZcdY/YOFQ+R+7aHnyekxa26IP7kzGnMOBs1X
 /1Ge4mhh6VwrMviHi4SnKBZ9lq5G42KLcBrKyY0oG9U/76Vk0I336lu0eiQKdukHCn0h
 SslNW8sHnqpHpELYq3HMILuS2CaA+IXsLJNK1gTkQo01Q0mbF0/ky5H02iYjlLfB0mNt
 dDuA==
X-Gm-Message-State: AOJu0Ywz0tLVdYWgkktWbTUfNL2UKwOWfGQStOzJjSKGRIzBOnGpa+jV
 VCQEoVgs3iPYYQKlUT9wHsmU2NC7r4AAjyK+mwZyFlONXD5+9CsxlhPykTBkJeVfdbwROIGgPgO
 8CkVoe3qk9uW3weGDAQdfXQuyfbL799z+I3z2Ii0WunXk9Lj0h1pt4Z9d7LfFukDoZorw
X-Gm-Gg: Acq92OH8a9vns1u+cMVqPVFJeVBX3ltai9EIzfrOCOBOAVIp34Sx7V+xyJK0Nyi9HPM
 TK23V5FvEIt4a8DBGlSoWKtbUAxmJKfVu4qouPFtOphxfHQVi5f+SWQ81B8ArC9SQ7wLZt/0Yj1
 HMFAdK0xSfjNDHPqri24z3hlLJOWLdPbh6UorZXbdRlI+o1HHnQ0SUWYHACZxCRH6Y7XckHMx6m
 Psx1F9rQW1IQn55kWTOYOBTMRRNGQ6aUl8fz8tfRv426mXRntDBV+/NpofTJVKUA9BssgfxskVQ
 2/kcRoB7rudY5FdwYiywcK1aphR7ZVwVA9bCnECSwdrP4fSYTIGTZ2wfw0UYzj2+BANyXfIqxfK
 nk/IhdFQWpY+aebN6WevHeztOo4JdIP4xJFWoqyYnrkokG8XOoAqAO9eBSPEFOJ6+jRS37GLR4x
 1mDh3/9w==
X-Received: by 2002:a05:7022:608:b0:128:d577:dc21 with SMTP id
 a92af1059eb24-13985ebb2ccmr250616c88.13.1781552136814; 
 Mon, 15 Jun 2026 12:35:36 -0700 (PDT)
X-Received: by 2002:a05:7022:608:b0:128:d577:dc21 with SMTP id
 a92af1059eb24-13985ebb2ccmr250603c88.13.1781552136241; 
 Mon, 15 Jun 2026 12:35:36 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 06/26] plugins: remove qemu_plugin_id_t from
 qemu_plugin_vcpu_simple_cb_t
Date: Mon, 15 Jun 2026 12:35:05 -0700
Message-ID: <20260615193526.2883349-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXy3YKnyI2PqMp
 OLYWKAKSHvw7O+ZFUfHe2xjL3lja44EH8VCYyeHJMlGK1xTXnDQsETqWanrxmIwBlgB++Ix7RAh
 EM7+0m8ixgjgk/NIgZlEzT7OBKQbF5+/29kUgrK1/jrOGLW1gip0+2VkngdSabBxvlMc1aTbG1I
 y0Gi0TFahKvdv6Je/OXHJFjCBWARSb+3CGZo+Bp+eO839P3S2u9ZCUAQ58y4wwPqaYz8Mx1rE9f
 a9x2o3UvMPR2DZw3CX/6fWE0KUmVj8mUcAijlNaaXouzIRgvo86/1BnjOiIoyHpgjwRfuwHVxgj
 QhNnhD5rSc4Da2DmP9XErP232eFBSdj9HDbp8h3qA6ctRlpQP+rP2HS4R4STSmhMkdOW4KGvJt9
 LcdMwfVLuUyPHenOFCApllITXJt6l9D305ZX4qcvH6BFcFZ3jwprdI4643h1jDx7etqVqUQKtpP
 LkZByn+VTTfAc0hGgWw==
X-Proofpoint-ORIG-GUID: xEckL9qgg3Z16lOlt9kJG7LpQKuqgh7y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXzyCEUTrIKwC1
 Mt46BPozhfRpulFnpenLtWQbO8LhtqElmaU6rpCcgoVEwE9Nm7S2jWWpFNXI3m8XQmvKan5GBbx
 qr/Ej5b0OBboAMfMLK8hDi0IY+0USUc=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a305409 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=mDV3o1hIAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rXe6YV4CopgQa2I4tT4A:9
 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xEckL9qgg3Z16lOlt9kJG7LpQKuqgh7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Not used in all our plugins.
Future commits will remove qemu_plugin_vcpu_simple_cb_t completely, and
replace it with qemu_plugin_vcpu_udata_cb_t, so id information can be
passed using userdata if needed.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/bbv.c         | 2 +-
 contrib/plugins/execlog.c     | 2 +-
 contrib/plugins/ips.c         | 4 ++--
 contrib/plugins/uftrace.c     | 2 +-
 include/plugins/qemu-plugin.h | 4 +---
 plugins/core.c                | 6 ++----
 tests/tcg/plugins/bb.c        | 2 +-
 tests/tcg/plugins/insn.c      | 2 +-
 tests/tcg/plugins/registers.c | 2 +-
 9 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index f2b1b258a90..72cc896a0a6 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -60,7 +60,7 @@ static qemu_plugin_u64 bb_count_u64(Bb *bb)
     return qemu_plugin_scoreboard_u64(bb->count);
 }
 
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index)
 {
     g_autofree gchar *vcpu_filename = NULL;
     Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index d347ac25b6f..398aa4a1f3f 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -382,7 +382,7 @@ static GPtrArray *registers_init(int vcpu_index)
  * As we could have multiple threads trying to do this we need to
  * serialise the expansion under a lock.
  */
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index)
 {
     CPU *c;
 
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 7614ae1eafd..32fd86c87ac 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -89,7 +89,7 @@ static void update_system_time(vCPUTime *vcpu)
     g_mutex_unlock(&global_state_lock);
 }
 
-static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
+static void vcpu_init(unsigned int cpu_index)
 {
     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
     vcpu->total_insn = 0;
@@ -97,7 +97,7 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
     vcpu->last_quantum_time = now_ns();
 }
 
-static void vcpu_exit(qemu_plugin_id_t id, unsigned int cpu_index)
+static void vcpu_exit(unsigned int cpu_index)
 {
     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
     update_system_time(vcpu);
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index a071a34ea75..438cebf2831 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -874,7 +874,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     cpu->ops = arch_ops;
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d7d972103cb..8aaf404504b 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -149,11 +149,9 @@ typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_simple_cb_t - vcpu callback
- * @id: the unique qemu_plugin_id_t
  * @vcpu_index: the current vcpu context
  */
-typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
-                                             unsigned int vcpu_index);
+typedef void (*qemu_plugin_vcpu_simple_cb_t)(unsigned int vcpu_index);
 
 /**
  * typedef qemu_plugin_vcpu_udata_cb_t - vcpu callback
diff --git a/plugins/core.c b/plugins/core.c
index b0532e8d0de..217d6608c1d 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -96,8 +96,7 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
-
-            func(cb->ctx->id, cpu->cpu_index);
+            func(cpu->cpu_index);
         }
         break;
     default:
@@ -306,8 +305,7 @@ static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
 {
     struct plugin_for_each_args *args = udata;
     int cpu_index = *(int *)k;
-
-    args->cb(args->ctx->id, cpu_index);
+    args->cb(cpu_index);
 }
 
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index 8a854408aaa..f29b466dab2 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -56,7 +56,7 @@ static void plugin_exit(void *p)
     qemu_plugin_scoreboard_free(counts);
 }
 
-static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
+static void vcpu_idle(unsigned int cpu_index)
 {
     CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
     g_autoptr(GString) report = g_string_new("");
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 12421054f67..80f7cbb2967 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -84,7 +84,7 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
 /*
  * Initialise a new vcpu with reading the register list
  */
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index)
 {
     g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
     g_autoptr(GByteArray) reg_value = g_byte_array_new();
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
index 6d627c70371..94776d887fe 100644
--- a/tests/tcg/plugins/registers.c
+++ b/tests/tcg/plugins/registers.c
@@ -21,7 +21,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
  * registers that cannot be written to, which would fail the test.
  * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
  */
-static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init_cb(unsigned int vcpu_index)
 {
     g_autoptr(GArray) regs = qemu_plugin_get_registers();
     g_assert(regs != NULL);
-- 
2.43.0


