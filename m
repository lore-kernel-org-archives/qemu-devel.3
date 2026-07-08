Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F6AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUzq-00019t-MM; Wed, 08 Jul 2026 12:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzo-00019L-Rc
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:36 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzn-00074y-Ca
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:36 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso11483385ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783527574; x=1784132374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZERHPamERHB1hw0+7p9a9eq7gJF5zxz97pdFVP6Yy0=;
 b=L9xr1NSd8RxWSn2oYBx/qW/nAz1+O1OXZJvvCWJIfi63dfIiw9l+1ebGVjOdwTTznD
 DIAjgnL8bbXjq+fCjV69FgiH8qiMXkxOIPs293BDM+/ylnytWoysT6qzhJ2qw4XCjHOb
 6bdJin5pvlyfdYt5byKR4Sqsk80QTjx9cCdPDXT0T00oDGwbxJEiauHjqiFnAvDSvchV
 vRZpdz5y52n7J7lgbA6Ip/NctZp1xAL+H1RJD6iAeZdW+x8gBgyXn5d0f709yhZAnANh
 H2NOP10CUSp3e7yCGBhkqRiUkrYpL1D+L7V4eW171rtt5Gix43TqRcDHJWVBVHt3nEpn
 f+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527574; x=1784132374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZERHPamERHB1hw0+7p9a9eq7gJF5zxz97pdFVP6Yy0=;
 b=KVbVl0SR0ypcl9xO9paPfHduJEk60ii32hWOkxix+rYp3wTeQKe/G7rGUzaBuWz5dU
 dPQC/voE06GNKPiE6mymaPIIh4uZ+6cPnROyvvkrqKL2jraeVFe6XjwtGJ/ZciWNlpt2
 jykeljEGRkMtcNJKOHQEazpau2jRjBvXfv6KlZBRdiOr5we+gFuhvQK5ITpuzfIo6dUz
 VnbuS/WSuH6fTNVgtKq18rvxcV3mp4CiXBinkACem/PqZN3HbrF1PUBCQJW8bJ1vUbWx
 yCu/52o9dKrMi/eQswMlKTehZSyIB59KAcXY1EniskXH5wCnPd4Zpk/MiLaKm2dcixl3
 acyQ==
X-Gm-Message-State: AOJu0YzvQU0lsQUJ6UC9SBMgXxxeFtF+AFhhps0Gwl99UF0s4B0ZLmta
 H8eJoggIKOpfawttg+t5BPKHxaF3kvjMQMWhw6Q++VW3wC8vHFG2HQhr4oJkvNqKjCnLMOMShfk
 SoL5ia2Ypnsj7WuivonUHELye1jqnFK3veap8kZt1SaMWER8844nbxP8qS86eTETMa0DksIJdHW
 SciU7tNwiY19ZcX8mEWfHGL+QBwSBuBFIqbsDSTRk=
X-Gm-Gg: AfdE7cn9Ej0xaOgq/IlTZd4R0HN1SfBL6sh5+gjhPbTUhsA2GapAfeW/8zM2DEQum7G
 BepzscS1qQd+vZXC3CrtRwk0DmvVR3xw8lxmeUIzvpiun7tEq+Iphu9xZoJwuLWNeGEX/11jD6u
 p2iZ2B29wr/T41k7+9UNwR5obMwJYnKm0v9yWluqzBkK7jZ+XgV1gOm3gVEwOkLPNgDLX5PkuIu
 ps/CP3HqC1v2eiEUisY9anyjCaWSe0eoy3b28VNdqhchFML4cplygTui1QNG/YLHcYQhUOStxf9
 E0+MUNsP0U1wLqCqwhzWj3LhCOXTKwXcG9D6xFt2U+Zlqz3I1rlsW8bAiyjX5PX/RCw+z2Q2xg9
 7j22ja/U9xr+Axwi+JeSk8e75Lh/NX9ffHcb8a6SdnioBRIu7MC4Ibcak2lc0gow5NTCd7VHQWT
 y2iRUh3mPki57Txu4Nbu92mA8Mxx2bG9OXFzJ433HHNVi9sinDvNJ+0kQc2ab51F1uNrOUIzfqp
 yxcjEhYTAh6bjXv
X-Received: by 2002:a17:902:fc8d:b0:2ca:73aa:b48f with SMTP id
 d9443c01a7336-2ccea485246mr33357415ad.35.1783527573525; 
 Wed, 08 Jul 2026 09:19:33 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm30789265ad.15.2026.07.08.09.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:33 -0700 (PDT)
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
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 9/9] disas/riscv: Add support of Zvfofp8min extension
Date: Thu,  9 Jul 2026 00:18:59 +0800
Message-ID: <20260708161859.1124848-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708161859.1124848-1-max.chou@sifive.com>
References: <20260708161859.1124848-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x629.google.com
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

This patch adds support to disassemble Zvfofp8min instructions.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b262773..bcda21fb62 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -990,6 +990,9 @@ typedef enum {
     rv_op_cbo_flush = 958,
     rv_op_cbo_zero = 959,
     rv_op_mnret = 960,
+    rv_op_vfncvtbf16_sat_f_f_w = 961,
+    rv_op_vfncvt_f_f_q = 962,
+    rv_op_vfncvt_sat_f_f_q = 963,
 } rv_op;
 
 /* register names */
@@ -2260,11 +2263,14 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
-   { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
-   { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
-   { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
-   { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
-   { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+    { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+    { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+    { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+    { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3660,7 +3666,10 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 21: op = rv_op_vfncvt_rod_f_f_w; break;
                     case 22: op = rv_op_vfncvt_rtz_xu_f_w; break;
                     case 23: op = rv_op_vfncvt_rtz_x_f_w; break;
+                    case 25: op = rv_op_vfncvt_f_f_q; break;
+                    case 27: op = rv_op_vfncvt_sat_f_f_q; break;
                     case 29: op = rv_op_vfncvtbf16_f_f_w; break;
+                    case 31: op = rv_op_vfncvtbf16_sat_f_f_w; break;
                     }
                     break;
                 case 19:
-- 
2.55.0


