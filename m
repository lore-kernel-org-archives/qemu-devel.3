Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1418C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5Bi-0000w0-7R; Mon, 05 May 2025 19:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AU-0006tb-P3
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AR-0003wh-NS
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:14 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2295d78b433so49583775ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487450; x=1747092250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOUfFrwLeRqpVBNih8GreOXz04iy2wn0t5LFbPNHip4=;
 b=vOWts3Y8jXD1We1+V/Kmi6rVeTbEVgJ8wus6lDKgaPVuzfpD9nYYZI8ry7q43wiKgp
 5/chliPv9m1qG7lX8jyfQ6jZRvYh7du+g/VpbYRzwRrgRKghqQeChTLyDRuNGzZ+4IDv
 MSx2jmCGS8V9eBAjC85F7Bkeuc4mn5BCgKjmzvHroxJMVXqMrj3JHOmI/+cTcgXhIsld
 +zTD9noSQe5vgINNpcUTGflYvZvY2TdcCcG9c74U0XbN2pZLqlmILDnYPEjI3CpJJO2e
 fmgHr4HqljHdd+0Eb21sGqPMpMKLq3t5+MjofcJR8aXvDUr143PloDMhJT2NwzmE7bPQ
 MaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487450; x=1747092250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOUfFrwLeRqpVBNih8GreOXz04iy2wn0t5LFbPNHip4=;
 b=PZTUXBOmi86adwxqkcd0ymt3lPo293XJrqQTfkl5LXU34racMEjwBdGde9C72AeSQn
 RGfSqOvdsWD55mrvOSKsVdfs0N+O1xH0TxTzysfDBWQQhC5GOLYvq0z5VOehBer3U2cG
 4RHPeBLsQp69FWo8gZdaJtmD5wuqWHPS0+epvaMKkzByWxqSLJm8Edzvc/MddUAwcDAf
 rJeoj5L7y9k53bxRAdUIV9t+3Oj9XPX92xrJ3Ns6Ta588U0pCTRgz24TisO/9D2d1hvl
 hmkMdg6Hy1Hyb3diPLzlrIRtCBBYw9phtRIg7TpMcOF0GcnL65kfNJqUN42XGDhoQr3H
 aQ2w==
X-Gm-Message-State: AOJu0YynVcXhXQq5EMa9zBwiZUTLGMYn5zjnIdqVdMiSV/axBJaKqwvY
 2m553ItEtlw9U/GxgGgBs1bsFjFnnrCulINnZYNI+0bh1V5iH+PYhkAO6M4xjkojVhybAIvzXHi
 fMjk=
X-Gm-Gg: ASbGncvccl5Z1QhDsmLUtQCpkitQpGJFCHrUMB6cmIbMJToOlpM1juEUjvS3QQ6pHHb
 T7vIJ26rnD9uEQ0PqheqtLd5vB3w8V3NDyg+QqyAAcV+62sA3QljXUldmhADVPFHJxVqrAgXoR3
 JFNZAJoHCTi75zz9HkQKj2RxIkomWowFsekV0DgTFzV61eqhNQA0wxZTimOznzq5RdfLtSia90M
 5+3LBT9CzskXNmo8v6MaOTbL5rh8SMtq+gk6hyQ7lbLR1pKhYPyT44nTpMNpYp9vERwppJzrMgc
 N+jKlP38pvhXQJkpG7ugN2QvThL6Nau/rDJWapHD
X-Google-Smtp-Source: AGHT+IGrHHd6JwKe4CB3ehPMic8Dfrp4H+VJC4ilP9lT2i332N5/mNnvyzxXdEJSk1HP47igUbZz7w==
X-Received: by 2002:a17:903:1107:b0:21f:6546:9af0 with SMTP id
 d9443c01a7336-22e33112daemr17025355ad.44.1746487449971; 
 Mon, 05 May 2025 16:24:09 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 42/50] target/arm/tcg/crypto_helper: compile file once
Date: Mon,  5 May 2025 16:20:07 -0700
Message-ID: <20250505232015.130990-43-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 6 ++++--
 target/arm/tcg/meson.build     | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 7cadd61e124..3428bd1bf0b 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -10,14 +10,16 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 
-#include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index dd12ccedb18..2f73eefe383 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
@@ -63,3 +62,7 @@ arm_system_ss.add(files(
 
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
+
+arm_common_ss.add(files(
+  'crypto_helper.c',
+))
-- 
2.47.2


