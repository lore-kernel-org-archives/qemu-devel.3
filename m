Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79101CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBeNL-00065v-1X; Tue, 29 Sep 2026 16:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xBeNH-000655-2a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:24:27 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xBeNE-0005D8-Mr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:24:26 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so34987885e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790713463; x=1791318263;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kS3uCFMZyn6plfeHWN+FNCEZUTBvhmjHhCngGT2STbk=;
 b=Z+lhGTQn2SWI4E1mfbkjCsyCxwGuUAk9wZz6VLn2AisIJ2Ca1DBc3qmtcGmywJsTzE
 yaU8MDzJ7htoNK4esnyxy5VLXh9K+hV0yBGsvobd7f7ya5KpxCHyxqcGfo+pHHrvmOBo
 ggXr+tf9FQtvSpMShxQiaE2XkINqYyZXjiitDEQZwmTk2zLDG0adElhUx+/ooFtlIQwh
 S5wauGtGGu0lppH5vOzdyeA55jr7ifzpLeIMq41jkhLw4B7ZLk6rj9047FUC27HRD/0K
 kqJ8Midpml1u3zdSkGfBMbAd3IcopR9fuAHAMrWTfSj6FTXhngfe6321pkIK+7pDSTKa
 WcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790713463; x=1791318263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kS3uCFMZyn6plfeHWN+FNCEZUTBvhmjHhCngGT2STbk=;
 b=JY4WeJN4/cj7J+LSDBZ/vwtarV7uRBE6NhAY2YEbm70jmOpfMNS3CHsS42TsYicx+n
 kjtGa3BcUk/72omQPCGkCVrk5lWNLY4horQ8Csq0UdTpSk3XogAkeZ4beDw/N6OjBbZk
 Caa76gf2G0GaxnRSJknQ0L4F02UpuI0rk/18jScWftjy7m9v8FuhOuSClI2+epvXmrA9
 r7/7Oy6uUY/O/V1u68338UxIPOb7JZHq1KPR5rT40GcDhA59IAQS17KiL+vbld6LGYru
 mwHZn/rw8oK270KifBbZLn8WjZzKbJhMVW1hqSZ0/nVYnty0Jfh90RyZ9dbTGfwvYgST
 taHg==
X-Gm-Message-State: AFuF++nzVccc0KX5OBwGHnUlvV35yrmfnXnoHTWyB2Qs69RzabZbJtem
 STehn7BxRKdFZSvfvhMKe7H2Lt7pvAMEgStrpUzf5eg7FDoUeX15OwcixQ65duQhXSkfXXGi6jO
 PHjozM8M=
X-Gm-Gg: AYBFou2me4p8noWdstjckZuX+f+S+qzW21gGOCfbOaADIi3h9WD6Hp0Y6dvij9aQkfI
 rzRomRDLW+C7P6FQ7gQQOa3CpTz07CK8fsBemLJYA2THueRAyYlyE7d7AjFfReChR17nStIQupN
 km4IHpjcrgtdg/yOB9j6ghuNtI+4Hox5DeL6sLPEtuv7nZbmfEEWgoNZtGqV4BHVA1e1hhlHdvs
 PBhSBVPAaGfdonAUgVq6j1CKnOyUq2mY+YODg8zqN/ie2LP1WiOoWKnT6YhbZiJKRS2x46A8mw0
 NLzlCN709aGM4ulaPIzFGFON3ph7iEvVMTjBjMv7bziKOCqH2OaV8lvomC6un/kVSIW++wnUUp0
 pfAU+Qsrgk/nOnZnwGGDijUa5cmSIdIuuhhf1agCjWghUkc/Rq813qDIJx1TwE1lVl8ajC0PQsI
 84/oLLwtd3JXN4O9mrCrh81YAFbdCNuK7vmidhzfGe3J6N9EPyDjpS4rQN6+vv8j3ectlNFrhsI
 QDxJb/BgyliWZqh5hWVYCJ3DteYhOyKBRbnA/7PSNwieil0Bwlk5qeu/xMbOAYDRA==
X-Received: by 2002:a05:600c:3103:b0:49e:81db:4926 with SMTP id
 5b1f17b1804b1-4a01502fbd0mr3472175e9.5.1790713463290; 
 Tue, 29 Sep 2026 13:24:23 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a014f77aa3sm7021525e9.7.2026.09.29.13.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 13:24:22 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com
Subject: [PATCH v3 1/6] pci: Add device ID for CnuasNIC
Date: Tue, 29 Sep 2026 20:23:52 +0000
Message-ID: <20260929202358.725310-2-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:31::10;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Reserve device ID 0017 for the Cnuas virtual network adapter.

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 261b0f359f..271f61bb81 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -100,6 +100,8 @@ PCI devices (other than virtio):
   PCI UFS device (``-device ufs``)
 1b36:0014
   PCI RISC-V IOMMU device
+1b36:0017
+  Cnuas virtual RDMA network adapter
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a..99a31856d0 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -121,6 +121,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
+#define PCI_DEVICE_ID_REDHAT_CNUASNIC    0x0017
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.43.0


