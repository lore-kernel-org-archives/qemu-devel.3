Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA0ED1BDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84YD-0007SP-ES; Mon, 04 Nov 2024 16:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Y6-0007Ry-OH
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Y3-0006sp-Eg
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730755421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X09gUc+uwzieH0F+I0K2aed1PpK5bPTr3a80Rrc3pVA=;
 b=DIwK8eD/RLGAjF81MTSRPJV2wjF+EYNMM6v3+h03Lbfs7PfZ9CVl5oXX7oSibkipS2PO59
 nU52iYZZAVIugu84v3NqOaggzOGmOuqhlxnGczAMS52KKbodDRluPzCjNvmhPMcx1fUysi
 U6hd/tZ40VTWSl1D4SPGSMLMhw3ieyI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-muIJaDK1Mkym7X32QT5jnA-1; Mon, 04 Nov 2024 16:23:40 -0500
X-MC-Unique: muIJaDK1Mkym7X32QT5jnA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d52ca258eso2239920f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730755418; x=1731360218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X09gUc+uwzieH0F+I0K2aed1PpK5bPTr3a80Rrc3pVA=;
 b=MdBStzUOts6y1/UhXnkkKDLsBt6H5/GtlHKg/NlLmUSdq2mxlXbse8LAh/jDg6+y9O
 4NOtc1h+9SvTjUT4G1c6UFA60ykJXnDa+OO0CIYg2n10Zqd375R3S+SmZ4H1VegzGGw/
 RTCmbkR3Rzv45nOwu3Z2OVR/BOcRRriYMR2jr16A4LYRIcon2/pRzTlEHe1huRzn+1FE
 1lZZIYlJrsgnBQwWUbztAqllG6FpvXF05axkqjWI4Xah11/aT/sc5cPcMDKUmREJpTZD
 KosT79chyKjNdJzJMoNwa9KMMWZjlha8yoD2yD7uuDTCW42soz5IbB5psL5UpVJZgJUq
 tAQA==
X-Gm-Message-State: AOJu0YxRXA0ZsMRZOCXEsa9KVE3HknVwv6kGJVKqKLsHOZB3ZMUPpfPG
 r9f2rXQzZCsLhbCfZxm3dQWFUhH8c6lmT5Qt/VTM6DX1dn91EU4faDBpgpWSSeGwy+4ExhDuN11
 4FeaWGr5iSQzh1o+ZqAMWnl2FvGKL+iqHLFxREWSNGkz3UBhRqjnPBValGH4qokrgFTUj8oMwhB
 zgk2Ur8f2Zv2a/+/XLsEZub4NcV2LfMg==
X-Received: by 2002:a05:6000:1b08:b0:378:89be:1825 with SMTP id
 ffacd0b85a97d-381b710fbb0mr14315484f8f.49.1730755418275; 
 Mon, 04 Nov 2024 13:23:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSPyeteAV5XgPhKIIF2a2LYIAbvEtdkix6lQRHRFsVR5uTo9tWCd7LO84jCce15FOWdbog2g==
X-Received: by 2002:a05:6000:1b08:b0:378:89be:1825 with SMTP id
 ffacd0b85a97d-381b710fbb0mr14315470f8f.49.1730755417856; 
 Mon, 04 Nov 2024 13:23:37 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4a46sm14135152f8f.41.2024.11.04.13.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:23:37 -0800 (PST)
Date: Mon, 4 Nov 2024 16:23:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 50/65] hw/cxl: Check enough data in
 cmd_firmware_update_transfer()
Message-ID: <a3995360aeec62902f045142840c1fd334e9725f.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Message-ID: <20241104212334.pIfXSoDiu1A3SOnufXLrtAzdpykS8DpNKGunh7FEYX0@z>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Buggy guest can write a message that advertises more data that
is provided. As QEMU internally duplicates the reported message
size, this may result in an out of bounds access.
Add sanity checks on the size to avoid this.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3cb499a24f..27fadc4fa8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -705,6 +705,10 @@ static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_transfer = (void *)payload_in;
     size_t offset, length;
 
+    if (len < sizeof(*fw_transfer)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
         /*
          * At this point there aren't any on-going transfers
-- 
MST


