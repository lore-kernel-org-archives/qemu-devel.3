Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51748D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpm-0008Je-Um; Sun, 03 Nov 2024 19:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpb-0007up-LR; Sun, 03 Nov 2024 19:20:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpZ-0002bx-Nm; Sun, 03 Nov 2024 19:20:30 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so27049085ad.1; 
 Sun, 03 Nov 2024 16:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679628; x=1731284428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a32Tkb6cgQgEoNiKG2LmEIL3IAjBbIhO9o5SQGsOa7g=;
 b=cCGc/UCZ40lLeteUtoJsVEsVZJty6qOxYZYN5ni9Lp+5kMSx6vpiVSB6o5CwwYdcN+
 oZoodmPKQphd408d1mZjBnCl6UdO8aWPblkbB6WFK/bpRUs3YDNAIE5GXAbgqo6iRwGW
 glhnAMdUDpUn2ybgYXWjxvt1MPQVVTegqSf3hGX5pIwv2pX9lkFdRp7Wg8vf5VjBBcj7
 0qZeiSO+1N4VAzoMZqoDKEnBAIb+o7B8PE/PN0tvygvRFTqlvQdx7BZmJo4CytT+xYci
 Yn+ZjlTkJferx12/6P4JzBrvp7mLKW2/F+Nc6O014JM/AhZZZ6RgsDMzmzxpP3ZBw4a3
 QJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679628; x=1731284428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a32Tkb6cgQgEoNiKG2LmEIL3IAjBbIhO9o5SQGsOa7g=;
 b=kCGxYxyjBSm3acIcq+WnwxaL9yDTWbbUR5iIqnrj60bOvr71b0CMJ7vc8lWsU8QFsl
 uew7TDzWqXt94Q28828/e9rG/4ar95AaNfho2Y/57z4/BMCmlcxlqKGVoUlfE9ZBwZTd
 1+2A+ZTKyQxliE5BCTsyP8k74Xleb5NCt2xazZiUHwq12amwk+A8AfJcSn07nq6fJBY9
 sFwHaPASNivIsQxrwktYh0L+siOcti02J1+nUkUhEllYrvlHhjU1HXgE55Fez6xxMHMv
 S1JJrJvaHU6LTa1d7IHgoZndUbzyx/9AxKTpMLha+KMEaMfKUUxUMlOYxBmbN9JouLXO
 yXag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQXqoFNvLIPaQ9YSKOAKR3nYnympby3uExbiZVU4KI7FeBGMlL3T9eBx6kCePN2Hne2uND3oe0Fg==@nongnu.org
X-Gm-Message-State: AOJu0YyL+1oGSZiRyH8VE7OyKyjgX2IeNmo5uXIM6R37pnej/hs3m3mv
 6H/KShiYywxfO69z5rN2PisCfEXvExHCaFfAXQIRsW3q4+3QU5gXI+SVIg==
X-Google-Smtp-Source: AGHT+IHVE2bsLwaI/4osk7AHI9dQFr+yYRHKHw8bcSzkluxoslAou7s/UHLJfuf/3JrZJ+H61EAf1A==
X-Received: by 2002:a17:902:e849:b0:20c:7485:891c with SMTP id
 d9443c01a7336-2111b01c70cmr153675705ad.54.1730679627828; 
 Sun, 03 Nov 2024 16:20:27 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/67] ppc/spapr: remove deprecated machine pseries-2.5
Date: Mon,  4 Nov 2024 10:18:10 +1000
Message-ID: <20241104001900.682660-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.5 specific code with this patch for now.

Also drop sPAPRMachineClass::use_ohci_by_default which is now useless.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 25 +------------------------
 include/hw/ppc/spapr.h |  1 -
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4d7705c89f..f63843d107 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3070,11 +3070,7 @@ static void spapr_machine_init(MachineState *machine)
     }
 
     if (machine->usb) {
-        if (smc->use_ohci_by_default) {
-            pci_create_simple(phb->bus, -1, "pci-ohci");
-        } else {
-            pci_create_simple(phb->bus, -1, "nec-usb-xhci");
-        }
+        pci_create_simple(phb->bus, -1, "nec-usb-xhci");
 
         if (has_vga) {
             USBBus *usb_bus;
@@ -5300,25 +5296,6 @@ static void spapr_machine_2_6_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 6);
 
-/*
- * pseries-2.5
- */
-
-static void spapr_machine_2_5_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        { "spapr-vlan", "use-rx-buffer-pools", "off" },
-    };
-
-    spapr_machine_2_6_class_options(mc);
-    smc->use_ohci_by_default = true;
-    compat_props_add(mc->compat_props, hw_compat_2_5, hw_compat_2_5_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_SPAPR_MACHINE(2, 5);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 1821ef96c7..6e9e62386c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,7 +143,6 @@ struct SpaprMachineClass {
     /*< public >*/
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
     uint32_t nr_xirqs;
-- 
2.45.2


