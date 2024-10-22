Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3328BD1CDB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AOw-0003NN-Gr; Tue, 22 Oct 2024 04:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOu-0003H7-2S
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:38:00 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOs-0001ZG-FD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:59 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso3423587a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586277; x=1730191077;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Xt78vSTJ1r8zdGahl9S5mey0b+UCyoAUmEmAWGjCqs=;
 b=x8QYgZwZRxGN8cZ1QMUfPOeKAsZv96mGPbnyivYWSq+F6Waj0UJdypMZeP6rzp4FGG
 1boJtUTlvPcV0UVNFM/5lcYWRbeApuELI5sT+Jcw1zHCVCuPpjc0/StrzyeKIaHDW5oV
 qT1VFmMp6MC1gFOHoIv+UH/lKScHfr97QY/Wz+weuSWWfq8eQ6pPnH0Ak+tFC74Xktn0
 eAM+82H7GFTBoLn5F9/cmYwyNZvivMPV0kXaaecTsvFg01o5M6M6l+dwFxpNaaSX4kVB
 1a7OwuKq8TNeClImYgJMPeS0ggtDWYJauUzo31unuBpUwePXbjKzv0KkL1wcAm9V1yVs
 QLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586277; x=1730191077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Xt78vSTJ1r8zdGahl9S5mey0b+UCyoAUmEmAWGjCqs=;
 b=TgjyTkbi4/K7C9iCTPViJ44elBX+/49JjPGBamyPsXVZwYhzyspz/GHD6OvocRgMTM
 wZkOfTIQSHS749Xb7Kqr7JTUHBMN35tp3Kqo2BOwXIubbTBJB918FLE+hVQViO/L6aab
 U+ukmQCp8aCGQWQn1WRVRfthb9nNlyx9L90I061PE/4WqrJrgyt5THbKA/aYXk1QugEb
 3JQe/ysyLYG5lnAnskv2jLiay6EQCoO+yZMovWPTlqp1Fvy3gx3r8QLnTvF/sWtOEid+
 MHEN4p3YimPWrjnjvUg+YCu+OpZzprlROQMQ2yzEhjY2ziCc4kZHFjtDSMFJqzleIisk
 PMoQ==
X-Gm-Message-State: AOJu0Yw2c6Wtigp1wj3Oposw5ixYBvt73ZfiF4ZlomKb1/1fOkzlD6t9
 5n3sMfivPBUT9hzIUb3sOYx3/ZqaJqRZQGd6C9sOq2v0ttyQDF0gUDA2lcwrzuY=
X-Google-Smtp-Source: AGHT+IGctnbezCTGJqbvKnxKBdZzunDvWd8LXUp3Qrw4lkysCgqoEBL061YZtk6dtLBP6Ny9Lsd5Jw==
X-Received: by 2002:a05:6a21:6d99:b0:1cf:3f39:c469 with SMTP id
 adf61e73a8af0-1d96c25c2b9mr4130494637.2.1729586277177; 
 Tue, 22 Oct 2024 01:37:57 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7eaeabb83easm4531944a12.72.2024.10.22.01.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:37:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:47 +0900
Subject: [PATCH v17 10/14] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-10-bd7c133237e4@daynix.com>
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
In-Reply-To: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index f1993bc553c0..db087bb9330c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -93,6 +93,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.47.0


