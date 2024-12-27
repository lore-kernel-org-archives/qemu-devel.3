Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81129E7718F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 12:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR9ER-0002xc-V3; Fri, 27 Dec 2024 07:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9E9-0002v5-Ak
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:14:04 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9Dz-0005FW-P3
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:13:54 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so1047792566b.3
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 04:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735301625; x=1735906425;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2O+DIEBGhBsth5s6qrd3slMPO7yKFnh06DUjpLZtVho=;
 b=xzgYhYYkD0yWvLS9xiziyheuQ4Wpw3CiZMunGvBNapb0y/zNJxceUGHri2+CVC54dJ
 ck5ESvna+qK1GjlNB3SvF5gqrWQcPa4uSAtnz06xtySv1oyF7u4uFaP6vSUdVxrw/Ghx
 ibjpGHah6wPpgtAiSTnZy976Yr68bwVQ1W1zGHrPHrc7DEiA8j/2UwqPYIEkOu9NCjmy
 9mM4Pg5aksBPJsyWdQjoLRbNHJLlwjBqmqJd3WgGmlGWqTykCxDofN8VRa+j+3FKjtCb
 eCg3fDdimZCFpevumHA68AwHIGn675dlXBjDyHeU7AhlsnkVOOuuy1WxpEGqyFB3oDtT
 iUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735301625; x=1735906425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2O+DIEBGhBsth5s6qrd3slMPO7yKFnh06DUjpLZtVho=;
 b=e0x2OValmwt8YOx3Iik4WtQxQVzad6I0rWq/vF6UZo91nwWudFzz9c1+BFqkPq3Oz8
 wiRThGfK4It5hRiAiBZ2HnzhCHDfDDLdtSyY4OJaQERoUiFYQdsrW01YMr+ClGSbnrMK
 DIbKuAMKZdA7SClcuXoGNL6CvVp05+5Ge22N1l7b6FqSwsH0lVIm33wOSX8XhIZmyVcE
 STBFWOKRKQQRNTGwwCWzoFOebmw5fuRZIlDwADvlazYvXa0N0JsMAR6iABqdMS35AL4C
 N/bGRoEzecM57rwydafiUUAFjZF2MaQww+3RuVfg1jFwgyv4K3ATFpHChD5B/45sVuMC
 f3EA==
X-Gm-Message-State: AOJu0YwDmy7fHxAkuauUVXDZEUkLHn/AXYPHHxVsNrkmFQmPnEoiEW42
 GilEriUEh0RefuA0n7EChxcPv3hLSh3kDd0CCotOJbkr3Y1eyVZ5fgmz8u6I8gLHRveSKRoxa9Q
 =
X-Gm-Gg: ASbGncvhz5ogr752hsZN3sr0lEroP7na4MXB7K3u/3DeS1JdDH4FVlcVmyrvI7mtG/K
 hDuJb9nyM0/Nre0kohfZtcTabWcb2XV22vIPBKYjDceA+RXwnkPTOrd0jkBjMi9A55jYeId7vJy
 Jo024fVlTF/YtbD3CkfTa+kV9LQSnaTu7JJ19IreuNWU9mU0RNeM/cZ2pSkE1StJLOo4hsIEVR+
 F8is61T++on/lQjIpUzDSrlwDqnoBf/ZKSGsU53KUpdQZYyvo9fqogGDZPIu3PMzcmR/aYfmeY5
 HHcQwLYuLR2taOE2/DaZ7c5foO6XjZCR
X-Google-Smtp-Source: AGHT+IFhbg2kfNp9SugiGcMQk7FtZYZSin/YtDp1HS7iR9dP5h+WIPD7LKCmOEHFiO1xpZkkX9hjpw==
X-Received: by 2002:a17:907:86aa:b0:aa6:5eae:7ece with SMTP id
 a640c23a62f3a-aac33549659mr2712724566b.43.1735301625196; 
 Fri, 27 Dec 2024 04:13:45 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82ede9sm1098662766b.2.2024.12.27.04.13.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 04:13:44 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 npiggin@gmail.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 1/6] hw/usb/hcd-xhci-pci: Use modulo to select MSI vector
 as per spec
Date: Fri, 27 Dec 2024 13:13:31 +0100
Message-Id: <20241227121336.25838-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241227121336.25838-1-phil@philjordan.eu>
References: <20241227121336.25838-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62a;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

QEMU would crash with a failed assertion if the XHCI controller
attempted to raise the interrupt on a higher vector than the
highest configured for the device by the guest driver.

It turns out the XHCI spec (Implementation Note in section 4.17,
"Interrupters") requires that the host controller signal the MSI
vector with the number computed by taking the interrupter number
modulo the number of enabled MSI vectors.

This change introduces that modulo calculation, fixing the
failed assertion and making the device work correctly in MSI mode
with macOS's XHCI driver.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---

v2:

 * Switch to modulo arithmetic for MSI vector number rather than dropping,
   as per spec.

 hw/usb/hcd-xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index e110840c7a..e5e7330387 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
     }
 
     if (msi_enabled(pci_dev) && level) {
+        n %= msi_nr_vectors_allocated(pci_dev);
         msi_notify(pci_dev, n);
         return true;
     }
-- 
2.39.5 (Apple Git-154)


