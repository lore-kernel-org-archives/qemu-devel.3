Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686E4D2594B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkciT-00036F-GI; Tue, 27 Jan 2026 01:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciQ-00034O-Ib
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:18 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciN-0006nf-8h
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:16 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-352c414bbbeso4320680a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495894; x=1770100694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5CYrkhJrpjvqBVPkzOjtXXVzTM5dZscmB48AsapUgU=;
 b=hoc0DP9nxJByA1bg5Iw0Ox0pjVe7QDWjDHxLui5NzUY2PMBKUKylxc9TkFSxRLv9qO
 +spbFaxRiCk9DpaPuWSsjvpmrZht6HQAPkUJjR1X1dBwMWC6cFgcgAwd9eNMnre/OpA1
 9p3Xf9E2eon4NAOQOdWw3jGyFQlVGH7VRQr70mKaACwGDx2bcPd0w3pWwAi9cy5VVZdh
 z2QN9a5iW/mCFLjvq8yGtPbyg5HiaV3VkgU8cKK2QpLvvkn4nLZwffFmXVeIzQhFdWh6
 HQEiRUKaoflH40FNsgD0vNOtj+PerAdg3K8QWtg5J3AP6Kn/1WyUp8BiRfhgNU6MLsUm
 cLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495894; x=1770100694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d5CYrkhJrpjvqBVPkzOjtXXVzTM5dZscmB48AsapUgU=;
 b=UAhr5vak0wA3eVQ3f/XRUw5s+VeR/4avgFMfF1rwFVZxzJOW2RAW4Lx+6L0sl1S0cD
 9sL9yVJXh/CzsixttAQI0FLSbSXpUDd6DXXc7uMrmRnFloCmfMz84km32MuWMHaz+RpK
 VY2zyEH5+fEONqlK3136mHcuWQ2fBs+mEkHk9d7cBaNWDG4F9keEN9eoutdr6dmCbi1A
 Bp5Ghz2s37mZp1TIBIpztit0l5Y4H0Evx69/t7/m1BQniSmEEMvXK9ZoT4utSdlQORqU
 RCT6PexxsRxlKpoLsI3dbrXGMndRCi7jdn7E3B9HzBf+pWnssg3hhpZy6upbMJA638Cn
 T3Yg==
X-Gm-Message-State: AOJu0YzOd//2iXvD9A57W63TNunhSg0yGF+J2eY54LgvAa+AkS9e6NJV
 +HUqv92hoJH11i4Z/aW4Sb0fNO3qhJOu/RXLn/QeS6vMoMG/hcWGEuwZqp8BIVARaBnGO+GppsO
 ni9yF9sykF415nseV/r6MgIJDW8LoUafp/Xth1DlPUl0Ng+yWW+buiTgX6+2Zt2xq6/ZqtzPPJO
 I8pMRrfUYPZn+qj2hTLlxcmav6jfBnp0pmc2BXDJzECw==
X-Gm-Gg: AZuq6aK6Ma54Q9Xi5zQoehSNQQqL9/+l157sSZlbdOehXZ4didxoCpKS7Fpi8GqWqzS
 6YNJD9f7nYNBCiDWt5dAeQ8ie5dJUE31aeot5uW1OjIo5TB4mnIYMs4ZJ0/xHpJcB3Nn6myvtMX
 X3mrZq0ntUTN8dwXIIrsh9EwoEnDziOjIscpZY6Af5wzewoXjmLoQNxbCXGXuHCIwGOdFQ9n+MX
 rkavgH6HhFXyggtVmgjFaT1/ljYfru1xHfxaT6cZUSuXrMe9Nr/tJ4qScA97DeIX+VkcVrCQLtc
 7JpKv4IRIBByenB9XHVd5SVILT+sJP9xcGfa9YC0OS7IY1ljMftejU7EUG4Fm5MXzihe81ZM8Nj
 rOQIpT60goAJq3KEfS0g5aipVmR6SGmMGU3Mg8ilHC7Am3Z2GIJKYfRMvt59zLelBSaUgIcMrp/
 SarbqPDxWCqYVbYVGrNBY+vaNDMwJSJqXLFAjtKpV5IZEFUIJ8W1HjGhEvkuYma8uKqgLkxYXGt
 BP82XCG7YLv4LuK1tlMdCRQyg==
X-Received: by 2002:a17:90b:58c8:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-353ffb1937cmr610526a91.11.1769495893938; 
 Mon, 26 Jan 2026 22:38:13 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:38:13 -0800 (PST)
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
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 17/17] disas/riscv: Add support of Zvfofp4min extension
Date: Tue, 27 Jan 2026 14:37:23 +0800
Message-ID: <20260127063723.442734-18-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102c.google.com
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


