Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130CFC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 05:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shMQH-0006Ii-OQ; Fri, 23 Aug 2024 01:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQC-0005x8-D1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:14 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQ9-0008Pj-VL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:12 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7093c94435bso947038a34.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 22:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724389269; x=1724994069;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BRjBowTwtb659ZbVk9eSUPoUW4j3xXhVBm+o7M+tERI=;
 b=FyWzNj6tBFSqEFxq2oFNBzlGxbDZjoh4KYBmDNSYzpYZyXX4zGZYsIUQAiSp+fFzXf
 VXxIzdq2FWSFGIvYM2uB1yKmStRyccuoVAFlwMnNFnC65P8JEGrYhdz9en8APEzhy/Gy
 sKQSVd4SmuA7cqQh7a+pYnOW9fd//eL/ikj09TW60/Q6JNYQ2JH/rYdnsEVjpWPPXynE
 NSGW0y3cCKgjoUiE7LtLqAcwKPXBlPnZzF4KS94gn1Ei7MQrOZGLQeQqyyaCSDjmXoU5
 plKsTw/fwc8PrOrxO2aMnUkMOxD+LBU5dxCYtdB+M0G4LpvrOD5rE9JvIAg21RHUfPdc
 IftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724389269; x=1724994069;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRjBowTwtb659ZbVk9eSUPoUW4j3xXhVBm+o7M+tERI=;
 b=oJrf+sLiehTBOT6l9xH/xlT4ODRS2DTgYtDKKb0lf4sRMiKmERGLMotnCQ2fEw8V79
 cQCPd974U10uXgctp9EVFuKFbgVIe3qzVcDnSh1LZ8Addp4wQ3PS5NkRJIWCoKXb1fMD
 Xy2BniZ+7AvGS257cd6raPZP/6ZTMly7UP0LxwO4uApZ22DRB0HVaGf/ESQ70tpqo5XX
 s44zCUalHvJxrw3cgvD9H7SflDTYcWsGaTU5WnAnRfo41uj+seP3PxOan6+OaC0/3oYh
 mLzBQGGgqFgS1UnvOuKZl85SNEdrykZ5FroUY4RKPTiek+Lp6jdezi5nFSi7c6YILrb6
 uv5g==
X-Gm-Message-State: AOJu0YwzpwFtZGn31SIStasso/CErmntYPqlA6ewIDnO0iqP12sEscla
 yDv+FJIJSKILWGCJ9LeAUou4VJwiGQwzYS8gQxsVMJXHYueoao2CBnEaw7BwjoE=
X-Google-Smtp-Source: AGHT+IG/uT8sqLwnP2X7Rrsfl/XGMr0xQ1LdME7tVquUk9KGGhkgxbTpdRU1UiHHzNQIiRnjIti5CA==
X-Received: by 2002:a05:6808:179b:b0:3d8:4603:e7b0 with SMTP id
 5614622812f47-3de2a8ec94dmr1269405b6e.44.1724389268925; 
 Thu, 22 Aug 2024 22:01:08 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm1932066a12.50.2024.08.22.22.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 22:01:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 14:00:42 +0900
Subject: [PATCH for-9.2 v15 05/11] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-reuse-v15-5-eddcb960e289@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.46.0


