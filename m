Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED9606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OWpKECr6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsOI-0001A3-SK; Thu, 22 Oct 2026 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNx-00013x-6g
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNv-0007KX-6G
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso4504205e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792673946; x=1793278746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPQ7UhwLGjAGntITSh1z8fUIdTcQC3SFVKTSXT7fyA4=;
 b=OWpKECr63StT51LiRD4T35OtXsPerqKiJny6Sv3I4uNC35T6iaMTse4A02FMD+iUNM
 j1yRIhL0la9cS4zn5FkQ4ebfarpUskBbLw05wxDPuZIpwrvBWH+wuzkStw/EQRmCB0eG
 OfhdByjdDBtoJJvqL/cl1UmHyNQAwQNJ4g/E11Ly/uBXUXN0uRobT7t8CYnZrQSbHhik
 gnaLF1J9dWxqsCTIKS7vU1HJoRmgPqr78KcHE4QrmAx9D1jfNjLsZeri7WgGK8weQRQz
 pcavVEb44kXIEM8kU2sLDQZFGfuwZ0jaKT67DQzEZP2IRq+TcPbNPD/VGhunGS5JBADr
 60xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673946; x=1793278746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QPQ7UhwLGjAGntITSh1z8fUIdTcQC3SFVKTSXT7fyA4=;
 b=Xsfi9BIrQGLJCSMQ8lFakNI/QxqNq0Ohd7jyM6ge+n81A8OlnJ/mw6PCCFzE3qIQDI
 +1RiXasJMSLp55FT0+WrMUzp8SQksAgvNtMMQQd6IgFchz6d6HDR1VkgDL2XHEI3WbQX
 uavF9YxzVON9eBE31J4ZNqMDpr6pNLXx2MMbFPMQSPQDqjkz0WL6nzZQUWTLMSe1Q/au
 xupfBEZQlmJn6a4b018FUzTeTb4x0bp3E4ZGAq6RveVGZd40sGpaO31fcFe1+Tv+mYcJ
 qjbQFJ7lUaSO7iyEWk0RWLT8XA3UjT1ISxdrX4TYPFWWCQbmRGM+AlB5TP811iPJa0jz
 H52g==
X-Gm-Message-State: AFq9FYI7QqDRkYFwB/eP0+/TWtGta+2obxgN8gIhleQJk01w8x+KGdWR
 +ST2+EPTQU8F0/e40pTCcUsqeiy7EjyBsgENkZ5ahpKCPzPl9j0uLkAF4mOWalRD2MpRec/e3JR
 2mTkJ59s=
X-Gm-Gg: AYBFou0Wsxw8K//FedyH5fADPNfRCuGOlULszPQAZRrwZmaOpPwO6VlPV1Z71wEcUrk
 8/AnW6JS83AS6YBRqE4yh6sJNPztk63e1DBp1Cu+vTeAzwk209bvqvfw/KYnglQOOqHCTvfg183
 xtitkZsNYhkFl+pZYfxZQ0/SzhIQV1HZOlS0XOmdNIb/ZJcMsLFX7nsZ+9iotNS26f4rgeEveEy
 i0fW+HQJDZeBSR9gODWRv75S2XTpMgSkhTLW2yumVZjbNejeBNI3mReHOMJnGXdGUQlJxwzkUb9
 FSQYwVRZjhpxXizarJJGq0A9903b2up+5FFgkqPVSAPF16RSdqRvkUve1qtHgPsfujyveKeq6SB
 e+i3zMYp9qwheiQ4lgBfGjEOuKaw+4f8YodaX0V4SxMkuJKsn3oUAsrfEaexlK8wOlMph0cQc9U
 R9KT1bWg0fyA9sGRGO7WAwayYJ4gLkwxiz4NwuvYh41OBQzulavCYIHewRsqAEgShTrjCgyZHvo
 8WQaMpn9aPa1gHcjw2uAxRfnFMIz2TQpyX64NL8sJRUVFYdeUK84FlYrxeRO5v2aU81baKzxPYU
 RAik46z6NxmBkH80EgN4+dQQSMsmy7vZuRX+pBsSvUP8t7wjSrPoo3tefTzf
X-Received: by 2002:a05:600c:3115:b0:4a1:fba8:b13d with SMTP id
 5b1f17b1804b1-4a1fdaf7457mr106577095e9.9.1792673945770; 
 Thu, 22 Oct 2026 05:59:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b439absm79247015e9.9.2026.10.22.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:59:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 4/5] target/m68k: Convert to translate_for_debug
Date: Thu, 22 Oct 2026 13:58:57 +0100
Message-ID: <20261022125858.310252-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022125858.310252-1-peter.maydell@linaro.org>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Convert m68k to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/cpu.h    |  3 ++-
 target/m68k/cpu.c    |  2 +-
 target/m68k/helper.c | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108c..bd2582d5891 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -185,7 +185,8 @@ struct M68kCPUClass {
 #ifndef CONFIG_USER_ONLY
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool m68k_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                  TranslateForDebugResult *result);
 #endif /* !CONFIG_USER_ONLY */
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc23..69864faa575 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -688,7 +688,7 @@ static const MonitorDef m68k_monitor_defs[] = {
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
-    .get_phys_addr_debug = m68k_cpu_get_phys_addr_debug,
+    .translate_for_debug = m68k_cpu_translate_for_debug,
 #ifdef CONFIG_HMP
     .monitor_defs = m68k_monitor_defs,
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f59..c30854a6746 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -908,7 +908,8 @@ txfail:
     return -1;
 }
 
-hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool m68k_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                  TranslateForDebugResult *result)
 {
     CPUM68KState *env = cpu_env(cs);
     hwaddr phys_addr;
@@ -918,7 +919,8 @@ hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         /* MMU disabled */
-        return addr;
+        phys_addr = addr;
+        goto success;
     }
 
     access_type = ACCESS_DATA | ACCESS_DEBUG;
@@ -928,10 +930,16 @@ hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot,
                              addr, access_type, &page_size) != 0) {
-        return -1;
+        return false;
     }
 
-    return phys_addr;
+success:
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 /*
-- 
2.43.0


