Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBABD5AE5A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8tr6-0006E6-Kl; Wed, 06 Nov 2024 23:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tr0-0006DA-ON
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:43 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqx-0004yc-No
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:42 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso5530305ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952638; x=1731557438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OVUWWYTa0NKHAvdg4I8AkMOGiy68upct5dHn8LNb0Q=;
 b=Lpq+dFqJMPWySeR1ubhymx/Pdrf06BmsI2jUbTqYjswVO2aeSIJBjL9iqYv0WnHJf3
 64/oX2oBLiBRLhkTWuWkNsn0FgAwDNmMjJTDSgEw4LCb7HBcwsnaev3Yg7mpBlz3UzcK
 +mmwGHvTZeWMjqjuVuEh60VZW66mRTyCEyRgnmGCD1rREmb7fZ7sN21m0Dm+0zbNVtIj
 O99RvTA1BrcFAKOlqsQ+Qo/hjWXl5q8xk1YmIvMTpOXT3hfhg2yz6uO6yUAl5dR4VH8J
 CpoGWzBdwcKRBRrSFPwEtVcAyoev+M88cw/VnVoJQCutSKZ1vwxuP+alNYF12Y0fXWAW
 NKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952638; x=1731557438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OVUWWYTa0NKHAvdg4I8AkMOGiy68upct5dHn8LNb0Q=;
 b=UIN8ngnmHmPAjMq+B8XnvZo/LuP75j77OJwUXNz1hDrrrkQ8YtVW12snJh+YpFRgCn
 R5Y/eaewudhnx2PiFDm7UiPS9yivOfZ33UMXke/wRS2adGRKgvMkrpZlv+sa349aEQzm
 e8krFZkVLKLSDlObGb48khIekcfxxiK5bpNo7bXQGwlAtHO3XhoEWiX1x+0unr5sFwip
 ru2+93Y528GGdLmf9tceTtwWO1CNjKSaJKmq9puGJ5h7qT4/9kcrwYMVmt9nkuh0ZEmr
 ccIygL7MauP6rhdAWtfiqossEVFAPoRR+fUFXCM/AXLGI7q2AqKRYc6iPXR742moVcw8
 De6Q==
X-Gm-Message-State: AOJu0YzGMfqbMvQAdibpFNAQUapMO+CrDFn4FiaF+E/Fv/J50vl6d+dB
 Q/Ad6L95SLMLG2ORZK1Hrqc+K5bWdnyHZjO/SyVaZGEIzwrkj27eqA/31A==
X-Google-Smtp-Source: AGHT+IESrTLBjfjlsmwT5Mwqxsai/EgRym8tMyNUxLgASNvGqtewLyKbdTSokNldcGxMTJyoyuwXrQ==
X-Received: by 2002:a17:902:d2c1:b0:211:6b37:7e66 with SMTP id
 d9443c01a7336-2116b37879amr70392065ad.17.1730952638110; 
 Wed, 06 Nov 2024 20:10:38 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/12] target/riscv: Set vdata.vm field for vector load/store
 whole register instructions
Date: Thu,  7 Nov 2024 14:10:08 +1000
Message-ID: <20241107041016.40800-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

The vm field of the vector load/store whole register instruction's
encoding is 1.
The helper function of the vector load/store whole register instructions
may need the vdata.vm field to do some optimizations.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240918171412.150107-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index f8928c44a8..b9883a5d32 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -770,6 +770,7 @@ static bool ld_us_mask_op(DisasContext *s, arg_vlm_v *a, uint8_t eew)
     /* Mask destination register are always tail-agnostic */
     data = FIELD_DP32(data, VDATA, VTA, s->cfg_vta_all_1s);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
 }
 
@@ -787,6 +788,7 @@ static bool st_us_mask_op(DisasContext *s, arg_vsm_v *a, uint8_t eew)
     /* EMUL = 1, NFIELDS = 1 */
     data = FIELD_DP32(data, VDATA, LMUL, 0);
     data = FIELD_DP32(data, VDATA, NF, 1);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
 }
 
@@ -1106,6 +1108,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
     TCGv_i32 desc;
 
     uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
+    data = FIELD_DP32(data, VDATA, VM, 1);
     dest = tcg_temp_new_ptr();
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
-- 
2.47.0


