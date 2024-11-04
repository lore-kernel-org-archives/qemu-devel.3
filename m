Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1D6D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpP-0007pM-Or; Sun, 03 Nov 2024 19:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpN-0007ig-DK; Sun, 03 Nov 2024 19:20:17 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpL-0002Zr-VL; Sun, 03 Nov 2024 19:20:17 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e600add5dcso1564002b6e.2; 
 Sun, 03 Nov 2024 16:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679614; x=1731284414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5sPzbUGgSsU4x2ABl9K5sldSfgeOH1YuMonG4CNaHQ=;
 b=DuJnHZK3JELeRsWnIFALa5Hd+g5mghPsf3HuXRdo7SLccx8mQLu+dhW0F+/Ux6bB0T
 k/fd4GBQ0YHacz1qHplbqTD40EJaTUGncKP9faKjk5LoedffHIfWPhvr3UwqdexhFEV3
 ZdUqE8yapoSn6I1wOlD08Ci6SxoJznHnmds6qb5kj7ZdDzudZYeJaUazWOPVhxNPH0HR
 pliT/vVcEh3VCgQqYIHdpxGce804pRhn5crO+W4iDZ0W+6KakcPceJSAfdAPYQJoOeUL
 wwx4aFmMY36xMGIXp071YYJ1W49jUjupiBRCHhYS/+XT+/ASTRAc9eZs5GHGk4nv1hwb
 SMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679614; x=1731284414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5sPzbUGgSsU4x2ABl9K5sldSfgeOH1YuMonG4CNaHQ=;
 b=Ck+iAzOOIU7c8D3vPAK5k4bGk9+TVI+YG6mpwQbifIAHotbaHch8OtBz3hACnesjxc
 a6OPlD6Zp5yvfDTPd4cyrftdrT0Wv+BMgvT/GBWB6k07nEuGf+a8o74IIvb22Sl4faqF
 SWnlZhv4yct4u1TtZWattmnYGwrCT3+xsN4sTDReFls4c7uF+GUXoHBLQOSPiEnFD4rx
 vh12rXN6a9qrSHZ9ByKJ4D6+q/Uj9W/M94kHaTVdsWWAwf81Xuo4L/TaLDLjvUirzesg
 xTMPiVYndiV3IB9bB7MD8GcIDXhH4ciLUzQoi2w/UUfz8/0SVtCmo4waMlWOxj1Wwr5N
 HnMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1FpfHs3gz2ft3FLBevamr+P9lQqWDoG3wi9vsfxN5jZs0G0XALfkWuE6LT1PSIBCnrz5jjLC+2g==@nongnu.org
X-Gm-Message-State: AOJu0Yz59jigthWszd2PF+bkLuT8TThq6BSS3xMVLF2/3dc7d1wPFL13
 kYoeDntAvO0nM15yhruspO0xCt3e0nEbL0d8ES1uwQpdSs2j5bEtWLf1gA==
X-Google-Smtp-Source: AGHT+IH87p294n2CcfhzwQlusQ1FEG2uTgbaXNTUeEZXavl/i6ZNpysioGZhmsFqgSU7Ozel3yqTSQ==
X-Received: by 2002:a05:6808:2e8b:b0:3e6:ccc:2d91 with SMTP id
 5614622812f47-3e758c9d90amr9372381b6e.29.1730679613649; 
 Sun, 03 Nov 2024 16:20:13 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/67] ppc/spapr: remove deprecated machine pseries-2.1
Date: Mon,  4 Nov 2024 10:18:06 +1000
Message-ID: <20241104001900.682660-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.1 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/core/machine.c   | 11 -----------
 hw/ppc/spapr.c      | 11 -----------
 include/hw/boards.h |  3 ---
 3 files changed, 25 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17eba..a41d1dbe26 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -297,17 +297,6 @@ const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
 GlobalProperty hw_compat_2_2[] = {};
 const size_t hw_compat_2_2_len = G_N_ELEMENTS(hw_compat_2_2);
 
-GlobalProperty hw_compat_2_1[] = {
-    { "intel-hda", "old_msi_addr", "on" },
-    { "VGA", "qemu-extended-regs", "off" },
-    { "secondary-vga", "qemu-extended-regs", "off" },
-    { "virtio-scsi-pci", "any_layout", "off" },
-    { "usb-mouse", "usb_version", "1" },
-    { "usb-kbd", "usb_version", "1" },
-    { "virtio-pci", "virtio-pci-bus-master-bug-migration", "on" },
-};
-const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2c10a70a48..e9518ff8b3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5381,17 +5381,6 @@ static void spapr_machine_2_2_class_options(MachineClass *mc)
 }
 DEFINE_SPAPR_MACHINE(2, 2);
 
-/*
- * pseries-2.1
- */
-
-static void spapr_machine_2_1_class_options(MachineClass *mc)
-{
-    spapr_machine_2_2_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_1, hw_compat_2_1_len);
-}
-DEFINE_SPAPR_MACHINE(2, 1);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5966069baa..44d19e1ffc 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -828,7 +828,4 @@ extern const size_t hw_compat_2_3_len;
 extern GlobalProperty hw_compat_2_2[];
 extern const size_t hw_compat_2_2_len;
 
-extern GlobalProperty hw_compat_2_1[];
-extern const size_t hw_compat_2_1_len;
-
 #endif
-- 
2.45.2


