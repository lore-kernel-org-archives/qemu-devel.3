Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82943CD1288
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps5z-0001Cv-K2; Thu, 28 Mar 2024 11:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5q-00018b-C0
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:09 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5n-0001ui-Jk
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:04 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56bc5a3aeb9so1463203a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641301; x=1712246101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NXhpW96pCgkEoWuYwRT5cvChay+RSkHkEuAn7B/Dd0=;
 b=x97DBHoVgI4tYR7nRGTtRe/rqwAZEQT4s8WcHD8FNi45RLtCA841e9dNZVjVuUEBrK
 xyy2HqgA1WLdiDTKCunkHxVG9arRnn0bmWvtpTVpOW8qQYH4EVeRT/VIcPkWNEIg4092
 PTCabCwwP/LqbojA6VaJZPijzutJfqq8efhb7GGJLO7blUIN2v4XKEAzRw5UpZHAcU/2
 IQoqGs+S0CXflPD2IRMpc/57QNfuDnKdNHfc0sbIJXLHOQn2MmgmR0yDg23V2qqxI2xf
 vyUCkKfrNCg6azBT20W2x/AWYrLn+KGNPRfar+HYHLAjKN+cIyMIw8zf69pq1libRluc
 bgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641301; x=1712246101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NXhpW96pCgkEoWuYwRT5cvChay+RSkHkEuAn7B/Dd0=;
 b=Lnc5cBwR7qKcWNam/86Je92EVYkBXjy0c2T10xNAcJ7+KVBgU5lD/BTAc4Xs/xV5ay
 ZiSlFUrnofMUdbk318MREqSojXSN3oay9KDuBf+TRshK1v2C6NoA1dZvA+iIQkY/IQYk
 peJ0bw6zQGMuaG9dBTKCm5qPwKEueXkhmhTUw01Hry6MGacfCwdmDetN8v1ufI8rRe7e
 hmc6fSMpZKJyjh9zNWjrLzLKeMpWB0SIa/CWcZc9NEKPq3DanimDBwHUHobiQGF01xPE
 RWl3PkVGvBZTrpZAceYykVs4rBHzt9ySJgxKSLDcF09guGyZsi/u/RjQnipfosltcRjS
 HpXQ==
X-Gm-Message-State: AOJu0YynJiPX9ZzXkAaZX0vFsHYuK9fQDzP79Us+Qq1f4ze9FWP6c4HM
 TERZPrGqNO7EUtsB5jkbVmOLjNnWvriwuaW+b5v8W8t6cKdZjk6gliJxYfuCRAzG72PhNo4BOkv
 7
X-Google-Smtp-Source: AGHT+IF6f1YMBvOfsUocaggEtYJ9a+Kecpnx8/ab4gXfJ3RdBR3huqwiywmto+50jVUBk5TY6jKE5g==
X-Received: by 2002:a50:a412:0:b0:566:f81:41a1 with SMTP id
 u18-20020a50a412000000b005660f8141a1mr2402222edb.22.1711641301544; 
 Thu, 28 Mar 2024 08:55:01 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 d15-20020a056402400f00b0056c5395e581sm753171eda.70.2024.03.28.08.54.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 03/29] hw/i386/pc: Pass base machine type as
 argument to DEFINE_PC_MACHINE()
Date: Thu, 28 Mar 2024 16:54:11 +0100
Message-ID: <20240328155439.58719-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Currently PC machines are based on TYPE_PC_MACHINE.
In preparation of being based on different types,
pass the current type as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 4 ++--
 hw/i386/pc_piix.c    | 9 +++++----
 hw/i386/pc_q35.c     | 3 ++-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6b885424bb..33023ebbbe 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -268,7 +268,7 @@ extern const size_t pc_compat_2_4_len;
 extern GlobalProperty pc_compat_2_3[];
 extern const size_t pc_compat_2_3_len;
 
-#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn, parent_class) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -277,7 +277,7 @@ extern const size_t pc_compat_2_3_len;
     } \
     static const TypeInfo pc_machine_type_##suffix = { \
         .name       = namestr TYPE_MACHINE_SUFFIX, \
-        .parent     = TYPE_PC_MACHINE, \
+        .parent     = parent_class, \
         .class_init = pc_machine_##suffix##_class_init, \
     }; \
     static void pc_machine_init_##suffix(void) \
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1be1e050c7..b9f85148e3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -462,7 +462,8 @@ static void pc_xen_hvm_init(MachineState *machine)
         } \
         pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
     } \
-    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
+    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn, \
+                      TYPE_PC_MACHINE)
 
 static void pc_i440fx_machine_options(MachineClass *m)
 {
@@ -824,7 +825,7 @@ static void isapc_machine_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
+                  isapc_machine_options, TYPE_PC_MACHINE);
 #endif
 
 #ifdef CONFIG_XEN
@@ -837,7 +838,7 @@ static void xenfv_4_2_machine_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
-                  xenfv_4_2_machine_options);
+                  xenfv_4_2_machine_options, TYPE_PC_MACHINE);
 
 static void xenfv_3_1_machine_options(MachineClass *m)
 {
@@ -849,5 +850,5 @@ static void xenfv_3_1_machine_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-                  xenfv_3_1_machine_options);
+                  xenfv_3_1_machine_options, TYPE_PC_MACHINE);
 #endif
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 43ee1e595c..7dbee38f03 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -338,7 +338,8 @@ static void pc_q35_init(MachineState *machine)
         } \
         pc_q35_init(machine); \
     } \
-    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
+    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn, \
+                      TYPE_PC_MACHINE)
 
 
 static void pc_q35_machine_options(MachineClass *m)
-- 
2.41.0


