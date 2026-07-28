Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F347C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonTM-00047a-Jh; Tue, 28 Jul 2026 15:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSN-0003TN-3C
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:19 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSL-0001aQ-Fp
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:14 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso257873a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266832; x=1785871632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pK2tYb+uha0OTzKJ3jiWlIwpjnwXssFbFzC9Lye+Plw=;
 b=ob31+VHf4H1bYkQdzWtVNSBZQr1vSnSFxFTJBWCpgUMVY8k/HlZYkrcnEUP7eD+jWb
 EfrLDYAqbBLaILaf6oI0khQZ3CoayT59OIr3KT03c7wV1KohPGw2DWzBuXDpClFYVjdU
 nK5+dZbj+jXMTh6iXRi/GNwxhNAnP24zBNRNrCOfL8a1bOesG+Ys4bMzUnrHueY3Hts2
 2/6C5GrZLrw+TXN+hcnvdPLxFhiH/ABuv1B4ByXu6GcpATgI5Z8vm3Fds+OKHv03XcFY
 OmBeC44Kh/oBQLrfLNBaBhtaWSW8skzpwxl+CiGf9ue2gQOBEhyRF5eGz3NDBefqwbRy
 7Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266832; x=1785871632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pK2tYb+uha0OTzKJ3jiWlIwpjnwXssFbFzC9Lye+Plw=;
 b=NYcGreklIXaXQdF68sFLEfzAK9QhVnNV4VT5JpHw/vNunClzq4ZiJn0eQYSB7Io1ij
 0cRHkY7zGtdhjM0uVygcstOSXYdvF2Wxc2N6QBbHSlIn8L72TSo1kNXD2U2uydkeim7G
 eKsuFnoeJdp5qgdzCNbRB7tDPq3XD7zQ263T6E4R7JDWesWHopk0S5KATbQTUkXtqr92
 eaW5gFpnYyJC+X6ZHIM/aYM4QgmyZy0zQ+a+58x7GpQWcUNo5wNH/CYgKEl0Y+elIO4Z
 pnFdQZQQsayz/Y6lnMCksjmisCUobiI0kWm3zBwB6OxsnrFIb21e3+tZEbuSkI5P/Cj5
 cC1g==
X-Gm-Message-State: AOJu0YyHor9Tgpd0W0HPutjmBIZl4m2k3U7YtOt7JfKfFkdkstku3rxB
 jRiYpXZFxgWepeDcrlUV37fXUEvNWnykyfeeP8IPXxljJGg7LJ7DSasM3f2VGED9lgk=
X-Gm-Gg: AR+sD10HSMDsT940o+iYn5T3SUos/AqfG6C2dPSefj8Zkpy9w77CflbJSmvKMvhJ8gT
 yIUbEwyv3y7mjl8PYPX2bnsyOhaQJlvirVTPr7uhdrwLpM27KT6howQ537EpksW/4uX4OdVY5Nx
 L1AFRzOjgX7OR24PEyrINWCxCSUsKzvCcaejT8jHa3Jf5e66IhWU4/3qUYE+lUKJAXY6CeQlze8
 ghuMovJlEKSTbGml1wW8R6CNIH4vHjfYKWTYTfJw4EG8XUFWQkCFPDMiVSmwz3LLg1clp09h508
 Of2FU3RItY2NpNjpm7Jxf6gpbiKUjk5EIDCPEsJSwaeKx0FHitDgmhVpFVPN0JQ8zttWG9nDqsg
 dCwa061bPk2hMfrqO9aytDdc4joBW/BWYSE9/2UwXPKA0yOlAQHVme87OttQ0csGvs2KJ8a7bJC
 8iy2zE/06pnmGxLng9xwAd0ZD8o4B9Pzy24+QxTlF7lvFlaxC9ED9fH/rj2WdyASsAIMdPVlM3u
 nj1NZKFD6YUHAo=
X-Received: by 2002:a17:90b:1d04:b0:38f:57d0:3a9 with SMTP id
 98e67ed59e1d1-38f6a51c0b8mr3938868a91.36.1785266831998; 
 Tue, 28 Jul 2026 12:27:11 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:11 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 17/24] hw/arm/virt: Reserve one bit of guest physical address
 for RME
Date: Tue, 28 Jul 2026 13:26:23 -0600
Message-ID: <20260728192630.240375-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102d.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9123f46fae4a..fa6cd62a335c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4054,17 +4054,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
     int vm_type;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
-
     vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
 
+    if (vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -4073,11 +4083,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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
2.43.0


