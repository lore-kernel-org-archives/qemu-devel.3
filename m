Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1DEECD99E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vd-0006w0-Vp; Thu, 05 Feb 2026 14:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Va-0006tX-Eq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:23 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VW-00039t-Vn
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:22 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so886107f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321557; x=1770926357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPpxu2p+Qu33ItPtwVZLTz+VbMPN1gd77PjFYvkTVkY=;
 b=bAJVH9cNmYk5zaXbMfkaltHGWv8ywuENhTxtljW822rXSbX7r78+IkTbKhefvOu+8z
 gKnp4BEZI5gk1EIkkzQvw5xYaC67QkPB1fPvLXyJc9qNoJgaXWZVlEhwt8iRsIV8VAg/
 s9tWnaLwK69TdvGloPg9zd0xzyjGz6uqPont8j69rrd7y7+BKJerEsfX/CPukRnxntQF
 /9F9xE7PdGcpahI5z8qGew7waEecAPN+D8em9OocPQ+FHzwfnrzFMrkqtXpRnqVGfuU0
 sXIgizQrs82t3cdEFoN8c+QapcQQil4kTts25W6ZGkn5rEenoIHZ6M0D48g1T7HH/cTg
 oRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321557; x=1770926357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PPpxu2p+Qu33ItPtwVZLTz+VbMPN1gd77PjFYvkTVkY=;
 b=dtOTgqGX15R7Qog5Hsm6JIsQa6pB4QtWPl65WjmH71ghDF5DuZGq1aM1YqyTKvZLXA
 nC7dRPJA4FVnjHQZGvP4i9f+8ZA5bp4ivIEnTIoCX6bhJftIdvwGbhnvtQ50Ze3SDX9q
 a7U9grlYshV4SkWeTI8a0tLoxKtvj/wvAb6AsWPpvFb1a+tsbgosKNpElVvK7qttP+Vo
 e0SeOM2Erf0CBaGMVe9xE8ovy6fyj/Lw13Za2/K6qCOmO2xxZid39QC3zKdm5Lb8kC4r
 m4ndX7DrHEszhx7DfJP+D7DivVqXsIW1uuU/k5+nAmNjrSL67GdCmTj4MRFpKkDQJbIz
 IWSA==
X-Gm-Message-State: AOJu0YwuQJJa/OVlvnLoZrMNKQHY9XNDWUYWoJl/0rz9dXj2iJMS7MQD
 YHw7sFOlYVGUvhArV259+3wGL8wJznP/1GXsa/StmAeIrqunNOHOVj3deS6dSXhBs/E=
X-Gm-Gg: AZuq6aL198uZqru3IPvvvPK5i08X+DdB0kZwkUIES7a29b2OhDE4LzeBzS2Xb4CcMS1
 xNVo3chzvV7CUBefRrIb5rf6mhlpsao0L2py6Ose3BTIboxtxDtyDH7bonNNKiWwc3gVqbnVxOd
 tZyrEfu3z1SXtrsdgIMDeYmagivmVieWQwSNHiShLc+ou9C8jpTpQIgjI0W9g7sKIFDOBz9/lEc
 936A9TwFijcbDVBs8wXgfPlkgTmUeuho58/oX7msroUtdFCtYqolyLZhU4Re9OBEUTkrNAbBwAV
 vciXmyD0vvQCrol7tTOCSSYrh+jWvrKDAmMICvZsIgEAJERLEkOjxGvAk1Y5XW2P/zcNMdNCDuJ
 yV2BL2oIu91vxPFhcWj2v3bc6rDgzHdUQJeireMhwJ/nP/SwEP66ugZVxFavdwyV7dtM8jfB4gu
 Dp8Dkk9m/Sby5eyoF0+jUiVDlW9TaXYg==
X-Received: by 2002:a05:6000:250a:b0:432:88c4:e180 with SMTP id
 ffacd0b85a97d-436209bfc2cmr7362732f8f.15.1770321556829; 
 Thu, 05 Feb 2026 11:59:16 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:16 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 22/29] hw/core: Add Remote Port files to build
Date: Thu,  5 Feb 2026 20:58:17 +0100
Message-ID: <20260205195824.2610192-23-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x432.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add the Remote Port subsystem source files to the build system.
These files are compiled when CONFIG_REMOTE_PORT is enabled.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/Kconfig     |  4 ++++
 hw/core/meson.build | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index d1bdf765ee..25f553e189 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -38,3 +38,7 @@ config SPLIT_IRQ
 config EIF
     bool
     depends on LIBCBOR && GNUTLS
+
+config REMOTE_PORT
+    bool
+    depends on PTIMER && XILINX_AXI
diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5ba8160e6..7013638fcf 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -27,6 +27,16 @@ system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
+system_ss.add(when: 'CONFIG_REMOTE_PORT', if_true: files(
+  'remote-port-proto.c',
+  'remote-port.c',
+  'remote-port-memory-master.c',
+  'remote-port-memory-slave.c',
+  'remote-port-gpio.c',
+  'remote-port-stream.c',
+  'remote-port-ats.c',
+))
+
 system_ss.add(files(
   'cpu-system.c',
   'fdt_generic.c',
-- 
2.43.0


