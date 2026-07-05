Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F073CC44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUsk-00019m-VP; Sun, 05 Jul 2026 18:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUsQ-0000ig-3c
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUsO-0000SB-Ei
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxaqK2716420
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2br9DW08n90+USIli43PezSjjKsqs8k745Ddne726yA=; b=X1JROeRG17l6eK5K
 W+bwvjmqccC6ZVncd3MWbExdwP5ZFqiHEOnWU5HVXp+2wbjJdCgxK0q7bGUYC1gx
 4dEU0GaGIvswF3qSTU5ZLR9Ud/Qj60383cipj++i69rKuDtsoP4s8UE+EbqcrA6t
 3uQlAfpUonUJ9FwZp0Y43+jZGrxBqG+Lvqog1KhL9NTYCjeuQnVTpd6pJgpJkHeM
 6mouyJnWMJRo68toKWKvtchHtlfdheqtWpjFztSmUQ/B567kUHnpGHuxu6bYTNAc
 iX80e4NQ5Iv2ZjEPci/ZUKtsFulKBIUZ/U+GEzqCl6OzMoIb4snpBVFwKJsgdGXX
 WViYKA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txekdvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:59:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e59b0e0f4so167720285a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288775; x=1783893575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2br9DW08n90+USIli43PezSjjKsqs8k745Ddne726yA=;
 b=cLiQs/xfT7Shw+qisnaZtIVi0qpBtEKnhLcAEWhjAtFMPYphbmE+TC5L2xnq9Oxgn4
 kSs7NQwhUl1y9GoERP48IlOj2pF+SzLmFHlzKbYJ7Pni1c0g+UuCoidMGEHMYwSIsynO
 y3/04C02ncOOAHt1yDRIxbBBy4q8snBWfvv2IuP99HiUJEIS9fOGOeoA2Rrobl0SlOG8
 GLB1g5G0A65L8HAcOwWXXTxEPqaEtuSCSem7M8HA+ZZEoNo1B2Gojr4v1T4FRfCKlXBx
 /trPY8sVq1wOowaTt0KzUYzH95Ls4IZPR2srnuD0+w5YVcvHSfvufMR2/LqAGld05wqL
 fwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288775; x=1783893575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2br9DW08n90+USIli43PezSjjKsqs8k745Ddne726yA=;
 b=EC0l3A88yc4o/5mmG/Z0ombshEPC2VFayb0iSukmhbMkyLx3It86FRBxrVY5W7m6lh
 86YOsM4rfIAYlwC5QkZs/dcHk8ZDG8XAT93H1vfenyKlUSJouzJ2SYCxCbtvB4OIrnMg
 9g37r3hJZ3uUaWkC8Dhd06L8mSoymoX2dSVQVZwnTAJEojgx7FojT9drCsBL1QbR2c7U
 K8AqpfD2if/i/i84WiTcl6dcE3G0m9WUJHAcOcJ9GLWDjp2vYDpoWb0MDlxRSfjpwx+J
 hd92UhiNuAHzthwCLgyMBhs3YIgl4h76eaNFaNucJdEybdA8yAOtLijjM9GNnRTb05da
 xrHw==
X-Gm-Message-State: AOJu0Yx0I5Vcs5Y52zOQT1EjiIhrmxDL/IB2eL/rm/tZ+LuUpZwFw41a
 amGdMMik/vTp2sICTMTN3h7GfXSJ2VD5QKR8IaYxEcftQJyPzJ/jJaFxjQBaf8yvCCx6XMTD767
 lUh7xoDYc9uGYPC2YgGJpCOJpQXXMJK77Ov0Drvl7cm4n1+8eQPbXVWZOIYYfBf9kaQ==
X-Gm-Gg: AfdE7cnnu1l5u6tB7Zg+5K6FFQWB7+AaMzyYAkfdTnkHLz17sedSkwdacym40ADKcY9
 wRLEKzt9e1gWJXPXCUvkIbGYu05azSOke64n971TBU/byuw/HSkshtluTaejuI/ZtcPGtHUqbaf
 alyYqPQ0Vk8387pT2odj2FBp5AG9AnvHK933P9O5dsd8QMyG9L4ZBDwpIAOP8A0CtVUGUvUCl+5
 Hv4L4+CRm/AXcr/AsLbN4+WQQcGvDTUpKyQGXzRedVFFYGQGaa+zw6J26Euv6lmYtEIjYVW0Ewx
 VdBC+PNGFHth43REQe6EdKp/YlFdlYR2y4h3xxYGlsuayjgKv/eTmGnZ2YHZz8o6IlGgMwvF+YN
 +KTdQykZG74RzikazzsIfP8SOOBM4nAD0zlSdU99qvrJBON38ofMQgw==
X-Received: by 2002:a05:620a:4145:b0:92e:583d:245f with SMTP id
 af79cd13be357-92e9a346819mr1077593285a.9.1783288775381; 
 Sun, 05 Jul 2026 14:59:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4145:b0:92e:583d:245f with SMTP id
 af79cd13be357-92e9a346819mr1077591485a.9.1783288774894; 
 Sun, 05 Jul 2026 14:59:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa09608d4sm19859692f8f.25.2026.07.05.14.59.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:59:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 16/32] accel: Hold @can_reverse information in
 AccelGdbConfig
Date: Sun,  5 Jul 2026 23:57:12 +0200
Message-ID: <20260705215729.62196-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX+s+IFOsV4wgb
 kmj6Int/v561uvka/rGLOQjIkkZRXSkYzVVfrEAScBrzc1WvXVtjI4tY8pP3odvS/nslqgyxbGK
 syPegza3oBnSlRV58+ud4azish9oSfU=
X-Proofpoint-GUID: QXxfRzUdbfQooqK1yHwSKXHhhU2iwFY2
X-Proofpoint-ORIG-GUID: QXxfRzUdbfQooqK1yHwSKXHhhU2iwFY2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX0qsy0X2Girb8
 lMddFHlB7J5ShId/MTood1AKLV9JSXrPm0yT5ymLZd9DhM/39IOGESSfG9xxFFuF1foEyv6GL+R
 RkUtsI12WGcz06nT3HGSeJ+2fRVJgmUChGnSfsRvKKAn3faKAdR6pmBdxn5mcU4qQKmlLPckGk1
 QTLViPgSwOU+wOTgft9LzNh+6zVFKpihzLjL8maS9Rp3ghDNp4HHp3ayEUSvjr7G6ub7yJ2p7n+
 9nYAxCAvmnC9bZ3CJnVbx2b0NCY7i70vIiLBox2DCa6HQLau9vMGiyV/ocHQzOpsOATgkag/dfo
 It2fSA66Ye+5oUCC4dezvR61mhOH7WRfcXinBDBgFxw5NLfc5IHm6gko8fcPO56u5e4sK6pVilc
 sJL8zL3U46eCN7oL+AgnIR6oFYMtitDH/hoYwNSaNMINzPWveXmsz9cb5xGSmmXgdqiM4Jn+3U4
 qF53FazYsuPHSOlNfzQ==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4ad3c8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=SMEfN5HU43_l-HwGlA0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hold @can_reverse in AccelGdbConfig, set it when initializing
AccelState in AccelClass::init_machine handlers (only TCG sets
it). Remove gdb_can_reverse() as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/internals.h  | 1 -
 include/qemu/accel.h | 2 ++
 accel/tcg/tcg-all.c  | 3 +++
 gdbstub/gdbstub.c    | 4 ++--
 gdbstub/system.c     | 5 -----
 gdbstub/user.c       | 6 ------
 6 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 0444dee2246..0b74ea4000f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -154,7 +154,6 @@ CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
-bool gdb_can_reverse(void); /* system emulation, stub for user */
 int gdb_target_sigtrap(void); /* user */
 
 void gdb_create_default_process(GDBState *s);
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 3b01d55741b..8e0c3dfe088 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -77,9 +77,11 @@ void accel_cpu_common_unrealize(CPUState *cpu);
  * struct AccelGdbConfig - gdbstub configuration for an accelerator.
  *
  * @sstep_flags: Set SSTEP_* flags that accelerator supports for guest debug.
+ * @can_reverse: Whether reverse mode is supported.
  */
 typedef struct AccelGdbConfig {
     unsigned sstep_flags;
+    bool can_reverse;
 } AccelGdbConfig;
 
 #endif /* QEMU_ACCEL_H */
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d30b53cd3b7..7186c10cf02 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -159,6 +159,9 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
          */
         as->gdbstub.sstep_flags |= SSTEP_NOIRQ | SSTEP_NOTIMER;
     }
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        as->gdbstub.can_reverse = true;
+    }
 
     page_init();
     tb_htable_init();
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6c4fa065638..0a328b0dd48 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1376,7 +1376,7 @@ static void handle_step(GArray *params, void *user_ctx)
 
 static void handle_backward(GArray *params, void *user_ctx)
 {
-    if (!gdb_can_reverse()) {
+    if (!gdbserver_state.accel_config.can_reverse) {
         gdb_put_packet("E22");
         return;
     }
@@ -1684,7 +1684,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
-    if (gdb_can_reverse()) {
+    if (gdbserver_state.accel_config.can_reverse) {
         g_string_append(gdbserver_state.str_buf,
             ";ReverseStep+;ReverseContinue+");
     }
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 1179c82cb86..2e8c457097b 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -479,11 +479,6 @@ unsigned int gdb_get_max_cpus(void)
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
index f7bc4e63dfd..299388b9f71 100644
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


