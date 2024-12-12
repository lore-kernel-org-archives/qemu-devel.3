Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF01E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLf4T-000748-K1; Thu, 12 Dec 2024 04:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tLf4J-00071L-Q8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:01:13 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tLf4H-00053i-Qg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:01:11 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3147F3F22B
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733994066;
 bh=iVXL90rtAcJenBCKlExUlSYvnz+AAqG3rztiXVz6LCs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=v3ur+MO3WCTxSM/dY6/czpJ+3GJE+1xNT4jUQiX/CmLXwa4As7uikQ6J8se3MRZds
 D23oHWcAYYjP++nec1So/SjG+rLTW5D3/hdBwpL2lsOqLyeAPFA7+PXGnw9iC6QuFD
 PUfYdM1Tm2JBrKz+Qq/tuJKQ7H/mgSCm8aGPVf48klDX875qpmAqxZeFd4GO3Vk2pd
 CWQtkTT6aeSbKogAPKFdSyi6HYUQxo6x/0l0Lf0+w4139+Jer2YfHi0FwzBiwTAsSD
 3hhMbBrsY1djDOjoqoqCjBW+vz0gtXlpSDYnZA2YXhNUZVmnz4yXhtRipUCXSQ+kZJ
 lK9YcZm91+CSQ==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385dfa9b758so159943f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994066; x=1734598866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iVXL90rtAcJenBCKlExUlSYvnz+AAqG3rztiXVz6LCs=;
 b=HvrRqguKc6BhsupZioIT5gKGexw6R/O5+Y8s3aIfNxf6NquqvuJ5mVpctYhMUB/Oaj
 Ft/nlv+NE2CnDVdfVGeXBjXMaCPz5UEhKsRExaH9IqViya4Mz+vVufpbA2Zd/k7lLgM9
 nHBX2SdoRme9jYqGELJDnZybLynKtbFLp89KQ0kt0/pO9Jv+Isln8nrRJfKcJvJNctIS
 PiWMlFlrc6JV4LUFfqaqcCttz/38DBASdPpa8UEM9yzuX/n1FBnCzbulvs5vWQxs/u2p
 J54dFfM5kJyiJ2ItH2cwh6vWozg/JlC6BxLwXitEXTGKqHD10vfCtq6d9kJYTJE9vu+d
 XNOw==
X-Gm-Message-State: AOJu0Yxn8F7vii6Sl8Tt+f9uMgZqnd3P+VCHVq9Emdg6Q89nMW2dBRij
 czcE7qGZYABaCtvuphq61GH0oqsss6r5EEaytRnmGv0/mTyPkmkLOyRbm93KHa9S1VF/m2RbByl
 1cqU+YYbGiFS/oQtu3vU3bVJf6b/95M5VJm991OWk1Gg7AcR1QGjDrBKFJ2+UsPUsaCAK
X-Gm-Gg: ASbGnctAGgRFJMCV57HlvYm08O8z0GH6yHluc383qu21bumP65+NA2eRbZgo8+6nwEu
 2zII+mK1w7UkdN2vSP+rj9MdcVojhaX94eANU/ak5AZ+2pAR4PSsJYFiQRQrHV1eD9LC38I0f3z
 SPQTI0OEz5rfQ7u4LvfsDeKLDoXOFQCsuqdCO+Un/3IyWfc/a7IjUnBRPATg8+9/QG/tKJpQ7Lq
 4dPRxX/aq5T56VsduYV/S4rnOcc5x6Q17a9ovubZBjpCW7ICcFIws93FftpI534U7ZeBxzIm0oC
 hcPPz/AwjnXw2Xn1+1HYyP2gwhrYfqKWw5ykC/szJHip66pWoV4c5nN/IxM=
X-Received: by 2002:a5d:47c9:0:b0:385:f060:b7fc with SMTP id
 ffacd0b85a97d-3864cea3dbemr4203910f8f.25.1733994065716; 
 Thu, 12 Dec 2024 01:01:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN3t2pF75apDNWGMeTFGvS5qEolK8pqm2ndt+ns9jn4O4182GOMsEEnf4PcL3JOMMuBIfAUg==
X-Received: by 2002:a5d:47c9:0:b0:385:f060:b7fc with SMTP id
 ffacd0b85a97d-3864cea3dbemr4203838f8f.25.1733994064976; 
 Thu, 12 Dec 2024 01:01:04 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a4815sm3404505f8f.26.2024.12.12.01.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:01:04 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] pc-bios: add missing riscv64 descriptor
Date: Thu, 12 Dec 2024 10:00:59 +0100
Message-ID: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Without descriptor libvirt cannot discover the EDK II binaries via
the qemu:///system connection.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 pc-bios/descriptors/60-edk2-riscv64.json | 31 ++++++++++++++++++++++++
 pc-bios/descriptors/meson.build          |  3 ++-
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/descriptors/60-edk2-riscv64.json

diff --git a/pc-bios/descriptors/60-edk2-riscv64.json b/pc-bios/descriptors/60-edk2-riscv64.json
new file mode 100644
index 0000000000..14811ca307
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-riscv64.json
@@ -0,0 +1,31 @@
+{
+    "description": "UEFI firmware for riscv64",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-riscv-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-riscv-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "riscv64",
+            "machines": [
+                "virt*"
+            ]
+        }
+    ],
+    "features": [
+
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index afb5a959cc..cdd0be01a3 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -6,7 +6,8 @@ if unpack_edk2_blobs and get_option('install_blobs')
     '60-edk2-arm.json',
     '60-edk2-i386.json',
     '60-edk2-x86_64.json',
-    '60-edk2-loongarch64.json'
+    '60-edk2-loongarch64.json',
+    '60-edk2-riscv64.json'
   ]
     configure_file(input: files(f),
                    output: f,
-- 
2.45.2


