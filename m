Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C64E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyxv-0001DT-1f; Sat, 04 Jan 2025 02:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxt-0001CY-QB
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:52:57 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxs-00033T-5y
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:52:57 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21644aca3a0so107871345ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977174; x=1736581974;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oyg4pbHdwstOkTHIR1V+PL7i5L1dZO54bgS88oDmuKI=;
 b=tyuJzDsLQCsqS+Wr6FiXR7UODCKovtk8LvtpQywjF1L7yA4Eq0u4oRrmiSNZQOD2uj
 HYbvoUBWmnUvEDpkKm7zJbeVrvu+DJA/OispD0fB99oxad0FxTDcxZn5Xrsk5ugIKuqo
 SXtkMi4lJJicaKFmHDlxevTrq1j6BM2LxEPH6OMXUA+kwvZ+FNu6rXdJDNUD0wM+u+Kf
 5781lEoEB5B5qzjzv4Jbzmv8D+7PqJZ/8ECtv8caCXtUYg8001Esz14gU4YBmMfvz0+x
 Sz15X4Cy37wi30uGnPBjDUn4dvUsd6S81ip1aMiTH+BiFXfbZ7RWsKAREek0xYHgclu1
 7PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977174; x=1736581974;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyg4pbHdwstOkTHIR1V+PL7i5L1dZO54bgS88oDmuKI=;
 b=fjg/a38D/MvMr8lbeXo5U8ppzcjM9/2RS757H/EdvKuh1XfqABEWgHctvKgcANeqnS
 qxV9rA0naOtWTRxLzcp4QU7Uw+OGiBwJa9WkMtm7fmKYlsHwIQSZKdff8rUWWyX1Pq/g
 B3qaltahs4RtSoNsfB47Nt0owY4bwxMGl8mhXPiErmiGfoXYY3s0sLAFp5q9FKv5yXcv
 FJBcVgmqtr5+pHIarZs4ZncamRLIBwyUiAIqd+HdWWh9t7o/Bb8WHC1UQHL8cj8Peic+
 m8oNNCytiyJhqT8AkxKYvK4xpAhfBNlZIam4WQcpCoagJrPB71J8LOS5sPBDXojsRT9v
 aJ9A==
X-Gm-Message-State: AOJu0Yy5dSAvmAAjCd7MwUNvxdOMHoxLIdsb+NXDaY2qIsJom3hUR4qx
 Wubt9govJBE0HXlZklUG7XgYEqEJgQAtl1dtpzttIaNEQhyfWm6Zfz0cac8o9TU=
X-Gm-Gg: ASbGnctebnu6hXM4Piub2ORPVjCV1G/Or/MLzmUFs+SfN/+K4Q2MfMlfJ5vgxpIQJQT
 WNiQ2x+n6AgDhQ40jVsQz8sE46BjQJrUbaPJUeOroIh5m5Ci95eMe5IuAOnuM0HN7D85kAUNGNk
 3nE8Rdlw4wppTS/n7upx4uqk/geXiRQ6Pr08hvTamBSvAF/3hn6Qlg+8Pe+YjsrBym0R4cdlmwf
 gOTpvIcsJARbt1EHTQqfhwyQ8WOp00QjV/rH2lc/tGAzRV4LIOlXsJx5u6b
X-Google-Smtp-Source: AGHT+IF7UX6GHo37e73+PGjstFVRBzA2v1O2BvqJYsSoCb1TzOk9kmRKYUCZTr4l8wIGqgbKPIJiHw==
X-Received: by 2002:a17:902:e886:b0:216:5e6e:68cb with SMTP id
 d9443c01a7336-219e6e9fd95mr768318895ad.16.1735977173767; 
 Fri, 03 Jan 2025 23:52:53 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc9f68e4sm255267465ad.211.2025.01.03.23.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:52:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:23 +0900
Subject: [PATCH v18 03/14] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-3-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b94e4ba1314f..e0a9d50edc3d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1549,7 +1549,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged &&
+        !pci_is_vf(pdev) &&
+        bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",

-- 
2.47.1


