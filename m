Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82098CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNH7-00006l-LA; Sat, 30 Aug 2025 11:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhu-0000uu-Pg
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhs-00084W-Ti
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eskP7wGSMkx2uQO3NyABAeQ/Th6dfwDBwreOAQBKuPo=;
 b=UZShSfuBxoBBbXzxcFqzKjDokvT8R1D0W7VQkecauoa/c/tXF75F+6OYhnmZHoz9xVDpfp
 F0SbiViYFyDoxVCRVxM1d75WMlaETl2oprUsp3bQ+IBfjYq4zWPltLU/yBHDf52Ubfw7/R
 ZayY5wmAyTBtU6Xy0W48Cjqc0vzXyCs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-vhS8vOmgNHSIn5WTJ1x5Gg-1; Fri, 29 Aug 2025 08:59:49 -0400
X-MC-Unique: vhS8vOmgNHSIn5WTJ1x5Gg-1
X-Mimecast-MFC-AGG-ID: vhS8vOmgNHSIn5WTJ1x5Gg_1756472389
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b7265febdso13902195e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 05:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472388; x=1757077188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eskP7wGSMkx2uQO3NyABAeQ/Th6dfwDBwreOAQBKuPo=;
 b=qTZdNHpVseMXGnpOc8ulaHF4OySrcTX8k5YJE3Cf+CgEkQkornHnb6tuR6Mok/o2Um
 Q1/5WETFAejWwLmzsGhWbxB/Pl4BNkYKHARHV+m0BPnLD3NR8Ep/9zNCz4kYB01z2pyJ
 RYlxUw8d+asaHh+TvNE9IZmI/9za+yxMaGICLlb6wY17l7vd5dJQ0Nheaq5al6AQ6nah
 o5bXiKSFJ4ckpbWMRq9qMxkHPUTkgmJaUqJak2VZBZdv6BC+uWXyM8gA3UEpusA58Oku
 P3SshhYYsw/gRPI7Y1DgCy5w+JKUTUp/jgZg64oCaUU2WobLww7VBflDy7NQJ2Jqepuw
 dfAA==
X-Gm-Message-State: AOJu0Yx2eC7+JgYdsNvBoeyGEijP8iOd7eY3REVXy67k0hubsMTZv2IX
 F5ShLPJY9ZQDk3ipldnpVPrBdlgQg7mu3NvMZLoSd4Zy5xow8VHxNvW4OJmffPbTEc+jWaBfQ/H
 GU4vFU3XibQdhYi7M3OzYUk2jg7/yI3rdDawkSby3pY5kZO1Lf70cVg0FaI/ERXr16t397DfrhY
 FGkOxYrdfhBLfQ9sJwmB3v9GR8YWKdJ4jFRqV4z/DX
X-Gm-Gg: ASbGncurAPSp2cDAxcIYVb57qajzrOJTy9lk4N4THDGHokGRcSm6Qw7vDJS1d7kj+J4
 8NC/mJ7iYhxtCrZr7xbvTR38yWROcl3YD9x3SCC9HfZtCeraEHiN4eHZ8US1uMEEvb8dqEdJh+Z
 GnTfNoBCJ4/qw8G+1fFcGzvbb6WLHQcger9TGL1qMRZ8PXGKjr6Iyz2hrbHmwDbzjqnVHdtPiXA
 Db02YZKgJqQNgmLOthipJFZAUX9aC7ACjJDpR8oE+cZxPhmHd1Tp+5XkRJY6hFu93KFritUifeW
 K/KMn+KdvWd93ErOgXX08NkIMZRnUOdOsK5GZGoyqGFMeqhlEXQ5R4SqbUKH/xNAA95HRB49Bm+
 8gF+qhNp8iCZVRG5mJXP56UfzfhZSPmjJTtTLexviSvQ=
X-Received: by 2002:a05:600c:16c4:b0:45b:7e07:af4c with SMTP id
 5b1f17b1804b1-45b7e07b13cmr22096675e9.16.1756472388137; 
 Fri, 29 Aug 2025 05:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNKIkXCfFLWhM6a9uf7DBKbhrZNmDWLMJCRzxgtaKwZ14JTBev7AFZ9N4+Utt9WHdRzfP/uw==
X-Received: by 2002:a05:600c:16c4:b0:45b:7e07:af4c with SMTP id
 5b1f17b1804b1-45b7e07b13cmr22096515e9.16.1756472387666; 
 Fri, 29 Aug 2025 05:59:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e380b77sm41670855e9.11.2025.08.29.05.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 04/28] hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci() into
 pc_xen_hvm_init()
Date: Fri, 29 Aug 2025 14:59:11 +0200
Message-ID: <20250829125935.1526984-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

This helps to simplify the initialisation of the Xen hvm machine.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-5-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 351986232d6..8e302dc013b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -471,14 +471,6 @@ static void pc_init_isa(MachineState *machine)
 #endif
 
 #ifdef CONFIG_XEN
-static void pc_xen_hvm_init_pci(MachineState *machine)
-{
-    const char *pci_type = xen_igd_gfx_pt_enabled() ?
-                TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
-
-    pc_init1(machine, pci_type);
-}
-
 static void pc_xen_hvm_init(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
@@ -488,7 +480,10 @@ static void pc_xen_hvm_init(MachineState *machine)
         exit(1);
     }
 
-    pc_xen_hvm_init_pci(machine);
+    pc_init1(machine, xen_igd_gfx_pt_enabled()
+                      ? TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
+                      : TYPE_I440FX_PCI_DEVICE);
+
     xen_igd_reserve_slot(pcms->pcibus);
     pci_create_simple(pcms->pcibus, -1, "xen-platform");
 }
-- 
2.51.0


