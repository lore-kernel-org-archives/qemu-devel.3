Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57570C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegbm-0003Gl-LS; Tue, 30 Jun 2026 18:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZl-0005sn-H7
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZZ-0004ZU-CA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDc7s2920060
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Ws6dQvdsXQmipKgaBrKPksVyQjTVfHzk6V1qVaW2HA=; b=C11j6E1AZvk5Ge0p
 wlgWoUVSeyb9ATAWQkDsEWunT3LccLQnSPuB9zgRUjyLoJ4sshGMgcVrAGJ8IJoM
 Q3DnwAh0TxZcfxs2lOQ2JglH3740sVKbj9/RFbTvL9bXO4SkRhORUT7AJifB8+JX
 ojwIMzQiYNza7qMsdiT9JbSx4hAnC38ui5XZQQG7gUlp9uoEG8wgojnn40/zx51L
 JEioIsG+O4db1PymHPt7fRaGQfDR8S6HhsXcXoJKVmro7t2U2GqnEqwIFDT7eNOX
 4mll+RYcSUJrhr1mm7kdGaWiQP4je2DBSERxqbX+TbZSdmRoAc06nKjkmqsKO0XN
 eaiPuQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvw8unc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e59b0e0f4so231357485a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857081; x=1783461881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ws6dQvdsXQmipKgaBrKPksVyQjTVfHzk6V1qVaW2HA=;
 b=NwvTJNa8fUNQWeYGgtk0XG/+kBb9RkhB3cDd1+QdwUzPNMus7gM4pmmD4mf/3ZFy8z
 NSm9CfdYCYEkUwDravodzDis0VFQ1LtRZZKfkvDMfbGF/91vdCNl47wCqq58olBTVlDg
 YpJmoGJstdw0O0tKa892p9Xu4rJ8wvgO2ZR8e0p0x98Dx341m/rXog/5goricU8p0XIo
 D7/o46vht5cE7xWm3mD80yFKy62jfdsqr+DoKG8EAERKXqcHEu37mshkuUjHhkumC0u/
 Ig8i2bfkW3gVCTC/jD46HZqxFOYTey1lJU3Aj8eD/7hxRjFG7EQNNDsGANz/lwWFgkfW
 4v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857081; x=1783461881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Ws6dQvdsXQmipKgaBrKPksVyQjTVfHzk6V1qVaW2HA=;
 b=g8p84PBuIaV5my40HPqXiuJrt9sHJu87xXSCzVpl+dx8JQCh2AL7BI8DQ/HVT5UNRG
 0UVhvdGn+zDjOl00OxIZvVavtabBFHNQ9kQR5/PaKxmEhlMU2jxcPkLP0hZmpusHhJiW
 aheyEjIjLsKwESqr/bVAHUBSK2UE10S3S/80XcwNnoH3CQ6yP2gaCRjM7Q1jQtmFb7hL
 +POmldxpwivbCD01mDcUKTdr3Dkrbh3+BcLg9JW2Qy36x7Qyo409JN+h0UrBYOQWlbi6
 dA8szTDfOcm2gh++rP61bredtPNigQ6M7gVA9owJSC5vVRUnfKQBTQaS+tfj/rT39ged
 YYVA==
X-Gm-Message-State: AOJu0Yxfp4PJLdp3X8isY2eW5AVQVn8rwvEcEoz57OJeTv74/SGYbE3j
 ruLcYiy+YT4amHRKL0FXI6YS55B8zrJVNkQMf3aySiuwKodmow3k8sJxCrtX9qnDOQEGjBYNVe+
 /GetBzV1U3s2pDy5d4yX97BWlLaDo2obDrAWjQBC30nszWijkrurd8Gt71lmrhuW+xA==
X-Gm-Gg: AfdE7clGrp8ouu/UIlU5rQR/LDrsj2DnbeedRxV2FdAzzjqgR6QzZqmkeuGbCsw0cpp
 FLMmq/3Jo0nU6fSV6Tk84SSqj2UwAH+hEBkNurQ1+inrOAmmbcm+dHp+8fIpdFnOt2v3X33CCJz
 XtfcF3Y/17Mp9FCeV/aaeFfFrGOfXseluaz7M2tZga88USpVziqQzvsugR/dZO3Wmp/PJeRVuns
 s1qTeTnNEROEUZXhQyokDVJ5e09zEQFrVGuTPJtVuA9YhCrvjVQ7HnFG9OKJtwTJGaWxtV6/5lc
 svKvMQsDsdVpxYl70sqDMrqlmGihH/0HYmEyG4+5KlpkIG2X0lw3SdzK3uXJVo6w3VT+npzaLdx
 lFpojUnQuU8B8FW952AWcP6kZP2e18qXbglYDDfyNwGok7BPTqCi0zBl7BmBKHCS9RXyK
X-Received: by 2002:a05:620a:261d:b0:92e:54b1:2881 with SMTP id
 af79cd13be357-92e624a24ecmr899078485a.16.1782857081323; 
 Tue, 30 Jun 2026 15:04:41 -0700 (PDT)
X-Received: by 2002:a05:620a:261d:b0:92e:54b1:2881 with SMTP id
 af79cd13be357-92e624a24ecmr899072485a.16.1782857080854; 
 Tue, 30 Jun 2026 15:04:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756778f015sm11790887f8f.31.2026.06.30.15.04.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:04:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 29/33] cpu: Move CPUWatchpoint definition to
 'exec/watchpoint.h'
Date: Wed,  1 Jul 2026 00:00:56 +0200
Message-ID: <20260630220100.1289-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sHythFUDJOxUX6IkKmM35Ci7YkYLwNhM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfXxcJQepXxxMoH
 zQSehkiM2fG1f184hA+6C1TJlYSihfz3fYVylnmp+8QBi3u6pxEv69DYmaqExtgQ/e3KhKStI/A
 K0uqxopLo0FGf9znAoBfb5JITsW5cwo=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a443d79 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=HjWuKgUHFhC_F9lk5HkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: sHythFUDJOxUX6IkKmM35Ci7YkYLwNhM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX9+1A90k+uAs0
 pvvz0Gj71f2t5JWeG7fGhdYhDnFeH+zrJN7j9CCpX4Z8mhzb2QmChbXWtwYaydssOy5DWtfIWKB
 6/egBMUtwucCPbyIgSjGMYD1Mv3ZT2ELwkpJVwNkgfQCg1mTdPLqsBDIr4OtWTJxVvKvgeVEy2J
 x1E49FTJy7ffA5RRC0CTTAROU9P2W1b2zWBQN02MVJp+pZGOauQQLcV05G7gzZwatNOLcvzoH7c
 pe7uguJI3H/GBJ4CW8JjFECDmNmt5ZYhM7KnoPadZIzbvaGvU8jssadBVowDiLCl+WPDus8Ll6P
 sXa0nfRC4cKuI1Rmr73q+qtouJ06Gdf6XZY5hpsDEWPfONzaTcNMYszejvSK2ivw65fmMjj+fKJ
 9u68GnQbr/rYAZZ1QdHCggYu+HWc3VW0WpxR5fqUe1bsZjuylM5O8DIyA3AQHCDhUYGfH/GDS1C
 bsBl12tnL3begqtoapw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300215
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

Define CPUWatchpoint in "exec/watchpoint.h", including this
header where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h |  1 +
 include/exec/breakpoint.h   |  9 ---------
 include/exec/watchpoint.h   | 12 ++++++++++++
 target/arm/internals.h      |  1 +
 gdbstub/system.c            |  1 +
 target/arm/hyp_gdbstub.c    |  1 +
 target/i386/kvm/kvm.c       |  1 +
 target/ppc/kvm.c            |  1 +
 target/s390x/kvm/kvm.c      |  1 +
 9 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 568d82cdd32..d5994781c39 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -20,6 +20,7 @@
 #include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
+#include "exec/watchpoint.h"
 #include "accel/tcg/tb-cpu-state.h"
 #include "tcg/tcg-mo.h"
 
diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 0c3cc0c8ff3..9d0dd89e7c9 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -33,13 +33,4 @@ typedef struct CPUBreakpoint {
     QTAILQ_ENTRY(CPUBreakpoint) entry;
 } CPUBreakpoint;
 
-typedef struct CPUWatchpoint {
-    vaddr vaddr;
-    vaddr len;
-    vaddr hitaddr;
-    MemTxAttrs hitattrs;
-    int flags; /* BP_* */
-    QTAILQ_ENTRY(CPUWatchpoint) entry;
-} CPUWatchpoint;
-
 #endif
diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
index ba148eff3d1..7b72de35aa5 100644
--- a/include/exec/watchpoint.h
+++ b/include/exec/watchpoint.h
@@ -8,7 +8,19 @@
 #ifndef EXEC_WATCHPOINT_H
 #define EXEC_WATCHPOINT_H
 
+#include "qemu/queue.h"
 #include "exec/breakpoint.h"
+#include "exec/memattrs.h"
+#include "exec/vaddr.h"
+
+typedef struct CPUWatchpoint {
+    vaddr vaddr;
+    vaddr len;
+    vaddr hitaddr;
+    MemTxAttrs hitattrs;
+    BreakpointFlags flags;
+    QTAILQ_ENTRY(CPUWatchpoint) entry;
+} CPUWatchpoint;
 
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           BreakpointFlags flags, CPUWatchpoint **watchpoint);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 067c3f2b8bb..72ef3a2bf9c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -29,6 +29,7 @@
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "exec/memop.h"
+#include "exec/watchpoint.h"
 #include "gdbstub/enums.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/tb-cpu-state.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 108fe4bafb7..3dccd31cbc0 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -19,6 +19,7 @@
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
+#include "exec/watchpoint.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/address-spaces.h"
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index dda6946ddaa..62dd91169dd 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/watchpoint.h"
 #include "cpu.h"
 #include "internals.h"
 #include "gdbstub/enums.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1e09155e92c..372781ae715 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -70,6 +70,7 @@
 #include "migration/blocker.h"
 #include "exec/memattrs.h"
 #include "exec/target_page.h"
+#include "exec/watchpoint.h"
 #include "trace.h"
 
 #include CONFIG_DEVICES
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6bdfbbd68d6..85b15602396 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 #include "gdbstub/enums.h"
 #include "exec/memattrs.h"
+#include "exec/watchpoint.h"
 #include "system/ramblock.h"
 #include "system/hostmem.h"
 #include "qemu/cutils.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 195e39df032..bb329883c97 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -49,6 +49,7 @@
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/ebcdic.h"
 #include "exec/memattrs.h"
+#include "exec/watchpoint.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
 #include "target/s390x/kvm/pv.h"
-- 
2.53.0


