Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731FCD1D475
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrn8-0002b0-DX; Thu, 08 Jan 2026 10:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrls-0001O5-MA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:57 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlr-0003rh-7F
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:56 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso2559095b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885474; x=1768490274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zptjKe02yr8Uy+CgoibJ3oSutm+IPr1MnNC4Sa2a64Q=;
 b=AQBudgosU2qb34liYYzFd1m79qjjvadvs+TFYTiss8Xm49l0JSJK8sJ7Cn28mA4cj5
 AWjhGtYvU9ORNB7gi3zvDmDuDAgM1b8yLGBwTDIrcgX1Y42cWEo3dNXqzLJSkERNafjq
 KwjdYJHMrGKxGXH+0iN1SVrV1XNoavoPxYV74s/vLC8Zja5eTxU3AeFN5znLLKvv/DaC
 p5Biz6u3SI64bWbCqwPp53l9v8gJsi2ZjKGONFMZxzPXjFxKAv9M+VpCyPA/tGxdnIdc
 t42Fb7B0XEX7CArKTMCLbJbU4bdTt+Q3QfjqJ6e+gg9/gQjuf9/ToPL4Klt0/h8z52ox
 1n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885474; x=1768490274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zptjKe02yr8Uy+CgoibJ3oSutm+IPr1MnNC4Sa2a64Q=;
 b=tYP2TPnm+Z53nKO+fl+2hMSVzKKpQtS02h22tAum0VydW7w8cBVqPLu9o+tGlk/1Rd
 VwpvPglDz5up4hULWN5/pcGmoi5voOOpwF3mIhybLa6dCfjAosLLML94B8gPjnhUSk/S
 0a8XNSn/3nXCbWCvCmJfVABcnwAzV/ZOy++XqumLd638lIGqNX55U2jssZccY4pT0Kje
 3GYS3g4QxDpMz0xABSibGwdXEmMUubTWu6D5xJ7yvOSRFtaOBgFbz/up3T5o0ppCsw9u
 DGS26ufZvR1kwCfzjvZNlbJyMXcTrKQHCebadhEFwh+OirjAuK4vRN1tLIIPFEK1buWz
 8pjw==
X-Gm-Message-State: AOJu0YzbiyzltiAN76PHldtprQTedX+SyTiOwnXKOHy6xktbfmzc8Q3E
 ImXEz9Vz8iwXefdZBbn25/hOgdDE76EtISqoX2eCDxwiUsU4bZH5cno5WiNDOOTDvBvFSm8b3cs
 Amppx6FF81VmexI/+6SR7bbldSapdbvg1iVj9N/vJ+OGWggtRXnV7qvXbJ0L3NSOHw9KzW4+Z/6
 8whGo3uYO883L8kHRcAUI80KtuYcxoIsxCItBqA0Y=
X-Gm-Gg: AY/fxX7cD2fs6aVSMUm2vojMo+TRh4OEPIXv2lVi+YAujZVUOKd5PN+Zta70Qr0gY+G
 ihevXBg8z5i7NG3jRgiERE6R7PN8N/vQeCb01IUYI1PmbGrcLFWjKVB1Yrhsd5rSmy8poPwoFj1
 cttu+ldgj7bSxtVwF/1JT9i9pE/BP1fhVc4zGVMBX7eVn6DzwC+ryX/cTNbMAMgI6I9hXXrfR6F
 UGAT4I3Wn5oNsJjRAoSUrBDl3Vc3CP+HHgDKTx3nh03CsVGpkfHbWp+BhXx2UA69/waRk+W3Gig
 3SfeW92Z3VEeU0tQmj/UNnxTjg04N25EuzE4tX3hBmGQ/BgFpZBcCDCJ+eUtbPp1L1zVVimLnsy
 oedx5dHK1hD8lV8sFnhWKicgpnxXouGk247bmQp+CXmPUvARKzyE0DVaV1R8pGp4zQ7rIQcN1aY
 gPUSN3h00/3GB8bx9iBwRrG37nYDp4Q2suzAYZMRXj8ssR4MhACtrrlHc=
X-Google-Smtp-Source: AGHT+IFwSAUore8O5om9V9bxYc2SOUmSVBnxJbopKUyQetMzVUcPJb8cKr9jwKD2X7Y19GdrYCG3vQ==
X-Received: by 2002:a05:6a00:8d8c:b0:7ad:4136:946b with SMTP id
 d2e1a72fcca58-81b7e156b9fmr5418497b3a.28.1767885473746; 
 Thu, 08 Jan 2026 07:17:53 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:53 -0800 (PST)
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
Subject: [PATCH 18/18] disas/riscv: Add support of Zvfofp4min extension
Date: Thu,  8 Jan 2026 23:16:49 +0800
Message-ID: <20260108151650.16329-19-max.chou@sifive.com>
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
2.43.7


