Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D23FD2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkciJ-0002xt-4I; Tue, 27 Jan 2026 01:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciC-0002vO-Dm
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:04 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciA-0006lM-Rg
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:04 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3530715386cso4617800a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495881; x=1770100681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSJ3KB2AksZmC/j5ADncA7Ujrq+TzX7nTEDMJbopeQ0=;
 b=YD2fr2UgprhQUs8CC2YxSdgl/pmNPaNPRF+EpYdTTrNR15uBFzy/67lNZQHfq9SH6R
 oVKhq5NWgOhwUviPSeT2htxClaXfy0Bk4EoojQTs8KFQB6FU039ZXbSIzGvcSrt7XpjG
 Uu6yaDsKop8ZJlo/CS3jK85huiahpM7YrSFLLCHvV8UqhCO5k9mYwhPgCcO2QPof5PRz
 k3zbSRGNu+Yy3UyiNRSLxBM9iHz22PUzYUm/+AEpgl5PW28Da7tXMaMr2inse6IMraiD
 0sKZ8H8eXA7e1OMMto7KUlaVm/D0rNPdJn/FhN0x9IRccH3YMNrdRpl3C7x3sbrK040z
 O/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495881; x=1770100681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iSJ3KB2AksZmC/j5ADncA7Ujrq+TzX7nTEDMJbopeQ0=;
 b=SkDYqkJDm1DKZ9fHHnmWjmoBQ2sapn1I/EEQgegmA6AY9oJCEfoHNaJmP/2xV/gr1E
 th4edSc9DIvdEYqdVxSA2GwqeT25qlEBae9wm+kuP/Wo5HMZGiRZw30gI5gyOEXR3enR
 Be5oCBLUaIBWdVbpsUfdkuhf3pBwXf14UGRqDzU6h2mnV6xolhhDrEf5XyPINkdeTSr0
 kgRsf+fpRODpMQ3SbYCg4roCIr3rCo2m1ZlPoEwVnOPM8Gj3J7QF30rmFogqzuic0Ftl
 EGrP5VmC3WlD6jQgh0DLdo+5PMMXWoWUcPp+/LVU/M7w5P8QAcOv2dsqlGmTJuIXBC/N
 y0nA==
X-Gm-Message-State: AOJu0YzuSrnB9UITeot0W2PE5D6W3Os7jf8Z9vbQNpDjJn1kH0DCP5d1
 /f7zIkPiVNBB0XUIC3pxgluwtCFwqdHykX2V7BAQMEIZNGxxEJ5Rb2TYQsDPXydhQNss77B6aq9
 UHCwT/5/icKgy1uwrmqh3ofkVI7THg92G0ULd0r89gKWI2wFivnHf8gXMMpLA6gy+46Xn99QY4e
 gCQSnFDXKXtAEkM+/gMM5rxDbBK+toarIYXO0CEVYtlQ==
X-Gm-Gg: AZuq6aKo7n0GPNzhTL3+RCgA2jTvYqsRfI+6LKhmgpy+TzmBH4kuu6foug9ZLsUtqLK
 91+siklL9MukpWHdMd3pSj12/N0hb86wew8/dv74abLim+ZGkn90zTtJOKCYN90adX3HimsWFIu
 tO8DGyqlLD9Dh9P6hGy2gstkbRXf2+ZlFAJ+KnSgCjjt4zJuM/PmoFvy2Y1FxlqHF6QWs/ymnhh
 sdPIzIRjidJOrKea+rZG3E1QcOKqzyg+R0argzbMW81vEROZovD9bKQLzKR5o7DWYx9OpU09F+R
 r7xvHAua3ibKcL9k/5MVMU3WIaEIv1eVbi6NmC1qUJcFOkkdHlPgIA1gi81MlUZqkXbxnL/CVtr
 OSlNvXYf1piruA2HWvX66QVwAoZQsfU/t8gf0hO3jX53QyYQaWfTVVzbf5faspNet6Ki5SM6Qga
 oE4ZUxo2NG+C+V1A4vYR21++YNqdPtQClgL114pxUp1mF5U5segrES7YSsMQfUX7Xq4qUUsAHQv
 sGVezItvJgQMj+2zRio5q7CZg==
X-Received: by 2002:a17:90b:1dc4:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-353fed5cbe2mr980031a91.20.1769495881067; 
 Mon, 26 Jan 2026 22:38:01 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:38:00 -0800 (PST)
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
Subject: [PATCH v2 12/17] disas/riscv: Add support of Zvfofp8min extension
Date: Tue, 27 Jan 2026 14:37:18 +0800
Message-ID: <20260127063723.442734-13-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
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


