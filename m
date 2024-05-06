Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FBCC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40Jt-0007jx-LZ; Mon, 06 May 2024 11:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jp-0007hH-Rn
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:59 -0400
Received: from wfhigh1-smtp.messagingengine.com ([64.147.123.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jm-0003Oy-Rs
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id 80DE218000D3;
 Mon,  6 May 2024 11:31:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 06 May 2024 11:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715009513;
 x=1715095913; bh=zSuWjtonhAvpP4vNszbrhHmYCXZDb4UBfgKX0cnoSL0=; b=
 rbaLDADTSjnTGw0axYkJbC7X/MZhZfIKK6klrN6qvoNSahUg4DdVooXLQL2Xa7nl
 R9qntdRhKSoyJWup5zXHVNqeZB/afdRhBJnsWfrKocs8bNzU2bqSN9rVp3gMt+lA
 NY+LW+/ltQONAM06IWcDvdAi6v+bbVTmz5D7FFg5qC/dB2x0dR67CCfpUtJm95Ov
 ExXJTwRvjMjFyVasijTOL7F3yMaB6SxlaSGgxjcl48wq30spjdl8MYq3MhlJlAQJ
 1Nsd5+//tIxzH+XePb6UujgKRHhPkaDlft07VynnIuVAF2lje+x0BsQqj5Pqku0t
 GBf5gHI9JtV92aRLZ5Av4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715009513; x=
 1715095913; bh=zSuWjtonhAvpP4vNszbrhHmYCXZDb4UBfgKX0cnoSL0=; b=R
 kFXBLFY+HAwKlQp996KoSZ5rJ8F4jUqzVOZCnJbLhGN9AI0zxEJ0nGnpi/6u0zOV
 wdA1K8WgtxRk2NkmfIS4sPUsJKGMgaL2Un7W5NbPsgBBgdIrgQ7glwxTDOt2jaJL
 Pn1chn2iwMQRFpO+1uzE2QcvbPvPQzSCXSZkGUciO2ZHlZxpIcEPFdHOoW+SUNtq
 q4KFEbaDK7taH41gZFb2HZVsBvLaL8AYiqeBVbImiLBiTARlxRWk8+5nLbb8jEAT
 3ahDgX04vOAQYh/oY2zkDyO9ooACaJNBzx0g0MuHvtyjU2wGyWOVM7TiryTtLPAm
 HxZMLwPGilTMdrtwup/5Q==
X-ME-Sender: <xms:6Pc4ZsF0hKZe34eRwYHwXyfAdB7piiJ7Nf6LnlZBr9dyT6pMSakNHg>
 <xme:6Pc4ZlU4LS9Wi9P_pl3zwz-rQKZZzdaaXXWBInLjBv_1WHkfiZpOZN1db5HoXvnIF
 1Nq0VTs77iyngEaHYM>
X-ME-Received: <xmr:6Pc4ZmKymVI0HHIC-5HC3M0fMCngb4Jh2Q64D1YHoZTmgYm1dsY3Gls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:6Pc4ZuFr8PQ5WL9ZeSiNlfQkrlbYwqtfAY89FcXxAMP_ufMzwrp6Iw>
 <xmx:6fc4ZiXZ-RgQZt0gh4lMSArk8thAJ6mnMfgKtAC9snXZlG1wcBtfVg>
 <xmx:6fc4ZhNPe-BlfZXnyHIcXjgU1s-8-IX4Ss18Phq2l70oc5a3Rj7ZTA>
 <xmx:6fc4Zp1OrS90chXHfxhmmdlnIXXvxaL4xX695ldsNF8WfHPDld55Jw>
 <xmx:6fc4ZhRkaaa2SbpwL-W87hNb4_6DMIHuTjLs6xYM0NB15yOY52g-YVmy>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:31:52 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 06 May 2024 16:31:37 +0100
Subject: [PATCH 3/5] hw/msic/mips_cpc: Implement multi core support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-mips-smp-v1-3-3cc234786910@flygoat.com>
References: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
In-Reply-To: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8389;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=KYFqNiS8gSxVVeBLA/WE1udVx7/n3BTMqPVVrQQtEP4=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSL749/XeFWqRQ43Hu9k8uEmW1FQ6B1zxyZjUovir6KC
 tY9KXHrKGVhEONgkBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgInYZTEyrNy64ePDhut7m3mO
 lbxYyfuF3ZtnT2XKHk9by+r6LW0zVBl+s+wz9fVbYfY34poe4wyZR7cZ1/a5x7YfLUzldjt21ec
 oMwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.152;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement multiple physical core support for MIPS CPC
controller. Including some R/O configuration registers
and VP bring up support on multiple cores.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/misc/mips_cpc.c         | 97 ++++++++++++++++++++++++++++++++++------------
 include/hw/misc/mips_cpc.h | 15 ++++++-
 2 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 1e8fd2e699..f6a2f29088 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -25,9 +25,25 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 
+#include "hw/misc/mips_cmgcr.h"
 #include "hw/misc/mips_cpc.h"
 #include "hw/qdev-properties.h"
 
+static inline int cpc_vpnum_to_corenum(MIPSCPCState *cpc, int vpnum)
+{
+    return vpnum / cpc->num_vp;
+}
+
+static inline int cpc_vpnum_to_vpid(MIPSCPCState *cpc, int vpnum)
+{
+    return vpnum % cpc->num_vp;
+}
+
+static inline MIPSCPCPCoreState *cpc_vpnum_to_pcs(MIPSCPCState *cpc, int vpnum)
+{
+    return &cpc->pcs[cpc_vpnum_to_corenum(cpc, vpnum)];
+}
+
 static inline uint64_t cpc_vp_run_mask(MIPSCPCState *cpc)
 {
     return (1ULL << cpc->num_vp) - 1;
@@ -39,36 +55,41 @@ static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
 
     cpu_reset(cs);
     cs->halted = 0;
-    cpc->vp_running |= 1ULL << cs->cpu_index;
+    cpc_vpnum_to_pcs(cpc, cs->cpu_index)->vp_running |=
+            1 << cpc_vpnum_to_vpid(cpc, cs->cpu_index);
 }
 
-static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
+static void cpc_run_vp(MIPSCPCState *cpc, int pcore, uint64_t vp_run)
 {
-    CPUState *cs = first_cpu;
+    MIPSCPCPCoreState *pcs = &cpc->pcs[pcore];
 
-    CPU_FOREACH(cs) {
-        uint64_t i = 1ULL << cs->cpu_index;
-        if (i & vp_run & ~cpc->vp_running) {
+    for (int vpid = 0; vpid < cpc->num_vp; vpid++) {
+        if ((1 << vpid) & vp_run & ~pcs->vp_running) {
+            int vpnum = pcore * cpc->num_vp + vpid;
             /*
              * To avoid racing with a CPU we are just kicking off.
              * We do the final bit of preparation for the work in
              * the target CPUs context.
              */
-            async_safe_run_on_cpu(cs, mips_cpu_reset_async_work,
-                                  RUN_ON_CPU_HOST_PTR(cpc));
+            async_safe_run_on_cpu(qemu_get_cpu(vpnum),
+                                    mips_cpu_reset_async_work,
+                                    RUN_ON_CPU_HOST_PTR(cpc));
+            pcs->vp_running |= 1 << vpid;
         }
     }
 }
 
-static void cpc_stop_vp(MIPSCPCState *cpc, uint64_t vp_stop)
+static void cpc_stop_vp(MIPSCPCState *cpc, int pcore, uint64_t vp_stop)
 {
-    CPUState *cs = first_cpu;
+    MIPSCPCPCoreState *pcs = &cpc->pcs[pcore];
+
+    for (int vpid = 0; vpid < cpc->num_vp; vpid++) {
+        if ((1 << vpid) & vp_stop & pcs->vp_running) {
+            int vpnum = pcore * cpc->num_vp + vpid;
+            CPUState *cs = qemu_get_cpu(vpnum);
 
-    CPU_FOREACH(cs) {
-        uint64_t i = 1ULL << cs->cpu_index;
-        if (i & vp_stop & cpc->vp_running) {
             cpu_interrupt(cs, CPU_INTERRUPT_HALT);
-            cpc->vp_running &= ~i;
+            pcs->vp_running &= ~(1 << vpid);
         }
     }
 }
@@ -77,15 +98,20 @@ static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
                       unsigned size)
 {
     MIPSCPCState *s = opaque;
+    int current_corenum = cpc_vpnum_to_corenum(s, current_cpu->cpu_index);
 
     switch (offset) {
     case CPC_CL_BASE_OFS + CPC_VP_RUN_OFS:
+        cpc_run_vp(s, current_corenum, data);
+        break;
     case CPC_CO_BASE_OFS + CPC_VP_RUN_OFS:
-        cpc_run_vp(s, data & cpc_vp_run_mask(s));
+        cpc_run_vp(s, mips_gcr_get_redirect_corenum(s->gcr), data);
         break;
     case CPC_CL_BASE_OFS + CPC_VP_STOP_OFS:
+        cpc_stop_vp(s, current_corenum, data);
+        break;
     case CPC_CO_BASE_OFS + CPC_VP_STOP_OFS:
-        cpc_stop_vp(s, data & cpc_vp_run_mask(s));
+        cpc_stop_vp(s, mips_gcr_get_redirect_corenum(s->gcr), data);
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
@@ -101,9 +127,13 @@ static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
     MIPSCPCState *s = opaque;
 
     switch (offset) {
+    case CPC_CL_BASE_OFS + CPC_CL_STAT_CONF_OFS:
+    case CPC_CO_BASE_OFS + CPC_CL_STAT_CONF_OFS:
+        return CPC_CL_STAT_CONF_SEQ_STATE_U6 << CPC_CL_STAT_CONF_SEQ_STATE_SHF;
     case CPC_CL_BASE_OFS + CPC_VP_RUNNING_OFS:
+        return cpc_vpnum_to_pcs(s, current_cpu->cpu_index)->vp_running;
     case CPC_CO_BASE_OFS + CPC_VP_RUNNING_OFS:
-        return s->vp_running;
+        return s->pcs[mips_gcr_get_redirect_corenum(s->gcr)].vp_running;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: Bad offset 0x%x\n",  __func__, (int)offset);
@@ -137,9 +167,11 @@ static void mips_cpc_realize(DeviceState *dev, Error **errp)
     if (s->vp_start_running > cpc_vp_run_mask(s)) {
         error_setg(errp,
                    "incorrect vp_start_running 0x%" PRIx64 " for num_vp = %d",
-                   s->vp_running, s->num_vp);
+                   s->vp_start_running, s->num_vp);
         return;
     }
+
+    s->pcs = g_new(MIPSCPCPCoreState, s->num_pcores);
 }
 
 static void mips_cpc_reset(DeviceState *dev)
@@ -147,25 +179,40 @@ static void mips_cpc_reset(DeviceState *dev)
     MIPSCPCState *s = MIPS_CPC(dev);
 
     /* Reflect the fact that all VPs are halted on reset */
-    s->vp_running = 0;
+    for (int i = 0; i < s->num_pcores; i++) {
+        s->pcs[i].vp_running = 0;
+    }
 
-    /* Put selected VPs into run state */
-    cpc_run_vp(s, s->vp_start_running);
+    /* Put selected VPs on core 0 into run state */
+    cpc_run_vp(s, 0, s->vp_start_running);
 }
 
-static const VMStateDescription vmstate_mips_cpc = {
-    .name = "mips-cpc",
+static const VMStateDescription vmstate_mips_cpc_pcs = {
+    .name = "mips-cpc/pcs",
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(vp_running, MIPSCPCState),
+        VMSTATE_UINT64(vp_running, MIPSCPCPCoreState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_mips_cpc = {
+    .name = "mips-cpc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_ALLOC(pcs, MIPSCPCState, num_pcores, 0,
+                                    vmstate_mips_cpc_pcs, MIPSCPCPCoreState),
         VMSTATE_END_OF_LIST()
     },
 };
 
 static Property mips_cpc_properties[] = {
-    DEFINE_PROP_UINT32("num-vp", MIPSCPCState, num_vp, 0x1),
+    DEFINE_PROP_INT32("num-vp", MIPSCPCState, num_vp, 0x1),
+    DEFINE_PROP_INT32("num-pcore", MIPSCPCState, num_pcores, 0x1),
     DEFINE_PROP_UINT64("vp-start-running", MIPSCPCState, vp_start_running, 0x1),
+    DEFINE_PROP_LINK("gcr", MIPSCPCState, gcr, TYPE_MIPS_GCR, MIPSGCRState *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index fcafbd5e00..e88acf4681 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -30,6 +30,10 @@
 #define CPC_CO_BASE_OFS     0x4000
 
 /* CPC register offsets relative to block offsets */
+#define CPC_CL_CMD_OFS      0x00
+#define CPC_CL_STAT_CONF_OFS    0x08
+#define CPC_CL_STAT_CONF_SEQ_STATE_SHF  19
+#define CPC_CL_STAT_CONF_SEQ_STATE_U6   7
 #define CPC_VP_STOP_OFS     0x20
 #define CPC_VP_RUN_OFS      0x28
 #define CPC_VP_RUNNING_OFS  0x30
@@ -37,14 +41,21 @@
 #define TYPE_MIPS_CPC "mips-cpc"
 OBJECT_DECLARE_SIMPLE_TYPE(MIPSCPCState, MIPS_CPC)
 
+typedef struct MIPSCPCPCoreState MIPSCPCPCoreState;
+struct MIPSCPCPCoreState {
+    uint64_t vp_running;
+};
+
 struct MIPSCPCState {
     SysBusDevice parent_obj;
 
-    uint32_t num_vp;
+    int32_t num_pcores;
+    int32_t num_vp;
     uint64_t vp_start_running; /* VPs running from restart */
+    MIPSGCRState *gcr;
 
     MemoryRegion mr;
-    uint64_t vp_running; /* Indicates which VPs are in the run state */
+    MIPSCPCPCoreState *pcs;
 };
 
 #endif /* MIPS_CPC_H */

-- 
2.34.1


