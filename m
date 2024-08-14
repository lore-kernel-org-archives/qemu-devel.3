Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB54C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 23:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seNY6-0001kV-8U; Wed, 14 Aug 2024 19:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY5-0001hB-B2
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY3-0006W9-Oc
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d18d4b94cso276342b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723678618; x=1724283418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHisr3UikbRag7D0QJ33pcI9STMq6DpazTYXpbTOwMY=;
 b=HBLcCOEgy0DeFQZLiiV76slyZ9lgCegKElLLLIVNeseNl0Q+gYs9oauvw2tGIJjxmh
 od5kaI5mcalpQWoz6Z9OZIAhXNN3vQvjxbywkZoOOOPQ7xe9Swhb6bbTfO5aSELPbDpd
 DnyJG7v9GHwqoyF3mAeTRMaC8QFGnI47HGIeB8lpfj3auROc9yI8BH6TpmhDlvPsupJy
 7z/Uy9Ny62CbxAVPDuaw33mdE6gNjXH4oVxyzy2GoV3aFZQ6sP/7vTOBwGuhqlNPUgn8
 HvZvRwtJaaWVEXpxOwESdNf98Un24oJf6HI4X+I56baF3Gaa1+n07niWKN0fPykh0vec
 37Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723678618; x=1724283418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OHisr3UikbRag7D0QJ33pcI9STMq6DpazTYXpbTOwMY=;
 b=vvRPne89dE5AQbmPH+bRZRXyKR0lT6IsEb4u0coXNVWO0nxHljWgsit92KhZN0wFvw
 FNt0PVC6drFhNBRK2f32V8/1a9Xxv+9w93PxYRfC8QGK43feX88KbWY7VCaxVzLu6m4W
 nErOEL3N1WCbz6qZg8jLBUrSSVoWQLu/kTUw0FzU5MKQVFRKnVxqW56tZARORr5f2ru1
 YJ8doIN4v8f4wsXBQ3iMIvdiAiGPUIH2EEyvn7WtCfZbtLaz0m8DNy9XTeCxScPOBKW+
 ZHhmucZP/FwxWdrlUGuzwO5FCHDRHpinBcrT/JYMPS94TaD7dpq9l+VUn6FxxdrRkNve
 yA4A==
X-Gm-Message-State: AOJu0Yyg0vmenKneoAU5Axr7VP/ttzve3fi05hfK18qYpqFQVPo8OEWc
 oQ7SBPwvtxJtU+PCGL/oPy0AXLpiboSMdScKenLercIjiCHaNG7zpHSvHI7tQinKbT6Tku1qbLz
 aMk0=
X-Google-Smtp-Source: AGHT+IHXyYUb+nK7n0KwdvSo1ZfOGSVr8GxiCN3LqPpbhOi8eh+FyIDNujNiCWlLU8tqU6H38Vfcuw==
X-Received: by 2002:a05:6a20:6f0e:b0:1c8:92ed:7c5e with SMTP id
 adf61e73a8af0-1c8eaeb3b5emr5140262637.23.1723678618196; 
 Wed, 14 Aug 2024 16:36:58 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef57dfsm112164b3a.115.2024.08.14.16.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 16:36:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] contrib/plugins/hwprofile: fix warning when compiling on
 32bits host
Date: Wed, 14 Aug 2024 16:36:42 -0700
Message-Id: <20240814233645.944327-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Found on debian stable (i386).

../contrib/plugins/hwprofile.c: In function 'new_location':
../contrib/plugins/hwprofile.c:172:32: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  172 |     g_hash_table_insert(table, (gpointer) off_or_pc, loc);
      |                                ^
../contrib/plugins/hwprofile.c: In function 'vcpu_haddr':
../contrib/plugins/hwprofile.c:227:19: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  227 |             off = (uint64_t) udata;
      |                   ^
../contrib/plugins/hwprofile.c:232:62: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  232 |                                                              (gpointer) off);
      |                                                              ^
../contrib/plugins/hwprofile.c: In function 'vcpu_tb_trans':
../contrib/plugins/hwprofile.c:250:26: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  250 |         gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
      |

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hwprofile.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 739ac0c66b5..ee94a74ad94 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -165,7 +165,7 @@ static DeviceCounts *new_count(const char *name, uint64_t base)
     return count;
 }
 
-static IOLocationCounts *new_location(GHashTable *table, uint64_t off_or_pc)
+static IOLocationCounts *new_location(GHashTable *table, uintptr_t off_or_pc)
 {
     IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
     loc->off_or_pc = off_or_pc;
@@ -201,7 +201,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
         return;
     } else {
         const char *name = qemu_plugin_hwaddr_device_name(hwaddr);
-        uint64_t off = qemu_plugin_hwaddr_phys_addr(hwaddr);
+        uintptr_t off = qemu_plugin_hwaddr_phys_addr(hwaddr);
         bool is_write = qemu_plugin_mem_is_store(meminfo);
         DeviceCounts *counts;
 
@@ -224,7 +224,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
 
         /* either track offsets or source of access */
         if (source) {
-            off = (uint64_t) udata;
+            off = (uintptr_t) udata;
         }
 
         if (pattern || source) {
@@ -247,7 +247,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
     for (i = 0; i < n; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
-        gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
+        gpointer udata = (gpointer) (
+                source ? (uintptr_t) qemu_plugin_insn_vaddr(insn) : 0);
         qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
                                          QEMU_PLUGIN_CB_NO_REGS,
                                          rw, udata);
-- 
2.39.2


