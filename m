Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C7FCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgp-0001EH-C5; Wed, 20 May 2026 00:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgm-0001DI-Ot
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:48 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgk-0003qk-1b
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:48 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so4967209a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251864; x=1779856664; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z9OZKj50dZv5s1heY9l5Z9IxHiDUoqE1DOEEF5VctYg=;
 b=Uhf0tGtaWcZwFpyQ6W0ib8j58SH9E6ilJ9A8aOaJ875u/mMBtbI+bDJtuJrRxyraft
 tOFohWVCBpRLsM6/P/65EtY20tZvx/wdHnx4HphxPIZboOlFYWN7WgE7HjN8mwW+6oyO
 Mq3iF5ut695PzOEkbdrXNZEnIekgHnlh9e7hJXYP2lDvD+QVn8OtQTbeJL3ogeTbNeD3
 2w5BawtmYa3SuCE10Q+btQJJHi5+EzjfH7NzlLRodo1lYZfh5xDwdvsfZf9C5f/WWah1
 T0g0pj8YKktbY53SR9nnqnJWYtAGXP6yMT3WFhDfWYGIi00Yc+aHEWSLnSPdnmoEt7ao
 FfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251864; x=1779856664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z9OZKj50dZv5s1heY9l5Z9IxHiDUoqE1DOEEF5VctYg=;
 b=hhXYWnn3845O6smc7RGpbhPY/7LC/sQXg2m90mRbaqpp9UZ/zh7hU/fSoYaIdstkm1
 2Eq6vw9x8iM6720ZoJDprS2wFfCi/ea2aKpfmZojb83Lnu/crYRdfpsik77Lf5Ah41aJ
 fJWVz4AVV9bdTzUH29IukTJotUW10Fx5GHtohFOm3CRvjgK0k6M76wtcQEjKkpnvKuXF
 ys1JfCTUVEskpWg0B8uhWruRXwJG2O+TOXvuUywDDIBwbql6q+qYzDO+7Q4LSKsq1P8x
 SwYBh4Y5OgHFmgA1FDmVe7ewma65J/2R6jm7Uuk9uuY1mh0EhzMYnPzb4UkzvGoBRobs
 jz1A==
X-Gm-Message-State: AOJu0Yx/w4bAtIeSRAkPvYjc3k5gv2t/y7TrTFuAt5wkXZ1fwCUNLVWf
 3AdF9za7ujX6hqaWwboX9mVMW1U0jbTwf1iZyotOrCPniz+77TXMCR45
X-Gm-Gg: Acq92OEhDUWPYe6V7RMCSqqG/jLDi4upcEzsd2xuyaNEzXEo9q9GQ0nE1DjPS9Z6PGC
 gxes2/w64FxDmGy4jRAduVxxIbyaojiAxWJbM7FnvHkH/Qe3WTjy/PpM0J9rugt+WviztEAKzgR
 rvYesfRjkA3Xu8fvzqcB08/pGo7z2armQC/BL2LU7mi4q1vp6zSKVUKwY0ZLRMDcZNq9p9+ogpa
 +qgiLR3pGdR1QeTnKIKKf9EGp3WE3UH855Cx1qDrBmskiQdgsY37L2CaLTOfteHDffA8+fSVuGm
 WlQ7o6D4SENBpqsWKl7PCCFp3W1TtETyA3q+grEXwTXv4IunA2CoH2IjtMVbNnn9GFcPyWA2V+a
 1KS8FQtvof5ZcKkifEnz55IS31pbRJvwV+9JP1KXrHGEvGrBDrLSRHVjenIhy/++LpM6dh2m8e9
 TS0zsyp0ogxfWHpe+UZyOmfXA+N6jkrRHnBumni3a34rJamEzYICLaNEapnNona4pmIyot5PRAQ
 cs0VWyKAcFlZ231qAhj0QxTv7zw0LpVpvruw9EAcOCRX3JrJZoMfc6EB7xXhzFe06Yw
X-Received: by 2002:a05:6830:2a08:b0:7d7:f70b:5b0e with SMTP id
 46e09a7af769-7e4a400124dmr13308778a34.12.1779251864008; 
 Tue, 19 May 2026 21:37:44 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:19 -0600
Subject: [PATCH v10 25/45] target/mips: add Octeon COP2 crypto helper plumbing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-25-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32e.google.com
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


