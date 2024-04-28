Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EAEC25B10
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 09:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10U9-0007aw-6o; Sun, 28 Apr 2024 05:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10U7-0007Ys-9y
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:11 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10U5-0003oH-R7
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:10 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ac16b59fbeso3049358a91.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714295168; x=1714899968;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mRiSDh2hxalsIQeLxyFxc+nQD/ypYo8m/u+/Io1QRYw=;
 b=hs/zSCbk3SgQCL0Gc014sqP1kPQgHrE5O/mJvzUv6qHdgQKcBGFwjflJC2GJwbl9YT
 TK0ftv5Zs1ktFKWMATSpQ/OiCghy5FbFwVe+wiA34PNZo4OjQtFznZsRfAXa/W/iqAPn
 Vy5EKT3dAojHiTNloMCbhJCxmwqtJj0/zsowTUA9UfyuIj4T97yE3ZnN9kmEbgpSgQYH
 7hGMeYSZwE4c6W1fDSTXc5YCe0PVy70qYHdHDG0M3oc7VlSQTpj2KdvWDU9o1vqad1on
 WgCTZYbhKovs5q5pC1LkbWnb0tZqY/u26gUNQQ3k3isZef87tzKhrwWjxj6tC3lnJtBn
 KfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714295168; x=1714899968;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRiSDh2hxalsIQeLxyFxc+nQD/ypYo8m/u+/Io1QRYw=;
 b=vUoI6bshDbtCS9MR7RTFWEVPazoiXZCCAT5jQ/WCOw6YfAZXPxoTdreqDwAzAlj2vy
 x28d30+eApbolOKZKJlwaZOY3MlWvywU5g0sYdbkaR3ryZxM++5bq+Ds3/IB+agMmHG+
 p7Km+Mb9O+t32w2Sn9F0ZF374OgLd/AMilYkiZuTmJsbeBCzbZ396DrcTeOznJ/b+lAT
 A23u8xkBFVsIfuL6WtaGwBsj6+Li6sBzqLGLoQ6LK7EU22DtGVZlLqQvD2Y6Eh7odCox
 mU17U6L9Blm9YEjvOzoWa0Qbwozt5Z5uMzi4zPuthEUhi3219ySM5RU1VplN4RY7CWDW
 GHMw==
X-Gm-Message-State: AOJu0YxG3VV8PbUZkkFPVkFaanyEOqF1nS8iptab+Xza0cLfiKZkhSEG
 P+GgVaSdlQ0s8WwitkJgkj0mejrN+sj4ZGPKREh+1xYLG4BkOA23fL5C696sjTU=
X-Google-Smtp-Source: AGHT+IGLJ3d2wB1FvT/X9QJ8trVoxQVDsxuWTM6Mswqsbnouw7oSP8EUOvPWsd0q3rSpRIBWixCE9w==
X-Received: by 2002:a17:90b:3a91:b0:2ad:ec71:b7e5 with SMTP id
 om17-20020a17090b3a9100b002adec71b7e5mr6519203pjb.33.1714295168419; 
 Sun, 28 Apr 2024 02:06:08 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 db13-20020a17090ad64d00b002b0e8d4c426sm2060447pjb.11.2024.04.28.02.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 02:06:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 18:05:42 +0900
Subject: [PATCH RFC v4 2/7] hw/pci: Fix SR-IOV VF number calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-sriov-v4-2-ac8ac6212982@daynix.com>
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
In-Reply-To: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
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
X-Mailer: b4 0.14-dev-a718f
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

pci_config_get_bar_addr() had a division by vf_stride. vf_stride needs
to be non-zero when there are multiple VFs, but the specification does
not prohibit to make it zero when there is only one VF.

Do not perform the division for the first VF to avoid division by zero.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 201ff64e11cc..dbecb3d4aa42 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1437,7 +1437,11 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
         uint16_t vf_stride =
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-        uint32_t vf_num = (d->devfn - (pf->devfn + vf_offset)) / vf_stride;
+        uint32_t vf_num = d->devfn - (pf->devfn + vf_offset);
+
+        if (vf_num) {
+            vf_num /= vf_stride;
+        }
 
         if (type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
             new_addr = pci_get_quad(pf->config + bar);

-- 
2.44.0


