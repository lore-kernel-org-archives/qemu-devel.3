Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85960C5321E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 05:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shMQ9-0005kq-Ro; Fri, 23 Aug 2024 01:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMPw-0005a4-QZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:00:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMPv-0008MV-CZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:00:56 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso1173206a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724389254; x=1724994054;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hZYRJCaOR7D2p7YWgr7dJo7l/TPHeAaK6dBF5pYEnfc=;
 b=rM2HNMlhS5dgC68FevbyIp6f6TctdQB5j3rLhYgpWDHzp57Mu+hNm9JhZrV1ll9Gq3
 ZDj6eDnZQIXkQygBUGrlihqmHZ0CxNAwpLKQNFEkIZ9O0UlycE6CdzYDXa2kDrPM4oRU
 Wn5NqrM5QfvnbofPyrQ6zbZRNe9KXaIL67G0p3E0hiWUibAkvPI8vVVzvQZ/DnUHWvDn
 RCvkp647DzD5WH6erWwzjtJdQvrbcuie8rTS3lJBvmsAQ8p+TbvVtOZk+cuscRV13Q5d
 I6UtpGMi764n5aF4gNJnYtD4jq2e22zqyeWYpfLwKhnnLwzRxCfiJSIxOBxSzKtAaujX
 fEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724389254; x=1724994054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZYRJCaOR7D2p7YWgr7dJo7l/TPHeAaK6dBF5pYEnfc=;
 b=RJnoZEjNFMrnnzvFJgUvmETeiLi+ofWfcj45HXXFDrOxQy0kXron93yWpKS+erKl5n
 FoC026w60MXnDgMd0TDxGDJmeqzkH8QHoZ8z34zGqkoSk4i46/hVZfyVZkOjPlMspMj+
 IzlLlfDPII95K5UOlTQnUPZRLpQKCojkwCIsz1VBkEJeiKe8u/7NuldfLKzpX0Ut63Ih
 xj2hCKn2n2C12jsjCeXg/8RYeXvl6vw4w5LDJUJkvGnD4bZ2hRhKqV48sAeTSkoJE59/
 aiMCSmi7ZKA5iT/Z1kuD4MA2C8wPsEegyPLJv9LnSMY0NJ0+tWb3fmgc1J3x+P1khDlx
 uPZw==
X-Gm-Message-State: AOJu0Yxjt2Ru2UPrqT1rtUJQus1SMb08ADty0c8POBhsFOJywy84hEAJ
 ebj+CIXcPPjAiI8Dy1xqOMB3C4s1/rXHTrXaMPxADFkL2YZlB+cGV2B9Dvj75C0=
X-Google-Smtp-Source: AGHT+IH8Yz4yWjEqTpVL6zWi0jD9tMZ8GgNCi2TmTecjzXNRyxGEUbyuEW9X7PlH0P0RlEuBQhAlpQ==
X-Received: by 2002:a05:6a20:e609:b0:1c6:fa4b:3648 with SMTP id
 adf61e73a8af0-1cc8b4bd034mr1139845637.22.1724389253768; 
 Thu, 22 Aug 2024 22:00:53 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2d6136fce0asm2877886a91.11.2024.08.22.22.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 22:00:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 14:00:39 +0900
Subject: [PATCH for-9.2 v15 02/11] hw/ppc/spapr_pci: Do not create DT for
 disabled PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-reuse-v15-2-eddcb960e289@daynix.com>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
In-Reply-To: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c3546..f63182a03c41 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;

-- 
2.46.0


