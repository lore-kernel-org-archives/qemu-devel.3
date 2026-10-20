Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AB606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Mxqd+Z/N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8wl-0008S8-Br; Tue, 20 Oct 2026 08:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wj-0008Rt-DG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wh-0004Me-NQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1854241f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792499278; x=1793104078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NNPAVebBgE86yGS589DuMeccMx56+d9+OJ/1mfKNNsY=;
 b=Mxqd+Z/NC+aAKjmmbYdr8LkFKNsmXKJll53awecn2j4vWwD5l/3UehdI5QtrtPBS7E
 a0ZkOvA1uRvJtH5eYQnilOznamklxxJXrXM+t4fkopcmGitgUt533ePSfDoWC8j9vn8K
 iOUtzN7E3rN6R8UmgW17X1BtyOZoCFqO+4s1b8HyVagmrp2ZtjgkBgbAnTDd0oSGtqVT
 IQJkMVBsheC9NoTBgXSG/3r46HXaoV450BLqzpW7vmT0URa8OSw1GQuuQ/8M7Rp9PmZM
 ARpZ+VSLNXe9O0Zjt+dUdatZ8NcyObCst31A/GUbJEnEkAEjGmySyvlW8nUIwghiE9e1
 daPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499278; x=1793104078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NNPAVebBgE86yGS589DuMeccMx56+d9+OJ/1mfKNNsY=;
 b=iIEKp/XNe1GZMUISNY2Pn8DilCEr1VafSTkqCreMh5AlUwO/H7L6U+8kN1e80F+F6u
 9pW0B02RwC2XdQEOcJFJJJKZDfsU9Re0rBXDZlVkLWhphw0w9EwUaaEAE8jI/TbrbziZ
 qS6yYVdzJT9WWhPFQhqMOO+empoWdZOxF+yvQZ6R11LKrdpzTOtsfpp/XzbpndtADC+m
 Ldd76lNWAnhz3jEwCtvXyPzYS6ZmwCbhB7qxwHnF6S0At2wLHN001/IcM1VuQnN9al3C
 t5/CePhZ8IybjRaDJ4ICTj/k59QMHp5psh6wblRI5u+Xc2FP2KG2VgxAWtc0V4oQ0Ugx
 Gvng==
X-Gm-Message-State: AFq9FYIUpLxytOXMrGjOqxjvbLvTlD+jYxoeWBDFM3nhxp6vNI5XKem9
 qn/uwOLz8jjXurrMZGSZzRdv4S6OSEiwShVVNlxeyo617LgtshQn6l7vAOJsBGMgP52Vof+FhGq
 lumN2/sw=
X-Gm-Gg: AYBFou1B1zfFd9CWltrrW9LVBvGv/HgUuHGEOJ5mGlM+ScT0TKp6Sl8BZw1c0BPcIsd
 PV2vxN9RPpSdaI0D5VVANuqtFAeC2Q06+QxpVkIq+SevZQDqbrKvGXG2WN0MkzOcYbUnUul2s+q
 JoCRJLAZphL/NsZr2E2miuOLHyZJPg3d9SuAjjnzNwfGq9p6sBb2YRswgWnyGUiYMl92Cy8frRL
 ikit6L38LBB00Rlky9ww0VTUOUOguEryxGeerImW+MyYbjxtofXVDoPf9fYe2JOPFjYN3xNrfwQ
 yeWaCtALHeDun/O2qEzrZ+0cqYONLDNL75lycX3E6IhJqySILuYhabjQowmdhZ13crM+vR1UOA4
 ZwPAMuDNboA9jUZqgfdMq3Cdu1/IdHYwz3IAgDC3i/pUj3ztuCJZB94D1R8A4HPOiyFlkudx0Wd
 fMTT9bf11i9EpIg0nW03c3ocPfV69nKH8OGB9oyJXr9mcQ3T/Gbx9r4uSiTo5JbfTbTP2XH2mL1
 9cWyVOLrm9l47R09EKdIL9F6Ur4ChGO5I/sjthqiVYMBYpjB7aZ28nj5kPs5WGCAYdi7EZjtNDA
 u6k=
X-Received: by 2002:a05:600c:a4b:b0:4a0:eae0:b30e with SMTP id
 5b1f17b1804b1-4a1d7604051mr246946115e9.22.1792499278182; 
 Tue, 20 Oct 2026 05:27:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cd482bsm68899315e9.12.2026.10.20.05.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:27:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 1/5] target/alpha: Convert to translate_for_debug
Date: Tue, 20 Oct 2026 13:27:48 +0100
Message-ID: <20261020122752.3651914-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020122752.3651914-1-peter.maydell@linaro.org>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Convert alpha to providing the translate_for_debug method rather than
the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/alpha/cpu.h    |  3 ++-
 target/alpha/cpu.c    |  2 +-
 target/alpha/helper.c | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 378bd96d941..32f53453d72 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -282,7 +282,8 @@ extern const VMStateDescription vmstate_alpha_cpu;
 
 void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool alpha_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                   TranslateForDebugResult *result);
 #endif /* !CONFIG_USER_ONLY */
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 12e86021663..dca25456e78 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -242,7 +242,7 @@ static void alpha_cpu_initfn(Object *obj)
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
     .has_work = alpha_cpu_has_work,
-    .get_phys_addr_debug = alpha_cpu_get_phys_addr_debug,
+    .translate_for_debug = alpha_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index c3614ecafda..ccf1994b31b 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -297,14 +297,25 @@ static int get_physical_address(CPUAlphaState *env, vaddr addr,
     return ret;
 }
 
-hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool alpha_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result)
 {
     hwaddr phys;
     int prot, fail;
 
     fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
+    if (fail >= 0) {
+        return false;
+    }
+
     phys |= addr & ~TARGET_PAGE_MASK;
-    return (fail >= 0 ? -1 : phys);
+
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
-- 
2.43.0


