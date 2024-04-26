Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC80AC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RSy-0000aG-PI; Fri, 26 Apr 2024 15:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RSv-0000Vk-Pk
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RSt-0002tm-Oj
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a58c0a05a39so257164666b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160554; x=1714765354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmvNrspQ4cegMOJikcLgrcfGHx45XMIAa70gCbSZauU=;
 b=YdHFy1AV9K4NTYD+68FsT4yFL1hAFieTQIFgCpNqwaKIrUwQmnNzMwByKsNvR7rsSD
 /JNhA4TJOKP6DOw28Xyqf1rY6wgdVzwi0Cq4g0kBzW1gpC5ewaBygSwol5XW3k146Z3c
 akKqFxiU1esv8ZaUr+E9ysTiCvQ4Lhn6ZXmwUGNyceG5NPgoW4xa44T5/3q9d9pPE+am
 PlsNN7acIFVKepYyPgNCUvZk/Eo4D0zAhXUlRw7gqyhKV0x5QBVoDTMp82bJQLvq14By
 xQoCP1se+o7K/Z08b6lLnnQragxmwjD+3jDArQMjnQkPQ5WtCr0+kl+/t1DHZ0Xr8Zud
 NjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160554; x=1714765354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmvNrspQ4cegMOJikcLgrcfGHx45XMIAa70gCbSZauU=;
 b=rJzgLLIgmnV5lV6+IFYX9ti0Qv6nMUoVsckDEvws9VjnQ/abU6clj0mBQ6is8zGCqZ
 JAh/TjXPI/0f/jgfYWc5GK5MM/2owxLdIzawYCyOhHhfHPOAAXXUqlPg+9Y0tTRgTpkQ
 aKsrnrMm9vitGq6uE55E3f1yjMVkZ45w9nbk1JCwR4HR3ub/Z/cnLt7EGxSlJSNsimgw
 iioErD88zC90S+ns4KI/vmSR4Vc+N6cLLsuh95Z+zSepIVZUWyB5y3JyHQTbH+v6I+bX
 aRlZAPR94WjVdr5PH8g5HYfm7W8rw9gij6RWjRXXznyerESTyGOIryFFKiQnUgjg4z+t
 tg7w==
X-Gm-Message-State: AOJu0YyXm7GLw9HDe09d+tFISIM8dumcSamtTzpGZh3wvMI+DZXbdUu+
 sdCzz+Sd9ldNy8O9isidgtwdA/z1Q+Uo/XIHEv8IVPDG1PdAMT+cwo5NGDIqhAgfXjMYGOdXRuY
 HYMw=
X-Google-Smtp-Source: AGHT+IGPiMfDKc6V8n2xYyHp0jJiqml4tLfGM0tbtW0vpY4D+01ygLRYO25pcBOjrWkj7c+mdaHBMw==
X-Received: by 2002:a17:906:3593:b0:a58:be1f:9134 with SMTP id
 o19-20020a170906359300b00a58be1f9134mr2374855ejb.30.1714160554023; 
 Fri, 26 Apr 2024 12:42:34 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 m24-20020a17090607d800b00a524216fe78sm10939590ejc.64.2024.04.26.12.42.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:42:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL 05/38] accel: Include missing 'exec/cpu_ldst.h' header
Date: Fri, 26 Apr 2024 21:41:25 +0200
Message-ID: <20240426194200.43723-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Theses files call cpu_ldl_code() which is declared
in "exec/cpu_ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-5-philmd@linaro.org>
---
 accel/tcg/translator.c        | 1 +
 target/hexagon/translate.c    | 1 +
 target/microblaze/cpu.c       | 1 +
 target/microblaze/translate.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9de0bc34c8..6832e55135 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
+#include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index f163eefe97..47a870f42d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -23,6 +23,7 @@
 #include "exec/helper-gen.h"
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
+#include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "internal.h"
 #include "attribs.h"
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f8dc3173fc..9eb7374ccd 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/gdbstub.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index fc451befae..6d89c1a175 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-- 
2.41.0


