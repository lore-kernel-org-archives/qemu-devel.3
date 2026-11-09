Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D4606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lX78nxXZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXuI-0005Xp-3d; Mon, 09 Nov 2026 17:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtv-0005GZ-UM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:48 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtu-0003vh-8E
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:43 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8a9f9473029so1101639b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263501; x=1794868301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gfp51PLlf67b5A5in6MUJzCYhyc5cgtldNZyxdvH6Ec=;
 b=lX78nxXZBuqeHtdPrhcPx8jLCUoBrzN2pByRvFH+P0aLhdSKS+kmXBYLfvRjypuD5U
 fPefQFFhC7QASJD9YvBntrtKpGVMtxsgsQF2ybpSR6Urm3zV7QC7EoFRPOF41t+7nrgS
 I0USPuBoGdpCAUByWRsKfNl8IjNXz7USR0Hl6p8DdKm0BAagI0HGFmFK537SXAkSTRFF
 LjOdOEVES/V9IixMERrn5nVrMedJn5VRpMn24elRH/yMjNIx47q6UhlGfGvBNBhaAX99
 WfBx/Q+pzvMuZ7RXUjITv+kp4HiXRfgklMdfWZn0eXveFy9Rrybd3lPgDe22d0RxUszN
 ciFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263501; x=1794868301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gfp51PLlf67b5A5in6MUJzCYhyc5cgtldNZyxdvH6Ec=;
 b=JpRTcJFeKEpqI6yE7F7c7xh5YocKpwIjGyYKzxPRQmGlWSFlBqh0FGF1fwQ61IKpF1
 yGrPjmAML6wsiiCD6XIMPABLUhui5mxjwdCHRJSyyeNp4m6puuircpTh1zxd50YuyhSb
 iTMrlYoZzSFahQ4O1oyec5x7lbhWEByDYCsbJrJTSMWER5WFo/Eqb/soCv3SvZYAqBfK
 Boq41oaEWc6aDEAUu/RIngfQLfhAt1cecZ4sMZvKqd0w8quekSCB7siA5mljCEgx5G1D
 k+DASuI2pU9FaG0zGuXcGMWUiNRKsUsZoM+GWkF2S+KAOrHdqlscWXsaY9Syq0apBQUa
 24Uw==
X-Gm-Message-State: APuU4Z853Cq6oPHeU/ZFpMN3qxIWH7B2r9T+U2VQNTr3kL03dnrfdXNK
 bIXvQSsIa+HNg2fcZwv/5lZ3x8vYNOmXhRgNeOOeIvsMhNVeXVwG82svIjmR6PThgpU=
X-Gm-Gg: AYBFou3PnPbZhfIPN//o2P7yCK6KkYi3dGdFtA09HYJych7IZw+72JgT6y7DLYrd6Ap
 7TAl3nTiADHfQpNUeJRsoM0ok5oRLJowTR8KwfeiHGHkH0jLI08sOjW16ASHwyM7kMd49MVNxUV
 LVyiQuXf0P4zVWDi3c3YTjLwqQiRB72EfJEDPsAKVu0moXU8fIn/P784pIPbBCmwnUZLLJB4sDD
 cJQhZNGSjxCy8Kn7im3PVDcaV0xHfjCpLSFTLFCsQwdp8rr1u+cDsVgJDTG/oI+elX4stFH2XOP
 YXUudhwr3xG3JRc0o0fOrpBrIZKCD+ahDw0KoloaMikFajO1oAjaOjW8+6k3NMrIyVNihqYh5XA
 mUsEhgfqJqqoBUGscMGNDC2YOf2HsPEkVRHM7YwmMgUxRxhV80Y5UwTjowz2Ka5+bXMioMSv9hQ
 VJ5jQRbAJ3N4yjrRcvPw+ddLUyOl3g5tno5f2YpeIh23ufcKq7NbivLsJDxydGiwBlcJAXE0GLQ
 1uMhtwZec7sFg+IPi0G060J3sfRUYwUujRSNOQcYkA9t4A1X1gPoUlsLDmSU/+lYG15Fdn6a12F
 PZihwaHH+pO6aVXoGXJ9bfnW2FsxeUlnxvoyNbcLyLzEpW9U5c0/3w==
X-Received: by 2002:a05:6a00:951c:b0:8b5:f313:9f40 with SMTP id
 d2e1a72fcca58-8ba87e0a5cfmr993721b3a.49.1794263500868; 
 Mon, 09 Nov 2026 14:31:40 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:40 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 15/23] hw/arm/virt: Embed Realm VM type with IPA address
 space
Date: Mon,  9 Nov 2026 16:31:02 -0600
Message-ID: <20261109223110.1619504-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42a.google.com
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

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0ed6df4b9b9e..349257f53f2d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -95,6 +95,8 @@
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -4058,6 +4060,7 @@ virt_machine_get_hotplug_handler(MachineState *machine, DeviceState *dev)
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
+    int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
 
@@ -4087,7 +4090,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | vm_type;
 }
 
 static int virt_get_physical_address_range(MachineState *ms,
-- 
2.53.0


