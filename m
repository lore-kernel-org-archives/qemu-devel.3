Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5F7C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGi-0002LX-W4; Tue, 23 Jul 2024 07:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGd-0001jO-Uz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGb-00034a-Nl
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKWGQeqJTV62O0PjhVO4qR0DAdvYkDIxQ36H6bU2Erc=;
 b=FPPMqBXBbopfrVn2oO1xaIdgxG+1KT6+t54O0ejsppQUpr8taB/d75yAkcGhh82j53OQEo
 BGZBUFOovwOrE9tBu58ZCY0s7AYyFfHQ0VNte7BjDfqHs9/lHtQbQq75J4nUHsE2urr9/S
 NdSDobkQu5BAR0P5zuZozDAEWSPGCw4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-hQBZiScvPRGwZJIYJr7F4Q-1; Tue, 23 Jul 2024 07:01:11 -0400
X-MC-Unique: hQBZiScvPRGwZJIYJr7F4Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a77c6ea022fso115440966b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732470; x=1722337270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKWGQeqJTV62O0PjhVO4qR0DAdvYkDIxQ36H6bU2Erc=;
 b=qXi22SCcYPlErqGItiW6iduKwDhjqPCJYFDUXB8iFvbHGjF1WKP7Ln0J7tuweBDhZN
 q5ifa4tejxhvTu3bfUkFDvKvSLn5fyNE5R5cgMsWsbycwYfr74J8bwbkpTBfaM+DxNl6
 N7Z0Meunmn+fybA1GILsKD4CNMeRw1sgI9bUc4iHTjvpAXgsIUbgFKJYOB7PueSR/tzx
 jkeESqF1bxrcCVqCDLyst+B7a0MfzM9Kb6Z4VxfqIAsgZo8eIByb/gsJbVLG5CaWcr6z
 IeaAv/QD0/LaWjn/KHoU9VtHGHDTupDBAcX4fNssy9ejDPqLngNRTDpY1rI4Wcn3+xGR
 035A==
X-Gm-Message-State: AOJu0YxFHwQgvH3wGuUNaXn7Fd1yYmWBfQjLoFbQDDQYd2JHfG9oY4kE
 mlwJz9DN078/RA0tqTFzJNTacEG0OUbvAjLkGIKkCP7QejoeUM5lPGEKUSVVq5Ep3DlXG42eBNG
 0Bb3bZHZpyIfHJHzTkka3C2H+3zdvjjnYP1AM0oaPXuulZWzZDgcsMS2aq2QC73JLyhz/ecRBql
 3waeTbOrjvaZx15vm9EcVvkD+2Mt0wOA==
X-Received: by 2002:a17:907:80c:b0:a72:83ad:f087 with SMTP id
 a640c23a62f3a-a7a9424f0dcmr177432066b.10.1721732470068; 
 Tue, 23 Jul 2024 04:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgXb83KakDr1nH38tMDI093Vx93BbNff5N+ytvs/3oIj4VGTpGgE0zdK7+7MKVE63Ol7jkaA==
X-Received: by 2002:a17:907:80c:b0:a72:83ad:f087 with SMTP id
 a640c23a62f3a-a7a9424f0dcmr177421966b.10.1721732468489; 
 Tue, 23 Jul 2024 04:01:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785b89sm524326966b.36.2024.07.23.04.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:01:07 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:01:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
 Chris Browy <cbrowy@avery-design.com>
Subject: [PULL v2 59/61] hw/pci: Add all Data Object Types defined in PCIe r6.0
Message-ID: <78cc8c69475042ce6b6f720f8c81920fead0d86e.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alistair Francis <alistair23@gmail.com>

Add all of the defined protocols/features from the PCIe-SIG r6.0
"Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
table.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Message-Id: <20240703092027.644758-2-alistair.francis@wdc.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_doe.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 87dc17dcef..15d94661f9 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
 
 /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
 #define PCI_SIG_DOE_DISCOVERY       0x00
+#define PCI_SIG_DOE_CMA             0x01
+#define PCI_SIG_DOE_SECURED_CMA     0x02
 
 #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
 #define PCI_DOE_PROTOCOL_NUM_MAX    256
-- 
MST


