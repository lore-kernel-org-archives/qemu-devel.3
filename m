Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6824D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibo-0005Iq-Gh; Thu, 08 Jan 2026 00:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibn-0005Hz-3x
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:55 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibl-0005N1-5x
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:54 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c708702dfso1923505a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850251; x=1768455051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zEhE/QDquATFicjc9bVbC0uSox54fmfzVQ70vflQr6E=;
 b=XV+paVssuO4lS4gVwKuZZflyhdo5H+YRJfJ5vKUsnTOwfDjR4M1fKDiN6SbACZT5y+
 LfG5ZVPe4iId27HB8hjH6KPiom+y+Oxh6FM17DVvuqDw0bXOEY1oDMO2gq69EihKUTGW
 cJQqdAINtIsUAyRzTCY3jsRNsBGxiBg24QfdB8S5hFF7+Dn+yIXxrC8dNk/8wFzUUEaO
 Dp7/33ntD65dvu/cj8t3nxs5BClDFsmEDx21wbIoxo7der1B5M1BL/rsYCEDqw10XCEd
 Q5kFfDdbhSHkbg47+L/0/siZyS2UwVlta8UTeicwpXXE1gy51L1vO1DVHbRCXIxnlgoX
 +iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850251; x=1768455051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zEhE/QDquATFicjc9bVbC0uSox54fmfzVQ70vflQr6E=;
 b=ns+G0kmjP/gYVXV/PUu6TdKs9r92ERZRveeW5mTbCfAgE0f7VwS/9vbYyVKnlVdgZ8
 1jUeJ83NZTk1eIlFCTJaAQfhdZmDbeTrVzlep8+mjpU4u44PYJwyxFb2SlbOpuvlMaia
 1H4tzYQTBajqu0zG+vvn3WK0Y/vbSi0e8ne90hyjqfgq0Sy8B+AbHLbeY5+tRrxpQ8vX
 sND5MwRiQ4chIU+ZFklAfSBZdFj2Ac4fZ7OUBxKGP4wSkPihxbz+1I/oS3jMtmLfYDI+
 WxwpSA9icPmFwf1I2PfpZBhhNJVCZUK6XzHwDOX4shhwKJdJ1tniTy5289fc8TOMgV4n
 Kw8g==
X-Gm-Message-State: AOJu0YylJiYEaPCHOUQrFpziZ5sbeA/dJJgC1XruemdUh/490C035VCU
 14pv9Dl+nd11NyV2FfmQEpKQpCjlzQEDnvHegmYx/3aWLi0xULOLPwnWGenldK3j1ETZ1ArZdPK
 BrmUejWs=
X-Gm-Gg: AY/fxX6HH2AVgdxqQiD+I/2Dr2LWXMJsSHo6OU9YhGTGZJMdVWsiowwcwxIA3paQvDA
 sD6ERImRtxM44+Y5GEgrwqS3PAg8sxh3ciF1mGXIkcWuh64PzRZXsHjpUw5zS7k6kbhm84GhNKi
 u6HBAI4Yb+uJBHr18/8Gv8Zw5ECHHyvi9bgZry50CDerDFAzjJQeiIAI9sf/M5wX30QJ4hPWHDZ
 uVrn+s2wnrsaK76rUn/fuuGagJ6kLYQsKgDDoom/8GZ3YBOtScd9eur7tiMJmVGy7xSpr/QciUO
 EH3lnSFUO4+QVMD0iGikDUvho+6zoTIWwZXnVu3WckyRCdZChb0JLGu3vdBaY6Jt+SU80t9OmkG
 Kum7oLvj++UnqQoiqk4uyAzUwRBATATax0v+LA7DLzICx6C+IscFZ7pvrGHNHyueSjR2FHBJgRs
 HUBIbwNa8EMaap3kPmHNNncj50ffaL
X-Google-Smtp-Source: AGHT+IECwd30O5w+7BTQWtRwzChNw7jHDSPvPj92USPEfzS1IAF3jNmsoYXG9WGQU5Vm78eoQU12tA==
X-Received: by 2002:a17:90b:3c45:b0:339:eff5:ef26 with SMTP id
 98e67ed59e1d1-34f68cb94f4mr4625233a91.30.1767850251165; 
 Wed, 07 Jan 2026 21:30:51 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/50] meson: Drop host_arch rename for riscv64
Date: Thu,  8 Jan 2026 16:29:42 +1100
Message-ID: <20260108053018.626690-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

This requires renaming several directories:
tcg/riscv, linux-user/include/host/riscv, and
common-user/host/riscv.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/{riscv => riscv64}/host/cpuinfo.h           | 0
 linux-user/include/host/{riscv => riscv64}/host-signal.h | 0
 tcg/{riscv => riscv64}/tcg-target-con-set.h              | 0
 tcg/{riscv => riscv64}/tcg-target-con-str.h              | 0
 tcg/{riscv => riscv64}/tcg-target-has.h                  | 0
 tcg/{riscv => riscv64}/tcg-target-mo.h                   | 0
 tcg/{riscv => riscv64}/tcg-target-reg-bits.h             | 0
 tcg/{riscv => riscv64}/tcg-target.h                      | 0
 MAINTAINERS                                              | 2 +-
 common-user/host/{riscv => riscv64}/safe-syscall.inc.S   | 0
 configure                                                | 4 ++--
 meson.build                                              | 2 --
 tcg/{riscv => riscv64}/tcg-target-opc.h.inc              | 0
 tcg/{riscv => riscv64}/tcg-target.c.inc                  | 0
 14 files changed, 3 insertions(+), 5 deletions(-)
 rename host/include/{riscv => riscv64}/host/cpuinfo.h (100%)
 rename linux-user/include/host/{riscv => riscv64}/host-signal.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-con-set.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-con-str.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-has.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-mo.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-reg-bits.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target.h (100%)
 rename common-user/host/{riscv => riscv64}/safe-syscall.inc.S (100%)
 rename tcg/{riscv => riscv64}/tcg-target-opc.h.inc (100%)
 rename tcg/{riscv => riscv64}/tcg-target.c.inc (100%)

diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv64/host/cpuinfo.h
similarity index 100%
rename from host/include/riscv/host/cpuinfo.h
rename to host/include/riscv64/host/cpuinfo.h
diff --git a/linux-user/include/host/riscv/host-signal.h b/linux-user/include/host/riscv64/host-signal.h
similarity index 100%
rename from linux-user/include/host/riscv/host-signal.h
rename to linux-user/include/host/riscv64/host-signal.h
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv64/tcg-target-con-set.h
similarity index 100%
rename from tcg/riscv/tcg-target-con-set.h
rename to tcg/riscv64/tcg-target-con-set.h
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv64/tcg-target-con-str.h
similarity index 100%
rename from tcg/riscv/tcg-target-con-str.h
rename to tcg/riscv64/tcg-target-con-str.h
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
similarity index 100%
rename from tcg/riscv/tcg-target-has.h
rename to tcg/riscv64/tcg-target-has.h
diff --git a/tcg/riscv/tcg-target-mo.h b/tcg/riscv64/tcg-target-mo.h
similarity index 100%
rename from tcg/riscv/tcg-target-mo.h
rename to tcg/riscv64/tcg-target-mo.h
diff --git a/tcg/riscv/tcg-target-reg-bits.h b/tcg/riscv64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/riscv/tcg-target-reg-bits.h
rename to tcg/riscv64/tcg-target-reg-bits.h
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv64/tcg-target.h
similarity index 100%
rename from tcg/riscv/tcg-target.h
rename to tcg/riscv64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 4a79947ba3..2b9354757e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4054,7 +4054,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
-F: tcg/riscv/
+F: tcg/riscv64/
 F: disas/riscv.[ch]
 
 S390 TCG target
diff --git a/common-user/host/riscv/safe-syscall.inc.S b/common-user/host/riscv64/safe-syscall.inc.S
similarity index 100%
rename from common-user/host/riscv/safe-syscall.inc.S
rename to common-user/host/riscv64/safe-syscall.inc.S
diff --git a/configure b/configure
index fab9a45531..2d9a603ee8 100755
--- a/configure
+++ b/configure
@@ -462,8 +462,8 @@ case "$cpu" in
     CPU_CFLAGS="-m64 -mlittle-endian"
     ;;
 
-  riscv32 | riscv64)
-    host_arch=riscv
+  riscv64)
+    host_arch=riscv64
     linux_arch=riscv
     ;;
 
diff --git a/meson.build b/meson.build
index 6896c7a64f..b0fe798ee2 100644
--- a/meson.build
+++ b/meson.build
@@ -265,8 +265,6 @@ enable_modules = get_option('modules') \
 
 if cpu not in supported_cpus
   host_arch = 'unknown'
-elif cpu in ['riscv32', 'riscv64']
-  host_arch = 'riscv'
 else
   host_arch = cpu
 endif
diff --git a/tcg/riscv/tcg-target-opc.h.inc b/tcg/riscv64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/riscv/tcg-target-opc.h.inc
rename to tcg/riscv64/tcg-target-opc.h.inc
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
similarity index 100%
rename from tcg/riscv/tcg-target.c.inc
rename to tcg/riscv64/tcg-target.c.inc
-- 
2.43.0


