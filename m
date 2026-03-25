Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121CC1099B44
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vbo-0000pb-6H; Wed, 25 Mar 2026 17:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vbk-0000o8-1a
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:17:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vbh-0000wq-Cg
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:17:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48704db565eso4186905e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473458; x=1775078258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUQHzUWI6gn0rZiMO104Nh4NxBzPWeUQz9xRTGtk8RE=;
 b=UCt+8YMe4BEy3/6z4JhYtLwswCT1LoWEtyLcE4UaBJj6IFkO8+AlymZGU4os3l/prw
 FqhPyFCl96uwlfX/4Al0lcPAmhiBlWSMZOXEHUKAeslJMbtAiUHn5eBQDFTfzqGQcBKk
 zBfgV7j6Vnab5m/R+WWZkNF3WUr7WChJj8rp2VBXxE0au3DtYaac0kA8A3ywV/k712PL
 z0m/yWaCD/6N1zW/2wujBPlaYr0NM96Po4P5P54m6w6pr4/GB5MI+ma5XI7o8D8vochg
 8rCKiW2wPbGXQZIt0W7ry6reFwHQvzG2XIFcHnekF3+Z5wi3O1vasdwJKMfwTmG8uxHP
 2Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473458; x=1775078258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JUQHzUWI6gn0rZiMO104Nh4NxBzPWeUQz9xRTGtk8RE=;
 b=rHB2yXs1SoDBwqZyeu8TsZ173RrymAabSdLXOyP7hV+kDb1s4wi4ZZUNdrt0yspwD8
 MXiweuOo+s2QhynzutLY6UwfvkiDtQa3GUzI9lywUJcJqhB6BZd48L2YhH/tZWDx6NsH
 LKrFX5owdLuITZdm7U/YsVbr98faJhZePuyuDQY8hHnLbRuzBttG8Zlt9rwbZV3laT3f
 98ELwoYqPHEIsR4QXEyRIE03CId672OjbDzEQnCmrHmRVzcn80CyRspOmp3MXtrEJDCi
 ujtfMLwjNw9pQ4QN6ld1qWGVvHSBr4rN+tn4TJJC7wIqORSvTEB+AhW56M2v0jjc7M9Z
 Ahvw==
X-Gm-Message-State: AOJu0YxgXeiXJsMgZq/2Ci+95FxsA89xIKUf5O0P5T0E8qxIHwrvoBGL
 bTeQP5WY8TiXli8yBYWC/1owDhPeAUJfxUCup3xbQ+d81tPZE3c1cloJcNdtcDS5deHaQhHzrQE
 jnzLbUpk=
X-Gm-Gg: ATEYQzzuxooNIaKA/zIM1rHPY2hMqahS56Z55LG028Ploon0QSoGtrrzMPnvuUz4p4h
 63AA43zbTI8qpTfo7AR6i4G2YsrrGRrKJR9xFJ6pqrmKAaBu4TfaPqzO+41pvuBkcuxTtpMP7zg
 LG4cDK0Rm6xLYAztfEfFhnhcwfoNfhSA92G1O+WIFXQFEj8BpP0kubspy/wU8Ntf94W7oIjRATo
 XgO/Ic9z2AAYENXwKXMCg6j8FMkJuG0umXu6B4d1SAxHn3BhFw3pm/qqFopNfLPU7GZ0RhktkXU
 BtaAQ2cRp/i+q+58nPOOBKhV4chUn5j4fldmKI0gZT33pgnzhnZhruetsY5Q4gksKVQ3iq3ZUQX
 3A70QIUAdw5TB0ks9NnxqRbUmdhLhppvbocjhYeKkYWDDb/fwjN5HIgGhCg82ywNZZzsLXeXO6h
 KVSMFX1TR00wFLenPcYCO7zootvax5wM2ZM/+JNkLcKGjLEysLU6PhGnqJuFjRfYELKFuyS55R
X-Received: by 2002:a05:6000:2306:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-43b889e34b8mr7687238f8f.34.1774473458019; 
 Wed, 25 Mar 2026 14:17:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e35esm2489972f8f.6.2026.03.25.14.17.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:17:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH-for-11.1 01/10] target/avr: Avoid target-specific migration
 headers in machine.c
Date: Wed, 25 Mar 2026 22:17:19 +0100
Message-ID: <20260325211728.89204-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum headers required:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific. This allows to build this file as
common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/machine.c   | 3 ++-
 target/avr/meson.build | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/avr/machine.c b/target/avr/machine.c
index 4402862fb96..8064a7214a3 100644
--- a/target/avr/machine.c
+++ b/target/avr/machine.c
@@ -20,7 +20,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 static int get_sreg(QEMUFile *f, void *opaque, size_t size,
                     const VMStateField *field)
diff --git a/target/avr/meson.build b/target/avr/meson.build
index af5e7d63741..39e5eb02c2b 100644
--- a/target/avr/meson.build
+++ b/target/avr/meson.build
@@ -15,8 +15,7 @@ avr_ss.add(files(
 
 avr_common_system_ss = ss.source_set()
 avr_common_system_ss.add(files('gdbstub.c'))
-
-avr_system_ss.add(files('machine.c'))
+avr_common_system_ss.add(files('machine.c'))
 
 target_arch += {'avr': avr_ss}
 target_system_arch += {'avr': avr_system_ss}
-- 
2.53.0


