Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6E7CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95lI-0007i6-8C; Wed, 15 Oct 2025 13:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95lG-0007hq-Qw
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:58:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95l9-0005Wk-60
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:58:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so40443805e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551075; x=1761155875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sm0VhjiosRZGEONgmdQidUwgeCNLAFiEbQdZpOa2Z2o=;
 b=Qisy+cflQI1vWQtx5G908ijAT6qXbcijMxQXjfwlYC7QqRW7U4U8ZsXkDFu7lO+1yM
 JOZT76Scke/KEvdWTEoT8Lg1KtgNjjLqrPv9Acfzwd3QPXIJYwFTUzurS89X1B1BMzRm
 +52AT/G0hAzSex+mRlo1w+47ODtO3cL5pL4ssaDZuHJ/jXDDDgyMSxc5gdZoqsCos/EG
 Tw9Ow2CwOkm7aOIPQ4xxJJYmZK3lhUDl4H/mYaghemS+5PeTjgR4kwX68AeSzbjpFc4T
 7osHM1DdN/xmiB0SQlDeNU7Qc0oPKmNM2Ks5GfHdtoNQtlcUpkCGtBYO1S7j+s9iZFS7
 Ipuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551075; x=1761155875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sm0VhjiosRZGEONgmdQidUwgeCNLAFiEbQdZpOa2Z2o=;
 b=HrQhktjm/YWt30epsCWBdjVr3QhXJ0hc10HKRKyfY6ta3SbdVtM1Nis5GY2mxetefx
 y6VkD2Dxo290CWW1rHVTmdxKoRio8bt2MtTEe/gu+KGmXRDCgG+iOw+g3AiBf/JJjX4U
 agupVWj5UGiPyl/dil8z/u+d3FE7N4WLrCR3vh4QFqup6GkScUfbMHIiyi9QMS38k5Ug
 gCYA0Rz3RC9h0SN7vpW5jpY2EadNMmyajD2CJGZ/4gAQMMOdEyuLtse1M9CWKPz2FxRV
 xu3V8xNf9yr4zXwWalfdQBdZAW1uhpQPhdsaYG8TZ9BvKl5jyLS4ee+x1tFJoOw/O931
 i47g==
X-Gm-Message-State: AOJu0Yz537vi3xU8tRzD18WW4mYdEIYECcg1k1bixDVbdRabkI7u9mcJ
 RcmqDWhK+S2qR/WxTwGjFRCpMEtIkB+qM4InxyxDuxivHrGwyWrOVaemLSVSo8dvxT3fhKCLFXZ
 NqclxotYp/f7y
X-Gm-Gg: ASbGnctq67JFO46X8NeV0SCH1rpT1UJeCIvMbtU5qDJnC0Tc5nm9+cjjO3UGNERtPcn
 1ojg/2r1GGct1CNdjc5iQoUDh6LBTmcgIympuJe6Jql5y+ARwKJHIqsmK5UZNnoG5ZmVjLV6T5E
 7ul1gRidtplHhZguwugXpkIJsFlMWbqGP8YcIiu4v3o0XZL93yHnc2oSpdfUL4qe1JppBIB3J2G
 BBCC3d8p8g/WQ/9tbqcGwxJ0vCeaYaQCiGMn6xCnWBGV4kNEqdjFvFKM7LSFMeEQlFhz0zllhHG
 YRpq8GOdXk24rz3/57JkpV1nH+zreRYeaw/Vs5aGaA/H059JUMmsXPepMeLRZsOFVuHHgD0av9I
 /tzn9/W5RZ0zi5N3n09KzQ7H571Ye+BYtme6S+HVH1L1sL2Tqu8xozz73ew0sQ4c713Fw0OVCGO
 nZKIMbIXrT2+F7xLt6bKGthVXsh8vPv3Ruisj3PnYt
X-Google-Smtp-Source: AGHT+IGmoY9I4vfr3ZVBrmO4Z2nyPgWMrPv/jsCg0GPsAanIus0e+UAONaoDgE/pvx7myKMVF3RC2Q==
X-Received: by 2002:a05:600c:5488:b0:46e:45f7:34fc with SMTP id
 5b1f17b1804b1-46fa9b105ffmr206303385e9.29.1760551075457; 
 Wed, 15 Oct 2025 10:57:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e83e1sm30438690f8f.51.2025.10.15.10.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 10:57:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/7] target/microblaze: Convert CPUMBState::res_addr field
 to uint32_t type
Date: Wed, 15 Oct 2025 19:57:17 +0200
Message-ID: <20251015175717.93945-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175717.93945-1-philmd@linaro.org>
References: <20251015175717.93945-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

CPUMBState::@res_addr field is used as u32 since commit
cfeea807e5a ("target-microblaze: Tighten up TCGv_i32 vs
TCGv type usage"). Convert it as such, bumping the migration
version. Use the RES_ADDR_NONE definition when appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/machine.c   |  6 +++---
 target/microblaze/translate.c | 17 +++++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3ce28b302fe..14b107876a4 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -259,7 +259,7 @@ struct CPUArchState {
 
     /* lwx/swx reserved address */
 #define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
-    target_ulong res_addr;
+    uint32_t res_addr;
     uint32_t res_val;
 
     /* Internal flags.  */
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index a4cf38dc891..48efa546d39 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -78,7 +78,7 @@ static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT32(iflags, CPUMBState),
 
     VMSTATE_UINT32(res_val, CPUMBState),
-    VMSTATE_UINTTL(res_addr, CPUMBState),
+    VMSTATE_UINT32(res_addr, CPUMBState),
 
     VMSTATE_STRUCT(mmu, CPUMBState, 0, vmstate_mmu, MicroBlazeMMU),
 
@@ -87,8 +87,8 @@ static const VMStateField vmstate_env_fields[] = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 0,
-    .minimum_version_id = 0,
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = vmstate_env_fields,
 };
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0fc8faafd09..fe0101683e2 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -55,7 +55,7 @@ static TCGv_i32 cpu_imm;
 static TCGv_i32 cpu_bvalue;
 static TCGv_i32 cpu_btarget;
 static TCGv_i32 cpu_iflags;
-static TCGv cpu_res_addr;
+static TCGv_i32 cpu_res_addr;
 static TCGv_i32 cpu_res_val;
 
 /* This is the state at translation time.  */
@@ -857,7 +857,7 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 
     tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
                         mo_endian(dc) | MO_UL);
-    tcg_gen_mov_tl(cpu_res_addr, addr);
+    tcg_gen_mov_i32(cpu_res_addr, addr);
 
     if (arg->rd) {
         tcg_gen_mov_i32(cpu_R[arg->rd], cpu_res_val);
@@ -1024,7 +1024,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
      * branch, but we know we can use the equal version in the global.
      * In either case, addr is no longer needed.
      */
-    tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, addr, swx_fail);
+    tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_addr, addr, swx_fail);
 
     /*
      * Compare the value loaded during lwx with current contents of
@@ -1052,7 +1052,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
      * Prevent the saved address from working again without another ldx.
      * Akin to the pseudocode setting reservation = 0.
      */
-    tcg_gen_movi_tl(cpu_res_addr, -1);
+    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
     return true;
 }
 
@@ -1173,7 +1173,7 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
         tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
     }
     tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_BIP);
-    tcg_gen_movi_tl(cpu_res_addr, -1);
+    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
 
     dc->base.is_jmp = DISAS_EXIT;
     return true;
@@ -1194,7 +1194,7 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
     if (arg->rd) {
         tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
     }
-    tcg_gen_movi_tl(cpu_res_addr, -1);
+    tcg_gen_movi_i32(cpu_res_addr, RES_ADDR_NONE);
 
 #ifdef CONFIG_USER_ONLY
     switch (imm) {
@@ -1885,6 +1885,7 @@ void mb_tcg_init(void)
           tcg_global_mem_new_i32(tcg_env, i32s[i].ofs, i32s[i].name);
     }
 
-    cpu_res_addr =
-        tcg_global_mem_new(tcg_env, offsetof(CPUMBState, res_addr), "res_addr");
+    cpu_res_addr = tcg_global_mem_new_i32(tcg_env,
+                                          offsetof(CPUMBState, res_addr),
+                                          "res_addr");
 }
-- 
2.51.0


