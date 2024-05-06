Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4E7C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40Ju-0007k7-IE; Mon, 06 May 2024 11:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jq-0007hN-Vr
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:59 -0400
Received: from wfout7-smtp.messagingengine.com ([64.147.123.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jl-0003K2-Uv
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id CE5621C00168;
 Mon,  6 May 2024 11:31:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 06 May 2024 11:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715009511;
 x=1715095911; bh=gqjjzC39vWS61HBS72F1U4lFSfSfPey3jLgyUvvD31A=; b=
 hcm5A6yHERFG/K2S6uxuyj6iBe67ISJ/9SDpzrnyok59ByqUrCZCp15KGE6Ce+qv
 4HxbrifmpBSYcXNJ+RKkzmq7T3SG8VOM1cQUUzhQETGVNSAZWm04xDJ2hMkzMpyP
 4a92sCDU+wMFs8byYaLvwsDc0nxLqOdgD6KBAr7jlzA/efHv/rGqRHgTNCpV0b3o
 PbOznPZDURc3S4ifCW89yVhtcCPJUhfSksuqRY901NSOd7nWyYa/2PFZ5EHChbvt
 iPYmwsrJr3984xfIjg94gqBQXBzn3sXdYXjtjEllUO2AxPKWs/d2hXOLVZ10HC5U
 j6tvfHOaE3rcxiPXBJZGVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715009511; x=
 1715095911; bh=gqjjzC39vWS61HBS72F1U4lFSfSfPey3jLgyUvvD31A=; b=L
 0J/L9UE7qP4MD3dHynj72DBshVf3i0G3fbyIKEU/hPFZsUm73QDxaTVej2Xfk5tn
 aKWFXUTB0T3V7GhF0M2QgHhG5TP22Mp6HDbcdb0lqPMmCmONkvKZb/eyBJ5Nf4u6
 /oUIzbaQW0hrYd6Ap9BBTcNPRRFGH0Ez0CFLR8vEcXaq6iu8hAd3DNW/QdUDHgvM
 vtj5XxpTV2iDeoPn7YpnbxDaCeuWfIjGGc90/1lgzrBBiNH0DSSjB7dGsCHuUdGC
 vwAAVS/Ml7aO7PgdKa2vvc5D/DjIiFRdXryZ4E20i14XwCfwcpb13FgBEuhY+Gfb
 ht3znmxRxz0Eey7VICPXA==
X-ME-Sender: <xms:5_c4ZpbzVJtI98DefTATXf8jqo4vMjsZCbAV2dX2DVTnmzfHcxi25g>
 <xme:5_c4ZgaXQmAaLnPD6TJJGj9sgedBpvsJbz4iYIjKIeo06kkyBDlJXGnb-WcIeMQw6
 k0e9gX7DqRvu7HqYo0>
X-ME-Received: <xmr:5_c4Zr8J8jQEtxNMvdK2gDlLQjUARu0LtIX1wQfCcvkjITsu2m-2jH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:5_c4Znosx-JP5sKU3AHErhFDTiESioRgnUkaNITQboiITTiUpkXHGw>
 <xmx:5_c4ZkpQf4mdibhD9dTGCz0OkhbkvXWH2eS4BHWYxBpVfGIHl6cR1Q>
 <xmx:5_c4ZtRHdp6IcwC65uUII0TAR5weR6YCSPMkyxQMqO1N0MjIZrw4Kg>
 <xmx:5_c4Zsqe8j7W1xlz8hpHD5e1hx8VMnH34b1aqikS-TaOfkdbu4IOPA>
 <xmx:5_c4ZvVTKNeMJ53a4rr39Q2n4xodNarBfvvZwhP6-ZLbMZ3VSK-jiBtd>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:31:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 06 May 2024 16:31:36 +0100
Subject: [PATCH 2/5] hw/msic/mips_cmgcr: Implement multicore functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-mips-smp-v1-2-3cc234786910@flygoat.com>
References: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
In-Reply-To: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15709;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=YC6TrlfnKQ28wZCq8QngZ3hZOxnX06cw7yNgHujMLfM=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSL74+1Lob+3OG5Q6rW3+psgH2AzZ+HvK8DN81xDHw58
 0+Kt8TbjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIy7UMf2XWyn87tiNyYkPD
 2dzqCTpLGSfX8T2JkGGrXeHVyH+Vs4OR4ZjPDbv/Al0JUfv1TV/EW/toamzY3XSu7u71herKrqd
 leAE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout7-smtp.messagingengine.com
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

We implemented following functions to allow software
to probe and control VPs on secondary core

- Reading out pcore count and coherence state
- Two scratch GCRs for firmware
- Semaphore GCR for register locking
- Redirect block to other cores

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/misc/mips_cmgcr.c         | 168 +++++++++++++++++++++++++++++++++++--------
 include/hw/misc/mips_cmgcr.h |  87 +++++++++++++++++++---
 2 files changed, 215 insertions(+), 40 deletions(-)

diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 2703040f45..8c2d184f2c 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -73,14 +73,19 @@ static inline void update_gic_base(MIPSGCRState *gcr, uint64_t val)
 static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
 {
     MIPSGCRState *gcr = (MIPSGCRState *) opaque;
-    MIPSGCRVPState *current_vps = &gcr->vps[current_cpu->cpu_index];
-    MIPSGCRVPState *other_vps = &gcr->vps[current_vps->other];
+    int redirect_corenum = mips_gcr_get_redirect_corenum(gcr);
+    int redirect_vpid = mips_gcr_get_redirect_vpid(gcr);
+    int current_corenum = mips_gcr_get_current_corenum(gcr);
+    int current_vpid = mips_gcr_get_current_vpid(gcr);
+    MIPSGCRPCoreState *current_pcore = &gcr->pcs[current_corenum];
+    MIPSGCRVPState *current_vps = &current_pcore->vps[current_vpid];
+    MIPSGCRPCoreState *other_pcore = &gcr->pcs[redirect_corenum];
+    MIPSGCRVPState *other_vps = &other_pcore->vps[redirect_vpid];
 
     switch (addr) {
     /* Global Control Block Register */
     case GCR_CONFIG_OFS:
-        /* Set PCORES to 0 */
-        return 0;
+        return gcr->num_pcores - 1;
     case GCR_BASE_OFS:
         return gcr->gcr_base;
     case GCR_REV_OFS:
@@ -96,7 +101,19 @@ static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
     case GCR_L2_CONFIG_OFS:
         /* L2 BYPASS */
         return GCR_L2_CONFIG_BYPASS_MSK;
+    case GCR_SYS_CONFIG2_OFS:
+        return gcr->num_vps << GCR_SYS_CONFIG2_MAXVP_SHF;
+    case GCR_SCRATCH0_OFS:
+        return gcr->scratch[0];
+    case GCR_SCRATCH1_OFS:
+        return gcr->scratch[1];
+    case GCR_SEM_OFS:
+        return gcr->sem;
         /* Core-Local and Core-Other Control Blocks */
+    case MIPS_CLCB_OFS + GCR_CL_COH_EN_OFS:
+        return current_pcore->coh_en;
+    case MIPS_COCB_OFS + GCR_CL_COH_EN_OFS:
+        return other_pcore->coh_en;
     case MIPS_CLCB_OFS + GCR_CL_CONFIG_OFS:
     case MIPS_COCB_OFS + GCR_CL_CONFIG_OFS:
         /* Set PVP to # of VPs - 1 */
@@ -105,10 +122,18 @@ static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
         return current_vps->reset_base;
     case MIPS_COCB_OFS + GCR_CL_RESETBASE_OFS:
         return other_vps->reset_base;
-    case MIPS_CLCB_OFS + GCR_CL_OTHER_OFS:
-        return current_vps->other;
-    case MIPS_COCB_OFS + GCR_CL_OTHER_OFS:
-        return other_vps->other;
+    case MIPS_CLCB_OFS + GCR_CL_REDIRECT_OFS:
+        return current_vps->redirect;
+    case MIPS_COCB_OFS + GCR_CL_REDIRECT_OFS:
+        return other_vps->redirect;
+    case MIPS_CLCB_OFS + GCR_CL_ID_OFS:
+        return current_corenum;
+    case MIPS_COCB_OFS + GCR_CL_ID_OFS:
+        return redirect_corenum;
+    case MIPS_CLCB_OFS + GCR_CL_SCRATCH_OFS:
+        return current_vps->scratch;
+    case MIPS_COCB_OFS + GCR_CL_SCRATCH_OFS:
+        return other_vps->scratch;
     default:
         qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_PRIx
                       "\n", size, addr);
@@ -123,12 +148,36 @@ static inline target_ulong get_exception_base(MIPSGCRVPState *vps)
     return (int32_t)(vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK);
 }
 
+static inline void set_redirect(MIPSGCRState *gcr,
+                                MIPSGCRVPState *vps, target_ulong data)
+{
+    int new_vpid = data & GCR_CL_REDIRECT_VP_MSK;
+    int new_coreid = (data & GCR_CL_REDIRECT_CORE_MSK) >> GCR_CL_REDIRECT_CORE_SHF;
+
+    if (new_vpid >= gcr->num_vps) {
+        return;
+    }
+
+    if (new_coreid >= gcr->num_pcores) {
+        return;
+    }
+
+    vps->redirect = data & (GCR_CL_REDIRECT_VP_MSK | GCR_CL_REDIRECT_CORE_MSK);
+}
+
 /* Write GCR registers */
 static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
 {
-    MIPSGCRState *gcr = (MIPSGCRState *)opaque;
-    MIPSGCRVPState *current_vps = &gcr->vps[current_cpu->cpu_index];
-    MIPSGCRVPState *other_vps = &gcr->vps[current_vps->other];
+    MIPSGCRState *gcr = (MIPSGCRState *) opaque;
+    int redirect_corenum = mips_gcr_get_redirect_corenum(gcr);
+    int redirect_vpid = mips_gcr_get_redirect_vpid(gcr);
+    int redirect_vpnum = mips_gcr_get_redirect_vpnum(gcr);
+    int current_corenum = mips_gcr_get_current_corenum(gcr);
+    int current_vpid = mips_gcr_get_current_vpid(gcr);
+    MIPSGCRPCoreState *current_pcore = &gcr->pcs[current_corenum];
+    MIPSGCRVPState *current_vps = &current_pcore->vps[current_vpid];
+    MIPSGCRPCoreState *other_pcore = &gcr->pcs[redirect_corenum];
+    MIPSGCRVPState *other_vps = &other_pcore->vps[redirect_vpid];
 
     switch (addr) {
     case GCR_BASE_OFS:
@@ -140,6 +189,25 @@ static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
     case GCR_CPC_BASE_OFS:
         update_cpc_base(gcr, data);
         break;
+    case GCR_SCRATCH0_OFS:
+        gcr->scratch[0] = data;
+        break;
+    case GCR_SCRATCH1_OFS:
+        gcr->scratch[1] = data;
+        break;
+    case GCR_SEM_OFS:
+        /* Write is inhibited if the SEM_LOCK bit is already 1 */
+        if ((data & GCR_SEM_LOCK_MASK) && (gcr->sem & GCR_SEM_LOCK_MASK)) {
+            break;
+        }
+        gcr->sem = data;
+        break;
+    case MIPS_CLCB_OFS + GCR_CL_COH_EN_OFS:
+        current_pcore->coh_en = data & 1;
+        break;
+    case MIPS_COCB_OFS + GCR_CL_COH_EN_OFS:
+        other_pcore->coh_en = data & 1;
+        break;
     case MIPS_CLCB_OFS + GCR_CL_RESETBASE_OFS:
         current_vps->reset_base = data & GCR_CL_RESET_BASE_MSK;
         cpu_set_exception_base(current_cpu->cpu_index,
@@ -147,18 +215,17 @@ static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
         break;
     case MIPS_COCB_OFS + GCR_CL_RESETBASE_OFS:
         other_vps->reset_base = data & GCR_CL_RESET_BASE_MSK;
-        cpu_set_exception_base(current_vps->other,
+        cpu_set_exception_base(redirect_vpnum,
                                get_exception_base(other_vps));
         break;
-    case MIPS_CLCB_OFS + GCR_CL_OTHER_OFS:
-        if ((data & GCR_CL_OTHER_MSK) < gcr->num_vps) {
-            current_vps->other = data & GCR_CL_OTHER_MSK;
-        }
+    case MIPS_CLCB_OFS + GCR_CL_REDIRECT_OFS:
+        set_redirect(gcr, current_vps, data);
         break;
-    case MIPS_COCB_OFS + GCR_CL_OTHER_OFS:
-        if ((data & GCR_CL_OTHER_MSK) < gcr->num_vps) {
-            other_vps->other = data & GCR_CL_OTHER_MSK;
-        }
+    case MIPS_COCB_OFS + GCR_CL_SCRATCH_OFS:
+        other_vps->scratch = data;
+        break;
+    case MIPS_COCB_OFS + GCR_CL_REDIRECT_OFS:
+        set_redirect(gcr, other_vps, data);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR_PRIx
@@ -189,30 +256,67 @@ static void mips_gcr_init(Object *obj)
 static void mips_gcr_reset(DeviceState *dev)
 {
     MIPSGCRState *s = MIPS_GCR(dev);
-    int i;
+    int pc, vp;
 
+    update_gcr_base(s, s->gcr_base);
     update_gic_base(s, 0);
     update_cpc_base(s, 0);
 
-    for (i = 0; i < s->num_vps; i++) {
-        s->vps[i].other = 0;
-        s->vps[i].reset_base = 0xBFC00000 & GCR_CL_RESET_BASE_MSK;
-        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    for (pc = 0; pc < s->num_pcores; pc++) {
+        s->pcs[pc].coh_en = 1;
+        for (vp = 0; vp < s->num_vps; vp++) {
+            int vpnum = pc * s->num_vps + vp;
+
+            s->pcs[pc].vps[vp].redirect = 0;
+            s->pcs[pc].vps[vp].reset_base = 0xBFC00000 & GCR_CL_RESET_BASE_MSK;
+            cpu_set_exception_base(vpnum, get_exception_base(&s->pcs[pc].vps[vp]));
+        }
     }
 }
 
-static const VMStateDescription vmstate_mips_gcr = {
-    .name = "mips-gcr",
+static const VMStateDescription vmstate_mips_gcr_vps = {
+    .name = "mips-gcr/vps",
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(redirect, MIPSGCRVPState),
+        VMSTATE_UINT64(reset_base, MIPSGCRVPState),
+        VMSTATE_UINT64(scratch, MIPSGCRVPState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_mips_gcr_pcs = {
+    .name = "mips-gcr/pcs",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(num_vps, MIPSGCRPCoreState),
+        VMSTATE_UINT32(coh_en, MIPSGCRPCoreState),
+        VMSTATE_STRUCT_VARRAY_ALLOC(vps, MIPSGCRPCoreState, num_vps, 0,
+                            vmstate_mips_gcr_vps, MIPSGCRVPState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_mips_gcr = {
+    .name = "mips-gcr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(scratch, MIPSGCRState, 2),
+        VMSTATE_UINT32(sem, MIPSGCRState),
         VMSTATE_UINT64(cpc_base, MIPSGCRState),
+        VMSTATE_UINT64(gic_base, MIPSGCRState),
+        VMSTATE_STRUCT_VARRAY_ALLOC(pcs, MIPSGCRState, num_pcores, 0,
+                            vmstate_mips_gcr_pcs, MIPSGCRPCoreState),
         VMSTATE_END_OF_LIST()
     },
 };
 
 static Property mips_gcr_properties[] = {
-    DEFINE_PROP_UINT32("num-vp", MIPSGCRState, num_vps, 1),
+    DEFINE_PROP_INT32("num-pcores", MIPSGCRState, num_pcores, 1),
+    DEFINE_PROP_INT32("num-vp", MIPSGCRState, num_vps, 1),
     DEFINE_PROP_INT32("gcr-rev", MIPSGCRState, gcr_rev, 0x800),
     DEFINE_PROP_UINT64("gcr-base", MIPSGCRState, gcr_base, GCR_BASE_ADDR),
     DEFINE_PROP_LINK("gic", MIPSGCRState, gic_mr, TYPE_MEMORY_REGION,
@@ -226,8 +330,12 @@ static void mips_gcr_realize(DeviceState *dev, Error **errp)
 {
     MIPSGCRState *s = MIPS_GCR(dev);
 
-    /* Create local set of registers for each VP */
-    s->vps = g_new(MIPSGCRVPState, s->num_vps);
+    /* Create local set of registers for each VP and each pcore */
+    s->pcs = g_new(MIPSGCRPCoreState, s->num_pcores);
+    for (int i = 0; i < s->num_pcores; i++) {
+        s->pcs[i].num_vps = s->num_vps;
+        s->pcs[i].vps = g_new(MIPSGCRVPState, s->num_vps);
+    }
 }
 
 static void mips_gcr_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/misc/mips_cmgcr.h b/include/hw/misc/mips_cmgcr.h
index db4bf5f449..f75ff660c2 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -34,16 +34,27 @@ OBJECT_DECLARE_SIMPLE_TYPE(MIPSGCRState, MIPS_GCR)
 #define GCR_GIC_STATUS_OFS  0x00D0
 #define GCR_CPC_STATUS_OFS  0x00F0
 #define GCR_L2_CONFIG_OFS   0x0130
+#define GCR_SYS_CONFIG2_OFS 0x0150
+#define GCR_SCRATCH0_OFS    0x0280
+#define GCR_SCRATCH1_OFS    0x0288
+#define GCR_SEM_OFS         0x0640
 
 /* Core Local and Core Other Block Register Map */
-#define GCR_CL_CONFIG_OFS   0x0010
-#define GCR_CL_OTHER_OFS    0x0018
-#define GCR_CL_RESETBASE_OFS 0x0020
+#define GCR_CL_COH_EN_OFS    0x0008 /* Core-Local */
+#define GCR_CL_CONFIG_OFS    0x0010 /* Core-Local */
+#define GCR_CL_REDIRECT_OFS  0x0018 /* VP-Local */
+#define GCR_CL_RESETBASE_OFS 0x0020 /* VP-Local */
+#define GCR_CL_ID_OFS        0x0028 /* Core-Local */
+#define GCR_CL_SCRATCH_OFS   0x0060 /* VP-Local */
 
 /* GCR_L2_CONFIG register fields */
 #define GCR_L2_CONFIG_BYPASS_SHF    20
 #define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
 
+/* GCR_SYS_CONFIG2 register fields */
+#define GCR_SYS_CONFIG2_MAXVP_SHF    0
+#define GCR_SYS_CONFIG2_MAXVP_MSK    ((0xFULL) << GCR_SYS_CONFIG2_MAXVP_SHF)
+
 /* GCR_BASE register fields */
 #define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
 
@@ -52,14 +63,20 @@ OBJECT_DECLARE_SIMPLE_TYPE(MIPSGCRState, MIPS_GCR)
 #define GCR_GIC_BASE_GICBASE_MSK 0xFFFFFFFE0000ULL
 #define GCR_GIC_BASE_MSK (GCR_GIC_BASE_GICEN_MSK | GCR_GIC_BASE_GICBASE_MSK)
 
+/* GCR_SEM register fields */
+#define GCR_SEM_DATA_MSK  0x00000000EFFFFFFFULL
+#define GCR_SEM_LOCK_MASK 0x0000000080000000ULL
+
 /* GCR_CPC_BASE register fields */
 #define GCR_CPC_BASE_CPCEN_MSK   1
 #define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
 #define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MSK)
 
-/* GCR_CL_OTHER_OFS register fields */
-#define GCR_CL_OTHER_VPOTHER_MSK 0x7
-#define GCR_CL_OTHER_MSK GCR_CL_OTHER_VPOTHER_MSK
+/* GCR_CL_REDIRECT_OFS register fields */
+#define GCR_CL_REDIRECT_VP_MSK 0x7U
+#define GCR_CL_REDIRECT_VP_SHF 0
+#define GCR_CL_REDIRECT_CORE_MSK 0xF00U
+#define GCR_CL_REDIRECT_CORE_SHF 8
 
 /* GCR_CL_RESETBASE_OFS register fields */
 #define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFF000U
@@ -67,15 +84,28 @@ OBJECT_DECLARE_SIMPLE_TYPE(MIPSGCRState, MIPS_GCR)
 
 typedef struct MIPSGCRVPState MIPSGCRVPState;
 struct MIPSGCRVPState {
-    uint32_t other;
+    uint32_t redirect;
     uint64_t reset_base;
+    uint64_t scratch;
+};
+
+typedef struct MIPSGCRPCoreState MIPSGCRPCoreState;
+struct MIPSGCRPCoreState {
+    int32_t num_vps; /* Number of VPs in that core */
+    uint32_t coh_en;
+    /* VP Local/Other Registers */
+    MIPSGCRVPState *vps;
 };
 
 struct MIPSGCRState {
     SysBusDevice parent_obj;
 
     int32_t gcr_rev;
-    uint32_t num_vps;
+    int32_t num_pcores; /* Number of physical cores */
+    int32_t num_vps; /* Number of VPs per physical core */
+
+    uint64_t scratch[2]; /* GCR Scratch */
+    uint32_t sem; /* GCR Semaphore */
     hwaddr gcr_base;
     MemoryRegion iomem;
     MemoryRegion *cpc_mr;
@@ -84,8 +114,45 @@ struct MIPSGCRState {
     uint64_t cpc_base;
     uint64_t gic_base;
 
-    /* VP Local/Other Registers */
-    MIPSGCRVPState *vps;
+    /* Core Local/Other Registers */
+    MIPSGCRPCoreState *pcs;
 };
 
+static inline int mips_gcr_get_current_corenum(MIPSGCRState *s)
+{
+    return current_cpu->cpu_index / s->num_vps;
+}
+
+static inline int mips_gcr_get_current_vpid(MIPSGCRState *s)
+{
+    return current_cpu->cpu_index % s->num_vps;
+}
+
+static inline int mips_gcr_get_redirect_corenum(MIPSGCRState *s)
+{
+    int current_corenum = mips_gcr_get_current_corenum(s);
+    int current_vpid = mips_gcr_get_current_vpid(s);
+    MIPSGCRVPState *current_vps = &s->pcs[current_corenum].vps[current_vpid];
+
+    return (current_vps->redirect & GCR_CL_REDIRECT_CORE_MSK) >>
+            GCR_CL_REDIRECT_CORE_SHF;
+}
+
+static inline int mips_gcr_get_redirect_vpid(MIPSGCRState *s)
+{
+    int current_corenum = mips_gcr_get_current_corenum(s);
+    int current_vpid = mips_gcr_get_current_vpid(s);
+    MIPSGCRVPState *current_vps = &s->pcs[current_corenum].vps[current_vpid];
+
+    return (current_vps->redirect & GCR_CL_REDIRECT_VP_MSK) >>
+            GCR_CL_REDIRECT_VP_SHF;
+}
+
+static inline int mips_gcr_get_redirect_vpnum(MIPSGCRState *s)
+{
+    int core = mips_gcr_get_redirect_corenum(s);
+    int vpid = mips_gcr_get_redirect_vpid(s);
+    return core * s->num_vps + vpid;
+}
+
 #endif /* MIPS_CMGCR_H */

-- 
2.34.1


