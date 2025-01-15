Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5D1C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7s0-0005O1-7H; Wed, 15 Jan 2025 13:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7r6-0000lW-82
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:11:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7r4-00077x-Bu
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ieq/emO2kCfQcvYMmdgz0oHLufowA4A3MNBfjxWyJVg=;
 b=VJhsabcz1xpKOvVHytzFwZK3eTbNbTLjduhhTOO3awNwxKvSjtowjB2diHCAL8xuLhkNzP
 crzDRihOi4He9P5zoTmxOjGseeMf+prUedC4sQS2JN9exCEX0Xof0Y5R+u8sw0qcVuOOJw
 I+i8PqaHjhEuX+nIUZVDZJ6EMiqaixU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-DBMRQMb4OV2i4NnDShcRMw-1; Wed, 15 Jan 2025 13:11:00 -0500
X-MC-Unique: DBMRQMb4OV2i4NnDShcRMw-1
X-Mimecast-MFC-AGG-ID: DBMRQMb4OV2i4NnDShcRMw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso37160845e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964659; x=1737569459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ieq/emO2kCfQcvYMmdgz0oHLufowA4A3MNBfjxWyJVg=;
 b=BIRM6IgbTH2nWrdN1ESbzIC7D+4z4qh3v//3Rv+dlK9L6I/lcfRZycXn5WdDjREUB4
 KloYymic/4/inDC8SwIKBF27nB9MeJDZC1+v8zHNmEmMzfilcK2xLu3k3RD0codBRNsz
 GVgOTHWK+Gz5TWOEU52V7n9MN24yob+Gxoqa/1mI+4itxn9cPoIx8Qt7EJitmH6Ucm2t
 kxb1yBYpMQ2EV2nB329daZMSEDx1r4B4hPUXilQJaG6I2bXINrgNrPWhv60wKSpAoOMd
 ce/A+Gzdewo+eXOrkpZ4Xc2jSD2AKJuLbFzI8oa0nJQNvLK2nI4z0su2rvBKWQ/oOpL3
 BJ5w==
X-Gm-Message-State: AOJu0YzW4IK1QbKAuEpcx/ORdGDj8Vv9aIGH+ElABEcyeWK5yjxZbq2+
 zDrpVSQJ+mBJR+uF59gd/wpY/x0Fjh1ZkJEF1XG5ej5JrnrVQ1ASlpf9ko8fCZ8E+OTQj0uBo6w
 1/+ZD0grCm24mM7U2dWhggVkXlTJ/l45otV1qwfYSpZ4Obr7wvLv0wHfKMFJYbp4xpeZHJdp19p
 cUwDe//M3FQpvXL0541a/2C6O46y5X9w==
X-Gm-Gg: ASbGnctChRhVwtmSdWCjRh4L7lHrZlFG5DePlpTmWyj2P+MMDM1MMsnRoRUWFErJCMW
 YpC2paRprQrTgK/IogUETrStx9NP0QU4fPr4v0tEiMYCfQJAcoFEhUtVaVDFUe6QJgMVyVMHhZv
 yyIS1p6y5CvlnrVTwlvNx5JvSJBFM0Qh5T8BUTK0uvvjkLpVp56sdhHUP0PycFnaycnhOCKyKlc
 +tjlZ+vfR71M4C582bLVkVF/y7dWG+2+u4xrbwpCWf/3VQsF4ac
X-Received: by 2002:a5d:47c4:0:b0:385:ed16:c8b with SMTP id
 ffacd0b85a97d-38a87309d21mr9907998f8f.23.1736964658790; 
 Wed, 15 Jan 2025 10:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLCDO37xmN2YYCVJlGY1P/4rsU6aFfWIy5IGM73ClnFG3Gs9nsnEg2umS34cTlRMc0YOqSYw==
X-Received: by 2002:a5d:47c4:0:b0:385:ed16:c8b with SMTP id
 ffacd0b85a97d-38a87309d21mr9907962f8f.23.1736964658375; 
 Wed, 15 Jan 2025 10:10:58 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38f0eesm18569909f8f.61.2025.01.15.10.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:57 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 46/48] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Message-ID: <1ce979e7269a34d19ea1a65808df014d8b2acbf6.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Zhijian <lizhijian@fujitsu.com>

This assertion always happens when we sanitize the CXL memory device.
$ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize

It is incorrect to register an MSIX number beyond the device's capability.

Increase the device's MSIX number to cover the mailbox msix number(9).

Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-Id: <20250115075834.167504-1-lizhijian@fujitsu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index bd7652740f..0ae1704a34 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,7 +843,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 6;
+    unsigned short msix_num = 10;
     int i, rc;
     uint16_t count;
 
-- 
MST


