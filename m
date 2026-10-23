Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70BD606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GUfTKpTS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hSnBzTbv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHxf-00036L-KM; Fri, 23 Oct 2026 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxW-00030G-6T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxU-0002Vr-0A
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6uhf1492398
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 epFgZpDurF8jjpl8AheXX0iforQDPUNhZmhrBqPhW4k=; b=GUfTKpTSGljdR4xe
 ImbH3w0jZ1WCjKLyi7c8ZlGPUfGw58l9Yx7xNYDuFfMdnviIX1YLSwnhpOgB0nWS
 6EcqmF8ZzJ6kF5cecJcIZzZViQGjXLO9pB30p/N+6f/JFIT1i7WSd4s6pmw4kdIm
 /TiEmlCR+PmPdiU7P9SczuxNSPOdlZ4p/XQVxe19KTqGMBgN8o9l4QZzkVkWcZJ/
 Mo7m79HDCPOWVq3WQ8rjomUgb74h7ZkdwxEyqD8zqCsLHJ0lVJUs6J0Fh78LVJd8
 hB1mz34nvimcuxewMHVzd4yf3uNyYhdrzqR74ZgMKqImuTAMNAc384nj8NasnQp9
 F73/iQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmauya8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f32050e72so341505585a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772248; x=1793377048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=epFgZpDurF8jjpl8AheXX0iforQDPUNhZmhrBqPhW4k=;
 b=hSnBzTbvChH3iiwNNDoJJZqZvCA13HNUfoGlQF0nP13uV1ayThXHUpBvzKCft5tZYe
 c0DigufnTi2E22ywp4vPBFIRQcSl+2SROMdQfaDMe5IOqrRwErJx18Qh9QhJ5tYeJnOL
 vwqk325EC8NOH3UhqeQiyax1iPS+if1cwuCFqyXyWWffSkrHD4kf8XCBYK2UT2Mwg+hG
 nJyx3+e3sbM0WtDUYYph8cP3G1L6Qaula2l3kgqMA+2KgBZYL4OWLpsWztGBFgCJ+9Ql
 mjrwYJUXyxrWudMCnmNR5oOF5yDfdOcfILIRPgC9fapL3Y+E9JkdNzCSf6N2lkOOeNoY
 FmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772248; x=1793377048;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=epFgZpDurF8jjpl8AheXX0iforQDPUNhZmhrBqPhW4k=;
 b=nEpi279FrossBehdqlK8y4UxDrXrUsdAsg+MOGCrInE3pTBTVxvfSejYGOzGPS7cRI
 fA7+v1sYhCuyNOAH2YOnVjKYMMrRa8IG8sl6w2RCDx4clJewyjESE/k8bxHN88Q4XcMV
 3/jpavF1ekNEZpGm9ZpbdZutb6FnIBenquqSFP6uRBdfVe9l/h6EaOExUNf/gvcnH5TD
 0JQ8BBAfkp0hN2uPSUzBzEPeNrjCsPDWYxg3iT4tftnUVQORSSEF7tBB3GJuwytUycMS
 lbdgeGIDjQ16snt73ypTgd0L0AEBFtV/3n85/Xo44Oxd6bODcpJT56Vux+2MxChizhUC
 UrRQ==
X-Gm-Message-State: AFq9FYKW5cgoTBkpNYBnQLi5Wp4VJfFoNYvOVMK7ZOV45NQMwQH0zQXJ
 z1Aj96XpDHyTJ0OViF/Lpd40KJYnKn27J7+N6Fs3ZjdWkoTO8M9ZHj9booFU8dHwLwmhbjX+rFH
 d43FjpPBbbsgcBeXuhbPz82vpmTwEY0zlVVy07lnyuOwwyNbhhY+M5v0nPgY8InNGkb19
X-Gm-Gg: AYBFou2kEHoqCAhQvi1V3OdVCjJZqbUz/Il8I7m+njwQqiVeywkEy97jmP20yEi9VJS
 XWB4neRiPUV/EupSVkPBLSD7THvJasmoVx4hG9+VWmFl9cAqhFGNGYQhyizni2DT45C2xFjAb9U
 fDtnqurx4Kd0ETSn/RlFSwHLd8/GvPPiQdiXxfSWeCKO440hnkdpTLfzoDaWE+zMD3Pv//B1q/F
 22uDj4yOiMWaCUPO2QCsdiOC6nQA2XfCNPa+7G5oPnh6zhfsCSGcbYbCHfHgqg8Ry/R0kcnACH0
 XEfrnVjvRARWelPAu3sK8cXiwCy8QtyiRBWJX8omelKywkl0BSZo9k9+I/GThkfoIPZqcedpafn
 5MIYRzcsarXvWJ/sKjLg2dXnzl0GWPeyHgIAycS7H
X-Received: by 2002:a05:620a:608e:b0:93e:53fd:4139 with SMTP id
 af79cd13be357-93f6f79ca36mr476027885a.9.1792772248213; 
 Fri, 23 Oct 2026 09:17:28 -0700 (PDT)
X-Received: by 2002:a05:620a:608e:b0:93e:53fd:4139 with SMTP id
 af79cd13be357-93f6f79ca36mr476022985a.9.1792772247607; 
 Fri, 23 Oct 2026 09:17:27 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b066685dsm14624435e9.15.2026.10.23.09.17.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:17:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/83] target/loongarch: Register CPUClass::exception_name()
 handler
Date: Fri, 23 Oct 2026 18:12:40 +0200
Message-ID: <20261023161332.60153-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb8899 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VSQHGHcfQv50bvChvJ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX9acUVG9cOn5n
 fUqe8tyWf/xdqjhLSlxfLZSB0m2koARh3IeaL5z1ZN7QWhFK+qi/b0bjhkgw1ldUqiyrrqO15q+
 q4bnQCl3FmFqETZBrvfv79PmXmtiv8s=
X-Proofpoint-GUID: o1LDEX6fXIUcgoSCtwJ0QabdfGjgxvWY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX36E9qppmsJ3U
 dJ1gO4eNpZ8cBxZLYRYvMxG9i4gQ0TwIoc8KuVWtOWCC39ln3AKu9yzh91v715pFdSOt0ajL8eQ
 Zww2+XVfqJSqO2of7eCzg12n7EQU7uYGw5Eq+iNxDoSAJgDIKYLffjBJapsLrW/4iG55JMjb8jc
 7XSdo7Fj+wemHGhUpkms9A9Me0R/4N7sP2nzRDZXE89xouy/arvt1MRgv3vuiZMmir4je3hlPBI
 Hws5v4/vUvPaVqxeoQjgZX3MqE6kxvdphWJu/fvP87lMDn2gDKuPlMeb4P0KIfmPO3rE1LYjuG6
 yQKyIJXr3jcQ19EXZDv11LeH4l4UoR4LbkLIwnOjUwznyD3e6U1U3I4HT4DI6eCnBUrvdhs5JA8
 L6N2bp3on2Irfkjgj+Gu3xUhg6D/Ds8NBLRwAOXLRrpZuA2pcYJ5ahI37hptSOfIhlcWOLox3uz
 REhwgOsJP3rZYZaz/2Q==
X-Proofpoint-ORIG-GUID: o1LDEX6fXIUcgoSCtwJ0QabdfGjgxvWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Move loongarch_exception_name() out of tcg_cpu.c and expose
the prototype so non-TCG code path can access it. Register
it as the CPUClass::exception_name() handler, so the common
exception logging can resolve LoongArch exception codes to
names.

With '-d int', unlisted codes are now logged as "unknown"
instead of "Unknown".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20261022215115.19680-14-philmd@oss.qualcomm.com>
---
 target/loongarch/internals.h   |  2 ++
 target/loongarch/cpu.c         | 38 +++++++++++++++++++++++++++++++
 target/loongarch/tcg/tcg_cpu.c | 41 ----------------------------------
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 9d064d1948b..bc32bba7f75 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -41,6 +41,8 @@ void cpu_loongarch_set_timer_config(CPUTimerState *timer, uint64_t value);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
+const char *loongarch_exception_name(int exception);
+
 uint64_t read_fcc(CPULoongArchState *env);
 void write_fcc(CPULoongArchState *env, uint64_t val);
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index a95fdfc2b62..9579f4db2a1 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -835,6 +835,43 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
+static const struct {
+    int32_t exccode;
+    const char * const name;
+} excp_names[] = {
+    {EXCCODE_INT, "Interrupt"},
+    {EXCCODE_PIL, "Page invalid exception for load"},
+    {EXCCODE_PIS, "Page invalid exception for store"},
+    {EXCCODE_PIF, "Page invalid exception for fetch"},
+    {EXCCODE_PME, "Page modified exception"},
+    {EXCCODE_PNR, "Page Not Readable exception"},
+    {EXCCODE_PNX, "Page Not Executable exception"},
+    {EXCCODE_PPI, "Page Privilege error"},
+    {EXCCODE_ADEF, "Address error for instruction fetch"},
+    {EXCCODE_ADEM, "Address error for Memory access"},
+    {EXCCODE_SYS, "Syscall"},
+    {EXCCODE_BRK, "Break"},
+    {EXCCODE_INE, "Instruction Non-Existent"},
+    {EXCCODE_IPE, "Instruction privilege error"},
+    {EXCCODE_FPD, "Floating Point Disabled"},
+    {EXCCODE_FPE, "Floating Point Exception"},
+    {EXCCODE_DBP, "Debug breakpoint"},
+    {EXCCODE_BCE, "Bound Check Exception"},
+    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
+    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
+    {EXCP_HLT, "EXCP_HLT"},
+};
+
+const char *loongarch_exception_name(int exception)
+{
+    for (size_t i = 0; i < ARRAY_SIZE(excp_names); i++) {
+        if (excp_names[i].exccode == exception) {
+            return excp_names[i].name;
+        }
+    }
+    return "unknown";
+}
+
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -877,6 +914,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, const void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
+    cc->exception_name = loongarch_exception_name;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 7ea2a1eb933..cbf0e12c81a 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -18,47 +18,6 @@
 #include "tcg_loongarch.h"
 #include "internals.h"
 
-struct TypeExcp {
-    int32_t exccode;
-    const char * const name;
-};
-
-static const struct TypeExcp excp_names[] = {
-    {EXCCODE_INT, "Interrupt"},
-    {EXCCODE_PIL, "Page invalid exception for load"},
-    {EXCCODE_PIS, "Page invalid exception for store"},
-    {EXCCODE_PIF, "Page invalid exception for fetch"},
-    {EXCCODE_PME, "Page modified exception"},
-    {EXCCODE_PNR, "Page Not Readable exception"},
-    {EXCCODE_PNX, "Page Not Executable exception"},
-    {EXCCODE_PPI, "Page Privilege error"},
-    {EXCCODE_ADEF, "Address error for instruction fetch"},
-    {EXCCODE_ADEM, "Address error for Memory access"},
-    {EXCCODE_SYS, "Syscall"},
-    {EXCCODE_BRK, "Break"},
-    {EXCCODE_INE, "Instruction Non-Existent"},
-    {EXCCODE_IPE, "Instruction privilege error"},
-    {EXCCODE_FPD, "Floating Point Disabled"},
-    {EXCCODE_FPE, "Floating Point Exception"},
-    {EXCCODE_DBP, "Debug breakpoint"},
-    {EXCCODE_BCE, "Bound Check Exception"},
-    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
-    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
-    {EXCP_HLT, "EXCP_HLT"},
-};
-
-static const char *loongarch_exception_name(int32_t exception)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
-        if (excp_names[i].exccode == exception) {
-            return excp_names[i].name;
-        }
-    }
-    return "Unknown";
-}
-
 void G_NORETURN do_raise_exception(CPULoongArchState *env,
                                    uint32_t exception,
                                    uintptr_t pc)
-- 
2.55.0


