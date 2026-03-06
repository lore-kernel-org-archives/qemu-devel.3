Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D36FCB60B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfs-0006GC-Tj; Fri, 06 Mar 2026 10:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfG-0004hZ-Hp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfE-0002mZ-AH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:29 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48370174e18so56791345e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809227; x=1773414027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=656Y4fgWZBIz7MCPHMdodfP7tX0ZKv/MbjEqiaHF7H4=;
 b=trdr8B5UgOQc7TIdFTwAq0x9E2ORY4b3O1eqQQtzko4Pg4O06f6MTQXhBLzQP99PgX
 MrF5gOghiRdRrVjV2O+9oMvnJReiXJJesGvxPmSAHm2NBgnqjD8r3Opm4+VZjiCmh7Cj
 oLdVHe4qDktWv8H/rEwBbiUaycihjDl3qK5k/nVYDUd49IkQSEbNjY/BVzRUooqlbmHS
 MpRUgg5l/jPqgc/FXLiAb4kfIA3737M6K9P8xduu0T+fNXnAvlHH06hVpWpB/9bQHPfy
 jiYTWw0GLgj3NdmhP2GLrnd+BUTqKkzj6pCIhgVGXXNf+J1fofx4BVkLHunvnCdrh8Jb
 68OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809227; x=1773414027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=656Y4fgWZBIz7MCPHMdodfP7tX0ZKv/MbjEqiaHF7H4=;
 b=lWRWtDOiYK+G8ZPSuBzcoJepEn+pRgFCt60kjjCPdBTOxXUOmAfBaAnRep/G2vbQ9v
 65AdXediMQiwAlo1IKjgvL6APpeZhS3qw8d3aZ+Xwyy1Vk4/R8faeKFuqhxkEvkrK5Pc
 tVgWKDGikoeh0qLK386BvZM+WOVhHqRfLyc3YUILhKOjQDsiWN+jK7yluMeeNtpHsSkv
 /qMQBLsemNlRoEPIXFXiSVUkERWGrNPjuIapck8VwtGGgr8KnPOU2bFKlmmOEUZGXZy7
 S5/9u1lEogJlnV/Z48TJrgl5zglpPMFA5JPIGCH521Avgq6a1/7xXquTkAQ6S+YI6Dzt
 GoMw==
X-Gm-Message-State: AOJu0Yyd6uDUgm1W018BAZ9P+wCQQ+hmES3cvBhGVkipoO2qp6+h3Yrm
 2qSxWyfA0HMCBrnt9kdXQs9e9UUGuBz0Y8V2dsNdBFm34an5WrXLVQJC/mTltTaZgdh+FMMr5Xn
 dcZU6
X-Gm-Gg: ATEYQzwyl14nqrgpckcNFqt/USEpnhCISdEaiieujJaqL6libdaIjKB/bra/of5Lmh9
 c5LKbFpShzmyfNdCuNt+iRs4Ude04K3MKl8d14zBOh4kYDMK2HYsaRtazzj1laIQ8FpvgLxAV02
 yzigfwJ0p5pkcjIUHtDgpR1QpkcYLcSRPGBalmClautJX/Qrcjf3D1gMZ8n96hNF/qoPpViBPJh
 r3NIGe1FlOTZt5srlmMNeF21BuJJwy6jnt/KphjqtbrZca8vlrMga1Ah3uyW5sw3vk2rpJDCAHW
 w3e5Ae6Lbeyw4oUGLq9HSZrvfWYkkQDfS4ygU4ekmLCZWYQSIIjpXu/UhtPez9sfp9V/PWAj57i
 Cjw+9kubNMc66S5aytDvKLlUebBGmzSNob+K11IwGvmz/cOUu76BhiTJwCzwZjUOphu3+1xggUJ
 iLQYJByA6xo8S/tvIAkz1H59VZN/LdIgggMN/O7OlUmjS2s8ZOL633B2gLzxbyjSeCfSDXqPQHU
 9dTORMECwg0pjOaVBjEIPF6YhcOh5U=
X-Received: by 2002:a05:600c:a12:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-48526966b07mr37665545e9.25.1772809226623; 
 Fri, 06 Mar 2026 07:00:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/49] target/arm: hvf: instantiate GIC early
Date: Fri,  6 Mar 2026 14:59:30 +0000
Message-ID: <20260306145939.2162189-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-9-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..1c45125036 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,22 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     chosen_ipa_bit_size = pa_range;
 
     ret = hv_vm_create(config);
+    if (hvf_irqchip_in_kernel()) {
+        /*
+         * Instantiate GIC.
+         * This must be done prior to the creation of any vCPU
+         * but past hv_vm_create()
+         */
+        hv_gic_config_t cfg = hv_gic_config_create();
+        hv_gic_config_set_distributor_base(cfg, 0x08000000);
+        hv_gic_config_set_redistributor_base(cfg, 0x080A0000);
+        hv_return_t err = hv_gic_create(cfg);
+        if (err != HV_SUCCESS) {
+            error_report("error creating platform VGIC");
+            goto cleanup;
+        }
+        os_release(cfg);
+    }
 
 cleanup:
     os_release(config);
-- 
2.43.0


