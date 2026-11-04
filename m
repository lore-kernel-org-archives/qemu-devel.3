Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F46076086
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=UciwVdIx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtV-0003g0-S9; Wed, 04 Nov 2026 14:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtT-0003ew-PZ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:35 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtS-0002aJ-5w
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:35 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso2447277eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821413; x=1794426213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXahEjEZ59pFRWeQJKGqQMg/M7dhg8DontEO/dam/Uo=;
 b=UciwVdIximOQFTATbJTY8wImNcoT80d99cuwvMwwnVb+XUVz93kaGFS2h+TEJcbUv4
 rzQdmj95P1zOtaVXCEIuuCNw7KFFLmvTPjZ3OPtzlyryU+uUa87+EM8RW4BK+DpWxqTH
 OB0Pi3XV5yEfj3NcCWs+dKKfEzjzmYf7EPLQPisuUB5h2/3v9ZtGB5Xx3ezCFwoQIKjk
 oomf3wUSPY8Mu+F4AGFrDbs9vJAj1EYyBw9WogJrE28NATy6WEk1LNZkgAA58+zBkE4D
 ndLB2UzeC7n6MrozZLzTTvpIZcca79esj/PTySYK9gs7ayl2gk/jT4M4DUWYD44RkboP
 j2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821413; x=1794426213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SXahEjEZ59pFRWeQJKGqQMg/M7dhg8DontEO/dam/Uo=;
 b=RYAU2tmmdncMjNDbfTp4MtyqLbwz4r/idipS8ae1Qy9Ttkj6v1ZmdgL8ANYcCQxN8W
 JuC0PiOzCNKWrbhaAyDElWBXx6uzgbEpsL812u52r68sm6u0dGwWd7amkQZux80L+LCh
 GcggyJBQAOatxcTYFMoQACJnAqHA4qC5AeXQmJk2Ch80KasRC/F//hnI0MtBzzJeLQiu
 Nii30Yy7YNcuXCNg/TGdIjJFEnnWKKUBMPQhDd/pdS+rHPFphGPxv6lJIZVW19Qs30Fp
 wjCqtJEMzUoEwmWX7q9wKiXYtUp2IH2yePPDJ71OtUUdtoE60yL9Cv9r4d/E2YrkWNF+
 y0Pw==
X-Gm-Message-State: APuU4Z97CLVdT8Uo0slafoTGcU+2Cd/YQIZsDA8oHhN5NbFjlohJgXOb
 CmQkYsHvGza8qCyCF5ZivJIXN33EZzG3XRZxVBnuaiR2RZ7AlOE4i/5GCmFgji8wzKOwcTKJEWL
 DVK3oIa895NZyg1ro2LofOtHCcND0CRxkwY4EBgiDy8DAKPSmeHo2XgVemXW2sbfaiGyFVVJpl2
 ogkW0yiy9kq3VEW94Vfi6aHzXxuQLkATl2QRAKOrV0Bg==
X-Gm-Gg: AYBFou1WH3jKC2AcI05/5c+Va3yQa2MieklKv3nMwxdoKDdKNucBNgh1JBJzggfLzg6
 qFJZInL3EYJrRVC1aIa+6ELwZihO0sa0RYms//mF+kFELC9w9giXczeFw4Tlr8EzpAIEC0j4GqD
 Q0JmmYx1PiHsQJgB5bVrVqcYf8laBkRDSxDQXlG9WYuX46zmrgM5p4WCa/l68r/KWz5KEuP4fpZ
 tlW/8jx2yUzX8Rt1J5E0uWU/wQX5/jVi05etCXHQld04KZdnq/t2SAqy8LgcbUwR13OcSONhlhp
 LuDw3KMotnLwcl+9Pxs7OtsnW50+xsmLQ2FTcvuBLWZfmM92MUQLp11gB4SvlMOYH2itJ9w93eQ
 tX/z0//51Wa5zinBhWhT2mNl6VCXaDtUh1a+/WJ0kFcxuPVH1KZY8yMhP9eFMd5HnIu0xKlptX6
 fYJkvgsCfmeKklKMKYByYrvRcQp/3yxNfmuYRoAMUjXMhXfHR1OuX3I3vOXLA6cE4+zI/y18I2g
 a1M9wmWwfdem4Qgdwf/5BwO7NbLGxjSOCEGmgxnxJO5PXxeT/wru+YczXsViomRwW5P9bdJRElc
 Yqc72xgMVkiRy64tHkH6VF1NMg0xxwe+BD2Dfkrx6FeR5T7KNocl84nEnqHD4uodBwGMnfp1xRE
 4fXXdeAbCh96FRx7uqVDcKTgB35tZ
X-Received: by 2002:a05:7300:471a:b0:36a:2382:7dab with SMTP id
 5a478bee46e88-36a4232cda7mr23774790eec.6.1793821412509; 
 Wed, 04 Nov 2026 11:43:32 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:32 -0800 (PST)
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
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 24/38] target/riscv: Add implied rules for Zvqwbdota16i
 extension
Date: Thu,  5 Nov 2026 03:41:39 +0800
Message-ID: <20261104194155.679241-25-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132f.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add implied rules to enable the implied extensions of Zvqwbdota16i
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 99c82b898f0..95bba330e06 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2906,6 +2906,15 @@ static RISCVCPUImpliedExtsRule ZVQWBDOTA8I_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVQWBDOTA16I_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvqwbdota16i),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve64x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -3112,6 +3121,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVKS_IMPLIED,
     &ZVKSC_IMPLIED,
     &ZVKSG_IMPLIED,
+    &ZVQWBDOTA16I_IMPLIED,
     &ZVQWBDOTA8I_IMPLIED,
     &ZVQWDOTA16I_IMPLIED,
     &ZVQWDOTA8I_IMPLIED,
-- 
2.56.0


