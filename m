Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E79BD1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlw-0001Ov-Cz; Thu, 08 Jan 2026 10:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrle-000165-CA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:42 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlb-0003fZ-NU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:42 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7f0da2dfeaeso2843277b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885457; x=1768490257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eq0kz31utv24Lw7pa6NdX3yKLpZshCxhpuDssWv6wlk=;
 b=W77UABqEP0AsRazNUw8pXXqIEHhpyXNeFWpxmOewRZ6zilAfrKPBC6TMcgGRYONYGX
 TTNfit1d2PiRD0JvDh8vD9dcuNEtQQslWAYkhkQvUjzpG0B3OkS2s0sUJpG5s5ZOHyRM
 LTou8ctwq+W93Hclu4eMcdBcJzWHGVdH30Uvr2K9UtB5sd9cOSDJWNjTROewLYdysP5w
 /+2usQ5EDphmTh/EEo5EFmTNNvbYVWG3gobD8ha0fDU+ZNBSi+xcwEhOFjzCL+VQ2o1C
 iz0u+0kVfR4VvQyUe1iRyw04HMcs/MJf3R3SvJqC+Oq9Q3acbohG9tdSIm/LRvKMXqZv
 ND5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885457; x=1768490257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eq0kz31utv24Lw7pa6NdX3yKLpZshCxhpuDssWv6wlk=;
 b=WFvvbKdf78AqLPRYqOWeanTLadvabyrWoWiV44BpHxUB8b5CSaWHzojAt6y5GF9eo/
 1gJkwoIHCi+g3CeU5onzpmD/jNDDU92/yehqo02ZoGxYOTjsFh0jxx2HDmTWOxPxebhM
 ISh4cBVg3RrDM2ZhlfChhoxwHwOPEfYEcVkkq4MswtBZM/Psn4svTB6nycO/rXerpJ9t
 Jpu4s0Gv2QGid3CsnWsIDIRvXlkLF1WEsLz3ucHeRl9xlU4+fo6dxf3Fnrk7UH3LmCvs
 QrZrZCuqT1xveIvTQnmXJU+sn7aps9vLWwb1WvC+uzkZisUQWuMHYj+CY58epSb5+IgP
 rPqg==
X-Gm-Message-State: AOJu0YymoJ5bK/p7SV3wvivk3DUtHU6aKWcc5wB1OXX+keAH9IAOVVNI
 ndlMpoqoNrBfqC5FaSKMYOhzvAMG0hhQkfi7FAO7yH7UIIuti37Ybgf5WBuriCltivF5NtZVfar
 NEbXb8oZ+PQOJZYgEnkPUNuZHGhrud08smFlH3j6gkNA+b4unZjH7HsgN1/koI+0SK/8iadRCLu
 5giNTStGiaFzmslFzvP09Iu+7ISbNufvQ2wGZoQxA=
X-Gm-Gg: AY/fxX6GotMoTe8VA+EoZ+CShdpatiyHpSRrSctgnrj+uBPPchfDCd22FjZGjS6eEqv
 poTEXMnKw7hqzIoxy9fdg/MOXDhXVtDSew1hUYsXY0QuIaSiB/R6kNQkj00RbpodZVEIHoo9bwP
 HAnSnDQ/IGLagJ6pcEFh+bMEivCw3wBsxxyEHDpdm3D/HBvV4dfSMzASVZogwRGciqLgt9/QrHh
 P1YZICPOBnMQVwlXvH8n6eCxjbKsd8kiNh8ED85a+gvOTTJB8tV2v8kKYCXs0yoIUPhlcy46WEo
 W/oHGuZHEV5vChmMtZ+2QCGDZc0LKcTW152i6toKHuTcDohA/YtLlzkBN8TSPD7sPZ6ozApULy2
 7/YBJ4qzd0CoNBIF/8FLU2ecebjgrBRiFjwNBBmnjkXegOIhEz4CwGYbfNOa11oyDHB6OU1h6jm
 iZA/i47uObUil7SPNKH2Gz0NqDEpd4r2oofqYFc0+ETF5WSuOvgjl/puTnKMq5LqVaDA==
X-Google-Smtp-Source: AGHT+IF43WciaIix4zALWSPeVQS3T5PFovYvw2xK/yY3vpLq2GlnMlsdrUteZeoJvCozJcBofRPtgQ==
X-Received: by 2002:a05:6a00:1881:b0:81b:c9e4:91f7 with SMTP id
 d2e1a72fcca58-81bc9e493a6mr4657810b3a.43.1767885456816; 
 Thu, 08 Jan 2026 07:17:36 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:36 -0800 (PST)
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
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 13/18] disas/riscv: Add support of Zvfofp8min extension
Date: Thu,  8 Jan 2026 23:16:44 +0800
Message-ID: <20260108151650.16329-14-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42e.google.com
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
2.43.7


