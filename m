Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E95C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RTy-00023c-TT; Fri, 26 Apr 2024 15:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTk-0001bq-Rl
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:29 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTg-00035r-Jx
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:28 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a58872c07d8so650977066b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160601; x=1714765401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j5wqqpS7/lf73uUyWBqUlTl3qEW0g75YQa/BO6RAIE=;
 b=fmEWD8mrPo0nCAdTx+DfDnclKQMlrTALRAnzDDyyiHk64BfQO1BkhBUFlgnMvtx85K
 TUsTNsRav89Qrvl4yKgi/HjgD0tw4WSl9I8Xkzjc6mqQwnUvvYFSiQc3RuepKSoFRKc5
 sl4+mYKRzMmJsg5RbvOJqrPSMjo3Q0CnyN0pEj6wB5xodXnY26KagkAzBAu389yHi6H2
 mj7HVU4j+DaANMEwBE8yBzToxPiVlCcDf8AQXR0+l7ODTVgFM8QVmAlpf/5HMkfiEoBY
 6d+CoajPuURxZL2CX8tv6JrR3Rm4UUthvjUZ1aVzIa8SnqIItm+tpeSr7e3Gq18yzj3i
 x8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160601; x=1714765401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3j5wqqpS7/lf73uUyWBqUlTl3qEW0g75YQa/BO6RAIE=;
 b=cS3ObpCrTG04S4dJKBHpn5WQM19KPhAO5plKVyrtw3E6jeu6HExt/DGGSLj7wW6kEL
 89w0OuBBm2q5tPkqyZlcwmtmpf9vMCgxLYolnjkukSIkWvfWxErYjbDgRZ0ucB+dbBLd
 fUNSPK/90wN7tKJno8gNBNOk1dAqBA3hLHBqSAmeJMUNT2CWNLiccwAlujnQHMYzJPnK
 c+X/W3ZXpTNDZ0+j7MyUcEQhGvXL3d9GNfa3oA/hjihykEwZruqkchmQg2oLI4+GLYjV
 /xzs6L7seJzr2YD3RNKAcmr7Yh7Ea8MGO0sDFv6zGD667bJxlygnoQdoEGs48QmSuUh+
 +y9A==
X-Gm-Message-State: AOJu0YyengI+msqv9XgBvFN110sKU9eA9ngWx28W7yWTxsFV5gY17qRl
 DnhVs6X3D4/CiGRTZQOlZvKqLcUNEixiB8W0uShkSF2h98h6lESnzxDBis7/tmkTTDCivxwMLN0
 oOGw=
X-Google-Smtp-Source: AGHT+IETBPuyIVPCZBmtMgTb33DBkiexcpTAB7tWpueprnBvdcNXAlEwf1W/5t8Jv1KaOUZfGRpp7g==
X-Received: by 2002:a17:906:f9db:b0:a58:83a6:c68f with SMTP id
 lj27-20020a170906f9db00b00a5883a6c68fmr551531ejb.17.1714160600871; 
 Fri, 26 Apr 2024 12:43:20 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 dk21-20020a170907941500b00a55aee4bf74sm6993231ejc.79.2024.04.26.12.43.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:43:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 13/38] target/sparc: Replace abi_ulong by uint32_t for
 TARGET_ABI32
Date: Fri, 26 Apr 2024 21:41:33 +0200
Message-ID: <20240426194200.43723-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

We have abi_ulong == uint32_t for the 32-bit ABI.
Use the generic type to avoid to depend on the
"exec/user/abitypes.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240418192525.97451-14-philmd@linaro.org>
---
 target/sparc/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 07ea81ab5f..ec0036e9ef 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -108,7 +108,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 #if defined(TARGET_ABI32)
-    abi_ulong tmp;
+    uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
 #else
-- 
2.41.0


