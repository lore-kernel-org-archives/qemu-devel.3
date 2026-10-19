Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D3606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eKMlGMq+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eqRfhq67
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuul-0003Ym-QQ; Mon, 19 Oct 2026 17:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutM-0002oM-Fr
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutJ-0006L2-8r
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJwTB3103319
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fTiltsghreG
 szmy4qD9sK5drlKW43fMlcOKmtUEtrqY=; b=eKMlGMq+/fqPgMgqy02wjwVphaw
 t16nB0B44EqqjVXXnCIJBEb/ATL57eTZO1+R5deUOX5bcNhvAa7qE9/sDUdCCHq2
 eAOvuxHfP8UPvWKs9xvXfe3DuSBpFaLSENLV4px14n3G33CQECH+UhcNT2rQfxKl
 IIiGxkRoBxqIUtqVbQR8ZWc9ztX3Oxti4OfsVQqTptiZ13tIfTqsX5+8SsZw8FXf
 UgkNocqkcbFf7Hu5742qiPMYl7+SgeWVmuvzcJO7jzRS/A1SJlQsyA1PnUoQsMDR
 /wB3YfuldCSE40jk8SWbJFk90eQHkLp9NtJAhugsdmAAjg+FXLhxKybIH+g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0pd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso5346148a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445246; x=1793050046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fTiltsghreGszmy4qD9sK5drlKW43fMlcOKmtUEtrqY=;
 b=eqRfhq67MO7IGFqlZ2HWcg+F8oa8GkVGcY2++iketj6VR/SPmX6EKN8MJy8vkYBt+V
 OMHB/U2PCKZOWT/tfdPg1xq+6+TxXX/oVC1sVWVzvXfQOIipK3z2X6GIUevYEAFd15Fd
 +r1613mfkTQbhi8ZJpS101sIqZHdhN7zdXWIx1qSSo0JroajZmmbIXrQVWeNbQdYUl+2
 wNjknCWN6d8PFgwmWo/MNCAm1ZWhqVXb4HkDdnH6j+uEwrf++1owutyZDRq88t3viPGm
 quxpK45YclS2OJTfg6V9IdQWVLcFnZEzMWoXGmEYgkHsAYYm0nFpiy+Di+U1X43fJqWV
 Gd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445246; x=1793050046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fTiltsghreGszmy4qD9sK5drlKW43fMlcOKmtUEtrqY=;
 b=MRIPZByGS+6TnbJgvCAJQKmOWYgBHLKUKa4koyI3YKB2fSmqVtaSvOpvzrMT+hiLKB
 eKxykKGtwt6IpmqTWgDDRuxhDTGGDbYyiFz2gUQ5oxZbZUh+RVPyEoJiPrwXSNckUU/I
 s75eRn22hJB2C4P0xmFq46XJrtWqGlBHHsTn3mPu4HBYJsX1NpZPr+tI2rEuf+3O2d4K
 zL8xBu7I4jRMU9UK8ryJc50sxnMkMe8hk4j3x654B+jxpYMroU8wM3uKCE5LeVAqvNUd
 DzOsp/XWO7V0rzrINAxESdb5chZkf+ecHq70nZPXncSZRm/lU/LZLz7ySp8HpIokrjRN
 4z0g==
X-Gm-Message-State: AFq9FYLFzYnz3kAx+bJYEVxj8nnxta+csLZDPpLfg+76kVOiu0RX1kxu
 KYtfo1BfAkk92e0dw9JK3cMqHVDroKj9ZT61H604naDeYrv4m+MI3wEhu2ah1BG6a8tEGz292mg
 NcoOtS91ArmL34QoISCfzvUmlZPbhLe9DlB6DRRt2waMj6w1eWKNICMYsKSFXE8K3lw==
X-Gm-Gg: AYBFou0vjvO5JDsvL7rAEXAEab4Ra3QdpIVsx5s+repDLkHeKmKQDCDsq70qaSakZXG
 6ei0dzufSwSYtjQ/nI4WeuLis6JA8NBK/HCEWvC8PgGRwjl7W8Mnh8MT67ZoVyMSAVAzIy8vWyM
 nOWrhgk1GUHyYc1yg6f2kYYIVcf1LEEBZ1OgxA9ZD/DmbOMK+ogouBLo9GPWtFH0QvPTlkQBVZe
 +yIYP0TdgoUjnITTRqkdECYbE+rZaLGa3lgXrxRcw1jf4OVN0IRy9vpxhdB4E3zlkW+hBWVrh2p
 s4Q++QSk+wuyjuGUKXeKcFKMLYwYdcHcosWPNYDts4q9C0IbKvV+vSrpOHq1ygffrwQBpRPUtfd
 juNFDMQQsOveJETxn3IoTXghTxytW3TPjfxWFWaFbQyC8VyKIgb/6t2xY6U7CloE=
X-Received: by 2002:a17:90a:e7d0:b0:3ac:9176:e83c with SMTP id
 98e67ed59e1d1-3aceeb9606dmr7916259a91.12.1792445245827; 
 Mon, 19 Oct 2026 14:27:25 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d0:b0:3ac:9176:e83c with SMTP id
 98e67ed59e1d1-3aceeb9606dmr7916234a91.12.1792445245354; 
 Mon, 19 Oct 2026 14:27:25 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 21/21] dump: reimplement cpu_get_note_size using
 get_note_size sysemu op
Date: Mon, 19 Oct 2026 21:26:48 +0000
Message-ID: <20261019212648.154493-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7eBtbt6DdPFmdq1dtC84nissWvnOIf6j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXySFNsSN5yXug
 ZsiyAeGlxFFZWDxNSH0cc/GUmWsmopMdDVaS+5q1HfRmbUrEXJat5+XqJCHAASIlfj1kUjO4Frc
 fPnD/6N7O2L+4g6Aww0dS2MLtc8KjOg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+u5vo/DKZm4i
 W210lDfy+sZqr5E7oWlODY1+1O27osiyzltK5KTKPJ3H86KvX3irl5sDKh6HGt8Xp6rsRXu9O3+
 rDHwyzb6Qe9ipbqieKCdT7JFtwNRKX1bReLiDIT5SdGRxIud23aCZaUE7zOObWcGNnlVwUSWB8g
 /5121H9k5RFHM6Y/1OnYT/mMiGkKv2gPDAqBpxAevJMMyRGG7FwMCY2a6oUvr3GJZcJe+GOFlt0
 ObKXGch9UTKTZ4jfabU+JOHXIGYqJoM9sjJAkiw26A8hyCMekvYhsuiB1wJkh7ZTRQ7U+W7JFBr
 KJSYtsD33tQ4omQ0feH4Nz1SzMshWLhSEE/apKnSuehviojyrT1dmJUmQ3si+0sXdoLqdhyuDJ7
 rTdUv7VVA7f1Ea2pljuOkXZBLZ1gLpswLzvIbrqb+uCd5Prub286HF/w0GTuQS8ZZxmqRmmMWn0
 2yzq6CMhU9uvGU8v8Hw==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad68b3e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=omOdbC7AAAAA:8 a=MHTLdSNsR-t22p2ATOwA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 7eBtbt6DdPFmdq1dtC84nissWvnOIf6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that all targets implement the get_note_size sysemu op, we can
replace the per-target cpu_get_note_size() implementations (and its stub)
with a single generic version in hw/core/cpu-system.c, taking the cpu as
parameter, like other dump related sysemu ops wrappers.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c                  |  2 +-
 hw/core/cpu-system.c         |  9 +++++++++
 include/hw/core/cpu.h        | 13 +++++++++++++
 include/system/dump-arch.h   |  2 --
 stubs/dump.c                 | 21 ---------------------
 stubs/meson.build            |  1 -
 target/arm/arch_dump.c       |  5 -----
 target/i386/arch_dump.c      |  5 -----
 target/loongarch/arch_dump.c |  5 -----
 target/ppc/arch_dump.c       |  5 -----
 target/riscv/arch_dump.c     |  5 -----
 target/s390x/arch_dump.c     |  5 -----
 12 files changed, 23 insertions(+), 55 deletions(-)
 delete mode 100644 stubs/dump.c

diff --git a/dump/dump.c b/dump/dump.c
index 60ecde02173..23ac689907a 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1873,7 +1873,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         s->dump_info.page_size = qemu_target_page_size();
     }
 
-    s->note_size = cpu_get_note_size(s->dump_info.d_class,
+    s->note_size = cpu_get_note_size(first_cpu, s->dump_info.d_class,
                                      s->dump_info.d_machine, nr_cpus);
     assert(s->note_size >= 0);
 
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 499fad1c68a..3704dd40640 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -139,6 +139,15 @@ int cpu_get_dump_info(const CPUState *cpu, ArchDumpInfo *info,
     return cpu->cc->sysemu_ops->get_dump_info(cpu, info, guest_phys_blocks);
 }
 
+ssize_t cpu_get_note_size(const CPUState *cpu, int class, int machine,
+                          int nr_cpus)
+{
+    if (!cpu->cc->sysemu_ops->get_note_size) {
+        return -1;
+    }
+    return cpu->cc->sysemu_ops->get_note_size(cpu, class, machine, nr_cpus);
+}
+
 bool cpu_internal_is_big_endian(CPUState *cpu)
 {
     if (cpu->cc->sysemu_ops->internal_is_big_endian) {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d80a6a4e752..a3b4c6c08a7 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -712,6 +712,19 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 int cpu_get_dump_info(const CPUState *cpu, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks);
 
+/**
+ * cpu_get_note_size:
+ * @cpu: The CPU whose memory is to be dumped
+ * @class: ELF class reported by cpu_get_dump_info()
+ * @machine: ELF machine reported by cpu_get_dump_info()
+ * @nr_cpus: Number of CPUs to be dumped
+ *
+ * Returns: size of the ELF notes needed to dump @nr_cpus CPUs,
+ * or -1 if not supported.
+ */
+ssize_t cpu_get_note_size(const CPUState *cpu, int class, int machine,
+                          int nr_cpus);
+
 /**
  * cpu_memory_rw_debug:
  * @cpu: The CPU whose memory is to be accessed
diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index b89e495661f..1df88e732d0 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -27,6 +27,4 @@ typedef struct ArchDumpInfo {
     void (*arch_cleanup_fn)(DumpState *s);
 } ArchDumpInfo;
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus);
-
 #endif
diff --git a/stubs/dump.c b/stubs/dump.c
deleted file mode 100644
index 2ce3c5e274d..00000000000
--- a/stubs/dump.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * QEMU dump
- *
- * Copyright Fujitsu, Corp. 2011, 2012
- *
- * Authors:
- *     Wen Congyang <wency@cn.fujitsu.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "system/dump-arch.h"
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return -1;
-}
-
diff --git a/stubs/meson.build b/stubs/meson.build
index dcb67ce5295..4a26f795a6a 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -71,7 +71,6 @@ if have_system
   # adding more of these.  If the symbol is used in specific_ss,
   # in particular, consider defining a preprocessor macro via
   # Kconfig or configs/targets/.
-  stub_ss.add(files('dump.c'))
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
   if igvm.found()
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 60456e81bf8..986ce3d7884 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -453,8 +453,3 @@ ssize_t arm_get_note_size(const CPUState *cs, int class, int machine,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return arm_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 4d8e9374cd1..4a375f5cbe0 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -461,8 +461,3 @@ ssize_t x86_get_note_size(const CPUState *cs, int class, int machine,
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index e27bd0f6497..0b39fc73c12 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -163,8 +163,3 @@ ssize_t loongarch_get_note_size(const CPUState *cs, int class,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return loongarch_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index b59fef3c48e..f54729d77a8 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -269,11 +269,6 @@ ssize_t ppc_get_note_size(const CPUState *cs, int class, int machine,
     return (elf_note_size) * nr_cpus;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return ppc_get_note_size(first_cpu, class, machine, nr_cpus);
-}
-
 static int ppc_write_all_elf_notes(const char *note_name,
                                    WriteCoreDumpFunction f,
                                    PowerPCCPU *cpu, int id,
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 74b1489ddcb..05b637bea93 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -195,8 +195,3 @@ ssize_t riscv_get_note_size(const CPUState *cs, int class, int machine,
 
     return note_size * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return riscv_get_note_size(first_cpu, class, machine, nr_cpus);
-}
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 3ca85e6b64b..5048fbaf982 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -496,8 +496,3 @@ ssize_t s390_get_note_size(const CPUState *cs, int class, int machine,
 
     return (elf_note_size) * nr_cpus;
 }
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return s390_get_note_size(first_cpu, class, machine, nr_cpus);
-}
-- 
2.43.0


