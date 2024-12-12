Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC75E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLevn-0002Mo-E1; Thu, 12 Dec 2024 03:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLevl-0002Md-6V
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:52:21 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLevi-0002gG-2U
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:52:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-215770613dbso2175415ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733993536; x=1734598336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qQrx+fAhXsLEYfqQXcb8+Q84Emneqv6AOg2swNWKcZE=;
 b=ggEhDHwWv9tfglRXGCpTLBFQxK3mGK80h15E8XKk98do6Epx9NJnAyI9pQStddw/Bh
 yRPE00lktYcgP3xs4Xsi/LkPxGnjEdYs/fv3DFaXkm3ab6J5mrW31mvt9Tnfjcv8SYQ1
 eNTTjlhE8QC/32sTKQICqpb2xu4ZWK1QQ99oExZF/kAeMBdKpYtk1ztLN931qE6mWiye
 BzKgdGL6Nwzi1T/cFHWX/wLBq2aG++HCJ1cSoOZpL3afYofqh5yIPy61FuZ7ZA7wteHx
 Gfi1OBMLK0sWLaoFUzWXHN+NpW3PhugZLHWfT9m/dLT9lukrlIe055f6bzDwu8Ypz1Em
 zaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733993536; x=1734598336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQrx+fAhXsLEYfqQXcb8+Q84Emneqv6AOg2swNWKcZE=;
 b=po+uOHmKoy9wUSTr/yXv3FySwe4/mNHCQv1wCXGoPewcAUIVJqThrmm+oWYQl1TIMV
 EWMzYVEwG+eC0PnVK7i03qPhV6fTjJHtbBFS0Dqo/rQpe5JVUhppXXJBRXBTAc32/C45
 t4YmLfWcMHSWmhhJFU/C5IORSJ97JsSUA3/KDaBQbFdlOb8nza8+80Kh7UsA4mnXMQHt
 4H+PFAFPOQaYbzkjGkkEYQ5iGuqpYGlYvDUXqCRvnYD+9c9ii2uxF0xPtQXyHN3aR3fb
 4AewbK9PauE4CJCuekmXTjMZtkIzmdpoCjO6mB51zRGu3vaadZUuqK0+HjtOM0dRgouc
 fe7Q==
X-Gm-Message-State: AOJu0Yw5Dwwyqni3Zl0iEPKDEluMDCBhCZ9xG6qzHSxOBL+uD+8Fhsop
 bNVlWnhIwz9nBppmypyCn9o4300WWR2eBHwtFO6GCxsZncOKdOPSxD4aIg==
X-Gm-Gg: ASbGncv25kg91Cp5ahJgwC9HYhoi7eqTcVRNcBC5sAmq7tzPcxPvsObt1SAG8Aa8SVe
 P0XhbtoxbZilj7ETalKZL3Qe5ZL5QLiRegaZbXn8pnSS6EVGu8pz4egQf6mbnCinqnymac27AY/
 Ck5SvUTXQSBLWbcse0QULjdFKTL7PgQqYT+mkW85c2ehr9CvTp8cfvTyiH1oW71EH7Hrf6+bilQ
 Sq4++DKDEFfHBJf5/QQ/ppoBoKt9PIB/t/+zQIciZ4rsiZC8pt3X8T1vZc=
X-Google-Smtp-Source: AGHT+IHYVp+PX10wXJWDxb7yUZymItqu5z///xp3CuVuoIE8YkZdTkrl10HZg0IR4uy9YcfawqR2/w==
X-Received: by 2002:a17:902:cecc:b0:216:2b14:b625 with SMTP id
 d9443c01a7336-2177853690emr109810865ad.31.1733993536185; 
 Thu, 12 Dec 2024 00:52:16 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0a736sm118402375ad.217.2024.12.12.00.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:52:15 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI controller
 model
Date: Thu, 12 Dec 2024 18:52:05 +1000
Message-ID: <20241212085207.1439501-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

This adds a new USB XHCI PCI host controller model, the TI TUSB73X0.

The motivation for this is that IBM's AIX and PowerVM do not support
the NEC driver.

hcd-xhci-pci code is changed in patch 1 to make PCI settings
configurable where the new model differs from existing. E.g., the
option to add the PM cap, and option to use exclusive MSIX BAR.

Changes since v1:
- Remove an unused variable noticed by Philippe.

Thanks,
Nick

Nicholas Piggin (2):
  hw/usb/hcd-xhci-pci: Make PCI device more configurable
  hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI controller model

 hw/usb/hcd-xhci-pci.h           |  9 ++++
 include/hw/pci/pci_ids.h        |  1 +
 include/hw/usb/xhci.h           |  1 +
 hw/usb/hcd-xhci-nec.c           | 10 ++++
 hw/usb/hcd-xhci-pci.c           | 69 +++++++++++++++++++++----
 hw/usb/hcd-xhci-ti.c            | 92 +++++++++++++++++++++++++++++++++
 tests/qtest/usb-hcd-xhci-test.c | 21 +++++---
 hw/usb/Kconfig                  |  5 ++
 hw/usb/meson.build              |  1 +
 9 files changed, 193 insertions(+), 16 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-ti.c

-- 
2.45.2


