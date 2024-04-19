Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A738CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqfH-0001aR-Ng; Fri, 19 Apr 2024 12:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqec-00018L-QE
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-00016R-Rf
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-346b09d474dso2032823f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542391; x=1714147191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGSOG2AohVyB+YklCc4A6nr7dY+0+hbY8R/nFstjWpI=;
 b=l2+0XBA/G2YDY3NTWoz+FL2Wn3d+k+kuN++ZJqy+mJIbJKNpd8B7vOX6e0SkeQTQEo
 Ik7J+1/FPJvtVQ0c0NXF8A6vp6OkgzTrj4uH/QjPkSa/iCdHGE96PyK+Q1ANgi7cQdHR
 ym9U4SG9o+D3ExNx2I4kfEqAe8vqkjeidH7N9G8Ddei5VMQFXW6rwwZ+lkkp2NVVHzzw
 ap1vMGYq0qjB9ZxGMQjaWNoaQzZzBQokc5u1mh5cKHgsx1SxPtw+QQFmrCwVz6wUMYTQ
 a0NIsppr5sTFp0rL7v7Q3UEdzxMczQ1HJR2BQ9Ik7DWm+48LwJI0esv9epMkqAfGYtnp
 ziiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542391; x=1714147191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGSOG2AohVyB+YklCc4A6nr7dY+0+hbY8R/nFstjWpI=;
 b=W2Ikrq6mS3gvKgsIszq7vWGbBqz6L/i3pjXZ5lQV7lfFUp6nK0xRlqp24xPv8DOWYa
 3NiG7hCFCzcVYlsvs/NHfjZuQCyvTcpS/2Omb0cfRCpghiERurQXvCPJZBzXl/leMxrp
 89P+atbSKiTwM7vvIwP7HNLd8h9bn2EdsLRZqBowEyj5tqyHtacd5KTowElQTGtAFfg0
 Vn9GRy6c0X6uNhukQy+T29I7xjMZlpQC8VbRfZwScLEz04D5hGoPuBvi9W86BcRd3e00
 fZu1txkNltDft8zMS+iOJPZ1yvAMhSb31q8z5zB8ZRuf5e3dlY5rtPlDh8MrEJoBWvRo
 Nteg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Heqj9JVYh17U5w/2lztWm51tJfOzmPnBXyJzYoc/TFq7nhO95yPjHYBoiy7+hqi9p5rmXcOPJ15NHCv2aw00iSI3aYE=
X-Gm-Message-State: AOJu0Yw3D3WGZox7gUnU6ZYfO3Hc8d/SbySK0dKib/swoDL3D3UYPdb3
 nGgxl64etStrisjjc173OuRzWUtzTDC0/Lvi1Vzb+U7V0nf4jXMzQ2ZKi8dTbRU=
X-Google-Smtp-Source: AGHT+IFXWXZ2doR638dGx4gpYpEI6Czh03A8U4tqNaQVQjbA9rRJGDe2do9bDxtdVxSSCJ0+axOIjQ==
X-Received: by 2002:a5d:4f90:0:b0:347:4484:4498 with SMTP id
 d16-20020a5d4f90000000b0034744844498mr1910461wru.59.1713542391579; 
 Fri, 19 Apr 2024 08:59:51 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:51 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 07/22] hw/arm/virt: Reserve one bit of guest-physical
 address for RME
Date: Fri, 19 Apr 2024 16:56:55 +0100
Message-ID: <20240419155709.318866-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42b.google.com
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: separate patch
---
 hw/arm/virt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f300f100b5..eca9a96b5a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2939,14 +2939,24 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int rme_vm_type = kvm_arm_rme_vm_type(ms);
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
+    if (rme_vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
 
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
-- 
2.44.0


