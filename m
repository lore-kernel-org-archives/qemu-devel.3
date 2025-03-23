Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60705C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGX-0005pz-A6; Sun, 23 Mar 2025 13:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGV-0005oR-BY
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:39 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGT-0002tR-Fl
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:39 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3018f827c9bso4898054a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751456; x=1743356256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ntv50KlP9/+Qy60eqjdM/5mfxACbQs3UzEcbO1R0LI0=;
 b=bDI58YWBXyeYvRCmsxbe2nHCfsK/ED2AI8YMSo+XispEf6bdMQRQx4TnQbti5b+3u1
 yZRSS3DL/4FzS+Uo1J6/H3di2iiSK5coDRqDZnaipAgSvudPsqX/AS9cfvPvp4otewbG
 VDzJ8X+rcILbD/YgTzktM+ry2FC85kc4uNpnz8Vt3Ib1FljuplCPb7hUCVO37jE5mRgL
 dBifwnL5tfk5+x1vstKaSyyoTGIEWsBlePMB5WmP7aailJyor0yt/tr+kbFKMTgkeRqA
 gezLmoSvb7BFdPOOmPxXW5tO6T5ewXLELB5ziNSi8cCRgfjAfLZUX5bKupAhCfIE2q3+
 79Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751456; x=1743356256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ntv50KlP9/+Qy60eqjdM/5mfxACbQs3UzEcbO1R0LI0=;
 b=gfse2N1xbF2GDHynQOSbD5CfZXDq1MaJDW3DpYJrcObL3zBLW5w0dbciztHKhSrJmh
 7pKmKBCP0R2KzdYfUhY1w8GZiDL9ZA9bhW5luoqGaotqMxP7MF/2UH6d2yAyR+pPC08J
 NvcHfQypHiAt0CbNs0H71uEP3V2prwbrdcfqGlRvUJ1lE9kKV0F4Jigopdlek1WKIumI
 Kj+y+JboSceeF+I8PEh4Bow+oF/qBtaH4A0UkgAkR0zYxqysM9kCGi9G0GQ2CvrfJdDT
 +8nLF9/WnSZCvdY8vrjp/DkUlbh2Kue+ARQz9Cqx3U3azE06bWuvWoQEiXhWUtPA27zI
 olgQ==
X-Gm-Message-State: AOJu0YxfGzpyN/bzoHD4xoXXeHE0CxPnTQK/P0mqi0Q+DWS5eNUOPil+
 g4UveD0A1nQhv6LMCiIewLKmj9REgqrDen+GbmaJGPEqxL8SG8Q6nEd1HZOpof76prUxSNYNAiR
 /
X-Gm-Gg: ASbGnct6xduoS2/tQVKqfV8Y0Ii+fK48pIRZT9ssZ7d9LWptwvE5ljkXE4+NqUJdJ74
 XTXMJG8vSAJtgXSTAQyNJzCy5rqfrAFe5yNmYsWP5Wlm4DCUokvQPfZWMsLy1WuMTsCKwBjxxen
 iHmnhnjo6SZzNFxr86HQpAjWKO570SoHzLlKbHfd7yL4NOXHBp9ni0warNngaI5G2kip+4vm9yR
 FV8jxSJgRB5P1z2p2is8JffohUlRtmOxhVJLm8hoHjjLV1L6lcaRQqTbwLzNSii6f4qQPfrYPXu
 OaEOythHlYGvjNA8VQzcOgsBRheouTPW74jvotxBJPdDITFg+vm1iS/1vjAP/UHNyXwpFdvSdBA
 Z
X-Google-Smtp-Source: AGHT+IEfMSGxb6e/TcX2p3xWv4uWcpPjWdpgaOAXguMAGXxTkJuDR0y8hg3Q9T3bz0HKXyokwZYTXw==
X-Received: by 2002:a17:90b:2743:b0:2ff:4a8d:74f8 with SMTP id
 98e67ed59e1d1-3030fe721dfmr14669091a91.6.1742751455820; 
 Sun, 23 Mar 2025 10:37:35 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 06/17] target/avr: Use cpu_stb_mmuidx_ra in helper_fullwr
Date: Sun, 23 Mar 2025 10:37:18 -0700
Message-ID: <20250323173730.3213964-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Avoid direct use of address_space_memory.
Make use of the softmmu cache of the i/o page.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index df7e2109d4..7cfd3d1093 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -23,10 +23,10 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/getpc.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
-#include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -67,6 +67,11 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
+static void do_stb(CPUAVRState *env, uint32_t addr, uint8_t data, uintptr_t ra)
+{
+    cpu_stb_mmuidx_ra(env, addr, data, MMU_DATA_IDX, ra);
+}
+
 void avr_cpu_do_interrupt(CPUState *cs)
 {
     CPUAVRState *env = cpu_env(cs);
@@ -311,8 +316,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
         break;
 
     default:
-        address_space_stb(&address_space_memory, OFFSET_DATA + addr, data,
-                          MEMTXATTRS_UNSPECIFIED, NULL);
+        do_stb(env, addr, data, GETPC());
         break;
     }
 }
-- 
2.43.0


