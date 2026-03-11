Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7549FD88E0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09Ib-0000iT-FD; Tue, 10 Mar 2026 22:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09IY-0000f5-La
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:27:46 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09IW-0003tJ-Ks
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:27:46 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-128d7db88b9so3299206c88.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773196063; x=1773800863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDUOS+T/pU3klFSXmoTYqnaw4i2qHj3Ih1tuYbUSnhI=;
 b=agUuk4+eEcR3z8x7GeRnmtHkx7w5VUiTueHDSv1+pfwLgZRc7wq0XSEdJ95VxMp5/F
 Ga6S7aKP1jHvDhKm3CVesjeVdGFBIbUVv2BPNQHic9J3gfMuc23AjucObY09eAytkWbY
 JwouC6cb1mSzPoXm4pt9Yu6ers9JEGeeCkRe5d/B7iXpIQKE0+Fmulm+TdYJVid4vEpI
 2BqFFATEG78UUNk0AFMwPoAn9Sr7I+iKcQzX60Wil/u0SmySyaDhWoldF7NgsH+gvc54
 J27SoUExNatnfPl18xQlPIJeEgDi4JY4K4CpuGB3Ysi0vCgAcLBKS5Ky5WsaHgEdpSLb
 KezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196063; x=1773800863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PDUOS+T/pU3klFSXmoTYqnaw4i2qHj3Ih1tuYbUSnhI=;
 b=WslfGjbbYq2Zp6wBvhDhHfeY9/kOtotClVlk41Kj1xrz66qGZwqYHnDYcy1cVHVVJ+
 BzqN8SFj4lj7lyL5Q6Rts10O+o6yIpJA/yIqzD2gyUlhd3UujbXL8cRAFfstJ1fuQCFP
 87LXy1aGXQuFMiKAsHxKLog+YUvlccx2qQcy3Ya8+cVOFCA0zrN0u4hCKx0asAf+zOWS
 HOkbDL3YkNbioxf2VFOlH5eB4XIl+gR8pNx0/UFKEKlr0kB2vJPkpOSnUErr5GeU3/Po
 dFjJ/BBXGrZkq22GPeqsgo0K5oExJQAjYagNBFA7oLOrn/KIAxOtrg4t3LvgWGGCIFwO
 aJ9Q==
X-Gm-Message-State: AOJu0Yym3DpMsnH5DcT63zalo7OtklbO/EODFffbJyK1KbWfsK48S2Ct
 9ULDXuBuFlDSuO/rWdbZQNH+wSNDtyXwaAw/zFKeKIqS6VXRZUeNe2/kuFlqQg==
X-Gm-Gg: ATEYQzwWKT3f03obc7gdU3Lblntp48ZOKGdJaUrUAOvzYNWdA1ZrgcQ590p1W4s/JKj
 d6/oro3dlFqms5I1NuqOHws6lwZWujWsTj0bIkeY/TptV0PrvpGVHykzigH7WTTDJrPXO5NOuCe
 QqFof4DgJQv77UN49/jQcpiz9uoKF7/Eu9msvWxkd8CErUpdNwTECUJIVCVs+QcB5aerWZJul0K
 IC2g+9fsx3kISUR/ULA/7IN2aunZx1tGCdoNw/me6A4H1c3+BwAxqtzOQ6m0fhZoYYn3euwMbel
 N3X/PhT91qV7EFkdGzm8bRqJ4GZAmRrfpRFMMCD7pIOlWrouoyFppDXeRHKVKXLPbq3MojxhrhF
 WHLg5kWWG7O+R65ULz6CemaobOWruT4xHU85Mk2L2nOGHn5lGFwQ8wPtpNN1slmfuBOyqJ/cMRa
 LxWcy+zqdEOvG8T7y5Q3YZca84sSCwHJdqxrV2SphqPuHH0rz9sxc=
X-Received: by 2002:a05:7022:78a:b0:123:3364:2ca8 with SMTP id
 a92af1059eb24-128e785c05bmr449636c88.39.1773196062585; 
 Tue, 10 Mar 2026 19:27:42 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:80a9:8ba1:b664:ae3d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128e7bf1e1asm937039c88.3.2026.03.10.19.27.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 19:27:42 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v2 2/2] target/arm/hvf: configure IPA granule on macOS 26
Date: Tue, 10 Mar 2026 23:27:32 -0300
Message-ID: <20260311022732.64141-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311022732.64141-1-lucaaamaral@gmail.com>
References: <20260309214906.92578-1-lucaaamaral@gmail.com>
 <20260311022732.64141-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Read the ipa-granule property (set by hvf_accel_init) and configure
the HVF stage-2 translation granule via hv_vm_config_set_ipa_granule()
on macOS 26+.  When ipa-granule=4k, use HV_IPA_GRANULE_4KB to allow
HVF to map memory at 4KB granularity, matching 4KB-page guests.

If macOS < 26 and a sub-host-page granule was requested, warn and
fall back to the host page size (16KB).

After resolution, warn if the map granule exceeds the guest page size,
as Venus blob BAR mappings require page-aligned offsets.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/hvf/hvf.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7952b01..a6f139d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -11,7 +11,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "qemu/log.h"
+#include "exec/target_page.h"
 
 #include "system/runstate.h"
 #include "system/hvf.h"
@@ -960,6 +962,53 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    /*
+     * Configure IPA granule from the ipa-granule property.
+     * hvf_get_map_granule() was set by hvf_accel_init() before this call.
+     */
+    {
+        uint64_t granule = hvf_get_map_granule();
+        bool granule_set = false;
+
+#ifdef MAC_OS_VERSION_26_0
+#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_26_0
+        if (__builtin_available(macOS 26, *)) {
+            hv_ipa_granule_t hv_gran = (granule <= 4 * KiB)
+                ? HV_IPA_GRANULE_4KB : HV_IPA_GRANULE_16KB;
+            ret = hv_vm_config_set_ipa_granule(config, hv_gran);
+            if (ret != HV_SUCCESS) {
+                error_report("HVF: failed to set IPA granule: %s",
+                             hvf_return_string(ret));
+                goto cleanup;
+            }
+            granule_set = true;
+        }
+#endif
+#endif
+
+        if (!granule_set && granule < qemu_real_host_page_size()) {
+            warn_report("HVF: ipa-granule=%zuKB requested but macOS < 26; "
+                        "falling back to host page size (%zuKB)",
+                        (size_t)(granule / KiB),
+                        (size_t)(qemu_real_host_page_size() / KiB));
+            hvf_set_map_granule(qemu_real_host_page_size());
+        }
+
+        /*
+         * Venus blob mapping safety: warn if the resolved map granule
+         * exceeds the guest page size, as virtio-gpu blob BAR mappings
+         * require page-aligned offsets and would hang otherwise.
+         */
+        if (hvf_get_map_granule() > qemu_target_page_size()) {
+            warn_report("HVF map granule (%zu) > guest page size (%zu); "
+                        "Venus blob BAR mappings may hang. "
+                        "Consider ipa-granule=4k (requires macOS 26+) or "
+                        "guest F_BLOB_ALIGNMENT support.",
+                        (size_t)hvf_get_map_granule(),
+                        qemu_target_page_size());
+        }
+    }
+
     ret = hv_vm_create(config);
 
 cleanup:
-- 
2.52.0


