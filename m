Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7EEE8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVI9-0008FU-HA; Wed, 04 Feb 2026 00:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVI8-00087z-GS
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:19:04 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVI7-00087v-2w
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:19:04 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34c3259da34so222862a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182342; x=1770787142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5CYrkhJrpjvqBVPkzOjtXXVzTM5dZscmB48AsapUgU=;
 b=WdYJNeDnnNPJLvdljqpJweZf0ovrp/i18QidVxFVserUDrcHHnaaMn9IuGM1NAamON
 O43iouR+5XeLqJv0PM/2xk9FGcN+bigR6x0k+dInD0fnAJeBZVyvWuRe2FvjgdiAvd2e
 HNK3ZMnU3LXCvy7xlaAmozFhr8BPUb2RHm589Zojpa1lZow+LPhEvIhtGkjJ822T50K8
 3VeGPSxFvPz9zhhvwQNEAirh7ME/vg8i2bngxbm4+hPemo9vAoj/KqdYgQfM4w01Neme
 dmQ7CyMM9WR+4CAfCCxGZgFDoRD6aYs2ZxmwcAjQizCFyFIzZqbqHteMFAH+7cYReW0M
 idYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182342; x=1770787142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d5CYrkhJrpjvqBVPkzOjtXXVzTM5dZscmB48AsapUgU=;
 b=AAHtY8zkVzDfaIAX/0c/OjeWGqJsVZOdBIpwZqm7LVTdFLLpqbYYZkCt8vOCij7dbF
 f7LthCI7125fio90rbCuOlLZ2GNmI61dFlTavUQaMWsZmdEVfhr/OBZrgT3NDk/4mlA/
 khIQXjn4RQVfJk4/kVUvgIkCI4qx8ffJIkheSS/3tKEwOt/szkLWf/+o4fj+gaWxKMHV
 4jKMOK6y5O22OmY3c+O5WkAK3o9UDTWFO3lYUvm8yoIfGAH+G/iPyJ2ALSm+ycb8A2r2
 RlZ/vS4/pVyEx73baSS1FPIvcYUJ0mEHzhvd/1rhwc8Bz3ru0cft8xL9Wm5UoONXCg9i
 rkjw==
X-Gm-Message-State: AOJu0YxkquIdISiCS0YQWMKInACEt/4rtqC2JNEHp074rXN+MNMOP6kq
 pfjgQI6ZP2NKdevdNF4U1igJnOMwjnfpkAl07F7723XZGl8iol/tVEkwO51Uc75I6XA+zmFnjlo
 6gs0pJE6f2SW7Z/vTkSUVxntMcSIw0iiS/fZPtyoN1jFsI7BakmQGnFFTw/D0ODf+nevjJevbU8
 +GSA4iZvMSRxPZNidaiKaYDZv3I3ksUSDys/i8R62MJkCV
X-Gm-Gg: AZuq6aI0D2KDd5iGxmoUYtgLFzHEcabmEbm7zHNcoos7Khor1ofVOurEHVe/nzep5Fs
 U2hWKTIfm49AklsjYQzaRlA4N+9poiGu+tGORhg2VJeUfAtVfEqT4D+8xjnUH3c9fJwaQR1b/TG
 A2DJEH5yzAwIbM+3bMI3zYW0vkJQG1jg/R9LUFTEsGpiJEnpbO8Ep8Tt7lVlJe290YmrcotlApT
 9Jpsm3Nvm9j9UTGWCJ1XY+S9m16CzBvSQdvWEFUqcPvKWvce7g8s1CfJV1ereYy65eHsfJskox+
 rHM2/a1L5I4s1dK6M4lZb13yu+pbdTt8g+B2zw6YiJwXckDd7qmZBtQm1HgKvyXiDlX9cdizrRL
 ocikghmBTAzYAHHo+81K6eB7XUXKol9lrv5eyPNNOApDKHntuvOJsR8VST1so4jRfh4Udp+ZfFC
 cdzpfz6FVO1wIwMj1zPrNTKXuryb/FSg2OszRtT3F5WCuhKzInSR5Sqb/2FLZMAm7eDXQ56T7Wz
 bSkhbAzlb7FJGj3tLNiTA+UkQ==
X-Received: by 2002:a17:90b:5201:b0:353:100:2f20 with SMTP id
 98e67ed59e1d1-354870eb37bmr1537890a91.10.1770182341673; 
 Tue, 03 Feb 2026 21:19:01 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:19:01 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 19/19] disas/riscv: Add support of Zvfofp4min extension
Date: Wed,  4 Feb 2026 13:17:55 +0800
Message-ID: <20260204051756.667397-20-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102d.google.com
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

This patch adds support to disassemble Zvfofp4min instructions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index daffe9917f..9abf86f2d7 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -987,6 +987,7 @@ typedef enum {
     rv_op_vfncvtbf16_sat_f_f_w = 956,
     rv_op_vfncvt_f_f_q = 957,
     rv_op_vfncvt_sat_f_f_q = 958,
+    rv_op_vfext_vf2 = 959,
 } rv_op;
 
 /* register names */
@@ -2260,6 +2261,7 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
     { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
     { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3715,6 +3717,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 12: op = rv_op_vclz_v; break;
                     case 13: op = rv_op_vctz_v; break;
                     case 14: op = rv_op_vcpop_v; break;
+                    case 22: op = rv_op_vfext_vf2; break;
                     }
                     break;
                 case 20:
-- 
2.52.0


