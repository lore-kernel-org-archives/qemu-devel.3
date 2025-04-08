Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08942C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26Nj-0005HY-Qx; Tue, 08 Apr 2025 06:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NF-00057A-F3
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26ND-0008LY-91
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:09 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso7225857b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744108805; x=1744713605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkVjdjYouLt5XGZ94m+TBwvBpvU6v1qXWy64GPxIew0=;
 b=UXVRndReYqZBQ0yO7mrDKLJOoHSHK4ruq73Axs2NcmuXXHPkhSx0nNeNz877MNKqe+
 NJ/E5syEyGdiQr40z9K7KSRmo1rtUU9XC5bZRY+fA7i5LBZl+IYJ+mlMDIsacdhlYnDy
 p0zM4vQgH4k9f8KfFXzXz07n73yoNKth7V11X3+r0vHKSxgMfr0FpEZW0Rg5UTuKr97s
 T2Whhvorm5OLkTLKhefcSSCNtrhu44E53lmeBB8RRSfkgmMaYdEh9Z/frUcOA+nnxTyo
 c/dxxDqcPi3zNcV+XW3DjtNnGDdP3sQPJrEJ/7oKMvyvEW+zLh54hqzN+s+I3c1XfodR
 kXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108805; x=1744713605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkVjdjYouLt5XGZ94m+TBwvBpvU6v1qXWy64GPxIew0=;
 b=Z7zxYmGji931G/BSyzjvc4cYV8daKZaMNkqDc4tMGrkTbDMPE6fQpW0mu72VViYHtO
 Auq98XJlP9Nb979GxSCEu3yvRQUOfR/289VwITRt166Wn7sUhdsnp2L64wzACgpJNSVa
 dvDXFsDILoMexNGRcvUzjnK3BzqHCudusrsyZ9gtGIHq6cwxp5MuAnRFCoMNAmerjZSf
 E2662y/YPPAvo+H5FVJe3UWn1hI8y2yTN36uEvek6MkePgR1oKZHO9KIEdjISD99e1gA
 6DIro+a3lA1iLhACGQcnl6IGYQJYugbc4PAuG06hcs2+5SecE3OMozitEFoHOkNLTCNH
 Y78Q==
X-Gm-Message-State: AOJu0Yw9+71wHTyhIn7J+hL8Nefj+xRi59JORS8fZVDFM57BGUynKkIH
 X4RxQmVJMFeVtfoFmq8gzFUUC05c32rENgwZMMNDo61XIAliEbeMF7jfTVPQqOj5x70MyFmY5M8
 PNpaIr3yL5NGMTlVDPW+XvXr9l25uPVoQ0OckvMoyScMZLdJOWuA6jaw3YJI3aKsleTEV+7A7sR
 3XbQrnlYqg71XjJ5hRwIcbRyoJJZG+q+SLzDBBrZs2
X-Gm-Gg: ASbGncvW4Ud1SevLSuFkysyD5ZdMFSTrdgwblirlMtmnVjUxIwTLZ8BZSVAzAcP1x5p
 g9ytOXQGBSXfhydA3GF3UhEjhknBmv7fzaTVg/91YQeOJdPMh6NFj2yxkCyaVy2CeZoYPLU7zpt
 YGsfrkQYVz3R5+rx9nEvayJ5emZWK1UY32dULf/GPMfumJosV+8akHR/VvkcZUzSNpruWVuRLGX
 luYJbPrx5u2bkYZ97312+Rk6tPZdrcuVVrRhRAI8tbPKbWNYvvx3S9CHxh2bEJPlD4NM9VV90s5
 WgjKq52PuicjZx40WQf5MTOQibcdyDfD/Z92TZcy2PGpqxcQaRs1wlMObRM7SdMzua0ktz4uuoi
 CFdyShJoeKfuvvQ==
X-Google-Smtp-Source: AGHT+IE1v3wkxPvJyV1AY7Ov4Dh+CH2AOgmY4x8m5ZA8nW85qyLmy3sEe6aJzfRZtH1R9NnWxO94iw==
X-Received: by 2002:a05:6a21:6da4:b0:1f5:92ac:d6b7 with SMTP id
 adf61e73a8af0-2010458ccd9mr23483033637.4.1744108804676; 
 Tue, 08 Apr 2025 03:40:04 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e3734sm10532380b3a.179.2025.04.08.03.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 03:40:04 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 05/10] target/riscv: rvv: Apply vext_check_input_eew to
 OPIVV/OPFVV(vext_check_sss) instructions
Date: Tue,  8 Apr 2025 18:39:33 +0800
Message-ID: <20250408103938.3623486-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408103938.3623486-1-max.chou@sifive.com>
References: <20250408103938.3623486-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
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

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index e8197f779e0..2a4bededd1e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -432,6 +432,7 @@ static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_sss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ss(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew, vm) &&
            require_align(vs1, s->lmul);
 }
 
-- 
2.43.0


