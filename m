Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ED9C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkyi8-0002RH-CC; Thu, 14 Mar 2024 23:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyi6-0002LR-NL
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyi2-00022F-2b
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:22 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6b5432439so1720094b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710475097; x=1711079897;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JVzrVk4TYQYUBhxw61sjy4ZQEhn6xPnWNjuBpVS2XV0=;
 b=QMaEZde5CE5wPv2EFrtF7jmOoEg0dy/QK4zv7Ze8jKgWIU80inP8ez8SrX0u6BxWOO
 H0ROVy/5StA0Co2gokLMO9Wv7tVZUJ5SRnq31jAZYdA2By2YSQ8uT7W7GFN/0N0y380T
 eUW7tNUT9Xk4dz2Lo4iAOnh1iFeNZ+Q496P6MIgJdMoUUnlyA6WiKns4z854xiqCSGPC
 6jWmzT/iuTmA+OKPYHF9P3dTvZg4tKnEyJzN0kJOXkkTpesbPs8kzkHnYyglCWP0S9oz
 hkJUYqjlz/g+apQUvDBveoGa7OA2SYFEkVyOxn2uGnTpESWtOwWVEIDuiHbqGZq3cZ/Y
 gxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475097; x=1711079897;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVzrVk4TYQYUBhxw61sjy4ZQEhn6xPnWNjuBpVS2XV0=;
 b=UYsIFbkgNzHrakJ23c1RzG3wmw33DrLGyND2KxjNtHG1yuO4QenU8iV67bXAZoT+ue
 sYcOpDD8M/aeEDCpLWSo1Y0XJEh324IQOXj1r6h0/GftcUkxG6d74FcNID8NsIcs9KIh
 29fFFBnEuNQ6k96/bjS4D1dbpkLpYdWRfkWtrWg/vP8PdYpp5848nY4l36Ll2lXMJ+Qv
 IfZ+WT5RRc5GI+fusOlEq21PEGyg1v+GXpT+cGk3MXbXuv7UBJL5lI3oc9gw2DVO/TUA
 r5TyexSiqXmrkQnFUBkxwWKQYbmhw0InCGTWJjipAj8hpgfHmXR16TFBH+ISx2yml2nY
 Y/aQ==
X-Gm-Message-State: AOJu0YwqUPuapDMzEZA3XeyQVT4L47g7H5tZ0iUZz8HGJ+KJOoc4mj3O
 vp7duEvzn0LyR7vfaG2mqy8M3G3L0aD8Nqa+fPOjJ+nmcFOSqSvwPvQeHdWIC6c=
X-Google-Smtp-Source: AGHT+IFdKHo8ExtBRg3tM8aB6aRu4iLkkt0TxQQWXqYNTkAeiwV1EeiJrz6UThceJy1f1jqzMTqGfw==
X-Received: by 2002:a05:6a00:8506:b0:6e6:fb33:efcc with SMTP id
 ha6-20020a056a00850600b006e6fb33efccmr211427pfb.1.1710475096791; 
 Thu, 14 Mar 2024 20:58:16 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 lc24-20020a056a004f5800b006e6bda407b6sm2333903pfb.202.2024.03.14.20.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 20:58:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Mar 2024 12:57:52 +0900
Subject: [PATCH for 9.1 v9 05/11] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-reuse-v9-5-67aa69af4d53@daynix.com>
References: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
In-Reply-To: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
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
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
2.44.0


