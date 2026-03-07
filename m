Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D172F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytYj-00059c-FA; Sat, 07 Mar 2026 10:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYi-00058Q-AF
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:16 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYg-00086Z-O2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:16 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48529c325f0so9047855e9.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897232; x=1773502032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wU/ORYoX5ce355SU/U4E1I4Pjxf2Ge86mQ2n6Zg+duM=;
 b=H27JEagZdtdEsqd7+Leh6hZa4qy/uYhaPQL3LBxOkcSrcPRGFEPVFw3BRH0QXnwL2u
 C3HI4rf4zRFbAnFabSqbLRxApJ7iG+/iuyEShKp6O0IMrF4IQEbg1bPz9ikzbW0EMZAk
 E5qmqiG5kJd3ybudRQ6kJC/SAFXY0lIMn9c0kM+bhYUgv53ynIKPZP2Ptw6P3G9XkBt+
 VFl1qL5nafFA9s0AYFgYKkotXs78ZOJ2A83ELrsMbEouB7EJC8hYTMuPM5UCTFAgAM4y
 WlMOGhY9/gQbgyr6R8B3imTP2I0nl53+y6o/953XlaXvTHyBsft7bZ3F7WKAyXkUWqg9
 gIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897232; x=1773502032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wU/ORYoX5ce355SU/U4E1I4Pjxf2Ge86mQ2n6Zg+duM=;
 b=HVNFrgRz4Apm8pA6zq3fuSjqf3ABW1Tn1nIvvEcG1Tw8fmjKmH/s2pxfMOD4cHtdRV
 6jE+Et6P3tvjCvpXPuqbb+fYFCOafu8TQ3WwgWRe9wqiGdCx4beuzSzVkAPZUr9Ms+IM
 XJKDUQtVdM6K346LSFmCVGuj/bePUm4FnkDi3qeTkWRrmmi0/h/0RF316InUI/o7Hxdl
 kECWMqGISM+Ni1LYtrsdi3yAf7kenuqKca2qgndtqVmB1Q0vfzW5oMYJ2GjhI2M8KPjG
 N3/s3/bXQNsZqh/rJm3WuiwKZ3BiIRBa3397aIaojraTAQcIviHMhqbPz4YEJ/Z0tUIh
 p1ug==
X-Gm-Message-State: AOJu0YwAQSZsbYVjC5FQkXmHlgxqERtjZyI1DbVhuemzqWAO51BGiDS6
 G01Tl+CaubuAiB4CrFSl/HUKFP6CC/wGhzWdhEzGSKUKLQ0C7VKeCeMKP+FMx7rm3oVTJmfUWdU
 pJFBXrr8=
X-Gm-Gg: ATEYQzwHvaFk4T85safqN6DiYn6a8q0UF/DzggwLO57Gp/Qjpzs1o9N1Kx5lZIG/ipM
 GdVPY64hutGcIOGdeDQO8bYyqgZA/OzgvDbDB2FCuz4x5WS7gqdLgRz02yCPZ6oNX69OId5tDId
 k4QPs0w55KZfZVDdPSXH91r+SCH8NSBNRBPXUL9enkyTRqvCBmGbQzuky5k8hBzsESwa3JcymsG
 G+aNfKhdpoMZgcJAXTYBMAUEjU6UzC+DA0LR9K9xYuZAWG9Al3OSkfj7imeh41rQ07Aqcc2VDvv
 gjsZKfxg5IFcXCFY1Y7Bw4V92vo4B/9hJPdIZO3szULsP6tUmXCbVfLkbJVHmbKEIoCJxQ/nTWJ
 Fu2u8OyQQKKgtRKvtKbeqzhTZa3IzpmPEdMy4vi37ZcsgDcu987RxhZriNdAFSGuW6Ad+tHCKew
 kghRECYci2ZNZo7cZsu7PzJdIHXQfSUjRk4VpUX4U/+txKhNJB4UQIc4WzRltdQmunvUML1hyr
X-Received: by 2002:a05:600c:4e04:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-4852696759cmr95375645e9.23.1772897232587; 
 Sat, 07 Mar 2026 07:27:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b7547sm122750245e9.12.2026.03.07.07.27.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:27:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 05/10] hw/i386/pc: Remove pc_compat_3_1[] array
Date: Sat,  7 Mar 2026 16:26:29 +0100
Message-ID: <20260307152635.83893-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The pc_compat_3_1[] array was only used by the pc-q35-3.1
and pc-i440fx-3.1 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 25 -------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 908de5e1eab..4e1dd436ab7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -271,9 +271,6 @@ extern const size_t pc_compat_4_1_len;
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
 
-extern GlobalProperty pc_compat_3_1[];
-extern const size_t pc_compat_3_1_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b11afa0531c..93d1a52d712 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -189,31 +189,6 @@ const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 GlobalProperty pc_compat_4_0[] = {};
 const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
 
-GlobalProperty pc_compat_3_1[] = {
-    { "intel-iommu", "dma-drain", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "npt", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "npt", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "EPYC" "-" TYPE_X86_CPU, "npt", "off" },
-    { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
-    { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
-    { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
-    { "Cascadelake-Server" "-" TYPE_X86_CPU,  "mpx", "on" },
-    { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Cascadelake-Server" "-" TYPE_X86_CPU, "stepping", "5" },
-    { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
-};
-const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.52.0


