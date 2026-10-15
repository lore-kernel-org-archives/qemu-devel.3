Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6705CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT4Y-0005Ca-3v; Thu, 15 Oct 2026 17:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4G-0005AY-Bs
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4E-0002Qa-50
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3VfN406161
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=M4S/luozy0q
 zOifo+wf+UAtTf6pXhNYbZ+pAYPmVuXY=; b=J6W44mhLSQ5OpDRQ4b0uMV6eqM3
 oXVKQ0BBU8tEkpqZx7rGhbt3yXT51dL60lvC21YqGsmMENJbrsQ0GEmkP9OR94rb
 /ddfGOEnX+prS6qcFcHsznz4Ma5bQZzRbumO/yShmuhpUHXKR3719EpbDz4WlPiN
 SVocV57H/pJChtoFyfWXZe7gwB9KA+dMshYBIIF5K92NH6eTkEoiMDYJifEfeER6
 mICxPh8suUoFLbruZoE4FOljTHs5VxPuEFeEIo2rn+GTUK6GsWB8Z2uxWjQiRBvH
 Z5791PWCsx17w0Cp55XTs5T9o2RUCFi8Wp8k3oaPgRSjb9ZO2oEkub8uAIg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa0q15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac450b74b0so4365680a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099968; x=1792704768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M4S/luozy0qzOifo+wf+UAtTf6pXhNYbZ+pAYPmVuXY=;
 b=Fm5SGhNDa6q5a3I1aUoqRVw/eViJKAM5te9ByTTQ4HHlyU4Y+GDrbonP6YdaU90NkR
 iX3SsSmpWprJXq+zbLoOYO2XYGVdMyj/qE43X5K1KsrnxTctwoGwM4aCnUEAHZZTorTq
 99NBnpjjzpaSIe1Cw6r9i6KpV9jRttJo8oIaNwgY0LYLMv26ifXB76ZT2mMfrPnwJ+7T
 ps9QSrGkWRHGZcbLI74Jv6jYXnGZuaUoTsCUbsH2iHwviQZfL2Vu46YYVVxmU05ez34f
 CHlLMnrmH7KNkuhUB8l3yQR1bYiRcw3s65qOKv1M3yxbDSxggNRKj58sp0g331cZaQqM
 ZMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099968; x=1792704768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M4S/luozy0qzOifo+wf+UAtTf6pXhNYbZ+pAYPmVuXY=;
 b=y5JNJirFBsoVgM1Fl+ChGLby1DZEQvF8Mtq43nAxyf5KuDP8ZfTHoiOmjcNKz5NyJ2
 uDDxZJBCvtynVZydfORyKZuvQjFhAzBArO5HWvbwiRo2G3Mz5/3hheFjp5xhVqk7V75U
 LotOGEpgiLVBzf+zhgnZLqebloOh7qagidBsxTrSLsFw1lEZ8UBrZncV15DvQdl+sv5x
 V2xU8u2J8KwT1JFOn06aSPpYm3nm4dlXvyqQDqc7fZcHvPIKVuJhwjBcQHc0T09oGBzW
 zQbM0XUzkbdDP6WjarQAQIi6XJVWq9bkZPhMvw3/inIB08QAjC1nZ/K7xeotRsYG3MLS
 dkkA==
X-Gm-Message-State: AFq9FYIiKP0d+pz1S5uAlk+x1SBua5zMgeqrdZch7jba2xGcS5ZRUp99
 Onk4f1ITfVx8E6Zrc8pe9M1uQ3UTwRysFIl+RcnyXAAH5nhuwh7PddjBGl4IhxDcRlE7uEEtfD2
 pkTK/+fFgd6+6HNXeoBxmDmNJX9YcciQ1G37FiDIg/1zYIynWI9nK+JPu2nsimhjghw==
X-Gm-Gg: AYBFou3ey2fTpHx4HlqH79zmP/8OkBPrhAL0OpYQ2VXKKoMiHwyJdsJHbBa2ieVi6TE
 YCwQgkyaVXSAwSRqjK+ZQUh0/mYHM9/whscqdYqIJ4fM1LoVzTIHfDg7zadb24UFRmjaSJnZYMA
 5V4qRJB6IAXZ/h96r0QFtDxKZw2fVuGaQo8DsqmbdWP7Deh8W3V121S+Cu1n3n+FHrmwhDeKSVP
 SH0WIfaaymig+DBJJMxzdAUOr+UxJiWjF3hax2dO1FeLF3eN1m/cZamU/dK5bkSYyRm65HRqL7h
 id+6+UxpUsVb1CykPSbQKjCsD6IOR7S9nOksTC5W4oqR65ziFErXSitUdWSKXBObjdZQJtdxPg1
 SRhW7lvrUKBVTg5na8mv6NLsCMh8u6HSL12h/zVoJajpt4eZ7PWoYZ4sz+5EeLKY=
X-Received: by 2002:a17:90b:4d0b:b0:3ac:8527:3fc5 with SMTP id
 98e67ed59e1d1-3ac852744b3mr5246175a91.3.1792099968072; 
 Thu, 15 Oct 2026 14:32:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0b:b0:3ac:8527:3fc5 with SMTP id
 98e67ed59e1d1-3ac852744b3mr5246109a91.3.1792099966405; 
 Thu, 15 Oct 2026 14:32:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 03/19] target/i386: implement get_dump_info sysemu op
Date: Thu, 15 Oct 2026 21:32:20 +0000
Message-ID: <20261015213236.157767-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXwO3Qju/0LABe
 LCVRqRITYvwIMXPnQMPaMeO548ma210rXZBMP+mvN7SW4fciw6QMPx0vfIoWMKJIL/kK0YG5ksb
 Tzpc49DUwSIxUtOIqDJc7i0LdVQ455Q=
X-Proofpoint-ORIG-GUID: VcN5MmVynDi4RFfbTBaCR17y62Lq9UxO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX/V0etJ/Es5zg
 Zror6si/Z2Uj/BRB/R8hVs8UxA9a3RIyTc9z5POwHIOfxeIX/0eEpMh8uV9r7gt2oSAeXxYKsP+
 P7jGbc9QVbavcc2ykFGxvssaPUmUYadCAP6Vu25XwTOegkO1z9gQMbKFwVpFvNYLi18Rz8rMjNx
 HVWa+w+loN8TD5rJZYcVQZfxK4RZSlKHsdc4IX6efqOcqrRUPcprIcrOy4Q+tmX9Em1chIMj2Sq
 YcNY3OFBStcHNJ7BwHwJAO0FPu5rjRFGSEeBRwJ8P/Ip2IA6lz4jMhkdwuNBwMWGnFlUSHkbFjp
 00NajXaspfi4dRuBclFYuP/Gt+9n/YKi1/oGolJgUoT+QdeE/irnDWignZ8kJc+N8eXiqIrQOG5
 BApxezGcLpO4g0qYj1DO5UNbI37AQdzUwpsQRrSAay661y9iiYNgFwmk6Y5Bv2uG+PG1qh9ECFP
 35jE9YR1ZaWhMbv2RXw==
X-Proofpoint-GUID: VcN5MmVynDi4RFfbTBaCR17y62Lq9UxO
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad14681 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=KBKSk-pTE1mK2UdVZucA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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

For now, we keep the global cpu_get_dump_info symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/arch_dump.c    | 17 ++++++++++++++---
 target/i386/cpu-internal.h |  5 +++++
 target/i386/cpu.c          |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747d..d5016c198cb 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -16,6 +16,7 @@
 #include "system/dump.h"
 #include "elf.h"
 #include "system/memory_mapping.h"
+#include "cpu-internal.h"
 
 #define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
     ((DIV_ROUND_UP((hdr_size), 4)                       \
@@ -394,15 +395,15 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cs,
     return cpu_write_qemu_note(f, &cpu->env, s, 0);
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
     bool lma = false;
     GuestPhysBlock *block;
 
 #ifdef TARGET_X86_64
-    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
-    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
+    const X86CPU *cpu = X86_CPU(cs);
+    lma = !!(cpu->env.hflags & HF_LMA_MASK);
 #endif
 
     if (lma) {
@@ -429,6 +430,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return x86_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 37c61a1bc3d..9407b01d415 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -20,6 +20,8 @@
 #ifndef I386_CPU_INTERNAL_H
 #define I386_CPU_INTERNAL_H
 
+#include "system/dump-arch.h"
+
 typedef enum FeatureWordType {
    CPUID_FEATURE_WORD,
    MSR_FEATURE_WORD,
@@ -65,6 +67,9 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
+
+int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 74eebeabd7a..03efc411ab3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10919,6 +10919,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .get_dump_info = x86_get_dump_info,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.43.0


