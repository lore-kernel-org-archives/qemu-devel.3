Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F7606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbMiOX57
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzIn-0005wv-4W; Fri, 27 Nov 2026 12:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaynak.oguzhan0@gmail.com>)
 id 1xWzIR-0005pN-KF
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:59:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kaynak.oguzhan0@gmail.com>)
 id 1xWzIN-0001q3-6p
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:59:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so88418995e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795798773; x=1796403573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gX783G6huuYvPEgP1dNkTXKRxnJn9sjXNBPzajzwY9Y=;
 b=ZbMiOX57zsS7mDBMwTlQDwVb+YzlaObNcDBK1HHriCXPfbXcgqblWTuCx6Ix0TdvDj
 QXc2GLxFHbn9FOSWcL/qWZq0+TEPvtV+QwFCuFwx+NLafM3bA2v96rZCNxV+wSHp/7LK
 nbJV5UHDEDCYQGwGW94o8TsdhHVdxbcN90gxv+zKrrUTBJQoxRZcPeMuM9cM9eFzv9Te
 KZf9YxbqJKj+tgNrq+Qhveitsy6G8RM5ffEVvcji1n5vUKb0wIsn5zpR4hw2HylH8SwO
 VfugU0kfyil41hnxsF7YititEIPsioRqY+/bxq05ymONFYefb+nDRj8l4BR8IMHoRReT
 s4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798773; x=1796403573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gX783G6huuYvPEgP1dNkTXKRxnJn9sjXNBPzajzwY9Y=;
 b=xNR7V3WevT3dIIrMXXsMVdmSpW7R1wpGqrI7ogfe/KqMpVeTw9vy+uOuF/WAdVeXUR
 hdQuPE+64Vx5rip1wWT32MJAzQyfJ9Td16gP0H5j95de6alxHL2a645LP6KuFoSoIDOr
 WIvVl/ReKILTwYoXWHPDZ+dHsq+8esoqdlJIeSw/2PaX+VZJtpoXxsAc6XyYzmC81hop
 MgjeR4IEde9GZX4c+WfceimmXAnBP9klUTnnQgMzmUuOJVB7/kfgiP80EaEONNKe8HPm
 +IGuJRgNFE1jilupwclYwyzr89yhlhckNUwLJ5KlQdO67XdKXoi9meX1eSzNbaqF9FQP
 0qRw==
X-Forwarded-Encrypted: i=1;
 AL+hErE7KTYVAoYtcGkQi0WcZofxt1S4gibD4Ku1DCcty47QYMK4utZAZSlh85sQyjQT6QjEoEk6V3my25zF@nongnu.org
X-Gm-Message-State: APuU4Z8EvOoihkDXujXLcsioEkPyK4Yl4Rt5rKcLkszrGRYAxQGSCIdJ
 w9Vcg3nqMLbanln/fZhV2r06+KN1qdetYsS4xr3rpyuI0N0SZQO9SmVY
X-Gm-Gg: AZFdTZdqStNQT/y3TZvy5hZKfUnoQU46bTjRympKGhBY20ldL6rHWnZ7y9dsnlpLKBr
 z3BrJHcxyVsA2ZVvd0qlxiSEx7RA+TVeN8ckJy+uuGaSj/LtBAFREhiSAijdCsOQrK7zOpl2hOi
 Yz1EqaEBKGADyj9brmqI9UDHZb6k9fDmZTiFO/lQTCPbDNcC5cvC3/62ZgAKs0kPjXeM+NI5PsP
 mblwtsXkDA6s9S+eF/xzyvqgc0uqjdrb7CoTilnu7xjLx4q/nYB9FyiE+09iFBniH8mabPVjFc6
 5Hsd7jjIBQP3t67qupeBy7Z9wuRB1uuP4gbcmkRCLYBcdTtRztzgn6XPHW0STpcApZmvzppA4/v
 ThvFAoi6NnBC+fl+f+OhLrdI0Hj+zXrn6SEHcSGnIYFtwVfffQd1auV1sBMFyHhws7euPxYDkmX
 PWPn6hhTr/ijYimMaALtWau1172GEhe9VT1dI+CXxwd9UXFxlQATyEhG2BxxoyXubEaFQU8LpOk
 osj8tWrVRvVdTWrQujjOw/U9ef22c6bq3nn3swqz+6EokLF/A0qMkZQZvEbQkgHc3EzP0SrAkGJ
 j2dNbrj3sswud+Vq1f0SoLbQTAE23+xcyCkYZX/LWKxHwcPQyL5qJOgg2uq2mKdB0PuQ+qCtQbu
 4NNedU/cvHyfWmD6bF1/HalOsOONhsiyPD3cR80vW226ITzi1Jo1eOuOOsTnqaWetM+Bb1SWL8M
 I126hTPg0hO7OrE3J/dOZ9ZNbvqb2ulqYfWg==
X-Received: by 2002:a05:600c:5246:b0:4bb:6de4:2f7c with SMTP id
 5b1f17b1804b1-4bb8881c5bdmr527273975e9.20.1795798773352; 
 Fri, 27 Nov 2026 08:59:33 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110d56sm47642046f8f.40.2026.11.27.08.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:59:33 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>,
 Hugo Komatsu <hugo.komatsu@nutanix.com>, qemu-devel@nongnu.org,
 Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH] vfio-user: block migration
Date: Fri, 27 Nov 2026 19:59:22 +0300
Message-Id: <20261127165922.66105-1-kaynak.oguzhan0@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kaynak.oguzhan0@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vfio-user devices lack a migration blocker, so migration can complete
successfully without transferring device state. The destination VM is
left with an unconfigured device, for example with its BARs unassigned,
and -only-migratable does not reject such a device.

Block migration until vfio-user migration support is implemented. Block
all migration modes because vfio-user does not support CPR either.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/5002
Cc: qemu-stable@nongnu.org
Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
---
Discussed in:
https://lore.kernel.org/qemu-devel/awjCxgCwvDR0vViz@lent/

 hw/vfio-user/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e3749cdd39..d3ae2c150a 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -11,6 +11,7 @@
 #include "qapi/qapi-type-infos-sockets.h"
 #include "qapi-visit-sockets.h"
 #include "qemu/error-report.h"
+#include "migration/blocker.h"
 
 #include "hw/core/qdev-properties.h"
 #include "hw/vfio/pci.h"
@@ -284,6 +285,13 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+
+    error_setg(&vbasedev->migration_blocker,
+               "%s: migration is not supported", vbasedev->name);
+    if (migrate_add_blocker(&vbasedev->migration_blocker, errp) < 0) {
+        goto error;
+    }
+
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     if (udev->send_queued) {
@@ -358,6 +366,7 @@ out_teardown:
     vfio_pci_teardown_msi(vdev);
     vfio_pci_bars_exit(vdev);
 error:
+    migrate_del_blocker(&vbasedev->migration_blocker);
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     vfio_pci_put_device(vdev);
 }
-- 
2.34.1


