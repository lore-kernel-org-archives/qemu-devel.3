Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79210CD1288
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 00:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsAkR-0006o4-Q9; Wed, 03 Apr 2024 20:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <industrial.reformer@gmail.com>)
 id 1rs6sa-0000Fx-Dq
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 16:06:42 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <industrial.reformer@gmail.com>)
 id 1rs6sX-0003ID-2q
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 16:06:39 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-430b7b22b17so1372931cf.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712174794; x=1712779594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hoMK1z3eyH96druCqszdNPMvpWOpH9snoZGMInjC0k4=;
 b=apQjt/NET29eUYQUpse6zcm+3qWixFD7+YhS0v6WNiCEJ8G1H6JoF97KxoSZ7wu10s
 8vMekgEyoGNoDh284YpJZbUIRtR5Iam9vtGNezSJYnE9mVFL9jYgOXOQEMUnjNP9PSMq
 VT2NhiRn+dTPg9xLCfbtX7G3A9dz9nAsGtZLCAp5rzotHI6sadH+gv0E0KNdbNy3H4Fy
 b1Je9fl+BKjnlwFiBVDWvr84wMKtwTiNJ3B48+TqDAd1ynW5pAX2rXsqNYdedqAQjXBB
 nDun4wwov4+mhJ+sN677r2gLHKAYC2SJ4wauzt/hQhDJzNql+zTrp6dQQ/sJ5hr+b7pW
 LvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712174794; x=1712779594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoMK1z3eyH96druCqszdNPMvpWOpH9snoZGMInjC0k4=;
 b=deoXUmfVlcBAB/EyoiHmlF+QD/aL2zt6/o3wUxFKbXjBkaZyLhrgfgUmDtg6OP7e1Y
 AFK4Ks8fNg1LyAbJ886zo1nA/SRVWtVcorqJpCLZtsg0X+zzaIlv3ToeyGgwAF/W6oN8
 FGPbm60FePwrQhByfrYr9NTJ5KzrZNG1uLNeUGjYr6IYydCBFbPMfbDweTjK7MgdRi/z
 +jgWSPV5D2uUfX4Aql9OM/cnav7U0vuVOvxVTMc7TsclKwWNiaiGWgfjTjvT6CXXsrcM
 IN9MG1zrx2VP+agwxup05UUgJxdA6NqfwddAAfvU2iRU1//0QWDKw37Ges0WDg2UC87O
 sgSQ==
X-Gm-Message-State: AOJu0YyhZdsvcowLEbkXS1jQayOmY9bsBuF09NUw4sTNaXGZQsWd5iOw
 iqH5elPzq9FYXKpPpKHhTzBkb2tr5SmEPDEBT6CpcNfkQTI0GJM7ru8SM8s+
X-Google-Smtp-Source: AGHT+IELF0XQchQUoq3bII5ZD+GIB/wVXpAah17GABhF9/dC77uSFL5cvpFsAh4v0sNE0uo8UIp3vw==
X-Received: by 2002:ac8:7d8e:0:b0:432:d2e9:38b0 with SMTP id
 c14-20020ac87d8e000000b00432d2e938b0mr333377qtd.31.1712174794569; 
 Wed, 03 Apr 2024 13:06:34 -0700 (PDT)
Received: from localhost.localdomain
 (static-71-191-40-244.washdc.fios.verizon.net. [71.191.40.244])
 by smtp.gmail.com with ESMTPSA id
 k10-20020ac8604a000000b004313141f734sm6820136qtm.46.2024.04.03.13.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 13:06:34 -0700 (PDT)
From: Ian Moffett <industrial.reformer@gmail.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	Ian Moffett <industrial.reformer@gmail.com>
Subject: [PATCH] hw/usb: Check cycle bit before trace call
Date: Wed,  3 Apr 2024 16:03:49 -0400
Message-ID: <20240403200349.2043-1-industrial.reformer@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=industrial.reformer@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Apr 2024 20:14:30 -0400
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

Signed-off-by: Ian Moffett <industrial.reformer@gmail.com>
---
 hw/usb/hcd-xhci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ad40232eb6..ea5bc64b26 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -710,13 +710,13 @@ static TRBType xhci_ring_fetch(XHCIState *xhci, XHCIRing *ring, XHCITRB *trb,
         le32_to_cpus(&trb->status);
         le32_to_cpus(&trb->control);

-        trace_usb_xhci_fetch_trb(ring->dequeue, trb_name(trb),
-                                 trb->parameter, trb->status, trb->control);
-
         if ((trb->control & TRB_C) != ring->ccs) {
             return 0;
         }

+        trace_usb_xhci_fetch_trb(ring->dequeue, trb_name(trb),
+                                 trb->parameter, trb->status, trb->control);
+
         type = TRB_TYPE(*trb);

         if (type != TR_LINK) {
--
2.44.0


