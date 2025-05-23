Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24723C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHlY-0001I7-C1; Thu, 22 May 2025 22:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlR-0001Fc-OY
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:04:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlK-0007ki-V8
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:04:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso4363031b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 19:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747965833; x=1748570633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=VkgJWWSrJOxj8cqyEbqWQJ8t1muJ2xduSTJZSegqLvZEki8sLx1FJICKpk5hnJLmUE
 NxCJwDoclwNCK6/8Y9a/sBnDjoZy1XOnpzU8IZPDa5nawhiuIKt9KID9hmY8BTWVm04c
 wYC4qTPuEkI/FWZ1cyrVfEiLTsHf8trDqKICsKH40C3GdIlrXwuHpgw7uwiCkU/5kUjC
 I3ZQb9lwzMF8IOiBZE2cijypJDZKjS3/uTenk8lqmn4PVZ1BEHDrhs0jEKgkN5tyjo0u
 Vj468QzqO8BNntN5dV6mu9GnWqr6e0HUsVHgCePyE5dErwJsjkgvNF2rlwrxZKeoU3EX
 0ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747965833; x=1748570633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=KbnmAigxWl7Fly2XvaYw9e/kw0sn/Eb2ZYOKWqBQfWfUWiRuxyYCviLObeBIj9uTTp
 kGCQyH+PbwO6W+vuuS9QEy703/FbFTpquKnOEAfHDAYdUn164RmyZ0Aav4oKUP8hEEsw
 x6VUi4eAx/tBDttwUfoyyIC5JCsr3WJY0UdDaPYHzHMe1FK2kZeM7+nsP8fXhrNV0Uv8
 /jrPlua92E/velI9gc/As7cyWg+s9MbOYXaOb6OhuYa21T5VIigP51Y3u/eeUT52E9Xp
 21o5zQrGvdldVtPpNlsGUNleLGR5meym/0iknqYatVaUfpgwJREXdE0QDA+9O4hbu993
 rJuQ==
X-Gm-Message-State: AOJu0YwW+WpRUnA5luIqtbDQpG4uH5kUTP3UstMFFQ+3GobNJERGRmRf
 sXc04TcGQzDiMkbhqxoA0SbJZgMUPfztPF7apydyfvfyVXFJauHUUV9nYPzczMs8RrA=
X-Gm-Gg: ASbGncv2YRdX/TJtHRBFKBqkCkKBL53yz36OcJQTafWDu257p9yZ59PAZPlJbBYn8fZ
 hgamhGpnxrJby+8HHEmUKWDJuDjX1sISMv3VEFWVS5h6b4XcBTqFk9Nv69OdcwnHwTtWv+38s8L
 0Yfzx1d/eol2xV+WtXdGrpmp38SD6eN+WVCcDgqVgHN69hg7FM1F8CamtBx2CVLiZ+vQqc7DK4K
 HEXEu0n2saH1njGMMOgXd+uF5okatF9Y8y2ebnh2p1e5ztX2npSWbk769koWBtXCQ3NY+MZ27sl
 p01Px3UFaoFTvuT5xfDCxktcugL6frKOad0LY+es4pZfeaur+qBcAkfp4aZvqg==
X-Google-Smtp-Source: AGHT+IFsujTE/WP91RBzfc4Ma15ALzQau+vs5gDpYvGLFDvfVcUDHt1l2MbdxhInoQW48PhI//cgVw==
X-Received: by 2002:a05:6a00:98d:b0:736:34a2:8a23 with SMTP id
 d2e1a72fcca58-745ed8f5d5bmr1702673b3a.15.1747965833047; 
 Thu, 22 May 2025 19:03:53 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a242asm11820818b3a.164.2025.05.22.19.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 19:03:52 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v4 9/9] plugins: Update plugin version and add notes
Date: Thu, 22 May 2025 19:03:43 -0700
Message-ID: <20250523020344.1341179-10-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523020344.1341179-1-rowanbhart@gmail.com>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x433.google.com
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

From: novafacing <rowanbhart@gmail.com>

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 2cb5de9f64..170a79e667 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ * - added qemu_plugin_translate_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.49.0


