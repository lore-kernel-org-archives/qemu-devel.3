Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7F606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IKGJCJV8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2He-0005Cp-PZ; Thu, 05 Nov 2026 13:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2HM-000588-AB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:33:43 -0500
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2HG-0007fD-Mi
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:33:37 -0500
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-36a0f27c9f4so4147278eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793903613; x=1794508413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oy5DoHzhJBLmB2vbo8S3/BszoXn1nmgmNWYhTGzcVGU=;
 b=IKGJCJV8zd+BOmOCz69DYR+QHYWdddqGkCMgBr/Nx6i9wwcBml1vTplPqtZuVE40lJ
 qdfTx5R5uW/G2fLo4Nbo6tq0Xbd4iqy/fU581IbmkxLye06wReA4Ab/f8KEJQDXiscb7
 pIe4ygS4D7VfeSc6saBN7sfpDrnGF2az+4HTN4BCV4j4YU5ZgJTRldIE4+CrCYYF5Lm1
 mudTrbeySyguBr/Rv89aelo20y9fA/YzDKamzmZMLRFnyk04VBl+1uyawuQPMfzqbzL0
 1DRDbrGw1Bcebhsu07184N3GF+2LR8/OJr5k/YPQYqsuFzXyYZR9ZyvQ4zA50yUd3S64
 aNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903613; x=1794508413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oy5DoHzhJBLmB2vbo8S3/BszoXn1nmgmNWYhTGzcVGU=;
 b=eIp6vPbXZe0er3xm37KGLwWZe5Hess6osWn15HvS33UKzl9isT3X7UPDII7QKe8tPp
 Ml2aa/3mI2MSYHRZX7wSkwMW1Eh4DF2RSReUNSV5RTVnD1w2f9xnPYfFPSH1Nh+hy5yI
 7FLfiO27dlUI1lVNRtx5100GRaAovI/xktKG1ZeTeTYJiTXeshr5Fxzh2HtQuA0FAD6m
 +KjZ06j1ilbVjpHRmRCHfxW/2C7vQVk03Ewd+b+/daBrHzT6Jq3vMcAa5ljLL+PG4rTD
 cAoufgDpzGDdwhY+eGvBQC993cC58IBhuI8EDzO2GvljCKokld+0qd7aNUtAoZuA1BR5
 9M9A==
X-Gm-Message-State: APuU4Z9P81vO2ZGnCMdUNheo21q5/SuWWiyqlPU5JBx4RZSQkeBC7TFy
 JbdW1iBgLYVbl0z0nYwSnis9cB7t0sRtO1CMQl7ZGjHP1C3a7RxyJ30tgzrRV2LqZD8=
X-Gm-Gg: AYBFou204LDipl58jaRHGvCTJ4VLbOIQvrsi0lMWh5B8q77+7Wyq1lMf5HYeaKHA+jr
 UB+qp8p/hGOXhNNdICev4PATZYBdoQ+dBUlFQQbjRwj8TYzPZvSClerTpqO5ktPL9xvzmYT1W9x
 XZrMnB2MAbkG6yBr89CZ5ctHSHM5SsxXuY8UBnuojfprzKm3GeQH11TQm1I1BNmBjt5QKTAVH43
 ZwImv9SIKe79PMoNTkhXHItUGvEfN9svLbgj72HUMU/ng/8c0BrEwNBXQ/Csg/Hzak90nB/PyfU
 +zMo0ewderyzdQcXlv+u/HF9XQvHQIDvg7vO84dd0MdcufQOve6xtsEZ0kPtuVWQc5nKk7F4aU9
 2CxWyN4U1yAygymPiulqnZuWP8Iqwzy4NK/rtD+poksYE1qE7z4nv5KANm94TmMNFRPDi7mznBf
 bN361+42UJ0e1/Dp7tTAkf5CaCh/IfDDV9HDJjlN4rVx1C8IkK8ivwIdJaRenYj2aMsjCTIakqp
 mykn/baD2R/tCjx7AP1KxgEhcXDQ18JU04Xz2RP2YiS8AbpXGYOd/9ZKe32r7tv+rhchs2Ll0xT
 fDbhgoavi9QkdZDXMOXYFXkpuDHas7XtAlUGlfN4Pb6tp/vVoPXYjlanrNZyrAz0fXXDtQ==
X-Received: by 2002:a05:693c:69cf:b0:369:daea:812a with SMTP id
 5a478bee46e88-36a423fae73mr27075385eec.30.1793903613090; 
 Thu, 05 Nov 2026 10:33:33 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36f66086a4asm277795eec.0.2026.11.05.10.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:33:31 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v4 2/3] Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu
 to riscv targets"
Date: Fri,  6 Nov 2026 02:33:08 +0800
Message-ID: <20261105183310.1614-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105183310.1614-1-luoyonggang@gmail.com>
References: <20261105183310.1614-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is redundant now as all accel-$cpu_type parent is already registered.

This reverts commit 2d3e6b4003d5380c245ce8ffac4b8866f6d10a33.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5beb602338..aa28098e10 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -27,7 +27,6 @@
 #include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "qemu/target-info.h"
 #include "qapi/visitor.h"
 #include "system/system.h"
 #include "system/kvm.h"
@@ -2241,7 +2240,6 @@ static const TypeInfo kvm_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = kvm_cpu_accel_class_init,
-    .is_available = target_base_riscv,
     .abstract = true,
 };
 static void kvm_cpu_accel_register_types(void)
-- 
2.55.0.windows.3


