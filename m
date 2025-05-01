Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91553C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb6Q-0001JT-7g; Thu, 01 May 2025 17:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6L-0001HI-Es
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:49 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6J-0006Z4-Ph
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:49 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so4548315ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133545; x=1746738345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/QVQ9eARYed3NJFRK9UiivRgqBpCyWfc+XTOWrPU4o=;
 b=aDZV01h+aNa/6oF+owR4bkoobkcnTEUSjeLXC1D2c79flAKDLg01NkrmBu2/GtdR8S
 87Wv27uC1L5wnZZQDvzbUFGb/75OHfU60LbBP9DX/M2flC8oQswCIGEyPcmRhEjPGdzP
 CaGB0WJ2x7oiuq71ecAp9xV7jezDRsgy+zwxlF2IW750NEgcyU1imxyTa9P/ZRLYhL9W
 aePxNjOCuN4y7H3dWyWiN28K9ZkiPyM2uCFPwRTz3zCQGgjSEwRD7zBM28qUSoKl5irs
 tITM8ohtvnXyKr/yDvHMmtHrA+577l5aBZP00vT8V58SpbbEYaozggjtItqQdcb8Yxk5
 6ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133545; x=1746738345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/QVQ9eARYed3NJFRK9UiivRgqBpCyWfc+XTOWrPU4o=;
 b=BLy4W0pYRZjtOJoR5DqRcKgmG2WKqyvVtUyTcNXBmhwkfLgOhNwGgciGYC9ABxmgS3
 av5B23dwZ1GwgcrVXqxERT0a8Zc2f1kjeTz0+1URbtlHr6+dK4O6JThKu1OsUgX8keMK
 bv33ZOCtqwt2nOpu6DltDsZsTd0v03kg2eGkL8FTtngcv1X12VJtGm0EiNfdIxWff3s0
 Esh/sySe3JdjY9/qna7IubFMY7/B1Fw/nnqcnl7GlPoIsRlvUKPCNFY5lnSOpJF0+u9g
 Tf/g5qSKXuOnE3gY82qQswOwwX+Lko2TggvrB3aEHPKrDGpUq92iNn3BgoAVn+B+bWr8
 /52Q==
X-Gm-Message-State: AOJu0Ywnu/Gt/lOdpLxQOgg/z1eyQKJZreTUqvu3pqighDI3E5thxsGM
 EwomaYpWHOMzlwIVuwdHr54Yf8cnyYc2tTksg8wsPINnYNIKKZFoVY4Cb11VTabgCPbGwAFzPeo
 f
X-Gm-Gg: ASbGnctr12qbrYsqHeNhIA+Y9unahhFpMR95fC/oH5ScEr02wCk4yXpp+vaiddgwuKC
 40BKjtNKl9dnqqbpBBCpncW3nGROWmPS8FVvCTO4FO7skurTY9VKtk5mPTPBLXTQ6oktUdgLGTN
 i36Z0kUETT2VhZ+4uaRB9NKFrTGJTIxd/Zxfy0WHC99QJBET9nZqpjsSwEo2fpr6rBMuCvXovFG
 b0zhm9Nc1iKzGSalO25DIatLspyFPiYvsaRIs8+xEzg3OdruBs7/SxlCBXpngmMLC/pe679sS5w
 DEFrb0Zf18Rfdmiyjc8AOzyJjDRhH+Eov08H5w6A9ncTRnXCywAqrD1Kg0mcvOGoTq35rdsKnAS
 Wfj0N/bl8301zECI=
X-Google-Smtp-Source: AGHT+IE8GKM0G0mpiOZK0wMVckc0ZPpmMupnQz/unCFyiOCkLSgdY8QJIlLIG973JeMcgYSsJ7o9/Q==
X-Received: by 2002:a05:6e02:1a85:b0:3d8:1d0e:5308 with SMTP id
 e9e14a558f8ab-3d97c17f122mr5120005ab.6.1746133545451; 
 Thu, 01 May 2025 14:05:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975eca768sm3074505ab.37.2025.05.01.14.05.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:05:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 05/18] hw/core/machine: Remove hw_compat_2_8[] array
Date: Thu,  1 May 2025 23:04:43 +0200
Message-ID: <20250501210456.89071-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
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

The hw_compat_2_8[] array was only used by the pc-q35-2.8 and
pc-i440fx-2.8 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h |  3 ---
 hw/core/machine.c   | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 77707c4376a..84bd3735c42 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -835,7 +835,4 @@ extern const size_t hw_compat_2_10_len;
 extern GlobalProperty hw_compat_2_9[];
 extern const size_t hw_compat_2_9_len;
 
-extern GlobalProperty hw_compat_2_8[];
-extern const size_t hw_compat_2_8_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bde19a2ff67..bc0606cf740 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -252,20 +252,6 @@ GlobalProperty hw_compat_2_9[] = {
 };
 const size_t hw_compat_2_9_len = G_N_ELEMENTS(hw_compat_2_9);
 
-GlobalProperty hw_compat_2_8[] = {
-    { "fw_cfg_mem", "x-file-slots", "0x10" },
-    { "fw_cfg_io", "x-file-slots", "0x10" },
-    { "pflash_cfi01", "old-multiple-chip-handling", "on" },
-    { "pci-bridge", "shpc", "on" },
-    { TYPE_PCI_DEVICE, "x-pcie-extcap-init", "off" },
-    { "virtio-pci", "x-pcie-deverr-init", "off" },
-    { "virtio-pci", "x-pcie-lnkctl-init", "off" },
-    { "virtio-pci", "x-pcie-pm-init", "off" },
-    { "cirrus-vga", "vgamem_mb", "8" },
-    { "isa-cirrus-vga", "vgamem_mb", "8" },
-};
-const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


