Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B1606AB3E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=F3swSrwV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtH-0002xn-Fd; Wed, 04 Nov 2026 14:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgt8-0002mX-LH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:15 -0500
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgt6-0002Uc-0I
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:14 -0500
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso1854149eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821390; x=1794426190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s2G5pV6bLptE5tDsgdaE0ZHFNAhsh5E18iMfQgtM6s8=;
 b=F3swSrwV92DVq/aDU3UDcPYgbbjfJQJVXpxuFj1r6Upxc5k17NAMp8JFQOS5gA3WVy
 vlsYt9GoO4ykLfjghLVfdvlnueAGpOpVT7oqIssmZgq5ahz+t5zYBtAqcldl/AUFH8bX
 yeDswt9bZAxyEIn7CJ3H1cYPe4wQRlIbHX0SvSu1zQVbVpqwPXRPYhdkHc9tz59Qg4Ln
 DccmZDdDWD9y5R1NeB7xOYCiPJnzCGby0FLL1r2uSpqmv+ruxUg/iLDrU9jDQx4rsYCJ
 fAo8w5QySrIogbFJKubcm+5QuSbBT7l7QSMIIiW9eL1oDM/guhJYHkte7RC0uO4ODn5/
 4iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821390; x=1794426190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s2G5pV6bLptE5tDsgdaE0ZHFNAhsh5E18iMfQgtM6s8=;
 b=dPdNfI5uCQtfe9uCvW1ETmLLI9dW1f0quosvlqaqcOB6CyHPgD00nRv98gnvSYbdg4
 NNIv5epM0ixk3Jg7x3ZLRVhtRJI7jqCyGtnrDz9ECj45ra8d75chXOk6oGW8Rl+Drsb3
 8rOAOwi495a3ERLw0dXdABBaMCvHXePqpIwFge1l+7iKBEtNoXxYYEQZNpV0zW/7uy/Z
 ioZm/BMR3ZXY3pUom59lPBKNlF21/Y7F778jsw8ZC6zaHfgcdJSIIDPPUo/rp9OQqLUq
 Ryf1vcxOyn8eS2wPL82UA9aP2Uu7pDy2Orycs7m8o0gbQvVl4/JERMqYZN/YbUuNg2BB
 rTsA==
X-Gm-Message-State: APuU4Z96TlrCLEM06JCpnPEgLwZJXKaS7cx0M/5Go+H3rrxlFLwp9Knt
 C9j4hGwIg1pPIoymhZMwBmzPkDWcAwS9nVv+nIZXmrN5iWsFagipuY8aDF6Iby2z0L/dtF097df
 yNxUNArGIAVzr7+gI9KaTVLAKGP9YjXR+N9VMSnegqFLUX5LyK7ZmKJWIVs8Cz/5ZnN090WOhVf
 FnNC7xXNpxE5Dxdwx4RSl5Ty4gOJZjMiamf0pw4KexEg==
X-Gm-Gg: AYBFou2NUYyQRdbP/SueqTv5aJmoMA4Un7bj/GRmJPKHA794nBwTc8t2iNxA/+IGttK
 CKvsxFLxjlhANvKsAKO26yaMd/rHC04koTF288yvShmAHwcVvsgRfF1WFvtqT/p7rxN9EgBkyX8
 xSvSiC8qJvkSedoesmGiaKtS2UgQPOlzl9lnHU6i7WRoBuWEUO90CQ5FyTlw7xo8UiEo4xQnMD9
 UNce99RC7SqkAZIORU97zlKfPpY9vpbMdsarRIBHSXNm+GN+R6gDe9szOmE3pTrAeUUX4/AD8Nf
 11v3Vk7IxtJpg20jmq8vOyeZYV0Vm8O7QsjGZlQYXv7Qsgpw0bo1FV2/isBNeuwA4B9v+VCNjwU
 ygjvgZslFVMKDvKVjKw0UoLGXQ4xXmpH0iI3dqOemOIjBoUKDQLwlCE1a4P96jczVWd0gx6wTeL
 KThgfpyNN5QtqZOxGKJ0ExIkbDpzBMHbirvkyIMuhCSqmsil9EkeFwCCI3EYEihOIRwIWGP6HW2
 wGqyhhH5KomUFeeBqKPD37sJL70q/qK/Iq6VDehnVUytjFxm30wfGn6tho8PcyeNl8Rrr/GGn5G
 86/Wayq/WosFNm5WPKufP3bug4IMMIC5twJssd8AxLBCo6AfX9wXJ4Eb3469o+fpR+wcLYlwOUN
 5Fwf+V1g40hUfc5rpEPWOHunM/t0o0g==
X-Received: by 2002:a05:693c:87c6:10b0:367:5e31:ce29 with SMTP id
 5a478bee46e88-36a42404ab3mr26422168eec.20.1793821389970; 
 Wed, 04 Nov 2026 11:43:09 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:09 -0800 (PST)
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
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 18/38] disas/riscv: Support Zvfqwdota8f extension
Date: Thu,  5 Nov 2026 03:41:33 +0800
Message-ID: <20261104194155.679241-19-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds support to disassemble Zvfqwdota8f instructions.
- vfqwdota.vv
- vfqwdota.alt.vv

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv-op.c.inc | 2 ++
 disas/riscv.c        | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index aeb9423f130..5ba29f52976 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -583,6 +583,8 @@ OP(vfnmsac_vf, "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
 OP(vfnmsac_vv, "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
 OP(vfnmsub_vf, "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
 OP(vfnmsub_vv, "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfqwdota_alt_vv, "vfqwdota.alt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfqwdota_vv, "vfqwdota.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vfrdiv_vf, "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
 OP(vfrec7_v, "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2)
 OP(vfredmax_vs, "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
diff --git a/disas/riscv.c b/disas/riscv.c
index 62feb4c653e..0f609cc06b4 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2640,9 +2640,12 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 39: return &op_vqwdotas_vv;
                 }
             }
-            if (((inst >> 12) & 0b111) == 1 &&
-                ((inst >> 26) & 0b111111) == 36) {
-                return &op_vfwdota_vv;
+            if (((inst >> 12) & 0b111) == 1) {
+                switch ((inst >> 26) & 0b111111) {
+                case 36: return &op_vfwdota_vv;
+                case 38: return &op_vfqwdota_vv;
+                case 39: return &op_vfqwdota_alt_vv;
+                }
             }
             if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
                 switch ((inst >> 26) & 0b111111) {
-- 
2.56.0


