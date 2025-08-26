Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ABBCA0FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 20:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur0i0-0000d1-LU; Tue, 26 Aug 2025 16:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Sh-uaAwKCo04rszyv9Avwr4x55x2v.t537v3B-uvCv2454x4B.58x@flex--nabihestefan.bounces.google.com>)
 id 1ur0hs-0000cL-2k
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 16:55:52 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Sh-uaAwKCo04rszyv9Avwr4x55x2v.t537v3B-uvCv2454x4B.58x@flex--nabihestefan.bounces.google.com>)
 id 1ur0hj-0001ph-95
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 16:55:51 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-24458264c5aso65145245ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756241738; x=1756846538; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=XLWQ6+awZKXTItHiME+BnTYtxfVMRnSFUV8dpp1zUQ0=;
 b=eNT5ERNBA4Lo/uCP2/JRSKJ70Kz3KTw0vHE+iQss5cTNIwO49XWaz0u+c5KSPdIigN
 Zxq/RYgbstqK6/OGyzPx8cDaefHFLQMklKHDY0JiN8g6tL1kPkuoATPfLVyFytHCO4Pp
 mrNwIDOfECuDGEQMzN6W6FU0JE/3yzv+McrjPPNUEzw9oahLF+fJTqUFVfkh73r6nsRK
 5M5B7TM9PJ1x4iyZENmlZDVwU85Sp6+b4G1ckg5VsoGq8HagGN0N1iKZQwj5/bZwu5TP
 uTeQFbs70RN0/vnLFxhAAh1+dJpaqNuHoOZIgC9KFp1+9LnVK+OBuINw15nZNoDuEmY/
 K2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756241738; x=1756846538;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XLWQ6+awZKXTItHiME+BnTYtxfVMRnSFUV8dpp1zUQ0=;
 b=BS+SWUVZhWw/cYePxm4EANjW+JggiBkW5S17oz8cLXqTXaQ7aLbvNCPzY9y+pw2leG
 nZ2wIpM39feap8NCYYEc7vBL+n9m2Q3XMwUVOvBGrUxCCRbrN+us4Rw6W12Y46qZ+gj5
 IEbf5pkvLcBq4CVvPkjw/PbgZwirW/i2N9c93XvMrleLuf3nVslKV/02fB/ysyyT43jL
 PZZblm5mT64VlhP6Gi6tgRJUN81VTj5xY9lD4ovCSjsIsjsAYGMTEYky9ufDQg/SDoSR
 9KLH5wxK5JkVx+EvyAXo/06qVzF6kyL1v/ExZaU8lHQZc0cd5YofXLCIILHC63Xlb1jA
 XYOg==
X-Gm-Message-State: AOJu0YzIgiL/uOsuz/2CuG+hq94SAMvD2Mc2qtGqgFuaS4TRjqMaiSyO
 oL014V7sqPBQ2sH0wXItYl0FEaDEh6j+Iig0g8rfL2YBD1LW4MnxSB9cRT3SKDEssVTpPLw5r0f
 iuOwnBfyjTEwepUwoXFjA6+0ka2cFm3x33QjfwMrqtKPHHtoG+/w3dJvkPkps5caEasPts55Mbw
 8hq8saNi70uXSb+FKwr3+UK8roYoimnoGhTXAriIojXomYBzq+EAf9gMb234r6RSOCr+o=
X-Google-Smtp-Source: AGHT+IGGDVwy+ziI7XLSI546Hqn6ytIgWQ7BntNvFob5H3QNBypzvmK5KxyDaoC7YhFbqGdgsxOUAXFThezmjpWY0Fk=
X-Received: from plbla4.prod.google.com ([2002:a17:902:fa04:b0:248:80ba:9ee0])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1acc:b0:246:6442:19e4 with SMTP id
 d9443c01a7336-246644231c4mr168828955ad.58.1756241738308; 
 Tue, 26 Aug 2025 13:55:38 -0700 (PDT)
Date: Tue, 26 Aug 2025 20:55:32 +0000
In-Reply-To: <20250826205532.1500639-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20250826205532.1500639-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826205532.1500639-3-nabihestefan@google.com>
Subject: [PATCH 2/2] MAINTAINERS: Add entry for PLX VSwitches
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 venture@google.com, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3Sh-uaAwKCo04rszyv9Avwr4x55x2v.t537v3B-uvCv2454x4B.58x@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add entry for MAINTENANCE of PLX Switches

Change-Id: I7592518c96af89fa2722c409b78ebc7e34acdb84
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76..fb90b4b36f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2098,6 +2098,12 @@ F: docs/pci*
 F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
+PCI PLX VSwitches
+M: Nabih Estefan <nabihestefan@google.com>
+S: Supported
+F: hw/pci-bridge/plx_vswitch*
+F: include/hw/pci-bridge/plx_vswitch.h
+
 PCIE DOE
 M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
 M: Chris Browy <cbrowy@avery-design.com>
-- 
2.51.0.318.gd7df087d1a-goog


