Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F67C52D6D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 09:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saX8M-0001d6-MF; Sun, 04 Aug 2024 05:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX8B-0001Ne-BR
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:27 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX89-0001Cg-NG
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:22 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ab34117cc2so6270833a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762140; x=1723366940;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4tfsLBSp5P9Enjc3prc0IqWrh95La08LAkdzlIXsS/A=;
 b=SIdCVoD4T0C3Z3WnwPWzxzTokka/VMmqMXCcjPq623o5Vzk8dRzzSYwkjmRfz5QZGe
 IsY4K+FFGwEpTbgDcDsibHdGR9B3n5VjDzNiZRwn65D3YY7F+LrFOSbiWqJkPnbm71W9
 8fR813/mGyjFUmfzJ8j/iZENq0AFmW4WWTBnas4SQlxdM7npkwkD6tlUUdtc1RHDXdMQ
 z1QWRIsQjsmNvylgFz5K5sOGKi9kvFL5r27bc/jsTgP4OzK9syRSCj2462MSZwM+sWqh
 e9J3SkGIbJI3nKFCBdNiYmg6K4U8G7QgtyvZY1xwCUxvUvS6Ekn5TCbLDaFOSCmDhz9j
 D1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762140; x=1723366940;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tfsLBSp5P9Enjc3prc0IqWrh95La08LAkdzlIXsS/A=;
 b=mX8KOiUvwFFUapgxEaPcbf7JLWwvzgKFBu5kWzppMiZITpcivYyEJXs7behLkN9WRe
 jQj6TscsiOO1SdFNDJeQ2z+/WkqG6ZzkBg0Ot6KqLALlROsF3IlYdKUZ8VbE19Z0Etu/
 niymtP/vPLz3C6MB/3vRuK3+8QicCQEdYLT+pkVheK/tzClTSd1zJX0ZkP7Q7kdJ4pll
 GdHi2k93IuPmIQuhbp/eKi+xokjks0MMBgmV8hpVZ3RzyB0T+gN7Tk0z5xTJoYdGI59j
 d5gDf/gzZdjSisQ4W/P9Um8wDAo2EzwsctIa6stTErGM7gzLZfqZFPfgGMn58QVVAUpq
 Xokw==
X-Gm-Message-State: AOJu0Yw2RoHQ7gl6YHeSkH8FLwudjqpH2ITdwzICXPgOd5zW//9RuGEj
 8BeQL9lrG2LRELAO3/R96EwV0msQh02T2L5/YStuckQyEnRjbPWSBHd5ssc3iJM=
X-Google-Smtp-Source: AGHT+IG27Fp4WR8hpKUwyCNT3d2754w+qcOovL4tQ6FOiPucwI8PpeN/WObFFL9a+eRY5eZoTm6zIw==
X-Received: by 2002:a17:90a:db12:b0:2c9:65df:f871 with SMTP id
 98e67ed59e1d1-2cff9430e17mr9434670a91.15.1722762139908; 
 Sun, 04 Aug 2024 02:02:19 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cfca2a8330sm4525031a91.0.2024.08.04.02.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:02:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 04 Aug 2024 18:01:43 +0900
Subject: [PATCH for-9.2 v12 07/11] pcie_sriov: Release VFs failed to
 realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-reuse-v12-7-d3930c4111b2@daynix.com>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index faadb0d2ea85..9bd7f8acc3f4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -99,6 +99,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.45.2


