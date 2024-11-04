Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED17D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84KA-000140-Hl; Mon, 04 Nov 2024 16:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84K8-0000wQ-J2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84K7-0005X1-2F
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z8mjCAYRXCtl4i5x731E2QWqLSQ+blqkHsX/35ib1TE=;
 b=A34QkXLyj7k8va6cXHfioEKBG9kcAsT8pFIo1xBeUhu8wXiqSt2rHGjs0ThOzn5T43yeLq
 4Oa9jn4lnOtw9kWHihF5BoJZy46o2CHKwE7cvMwyKNBcb8fjUHsyaxTCcRAf07rF/OI0RU
 g6UOO/J7WALAMM0k77nc929c8ykXD+c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-FY0PbRVZNRSO4HWPtcHqQQ-1; Mon, 04 Nov 2024 16:09:16 -0500
X-MC-Unique: FY0PbRVZNRSO4HWPtcHqQQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso27297275e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754555; x=1731359355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8mjCAYRXCtl4i5x731E2QWqLSQ+blqkHsX/35ib1TE=;
 b=BEcKQDYusjtFS+EXwXjSv2kHqo9hZLU5kIOyMjU6k79aXB/aYsU3TEX6U96JyTXk+2
 //nYeL0f4y271gFw1Gus8xsvKhGnm8MrO9vmzTCTHUUJYMcUgjuLUpbiAbHU170iMvFS
 Yd6JjJYtjXCKVrkvFvvEtQkwGYopXArQyf+71PlVK0rrpUp6W8dTg9twE0Oz/d4FBDnA
 Io8uCtKwTvR5C1Ak0YMhl8w6IztbxfFkevS1oBSFqWMkJiRvsocOG7nA8frjpaIwkJkL
 ThazhJ40jZZZEtTZ2J42dQuCDXoVc+Ip2SjZutJBeCLf8Om1Wohj4PFe4srGHrr9vPB/
 xHMA==
X-Gm-Message-State: AOJu0YxV66czLlIK6bzYRHLbsEQFDUWKk49VfWGhttvbol7lTWbyJ3SK
 IPAktqFG7rZYgzro5vz8VXmvb4yWfp2TO26N/XIe4heyHiqbQe7IFawcTOgJ28GNwfn8bL8ci2C
 BMDoqM+1T6ewZ7Bgecyync+GY1I4c5Y+ck90WKCp5tEbxd22X1JOvm2PF7PCxL2/lA1M5ZnLae+
 1Cnr64IeO8n/UynXM7w7FjkGOmsQGbbQ==
X-Received: by 2002:a05:600c:1382:b0:431:5475:3cd1 with SMTP id
 5b1f17b1804b1-4327dacc373mr122768585e9.17.1730754554797; 
 Mon, 04 Nov 2024 13:09:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9OxVsWEUkkxztFDINuwekKPZehgtJpRIpJYkMWxO6+XhnNGH3YGJU36vfpcI+EJq92UN0+g==
X-Received: by 2002:a05:600c:1382:b0:431:5475:3cd1 with SMTP id
 5b1f17b1804b1-4327dacc373mr122768395e9.17.1730754554404; 
 Mon, 04 Nov 2024 13:09:14 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ac002sm164216815e9.5.2024.11.04.13.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:13 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 56/65] hw/cxl: Ensure there is enough data to read the input
 header in cmd_get_physical_port_state()
Message-ID: <721c99aefcdb311bd41d20678d3935fd11454641.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If len_in is smaller than the header length then the accessing the
number of ports will result in an out of bounds access.
Add a check to avoid this.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-11-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f4a436e172..2d4d62c454 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -530,6 +530,9 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
     out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
 
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
     /* Check if what was requested can fit */
     if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
         return CXL_MBOX_INVALID_INPUT;
-- 
MST


