Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31591C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHk-0002OK-7V; Fri, 24 Jan 2025 04:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFk-0006ua-Bf
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFi-0003tg-66
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KP65DPAPt9KsJWuPUWuSo56FR59BUIL6HMXyZyeXonQ=;
 b=EFSzao2LRCccc1n+XtXsHx0pExowx8G0rV+gVjkOtCzCemhdp6i+j8Xd69qQ7MPVkZh0up
 GX0VQTHDKNj7YJR8r9nIaLY9aP7V5jvnJ/QcQN51eQuKbGaY165IzCl9RW3OXmMVEv4lM+
 C5NbtMCRZeKveY/L1u1aWoWPnopvlfo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-MDD2BVuBNHa8zul6NN7HBw-1; Fri, 24 Jan 2025 04:45:22 -0500
X-MC-Unique: MDD2BVuBNHa8zul6NN7HBw-1
X-Mimecast-MFC-AGG-ID: MDD2BVuBNHa8zul6NN7HBw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38bf4913659so1541258f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711921; x=1738316721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KP65DPAPt9KsJWuPUWuSo56FR59BUIL6HMXyZyeXonQ=;
 b=k/nmwxFG1ZR82tX6PhQ+TUSPng+82ufHZqHMjmu1p4QsZDu9brHh1Dm9Ky7NNhh6lT
 nSWiA9pFUV9TJlgn6m71zqwinSTlO0Wxh5eV/nuwRdMMDUm3/+Ocdsmgi5RJ3tV1xPF/
 /JJXr9ex4fMdkfehYTAWweVM/pYVkouldc9NXGrLnZAR1XUUu7K0PEL47V4HGUjBSw6U
 IaK/coAXFMH/QljSqvx41QVKjpKe3UdYVn3SRlVkNDe8cYpO6EjVQFqYBBRPlU5oel7J
 XPoFfaknL5lQmfhVIWJzwPoCM9TDiu3C2IXdvqldsf96d7tzu3GdBqXjP1Si4Gq5zkTE
 4KqQ==
X-Gm-Message-State: AOJu0YwkTn8saT9Fbpdme81WH3ONbnoUioCHa0Y4A/ct0evmn5LUnhQl
 hh++o8fkDzXMDckJcVF2Q1sxA88bQxSwwfuWMZDzEDtK0Bcsmi9MuOsTJHjSxvz4EjTXzRLho0N
 lLPj/dkiJ2SSVVd0vGG7kpgTO9VqpCPpbfoEPh5pGRsi0HgxzV9S1HORk5oKT6u2d/4SlT1cEmo
 urskWO7h2pSdEu3IAuKcLl6CkZmC7vBuJkcdjQ5Ck=
X-Gm-Gg: ASbGncs3HS+huN+/a/+6aKboqHhZLlBIt/cDHZyUyfph/Yr5aNLh50puvyvKY6hCvb9
 JuMWCwpSis67DJWXXKJnpBVHdlHTvNEGnTaUSt0kwbiVWawWHBbqTp309xJiDb6XoUia5cwTVJL
 2Na8/y5VrZx7AnH6SA2RiRA2r4z4QRcgIbsdQBeuemi9ffuc2rSoYx4Mcw/sT0q0dfvGvfonM7P
 mX7l5hVpWHqbm7g7gkBFjmoNHroMjOTb/RSd15oDThaJiy2qNoBoqfCgE5ZecyZ2VAUgVf1ag==
X-Received: by 2002:adf:ab0f:0:b0:386:3711:ff8c with SMTP id
 ffacd0b85a97d-38bf579348dmr20110933f8f.23.1737711920744; 
 Fri, 24 Jan 2025 01:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6F41fp90vF7+INj63ZJxGWMaZ97YzAIZIKNwemeiacajidaMxNqpfpoUP7WsPXlRK0tU+hA==
X-Received: by 2002:adf:ab0f:0:b0:386:3711:ff8c with SMTP id
 ffacd0b85a97d-38bf579348dmr20110909f8f.23.1737711920207; 
 Fri, 24 Jan 2025 01:45:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188a77sm2209828f8f.51.2025.01.24.01.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 19/48] docs: Add GNR, SRF and CWF CPU models
Date: Fri, 24 Jan 2025 10:44:13 +0100
Message-ID: <20250124094442.13207-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

From: Tao Su <tao1.su@linux.intel.com>

Update GraniteRapids, SierraForest and ClearwaterForest CPU models in
section "Preferred CPU models for Intel x86 hosts".

Also introduce bhi-no, gds-no and rfds-no in doc.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121020650.1899618-5-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/cpu-models-x86.rst.inc | 50 +++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
index ba27b5683fb..6a770ca8351 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -71,6 +71,16 @@ mixture of host CPU models between machines, if live migration
 compatibility is required, use the newest CPU model that is compatible
 across all desired hosts.
 
+``ClearwaterForest``
+    Intel Xeon Processor (ClearwaterForest, 2025)
+
+``SierraForest``, ``SierraForest-v2``
+    Intel Xeon Processor (SierraForest, 2024), SierraForest-v2 mitigates
+    the GDS and RFDS vulnerabilities with stepping 3.
+
+``GraniteRapids``, ``GraniteRapids-v2``
+    Intel Xeon Processor (GraniteRapids, 2024)
+
 ``Cascadelake-Server``, ``Cascadelake-Server-noTSX``
     Intel Xeon Processor (Cascade Lake, 2019), with "stepping" levels 6
     or 7 only.  (The Cascade Lake Xeon processor with *stepping 5 is
@@ -181,7 +191,7 @@ features are included if using "Host passthrough" or "Host model".
   CVE-2018-12127, [MSBDS] CVE-2018-12126).
 
   This is an MSR (Model-Specific Register) feature rather than a CPUID feature,
-  so it will not appear in the Linux ``/proc/cpuinfo`` in the host or
+  therefore it will not appear in the Linux ``/proc/cpuinfo`` in the host or
   guest.  Instead, the host kernel uses it to populate the MDS
   vulnerability file in ``sysfs``.
 
@@ -189,10 +199,10 @@ features are included if using "Host passthrough" or "Host model".
   affected} in the ``/sys/devices/system/cpu/vulnerabilities/mds`` file.
 
 ``taa-no``
-  Recommended to inform that the guest that the host is ``not``
+  Recommended to inform the guest that the host is ``not``
   vulnerable to CVE-2019-11135, TSX Asynchronous Abort (TAA).
 
-  This too is an MSR feature, so it does not show up in the Linux
+  This is also an MSR feature, therefore it does not show up in the Linux
   ``/proc/cpuinfo`` in the host or guest.
 
   It should only be enabled for VMs if the host reports ``Not affected``
@@ -214,7 +224,7 @@ features are included if using "Host passthrough" or "Host model".
   By disabling TSX, KVM-based guests can avoid paying the price of
   mitigating TSX-based attacks.
 
-  Note that ``tsx-ctrl`` too is an MSR feature, so it does not show
+  Note that ``tsx-ctrl`` is also an MSR feature, therefore it does not show
   up in the Linux ``/proc/cpuinfo`` in the host or guest.
 
   To validate that Intel TSX is indeed disabled for the guest, there are
@@ -223,6 +233,38 @@ features are included if using "Host passthrough" or "Host model".
   ``/sys/devices/system/cpu/vulnerabilities/tsx_async_abort`` file in
   the guest should report ``Mitigation: TSX disabled``.
 
+``bhi-no``
+  Recommended to inform the guest that the host is ``not``
+  vulnerable to CVE-2022-0001, Branch History Injection (BHI).
+
+  This is also an MSR feature, therefore it does not show up in the Linux
+  ``/proc/cpuinfo`` in the host or guest.
+
+  It should only be enabled for VMs if the host reports
+  ``BHI: Not affected`` in the
+  ``/sys/devices/system/cpu/vulnerabilities/spectre_v2`` file.
+
+``gds-no``
+  Recommended to inform the guest that the host is ``not``
+  vulnerable to CVE-2022-40982, Gather Data Sampling (GDS).
+
+  This is also an MSR feature, therefore it does not show up in the Linux
+  ``/proc/cpuinfo`` in the host or guest.
+
+  It should only be enabled for VMs if the host reports ``Not affected``
+  in the ``/sys/devices/system/cpu/vulnerabilities/gather_data_sampling``
+  file.
+
+``rfds-no``
+  Recommended to inform the guest that the host is ``not``
+  vulnerable to CVE-2023-28746, Register File Data Sampling (RFDS).
+
+  This is also an MSR feature, therefore it does not show up in the Linux
+  ``/proc/cpuinfo`` in the host or guest.
+
+  It should only be enabled for VMs if the host reports ``Not affected``
+  in the ``/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling``
+  file.
 
 Preferred CPU models for AMD x86 hosts
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.48.1


