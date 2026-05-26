Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872E5CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRx6o-0000bc-Cx; Tue, 26 May 2026 15:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx6f-0000Z4-Uk; Tue, 26 May 2026 15:06:26 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx6e-0004iX-HF; Tue, 26 May 2026 15:06:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12C1460121;
 Tue, 26 May 2026 19:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DF41F000E9;
 Tue, 26 May 2026 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779822381;
 bh=Cw9b2yaVekAwr8cSAaU3u13HS5WHaa+YXcm5rfw6fPc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m4nG1c/70qCPw2yFUTxgY4+BBz2x8b7d2aoKSTKFQ1CYDUWpM+GNiXRXNP7qHGZtV
 yU2qRgc03He2/tiUaOlSoclNgS0E81aIvSvO1lo57AvTrfq+bzjIgNH0P7B5hbVzYz
 2TRjO/HQScx3DHxK940jhdy73vzdA5r69X3Kq7tTQEjIEfS7BZtf4m528M9XIYNx5a
 b+CFspuSoqpqbxzsWPSc8Zhq2a09azgo4RYk0fL1xjxF474lH7q4mnW99nqzwdC4P+
 ZzN/BxXqOWwnhba24RoahB7/igSoQdn3eCwPPs/spurc4NxeRSuQOHPbQSADSU9AXo
 m+tNgQ3db10ew==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 11/12] linux-user: Move init_main_thread() prototype to
 user-internals.h
Date: Tue, 26 May 2026 21:05:34 +0200
Message-ID: <20260526190535.10833-12-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190535.10833-1-deller@kernel.org>
References: <20260526190535.10833-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The init_main_thread() prototype is needed only by code internal to
linux-user/, so it doesn't need to be in qemu.h (which is also pulled
in by various files outside linux-user/).

Move the prototype to user-internals.h, and give it a documentation
comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/qemu.h           |  2 --
 linux-user/user-internals.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 7f98fb2607..474489f046 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -371,6 +371,4 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
 
-void init_main_thread(CPUState *cs, struct image_info *info);
-
 #endif /* QEMU_H */
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 21daf422b7..fbfd12237f 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -194,6 +194,21 @@ static inline void begin_parallel_context(CPUState *cs)
     }
 }
 
+/**
+ * init_main_thread: Set CPU state for main thread
+ * @cs: CPU context to set
+ * @info: information about the image being loaded
+ *
+ * This function must be provided by the per-target code. It should
+ * set the initial CPU state based on the information about the
+ * starting binary in @image_info. This will be at a minimum setting
+ * the initial guest program counter and stack pointer; it should
+ * also set up any other guest register values where the Linux ABI
+ * defines that they start set to some other value than what the
+ * guest CPU architecture gives you out of reset.
+ */
+void init_main_thread(CPUState *cs, struct image_info *info);
+
 /*
  * Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
-- 
2.54.0


