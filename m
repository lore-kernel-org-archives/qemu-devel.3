Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE50C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdl9k-0005mO-7Q; Tue, 13 Aug 2024 02:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9i-0005h4-95
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:18 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9g-0006OO-KR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7105043330aso4147770b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531035; x=1724135835;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HcdZ79xR6R3d995UHi2uhISfC570oppLStRageGdWZU=;
 b=0+35AJvKFTBR7hHR6X+B3VCiuTMRlGIzJpHZAIu3lEdKgWlQ9Qeym6uWyoQWT2w5Mz
 1L4NrQnkSgEv2Jz7r5COeCz+iNj3Jtu30PMLPa7WfofLDaurmEqPh+CXrPGr5bUiP80t
 8X6EYlzQhUTrXAuO1apt+j+oUeywcGoG6LFgikFP9YrCpCZXq+l7hO3jDFs0PQL2BE1F
 U7wCp6lpbGsEY0ODaTxNqM8vgEpkD//ok3B/nPOzSUjhMKkbhO5eGpBvvn3IZgApfTme
 1SMv085tGWh7xyZkzXp7acnAMq0HcRv6943ZikFmTSEzCEKUxNoHq2ZQbX8Qiijv+nVR
 18Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531035; x=1724135835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcdZ79xR6R3d995UHi2uhISfC570oppLStRageGdWZU=;
 b=Kuwar8dNv8/RC/AtIzBEf6Ec0VUsYi5TI+4oRwBhUr0hcqXl1EPySZYXgbNNtSB1Q1
 1EsuFSiGsMcjTWGQYfaiF9pPYZ6i72KN4nVt6kcrYERnmagpwr7eroZtu8lw7zxKYeKu
 UA9K/oz7H7+Rap4P7CDCiPiPaP3IPW0boBuSpxsVbRfy3uB9Tl3zFR1MA8meGiqj+DXg
 WCvYB0ngUHu7FET5huO/JTlSpEBJal7WU6oPz4jxvxfEWvnsdRH5wti9UcP/NfdATqH+
 jjywIg4gPvQ+dQSd+OJKIobQ0hd4B7tfQp4GNxsMnbJmi2/5sbObR+aBlxcQ1Pfti7v/
 qu7w==
X-Gm-Message-State: AOJu0YwQinveCHN7Q2hYtoAhYtRozFibQ/paWJNcl2t+bcl63JEnZeT+
 NnoVjYH1+4lEab6WWaAzICRbhjOHbFgAOsNw8z/6V1gT8Zwj7WEw0fAqaebghsc=
X-Google-Smtp-Source: AGHT+IEch9SwD8Q+h9uVEvHbtNqM1jtzZzAcbONmiJNa0r9Z/x9ub4X0EJe1TJ53BArtoaWcbZqRuQ==
X-Received: by 2002:a05:6a00:17aa:b0:70d:2693:d212 with SMTP id
 d2e1a72fcca58-7125510c560mr3177429b3a.6.1723531034969; 
 Mon, 12 Aug 2024 23:37:14 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7c6979ebfaesm728212a12.24.2024.08.12.23.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:37:00 +0900
Subject: [PATCH for-9.2 v7 1/9] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-sriov-v7-1-8515e3774df7@daynix.com>
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d2eaf0c51dde..60b1747d60e6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2359,6 +2359,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar > 0) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {

-- 
2.46.0


