Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77102CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1lyo-0008Qi-MU; Thu, 25 Sep 2025 09:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CRrVaAgKCt4ZHUYIFEIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--zhuyifei.bounces.google.com>)
 id 1v1jGV-0006uL-Ki
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:55 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CRrVaAgKCt4ZHUYIFEIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--zhuyifei.bounces.google.com>)
 id 1v1jGK-0003QD-6U
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:55 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b55283ff3fcso643777a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758796298; x=1759401098; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=YemKi91g7ARuyO0/fukWjxkMGSCeafJRb6DqN69yA+g=;
 b=v4tT0gDC+53vqJb7yekw6CHdgiOV4kWawRBdFFqDCAY3nQYyGGAkLyiSOmGCESgCti
 ZhNJrkXmz5DQL0q9wl26Nz2e04YLz1SmBCiEMtgUFIWoOTu6y0lQEQQH4STrrgWcDvT+
 ZRtIYcKHABFIpZsUcJm/Mpdt7kczElTyGyWRW6DhTPq6K4KIxeZ8tujg45JpJlw6DLv2
 PCGLtzKU4plOAYR8V/Te/462iW1zt6JWfP/cPKQ1qMSUbkmy3XlfLwU+FVS+95xOrBFS
 uMMWlfxl+D5vlWvNC2FhEsRUBNRvMdXuTOmDX+Xx42x+vVxUYT4Gr5Z5vo4ag9GQZFkp
 x3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796298; x=1759401098;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YemKi91g7ARuyO0/fukWjxkMGSCeafJRb6DqN69yA+g=;
 b=IDZSfs5QfuzIvP7kzvAisYIrEjEV/CxKGQFwjfw5XfQIHfdtHHrfaP1jW82ZgpHrlC
 kl3nLotVeAYrHOmCP+29JylMPN4x/EOjIDalFJN2n2H3rX35WIG7m6XNVYM7wjQ4nrjc
 uSIuEBF/Nek0zS0dsQHEks6igIxCcXByE521M66V4mZmB/NLbcFwypQiNPLdOPf1A3Cv
 3SORzosvGVcO6OWcQ/vYimMP2OHDzGg7a/gKQ1f7C+aJvFJT738QfJPsB8GD4lxZ+zO9
 JpSf8dlLRZeq9AlBGA6b1kwCGe9sb4zeHFNFe0DpPdagwksiaHHNQ3+FS3pFFqdSJ2pB
 cK4Q==
X-Gm-Message-State: AOJu0YxkE18pZgDGyFRRvViEjNpwlMLaOoxD3QW9iCJ0GgDi+hj0lOdX
 SnsoYgtqsjaboPvKTATnm3eHoT4ooLyH9JR7n6pIHLlekaIn9AVXKKI7o/BIbsqQQEViDPLi+fK
 aDXEf8Ba8GR5WCTYKxuB399BsZX+C9CnCfJYpNQ0itKVo7EjPipRHmHGieP9T/typmxLM4fQ0NG
 p0EzXUA2d/ZFAEiX28XlP6wgtJd8pv4lRP2ECNwu/2d0wGeQ==
X-Google-Smtp-Source: AGHT+IF/XdGu8daZGR+d5C5TvYEzLCs2WJ6qY5IEQXsGcogJpG4Vq1M2fNNAW8Ww++EuAxvO1pvpikR9J/MzKg==
X-Received: from pjbpq4.prod.google.com ([2002:a17:90b:3d84:b0:332:8246:26ae])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a8b:b0:32e:1b61:309 with SMTP id
 98e67ed59e1d1-3342a299f27mr3043852a91.23.1758796297773; 
 Thu, 25 Sep 2025 03:31:37 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:30:57 +0000
In-Reply-To: <cover.1758794468.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1758794468.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <2bacb9b24e9d337dbe48791aa25d349eb9c52c3a.1758794468.git.zhuyifei@google.com>
Subject: [PATCH 2/2] i386/tcg/smm_helper: Properly apply DR values on SMM
 entry / exit
From: YiFei Zhu <zhuyifei@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 qemu-stable@nongnu.org, unvariant.winter@gmail.com, 
 YiFei Zhu <zhuyifei1999@gmail.com>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3CRrVaAgKCt4ZHUYIFEIGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--zhuyifei.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 Sep 2025 09:25:46 -0400
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

do_smm_enter and helper_rsm sets the env->dr, but does not sync the
values with cpu_x86_update_dr7. A malicious kernel may control the
instruction pointer in SMM by setting a breakpoint on the SMI
entry point, and after do_smm_enter cpu->breakpoints contains the
stale breakpoint; and because IDT is not reloaded upon SMI entry,
the debug exception handler controlled by the malicious kernel
is invoked.

Fixes: 01df040b5247 ("x86: Debug register emulation (Jan Kiszka)")
Reported-by: unvariant.winter@gmail.com
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 target/i386/tcg/system/smm_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/system/smm_helper.c b/target/i386/tcg/system/smm_helper.c
index 251eb7856c..fb028a8272 100644
--- a/target/i386/tcg/system/smm_helper.c
+++ b/target/i386/tcg/system/smm_helper.c
@@ -168,7 +168,7 @@ void do_smm_enter(X86CPU *cpu)
                        env->cr[0] & ~(CR0_PE_MASK | CR0_EM_MASK | CR0_TS_MASK |
                                       CR0_PG_MASK));
     cpu_x86_update_cr4(env, 0);
-    env->dr[7] = 0x00000400;
+    helper_set_dr(env, 7, 0x00000400);
 
     cpu_x86_load_seg_cache(env, R_CS, (env->smbase >> 4) & 0xffff, env->smbase,
                            0xffffffff,
@@ -233,8 +233,8 @@ void helper_rsm(CPUX86State *env)
     env->eip = x86_ldq_phys(cs, sm_state + 0x7f78);
     cpu_load_eflags(env, x86_ldl_phys(cs, sm_state + 0x7f70),
                     ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C | DF_MASK));
-    env->dr[6] = x86_ldl_phys(cs, sm_state + 0x7f68);
-    env->dr[7] = x86_ldl_phys(cs, sm_state + 0x7f60);
+    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7f68));
+    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7f60));
 
     cpu_x86_update_cr4(env, x86_ldl_phys(cs, sm_state + 0x7f48));
     cpu_x86_update_cr3(env, x86_ldq_phys(cs, sm_state + 0x7f50));
@@ -268,8 +268,8 @@ void helper_rsm(CPUX86State *env)
     env->regs[R_EDX] = x86_ldl_phys(cs, sm_state + 0x7fd8);
     env->regs[R_ECX] = x86_ldl_phys(cs, sm_state + 0x7fd4);
     env->regs[R_EAX] = x86_ldl_phys(cs, sm_state + 0x7fd0);
-    env->dr[6] = x86_ldl_phys(cs, sm_state + 0x7fcc);
-    env->dr[7] = x86_ldl_phys(cs, sm_state + 0x7fc8);
+    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7fcc));
+    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7fc8));
 
     env->tr.selector = x86_ldl_phys(cs, sm_state + 0x7fc4) & 0xffff;
     env->tr.base = x86_ldl_phys(cs, sm_state + 0x7f64);
-- 
2.51.0.536.g15c5d4f767-goog


