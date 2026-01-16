Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D3CD4899D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjPp-0003jn-PN; Fri, 16 Jan 2026 07:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPS-0003ei-5y
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPQ-00009s-68
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4801d1daf53so10857925e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768568315; x=1769173115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxtWiPsN7Mi5aHJwrd0JDklGWH67zod3CgRiIov2LTE=;
 b=EqEXQKIdRhRssBywlR+8rt8vcW0cvXidahDIp+2/muvGfz68CsML0ZnaCVIDqQkm84
 gRanJUa2mjg/HHgGjMnXz+9n5z/3K26p1k2aGqI+sIICwJvDYALwkCruG7Jp5fEAeieM
 5g4hMmYWPZxpOIWdLSGjrEqspb5xjAR4K4heqaZfeDuMe5w14tysa4pza7PxD4ZJqRdy
 OFm4E5BQZFxltUzLSn38E4fp/QgRi6EhxYSFMdDqUbU1zSrMb85izzuUkEgVGXS/pz6t
 p/2A5zEFsdHVeiFOIS/6HYbmgnjSQR5D+ep2XDUsnTn6AgRc7/SAvIj/sL015Kp8t6TB
 4nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568315; x=1769173115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xxtWiPsN7Mi5aHJwrd0JDklGWH67zod3CgRiIov2LTE=;
 b=X8dvsi8dJKPB6rA8XTZw5hJ/fhn2Xwi4AbnFywm9Wb9/7cOULInGWlbcVdsH4+jtCD
 mpwcgy2485HFlt1l0+ytkn079yUJyUSNr/WNZw9sj8gpeF7dwkjp0EYfeo20IpUUeXdi
 aj2yKPLQ4uWcPlTXi9og13QFfO/HAooNudKlVI9bHyteBmXcXJPUxg3vyjb+k3jVJhor
 SvUgwwNdsKkKXg1mahU3EfmnKLzBJThVgYWYPrjUO3ktVR3pr36Hx/elZ68deHqwVpYo
 CZsZICUCrBui6V7cWU9gF2nQhz+XFMjKGB8UR1aiMEMr2S9XSiWmd/FeX6X5v+E/2rO5
 WVSQ==
X-Gm-Message-State: AOJu0YzS4+fwYVtH8gPc6tFGYhfL10+3OtGhcPK0Wh+sDfgwQeJMcAK0
 gY9HQJ4KkAi5vRg6aQnjHWKp4qj+KBWUXe3SF1zm9wQq2vUQOfDSRpWsc2df8PegC78e/R+w3re
 v7eUp
X-Gm-Gg: AY/fxX6tGJuZQ1NOKVRfPeL1nmnWmAIeXrLxpG8ZehCbIA+4XpwYsFkL02Wx51/MHDP
 pYOAzq1/IflSorHF6aXW8RzQDXYAh7ht/j1W9h0491cxJWByK2NEiSaskxQfzjB2KMDq2w/hVrE
 bK0vDxASaiMq9OTdY1bQk5ofsWtHq0s6kwhse79I4KtDXiavhl3SVK/2LY6WLnO0rg7p13TC3WW
 R8Z8l/wVjShQAAwFWYp51juik4h9Y8jNoGQ/FjROsmDXVo4afXWaX5IT6zj4mMCiVT9LPiNgHGy
 yw59b2qUY4TNs48WoVMZxNdcDcZ1od7xNp6P/86iCcYD52wmWfU2J/6BeunClKKsN+VYWKRO6xx
 Kt5dXiicOTBhsepBSuDtEEYa2B4ab58y+UB6/eSkP6YHH2oJeh8KNNVfKASGgncelEXKeYAIPr0
 0Pj8AnFQQxZjA0UakjFiXOgCrYtYQ00ZxHYWwtcwMHTTJySYKxnN67VTcw0pvm/VCak1NLroVW/
 angF7ZYYq0P78LfTo9k/FubyBnqb2JgUFotUzGC0sTidHyxSIZxIap2
X-Received: by 2002:a05:600c:6990:b0:47e:c562:a41f with SMTP id
 5b1f17b1804b1-4801e334361mr35901095e9.18.1768568314641; 
 Fri, 16 Jan 2026 04:58:34 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe67780sm15387565e9.16.2026.01.16.04.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:58:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 2/4] bsd-user: Clean up includes
Date: Fri, 16 Jan 2026 12:58:28 +0000
Message-ID: <20260116125830.926296-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116125830.926296-1-peter.maydell@linaro.org>
References: <20260116125830.926296-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes '--git' 'bsd-user' 'bsd-user'

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/bsd-mem.h         | 3 ---
 bsd-user/bsd-proc.c        | 1 -
 bsd-user/freebsd/os-proc.h | 2 --
 bsd-user/qemu-bsd.h        | 1 -
 4 files changed, 7 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 416d0f8c23..a118e57260 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -49,11 +49,8 @@
 #ifndef BSD_USER_BSD_MEM_H
 #define BSD_USER_BSD_MEM_H
 
-#include <sys/types.h>
 #include <sys/ipc.h>
-#include <sys/mman.h>
 #include <sys/shm.h>
-#include <fcntl.h>
 
 #include "qemu-bsd.h"
 #include "exec/mmap-lock.h"
diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index ca3c1bf94f..8dcac9608d 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 
 #include <sys/param.h>
-#include <sys/types.h>
 #include <sys/cpuset.h>
 #include <sys/resource.h>
 #include <sys/wait.h>
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 3003c8cb63..cc53215138 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -23,10 +23,8 @@
 #include <sys/param.h>
 #include <sys/procctl.h>
 #include <sys/signal.h>
-#include <sys/types.h>
 #include <sys/procdesc.h>
 #include <sys/wait.h>
-#include <unistd.h>
 
 #include "target_arch_cpu.h"
 
diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index ffc64bb244..56affcd31d 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -20,7 +20,6 @@
 #ifndef QEMU_BSD_H
 #define QEMU_BSD_H
 
-#include <sys/types.h>
 #include <sys/resource.h>
 #include <sys/ipc.h>
 #include <sys/msg.h>
-- 
2.47.3


