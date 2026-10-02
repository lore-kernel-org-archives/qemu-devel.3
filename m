Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6172CA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjke-0007T5-Ej; Fri, 02 Oct 2026 16:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkY-0007N9-8M
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:58 -0400
Received: from mail-pj2-x2a.google.com ([2607:f8b0:4864:39::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkW-0005oU-KU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:58 -0400
Received: by mail-pj2-x2a.google.com with SMTP id
 d9443c01a7336-2e2db9f927cso22118015ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972455; x=1791577255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xGwa4+kYIpnF7nSKCoYuD6ZjnEJjyPrjCuP1EkufKsg=;
 b=WarenS4NlqmlSJtJ5AyEdWsWvxgH/pnhU56fRmpiGaPZh8Po7AwpDEZuYuZ9KaHp+r
 dou8egoLJorvsDsoZD2/D4vdCxZzM/QF/2d24zIs2Gs2+hIzWzh3w9ECUOLWntUEzOCg
 tErQhd9sPLvSBL35i6wzd+QLX16y0/gCpKvMf5Hk5JU6ng+BGBSDV5WxuPWTyuuGh1YG
 z1hRfAJDaIZY1HwzJy7HzXSwXYoZecOMh2xNYgSpq8u+C+s4L1ScTa2gACO3Ja/NbiBv
 rcW9mSTf3siJS2iR7WrsvPo3BFtgQzqLfxhH8L9RJtJ713jDgGhTItg0inODjLFvTU3P
 5CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972455; x=1791577255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xGwa4+kYIpnF7nSKCoYuD6ZjnEJjyPrjCuP1EkufKsg=;
 b=RmFf0RHZqVdlbdHmk0v6BAos9qGVEW/gSHxHcpCCCHxt2KoqFYKonDDsfsynp0f68+
 AR0h0jJLkeE3XvlnI9hz7xZnTqdvijOJS5wd+dwHxtvMdUlevKtDh5NMiTjlzq0F37yW
 oOSWmLC0MgzhErw3x6zxU8MnWOs0Bch8iH9yMI86lDawUxZK9vHNK7bKsqYqdvjKPqbz
 3xsl/5YwaVKNDpv0tOAk7KUoygdVlxEc8a7GTz3OrEMwgzTznZHEblmZAw2IaoWmV+bb
 0NZy7530BPA5jf9MfdDwvcwACH72WjE2Uv8fYAoPQVQ07yCUThDSbxA8M4Ss2QCJpsl2
 SCBA==
X-Gm-Message-State: AFq9FYIJmN/wKfaGs4Efp1MRbityOWMk/cGMLRbXpWK/oDUPAaxytt1i
 JUtbP0SkAU1qtjuRlCa3jmR0F5evmsEb5NBzDHFW+WHTBRwA+ZlMqs3bBNCGc/MzPDU=
X-Gm-Gg: AYBFou3kz8QGIo9tShaKPTdtZIQnhvTchIFnjIVvG7BAs7gY2boFdQ4NPC6PHgzk1J9
 yhue2M9xc9OlGcP8FM8ZSP/j/SL2lkfF9Uad558CJNUpLMJin0yBuDj3p7yioJDhG/NqWW+mh7l
 ovy3A5nSNM8I7ei0pRTgmfIhuMsQkEYmim5NInYCMdzB219Cn/zf4VHkXSEYglumpMIuzR8yyRy
 9g9MFnUfUpgXqzFN9GxATltgjgTe7dlU6X2FdD2lahnNycnS2h9Ww+k5c4dgey3z9amCgv+RsoR
 ksXjyU/oSGvr+KED0XGng8v6SuilyLvOXmUXlM6GE9YiaEnOrDZ8KtexYgpoeyglDFj07Nr1yhb
 wCWtFWqXA/aEhtEmEJ5OMjMCs+yXZfQG6kXVrKl3F3HJX+2HqOPPG4TB1l+lbukH/T5CizEg+3s
 3IOfWoId70QRLXjOi0tZSx73FK6vqpOS+C3vouz02mTvx+hJzdHo0mXodAA/ietbAsQnnr9acpI
 kfLsUqJUOjbC1/cmETP4SKU91bv46E0wBU=
X-Received: by 2002:a17:903:18e:b0:2e3:1bb4:6113 with SMTP id
 d9443c01a7336-2e49b648c41mr40464145ad.26.1790972455139; 
 Fri, 02 Oct 2026 13:20:55 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:54 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 14/22] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Fri,  2 Oct 2026 14:20:18 -0600
Message-ID: <20261002202026.1204110-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5ab4bb23ef2d..cdfb71ce97d3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -96,6 +96,8 @@
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -4047,9 +4049,12 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
+    int vm_type;
 
     max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
 
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
@@ -4074,7 +4079,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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
2.43.0


