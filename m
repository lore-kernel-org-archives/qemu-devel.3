Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1F5C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCOI-00049d-3W; Sat, 03 Feb 2024 04:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCOG-00044X-CX
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:48 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCOD-0005kf-3U
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:47 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso12989335ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 01:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706952762; x=1707557562;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HYSjFZHgQ2mbSqHRTj9z4C9g2BrbZ8iNuTfeoBp92uM=;
 b=jL7UHS+H8p7wM73OZ3Mgzf0kPMppZ6RTMmDHXoD8qUZcCO/H2o0/idGQ+IY88XynuS
 HsxkYuDASEsqM/k0kxI8gwAw+sthJikKrjZLCYiCgV0N6diDzQtRBFUu6SaoRjJGOHHw
 TLG9H+N2E+AaM3wEvwtcJfZA7/PCRoKl+2NfBD6UfeYoOei90cQtM+eaxzmCEF0J95rj
 2Irkz3NxdB/HPJyRBGDfulzviNDcuP2Dk5BO3SUYJfgpg6rIqquusJWY1oRygjbt1tfG
 eTkeyeyDeD2DVAPBX5odTieDo27Tkvsl+iqbf7HZmacNCNjeYXmE7zbWfFCDqZETtoa8
 9EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706952762; x=1707557562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYSjFZHgQ2mbSqHRTj9z4C9g2BrbZ8iNuTfeoBp92uM=;
 b=LM0YiljW1+G7SmjJkcP40FEEIV5GukfAeFiW8V/x55e1ueQt1xsB7XBXE3GtnWy5pK
 cLwWgv0bXFh5DbzWmu5JiZWAbnp0Gsj+v2i3jl4VcctxXaPREPqIw4tiEsPLdjgrCMrG
 QWwsU2QeRGx6fWZfKZ0FzkkBB1IHfzUMgePEec8pSuOXSMo9297rXL8InSN6Ic4KDA7D
 Xq8H/HYRUvpy5BFwSxhwnlY3doE08f8JtRVfz7HfsPVJlfvd7KtsClRYi6j5INJhp+F9
 HsaL8ejGJvoDWNybNAfWU64PpeXyxn6NNyOZx3ZRbJ6rCJKk/tup1OBVQ3gFujm8k8EU
 IzIw==
X-Gm-Message-State: AOJu0Yzv0MUSZC1F1We22OIE0765aojDWA9bqdH3p1Cl+1zcN0ftgsCc
 jxLXAt21/zEvycFA+hh4bgINEYGUUIKyvy6xZQ6IEBMQ7p5cD3MzeY318y/WTJk=
X-Google-Smtp-Source: AGHT+IFHh8OIlJipxLVkpu9RnisnYTIBXlOI+2/luFbNUWvGW5L70auwT/6pjFkoG36AVQReAb6PiA==
X-Received: by 2002:a17:903:22c4:b0:1d7:1a90:65ba with SMTP id
 y4-20020a17090322c400b001d71a9065bamr1747296plg.25.1706952762559; 
 Sat, 03 Feb 2024 01:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVU9y+cwhOt9lniJMAc70W8Eu4EquWpR0TdS4+87r7J6BDHTnGVaSdOoF59YhoO1u9xFvK6RzvhdprYPGFudwO6ergT8rLAH05snf9NbQxJBMqF2PKvVzYcnf5XEC+jkAkvlozYrGUfgeaLJ2o8YmRBXPiA0oDAHw6ZrxOCU4nT6KFyIJsQ4of6Q3YenOFfYw8zlx2gEgADJLB0p0Btr9UiKtWIJI1M1ktu1wSUQyMIDygAGJOdp+G5u8GEc0wqTWVl9hrw1SIrba0HroDBZdUMN5x4mGsRbITnYAeqo7GIDc+Ib55OiJyfzU/8nA5ivmmgx10gnI0vPVPpbaDwDmRxjPeV+Q1p32sTYLrib9k9aY2LJ5TG1HRdVBkzPRLXFg7bEKTiVZOs+q/Bvg2beTy6dI9gKw+pXccv5MQJ2w==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 j21-20020a170902c3d500b001d7610fdb7csm2884316plj.226.2024.02.03.01.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 01:32:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 03 Feb 2024 18:32:00 +0900
Subject: [PATCH 6/6] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-reuse-v1-6-5be8c5ce6338@daynix.com>
References: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
In-Reply-To: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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
index 9ba34cf8f8ed..9d668b8d6c17 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -91,6 +91,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unrealize_vfs(dev, i);
             return false;
         }

-- 
2.43.0


