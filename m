Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E57CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRs-000780-GQ; Fri, 16 Oct 2026 14:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRq-00077W-Dd
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRo-0000WB-Rg
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5lSw2153750
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=asltVyfD8H1
 3fbxywHDZmQ6QJCi99JfXMRZRCX08EHU=; b=QcxaOaULlSI66HXO3paZwcVra5l
 GyvFg0iYt08JeQOs+wyDMQPiwoSs4YZfO1wQnNzt7Zi8a7OunqjAh47Y4eIXiraw
 tbnG17Qxzvv5V/303z/6r4w6Pwz11ebitbygUKbdjlgYuIUzRLtTFyAsku2lRZp+
 w4HkbXIRK4QSoi8AHL5cJkGAbQ3dWqbnWc8LdJaVv/UKL8EPXar7nxCAk6d3dgu+
 qav4/eqA8H8FAludrjwZqqQSS/PAGfjPdPaMUaIIDyp0Q4C0R4cr7pYhveKTgykB
 Xh1wcUpdrgdMTUcKJqoQL990WzheFunIpKBDSUjyhk8axf07UoYjODwD9mA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumssue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac16335199so209009a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174467; x=1792779267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=asltVyfD8H13fbxywHDZmQ6QJCi99JfXMRZRCX08EHU=;
 b=gDn0/sXWJRwpSVFajKQwc2lYAMkrZ6nROo59SUiL2QT/1MMXGEof8tuPUAAr/6UXT4
 d9Pb0GAaFa9B0kobSa4b8lJbMWczfD6mQjOxRMbFU4udkDciL7LKNh3W7XnYxclzYhP8
 AaWIam8rSsP4EF0ZldfMYluw9QJGbKapIuZsFQUS7xt/tkZHXSrOmSF9XADD7RF6NNwk
 QqoRWrkI9PjyEZkr4ggkjkXCWzGDyQLoCa4cJIGvrtQNg3/zOWikPEWLhxj5L1Y3rQew
 wg1s0FGnSteP3xirsq9kCODdtya5vz8zfG3WhK9hJDPdT41a4YSh0FBIJTSDnv0/1dvb
 2z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174467; x=1792779267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=asltVyfD8H13fbxywHDZmQ6QJCi99JfXMRZRCX08EHU=;
 b=1HPbCge/xdJnRVtrJnEhCsicdWcHE62R2eXLg3eyZJ8SnmCMwjSNvygoJZv3wMDbMH
 xjhXmHPee4hC6hH48mwfh1icuThILItGWXGBQowky/Unyv9mZ7aTJB3ZhFYArsTGP9Bc
 I+YyoaKArP8SuNbPZOsRs0AtFdWKhyNOZX8IReEHv/kmvS2WEWMo6BvWwtHADv0dhmJx
 A8wS9wg5bznnv7ScCND+TuDssGVmMVnzEIkKtS9kBl5f9goVyJ6+68DZuBw/ZDtaT/4I
 sqXBVN+QJZZsOhOqQ0iqx3XspVg2Leew2vSn6ywmTHzSr5bg3Zvt9i+9hbr3+zR2KsV4
 TKGg==
X-Gm-Message-State: AFq9FYL1aU4w6YU31Pdp39hBgoqOvOzUOWFbM1QLmvwe/TQlwXZQdhVO
 JT9A7ebaEAle16FpraDN7J8YpiPMUqvtZ7aR08Dm1oAzmnyPAia+fkfhBqD7MMeGdzG310rTYw6
 dVkpk2hqh8u1/WUi/oOC/rv3ZNlt9I+ZrKa/TapydWjxz51BflQKdCvsSO3Fw9J/Odw==
X-Gm-Gg: AYBFou3D+JIvxiWxnYf6g5245p/NIT2IU9mYFTJOzYtLoC68ViC7GpXNPUgKvZQseMp
 v9RUhiLVKMwWyTMT+oRjXSfal9Bu/81P1w5mOhJSGRctPMCqBlUZGYs/T5SHf/9EXJFNs5oK3K8
 SP/fSnZhB6hgrmxbEY5oxF3KWVOY4M6uX6mwA2ZAHJhjDBeYxmCBzzoasPZrSP9SKtz8R1TWZh/
 guY101ZqLrSG1TZWT8ITijTYKcU+w+sFZ7kKZX0SpHAHUQv30/9YnAAPFXk4clsf6AoIgPvZwnB
 GZCqcgOy+BHcgBRnJfHfR5+mM4uwMq/D2IArRkTzJHlI6YHQoB3VOEzIJkn1hOU0oFsK/Mt5VoZ
 YjdkOuqVixnlEvm0XdpP22pT9y1pCQU1NbUGD/FLNJHMXGCpJMWmMM3zjsnCHZkY=
X-Received: by 2002:a17:90b:5111:b0:3ac:450a:fa22 with SMTP id
 98e67ed59e1d1-3acee289d0dmr643122a91.2.1792174466829; 
 Fri, 16 Oct 2026 11:14:26 -0700 (PDT)
X-Received: by 2002:a17:90b:5111:b0:3ac:450a:fa22 with SMTP id
 98e67ed59e1d1-3acee289d0dmr643106a91.2.1792174466327; 
 Fri, 16 Oct 2026 11:14:26 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 07/23] target/i386: implement get_dump_info sysemu op
Date: Fri, 16 Oct 2026 11:13:54 -0700
Message-ID: <20261016181410.191743-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX5+1i8V/NJijq
 wLh6Jti3xVt/+z2LaST34m/JXbkgiYFbSgSaFNYTzAB++Mg81PvAVMPTM9ZLTwoA+/hdkQ1Vl/e
 JnH7DzF66P4rweoDagQ1K1hFsiY2E7w=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad26983 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=9TR7Q1sQarOedDMGQfkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: FuaSbraaMLvee4FlqqqU6O9f9NGUgzuI
X-Proofpoint-ORIG-GUID: FuaSbraaMLvee4FlqqqU6O9f9NGUgzuI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX2xNWkWokc4oF
 rmGQuGICWYiHNer7KqoTm7lB/4ijjcJmDiLqTkY1SDCF+IV9pmpG+R8j2yV0D5oxk4Vi9ywCU0W
 n5hC+rbJPWYnrDKU4mqkc8iFFs026RToGV7BdSqtVi+DxVMuaH4nQ9ielDmgUo70iEvoJ0mwPig
 lN9wz3aVAmn+3Q8XNAxi1vPaQBbuta7HZcBvLWRD7i6V0nMVRsME4k/75ObGPoxHN0J1Kumha+D
 2GCXnT3nIRP0mugBrcLZqBGTgcC+sgH6pP20xvyAwHFFP6hgASuyMNSKuyh21YGj8tgtC73Pyar
 jDWQtQrWDfXnl5H50JP+6Vl6blZA4b+zFNOlAFIcaSb+5AIGDOQvkC253LJEgPZrUoh1cG/wePX
 8d73eiscYUZcKAdX5ENUTTgbrkmoa5sgyMocdG+W2o61RHH0x4rAjwVzSycEfIpwzVH9w1qXzHy
 JqRfP20dqazWHRQTqDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160071
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/arch_dump.c    | 17 ++++++++++++++---
 target/i386/cpu-internal.h |  3 +++
 target/i386/cpu.c          |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

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
index 37c61a1bc3d..9bd2a37c447 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -65,6 +65,9 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
+
+int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5da80ade70e..49f453bb011 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10920,6 +10920,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .get_dump_info = x86_get_dump_info,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.47.3


