Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8787DE8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHv-0007m4-QI; Wed, 04 Feb 2026 00:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHt-0007hE-Nm
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:50 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHs-00084H-5M
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:49 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso3396502a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182327; x=1770787127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSJ3KB2AksZmC/j5ADncA7Ujrq+TzX7nTEDMJbopeQ0=;
 b=bhpVcGXco9y7AaKclxUBD9B26XdedYbRdS1mxHGKbEjSTe02hrsmfNrfubn8sQoUH2
 44qrOXg8gKO+rwqUMvid1vT8EKaZ9W1P8EMgAHT3PHsFrL39T3JoSm2ykxJsHLLAy5QM
 lFsL2Y7sIe1pk7CiH2RH0RVvKFCblt69yzQyg/ZeF4z7ZW3utES1zMQcWsjferRiDz5q
 Ukz7xKvi9c/3aAbj7bHKv4ExBd5bSv/qBS8f650aqUXgwTJSK2HuQT68Q0rSbb6eFH2S
 PEtNiPFC95e5UfoY7P0WIYuOFSc2U++CMFybuAJK2TU9SrsR/kW/27GsuX7+HtN4d2SA
 x1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182327; x=1770787127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iSJ3KB2AksZmC/j5ADncA7Ujrq+TzX7nTEDMJbopeQ0=;
 b=NxxCqPfYvSj2K4H6UXfPqalkbmDxZWSMAEVTALiHBPYFmbPB3cVYDDcUAHEfhNpz4r
 YcStrpXd9uP4jSc/kefrs6rp/Zl/jQA6twJHw3B/V2TiqUkXGSdIbV7XoQdi1pKfWB6k
 b0mfFTb/VWWk7pl3FW1QPeJecva1tK1kX3/lg+8BiEYRXv68/ocmBLZQzoXHDcEy3ZEF
 pwtyG7piEpMEt+BcrGa2tN8Db+zRIU1z8EObCSiBUsrIs1hUGj6wYlruvJuTLxmA5+Ud
 1+3X4NLs/xRx9N7Wtsz01pGO1OSSgurchoN2zztQ405uftiydoLinZADTRuXtQyR9wOZ
 Y2jQ==
X-Gm-Message-State: AOJu0YzR9RxUdhWL0QQS3wrOt8rrLb9IVDSpJ8Y401XQmkFCzq3W4aer
 4waAIiTnhBWueAxbUYGVs1hn+iw3NuWCVxMWvw3GY9uMLOVyCOYMndS3BngkY/KP4hQ4A+aRVdT
 OIlx6Pmoz+vp0YqJH+OJWzUsmAnxWQb/iPHmYbrZ2icNzhViASrivVX2ZiK1MfgMw7V2UK7/WMa
 RB3+123xIOy1MK3NrCwFVvlkZRgtDsy17S4+oNcLA7I5cq
X-Gm-Gg: AZuq6aJaazqBhxJPLZsTQ3iu5Tn3cyHZePl43mzUczUpsDBcKNeQO0go9aAcFPeJfWn
 PARlfLjP9vhmGA+vbOlKMq+r+o3s50tLnK5lPNQrEZnA8SHWE1eXl8uMWjHU67Xs4lLPx8YWBWi
 OfITXjbAQAgshw2JK3t5lvMp2SqGZZi+s7/D/VF/O1ChENsHn8SU1Mkksw4by0Pe9pqbQkHSAVO
 oXsBsxCGdl7+nX2nwvOqgd8i9/IllcgWeaCh/fWU2W4V7UKfEE1I2tsKdK3B2xky+ho1RNTSae2
 WCDNtG5wPBbYCD8OwrDwQE//JveYbUKKuU+45QsZY53+YkVqk7s17JEqaQMIRtP6tclybRDhWt/
 CnST6u7AUqFSHLQ+pOYBR8z+D0dc8EyeaK586GXIjexTViBXKvZMBsCp0DoAa1UufkyKIkg3NVj
 s6DkRyWSY2bBnoUfUoa2dMIPTGyHVz8I5V3xjwzy3ZtHE4gHL/g3uSE7LLYD9BeLNQJ9mvCjEGq
 GzmvVY/YauqVo0=
X-Received: by 2002:a17:90b:1c06:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-354871bfd97mr1476996a91.28.1770182326680; 
 Tue, 03 Feb 2026 21:18:46 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:46 -0800 (PST)
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
Subject: [PATCH v3 14/19] disas/riscv: Add support of Zvfofp8min extension
Date: Wed,  4 Feb 2026 13:17:50 +0800
Message-ID: <20260204051756.667397-15-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 85cd2a9c2a..daffe9917f 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -984,6 +984,9 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_vfncvtbf16_sat_f_f_w = 956,
+    rv_op_vfncvt_f_f_q = 957,
+    rv_op_vfncvt_sat_f_f_q = 958,
 } rv_op;
 
 /* register names */
@@ -2254,6 +2257,9 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+    { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3630,7 +3636,10 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
2.52.0


