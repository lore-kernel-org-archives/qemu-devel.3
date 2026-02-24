Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ED2E9B265
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vustj-0001YO-Kx; Tue, 24 Feb 2026 08:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourishduttasharma770@gmail.com>)
 id 1vupgf-0001rl-Ea
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:30:41 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sourishduttasharma770@gmail.com>)
 id 1vupge-0000Qw-0i
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:30:41 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-824adc96ad2so5381439b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771929037; x=1772533837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cU/0LG7CvSD/ElHhaJzwX+s0/1C+e0sN+ZoFBRB8gcQ=;
 b=IjCBKiyKZywGb3PLITnMJHXbdXgxEd2MrIYxHrg3CAEJaiJdOtBIi0pRNQ3uIpPAmI
 vl+6XKn3Yv58tZNT+WeWfpiaHdS4H1ZEQvHciKnUhXF3f1SB7RGhp2baftz8BrZQqjpE
 pq13e52GV/ldiTBUNKAChn7RJol5OItWNVyfZnO7O1dv8GUVVAZVPxhepYPQE9Ns5wh5
 rUESguxqVLRW29hJWwiIL63Db/sXdkbFuMTSiOUrbdmHSeb+8RRjfYk6LTlfTF1yTQ5t
 JtmzT6qJ90/bQHig5DqcCI2VijnOiKtjKxFbtOeDsJcVt0+/9NRQMX9D30ET0laXbMvD
 +tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771929037; x=1772533837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cU/0LG7CvSD/ElHhaJzwX+s0/1C+e0sN+ZoFBRB8gcQ=;
 b=uGhsvkXoXjf/OOMDbgpJyipinrGGOYTaTu6xmAjK1IGDmztyMJcln0LsBqaYo+qN5Q
 bqcO8NM2aarZEZ6PqxNE30LYKWQ1voatyv597lBMREfV6ohPBIZdRcxbxeUJH5mk7y2U
 psEUpspIq4fKiOq1rAI27B4z2jkD+MJnzfMVyilFDzg4D1KI7Iw4hRigKyrjpzpHGlCV
 0TNPAdJnMnjGlNBgv2PVwA5Ez7s198g5dPh2b5g8qbxM1G8E079srf86gKUq3QfLSPnJ
 WLNzlvp4zLu0CAVWE2WFQ+Br0ok0SbAajiL8d5+3qX164FtbQEp8A3n1u3uvM/ARm3Nz
 kGVg==
X-Gm-Message-State: AOJu0Yx7azAsGPPYthvH3cyHb4bJoPpm5O2irxoSRV8WHFD6oiXwFEPL
 hvVcGgkC+DJvnEnioEfKiwygHFx1H1BouY9WyFgxkZb6CvtvgYMq4ImuURCQrmtLgw==
X-Gm-Gg: AZuq6aK47snduYOBqclndafWle73yoDduObzHDFixZ1b/QMCHant1xx1D9GUU9/7QT5
 c3U5dVd/5jDo40Mn8Jm5pq04YmlMbOOgTX5oQoN2/EAJTMay2jO3IQzUiyc1IOLatfaEhKK9cMd
 WKPEshkKWWh1YvT2mljHnAg17KS8yTAu4XUtgpGvd38P5BVRxPdtjDEMmbdQI/JKb+VrbW7cnnn
 kCGsPFpttb5Qlj9FhwuzQ/aDaNvo+1oIYE3saLidm8Z9qSdyXXDvOjwlqhdZlrPkxozUyAhs0Io
 VYryvtFo3MlWwG6MY5xQX0p+/nhqxkSTlpaULMVlwX4y1rO7WRUrGZujEnnkQ3NCZR8BP8Xlu1p
 5iReP2bK+2fXKAAb1g44sBZDpl/XiNIIail0/LM11xMGGxy7POgutJNIFZ8n6qwpXKN3l9viUob
 JMIN9Y5uPsJhZXcXP8u3moQdPLh+NE3g==
X-Received: by 2002:a05:6a21:3b89:b0:392:f895:66b5 with SMTP id
 adf61e73a8af0-39545fc60a4mr10407210637.49.1771929037295; 
 Tue, 24 Feb 2026 02:30:37 -0800 (PST)
Received: from kali ([223.223.131.147]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c70b7243d48sm10977171a12.21.2026.02.24.02.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 02:30:36 -0800 (PST)
From: Sourish Dutta Sharma <sourishduttasharma770@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 Sourish Dutta Sharma <sourishduttasharma770@gmail.com>
Subject: [PATCH] hw/i386/fw_cfg: Use g_new() and g_new0() instead of g_malloc()
Date: Tue, 24 Feb 2026 16:00:20 +0000
Message-ID: <20260224160020.137036-1-sourishduttasharma770@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=sourishduttasharma770@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_03_06=3.027,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Feb 2026 08:56:19 -0500
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

Replace g_malloc() and g_malloc0() calls that calculate the allocation
size using sizeof() with the type-safe g_new() and g_new0() macros.

This aligns the code with QEMU's coding style guidelines, improving
readability and protecting against potential integer overflow
vulnerabilities when allocating arrays.

Signed-off-by: Sourish Duttta Sharma  <sourishduttasharma770@gmail.com>
---
 hw/i386/fw_cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 5670e8553e..ae1ba3b6a2 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -91,7 +91,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
 
     /* build the array of physical mem area from e820 table */
     nr_e820 = e820_get_table(NULL);
-    mem_array = g_malloc0(sizeof(*mem_array) * nr_e820);
+    mem_array = g_new0(struct smbios_phys_mem_area, nr_e820);
     for (i = 0, array_count = 0; i < nr_e820; i++) {
         uint64_t addr, len;
 
@@ -207,7 +207,7 @@ void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
         return;
     }
 
-    val = g_malloc(sizeof(*val));
+    val = g_new(uint64_t, 1);
     *val = cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
     fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
 }
-- 
2.51.0


