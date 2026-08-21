Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227FCC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1K-0001Hd-Ju; Fri, 21 Aug 2026 07:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN16-0000mU-5Y
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN13-0007Vn-Gl
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso7253375e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310148; x=1787914948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SIQ95ChhMBEDMeksGTqzOnHzqdHd6VFFDSZ1sW5capc=;
 b=SYouMwDTcaukeY8eP4XUidDZJ/b40uS0bYVf2Z/Wxhc+/aJRu3Wlcc4TtRDqhGSmzI
 KXGsJBmNboDsuFLOotn5fblmAUxQ0WwzqUAai7Uzj7Ib/VecyVapJ6ryCcd0vrXs51wU
 4WegKJmmta8qPPjV+TmQNoHPi/eil3w+o03qbjhE3RSyi+cYr7CIigAsCyDOubsWWi7U
 4ABq+yLIGb76f6yZnWAcGZ4feODdcrAilg2qhflv9twgHf2YJRkY123jCAKS3gDxO0A4
 ShR+I4N650nJ0sYGHNMEzeHageqAf0tUE9/ruAHgG4W2zDCIw5zWpgensZ1dG7Clq2GZ
 tz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310148; x=1787914948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SIQ95ChhMBEDMeksGTqzOnHzqdHd6VFFDSZ1sW5capc=;
 b=NWzEqINuFPCs9FpLm1VSTr3wSuaBdJH0/O2V5WQSmjodZ+vi8udL+HdgYPXB3VKw6F
 +w5MlDJCMMHoOjTgkwxI4LFImNARHhK5FKIXoscnIM22NTEmzOxuF0hFOvn3esNeQJZa
 bBxVVUe0VC30dxA95cRTVzpJVlha6HTDtNkk999tz447iky1WANIRRiamYyXmzZKHF5O
 O255m2fSJlQgls/ZUk+CzUBPhce/xo64GToCQT27eMRThanR3UTzKSseVZwsjpVHkbQZ
 tVMnYJjg4VjgqFRuY7vS9JXOHnTkVVbf+FUJk/T1CnSQgdWLOUel+mletK/dGzUonwN7
 khwQ==
X-Gm-Message-State: AOJu0YxTJnwTdkWSY2tQeKsVrXs7LzdG78oDHoVUIkeRq6UZKu0UnG1P
 EbnJJxZuy83McvpVNhRmdDOsmnJ6q/8KWq6bdCX9es9SnRe6i07WFwHK6nn7Wvcpmd80tpBRnQE
 ElMA1
X-Gm-Gg: AR+sD10muUoDVC6+I64YL1EJml/JYd5gSV0dlYBrrMU2e4O1VCLzj6CutG0+jToYym8
 N0e9bDCcflgZcyDSd0c1Kah1XiRPKPvnGC1ViPr3ZtUzCxwQbKc5CViDd4b6fvRGFMJ0nuls/Au
 ZBHnzEAlZnDoy/BlDRW+JWV/HOxVvJzRpXde2EYKYRFZcsM+BT6EmsVKLstuD1TlOncFpoDiPgG
 7HAHv25Ob5cCk7VDOhf1mZxkdsc39wqJZCrTHLtxt46BzKudwST6PRq9Yk7RkwkUNqxZ8j8tct1
 1BQTA+ZNKzeFhgtD23b9H6TQuKnjnxLklL0FjaUWTUxjZXWQgmCridiv63V9KMcQ8hIMMwZg4uV
 N++LQRbYyntNF7612QyssJS7U8ZPErzm9R8T4zZP3KLYOu4EJNlRrvhqZiPe3gQiMsC1C8JsWou
 Tg8mr9oKjJLMMO4ldIy0z9VRuYapnWtgHGr6UyKSpsA19CCgR2uKGjNBBK9BkChu5IhAmcf6skK
 bvg2eB/IlZVyys5MGmXM+UuyNztVxxotoqUXeqvjlyJ367S/LZIQD56/Icoy2hSHMuVvA4+AS9J
 wagl
X-Received: by 2002:a05:600c:c4a6:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-499b82f4090mr88635515e9.1.1787310147728; 
 Fri, 21 Aug 2026 04:02:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/43] hw/arm: collie: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:45 +0100
Message-ID: <20260821110101.3971391-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Bin Meng <bin.meng@processmission.com>

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move the boot info into the existing CollieMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-5-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/collie.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 91f0a94b6ff..01d74ad38cd 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -30,16 +30,12 @@ struct CollieMachineState {
     MachineState parent;
 
     StrongARMState *sa1110;
+    struct arm_boot_info bootinfo;
 };
 
 #define TYPE_COLLIE_MACHINE MACHINE_TYPE_NAME("collie")
 OBJECT_DECLARE_SIMPLE_TYPE(CollieMachineState, COLLIE_MACHINE)
 
-static struct arm_boot_info collie_binfo = {
-    .loader_start = SA_SDCS0,
-    .ram_size = RAM_SIZE,
-};
-
 static void collie_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -66,8 +62,10 @@ static void collie_init(MachineState *machine)
 
     sysbus_create_simple("scoop", 0x40800000, NULL);
 
-    collie_binfo.board_id = 0x208;
-    arm_load_kernel(cms->sa1110->cpu, machine, &collie_binfo);
+    cms->bootinfo.loader_start = SA_SDCS0;
+    cms->bootinfo.ram_size = RAM_SIZE;
+    cms->bootinfo.board_id = 0x208;
+    arm_load_kernel(cms->sa1110->cpu, machine, &cms->bootinfo);
 }
 
 static void collie_machine_class_init(ObjectClass *oc, const void *data)
-- 
2.43.0


