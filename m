Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF48CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5AS-0007jj-G0; Thu, 04 Sep 2025 04:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu55P-0006n7-7x
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:57 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54k-0004I8-Ni
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:46 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b042cc3962aso114363366b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973528; x=1757578328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJY1IlIgq7GGkBP3hhYu6s36xjwpVbPeSOjHkNAYnEM=;
 b=ujbQemcQ1csrq8TigLZhY/HJfO3aNWnKZb3SzO110U2hOcasSApv+x0jq3YFpBKqgF
 cExNpJXEC9WaZDkXhtdIeAgFd9smMtiuE9HRqIERWU37IH54Z0uPAQRdBEjQBapYx4+s
 5yc6dJYLCsC+lLjpAdPad77y0wXwLd9/bdJr+1QoedH03WK1YFeTEK2Uo46sHXQqzt50
 Uip+cPAaY0+kOAwzmLFnC47BB8WNzH8236AGDFj4a4NBKPjg84t2l1SGWPKmlkXc1tKe
 Ex0ut9d/VbgZQ5x/cQZauKzj1Rhyje/BMatncT791/+4xLeRd62yTZYoXO+uh9Q1leHi
 ZORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973528; x=1757578328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJY1IlIgq7GGkBP3hhYu6s36xjwpVbPeSOjHkNAYnEM=;
 b=kZZRJB4hdmgYtaJ35kqg9CPywM8bEMXFrMQHLO3x6VBeKNEOUviBlCXU+GOXQTOZw0
 AyMWfdpVIX631VcN4GDP83H86FPy9+T4MOPK3VtTuY7xCyUwZ/MgslMpHWvq5tbqz6DW
 OCNq5wUrjxQD5iBX8Nmc3BEHWS6IWJrIiiz9FnUvtDyRnc3OZQvY6PXPtx8eOxmBM/4y
 Q341Q75Td9vQ7NxXqruJhybX3ypbadQaonCoRPYgyuM12KiDntJajMgK90l/cZAK/Ft/
 /xpMV/bZbCbTBodL6zLQqQH8Atamns/l2ppBr3rKqAuXj1MYiQI517xNDJ3vs2gDmH/k
 2bsw==
X-Gm-Message-State: AOJu0YyXPJV93yE+DdTmueqpCyGPdyovCzQ55tOLFyLj3PfMHy2E0VlA
 fmWbw+OZEbfjv1Q3JkIQjLkLdnEbnwF03ENYCH9saCnQYtgZRBPoC1tn4USoWdLIN4v73MXQJyk
 Isz8dWyyabg==
X-Gm-Gg: ASbGncv/GIJTSXVGisZdEOZ1ZTUEEbfoTMXNvW2Ak8AgBIgxk0AsXi/dhnMWTAhKCnV
 jVxDezRDNZ/j6tcT1l25BGyh72uqpU/cVW0WONbm2f7FCCBJqXIk61zXAa/oGA/IlXRd0o0WdzO
 rkZqr8ELSGJZDe+tP9nKsRoj90QQBa3DnZC1HTjaXDoVtvs0c5NRfccTRsXmmOQWIp4a/wR6qDv
 ywiq2qFnI3A9ioGQZ0Y+rkmHUrAHex2MUvFRQOlRtAEEtipVLOQ/2Q1nH082nfPdKdICCWuH4lU
 QjJ+/W6HHCcAO9iNUhMGPwZf9SmH2cbzLNSrFyxy+W2oK0+0HrcklCdqWzLyTSh/Zazd1wAkKEY
 lbpu4m1vRS4u+VgkPQ0F7g8Y=
X-Google-Smtp-Source: AGHT+IEi9pe0oeBOE15/8xuZT4mmtCw/EODsHqznTJDr3Z4WP9YjhwiV366LnSMgu6QLvZ6qkctWyg==
X-Received: by 2002:a17:907:86a6:b0:afe:bdcb:9e62 with SMTP id
 a640c23a62f3a-b01d973074dmr1930653766b.33.1756973527252; 
 Thu, 04 Sep 2025 01:12:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0424cc1698sm987487966b.21.2025.09.04.01.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:12:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 093DB60ABF;
 Thu, 04 Sep 2025 09:11:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 076/281] linux-user/aarch64: Create init_main_thread
Date: Thu,  4 Sep 2025 09:07:50 +0100
Message-ID: <20250904081128.1942269-77-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 14 ++++++--------
 linux-user/elfload.c          | 10 +---------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 030a630c936..4c4921152e8 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -137,10 +137,10 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
+    CPUARMState *env = cpu_env(cs);
     ARMCPU *cpu = env_archcpu(env);
-    int i;
 
     if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
         fprintf(stderr,
@@ -148,14 +148,12 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
         exit(EXIT_FAILURE);
     }
 
-    for (i = 0; i < 31; i++) {
-        env->xregs[i] = regs->regs[i];
-    }
-    env->pc = regs->pc;
-    env->xregs[31] = regs->sp;
+    env->pc = info->entry & ~0x3ULL;
+    env->xregs[31] = info->start_stack;
+
 #if TARGET_BIG_ENDIAN
     env->cp15.sctlr_el[1] |= SCTLR_E0E;
-    for (i = 1; i < 4; ++i) {
+    for (int i = 1; i < 4; ++i) {
         env->cp15.sctlr_el[i] |= SCTLR_EE;
     }
     arm_rebuild_hflags(env);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 95868739546..f93afbdcea3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -395,15 +395,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    abi_long stack = infop->start_stack;
-    memset(regs, 0, sizeof(*regs));
-
-    regs->pc = infop->entry & ~0x3ULL;
-    regs->sp = stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_NREG    34
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-- 
2.47.2


