Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA1D232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56b-0004EP-W1; Fri, 09 Jan 2026 00:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56Z-0004DF-8M
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:11 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56X-0003gL-O8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:10 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so2395877b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936728; x=1768541528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkJNbJU17Qc21sNmzvDOireMcCt37Uqm/PQW3qdJY1c=;
 b=A7erfYj82R+xFi20/XAdNKmmDLhAaX6AYyqDkZk2bIZMtdwqr+Zfb3jUcaKO/yFWUi
 eASZew9bUOLj1Zip+m26bjfCgc6KQLiba5lHaHLj/BhUcxmtm6pkEU0svBLRwdKGP/OF
 /2KrcoB4MhOBzuoXEq50AjPBdB37bo4+xyytBeJLBCUAnml2cRdb79mXkqSeoNpTUl0k
 W/jGuxsIxTPyj/YEdd9Z/KZSHqhLHaH7rONxuC9nnCkJTMmjob9C5bgNZQcT/HP+kswl
 G7DBJuRK1TMqVMxjHaaKlPuDW1RVPQ5aV40S6LgbSFVx+6E9ysszvjBaFewGA1WbbGSN
 l9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936728; x=1768541528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkJNbJU17Qc21sNmzvDOireMcCt37Uqm/PQW3qdJY1c=;
 b=qczsYpianV84kMUMf1zdqdE3gbqMgDckmJVJmZ47bSHoo7Dh2VmnUSXODvcl2oO4KF
 yKTpNmbVW2rvwYyhzclDWuwwzhBPC0Cq6pGn6JOe1O7mNmN8eg9x+uSbqy9+6SS8SqFS
 Cna7bvLWqf+5aU8DoE8IRKn4N0A939DFztN/Rdg5r+usdlVghvIUEbLEJTmYSOEucbiz
 Si+bsN50Zzs6FxRWn++p1ONLb39OBlbDnw+gmia2orQbX8CCpo/eWuGb/tykxKiG4EeA
 eAKXxlWEQjNCeBbr/GZ9p+PqvjLKPpEaliprf+ddrAIMOiTn5jkHbLg3v2OtWNRXSSxv
 jywQ==
X-Gm-Message-State: AOJu0YzXuzQ+3JGHCFDh2ObaKlw2z+KpnsNwd4Ltcs+Ikr42MvMwOoRN
 WUjjl4ta3Bb4j+7mPpGzcBg3QOvT9XTpCvyQn6GXnq13fxkhk2++hxuNf1Ijf2aAlpBOYipVH/z
 As7NF
X-Gm-Gg: AY/fxX5pI0AhAl/Fq0q3zc3xTUK5iD5L1p/bmbVDwstWxyTZYHJ9eXFhGyDqBPEESCr
 /Pjc4EGDCVddWZ2+xDTWN3JRZMzlCN9aXSc4B6iw4RpFPQqPMY8HW7U/5faAH6lAl8Ur5THCXIk
 m9mkmT1NvDZLfynJqi9Pg6nFN0tT4itADxTf2jo4E920YIUfbHToux6EMZWZpjoi6Tf8qGsJiJS
 KQLuDR1d+MPRtRSTzX3il9U369Kez7KcunDUHUQstal9iGfANG+rMbp0QJpkQJD2aAEmj8TTY3a
 0TVoeEH9Ri5ib00U2D1lvGpOMr/2UhhZnag5vScbo+qIO5pgHbU4sqdoXSM4pbGwzP7NjoYRwAv
 xd35lrsLxQ4lc9p3G0p3aKGx/j4sqoCVODEOwHt+gIzm31XdzWg4xYVOnT7l2+Af+meg+2l7wch
 Xtf7zk3oKXnSJkT8TE9KBgCR8NJnnaiAixwpIFoNWoHlUgOBuF+nsdxWbeMeFOhXcy
X-Google-Smtp-Source: AGHT+IERtNBLBFv+NTuXe03dGAyjcboVfPS7hXF6UfmV5VwKYcpUTEAxj8iXDg5tC/lixhcBQJc+jQ==
X-Received: by 2002:a05:6a20:158a:b0:343:72ff:af80 with SMTP id
 adf61e73a8af0-3898f9f9d3dmr9110022637.58.1767936727771; 
 Thu, 08 Jan 2026 21:32:07 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 01/29] include/gdbstub/helpers.h: allow header to be called
 from common code
Date: Thu,  8 Jan 2026 21:31:30 -0800
Message-ID: <20260109053158.2800705-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Target specific variants can't be used in common code, thus limit their
definition to COMPILING_PER_TARGET.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/gdbstub/helpers.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index b685afac436..197592036bf 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -12,13 +12,12 @@
 #ifndef _GDBSTUB_HELPERS_H_
 #define _GDBSTUB_HELPERS_H_
 
-#ifndef COMPILING_PER_TARGET
-#error "gdbstub helpers should only be included by target specific code"
-#endif
-
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
+
+#ifdef COMPILING_PER_TARGET
 #include "cpu-param.h"
+#endif
 
 /*
  * The GDB remote protocol transfers values in target byte order. As
@@ -102,6 +101,7 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
     return buf->data + buf->len - len;
 }
 
+#ifdef COMPILING_PER_TARGET
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
@@ -113,5 +113,6 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #define ldtul_le_p(addr) ldl_le_p(addr)
 #define ldtul_be_p(addr) ldl_be_p(addr)
 #endif
+#endif /* COMPILING_PER_TARGET */
 
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.47.3


