Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8CC10F284E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AJn-0006z6-9y; Fri, 27 Mar 2026 12:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ2-0006eU-CS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AIz-00038n-Fa
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:08 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b0603ee486so14766565ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629898; x=1775234698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2jhG0JdJkpzPMpSo2GG9wEa3WbWFhcOQfxGH9DnApU=;
 b=zAzmJm0V2T8Gz/bPfqtsoEEBaGwx0nBVgTx/vv2I+zixhtoj3+CyUEFDHSSLAmpize
 t9UBA4wG7YtlQuRK4LA5whnnFv3X3Q778Pxw+f8YenhV0slVhC+tqYTAga6cfUaTnLd6
 vko/C7+QHTqfo1DlqLtJs8kH1kXjncbB25WdK3kvG3Do+I7rkaHf2lPoNf0MQH4N+DCU
 vy54hQRqj95jamhRxsUytEUgHUm4sNAvjhFAMrA08USEOijIxiFSLl4nDJYvXaliltXA
 8P8Eja/eFBvMXoWBXoTpocbfG2irAn1MplhIgpcPYIjvLz956PewKLHrR7/2ImlRg5tX
 C/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629898; x=1775234698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r2jhG0JdJkpzPMpSo2GG9wEa3WbWFhcOQfxGH9DnApU=;
 b=HSuUceUFp7Wu8Ji4yR96fA4YSNpxyg0u0Tk2w++7FER4QPsqlVkh1OrIcGDbd4RTt3
 jQkWGv+3ImyT5wkjuthfRc/MQN9GT7Xq7gPV448Qo4hDsI59Puy2WjCPyRvVq052LWtK
 KMsZRl519iQVSX15LK+S4reT0peCz8CMcQYrEkJs3q0OnCcieGGFWbtzWl4S9C9SKNeA
 QcWJCuNs+KQGnD6hmVY9a+gukEfJShanwYRVGT5PTocT7MthdX/Ox1gNfBra9pveGOq6
 029AHNRbnRCdJM1u4QLytX10i8v0M9/ClRrx/b/lYgM/d+y7vT5tKcWVf+V4IN/tEQPH
 DCPA==
X-Gm-Message-State: AOJu0Yz7vwtx4MnkGq2QemaUcpe0A8fb2hWcIFTtJPMUwlUp3Bs3f2Z1
 RCkI43zyoxipsvhE3F0PUvTZIVpx6t5vNKY209LBz+VJMNlDleapasGXr2ZaR99hcOM+2RVkA+d
 dFvwIS0w=
X-Gm-Gg: ATEYQzz4MZda5lGHN1OFcTunH9XYzMQLlLjwhPnmdkxEiTVPSkBYxWy6JZUPtrpdn1b
 yG2jnmaAGjSfZBhy7pw9q9UpySH3wZ/TpxcrdtuoUkpwg1YXXGQfjHYMioslPYUl3q05JU/F5rU
 v7W1FjPctl3djFFITlOppr/5fl7RD83GlHAqC/qm4fBoDco3pNzB7j45f0EwLfm+39ErhHWJJ0u
 CFOR8CRPcnO5BREBCDvnp+3DrB+BzSqd4zRhg+qPflpKWSVKJkbgGNUxhjKlDVG3hbl+cjRmsG3
 NC21l0mJ6nYv/2UWN4ou5FzShHlI/Pg7wQhK+89umqbJReNzzJXwmR2bFwHi+IpH4FSGb2YXLWs
 UkeNWcf6IGyb+CB4lytjyoZitufLgk5zxEIMtmp/ewh+Lnnnn+/JTpJz9jwq7u8ZuWGO/brxBSB
 YkiNROdcUBHhWzKA+xhenjIwoQCkhyRPLFAoRGIi5ACOYH/ufcrvxxKCkAQV6FNOvTL57c6GbdH
 Ac3
X-Received: by 2002:a17:902:da83:b0:2b0:bed1:46db with SMTP id
 d9443c01a7336-2b0cdd97682mr36381145ad.45.1774629898181; 
 Fri, 27 Mar 2026 09:44:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:44:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 03/12] target/arm/tcg/translate.h: remove tcg-op-gvec.h include
Date: Fri, 27 Mar 2026 09:44:40 -0700
Message-ID: <20260327164449.596767-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Include tcg-op-gvec-common.h instead.
No target/arm code rely on target specifics for gvec ops.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6d52606f9b7..e28eac54afb 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -3,7 +3,7 @@
 
 #include "cpu.h"
 #include "tcg/tcg-op-common.h"
-#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "helper.h"
-- 
2.47.3


