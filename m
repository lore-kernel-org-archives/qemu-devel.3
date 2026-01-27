Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE90D25950
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkciJ-0002xN-0W; Tue, 27 Jan 2026 01:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkci9-0002te-KI
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:02 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkci8-0006ko-2j
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:01 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-352c5bd2769so3358052a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495879; x=1770100679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKFOVd1x1tdBqkVfLTFpz+52PeGKZ9TXVu5yfqKIdwY=;
 b=XwBsdWveuXKRFYVwBMk+wFIvCVtK+dMrNoPdXaODltBbBHOevhdEJSfPaniZvvmCHh
 1lSkq2o13KcPNCwVYMRQRFFA/r5+ZxDykGKcOtqo7AighPzSRtWGXw1Rwq63bcYDqhcI
 UYnuuqN1N8rBsbUAH+r/ldoggxJKDIaZ8evKfELF804kgsNBOJnSla5BuhIFYaDSm3K4
 j0w9A/4K4fTy4oxsiI4k4d8EQZAxZcDdo9okR6iSWKbGFPt8L1tWiDzKs+0Cq0Ak01hK
 UYA1kVlKU1OXoACf4UXCjGOJvVEJ3OuJkT2eWAKZePzo6z1l+lL50+Uvc6iOJ+FYn9wT
 dy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495879; x=1770100679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NKFOVd1x1tdBqkVfLTFpz+52PeGKZ9TXVu5yfqKIdwY=;
 b=CvqHWmRDr+zR1bblpA8DF2e/gXey2qE3YwmBImKlvrE6bABs+Q0RUPV0gObVl/3gpp
 qmAt6yO6KVxFakZ26HrSm2LZHdo0LYr+Jdr/F/i5GQpDNWd2YNgvDE8O9Mg17z2zqhwY
 7cT3n1PrbldQowDF2SG9+QMi9zezp50vhIfTRbzNrgmnHRWSz5W20TBG/UUMBIuLeGTu
 DJo4WS0CeGMgHZ6ppkhJKacw9qxeRVHzkAVdtEBm8dcDU+O/Wl8M22ba/hCuL5ZBVVUz
 H6o8lupbhzDJNXZCtIwRc0yt2IJPqE3EdgZ4FLxMQETXcpbm4zhQrnWx0KcfGFEnsO7F
 p3xA==
X-Gm-Message-State: AOJu0YzQli9hVeXnkYVH6V5YSlG0gHkg9cbEUEvd5Bk0MV1KIlVW3Y8t
 lPGFelSqBLCQbAyhzXB4Rj1O+0mj2cltrjMadEd0MDjjCplPwokT3ld1ZLfZsDrVJwa4esw5sNp
 pvpX6CuT+yWxHqbXJNSR4NKk10Wqx806s+sxByRNT4EzAGOyO4TPvCuqpdy0vcBr2uPs4J35Gmf
 nJwbAmurY+Rc8vhN1l4xS+aA+Otf80m0lddrjUMtE=
X-Gm-Gg: AZuq6aIZ5utbtQb1z2JPNehSdamz1xbFBjYjBey3QRHVzUsthGbsAvFnSshU31EcLXV
 vKm5h0JbfkPYcjwqo1drdQ44K22S4qrJUWfYk7pTqLSZ5rGafiIEetEuTmZf5/z7JcqAAoWT9RT
 EP7VVPfP9BSUG3RbM9oH9AvHPSFQHHEFsydkw+2PBfsdCsht/aWuqiLRxMIqL3PC0QeDUwwBBV7
 FSwzzjvSCragPzbnheth4cevD8bPSu8RQH/lYmT5LRxeqcOC0jhvyHYZmLbJ7/jp9DKIfy/9gYa
 FSUIJ3hVqJJZfikE3TJkKcd5S+/fzSKjgAequ/2BbpoHhQfWig8GzWEVXONpLVVt0B9hzgrDEtb
 qw82b3Bgr+5fWznnL5xaMnrAgDa5caVyqrHU36AhPlB3GsVnl+XeF1xAqR95ZLE86i57sCAu0c2
 rZ7TaHCeXEYTp6l9u03ejK3LPnyOtNBXiCS6DkM4brd/vF42z4F2XQsJ/PNTt3lWtApxLnWCyyX
 bCm9QOY29FJ0W8=
X-Received: by 2002:a17:90a:d603:b0:34a:b4a2:f0c8 with SMTP id
 98e67ed59e1d1-353feda7c73mr806357a91.30.1769495878563; 
 Mon, 26 Jan 2026 22:37:58 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:58 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 11/17] target/riscv: Expose Zvfofp8min properity
Date: Tue, 27 Jan 2026 14:37:17 +0800
Message-ID: <20260127063723.442734-12-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1030.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 36fddce5bf..c8cb3d021d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1381,6 +1381,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
 
+    /* Zvfofp8min extension for OFP8 conversion */
+    MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
+
     { },
 };
 
-- 
2.52.0


