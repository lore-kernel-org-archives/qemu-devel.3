Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E0CE9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9dy-0001TH-Us; Thu, 19 Feb 2026 14:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dL-000084-Rw
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:23 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dJ-0000EB-Re
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:19 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4362197d174so870999f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529055; x=1772133855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+bm8Uli5keNN0nt9Uh3wdHMVxKvtg4uuGhjgMaQ9K4=;
 b=yRlOV1sRJdvU/dSNT31m5ZGBTXGjqMgTxVzKDGoZpdtewX7W1qp1JHVmP9n2IRNr6c
 3OZYKK0TgaU021T+9oDGYTy7002SzfUDFg34oBLQl8zdkx1c2OPAGEUYIv9zUS0HbHpx
 Ht1+h/zPEI5IIu5mXoyMdfpuGicrJsdkujLIlY/aF5fdWqshlgAWIIdFOXuWx9zBuFz4
 mQqAjuaTfmvZqDY68IMq70L4NJxumjOfWC3Q71ct9XIx56MOVFqUrZHwt8JEgYvo+eHc
 htZ3m2U7E3gRwItcM8Twomn8CYm/eC694LTaQJ6Go++imn564NGqoRm5DtqIy2NBn/hh
 Yn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529055; x=1772133855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+bm8Uli5keNN0nt9Uh3wdHMVxKvtg4uuGhjgMaQ9K4=;
 b=lqhMZR4loeo0s3viqlmnFDHqWvG0XiIyP5GDrE7fZsVfU7yOI4SEnwT2tci78070TF
 o+pn+AYfOsIrPTHh0wy6mcjkx3FyvCqtu/0m6DEKxVBg0dpfSZmXk/Ttfi5IPVKMraFE
 wMYEJ2Vt5/o9dwTZpvcC3W28YgTcXVsJxSSikvi/oBmmiULremrCsYRe+ffJLR6qpl8t
 j4RZ7hjuwGv3QkzZFW/lKv8b4wmDo8UHeDXLvERLvCv21g3ZVjm5VeEKrcDEX4SFdUxK
 WUtCQIoYBcJWUnZyhL9LZOAMEenFYBbkVqGpWbposinUSXRN8RZa4BXTDNzd6W2QATaz
 lkCA==
X-Gm-Message-State: AOJu0YzrK5Z3U4RJXjEm418jR7OHAjaPm9VcRhSthwYitro4mTnhUAkQ
 JI/7D7ZfqinCM0q1soXGpygPX29MBFn22mL4wx9pVXPpHuTLYqiT5+DPhDtT8UKmfFv4dvj55Kj
 i7wSRWwO8CA==
X-Gm-Gg: AZuq6aKkbmAsafR3V3q2ulhOx5Rkg19RC20VFVWySY3WwXCs1XgbHa/SnS2QSTNjdNB
 T67ejiuYKaIoFxdjeDWBoCIPlbvpOgXW3qlALI+H5x8Zdy8inD3DeQ2Eg7fbVVL2TTHlOLREDut
 xqpeMzyaI5cxqH8QcxEdtEiqX9XFqiZva6TAjzDB3kSCJNX25Xf2LB92g8vwMC1FknShDZEhoQh
 XV2u326YHb1ZLzAEtGLskgQZMmw4O3fO9PzW4HaNCl75EtCzGCF1LuQYPcaeUWATgFRt6O2wGPj
 Vsjr6pd7Yk8euabrtktPd1qIg2VMisOc9hbfr0GdEV+TzJExnuCj/WUF3JlhGgdO28vD1XFF9Mm
 Psj6qQofcSbjMPrpKaaVs1pembP/mQEwucpClDfIupIj+qurAr8Do4Bu3jhr2Ox9F8zps50LAfN
 cD97GggryhDXX+vKbCRQ8HTaXLNQPr1ViR46kjRVauyR5xxysm/DGekxmnQwaGwP2+MbVdn/xq
X-Received: by 2002:a05:6000:178d:b0:436:30b0:759f with SMTP id
 ffacd0b85a97d-43958e0df09mr12837191f8f.27.1771529054997; 
 Thu, 19 Feb 2026 11:24:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac7csm48899172f8f.7.2026.02.19.11.24.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 36/50] target/sparc: Expand gdb_get_regl() in gdb_get_rega()
Date: Thu, 19 Feb 2026 20:19:38 +0100
Message-ID: <20260219191955.83815-37-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Convert the gdb_get_rega() macro to an inlined function,
expanding gdb_get_regl() via a TARGET_SPARC64 definition check.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/gdbstub.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index d19819cd1a9..792bf70a145 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -22,11 +22,14 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 
-#ifdef TARGET_ABI32
-#define gdb_get_rega(buf, val) gdb_get_reg32(buf, val)
+static inline int gdb_get_rega(GByteArray *buf, uint64_t val)
+{
+#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
+    return gdb_get_reg32(buf, val);
 #else
-#define gdb_get_rega(buf, val) gdb_get_regl(buf, val)
+    return gdb_get_reg64(buf, val);
 #endif
+}
 
 int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-- 
2.52.0


