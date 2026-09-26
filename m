Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17246C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMVn-0001AK-Lh; Sat, 26 Sep 2026 03:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRW-00051u-Rb
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:31 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRU-0000dZ-RG
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:30 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-341f6327b95so909560eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406207; x=1791011007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BiL+h4U+/0i4V9PGKop4ONI8GOLawX2pYUUOBevWvkI=;
 b=AHIY2d/FdVRiOfEpzF9ho/cezuhSIQpceBP5YzWCnIIQ65vgj6KQ4RCBKT00+lSQOm
 H/zZxzPUi5af8EhZYFpzwg5Lcl5W5w0jbTNcA7fj1Sh12EBfivbFpQtB6kVzAuu09YY7
 BdIvzVGVp4d6Wk3vyhp74NUmjNbcIp5L3YS4/pBajHxGiFvK22S9meZEyQOcBAUDQf/h
 bbaNp9Id6r+jN4I/polaEz13BZDjNYn9hQwgtlnSmHbDS14LhzGc0Iz+L2nG4q1kc/0q
 AtLUE+xNLjXbiaOoFm35RbXSt65AUbyx0IAcDVmzc6ELRkSbBfqGCQe4BW86iTnlqRQi
 iVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406207; x=1791011007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BiL+h4U+/0i4V9PGKop4ONI8GOLawX2pYUUOBevWvkI=;
 b=XoWxAFCSRiyKlV4ouOr48xSp5lqjFUyoxWoPKiW9ln6iW+FN7M8hOQ7DdOe8QBLVbX
 BTylyhHFQKQVH1Z8Gu3hoCZuFOTxq5KMMjSonCJ5ARNH8lUrJxtCnix8j6eeKUj3LcD6
 fiSN0J7E4V1IQWHXLW99VoO1PnAbv61faumryLUdkGMVqxHU+23C/5eDG57al5U1uQx7
 kpR3FIJodasLwwymI1EC0iL2hGdHdALX+sEHo13lS7kw5YQ8wtr7mXEEmRvrpiO1g3FW
 Pu9CSHgTksOnR9LzMh/ENvZBS3DYOSQpLBn0vmiOiUxcwDz5wNDmhPoqrjrvYzwlOL25
 kPqQ==
X-Gm-Message-State: AFuF++nwDl4rcrhK1HKg3H1EGcbHSFyStjBExBZL6yspWgCy/M5xn0KC
 I6v2w/1mbxsNSF0uo1qZkLSnMEygWMlc7GA4J5FsohmpIf3I531/iYjo5TxOEURQ
X-Gm-Gg: AYBFou1uVGLfK4AJAiFeRAJP+9Jg6B4xmtipUSmwAcccSDhphnuLk6fhgVBpcdzWckR
 pvQ3HnTP0W5yvIgymg0HES6p70mw+ODduwYfvVpctKnAmTGOzE/oH5076Eg6PDfZ2BD9Yi9r5vI
 6eWdQw580dfzbj7EEBr85u+iOW6CjyshCWVYecypNq4G0PGBaWukFcGsNdT0FjbaRH2HpG9MmMA
 p7cJ30eugxeNjWXU8vyA2u5a3/YjLlERhXXjbZxET4PXBFNey3YvBxgIr/Pjrpbd4f+6WO2IqmN
 wbTh4KARLmZB/mx5WIRXw/XCC6co9WVsqYM5xdf5rAYuev16E0Wv6h1l8nHzaKZUroaVX7jnO2d
 fhHx+sgIRJGBLcJaP5z4naeq2b3+7ywJMhLfqu2XFrNDnFhq3OZLL1MUEV2vtvCINjeTfFA0Udi
 CIxVmiLLy791jaOoVOgmgLQxBi3zw+rO83Il6S70S/YQljWZfN8DUuWBBZIUENaayXWK9zUcfaB
 y25ZDHn8zI/myjb7zANEETDXA60jNM=
X-Received: by 2002:a05:7300:f282:b0:33b:fa13:61bd with SMTP id
 5a478bee46e88-34272853c94mr2057256eec.31.1790406207220; 
 Sat, 26 Sep 2026 00:03:27 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:03:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 36/55] exec: compile abi_ptr.h without per-target
 cpu-param.h
Date: Sat, 26 Sep 2026 15:00:35 +0800
Message-ID: <20260926070057.1234-37-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Include cpu-param.h only for user-mode, where abi_ptr depends on
TARGET_VIRT_ADDR_SPACE_BITS. Softmmu abi_ptr remains target_ulong,
and its format is PRIx64 when COMPILING_PER_TARGET is unset.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/exec/abi_ptr.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/exec/abi_ptr.h b/include/exec/abi_ptr.h
index 2aedcceb0c2..7e8a78bc980 100644
--- a/include/exec/abi_ptr.h
+++ b/include/exec/abi_ptr.h
@@ -6,13 +6,12 @@
 #ifndef EXEC_ABI_PTR_H
 #define EXEC_ABI_PTR_H
 
-#include "cpu-param.h"
-
 #if defined(CONFIG_USER_ONLY)
 /*
  * sparc32plus has 64bit long but 32bit space address
  * this can make bad result with g2h() and h2g()
  */
+#include "cpu-param.h"
 #if TARGET_VIRT_ADDR_SPACE_BITS <= 32
 typedef uint32_t abi_ptr;
 #define TARGET_ABI_FMT_ptr "%x"
@@ -26,7 +25,11 @@ typedef uint64_t abi_ptr;
 #include "exec/target_long.h"
 
 typedef target_ulong abi_ptr;
+#ifdef COMPILING_PER_TARGET
 #define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+#else
+#define TARGET_ABI_FMT_ptr "%" PRIx64
+#endif
 
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.52.0.windows.1


