Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21399D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabp-0007XO-GL; Thu, 15 Jan 2026 22:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabi-0007IR-1v
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:45 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabf-0005mi-KE
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:41 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81ecbdfdcebso921284b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534478; x=1769139278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1elLXYSGrJNsfz40yQiYIFdnTmy9vR+YxG5ftNQkGbA=;
 b=oLpLITrPkshjaOM5X466rcGrr9PgxnhmqnT6EzxdZp2cX+87fTbdVqwQ8PH8Wl/qX1
 Lcp8QRWL+r5QhI1yitvqC6E7ScIKTopkCr0oqxiNoytNP96dcgowXN4EeJUzVMSkWbKX
 4hAsTbGguqpSbqujvqk5RuZ9U2r5tPKXbITxqNPbYAP+2H0QhrMC4s+e9NPTcmBl1n2N
 yLa8SkUR1sMtZrrt1a55UT05i4YsDhHPgkgUZZnDY2NJiiu3B9lXMuCiMnKAdlV4WTdX
 URq7hx2Vq7kRMAze9V/fRBA6kpPEWOO9UyIwCdUCmsaSGx50QQem6LyvLNIaTIoCvkyG
 /HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534478; x=1769139278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1elLXYSGrJNsfz40yQiYIFdnTmy9vR+YxG5ftNQkGbA=;
 b=r0KOlbZaBlg80kmxNUAO505uNxpkRLLnwKK3G5y5EZdOjDMoF9g+NKq1zYP+BZBJj9
 8H+zeD1kbFqTX681q9mpXbWHJ5yc58iSAHq+UIrKJekp9ohNT0azQHGHMgP3kTIcDvPo
 YoSj5osqeHhQQJyYqpRH5oJGFgZ9r839Ij+oUpRLCELIegzfRBzaDaEJ1oPduLpgAb/r
 300JAYjz5v+WtQbx2URICXsfNzrF0om7Lp0ae9iroqS5q8hvpsYTTvlpkExR5Wj8EjRW
 qR0OA685CNcl0oT36X5gNkHIEvGaZtcLPm2pYMHs0L150aUlnaVsGYXrSvMZC3fwie63
 haEg==
X-Gm-Message-State: AOJu0YxAvUa3W9M5j3TsgAyj0q6NZkUlc+TGcpyKs3DjIhluJMbbFlrr
 AwXp5Q6JVZTvn1BJtYRuIgNdvR5bqaPsLtjXrNwmKQPK+tJN52sDzYoxBqTDcga0BBXmAzLV6JV
 Eslw0O37NGw==
X-Gm-Gg: AY/fxX7LBD95O4L0yi1Q+jujWhRj1K5SrUFYkXcOREgOCvPI2I64sxAa1u39nzovuWH
 EMFvwKrGai3aSd0mw5rxKCMCAHNOJU73hQcPTpRLJRhqa+Gd0bO1NrBO9KF1gNAlvW+JqJ5HrWk
 I0vjPpk3jKcaElk1CgRHo9Gbvatt10hajJB0fo7ckyVz4AFv7CroI069KVCOSxoGGLsNSUiQkeR
 aiqbkCYay/s/1V1jpxXEwlgIkSgDXXD4l8MYXxWMLHEtDbzlYDGkHIwG+xig2cDOpICuNeIS6ES
 5XMuc2b+g09709fZshVkQ9WJBFRsg+MCNnVzrdWDnLwUrVTx2SKrVPnUMocNIuZcOx1nbQfP/eH
 Etr13pZmntN55fK3+rxi24P7fWKYfmb7F2rzW47b1Q0Ac3WJl735T5oNpRWVJPF+vXoyx3G2qWf
 /GnPI4B/RHa1kdp215XQ==
X-Received: by 2002:a05:6a00:3397:b0:81f:4566:cce8 with SMTP id
 d2e1a72fcca58-81fa184d5b5mr1068751b3a.55.1768534478257; 
 Thu, 15 Jan 2026 19:34:38 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 21/58] meson: Drop host_arch rename for riscv64
Date: Fri, 16 Jan 2026 14:32:27 +1100
Message-ID: <20260116033305.51162-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

This requires renaming several directories:
tcg/riscv, linux-user/include/host/riscv, and
common-user/host/riscv.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index d3e6041186..c1e586c58f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4086,7 +4086,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
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
index 04d0b214b6..ee09f90125 100755
--- a/configure
+++ b/configure
@@ -469,8 +469,8 @@ case "$cpu" in
     CPU_CFLAGS="-m64 -mlittle-endian"
     ;;
 
-  riscv32 | riscv64)
-    host_arch=riscv
+  riscv64)
+    host_arch=riscv64
     linux_arch=riscv
     ;;
 
diff --git a/meson.build b/meson.build
index c36f2f6962..e1ac764793 100644
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


