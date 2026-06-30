Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80AEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegYO-00047z-4U; Tue, 30 Jun 2026 18:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXi-0002yA-7b
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXf-0003we-EV
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:02:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDj062959559
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2B+Rc9UR1tQQKp1qAJSR+ZDe9AelYqZi3TA+CLAH77Y=; b=ZyURHLKYgpbCxyEG
 n43EpB58fbYAgJa3Mswx259er0K+rjKsnxefV1xxI5MeHkU94stqsS/X3hL1BDaq
 PZ2VWNkj9uwZrT3rbrAkrLcsm6Exx2HadWzNs5TTcO6Ad6jo5kEFHg+DORAztc89
 MDabq6SShqAfskzUW+cCuehzNaLYLuOzJM5xy0XM7rQmCWbZxc9gAdTtQRJjH4pD
 G5x1qtBRzXGjYfsuEMFKkIRz5nsrQbcSvLKL8PWSQzEsStop9NNDmptljhNc7Dr3
 f43ajYGoTDCM244enPtAayASBaCyfJ2yfQ0ETHyPcB53ZZC8sam1jjytxMAkvnOj
 IntEZA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jkt8y3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:43 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-495f94eac1eso59547b6e.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856963; x=1783461763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2B+Rc9UR1tQQKp1qAJSR+ZDe9AelYqZi3TA+CLAH77Y=;
 b=E/1WVFjGeE25IKeymayobV2RsVgJ8ovtC7IAB0pU0kjDQYEieUpsfKRiIZejFfMO9+
 YjVWsNM172UerDW3IM4WgV79hCCrdPBNNB//I9z1zfqMFzoIqaJr3oKWjsVKlXaUi082
 tXa5W9SPFUkGkuvxPwzJq+MSbfScGUzYPMK716CbHkMU05JLKa5NXqvZe7J0VZd7qFWh
 fWW66I+3tz4B61LLQCt914IdNrYjSJY0KhrJB97Ogbw/ZtTNBJ/v6Cw33R5OgYDMWhp1
 WSQ538bM4Xcdh/k6k+Lg08THUPK/pMu4m16k9Z1dJbDzgADHfUgzWEipYmxrX7PhNWl7
 U9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856963; x=1783461763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2B+Rc9UR1tQQKp1qAJSR+ZDe9AelYqZi3TA+CLAH77Y=;
 b=K7J0H+WWtRedRn4USh2qIEC3lv5MjZDY4WBJUn/Awel4+aCs8kn5g4qVO6MTm0PudE
 itBxk9fRS0e5PBBZtZ6mCPVbXiS6hVMNBKG5xxn2jdW6ipSvN7bsGuTAoRkjvjBIgAHo
 iBHGKzJ7zPkFRqdhp6bicZk+Yvx6svNoOENFlRhAsAS4RyC/scsdUagNYdnAEPv1Va9G
 Vyun3yN75TCKyu4Y3U4xFGVDi8n0z6gWOo0cAdM043yncFfezbNIL6cbiZ7yzZhPA6kx
 NNY+73ieWuCpr2sc9IxxXA4vlGjDV6uCUKXh2GgeQIlcHPTYx27m3i39oK4XBSrB9K4L
 GO0A==
X-Gm-Message-State: AOJu0YxoCrcsERPIW/gNPFCUc+G6jp0F3Z7KKZgjiC9uJ/KTgunqZwIx
 0CE2ThML/8UUt5w40OZyeQQnhK4cwBoC73112PWZPvb75Sn3nRz4fV9sRkALb7/++rR5MmOzdiA
 wi7hkmmRfpYhnM56HKH/vA4KXNWY0tcKVuQaFpN8/lHzJleC2zd76JtfoH/z5Iy2VMA==
X-Gm-Gg: AfdE7clSNUl7ZuyIELnS1Q04mF9EhPts98h3vLeiVlQD9Jb3UgXhcv0GzUl6foZlNLz
 w/1qYNTIPKNco4NwjOQ4LNP81dW2IeycbvTm1ID9DqLaSmAFvMD1udre7hs3UMVyxpG8HCs8hng
 lmKxam29cUF4gpw8SbVIon6hl3PgAPaZX0neX6AO8BdPNbiJG3D04xAnJQxQ2CiUqD0zjug7982
 M4x/jxYn5ylv/4mCLX8gKINjBDQ+GFRxPxWT+vf2kFmiCDNIoTtMTspTAqp/W3eS/EjR7tF7yCq
 eHjlkhARli1bU3/Iyr2rnT9PcLP/hq18UfwjulbUTjt1JREwr47u9xPrSLEdltcdDbBhBCcHwnq
 9s40PRX8cZnGym+U5BXLLQLw/zKZyFeGO4qg3WGD+UoyJeJkyl6KuaZZbzKsdwXGhXyhP
X-Received: by 2002:a05:6808:1821:b0:492:7abc:4244 with SMTP id
 5614622812f47-495eadaf2a2mr5364080b6e.14.1782856963118; 
 Tue, 30 Jun 2026 15:02:43 -0700 (PDT)
X-Received: by 2002:a05:6808:1821:b0:492:7abc:4244 with SMTP id
 5614622812f47-495eadaf2a2mr5364027b6e.14.1782856962634; 
 Tue, 30 Jun 2026 15:02:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194b0sm11859962f8f.1.2026.06.30.15.02.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:02:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 13/33] accel: Have get_gdbstub_config() return @can_reverse
 value
Date: Wed,  1 Jul 2026 00:00:40 +0200
Message-ID: <20260630220100.1289-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXybY1veROyTso
 +17w0ncX9mtNlLJju/qdotpOsXIPgAcmLjg0dAVs0RDE2WD++DIgkP1SQjBLJzjdR0smera0i/Q
 r3kKXO187CFbYuXpISEoZf0eBksCzOA=
X-Proofpoint-GUID: gY04QJYiRPY6ghXPhSifC_moil8WjHaG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX8WDro4W3cSI1
 oHqIy90imp/B4fBAuDnCLHQeTOFrIZDZ9uoNcJ5EPt33gl1JlXJbd1hLaeOxeCnYAynu3v4Xr9c
 TbL80EsZ6bDv24IF308j7sQ+8Pv0pbvwUiK4Zxi7gg8JmXZZhJOrkhVVd17L0cMFI4jeU6H2Djy
 TZrKFSXTmqVbSS6/fJ/jYGNnTdYO5sWOs2BoyKRDcCon/nUTgBX7KOKCFGeR66SmLUChIrVmmXO
 u5GNF7nSnXvO+tRDFU2+cejmkNEYj/2iyyirW0R6jxAJ80rUR/nGKmk0sAxpvWUMlipTVZh1Bwb
 dN4raVFdzLnERpVdsYE92D+pW4YEBzttmvnxHWVGK8vkVVPHU/i+wloJm20ectiTlkTM3rw/tWb
 P2h1pcgRiAe0tJI2XN/OBXPlycUkk9cVb7xUG+k8hVJAw1rvMwYSSv8BSQMYCx6rSudDcg4hPU9
 n0oyvqKQmcipRBa+0gw==
X-Authority-Analysis: v=2.4 cv=R+wz39RX c=1 sm=1 tr=0 ts=6a443d03 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=B3UIE0ElhL7aPqeKxCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: gY04QJYiRPY6ghXPhSifC_moil8WjHaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Have accelerators set @can_reverse in their get_gdbstub_config()
handler. Remove gdb_can_reverse() as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/internals.h       | 1 -
 include/accel/accel-ops.h | 3 ++-
 include/qemu/accel.h      | 5 +++--
 accel/accel-common.c      | 5 +++--
 accel/hvf/hvf-all.c       | 4 +++-
 accel/kvm/kvm-all.c       | 4 +++-
 accel/tcg/tcg-all.c       | 4 +++-
 gdbstub/gdbstub.c         | 4 ++--
 gdbstub/system.c          | 5 -----
 gdbstub/user.c            | 6 ------
 10 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 9a1b8d9dd8a..dbd6d11eb8c 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -154,7 +154,6 @@ CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
-bool gdb_can_reverse(void); /* system emulation, stub for user */
 int gdb_target_sigtrap(void); /* user */
 
 void gdb_create_default_process(GDBState *s);
diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index 1bc359ff3e5..07241f799a8 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -37,7 +37,8 @@ struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
-    void (*get_gdbstub_config)(AccelState *as, int *supported_sstep_flags);
+    void (*get_gdbstub_config)(AccelState *as, int *supported_sstep_flags,
+                               bool *can_reverse);
 
     bool *allowed;
     /*
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 92f9c538f31..e740939908a 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -76,10 +76,11 @@ void accel_cpu_common_unrealize(CPUState *cpu);
 /**
  * accel_get_gdbstub_config:
  * @supported_sstep_flags: pointer to store the single step modes in
+ * @can_reverse: pointer to store whether reverse mode is supported
  *
- * Set the supported single step modes for the configured
+ * Set the supported single step and reverse modes for the configured
  * accelerator.
  */
-void accel_get_gdbstub_config(int *supported_sstep_flags);
+void accel_get_gdbstub_config(int *supported_sstep_flags, bool *can_reverse);
 
 #endif /* QEMU_ACCEL_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 526ab2a0cfb..41f98937426 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -113,14 +113,15 @@ void accel_cpu_common_unrealize(CPUState *cpu)
     }
 }
 
-void accel_get_gdbstub_config(int *supported_sstep_flags)
+void accel_get_gdbstub_config(int *supported_sstep_flags, bool *can_reverse)
 {
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->get_gdbstub_config) {
-        acc->get_gdbstub_config(accel, supported_sstep_flags);
+        acc->get_gdbstub_config(accel, supported_sstep_flags, can_reverse);
     } else {
         *supported_sstep_flags = 0;
+        *can_reverse = false;
     }
 }
 
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 284ce8ebff1..49014de26d1 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -228,9 +228,11 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     return hvf_arch_init();
 }
 
-static void hvf_gdbstub_config(AccelState *as, int *supported_sstep_flags)
+static void hvf_gdbstub_config(AccelState *as, int *supported_sstep_flags,
+                               bool *can_reverse)
 {
     *supported_sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ;
+    *can_reverse = false;
 }
 
 static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 72d6eb464db..0019a092d69 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4286,11 +4286,13 @@ static void kvm_accel_instance_init(Object *obj)
  * Set SSTEP_* flags that KVM supports for guest debug. The
  * support is probed during kvm_init()
  */
-static void kvm_gdbstub_config(AccelState *as, int *supported_sstep_flags)
+static void kvm_gdbstub_config(AccelState *as, int *supported_sstep_flags,
+                               bool *can_reverse)
 {
     KVMState *s = KVM_STATE(as);
 
     *supported_sstep_flags = s->gdbstub_sstep_flags;
+    *can_reverse = false;
 }
 
 static void kvm_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 89f7e025021..2d2aab80d17 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -242,7 +242,8 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
-static void tcg_gdbstub_config(AccelState *as, int *supported_sstep_flags)
+static void tcg_gdbstub_config(AccelState *as, int *supported_sstep_flags,
+                               bool *can_reverse)
 {
     /*
      * In replay mode all events will come from the log and can't be
@@ -255,6 +256,7 @@ static void tcg_gdbstub_config(AccelState *as, int *supported_sstep_flags)
     } else {
         *supported_sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     }
+    *can_reverse = replay_mode == REPLAY_MODE_PLAY;
 }
 
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0037704d522..0a691c95880 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -72,10 +72,10 @@ void gdb_init_gdbserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-    accel_get_gdbstub_config(&gdbserver_state.supported_sstep_flags);
+    accel_get_gdbstub_config(&gdbserver_state.supported_sstep_flags,
+                             &gdbserver_state.can_reverse);
     gdbserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
-    gdbserver_state.can_reverse = gdb_can_reverse();
 }
 
 /* writes 2*len+1 bytes in buf */
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2063b63b2f8..1421645c6e5 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -477,11 +477,6 @@ unsigned int gdb_get_max_cpus(void)
     return ms->smp.max_cpus;
 }
 
-bool gdb_can_reverse(void)
-{
-    return replay_mode == REPLAY_MODE_PLAY;
-}
-
 /*
  * Softmmu specific command helpers
  */
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 97eb13e796a..2cc851691f7 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -786,12 +786,6 @@ unsigned int gdb_get_max_cpus(void)
     return max_cpus;
 }
 
-/* replay not supported for user-mode */
-bool gdb_can_reverse(void)
-{
-    return false;
-}
-
 /*
  * Break/Watch point helpers
  */
-- 
2.53.0


