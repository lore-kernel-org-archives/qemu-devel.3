Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E77C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 10:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYkY8-0007A5-E1; Sat, 10 Feb 2024 05:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkY5-00079P-Py
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:25:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkY4-0002xm-DO
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:25:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so16819925ad.2
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 02:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707560727; x=1708165527;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HYSjFZHgQ2mbSqHRTj9z4C9g2BrbZ8iNuTfeoBp92uM=;
 b=BPgJyd2YvFimCl1yOL7WV2xD3kbSoiDk0WASS8MeOzLKfBQYxcBx2Go3B+KLSh57gn
 LfDe3jvLfKpCIq3gLJeJ9ZoCsn0rdo+u2Zrhf6h/m7agcUhdde+tJwNav9DC4OLxs0Zk
 fHXxqkY2hi/hVwW7sE3Q0Hsm4I+fVyTVz/zvJJxWeSgh2x4qLSzD+CaK7wJtW8TQnXkr
 2qEUc0AHpU5C0Xm/3odvdXfjjrVzhxHWig8SelwSEQrekQz2gSRrdPeLQHa09aNrGk4f
 SWLrBo6FQq2PbWQ4SLNrsfsaUcb9b7KdAki7fYhYvqZwP7Q6aDTwPHjgXoAov7Rxbsld
 TJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707560727; x=1708165527;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYSjFZHgQ2mbSqHRTj9z4C9g2BrbZ8iNuTfeoBp92uM=;
 b=GoQsAfbpKP7w8YaW2lU6wei7PsI/8yiqGgtbGlSPRiTuqQ6UqDELCqoSuzU+Kuyvy/
 dvTWJHY8rkiybigA7Kgv8E67FmALIq4nirxX6/I7S7mCm2SQlLvNe7aTAMYaGuoscc8H
 XUxgo6/yrxnThl6T7KLtm12gUO4FFUVGr37Izqp+nrcpHJKKOp7sHT6Or3NsU64lOcPj
 05lnI2JoPOrOYSn//qOK2tuUMJnH3/fqamJPPUUTj1uajggc2j+I3ZUcTSgvHRcbY/Ee
 Viv9tGBxTuPjq+yn17MOqbv0wXTsyFq++701V3BqA3TXgcBT2X1y2fbxZkAEXqUr8iM9
 MovA==
X-Gm-Message-State: AOJu0YzysyyPfhlyFy2sKlPLpYJudzLbLQOE6TMVk1piZBU/ZUIpci5f
 5ZN+pqDQffxtpowsN9BNW0L49p3B3TWiVLFnaDTJRW3VyUljHI1c6fkkbRt/mWo=
X-Google-Smtp-Source: AGHT+IGQ5aM221Wc+qYNnPkwBsvvR3Eberqq3vc7FhS4p+fUTry0/8lA9fzDI02NO/aUK8tdVyy/Ug==
X-Received: by 2002:a17:902:c60a:b0:1d9:8549:48de with SMTP id
 r10-20020a170902c60a00b001d9854948demr1586878plr.27.1707560727100; 
 Sat, 10 Feb 2024 02:25:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUoyMEgFesgaCR8VJ9Rh14JN+NimmFvywA076D0js6O07lKOTz8gN6Zk4wwhOganlJ+rCMy2DUt4g9YZq0NAsKeKqGywsaQs1KZ23uxpbV4sY+xda1XIaFiQfubQqQejOmfJJavmPlkN2aEq8Lh5FIuZOoNoxiqj5oaSYkGOGI+bcHnGbUwZC4FGWiLzcP7qPocGjZM/BUXWNEdv7+fvMHZWNznE6xT1J8RqYqKVpTYijqobmHj8xetNibNlFipbV0hVCc10bMnBKD7T2W2kyMPKbu/Imv84n3f+/TDJ2oourFeKr8TyyzmsTzgLUwO8h0hCoPsa0Jq/1xh2FztQ28Srrs6JYyMRQfHlePXC9zway9pR/7KKewfFQdFK1NXjaaM/YRQQFZjw+w8rkxCKhe3VkAWfZnw+vfBmerSzw==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 ko13-20020a17090307cd00b001d88d791eccsm2802749plb.160.2024.02.10.02.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 02:25:26 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 Feb 2024 19:24:41 +0900
Subject: [PATCH v2 6/6] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-reuse-v2-6-24ba2a502692@daynix.com>
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
In-Reply-To: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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


