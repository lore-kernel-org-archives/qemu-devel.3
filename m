Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12472CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 19:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Zhq-0005nw-TY; Wed, 08 Oct 2025 15:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XLnmaAcKCrckXsfabjdlldib.Zljnbjr-absbiklkdkr.lod@flex--navidem.bounces.google.com>)
 id 1v6Zhn-0005na-Su
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 15:20:07 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XLnmaAcKCrckXsfabjdlldib.Zljnbjr-absbiklkdkr.lod@flex--navidem.bounces.google.com>)
 id 1v6Zhg-0001MS-U4
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 15:20:07 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-32eb18b5500so765499a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1759951196; x=1760555996; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=chBJngDQiYLGBsHXPtAkEEWlY9pdwGhGS2MbjBERUuM=;
 b=xjD9Gx+l6r++7OQ7GRqD+jnwkhqdEyIPi98iHEakuMvTM+y2c2gVYTMMcHF3xwFYPP
 QQ/e+0UehJY77tAyIaXv7K6LSeTydmSDjf1krq+12GGxwf4lRK1jNY71esO3g8+pIoDX
 1JaqIbPhxL7DNq18groUoYAmyEpJr6jKx+WHz98q5OEBqdtiRn7cw+pMEdC2S6/RLE3f
 5a8dVFEBsvaNlwqRs/+nHeSApk9jj10dixQXDw86rO/3O88Kvy/bJZORBLd3mR4V1QSg
 NYJo4y5x7PciKcwsCa7WbCkoG7hsRfQtEgEklrBM/XWR1AwXgtVPFTm8oy1bhHKJur/T
 cJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759951196; x=1760555996;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=chBJngDQiYLGBsHXPtAkEEWlY9pdwGhGS2MbjBERUuM=;
 b=YW35nkAQIEF6m7ZiefX/j5Ub1290YRL8lelTRpGxK7CYjB/uGuREdvE6sGIDs5vK7W
 3WEx2khu09UbdS7rqZ48tl6Myoegf9dE7gDIehu5VqumAwOtsvmGoUqlzfNbgK3U2NpW
 hTQn/agmF/Rgg91+hmwqAXklbphoRtvISm0vNW643RBcaXUzAGpDtYs9wU4i/85HWCJy
 uBz22Di2o2UOTKMv/DXBkj99onVKxP/hZv8M/mD0wnF4mnxMOUjiNaSPiqT4X9BzO2fk
 mBW79mFAS33+hsu84tWMhJ7DyQcGp71cug6Gja1ZR7mLlqhcOSIEcAMfYDrl4cv6Q/uP
 s/FQ==
X-Gm-Message-State: AOJu0Ywh3qEQ8a6gXaN43s1soAH4eBqkHC+CmgAi6j+MwXL/B+uIMBcX
 yf2MDlAHbQmiXoRzxQZB6dAbVmiPFYc2HfR1Fd65+Nv1gvwwoULTKE3JBlmhmQ7m3Yl1vBVQbiJ
 subkHerMtj4q0Vj9AUZpWQJQaEn7tWAJ2GUYI3Eq5Xj3QpRuez6V2dDMvn5aeyg350NrTIwe0tw
 XuyTkIpIxn0aamxiYpregOJfi8lhfOxUiVaA1BIpvx
X-Google-Smtp-Source: AGHT+IGEJHsfT5HGBUQPNwQzOo+AMJgM3wz6tRVzoSiLo6R7HDgpK1dSI/jPk0TW6AMgjWfKrCyUg+pRefRG
X-Received: from pjbcl2.prod.google.com ([2002:a17:90a:f682:b0:327:50fa:eff9])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b50:b0:32d:a0f7:fa19
 with SMTP id 98e67ed59e1d1-33b51375940mr6489801a91.17.1759951196177; Wed, 08
 Oct 2025 12:19:56 -0700 (PDT)
Date: Wed,  8 Oct 2025 19:19:36 +0000
In-Reply-To: <20251008191936.3069950-1-navidem@google.com>
Mime-Version: 1.0
References: <20251008191936.3069950-1-navidem@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008191936.3069950-2-navidem@google.com>
Subject: [PATCH 2/2] tests/qtest/fuzz: Add generic fuzzer for pcie-pci-bridge
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org
Cc: navidem@google.com, zsm@google.com, Alexander Bulekov <alxndr@bu.edu>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3XLnmaAcKCrckXsfabjdlldib.Zljnbjr-absbiklkdkr.lod@flex--navidem.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add a new generic fuzz target for the 'pcie-pci-bridge' device. This
target uses a Q35 machine with a multi-level PCI hierarchy to exercise
the bridge's functionality.
This is made possible by the preceding change to handle unimplemented
BARs during fuzzing.

---

This new target significantly improves code coverage for the pcie-pci-bridge
implementation. The baseline coverage shown below was generated by
running all existing fuzz targets with the oss-fuzz corpus.

=== Component: hw/pci  ===
-------------------------------------------------------------------------------
File                           New Target           Baseline             Change
-------------------------------------------------------------------------------
shpc.c                         359/511 (70.3%)      0/511 (0.0%)         +359
pci_bridge.c                   255/304 (83.9%)      12/304 (3.9%)        +243
pcie.c                         390/774 (50.4%)      160/774 (20.7%)      +230
pcie_aer.c                     119/524 (22.7%)      38/524 (7.3%)        +81
pci.c                          1154/2069 (55.8%)    1084/2069 (52.4%)    +70
pcie_port.c                    58/119 (48.7%)       17/119 (14.3%)       +41
pci.h                          86/132 (65.2%)       81/132 (61.4%)       +5

=== Component: hw/pci-bridge  ===
-------------------------------------------------------------------------------
File                           New Target           Baseline             Change
-------------------------------------------------------------------------------
pcie_root_port.c               86/127 (67.7%)       13/127 (10.2%)       +73
pcie_pci_bridge.c              62/94 (66.0%)        20/94 (21.3%)        +42
gen_pcie_root_port.c           45/66 (68.2%)        19/66 (28.8%)        +26

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index ef0ad95712..e025f57a3e 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -247,6 +247,14 @@ const generic_fuzz_config predefined_configs[] = {
         .args = "-machine q35 -nodefaults "
         "-parallel file:/dev/null",
         .objects = "parallel*",
+    },{
+        .name = "pcie-pci-bridge",
+        .args = "-machine q35 -nodefaults "
+        "-device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=true,addr=0x2 "
+        "-device pcie-pci-bridge,id=pci.2,bus=pci.1,addr=0x0 "
+        "-netdev user,id=net0 "
+        "-device e1000,netdev=net0,id=nic0,bus=pci.2,addr=0x3",
+        .objects = "pci* shpc*"
     }
 };
 
-- 
2.51.0.710.ga91ca5db03-goog


