Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F105DF36B97
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 02:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB1Aj-0008ES-1s; Thu, 09 Apr 2026 22:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wB1Ah-0008EG-Hf
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:00:35 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wB1Af-0003HF-O9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:00:35 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-463f00cda04so829034b6e.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775786432; x=1776391232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UsGjB9ox6YYtoD97rEoIJs8TMPMVsIdNPaQfg6LAnNI=;
 b=KNZXGOSR6aUshFPsmmqpKXENINHtvQphOi+HuWGptAIut8ub556XgQ3C0RLHIUTnv+
 zxp+N0SVsMZKS2K/VGENBEC2XXjs4Xmw0gicNxIYiAm8RKLhc1rW7lmeWLiMZjue3j2M
 /2N1r32ilrEr9+3t/Yg62AMr9/pKI7R9ISQDuoDbf7iq2HGcKhuxePauMFAjuE0Dx5gq
 juCyMVc0TZ29KMIh5DMunrON13XDLyVNj8fKs71gmyJ1md1/7oHWyDasE/CbHXv8ulxC
 OdfRLI+mtxXaiXNzQCvTo9oT1T8Nmc3f18lVBm/ac4c2qzK2WOnBbFBy1J6/AbYyr+y/
 B2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775786432; x=1776391232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsGjB9ox6YYtoD97rEoIJs8TMPMVsIdNPaQfg6LAnNI=;
 b=eN2bsGkAuCZWqzUWKVlbHAfAKxFHRSu/d9C1aH+pv7GMXqDPyS9VZeV5ryrGEWPavZ
 7d3o9RmMcxdLwp3PPzGmjkkebgEER8JlgHp4nS5Pj4AkTMlFo3+B7t5TgLpjUZ2B1S/m
 QRT4ja5AHHASc70sV55IAYI0IMVghuH9HnSXJTbK9KpaIo/Q6xODBPAe9ChxAZi5vISk
 07KKBXk4SzBDJtHU+7wfs6xJK0BW8WfG+gkYS0HB1fDMFZl3BAJDdjkyrY/WbeX2lefv
 0zZwOsh+VhPo6bzIUEPkaJ/5Yyhs3Msh4ZkAW/62W+0shAeC0EDulImRFIqEOPtZYXNo
 voYg==
X-Gm-Message-State: AOJu0Yw/FtiTAk+eOOYaBbEDBWfRdH7gstuTQXxiB4kbCplepDVz4O4U
 22ouejCvbUsANsbutdEGllWKtlDXapkCCbY+YxDSyLgMSqrooEpOYkU+Mokegg==
X-Gm-Gg: AeBDiet92GAqiAh+ttVJtGSzQUPpu98FdlUE0yKcQ2PvZz4WEE+naQVW5voXE1xxaGp
 rOPOUiN61rVdawZrqOEZpKDzNZyu23Bv64NVDpMN9wCXRBkpfeY5ua/2+H4GVpWkDQJk3D84xHD
 QNQJI3LCqAO0oBRGnSg+Wmz90o9OsKtaVxfZhuBslzfYDZcjOt7KR5sF5RAqi/IZ3ZEQYRMrIx6
 0mN/pQMizm0CktDmZZt7oeKTO5+9CxrP1weMm8QA4g3m8m+ed4RVWkyv2ANokzUR2GBfWOSni/Q
 SAZwO/mIh7cyEnGdK0d9pSBvWI54wLahokCSHnSI1PxIHSxf1K7buvaHAz0c+/8OwRNDSAD8ltv
 jVWq0TBFrgP0X0K9A5raGVM3OZG2KbNmHWoECz/6BGWUQK34NMxpNS0JIp5BrdK6CTqbd9IV5Cj
 TBO2dONS8zvdRqRTwmJeMgBzZzFwrmv72Uyoarr9tHj/5x0sAy7hMYgdqY+Bj8swoDgo39ibmE2
 be/BZwReR3dgizul0TNmrzrKUje5GfjdNFuTwOapu1XpSb3pjuvipxAcgnCTYDSciYctU+kNGq7
 pyE=
X-Received: by 2002:a05:6820:5106:b0:67e:4004:dc93 with SMTP id
 006d021491bc7-68be80df857mr487472eaf.29.1775786432262; 
 Thu, 09 Apr 2026 19:00:32 -0700 (PDT)
Received: from Mac.localdomain.cloud (71-218-253-186.hlrn.qwest.net.
 [71.218.253.186]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc7dfa196sm775742eaf.2.2026.04.09.19.00.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 19:00:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/1] linux-user/mips: sync k0 TLS for EF_MIPS_MACH_OCTEON
 userlands
Date: Thu,  9 Apr 2026 20:00:12 -0600
Message-ID: <20260410020012.98778-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Cavium Octeon userspace is not following a generic MIPS Linux TLS
ABI rule here. Older Octeon glibc uses the k0 register as the fast
thread pointer, while newer Octeon2 and Octeon3 glibc variants use
the normal rdhwr $29 path.

linux-user already updates CP0_UserLocal for cpu_set_tls() and
TARGET_NR_set_thread_area, but it does not keep gpr[26]
synchronized. That leaves EF_MIPS_MACH_OCTEON userlands able to
complete set_thread_area() and still reach pthread startup or
pthread_self() with a stale k0 value.

Use the existing MIPS ELF machine flags from linux-user/elfload.c and
mirror CP0_UserLocal into gpr[26] only for EF_MIPS_MACH_OCTEON.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - only enable on EF_MIPS_MACH_OCTEON
---
 linux-user/elfload.c         | 3 +++
 linux-user/mips/target_cpu.h | 5 +++++
 linux-user/qemu.h            | 1 +
 linux-user/syscall.c         | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 59b543f740..0e757787d2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1476,6 +1476,9 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     /* Usual start for brk is after all sections of the main executable. */
     info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
     info->elf_flags = ehdr->e_flags;
+#ifdef TARGET_MIPS
+    info->use_k0_tls = (ehdr->e_flags & EF_MIPS_MACH) == EF_MIPS_MACH_OCTEON;
+#endif
 
     prot_exec = PROT_EXEC;
 #ifdef TARGET_AARCH64
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index c375616c55..2bbd0a81c5 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -35,7 +35,12 @@ static inline void cpu_clone_regs_parent(CPUMIPSState *env, unsigned flags)
 
 static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
 {
+    TaskState *ts = get_task_state(env_cpu(env));
+
     env->active_tc.CP0_UserLocal = newtls;
+    if (ts->info->use_k0_tls) {
+        env->active_tc.gpr[26] = newtls;
+    }
 }
 
 static inline abi_ulong get_sp_from_cpustate(CPUMIPSState *state)
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index cfe5f45fc4..7f98fb2607 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -65,6 +65,7 @@ struct image_info {
         uint32_t        note_flags;
 
 #ifdef TARGET_MIPS
+        bool            use_k0_tls;
         int             fp_abi;
         int             interp_fp_abi;
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4b74ad350..8e96cc26db 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13216,7 +13216,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_set_thread_area
     case TARGET_NR_set_thread_area:
 #if defined(TARGET_MIPS)
-      cpu_env->active_tc.CP0_UserLocal = arg1;
+      cpu_set_tls(cpu_env, arg1);
       return 0;
 #elif defined(TARGET_I386) && defined(TARGET_ABI32)
       return do_set_thread_area(cpu_env, arg1);
-- 
2.53.0


