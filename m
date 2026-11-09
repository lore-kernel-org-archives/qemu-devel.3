Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF5606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qRNS5eMq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXu9-0005Nt-4Z; Mon, 09 Nov 2026 17:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtz-0005Gv-39
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:48 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtx-0003wp-4j
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:46 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8b271e573adso534123b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263503; x=1794868303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kH8pQhkREIU74SHtQ57ILotvinGHdRLLkwynIXqi/JI=;
 b=qRNS5eMq+0NpOmb7dk5aJCcPiY+T/mcTokweZIlHUCyBNRMDvhACVvBDjgU8OYGj/7
 hpbIsiXIIODyC7rqOIZwOq/+wL8/ymFMg/5z6+evH/HrGNJMwFlCys38K/PW+lNRgXnB
 El6pc0ozZE/+RvsSMcxHUsotJ9/XmoViUQLo/OJ/EnvRX0K7JocKzQFUPONyWYeIfYAO
 XCRxaRJdD0X8rVl4/AbckcNleezDQkDj65f8a2yGkHynfUYKrMjm1iuVOq5DB2XQMKd/
 D/3WBKXtbS6tfCctyDd/IBZKW7IAYRLe9h9RGE7TSMxElmlcxRXL6rLsULFg6sILzuBW
 HIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263503; x=1794868303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kH8pQhkREIU74SHtQ57ILotvinGHdRLLkwynIXqi/JI=;
 b=TT3BHuRcEmbORiecrJL6dGoJIVNvYwDoo2V7jHWtHXnEz5brzHz5efORgvFbq854P/
 9SoY8qLk7+d+hOcYTTWy+YVpiM32ioFxdB+OciFmRpCwhDYdeIJxZj7OFihZZmXG7se4
 jsOpKcwoGnmzd5ibWjGqy+sDz7ScdUK0esrX+oojWkAbVED2YMtt+3AdY2Av9BKP49bc
 BW05DRd9MicecdiZodVq4E1wK9kBIsBEKO5y323qLtnZzc99L8+Ep1vs2znHlmHfS9C8
 Df3K9pNOFw8j0668eM40MUtc8r3PzLDlIpyPURcs09273622xgi5JJhjQFaWa9lyIWsB
 xcCg==
X-Gm-Message-State: APuU4Z8nUW7HYZmSIYMzL2ZesTCYlMxtUHWn8FAyLjbefy829PbjZQjk
 BDmFEE7blKv3CXKcL2sAurSGUaIeU7KVolT7XaCmTsdZ+DCowGkjHPNRRn6iYY2UpyM=
X-Gm-Gg: AYBFou3UpJbuseB0eJfpfw4XUxdWEz8/ZT/N/5sX96N5AuRyq2kXEUuaqBo0b4n/5+/
 LRNascHzegij5Oc6CaBMVbOTviGvvPobkNVlsAVGD0FzZrWk01gaRTrdskGtzYUxTRvfKoPuP6c
 DuoL5v6O2iHjUXcspVZLc/+LJ2N5W02NmwKUGBWGI6y0KmceaDvj6PNn86Lg5DIjLmBse5A2Wi3
 NVwJygxf5AfELe/+7uWnBECEMdXnvkjjLaEWinRXuBSmTpKdCYLIemiCQPkRjWpRPHbIDruPgNt
 aiMORmXNNVyakn3GV2VOgxUZtQhjguoSdpPRGZ0jD6wRvJABrITGoEG/FcWaMbUMkilqPS9g3rq
 KZ5QxnBFaO5YcvETx82vRUwD9F7cnzthXNyJqUCOzhjO2083+8p9V/yI39fiYXatxActkJuFwQ3
 Fx/mtdGVuPBE7mHYJ4N+wpiYxPu3JvOqfQbgpW/LSEVNh6/YgNUKJ5kB+9+6o7Cu3mCGfDyxb9a
 E80U10+2o9Oe/0xBLY0sJd1QBhVTvTkZv2CJd3YVagA4rDVHl+DRyTw8Ik5EH6guERZn4yLL5Wt
 qLhtDBw6CTyWbrO+eRPsDfvfQmRfZGTOOwXiJwULqn9HmdRXBVeQow==
X-Received: by 2002:a05:6a21:828c:b0:3e1:1eca:2214 with SMTP id
 adf61e73a8af0-3f18f2ae577mr556848637.49.1794263503236; 
 Mon, 09 Nov 2026 14:31:43 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:42 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 16/23] hw/arm/virt: Reserve one bit of guest physical
 address for RME
Date: Mon,  9 Nov 2026 16:31:03 -0600
Message-ID: <20261109223110.1619504-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x435.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 349257f53f2d..9dd89f39a044 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4062,14 +4062,24 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
+    if (vm_type == KVM_VM_TYPE_ARM_REALM) {
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
@@ -4078,11 +4088,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
         requested_pa_size = 32;
     }
 
-    if (requested_pa_size > max_vm_pa_size) {
+    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
-                     requested_pa_size, max_vm_pa_size);
+                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
         return -1;
     }
     /*
-- 
2.53.0


