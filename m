Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6E8CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDPd-0004Zz-TF; Thu, 21 May 2026 20:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOP-0002xW-5I
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOH-0004k2-P4
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:27 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bc763e2ba8so32886155ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408324; x=1780013124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+87QTMcfFX2FyZwbh4AAcXaUu5KgnVrJc22KYW3tTY=;
 b=onDoiNjBTDlyw+L4pgnjz60zk10aAuRMuRcr8IE6u8xuFFM02rGflkxnJ5/G3gU3gB
 +75I5YGzEK1ZmYH50jrnBXztYagXihYnUM6KuMx9MsufFJAo6veta+GcaBpsRjovKDa7
 Jrx0b6sdJJMcHqIf/o4CqU+0ol6voVdA3qwdZNhYlBT/7dtdMqWfZ0H+QMKLjX1AxAsa
 U7k/ZQArFvyGLQxmCGo5AiBadPF9R6bCaRlKDBBmgsEYj/jx6TptxpnGQElgRDLgCHIO
 pfwW7lR6pz/mt2NAdq6fKYWRCPtKN88x2YjkZmxfidvnTabp8/ad84I/s77eGoXMfCdl
 qc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408324; x=1780013124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j+87QTMcfFX2FyZwbh4AAcXaUu5KgnVrJc22KYW3tTY=;
 b=aeIixnHqu48o0wIPw6jGNT7YvyuHWyHgcwOOK0yUd3tDBjj9sKBg+zKdo2UL3PqqvE
 ck9e0DsOBZmZi7ijlJaH/Ke/OxOhd30KevO09q4D/wadx91qewItIo/bg7jK38J+ZTlt
 EgITFYENqk5ZgoPjxnlelV+/1wD1RFto9cjDaBhDxr/4+GP3ZV/jRdwgqeVQrJFF/39x
 Nw16fs8RaDPN+78nkm7d70yW+XK1Ys0GNFoyLp1VG02O4f0xvTpZMtXnxT51eZG1sIRX
 JP0hoq1xCWhccjNBlnIxZoZ+ghsCPTzwNA0W0UpLt/ZFFD9n3hQFswiAkbxE0RNqg3C6
 IeVA==
X-Gm-Message-State: AOJu0YwEoKlwdSL0QW+CpgdNIoSEoF+etazlVIs9RBTdoZfJDcx5FaEA
 XlXw65XRpabTNFqDUDiGdHuiP/v3kyZjE8LW1f026ETCSH1BMl11dG5RMwqIASla
X-Gm-Gg: Acq92OHyN+veulQ1nxWzchZNUwyVsvTd1q2SnCcSu/RSZvPJgpHRlGJ5IJlFtXws8NG
 Yxv/zW228snmAssI8Vst+IpKgD7JF+WwPQ+9mL0CEJFSSIW9f3N0r1Lh6zHF1rO3vFeVpcAjxVH
 O/ymvgBDFtP7X9GvRU8WlpPl2eKAqvuDb295Gge2RdzNCK6j7g0tTxtm7u8+og9CiJ0bYnPzmMF
 EJu1C1GYTfnfje/vlqGXPf/zrtyw8gklH4K5SpxaUdblJFy6VwFO1GnnxP59lLaADtL4NJ437gV
 PVdXfgLa4z1g7miUoNBzOSpxtryIBwReM7lBj4QE4qqBlL+nnTMcb9DM+BSTS10hzgf8NH+dYI6
 rwUGTLETPa1ANbL9A6B9pe0bzfZXysvKYTTpUnlMq0bHjKXMO32RnSpIQG9CyFY2w/jK+7HvSQ6
 hjf3A0LirBJSKHGZA0zbHKL1z01zdlk1veLwe8Vw9OsOrFFMBz/HSf
X-Received: by 2002:a17:902:e74f:b0:2b2:58c7:2ce1 with SMTP id
 d9443c01a7336-2beb07da2dcmr9938835ad.36.1779408324479; 
 Thu, 21 May 2026 17:05:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/48] target/riscv/kvm: use isa_edata_arr[] for unavailable
 props
Date: Fri, 22 May 2026 10:03:10 +1000
Message-ID: <20260522000324.23255-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Use isa_edata_arr[] directly instead of going through 3 different arrays
to populate the unavailable KVM properties.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-10-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 34f60bd80c..17ba38403a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -535,20 +535,9 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
                         NULL, (void *)prop_name);
 }
 
-static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
-                                        const RISCVCPUMultiExtConfig *array)
-{
-    const RISCVCPUMultiExtConfig *prop;
-
-    g_assert(array);
-
-    for (prop = array; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
-}
-
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
+    const RISCVIsaExtData *edata;
     int i;
 
     riscv_add_satp_mode_properties(cpu_obj);
@@ -582,9 +571,15 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                             NULL, multi_cfg);
     }
 
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
+    /*
+     * Mark all isa_edata_arr properties that collides with
+     * a KVM property as unavailable.
+     */
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            riscv_cpu_add_kvm_unavail_prop(cpu_obj, edata->prop_name);
+        }
+    }
 
    /* We don't have the needed KVM support for profiles */
     for (i = 0; riscv_profiles[i] != NULL; i++) {
-- 
2.53.0


