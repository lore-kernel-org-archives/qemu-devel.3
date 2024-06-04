Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760C1C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwq-0006u2-Ik; Tue, 04 Jun 2024 02:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENw1-0004qh-BW
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvz-0007em-TW
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq2q9uxyAktwdcKYIxqUTltXlnnz0rVwX7EaTrp/tnM=;
 b=N3eQ/XqJ+KVCvu4leU2wabvzIm5RMw0dsR8+Mo6T4tdgTwfpuFQecU4m/gDNhzlPjJq7Wc
 hUwIi17L5uHkkPADEhppLBNkC+lGt9ZDiOOzFbZtg4Hy/VEo5aVVzcfPwCxDS/GXvXtY7C
 ++j1w0NRtoe3vZE9x7UrsGkoRDgzQuk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-HJ0qzlGrO9eBzsKR8cYQOg-1; Tue, 04 Jun 2024 02:46:14 -0400
X-MC-Unique: HJ0qzlGrO9eBzsKR8cYQOg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2eaa6f40e15so19454341fa.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483572; x=1718088372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uq2q9uxyAktwdcKYIxqUTltXlnnz0rVwX7EaTrp/tnM=;
 b=swcl/1v8h53gRpVlBaP4zbLIhxAxGVsV4RL0sU+lD5KRZkOKbVINTiI2uX/AqZSCFZ
 2AkBMIn4fTC2y3KWm9NWJini5uDxHRJfrcQ+Blt23rLEjQncy934cKQzmVNMV/3ZT/Tm
 7VX7qGFUrukoMpQSx8qwsP+ddedrrj5yynfYq8AfUa2snWKhsjNEqbYry/U6uz6xn8GF
 0OaxPwJYx/Mq0Z5C8sjZ7xUFe7kQHRg3tgqmNDk24ZOF18ErZIrDZgyyhmE5+iU3nPJa
 P93VMBjXfzt9SdwjqCeejZqnzZz0FEEjp4M2mMG5fnBBoJu390XaEHV56z282idTsoMi
 5twA==
X-Gm-Message-State: AOJu0Yyqc0TjOhwuLfYLtWVL5UvlgrMtCoWsD5xRSoe9xz+rMmBu4AWy
 8iDW4rhM8cfDo85rW2D8JdfXNW4LrLTqfSZRj5TwcL8TZUjv5Oxm7IwJ7rImPjcZyZ13kfxKqPf
 yq7RJn3HHHxWEdSVTFcehhsA4YTNW/GrtKF7kMnAt8+yc/ssIU6Bnytc7CYHK9p4RrLTfO/bUG4
 xExTJA1MQavKT/ZWuQIv4tPJckKG/tHzgjUSUo
X-Received: by 2002:a2e:9d88:0:b0:2e1:9c57:195a with SMTP id
 38308e7fff4ca-2ea951de27fmr90810561fa.32.1717483572081; 
 Mon, 03 Jun 2024 23:46:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPVSJacDWONa1Gd79Mcp5QwQL4/P46iBjL4ndcvKW/Tw1hXRofs0kZFlHIRgu0Ntnp0JDTUg==
X-Received: by 2002:a2e:9d88:0:b0:2e1:9c57:195a with SMTP id
 38308e7fff4ca-2ea951de27fmr90810401fa.32.1717483571710; 
 Mon, 03 Jun 2024 23:46:11 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea586910sm582398766b.113.2024.06.03.23.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:46:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 43/45] memory: Introduce memory_region_init_ram_guest_memfd()
Date: Tue,  4 Jun 2024 08:44:07 +0200
Message-ID: <20240604064409.957105-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Introduce memory_region_init_ram_guest_memfd() to allocate private
guset memfd on the MemoryRegion initialization. It's for the use case of
TDVF, which must be private on TDX case.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-4-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h |  6 ++++++
 system/memory.c       | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9cdd64e9c69..1be58f694c9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1638,6 +1638,12 @@ bool memory_region_init_ram(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
+                                        Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        Error **errp);
+
 /**
  * memory_region_init_rom: Initialize a ROM memory region.
  *
diff --git a/system/memory.c b/system/memory.c
index 9540caa8a1f..74cd73ebc78 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3649,6 +3649,30 @@ bool memory_region_init_ram(MemoryRegion *mr,
     return true;
 }
 
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
+                                        Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        Error **errp)
+{
+    DeviceState *owner_dev;
+
+    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                                RAM_GUEST_MEMFD, errp)) {
+        return false;
+    }
+    /* This will assert if owner is neither NULL nor a DeviceState.
+     * We only want the owner here for the purposes of defining a
+     * unique name for migration. TODO: Ideally we should implement
+     * a naming scheme for Objects which are not DeviceStates, in
+     * which case we can relax this restriction.
+     */
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
+
+    return true;
+}
+
 bool memory_region_init_rom(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
-- 
2.45.1


