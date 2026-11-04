Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87A60BEF76
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=OeibzEl7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgt9-0002mf-Gc; Wed, 04 Nov 2026 14:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsg-0002Ix-Rm
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:51 -0500
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsf-0002MI-6y
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:46 -0500
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-3282db206d3so2089194eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821364; x=1794426164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sxdDCH95QuQuvi1XNPzOyVk+2xiH45irB4Kjbr47kaY=;
 b=OeibzEl7tHM2TWa2XZRgvZb9uhdyidBbrj2krm1XdCiWhjRqNEbBk9LIQB01p11HkS
 yiNQDfZk4nSKHeLDaaI3Oc6nqyt4tkCVb2zs7Pl7gAZ6k7qEktCnUVhku69AvLXqYM0D
 BBZEe26SLVysoFpa141WFEGn5VcBx9BUTolDwS9X+OwMd+/WoLheNTERyqKwZchXZLmb
 40wCAtMdTebBdBWQNLHAwwxPJTcFQwZQfTqHTKbErmSYI3KscCsILDHYPLKeBCbK6/EN
 8+YZUqw5ODbh6FNU45qkz3WJZMiW2ImyLRViU08mgslSrXpBJ38Tocy7RpSrOXZNyBAx
 AxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821364; x=1794426164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sxdDCH95QuQuvi1XNPzOyVk+2xiH45irB4Kjbr47kaY=;
 b=PPC1MoSvSsBk6xwESS3CTBTEev08jYmjeADBMqjQQ7rc7OJfnnWdPiCVdpRw2zLAbW
 zndfnLNqL4doEHR6grtFfFBCzapGaEeA0LSi0SjjWCciSweZIsomDNF6+4R6N7O5p4Vq
 B2AiCnxB57SLGaIlkTwpx1MjChckQHt0WRZIU182m12PvWgZZ1SVmknsYX3V8zzuoVZ7
 CePXWg+BxtauQwPTBW/CpTmnikKNKt6NrP5XrX7uvIGVhIs6Z0dyd6z+atiBvEcZAMph
 6mpNRQH3Whg9cAqw1QBHdE28S6hxReI4K9loiJ8cXGelHrahS5ybX0iVwIs4F3TKo/T9
 xA8w==
X-Gm-Message-State: APuU4Z+oMC9Dd3fKRML2U4OURAZ3EXsvPKB0BQM/NHTRL1YQRLI5nR1d
 W9ACdD+Q+kcbQi2BJoYs98RF6BmboXsbGrciPMAosFdnMZFkhpVfK4kaxSWIglcybuVvoVb7rWl
 m3GPuOtPiZ9MVWpVhUoTT7LtxgRWujfSUhhxLryv4j0FFzodRXxaABRS+87rduPXy+foE8NzCH9
 0OHO23+SzzlmEkpUiAl6V3kwWDIVsho7vS/dbzneCvwg==
X-Gm-Gg: AYBFou2NWdGGGGHknSuIqvYsBOlP7K5TuhQ6Of0Oupep99EWabCxN5eKYTprs6CsVGN
 lexcleJFCAJ5C8kWN+ewSEA0X1NGaL/GKhyIpSox2U3Dd9b/I//i/kfpa2CutQhH5bc7LN0FBCj
 n5qcZNw1G26t4Veojbclrm83zpkuf4HthTi3bOdwCRICFjsXNu8afsDizKCSIQE/+/d6qBJEkU0
 1DZ/XweKKwFkVAws9vWQOt5hmCS/taNS3CAdbwgxTSBv+K6aJxl88Ij7NyoAQjpoS3fSiuBi/w0
 h9TPD8+hkZuQGyQZMo6/cGShSwhnFkb7A68goWypTgg/wY8rZdeVjF1AwvTIDLrb+IYAAp46LL1
 olFoKeVPA46m28fY4yhsViOpVci/Xdtx97qOEjVhQr502efPRS2tXe/SC0pkWY6UKJorOVv7tyf
 Zvr42YOu4xxbTASsGa5N3v/84NAYdVI8JXWD8A+20DFu+La3W5tP1YkQj1bIyuNzQSjaXsnW5CU
 zgSl+dFaNq2l3gcc2hwHvPHVHMBYnFcPXpYr0hOnfsAfqOFZxqvmHAWQoae3Gvc1rtKFJkglUYx
 o9GfBkrVZ+0oae2EwdSSN3iSv8L4uQSd6hTdmuLRFAZ/TovOZrjz3xZcU9rfFba7GE9a+uzb9Ow
 VrguI2YKZpIWRfDmUAkxcmF6GYk0e
X-Received: by 2002:a05:693c:4199:10b0:36c:d0b2:9bf5 with SMTP id
 5a478bee46e88-36cd0b2aaddmr4177928eec.9.1793821363798; 
 Wed, 04 Nov 2026 11:42:43 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:43 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 09/38] target/riscv: Add Zvqwdota16i dependency imply rule
Date: Thu,  5 Nov 2026 03:41:24 +0800
Message-ID: <20261104194155.679241-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

According to the Zvbdota isa spec, Zvqwdota16i requires Zve64x.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7873e67c053..ae859128d30 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2853,6 +2853,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVQWDOTA16I_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvqwdota16i),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve64x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvqwdota8i),
     .implied_multi_exts = {
@@ -3066,6 +3075,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVKS_IMPLIED,
     &ZVKSC_IMPLIED,
     &ZVKSG_IMPLIED,
+    &ZVQWDOTA16I_IMPLIED,
     &ZVQWDOTA8I_IMPLIED,
     &SHA_IMPLIED,
     &SSCFG_IMPLIED,
-- 
2.56.0


