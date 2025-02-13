Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BABDC021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYjP-0005Qy-7F; Thu, 13 Feb 2025 07:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <madmarri@cisco.com>)
 id 1tiYjL-0005QT-IH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:54:11 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <madmarri@cisco.com>)
 id 1tiYjJ-0007kw-Vf
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1077; q=dns/txt; s=iport;
 t=1739451249; x=1740660849;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vfSbWWpJrourxmLHfdvWizUEvZuT+2R0zTs9XRrc2X0=;
 b=MevPAWMd+19mrBs4tUCjOAdiC1Z8b2OJpKm5unwK5GkqnUw42D9txbKX
 /c6KfeJO5fsdOTAZXea22N3okqATIHDD2jW1uT+xWPIILJUvTjdY/4wYR
 rmEFo3+RKIx21CmPv1VPnpXiPGYGIYxxGPb3sFwPgIF4Y4+pRBso3SG9c w=;
X-CSE-ConnectionGUID: Q3yWZKx1Rf212ey8hNuMTg==
X-CSE-MsgGUID: gHTXTbpfSO2lZTY7CGRsCw==
X-IPAS-Result: =?us-ascii?q?A0ATAAA16q1n/4z/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBAYJJdllDSIxyiVOaEoQFgSUDVg8BAQEPOQsEAQGFB4sLA?=
 =?us-ascii?q?iY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4V7DUkBD?=
 =?us-ascii?q?AGGBisLAUaBDESDAgGCZAMRrlOBeTOBAYR82TiBaAaBSAGNSlcZhHcnG4FJR?=
 =?us-ascii?q?IR9gQWEC4V3BIddhzCDeplTSIEhA1ksAVUTDQoLBwWBcQM1DAswFYFGQzeCR?=
 =?us-ascii?q?2lJOgINAjWCHnyCK4RXhENeLwMDAwODMoVYghKCDIlNTkADCxgNSBEsNxQbB?=
 =?us-ascii?q?j5uB55JATyEJgGBAwosIoEvk2ckAZIqoQSEJYRvhymVLhozqlIuh2SQaooHg?=
 =?us-ascii?q?32WRIRmgWc8gVkzGggbFYMiUhkPji0LC4NYxzElMjwCBwsBAQMJjUCEQQEB?=
IronPort-Data: A9a23:PyoFpatCn0HhODR0QP0duKVSOefnVAdfMUV32f8akzHdYApBsoF/q
 tZmKTzQOP+CMDP9cosnYNu//BhSvMLXx99nTlZorHs9EyMXgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYzdJ5xYuajhJs/ja80s01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIww71mPlNt5
 aUiJmpUNB2S1+KQ3ZeHRbw57igjBJGD0II3oHpsy3TdSP0hW52GG/6M7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtPYH49tL/Aan3XdjRUrVuPv6sf6GnIxws327/oWDbQUoDRH58Izh/H/
 woq+Uz2Ii0qCNaHxwGiqHaeut6QtgzBQ6kNQejQGvlCxQf7KnYoIAQbUEb+rfSnh0qWXdVZJ
 EoJvC00osAa91aiXtT5dwe1rH6NolgXXN84LgEhwBuGxqyR50OSAXIJC2YaLtcnr8QxAzct0
 zdlgu/UONCmi5XNIVr1y1tehWra1fQ9RYPaWRI5cA==
IronPort-HdrOrdr: A9a23:VisY/KkjM9Fnd0cbYesiHo7msQHpDfIn3DAbv31ZSRFFG/FwWf
 rAoB19726QtN9/YhAdcLy7VZVoIkmsl6Kdg7NwAV7KZmCP0wGVxepZg7cKrQeNJ8SHzJ8/6U
 +lGJIOb+EZyjNB/KLH3DU=
X-Talos-CUID: 9a23:DmE6sGwjPNb+Lh8FBOz6BgUtQdEaQF7NlU3eeRbiBHc5SJuIbGOfrfY=
X-Talos-MUID: 9a23:V8R23AY7UoSy0eBTuB/QtA1oLMlTxP6qOnw8zr4pgdKvKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; d="scan'208";a="432258171"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
 by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Feb 2025 12:54:07 +0000
Received: from sjc-ads-7373.cisco.com (sjc-ads-7373.cisco.com [10.30.220.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 5C41E180001FC;
 Thu, 13 Feb 2025 12:54:07 +0000 (GMT)
Received: by sjc-ads-7373.cisco.com (Postfix, from userid 1839049)
 id E2462CC12B5; Thu, 13 Feb 2025 04:54:06 -0800 (PST)
From: Madhu Marri <madmarri@cisco.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	xe-linux-external@cisco.com,
	madmarri@cisco.com
Subject: [master] [PATCH] usb: Check USB_TOKEN_SETUP in
 usb_ep_get(CVE-2024-8354)
Date: Thu, 13 Feb 2025 04:54:03 -0800
Message-ID: <20250213125403.4138883-1-madmarri@cisco.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.220.158, sjc-ads-7373.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com
Received-SPF: pass client-ip=173.37.142.92; envelope-from=madmarri@cisco.com;
 helo=alln-iport-5.cisco.com
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_NONE=0.001, T_SPF_HELO_PERMERROR=0.01,
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

USB_TOKEN_SETUP packet not being handled in usb_ep_get function.
This causes the program to hit the assertion that checks for only
USB_TOKEN_IN or USB_TOKEN_OUT, leading to the failure and core
dump when the USB_TOKEN_SETUP packet is processed.

Added a check for USB_TOKEN_SETUP to avoid triggering an assertion
failure and crash.

Fixes: CVE-2024-8354
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2548

Signed-off-by: Madhu Marri <madmarri@cisco.com>
---
 hw/usb/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 975f76250a..df2aec5aca 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -741,6 +741,12 @@ struct USBEndpoint *usb_ep_get(USBDevice *dev, int pid, int ep)
     if (ep == 0) {
         return &dev->ep_ctl;
     }
+
+    if (pid == USB_TOKEN_SETUP) {
+        /* Do not handle setup packets here */
+        return &dev->ep_ctl;
+    }
+
     assert(pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT);
     assert(ep > 0 && ep <= USB_MAX_ENDPOINTS);
     eps = (pid == USB_TOKEN_IN) ? dev->ep_in : dev->ep_out;
-- 
2.44.1


