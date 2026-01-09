Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB89D1A616
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBiK-0000Zb-AW; Fri, 09 Jan 2026 07:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBiI-0000ZL-Cm
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:35:34 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBiG-0006eK-8S
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:35:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A9C795BCE7;
 Fri,  9 Jan 2026 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WnnkRKSlcwzF06r7zmWGQEkmxoyPu7C3Cvaiks4QfE=;
 b=hRU/BGbYsULKzjLbT1vAAn9MReptqG6tl1slgWo91i22Hv3XWg8Khy6/cxmcI4GgRRnYqn
 329j1zzYgj5rxnPhOnj3tUl10Q2w8fUWM8M+1wHsHokspvxlryeQQNs/LEjt+B66tWBvmy
 0qM2ebCozJvt4Zf3b5m38buCHjVsM0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WnnkRKSlcwzF06r7zmWGQEkmxoyPu7C3Cvaiks4QfE=;
 b=oLSxVRpUZkgl3q6hq/VUFAKd99dS/bly5/V2qPK1dgDK3o2Mve1U/0CdskuDIyhHdK7wV0
 IqVTPfIVMFBcXyAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=umEsu0Xt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aor6ZSCs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WnnkRKSlcwzF06r7zmWGQEkmxoyPu7C3Cvaiks4QfE=;
 b=umEsu0Xt+U5FTefG6QccL8z6N33nK5EPVkRdBcm5Oaklkbu1cvbAE48LNv1CNAwWMB55YC
 N79+U31ZR0PyKw6N2NvBSmIp0VYr4x2WNyEwalVgkw2lqwlMoA4ovFeciC6mypJq/V5kFT
 fKBByaQN9VxTdzyYLZNewYO83CNocIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WnnkRKSlcwzF06r7zmWGQEkmxoyPu7C3Cvaiks4QfE=;
 b=aor6ZSCsfvgghbjpffmJ5vFADY/XcjCl7Rfl4zQMtqcCEnsqMFHCa4AeZRmOp334C7wWOS
 YUpjwOYwLaD2xZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E0153EA63;
 Fri,  9 Jan 2026 12:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oCkfCAz2YGlqPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:35:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, peterx@redhat.com, Fabian Vogt <fvogt@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 1/2] target/ppc: Fix env->quiesced migration
Date: Fri,  9 Jan 2026 09:35:18 -0300
Message-ID: <20260109123519.28703-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109123519.28703-1-farosas@suse.de>
References: <20260109123519.28703-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[redhat.com,suse.de,gmail.com,linux.ibm.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A9C795BCE7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The commit referenced (from QEMU 10.0) has changed the way the pseries
machine marks a cpu as quiesced. Previously, the cpu->halted value
from QEMU common cpu code was (incorrectly) used. With the fix, the
env->quiesced variable starts being used, which improves on the
original situation, but also causes a side effect after migration:

The env->quiesced is set at reset and never migrated, which causes the
destination QEMU to stop delivering interrupts and hang the machine.

To fix the issue from this point on, start migrating the env->quiesced
value.

For QEMU versions < 10.0, sending the new element on the stream would
cause migration to be aborted, so add the appropriate compatibility
property to omit the new subsection.

Independently of this patch, all migrations from QEMU versions < 10.0
would result in a hang since the older QEMU never migrates
env->quiesced. This is bad because it leaves machines already running
on the old QEMU without a migration path into newer versions.

As a workaround, use a few heuristics to infer the new value of
env->quiesced based on cpu->halted, LPCR and PSSCR bits that are
usually set/cleared along with quiesced.

Note that this was tested with -cpu power9 and -machine ic-mode=xive
due to another bug affecting migration of XICS guests. Tested both
forward and backward migration and savevm/loadvm from 9.2 and 10.0.

Also tested loadvm of a savevm image that contains a mix of cpus both
halted and not halted.

Reported-by: Fabian Vogt <fvogt@suse.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3079
Fixes: fb802acdc8b ("ppc/spapr: Fix RTAS stopped state")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/ppc/spapr.c        |  6 +++++
 target/ppc/cpu.h      |  1 +
 target/ppc/cpu_init.c |  7 +++++
 target/ppc/machine.c  | 62 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3d87450be5..5e8b7ab1aa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4788,8 +4788,14 @@ DEFINE_SPAPR_MACHINE(10, 1);
  */
 static void spapr_machine_10_0_class_options(MachineClass *mc)
 {
+    static GlobalProperty spapr_compat_10_0[] = {
+        { TYPE_POWERPC_CPU, "rtas-stopped-state", "false" },
+    };
+
     spapr_machine_10_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
+    compat_props_add(mc->compat_props, spapr_compat_10_0,
+                     G_N_ELEMENTS(spapr_compat_10_0));
 }
 
 DEFINE_SPAPR_MACHINE(10, 0);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index dbebae89dc..49445eb4ca 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1529,6 +1529,7 @@ struct ArchCPU {
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
+    bool rtas_stopped_state;
 
     /* Those resources are used only during code translation */
     /* opcode handlers */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 929254827d..58816c51a7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -55,6 +55,11 @@
 /* #define PPC_DEBUG_SPR */
 /* #define USE_APPLE_GDB */
 
+static const Property powerpc_cpu_properties[] = {
+    DEFINE_PROP_BOOL("rtas-stopped-state", PowerPCCPU,
+                      rtas_stopped_state, true),
+};
+
 static inline void vscr_init(CPUPPCState *env, uint32_t val)
 {
     /* Altivec always uses round-to-nearest */
@@ -7529,6 +7534,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
                                       &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
 
+    device_class_set_props(dc, powerpc_cpu_properties);
+
     resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
                                        &pcc->parent_phases);
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index d72e5ecb94..49cfdc6d67 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -257,6 +257,45 @@ static int cpu_post_load(void *opaque, int version_id)
         ppc_store_sdr1(env, env->spr[SPR_SDR1]);
     }
 
+    if (!cpu->rtas_stopped_state) {
+        /*
+         * The source QEMU doesn't have fb802acdc8 and still uses halt +
+         * PM bits in LPCR to implement RTAS stopped state. The new (this)
+         * QEMU will have put the secondary vcpus in stopped state,
+         * waiting for the start-cpu RTAS call. That call will never come
+         * if the source cpus were already running. Try to infer the cpus
+         * state and set env->quiesced accordingly.
+         *
+         * env->quiesced = true  ==> the cpu is waiting to start
+         * env->quiesced = false ==> the cpu is running (unless halted)
+         */
+
+        /*
+         * Halted _could_ mean quiesced, but it could also be cede,
+         * confer_self, power management, etc.
+         */
+        if (CPU(cpu)->halted) {
+            PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+            /*
+             * Both the PSSCR_EC bit and LPCR PM bits set at cpu reset
+             * and rtas_stop and cleared at rtas_start, it's a good
+             * heuristic.
+             */
+            if ((env->spr[SPR_PSSCR] & PSSCR_EC) &&
+                (env->spr[SPR_LPCR] & pcc->lpcr_pm)) {
+                env->quiesced = true;
+            } else {
+                env->quiesced = false;
+            }
+        } else {
+            /*
+             * Old QEMU sets halted during rtas_stop_self. Not halted,
+             * therefore definitely not quiesced.
+             */
+            env->quiesced = false;
+        }
+    }
+
     post_load_update_msr(env);
 
     if (tcg_enabled()) {
@@ -649,6 +688,28 @@ static const VMStateDescription vmstate_reservation = {
     }
 };
 
+static bool rtas_stopped_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    return cpu->rtas_stopped_state;
+}
+
+static const VMStateDescription vmstate_rtas_stopped = {
+    .name = "cpu/rtas_stopped",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = rtas_stopped_needed,
+    .fields = (const VMStateField[]) {
+        /*
+         * "RTAS stopped" state, independent of halted state. For QEMU
+         * < 10.0, this is taken from cpu->halted at cpu_post_load()
+         */
+        VMSTATE_BOOL(env.quiesced, PowerPCCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_PPC64
 static bool bhrb_needed(void *opaque)
 {
@@ -715,6 +776,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlbmas,
         &vmstate_compat,
         &vmstate_reservation,
+        &vmstate_rtas_stopped,
         NULL
     }
 };
-- 
2.51.0


