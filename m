Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2080EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpARf-0000jC-CL; Sun, 08 Feb 2026 14:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR7-0000dG-Ck
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:14 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQj-0008V9-T1
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:56 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-66f747175d8so438302eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578791; x=1771183591;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M/h1I8mh4sCXt2YrqT76YwFpWe/dyQprsnlvmk2nflE=;
 b=0/VCaidJWFynK+YWYjYNXu6hNQx9MmPaoM/7FnSM4Lje5vfhy9t5rT9quEOBoZR8ct
 EczlD7Uc5ckMsWj+ByWNJuJDa7Lsoa0tnflqBbDZxPh7X9ehizti++a9YYixCGSBuoof
 5dLiijuWHqrME8VkvwcszjVNKecXFutUNDAX4/4MFALdN8NNrOJ9m9N4ORNta1vMwahW
 KK8U7DiN+pNSUfIQFZM0JOSXjMHTUItf0L/C05SjX+Hy3wz9YbdQdyaICnuQMkc/rhUR
 y/1eJBVp45AtRpdPXAWflR6fhvsetwm6ByvsGLx+7hHKUzFvjQin6v3fzTW34mGbtozR
 grww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578791; x=1771183591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M/h1I8mh4sCXt2YrqT76YwFpWe/dyQprsnlvmk2nflE=;
 b=rX4h+8nVX7Z2x9nTjlqUKiiagXmH64Y7Vfy/7sigchpjBbSL5ANq9Js5ZhtNiJKShK
 l05maObjYTdK/cdi3+iLbM7n6SEP6LqRwrA9H/T8RLm+XMF04J2uUu+yPR1ViiDuu0Dy
 lQEr9AvO+ye+vQK9TcZY2/82A601oqpSKilHWHLc3fzB8ob08w2BydcRfAn6H3oYb3zg
 hxdJTh0/Z9gFPvRFotK7eWQiw258Fr05G5/FR1pdVSVPzQitos9eocbbfO12FVrtUQSq
 eHkmQqvhn2NksvrbO3fi1Xh9QywRiOvi3eOFfsuY1Bx3m6N+e/RvdU7gHkBVEqeBuj5E
 FnNw==
X-Gm-Message-State: AOJu0YxRNv0oNBjUHbK4lAHy5TonxElFhInjjWHFgejAwXmG5VnT1Ulo
 6QZ5Z2fAgo+RicFnzHDRTkPGxs0+/M+moAq7EenrepVoapVdLPzd8C4Ue+IBuWjxiyU=
X-Gm-Gg: AZuq6aKOng6TJB5GzGf7NhL+mCR2iMgHJRbNLKZUHqy91xD3wVkX8ykWZM2BeL/JXLe
 dOuMDadr31NtfpM9syMcnzI3NyDQCEl3fmPcO62k+gSv81AFk6+/8Iw8cGiJdo9m6pb8uRtfEK/
 Wne7HFbGT05f0MqE2pYPBOHIdn1J2+5SNwWwb2AtBynoWyPiu9+5f8b21/gwjUZdizF4mdXEdJw
 B3Do/bBCHspj2kuKNGMFrMfxqRkg/RitduauwxT3DO61slm954P+xHF054SVNQA+RwCIV/7VuWZ
 d/bgfAwhKzmlpGx4aW2ffFg8RNqXACs2duWU1osd7/dEsXenSeRT3ezNVr9vrEpJ++BuVZTfooj
 OLHod3U//PKhhnSNGH1WNrtE1u+CCg2xv4Zxb1VrAhQlxHAxlXqskgNEzjZ2dgp9rArOSWtquDg
 ==
X-Received: by 2002:a05:6820:1797:b0:662:f25c:7033 with SMTP id
 006d021491bc7-66d099c58d0mr3785382eaf.2.1770578791621; 
 Sun, 08 Feb 2026 11:26:31 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:30 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:15 -0700
Subject: [PATCH v2 06/24] bsd-user: Add host_to_target_uuid for uuidgen(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-6-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2260; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=NtuEVgEPaO97Ie5tPKAv+9whiM5yEx6RocfiBDm22x0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONghN7myLR+HE8rEFUV7jkee11IYEBoRmuMu
 Ia+8ZItfuqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 AMrmD/4sARieqm7dwCdOTlLRl5Uh4sumuR7cwm0X5GwyAZjxssycwk27eWiyiucbVAYI93YsDjB
 Lx+LlXaD54lSZyxYmrfUBTHJBCety0uF0qRnnpyuTLJL5AHnQiXSPF/ysC6Dv/qCkyk1JSRiAsi
 0EJIZ7EdY44sZWEwgTQ7o+J8uSn6z6YdN7/iHa9qXJhUP+WkpcGMdhxuKAzDEZlmNnozjWfF+Nl
 17gXIrfoJndr4dtac6xNovd0QMYZqlyNuj6ZpuhoRfSaVOzAN6hoHL4ZF9Nt3cieaRX/X5OhFcq
 5OuEcWdOVt6yNfQ/Y7dMDiudWCJRND3B4btJo/PTeC1zA5+jQxCoao+w441+RuYuxel8fydPia1
 amXE2rYv/kvurNvgZ/N/KNsxqeA72cRaJfFN6os9CA0QbW5Ttgwe757i++eX0rQSyIQ1bRy689t
 X0mTtxZObfqohRozldXC/vkX3xTlD1+tLm1OGzfIS01UKzSQxSg+izvI+3cIlAtfj0I7BkXNjvl
 0pDHzbUM+n0u2qTqHEwt0HZNabaXT1eq2WGMtJtYNZ7qChWzmoEjeGzdsDujC1nf4HeeFQxDuSU
 btP8u3r6MVNyBmKYQj0a0mososttI56LQX5/q0XI9M6vcYFEWk7XxAwMJV7CW8FvqBEZUQ1CMQ7
 xLXwUoddlmxOVMA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add host_to_target_uuid() to convert host struct uuid to target ABI
for the uuidgen(2) syscall.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
new file mode 100644
index 0000000000..d2107b2f85
--- /dev/null
+++ b/bsd-user/bsd-misc.c
@@ -0,0 +1,46 @@
+/*
+ *  BSD misc system call conversions routines
+ *
+ *  Copyright (c) 2013 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+
+#include <sys/uuid.h>
+
+#include "qemu.h"
+#include "qemu-bsd.h"
+
+/*
+ * BSD uuidgen(2) struct uuid conversion
+ */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
+{
+    struct target_uuid *target_uuid;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_uuid, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_uuid->time_low, &target_uuid->time_low);
+    __put_user(host_uuid->time_mid, &target_uuid->time_mid);
+    __put_user(host_uuid->time_hi_and_version,
+        &target_uuid->time_hi_and_version);
+    host_uuid->clock_seq_hi_and_reserved =
+        target_uuid->clock_seq_hi_and_reserved;
+    host_uuid->clock_seq_low = target_uuid->clock_seq_low;
+    memcpy(host_uuid->node, target_uuid->node, TARGET_UUID_NODE_LEN);
+    unlock_user_struct(target_uuid, target_addr, 1);
+    return 0;
+}

-- 
2.52.0


