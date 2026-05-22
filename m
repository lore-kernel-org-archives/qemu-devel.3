Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD9BCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVg1-0001dl-4r; Fri, 22 May 2026 15:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVfy-0001ci-3L
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:54 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVfv-0000RE-D5
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:52 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4854166e1efso1830418b6e.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478610; x=1780083410; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=48Ai9CIUSaGzXZYONL1dAcOkXHUHQVK32aP2mmtN5aU=;
 b=hwm9YBSjnox0gDjV7Vx5x57CfGI2nPcyww0Sq7s0Xn3LzAWtZqlvLs/efAkufe5cji
 iCmrovbn9OLg7CutjwxKsi6BSFx7X752WXboOduM2uPOeR4rPLhRq4vLf3GQ8k0gAhZF
 o8iY4n33X2yqtg9fZpzf4fXbOedFo8FlQerUpvvzEH2BMR5ViIqsI1zFszHqNnyQKWOd
 131f/fapBSM8Jh9TxEQ/Eta6dgeG6y9kYEcFvhHs2z5mAEBUGj0c9FhEVAm1HCsDnmVC
 psL6Wf42s5oaoO8YiSoRykJcV0aKRT96K9qXnP0yL/vHvA4a/LyHv+Mxi/SNCREEyaH/
 ZVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478610; x=1780083410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=48Ai9CIUSaGzXZYONL1dAcOkXHUHQVK32aP2mmtN5aU=;
 b=n5/R35QNc+eeO0YuiiEY89qIjMbWUObx6JKAJXYgg7hmJ55VIxUKMzOOoqEfDfX8Ik
 4JA38RRQoqoxd4dlfedKShy3absxJMusqVYKLFWcCSkXlpiPW7bBMfw/jKZts5KboR92
 Ip02v6dmEDBKpvzgPRCbaKDibTBkwJNRISSNU3NeeCmESrx73pqiBpj49lqepKj/vvqN
 S4Z6Fixz18IDy4dHbHg0ya6GCookllWVV0hFIOORimawsLFQ7e0Av7agj7te28ACy+X8
 zmn1n4TJ6X0tb/yqL3p8O9NsKL+mjrPn6axzr6OL6qjTYNZ3b6wHaOXgSBxTfIChEkYQ
 EYcQ==
X-Gm-Message-State: AOJu0Yy7QrODGFC74x4y2iNv7PC545pxfnln4A++JxgH9CSVm8JGjOyk
 yu8SmgOGzSAeYZzygUfidR0WvLQAJo70dY+Ujg2Vt8u9qpP+f42qB4x0
X-Gm-Gg: Acq92OEAIn3BYnoupZhWORoNcWGfpBhSlpnhPmcLK0F1BQRP5qs0w+zVl5KKOUiXgbA
 mD+FEiiQE+qflL0sNU0Ek1i82AnbyB4cLXNMb4ikxlgl6vhovRuQRunXilcGT/N7Cz6mxopcgn9
 L5cOQngX9cFR1WbYhpXOo5Gv4k+LPbgEC2LGmy4ar5yHvgssj2F0dNlAEk3xKbM1+GC4A6miyIz
 TcxUhscTOkp8rDQcQ/CAgV43FtQtJBGVLXQLuuRGoyvXFvbu4sTV5Z5Trbrx7JhcJ24pZkrM6Cb
 KHBKDprjHTjorHlK/a0ZpFs0AKIEC4xIZDsq9ijEw/K0Lne9OEAR7Q/n8MQgyybq7NfdUG7CdTw
 +AA84sqwowg0PCHeekWMfTZRt35u5L3odn5hvFXE2YQ+sUyYmq4S8K9DnPyCh9kRJPuf2K2j/E9
 J4IHRoaccDylwbgQ/tFn0q1HoCK/rOZG6efQXkpKR1w7XAq6g3hxH4U/1aQ7G5921r5AvNGX8dV
 ynFhHjky6li/RksAhyClOoi30Pb28zGMQF2rAW5uN9jcg7pePfEdXCLBXDnnU6jOtan
X-Received: by 2002:a05:6808:5190:b0:469:fc59:b128 with SMTP id
 5614622812f47-4854a2282b8mr2576895b6e.25.1779478610169; 
 Fri, 22 May 2026 12:36:50 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:36:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:34 -0600
Subject: [PATCH v15 03/22] target/mips: add Octeon COP2 crypto helper plumbing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-3-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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

Add the Octeon COP2 crypto helper source file and build it with the MIPS
TCG target. This provides the common compilation unit for the COP2 engine
helpers.

The instruction dispatch itself remains fully decoded by decodetree, and
operation selectors call per-operation helpers rather than a common
selector-dispatch helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Changes v9 -> v10:
  - Remove shared-window selector constants and the shared-mode setter.

Changes v8 -> v9:
  - Split helper plumbing out of the former monolithic COP2 helper patch.
  - Keep shared-window selector arithmetic local to octeon_crypto.c.
---
 target/mips/tcg/meson.build     |  1 +
 target/mips/tcg/octeon_crypto.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index fff9cd6c7f..4ee359874a 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -18,6 +18,7 @@ mips_ss.add(files(
   'lmmi_helper.c',
   'msa_helper.c',
   'msa_translate.c',
+  'octeon_crypto.c',
   'op_helper.c',
   'rel6_translate.c',
   'translate.c',
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
new file mode 100644
index 0000000000..df5b0449ae
--- /dev/null
+++ b/target/mips/tcg/octeon_crypto.c
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * MIPS Octeon crypto emulation helpers.
+ *
+ * Copyright (c) 2026 James Hilliard
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internal.h"
+#include "exec/helper-proto.h"
+#include "crypto/aes.h"
+#include "crypto/sm4.h"
+#include "qemu/bitops.h"
+#include "qemu/host-utils.h"

-- 
2.54.0


