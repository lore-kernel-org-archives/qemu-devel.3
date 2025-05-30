Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9164CC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvi-0008Na-TF; Fri, 30 May 2025 03:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtve-0008Hi-Iq
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvb-0006pA-1w
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmCqGv2PLULpIzliwAI2nsyTkhSfdekcaFoTKA8oFL8=;
 b=Yb+rAql9fFlkZlNb+8IHIsooZFr9vBkjT/DQC3WpJTK/+mQW4AWfZln+dJ4gRKyvm1tOXD
 76FxoVBgIuF1LcYYPYE7PUwlrIAYnmJic/lE3FTKTPnjYm8MY6kmCM00RQKaVbGF1J7z42
 We2yOrAque+2MkAxbattSUSQL5Sxd10=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-_lr_WY2GPRy1V5xJOuJNEg-1; Fri, 30 May 2025 03:13:17 -0400
X-MC-Unique: _lr_WY2GPRy1V5xJOuJNEg-1
X-Mimecast-MFC-AGG-ID: _lr_WY2GPRy1V5xJOuJNEg_1748589196
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad8816c50e1so121137666b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589195; x=1749193995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmCqGv2PLULpIzliwAI2nsyTkhSfdekcaFoTKA8oFL8=;
 b=lJtnA3IG+T5nPYWuTipBGZEOPZzSc2KFIXXERWY+a8GIlcJRx1q6JV/qN2ef9bdo30
 sia9AJ87a7fZ2u+QJdtRu8M5Y2pEmsRhC41aL63wlQdDfobdNMtfpyN4cJ34jKldHRlw
 q8wXiIdPoM5CLfYhvrQSr65HvddtTtUWI53YiMmNvx+lyKclIR3vb248VsAosUGW+//J
 wUFVYngf+eV2mWXZhDOW0veTO4J5fbYJgUS4AcTu0kzv624lNPW3jCZncpjJ6JhKxOF0
 wWVWtnqzMh5RpqFzIW2qkPq0fprTudg5V7HF424ZrufjFw3VpILVG0gUkPy7IPyqNidU
 Q/ww==
X-Gm-Message-State: AOJu0YyBO4ER2vgfMdjRSrCkXCJVt9QK1KEdP72eWb2S51FCOTFFvgLH
 SWnsW/PmYvG3jmudq6zTDTdulpfga7kqx1c3fwJEPWNsPav/bnHGdWnNzC+cjv+hX+4lIQc0XeL
 yEmV6LyUl8KDH5ZFzGqYeIBU70IX7oLWiLSRUb2qGwLOSFhmX/mErb6OztUYtwowPrM3WmwpdCw
 Ev3LwHQ3YLtvRDHHpf5+plW2gVwqNML8Sq9MrKU40C
X-Gm-Gg: ASbGncsyAravzW0wmjvjobnTrSfJ1hPVx/ZeMSLcwMtMbswt84Zk7x0k2nruQJwZlcv
 JU0cKYDFj5FfkiP3AC1fg0tPj2+lKPv0cIQtzjhgb+izZ6fCoptjTnTPgzxWVNyQ0dmzxJmuqW1
 9jNG6udZwj2yQ0E5xzJOsZ6ReNwk1sWqsdjc5ykUdDE0V8zjVeWB11jn1vUEFb/U6jmFni3hRVC
 xpp7kbMxRFoWNREtmJRFd9CEtu/YdX8ub2XMXiNXw5OVUAuoyx3L3GV8w3dtFumB1P9M8JX19ay
 jqVaXNZReOd4mw==
X-Received: by 2002:a17:906:36d9:b0:adb:3509:b459 with SMTP id
 a640c23a62f3a-adb3509b66bmr95106466b.19.1748589194995; 
 Fri, 30 May 2025 00:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiH1tT4H+jMeLRwMsO8hoa/9WyExHTmd8OqM7kxPpX55unrESa4fEfTGa8ONh0xDlPT9sr+A==
X-Received: by 2002:a17:906:36d9:b0:adb:3509:b459 with SMTP id
 a640c23a62f3a-adb3509b66bmr95103566b.19.1748589194517; 
 Fri, 30 May 2025 00:13:14 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad3a6b6sm277715266b.142.2025.05.30.00.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/77] rust: Fix Zhao's email address
Date: Fri, 30 May 2025 09:11:39 +0200
Message-ID: <20250530071250.2050910-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

No one could find Zhao Liu via zhai1.liu@intel.com.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250520152750.2542612-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/fw_cfg.rs     | 2 +-
 rust/hw/timer/hpet/src/hpet.rs       | 2 +-
 rust/hw/timer/hpet/src/lib.rs        | 2 +-
 rust/qemu-api/src/bitops.rs          | 2 +-
 rust/qemu-api/src/timer.rs           | 2 +-
 rust/qemu-api/tests/vmstate_tests.rs | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index aa08d283519..6c10316104c 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::ptr::addr_of_mut;
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 779681d6509..e3ba62b2875 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 1954584a87e..141aae229d4 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! # HPET QEMU Device Model
diff --git a/rust/qemu-api/src/bitops.rs b/rust/qemu-api/src/bitops.rs
index 023ec1a9983..b1e3a530ab5 100644
--- a/rust/qemu-api/src/bitops.rs
+++ b/rust/qemu-api/src/bitops.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! This module provides bit operation extensions to integer types.
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index 868bd88575f..0a2d111d490 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2024 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index ad0fc5cd5dd..bded836eb60 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -1,5 +1,5 @@
 // Copyright (C) 2025 Intel Corporation.
-// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use std::{
-- 
2.49.0


