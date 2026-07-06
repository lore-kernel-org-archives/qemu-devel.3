Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CF6C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjhg-00068q-FC; Mon, 06 Jul 2026 09:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhQ-00064m-Np
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhN-00076Z-DO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxL30369098
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WcpkIGHjhwQR0SDiD0tAqIwSLlRtqtm9/MDOtUpPkm4=; b=GHABsOIOamXEb2Y6
 4iW3zOiF4mGCtryFuRJYLhqlnadsc91NkEw4B2VEFwmmd4HgFHkuHhQoTwzUxaEH
 vgZuVU0fbmfKvm8cwIbEzsXYOfhxnjt6vtK+4U7cTpn7Ly2XSOlvZbSno/QWUvUh
 BXNnxpSAw9cNaJNhj7gixUQKsB/JqsapcTBhhXbocg6Aka1GWZd2XopN0IshzleI
 4dTOkH99k2Hl/AjwKRjkS0IuRUBqb1VoQ9yG7imycxQy2uU9vNxATfQdZDhSUZ+N
 hVVgTg/lHqr1IXyyWYE84XG6Jdf1rn6HK+e9u/RG05/adc6NC7cO88d0S8LTno+B
 CJyIzw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h99ccb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:49:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92d1cae5740so351322885a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345764; x=1783950564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WcpkIGHjhwQR0SDiD0tAqIwSLlRtqtm9/MDOtUpPkm4=;
 b=hUuKY1SOIiiFljSwB+QHvdfVqVXXe/fIbL3yCnETiagUxAsBh1nsZtaSL7+MAp2eET
 pWz9DwzoXqxT62FwSL42fqts5madw23o7i4u7txngD/HIvwNJ9mxMxms13mnk+5GfD5N
 LiXy+NMm0Twam0yKU6NKhA1Kr6GmcW6aWNOzq+v1LC9Oam79NpkPD2gMArTUDQwS44He
 hNnEx1YIev8Y89RGQuUUo4CrADCnpa7fQFx5qnTWKMk0sPACpLOsgu4vc4jfRE/y/pRq
 EwDE0qo8bGqBpyrHDos+UqzlzHZy/UiDHjpXKuEBYlS9IMFgbE2+iqHU3Gy1rimTxy6m
 VNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345764; x=1783950564;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WcpkIGHjhwQR0SDiD0tAqIwSLlRtqtm9/MDOtUpPkm4=;
 b=cL0/BFgpY8j8VvEyqeGjIYeVJY4uHnbROVxszHUBae6ZWIPBjTx7iPWOI1dhaXi4yk
 DyVzRzC+kcrHmV4oII6BKHSSk3NFSPR3TBJKggwMJfckhHFkFcJFSKOB+Y+IV61xR7Ro
 CBCltGw4y2JwYnZ774cqG2I9cSip+USK+a3zjHjg8wKKkGGwlAuuMeDwxIBhQTSAS+rh
 WDDD2E1KqT8oLhOy7UgrR+oY515RsWhhXWk0wSUHfkBGtyOUnI3D9o4cGSvGHdhn37FU
 nUmli831HcsYqd7hFB1kwo4dgH7UZC7ZQVK0C+UUVphd8f0h5E9+lMaI3P7pwBOmBA9h
 gjog==
X-Gm-Message-State: AOJu0YwK6sA0ShT/o2UQqQVqZTtsBgL97v22bqTz1WR4p0uQup5rHGfn
 i7x2NSnJgtUgpyCLqKP6u/OEBLo7RNDr5rSkHeqbDHVW3VXIiMRNq+VQBphSnFoe8yOJO4QCAYN
 0TQ9Z51OjAbEg3ZtX8rCR4XhsSnNhpE2nCAqUxV3BTcL0luCkdVzoDc7b7pZKD9Zzaw==
X-Gm-Gg: AfdE7cmBK70EEXeZhTA4g6ryh80h4nwmxpNyqw0YwDXTZKhoCajmWnMerP0E8HJ/Iet
 cefSiunMbmt4oiO2E0TCvM39BctvchJ33AswtwKEun9xpZmZn+HNX2Oja0fZHOghdtizZwnGni0
 sn7YPdBanb/FNPfDn+eUQbvtOotqmCFyuTuxrlf3lvC1WmZgHEWlYYuwwT+efAXcV3SXkBUEArj
 tPvJzlVaokh2vcrVOzu+Nht9/t+SSmk/E3WhZoeVNNGVguzitaOgkG/P2CY8zP6flg9J1AoEnKf
 aoNv0m6B6Rug5Dz6TgOqjMBq+pH+YOXAYAs1MToqgquLlS3MxZBelLbIVa/Ptpp+LunCn9pguuJ
 evO+22ZlELPHoggmlZ7mMfi8OepvKHhuBlzi7dIdSuHw/VKLnrszimwZcwA==
X-Received: by 2002:a05:620a:4626:b0:92e:6dc0:7b13 with SMTP id
 af79cd13be357-92ebb6072ccmr87019585a.53.1783345763428; 
 Mon, 06 Jul 2026 06:49:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4626:b0:92e:6dc0:7b13 with SMTP id
 af79cd13be357-92ebb6072ccmr87009585a.53.1783345762408; 
 Mon, 06 Jul 2026 06:49:22 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce0a7cfsm283003345e9.9.2026.07.06.06.49.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:49:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/32] accel: Use GdbBreakpointType enum
Date: Mon,  6 Jul 2026 15:45:20 +0200
Message-ID: <20260706134527.84808-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NISZlFUxOdsXww8dU8MaOylENmFe0h6i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX62XWEi/KanHr
 ydlZpu9cmaJ5y00XxY7oECs+7hgG9qQ+2eIazWgzBVdDH/R+nPjTX52kVMEjpcwBnVTsi0adsDK
 oiUEeUG471bPSic1y/ivlW8nLASRpu0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXx/qwaZ8l/lF7
 dC1UBzJ60lrkIInoEqXxW7c2Csqf1aBHAkN5orKoSX2r6G8paa30xZXJFL2a89HEQkKVEYxGf1M
 hY8CjUhSXBo7q+g77wjXyM51xQMco470t3llqWjlF6b849pM1Q/1Hq0vSIDi4H8z8PCPH9dkE4Z
 SGhZMckvYuC3n4KNazdRQS0337/EYUsNmS4CkY7snDfeF/Zo8r27/XiCKxO4aYuDLTVG6E0NkdR
 1D+Wqs4VZfFJJ8GTPArtax+sqSxgejUTh6VCBjFL/rqS0MLHmFVQlz2uDSRphRxwsu0D7jgTfet
 ZPVBYhMFuMz+qRJOw0r59JUdNPBmDHbzeZtpm6BBM71xPJZi5pVJ3MaiGlzGpwx9CgpRIEbcYhK
 0rStJijAa+RFpW5L8pY+3OiBmV5Vw9ypC+c44EkOd4lGY2AGIVtl0Xx6WC4PLBOa71+YYxDp/R9
 GCV6r3IwdC1MOtSHmgw==
X-Proofpoint-GUID: NISZlFUxOdsXww8dU8MaOylENmFe0h6i
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4bb264 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=j3PXfpA4_7De4rqNWBgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Include '_gdbstub_' in the AccelOpsClass handlers to emphasize
we are handling gdbstub-related requests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-26-philmd@oss.qualcomm.com>
---
 accel/kvm/kvm-cpus.h          | 11 ++++++++---
 include/accel/accel-cpu-ops.h |  9 ++++++---
 include/system/hvf_int.h      |  9 ++++++---
 include/system/kvm.h          |  9 ++++++---
 target/arm/internals.h        |  5 +++--
 accel/hvf/hvf-accel-ops.c     | 20 +++++++++++---------
 accel/kvm/kvm-accel-ops.c     |  6 +++---
 accel/kvm/kvm-all.c           | 14 ++++++++------
 accel/tcg/tcg-accel-ops.c     | 16 +++++++++-------
 gdbstub/system.c              | 12 ++++++------
 target/arm/hvf/hvf.c          | 12 +++++++-----
 target/arm/hyp_gdbstub.c      |  8 ++++----
 target/arm/kvm.c              | 12 +++++++-----
 target/i386/hvf/hvf.c         |  8 +++++---
 target/i386/kvm/kvm.c         | 12 +++++++-----
 target/loongarch/kvm/kvm.c    |  8 +++++---
 target/ppc/kvm.c              | 12 +++++++-----
 target/riscv/kvm/kvm-cpu.c    |  8 +++++---
 target/s390x/kvm/kvm.c        |  8 +++++---
 19 files changed, 118 insertions(+), 81 deletions(-)

diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index 3185659562d..bc2dd82e68e 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -10,13 +10,18 @@
 #ifndef KVM_CPUS_H
 #define KVM_CPUS_H
 
+#include "gdbstub/enums.h"
+
 int kvm_init_vcpu(CPUState *cpu, Error **errp);
 int kvm_cpu_exec(CPUState *cpu);
 void kvm_destroy_vcpu(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
-int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
-int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
-void kvm_remove_all_breakpoints(CPUState *cpu);
+int kvm_insert_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
+                                  vaddr addr, vaddr len);
+int kvm_remove_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
+                                  vaddr addr, vaddr len);
+void kvm_remove_all_gdbstub_breakpoints(CPUState *cpu);
+
 #endif /* KVM_CPUS_H */
diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index b23a0606c7e..f0c7ee7542c 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -13,6 +13,7 @@
 #include "qemu/accel.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
+#include "gdbstub/enums.h"
 
 #define ACCEL_OPS_SUFFIX "-ops"
 #define TYPE_ACCEL_OPS "accel" ACCEL_OPS_SUFFIX
@@ -85,9 +86,11 @@ struct AccelOpsClass {
 
     /* gdbstub hooks */
     int (*update_guest_debug)(CPUState *cpu);
-    int (*insert_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
-    int (*remove_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
-    void (*remove_all_breakpoints)(CPUState *cpu);
+    int (*insert_gdbstub_breakpoint)(CPUState *cpu, GdbBreakpointType type,
+                                     vaddr addr, vaddr len);
+    int (*remove_gdbstub_breakpoint)(CPUState *cpu, GdbBreakpointType type,
+                                     vaddr addr, vaddr len);
+    void (*remove_all_gdbstub_breakpoints)(CPUState *cpu);
 };
 
 void generic_handle_interrupt(CPUState *cpu, int mask);
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d64f4942556..a01691ce172 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -13,6 +13,7 @@
 
 #include "qemu/queue.h"
 #include "exec/vaddr.h"
+#include "gdbstub/enums.h"
 #include "qom/object.h"
 #include "accel/accel-ops.h"
 
@@ -91,9 +92,11 @@ int hvf_sw_breakpoints_active(CPUState *cpu);
 
 int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
 int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
-int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
-void hvf_arch_remove_all_hw_breakpoints(void);
+int hvf_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type);
+int hvf_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type);
+void hvf_arch_remove_all_gdbstub_hw_breakpoints(void);
 
 /*
  * hvf_update_guest_debug:
diff --git a/include/system/kvm.h b/include/system/kvm.h
index cdd1856ac5f..714b8c7b011 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -17,6 +17,7 @@
 #define QEMU_KVM_H
 
 #include "exec/memattrs.h"
+#include "gdbstub/enums.h"
 #include "qemu/accel.h"
 #include "accel/accel-route.h"
 #include "qom/object.h"
@@ -412,9 +413,11 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cpu,
                                   struct kvm_sw_breakpoint *bp);
 int kvm_arch_remove_sw_breakpoint(CPUState *cpu,
                                   struct kvm_sw_breakpoint *bp);
-int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
-int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
-void kvm_arch_remove_all_hw_breakpoints(void);
+int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type);
+int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type);
+void kvm_arch_remove_all_gdbstub_hw_breakpoints(void);
 
 void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fcce3804f34..067c3f2b8bb 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -29,6 +29,7 @@
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "exec/memop.h"
+#include "gdbstub/enums.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/tb-cpu-state.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -1968,8 +1969,8 @@ int delete_hw_breakpoint(vaddr pc);
 
 bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
-int insert_hw_watchpoint(vaddr addr, vaddr len, int type);
-int delete_hw_watchpoint(vaddr addr, vaddr len, int type);
+int insert_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type);
+int delete_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type);
 
 /* Return the current value of the system counter in ticks */
 uint64_t gt_get_countervalue(CPUARMState *env);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ecc0cd1b558..d2276d8513e 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -233,7 +233,8 @@ int hvf_update_guest_debug(CPUState *cpu)
     return 0;
 }
 
-static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
+static int hvf_insert_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
+                                         vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
     int err;
@@ -256,7 +257,7 @@ static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 
         QTAILQ_INSERT_HEAD(&hvf_state->hvf_sw_breakpoints, bp, entry);
     } else {
-        err = hvf_arch_insert_hw_breakpoint(addr, len, type);
+        err = hvf_arch_insert_gdbstub_hw_breakpoint(addr, len, type);
         if (err) {
             return err;
         }
@@ -271,7 +272,8 @@ static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
     return 0;
 }
 
-static int hvf_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
+static int hvf_remove_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
+                                         vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
     int err;
@@ -295,7 +297,7 @@ static int hvf_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
         QTAILQ_REMOVE(&hvf_state->hvf_sw_breakpoints, bp, entry);
         g_free(bp);
     } else {
-        err = hvf_arch_remove_hw_breakpoint(addr, len, type);
+        err = hvf_arch_remove_gdbstub_hw_breakpoint(addr, len, type);
         if (err) {
             return err;
         }
@@ -310,7 +312,7 @@ static int hvf_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
     return 0;
 }
 
-static void hvf_remove_all_breakpoints(CPUState *cpu)
+static void hvf_remove_all_gdbstub_breakpoints(CPUState *cpu)
 {
     struct hvf_sw_breakpoint *bp, *next;
     CPUState *tmpcpu;
@@ -328,7 +330,7 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
         QTAILQ_REMOVE(&hvf_state->hvf_sw_breakpoints, bp, entry);
         g_free(bp);
     }
-    hvf_arch_remove_all_hw_breakpoints();
+    hvf_arch_remove_all_gdbstub_hw_breakpoints();
 
     CPU_FOREACH(cpu) {
         hvf_update_guest_debug(cpu);
@@ -365,9 +367,9 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_state = hvf_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = hvf_cpu_synchronize_pre_loadvm;
 
-    ops->insert_breakpoint = hvf_insert_breakpoint;
-    ops->remove_breakpoint = hvf_remove_breakpoint;
-    ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
+    ops->insert_gdbstub_breakpoint = hvf_insert_gdbstub_breakpoint;
+    ops->remove_gdbstub_breakpoint = hvf_remove_gdbstub_breakpoint;
+    ops->remove_all_gdbstub_breakpoints = hvf_remove_all_gdbstub_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
 
     ops->get_vcpu_stats = hvf_get_vcpu_stats;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 45330327909..c8e7aa38709 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -107,9 +107,9 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
-    ops->insert_breakpoint = kvm_insert_breakpoint;
-    ops->remove_breakpoint = kvm_remove_breakpoint;
-    ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
+    ops->insert_gdbstub_breakpoint = kvm_insert_gdbstub_breakpoint;
+    ops->remove_gdbstub_breakpoint = kvm_remove_gdbstub_breakpoint;
+    ops->remove_all_gdbstub_breakpoints = kvm_remove_all_gdbstub_breakpoints;
 #endif
 }
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b03488ebac3..feffca0d82d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3826,7 +3826,8 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     return data.err;
 }
 
-int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
+int kvm_insert_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
+                                  vaddr addr, vaddr len)
 {
     struct kvm_sw_breakpoint *bp;
     int err;
@@ -3849,7 +3850,7 @@ int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 
         QTAILQ_INSERT_HEAD(&cpu->kvm_state->kvm_sw_breakpoints, bp, entry);
     } else {
-        err = kvm_arch_insert_hw_breakpoint(addr, len, type);
+        err = kvm_arch_insert_gdbstub_hw_breakpoint(addr, len, type);
         if (err) {
             return err;
         }
@@ -3864,7 +3865,8 @@ int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
     return 0;
 }
 
-int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
+int kvm_remove_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
+                                  vaddr addr, vaddr len)
 {
     struct kvm_sw_breakpoint *bp;
     int err;
@@ -3888,7 +3890,7 @@ int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
         QTAILQ_REMOVE(&cpu->kvm_state->kvm_sw_breakpoints, bp, entry);
         g_free(bp);
     } else {
-        err = kvm_arch_remove_hw_breakpoint(addr, len, type);
+        err = kvm_arch_remove_gdbstub_hw_breakpoint(addr, len, type);
         if (err) {
             return err;
         }
@@ -3903,7 +3905,7 @@ int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
     return 0;
 }
 
-void kvm_remove_all_breakpoints(CPUState *cpu)
+void kvm_remove_all_gdbstub_breakpoints(CPUState *cpu)
 {
     struct kvm_sw_breakpoint *bp, *next;
     KVMState *s = cpu->kvm_state;
@@ -3921,7 +3923,7 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
         QTAILQ_REMOVE(&s->kvm_sw_breakpoints, bp, entry);
         g_free(bp);
     }
-    kvm_arch_remove_all_hw_breakpoints();
+    kvm_arch_remove_all_gdbstub_hw_breakpoints();
 
     CPU_FOREACH(cpu) {
         kvm_update_guest_debug(cpu, 0);
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 1043fc61874..560fe2554ba 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -110,7 +110,7 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
 }
 
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
-static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
+static inline int xlat_gdb_type(CPUState *cpu, GdbBreakpointType gdbtype)
 {
     static const int xlat[] = {
         [GDB_WATCHPOINT_WRITE]  = BP_GDB | BP_MEM_WRITE,
@@ -126,7 +126,8 @@ static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
     return cputype;
 }
 
-static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
+static int tcg_insert_gdbstub_breakpoint(CPUState *cs, GdbBreakpointType type,
+                                         vaddr addr, vaddr len)
 {
     CPUState *cpu;
     int err = 0;
@@ -157,7 +158,8 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     }
 }
 
-static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
+static int tcg_remove_gdbstub_breakpoint(CPUState *cs, GdbBreakpointType type,
+                                         vaddr addr, vaddr len)
 {
     CPUState *cpu;
     int err = 0;
@@ -188,7 +190,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     }
 }
 
-static void tcg_remove_all_breakpoints(CPUState *cpu)
+static void tcg_remove_all_gdbstub_breakpoints(CPUState *cpu)
 {
     cpu_breakpoint_remove_all(cpu, BP_GDB);
     cpu_watchpoint_remove_all(cpu, BP_GDB);
@@ -216,9 +218,9 @@ static void tcg_accel_ops_init(AccelClass *ac)
     }
 
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
-    ops->insert_breakpoint = tcg_insert_breakpoint;
-    ops->remove_breakpoint = tcg_remove_breakpoint;
-    ops->remove_all_breakpoints = tcg_remove_all_breakpoints;
+    ops->insert_gdbstub_breakpoint = tcg_insert_gdbstub_breakpoint;
+    ops->remove_gdbstub_breakpoint = tcg_remove_gdbstub_breakpoint;
+    ops->remove_all_gdbstub_breakpoints = tcg_remove_all_gdbstub_breakpoints;
 }
 
 static void tcg_accel_ops_class_init(ObjectClass *oc, const void *data)
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 6e2dbc823e3..3098fd55740 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -627,8 +627,8 @@ int gdb_breakpoint_insert(CPUState *cs, GdbBreakpointType type,
                           vaddr addr, vaddr len)
 {
     const AccelOpsClass *ops = cpus_get_accel();
-    if (ops->insert_breakpoint) {
-        return ops->insert_breakpoint(cs, type, addr, len);
+    if (ops->insert_gdbstub_breakpoint) {
+        return ops->insert_gdbstub_breakpoint(cs, type, addr, len);
     }
     return -ENOSYS;
 }
@@ -637,8 +637,8 @@ int gdb_breakpoint_remove(CPUState *cs, GdbBreakpointType type,
                           vaddr addr, vaddr len)
 {
     const AccelOpsClass *ops = cpus_get_accel();
-    if (ops->remove_breakpoint) {
-        return ops->remove_breakpoint(cs, type, addr, len);
+    if (ops->remove_gdbstub_breakpoint) {
+        return ops->remove_gdbstub_breakpoint(cs, type, addr, len);
     }
     return -ENOSYS;
 }
@@ -646,8 +646,8 @@ int gdb_breakpoint_remove(CPUState *cs, GdbBreakpointType type,
 void gdb_breakpoint_remove_all(CPUState *cs)
 {
     const AccelOpsClass *ops = cpus_get_accel();
-    if (ops->remove_all_breakpoints) {
-        ops->remove_all_breakpoints(cs);
+    if (ops->remove_all_gdbstub_breakpoints) {
+        ops->remove_all_gdbstub_breakpoints(cs);
     }
 }
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e16457c3cfb..d5b1966a867 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2726,7 +2726,8 @@ int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
     return 0;
 }
 
-int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+int hvf_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -2734,13 +2735,14 @@ int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_ACCESS:
-        return insert_hw_watchpoint(addr, len, type);
+        return insert_gdbstub_hw_watchpoint(addr, len, type);
     default:
         return -ENOSYS;
     }
 }
 
-int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+int hvf_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -2748,13 +2750,13 @@ int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_ACCESS:
-        return delete_hw_watchpoint(addr, len, type);
+        return delete_gdbstub_hw_watchpoint(addr, len, type);
     default:
         return -ENOSYS;
     }
 }
 
-void hvf_arch_remove_all_hw_breakpoints(void)
+void hvf_arch_remove_all_gdbstub_hw_breakpoints(void)
 {
     if (cur_hw_wps > 0) {
         g_array_remove_range(hw_watchpoints, 0, cur_hw_wps);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index bb5969720ce..dda6946ddaa 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -94,7 +94,7 @@ int delete_hw_breakpoint(vaddr pc)
 }
 
 /**
- * insert_hw_watchpoint()
+ * insert_gdbstub_hw_watchpoint()
  * @addr: address of watch point
  * @len: size of area
  * @type: type of watch point
@@ -125,7 +125,7 @@ int delete_hw_breakpoint(vaddr pc)
  * need to ensure you mask the address as required and set BAS=0xff
  */
 
-int insert_hw_watchpoint(vaddr addr, vaddr len, int type)
+int insert_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type)
 {
     HWWatchpoint wp = {
         .wcr = R_DBGWCR_E_MASK, /* E=1, enable */
@@ -208,13 +208,13 @@ bool check_watchpoint_in_range(int i, vaddr addr)
 }
 
 /**
- * delete_hw_watchpoint()
+ * delete_gdbstub_hw_watchpoint()
  * @addr: address of breakpoint
  *
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
+int delete_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type)
 {
     int i;
     for (i = 0; i < cur_hw_wps; i++) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a54ef51ec2a..01f42f42538 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1784,7 +1784,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
         "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
 }
 
-int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -1793,13 +1794,14 @@ int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_ACCESS:
-        return insert_hw_watchpoint(addr, len, type);
+        return insert_gdbstub_hw_watchpoint(addr, len, type);
     default:
         return -ENOSYS;
     }
 }
 
-int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -1807,13 +1809,13 @@ int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_ACCESS:
-        return delete_hw_watchpoint(addr, len, type);
+        return delete_gdbstub_hw_watchpoint(addr, len, type);
     default:
         return -ENOSYS;
     }
 }
 
-void kvm_arch_remove_all_hw_breakpoints(void)
+void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
 {
     if (cur_hw_wps > 0) {
         g_array_remove_range(hw_watchpoints, 0, cur_hw_wps);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 19ad64a1d93..150598418e2 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1049,17 +1049,19 @@ int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
     return -ENOSYS;
 }
 
-int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+int hvf_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     return -ENOSYS;
 }
 
-int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+int hvf_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     return -ENOSYS;
 }
 
-void hvf_arch_remove_all_hw_breakpoints(void)
+void hvf_arch_remove_all_gdbstub_hw_breakpoints(void)
 {
 }
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 64cc421abe6..1e09155e92c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6159,12 +6159,12 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 static struct {
     target_ulong addr;
     int len;
-    int type;
+    GdbBreakpointType type;
 } hw_breakpoint[4];
 
 static int nb_hw_breakpoint;
 
-static int find_hw_breakpoint(target_ulong addr, int len, int type)
+static int find_hw_breakpoint(target_ulong addr, int len, GdbBreakpointType type)
 {
     int n;
 
@@ -6177,7 +6177,8 @@ static int find_hw_breakpoint(target_ulong addr, int len, int type)
     return -1;
 }
 
-int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -6217,7 +6218,8 @@ int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
     return 0;
 }
 
-int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     int n;
 
@@ -6231,7 +6233,7 @@ int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
     return 0;
 }
 
-void kvm_arch_remove_all_hw_breakpoints(void)
+void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
 {
     nb_hw_breakpoint = 0;
 }
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d6539c12acd..beda6965f8c 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1418,17 +1418,19 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     return 0;
 }
 
-int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     return -ENOSYS;
 }
 
-int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     return -ENOSYS;
 }
 
-void kvm_arch_remove_all_hw_breakpoints(void)
+void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
 {
 }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b94c2997a07..93ec0cf6a72 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -455,7 +455,7 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 
 static struct HWBreakpoint {
     target_ulong addr;
-    int type;
+    GdbBreakpointType type;
 } hw_debug_points[MAX_HW_BKPTS];
 
 static CPUWatchpoint hw_watchpoint;
@@ -1412,7 +1412,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     return 0;
 }
 
-static int find_hw_breakpoint(target_ulong addr, int type)
+static int find_hw_breakpoint(target_ulong addr, GdbBreakpointType type)
 {
     int n;
 
@@ -1454,7 +1454,8 @@ static int find_hw_watchpoint(target_ulong addr, int *flag)
     return -1;
 }
 
-int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     const unsigned breakpoint_index = nb_hw_breakpoint + nb_hw_watchpoint;
     if (breakpoint_index >= ARRAY_SIZE(hw_debug_points)) {
@@ -1498,7 +1499,8 @@ int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
     return 0;
 }
 
-int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     int n;
 
@@ -1526,7 +1528,7 @@ int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
     return 0;
 }
 
-void kvm_arch_remove_all_hw_breakpoints(void)
+void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
 {
     nb_hw_breakpoint = nb_hw_watchpoint = 0;
 }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 39d48a9db4d..2a5440d5846 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2215,19 +2215,21 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     return 0;
 }
 
-int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     /* TODO; To be implemented later. */
     return -EINVAL;
 }
 
-int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     /* TODO; To be implemented later. */
     return -EINVAL;
 }
 
-void kvm_arch_remove_all_hw_breakpoints(void)
+void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
 {
     /* TODO; To be implemented later. */
 }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index fdef8f9e8ac..195e39df032 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -907,7 +907,8 @@ static int insert_hw_breakpoint(vaddr addr, int len, int type)
     return 0;
 }
 
-int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_insert_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -925,7 +926,8 @@ int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
     return insert_hw_breakpoint(addr, len, type);
 }
 
-int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+int kvm_arch_remove_gdbstub_hw_breakpoint(vaddr addr, vaddr len,
+                                          GdbBreakpointType type)
 {
     int size;
     struct kvm_hw_breakpoint *bp = find_hw_breakpoint(addr, len, type);
@@ -954,7 +956,7 @@ int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
     return 0;
 }
 
-void kvm_arch_remove_all_hw_breakpoints(void)
+void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
 {
     nb_hw_breakpoints = 0;
     g_free(hw_breakpoints);
-- 
2.53.0


