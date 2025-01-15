Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC94CC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjt-0002Qw-PI; Wed, 15 Jan 2025 18:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjr-0002MX-9r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjo-0003uo-8I
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:55 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so2186825e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983430; x=1737588230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exJ7Ca3R/vq/HHzULuRBCmKkoI6lPeGDRYWa7f2d41s=;
 b=ltqqemIL8kDimkO2flxzXEWJ3J6J5mbZjly7XajD0dzUPeEBJOArTla3ZqcTA0Hcx+
 mexP2xyKhlzMaKKTY1hv6veIv3F3EDwr5yUqWC5v4B8Ncxxl7qcN6fcfFDdYL88WumM/
 ct7XWSBj9qutTEEVXwCQJtLEVAOb+GNbOLIfcYu+w9KbJzy11ExtQwlD+f1xpTkSb8AU
 2bYQ2WstAArD0QM5bDbuEPxzmCkNjAI2/UOKutDz+JEorkjSh4+BXy+l4XlMgbQX6IDY
 oZZtEXTpgWmWT+L2g9W+/TBUJUnAgRC7mo2kMQcnn7Znds0Z5O1jTBDjOwbsbAr7xzOg
 g0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983430; x=1737588230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exJ7Ca3R/vq/HHzULuRBCmKkoI6lPeGDRYWa7f2d41s=;
 b=qnPD9Bm87U3uu4q0ZHAVjeyLJflDPmd5X0S8UKK/A0TgrmCKj9/UpSPt0vnqT+kzfx
 Iehc/41DPl8YWjh/pE4KuYo9wnAtHyPyT8PG7dB4mAr7w++T/gijJQXQGz6Ru5bNcT7k
 7xo6pxyvM6VRXMryA5EQL+lh9iwnCx4CBF+qLnWjlO5g/fVfGHSEMnPJ99P+K4SMYIdM
 PIk9gzasINIY+2VipIsTtArB2PSAd3xxurPYS11E6wgK/PE6qI2zZ9Gh+YId4cK0vxAD
 rtYaCd1Cb6qNJdz9RNLiwHhW/qLLAWc2+jvV5cl4MFhBXn4Aj6qxrmTV+mgBo1IoqlCH
 Ri7Q==
X-Gm-Message-State: AOJu0YxplnjPt3tbtS2QUSzdhvBiNHL5qzdmFRJjMq4kXE2TJiQ64KNc
 EWQG3UMKW7vTAHKe57ZtoSzDTejjBUKOvXFWYF9EZ/A/s6L6zQKw0ci/XvdlD5/7jK7fnfi6OaL
 Fbx0=
X-Gm-Gg: ASbGncuE3MxMQVxoVjvPE5MeJfohmA0+z3xcoBvFIoTk+cqkniUOwq6yEwUhY6IwBOV
 U+2qyBqNn9TpcHyQ7XoPBOUmWPMXgBuUDfgE65jn2Fl07HRQivRcX2kJtIJMDtod2ozIiwoL6MC
 nee2rNS/mF5ezbmhEUr06AuE0aTB3fAjpg/PJX58apvWCh9XnNPq0sNTVHdAVMPSKSQouG6Y1nJ
 Inp1sANsM2+drjQwf69QDqKGPLUzk2jmjWzGY7qwLsTqmxXErZemas8eZuzOlg9rczkQew557VW
 K0t6GdTZrsKAYEEVqdUKSxaePMt6MHQ=
X-Google-Smtp-Source: AGHT+IHMK86u6r2/vg6SvATG2OTWt+CQ3fo0OeWwKfkQx2OH3lQkwkFdh1ZvjfCR+7Y3tp7/F1hyYw==
X-Received: by 2002:a05:600c:3506:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-436e26f137dmr302758155e9.29.1736983430377; 
 Wed, 15 Jan 2025 15:23:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b44sm19019996f8f.90.2025.01.15.15.23.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 11/21] hw/i386/pc: Remove deprecated pc-q35-2.5 and
 pc-i440fx-2.5 machines
Date: Thu, 16 Jan 2025 00:22:37 +0100
Message-ID: <20250115232247.30364-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Remove the now unused empty pc_compat_2_5[] array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst |  4 ++--
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    |  3 ---
 hw/i386/pc_piix.c               | 13 -------------
 hw/i386/pc_q35.c                | 13 -------------
 5 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e4bdb385a25..7b0eaa6ba90 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1012,8 +1012,8 @@ This machine has been renamed ``fuloong2e``.
 These machine types were very old and likely could not be used for live
 migration from old QEMU versions anymore. Use a newer machine type instead.
 
-``pc-q35-2.4`` and `pc-i440fx-2.4` (removed in 10.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-q35-2.4``, ``pc-q35-2.5``, ``pc-i440fx-2.4`` and ``pc-i440fx-2.5`` (removed in 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 This versioned machine has been supported for a period of more than 6 years.
 
 Raspberry Pi ``raspi2`` and ``raspi3`` machines (removed in 6.2)
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 31e799061ef..02c0cb8bd41 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -295,9 +295,6 @@ extern const size_t pc_compat_2_7_len;
 extern GlobalProperty pc_compat_2_6[];
 extern const size_t pc_compat_2_6_len;
 
-extern GlobalProperty pc_compat_2_5[];
-extern const size_t pc_compat_2_5_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6d0c9014d63..137f827b69e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -254,9 +254,6 @@ GlobalProperty pc_compat_2_6[] = {
 };
 const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
 
-GlobalProperty pc_compat_2_5[] = {};
-const size_t pc_compat_2_5_len = G_N_ELEMENTS(pc_compat_2_5);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 64c1ab5ff3f..ae573a39836 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -767,19 +767,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-static void pc_i440fx_machine_2_5_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_6_options(m);
-    x86mc->save_tsc_khz = false;
-    m->legacy_fw_cfg_order = 1;
-    compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
-    compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 5);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 847f56263f3..ff473b67985 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -661,16 +661,3 @@ static void pc_q35_machine_2_6_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 6);
-
-static void pc_q35_machine_2_5_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-
-    pc_q35_machine_2_6_options(m);
-    x86mc->save_tsc_khz = false;
-    m->legacy_fw_cfg_order = 1;
-    compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
-    compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
-}
-
-DEFINE_Q35_MACHINE(2, 5);
-- 
2.47.1


