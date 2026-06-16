Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C20CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkR-0004OG-En; Tue, 16 Jun 2026 14:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkL-0004NS-6u
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkG-0000PF-Rl
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOYhv303248
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rPVwjtVca0IUqr1xxj08PFOVLRyMwM1JDFtLV3mq9TQ=; b=oMBfg14GWfYkrXyf
 WWiHIW/5S7NzsiDGzQRtxL2McvLw4T8WfI6KB/foR2UQ00VP/j3crVzKWvd1RyLR
 gMMnKYp36/k5P2Ds1T6x5g6jEOT7hCFyMmBsvNi5684bHU+sQnzhnsRghl1qBnZC
 qGsYsFXYgHG6+ZHPteA5wkUnZ/JmRt+KVsXCJzVgpH0XfDOZQmqJ3ndi2x2vjU/F
 DK1FpKdBqmEXBW8ZtmVGp3trrPWO0RWl0UEdGVngvDhYSXNpy11VvtzuVQxfFk0D
 2U95pKLoOIZwV0KoDZsRvHUUbAV2bvrIAFxgT4ljYqGidBHLLu3IJqM3a9/rjk6H
 +Bcz1w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epb7cm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-842446a3851so2565460b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635363; x=1782240163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPVwjtVca0IUqr1xxj08PFOVLRyMwM1JDFtLV3mq9TQ=;
 b=EdrYp/5me1xYRORvyGWzI28HxMpCbULxiK6bOE9w4l744AwNTlsUpEC2vtGGvot78Y
 K5kCn1SGDbIx6pBMn+9n691Z4WVc2gcojh+oXbzpcfL9xFON1sIHiwMs3bXuF3nAo6G6
 9BE6OQiR4qrQ3hRLMBxr0Opy8ULTu9NUxQY0jD64xUaLzXrOMLriBIytpStgCnYhW1Sh
 ApNfd2jSbKWYGDv9DeILYDQ3eyfIfePMl8+Elqi/rYUZHO0bwGAvqS1deokj4QG7rSei
 +9yDXK3ia43rzbVR1DVveNs8/A167ptbwvorha1JxK5KT4+CmPusoZJMHC53ulNiy40b
 oXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635363; x=1782240163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rPVwjtVca0IUqr1xxj08PFOVLRyMwM1JDFtLV3mq9TQ=;
 b=CVvKWyEXnRxoIRYtpAphKUYDL6CQ2xAsGNO8ZyqgupaF5ippYHE8ZvNnBFo0AHiFTA
 dGciNRlFseC2nheMbKoSWu0bYXrDR2COJjcOD5lWSr+mtGYUkCJ33Pj2sw5W3YrSN/Tp
 JVuDDTrArBTfAH8nzHcf89FqrL5p1VPeHqyuGNCBWgrq57ock6b9KUhypj/7nfUmHDVk
 ueSO7AMPUKyZIc60FqtOJc1F4ph9YzPLAjm873E1edTkNAqlg7/mnRdzsLPQHno1Xx5/
 wumNCEVtUW0GP2rz1ijzWNbk6GiIFrYoaujTGoBjt7LTq7h7TUZQ5OFquskp/MSBLy3u
 n/EA==
X-Gm-Message-State: AOJu0YzWdwYnImEm8k9GiTq1daCZKSPfXP9AkBCJorxZzWQaARNg6a5h
 5Q9xQr5wnL//KPYNXaWDA9dKjCLSOa/sPXlItq429pG/jM5IhbymmGzRXq5xD0yxM9zKC0zQ4M0
 tqSr2m1evRPrq29kf5V5sKqveYywwgD3NTKrCxc+ywWJfU1cYZDnYK4GaN2niFDgCJc1j
X-Gm-Gg: Acq92OG7egOZKDC7JSywwgq2abYwD7z+1fP7JCveGooUrxwcFlhcE45SdIkOuWbpeh/
 uCUQamhDr+8eVbvim/lHMg+GRQggJbpySWP3wYyBHJnQ0kVU5fPfW4RG42o2qzlpzb3ZMjvowxm
 FyASYmozfyHEsWAVgOeTJ6Blo/VLHLk3tsvABubr76l+PH+oezzgq4Vs0fzRVc6noBu732a+7Mp
 xHf5GUzkkU1Tpy30/aamVCb4vzIXp7PI5mF+o/zU0tlOhmg53WCoFl7F/WNO7NN/0ttRNXO2SlW
 NEGFnlbAFC1aKAN2f2YT91SQ4tU1MXxX0+lZRN204Xtgq6YAWNW3T2nXOG6dRmqqFKFM//ta7lQ
 bUuIJw0FxVKNlu48RlpGO92eDO4F5YDxj2etbU5NswFc8ewcj92qxu0N7LJWMA/LdU0G4lxDh15
 LWFWEkrHM=
X-Received: by 2002:a05:6a00:909f:b0:842:6ec3:2359 with SMTP id
 d2e1a72fcca58-845245a009dmr298962b3a.45.1781635362689; 
 Tue, 16 Jun 2026 11:42:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:909f:b0:842:6ec3:2359 with SMTP id
 d2e1a72fcca58-845245a009dmr298939b3a.45.1781635362248; 
 Tue, 16 Jun 2026 11:42:42 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 06/26] plugins: remove qemu_plugin_id_t from
 qemu_plugin_vcpu_simple_cb_t
Date: Tue, 16 Jun 2026 11:42:10 -0700
Message-ID: <20260616184230.303038-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a319923 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8
 a=rXe6YV4CopgQa2I4tT4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX3X1YlsJI+Pda
 NcLkZ1WRRzNk+fszBdX1TYgtSQ/qPVqofXLZARbIjLgswcKlv9pmARCCveDFlvEbrOu9JZn83QW
 YlP6u1tXMDrapA4rbf6HQfjz2NGBvJg=
X-Proofpoint-ORIG-GUID: qaB-gLdpWzzZX_gN8ga8jBkY-4_uhDij
X-Proofpoint-GUID: qaB-gLdpWzzZX_gN8ga8jBkY-4_uhDij
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX1oIP6W+v3CDs
 CMCilwegbXVp2TIr5N3dZ5c60zpRU0Maa+9vO5LLRwnDTbAANYYwe4BFTWqvu4XsNloJvUvoDjR
 v4sLYKhEfBraObzvw4JlGxXrr+1C6H95OAgrT9vqlvAFAexMKO2Lul2h9jgMMZAvJf1IBcbahgl
 ygbNG9Y1kuetdUDzXubdV2c6STzEIool/OYNVdTgOezVUohSGH40XigEtJDlQ8CIIoO9yIOSHhM
 MAv2iJ0zn86I2y+iuNsU8BCw8djyoKqncX/C54zMVIkGgjfYBR71zy6mopRQSdJcEj0tc2UR4/x
 3b4rBwzPpQyh7hf0CcNRqPbWGqOE6uDmi8UkfWykvqSkM1RpVd6gxtabMf8h3G4gnASTxUUgJFC
 rFgvl22QItuUkySXpRbCuHiSHgmVppW57i4zK1ihaszxmUGVIiwR+LrTXDz6VqeM3Pvxx9H8jB3
 PLek50QTlQDrUO7ToeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

Not used in all our plugins.
Future commits will remove qemu_plugin_vcpu_simple_cb_t completely, and
replace it with qemu_plugin_vcpu_udata_cb_t, so id information can be
passed using userdata if needed.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-7-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


