Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D6BC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVnE-0004rN-7b; Thu, 15 May 2025 06:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn8-0004b1-3u
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn6-0008AS-2Q
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso7751565e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304773; x=1747909573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NyucHiYe/4GviI/GxcYBQGa71mt/U6jQw0yXKQyqmn0=;
 b=Sl+MJctAAI5E1mqTHDKU8hrIWKtBmQgkrwWxmYGdq7Iaw6GIVyqK5nPMPTYkcxT/nR
 1XR92lQyd/PfKTygKcBPKkA9LkD55CpFUyfE64wwGy/V/hWBk3tFM87wW86nnrE9bxPJ
 LkhMeglq08znvYzQ7GZK9qMvICvGwQ6rYvF/HmJt6AOirYO7iO1FGiplHry4prrUgtpS
 9a/Ko6jwzWr8okxH2bHidwsb1giqh5RkJo6LTA4S3agHarjekXZanWWvljlgfODaGodq
 lcS+nwFpMtUNSK42BXxRb3ohaY4l+6BpD1s3ahjr9+iKWtI3egoY/xGPKtWPO9jfZDO3
 XowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304773; x=1747909573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyucHiYe/4GviI/GxcYBQGa71mt/U6jQw0yXKQyqmn0=;
 b=TgO/LHY5xFrS+C5pJ2lfF05qIQUf5Zsxe+v7tJtNXdsB1xXlrLh69FFQPXV4ZZCA4Z
 7S4GYfqv+AGQ0NROMl2fwl1sF3IHkA08lInQyTp/3bhmrG2tNcTk4D8DkZMUq1hY9/p6
 C1oTYbkWHKDeSeOvZ+VoSsXaCuf9cBi2DoExRmkY8Xjr6xTUeAXSYSMRLpi/r6tC+Qlb
 cZgasKUG0xWQiIoOtb2A/20WcCeiUUTRgls86PZ1FRuGF9PyTmTYwEfGFaYuG/byhGn1
 tGQTjwwLcXSCE/zt88fZgK+3wad3OuQUlxRQV19aei4kWtcm3FMV20/q9/uOzo7mO13c
 NSog==
X-Gm-Message-State: AOJu0YzAH3K9CB9BXPNJwwB2AZntkYXaWBAMYz9gkr6HFZ1Xbv8jN+eq
 8YhuJfAOd8I9arx/1tC4+dPJAXFNC7wS0Cd7jntfkz1mrGnHe7EUKxxdvZf5jT9mYvnSoV73JWX
 WVG8=
X-Gm-Gg: ASbGnctQyfGEQkn08SZpyT/tUJs16esslSj87gGfsR+WX5prYu8GYkPxFDpp0KDxiUA
 HyYVsPypwwDHS3jckjNZzM82l4dQwRxBgrkLwhTOaICJsDpBac9riZ4YY0dU2ksu1Z2kn5W2k3j
 JPwp0TSZEkaV7rgo04WmseV5AY6jkjlDBOe+G/CHNu+K/IlKK2WXK8CfPPvo4sHjWwianrwYY67
 gRIELRcBt0NZDBWbie+mhwF37YnR6KfAfv/dCb+b0CeNOsXtIk5dlm22ULbdTIUgCYq44lN8ZNl
 ceGQp5cZBZT5CPGTmBCxb0PqL/O00TfGv4FMhAxD02Tz0bjtGEZOAsGO/A==
X-Google-Smtp-Source: AGHT+IGnR2GHyBea4gaX82ziwXlMzNKX8P4ywH9sE+rgI4wQv3cddtqVNABt9h/U/UA8/Pt7yTEDKQ==
X-Received: by 2002:a05:6000:4007:b0:3a0:88d5:7fca with SMTP id
 ffacd0b85a97d-3a3496999ebmr5471488f8f.12.1747304773392; 
 Thu, 15 May 2025 03:26:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/58] target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
Date: Thu, 15 May 2025 11:25:05 +0100
Message-ID: <20250515102546.2149601-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-8-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 66047693415..c7e00e64325 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1171,7 +1172,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.43.0


