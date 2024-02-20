Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17316C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPBz-0005Ft-FZ; Tue, 20 Feb 2024 07:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBj-0004rV-Nx
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:37 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBg-0006Br-S3
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:30 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d918008b99so43706285ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431927; x=1709036727;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q1P1QXlqV1/8uL6odiFFlW7Vd89tnDTB/dL2O/F70JE=;
 b=y0AaDbFFXW/Qxq1AoOlE8346bXgTUkYK02F3RCPFaxNSYoJbqs82TAkuzvfLpAg2Y0
 TVKpc93oO5uWXobX/NOcZhX2YI/y9ZVvTqqvobrFgz62Gy6d6YeGQWr3y3mkl7QJ7L2l
 /4yGR+ZCcuvPWMpc0Prl9vpqnSaLb8UI7VKRXRzQz554rbThWDREnxJxsqj1h3bJIPeN
 QWLYTfPpIy4CVZjYrm9LS1kj6p6x/PIwwmsXll1woRRp90cbIKmS56Co38HCBwUQKL8C
 aRwAK3F5qli2cRY8g4zqt3Ts09yVMHWJT5yBeRFOtLtrOggpPBqA9WlAHih8KUo9KoBN
 6QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431927; x=1709036727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1P1QXlqV1/8uL6odiFFlW7Vd89tnDTB/dL2O/F70JE=;
 b=nNhBtxPiaXOn+RNwE9956ArBlyRhieLs5gFVjCNwAviyG4iLLOpsIlUbx3uV0+wT+6
 s/4DZ+LtGwMxMMk2ni3XYVNgkNaK/9ntxTdyutna5L+K+6h7NJdx3Gy9DeGMOD2fyz0/
 g3XFUFdkfE8Kv1yq8cf7cON9hjfUPVkowgRMOF5zMXapJevQ9gc4DrRLKaeu3Q8LBXlS
 +rwD88OSYdnnwS9sOnw1CVMMQ8CbCKZm2gda9sX8qUIzardpNvDTyKihs42NzenZ8qCw
 T5hlB5H6Xp5aZkjo/7V/5oZs4vM8HnFOukg/GVklD9voUGckDpvqKjiljDDcz0o9qUwA
 ac+Q==
X-Gm-Message-State: AOJu0YwO6XHCqe8d0OAu6epRK1DOG/UI7NICldYWp+aykbsEwshE6m4u
 C9g/u2GjCEdUZVqQ9NoRcMLuA8TD6bYl6mG0ROQ5oD+72YjyaQj5xfIl95CvbAY=
X-Google-Smtp-Source: AGHT+IGYFCmi4+3aZ3aCfla1odpTNTheopDtaVHPuFGRrpQc5mMJCpOY5FCQ7fTvwyHBR7zc2xA08g==
X-Received: by 2002:a17:902:9347:b0:1db:95f0:4876 with SMTP id
 g7-20020a170902934700b001db95f04876mr12927281plp.68.1708431927654; 
 Tue, 20 Feb 2024 04:25:27 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 h15-20020a170902f7cf00b001db4433ef95sm6076392plw.152.2024.02.20.04.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:25:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:44 +0900
Subject: [PATCH v6 09/15] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-9-2e42a28b0cf2@daynix.com>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
In-Reply-To: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
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
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
index d934cd7d0e64..8710ee95b26d 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -86,6 +86,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.43.1


