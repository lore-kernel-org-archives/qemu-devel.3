Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF97CD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Jp-0007rz-Co; Mon, 04 Nov 2024 16:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jl-0007jo-M2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jk-0005VY-4t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YE3jbdd2VsjbSTZBjpl3sy5PbqS0FjP8JRPVWflkFi0=;
 b=eUtqMPOmZ75s0nydaP3FU6JBCUzhedqtsO5qiq/oXSbb/JIFJg7DvTMagqhRYB4HIxNA4o
 R/JdEPr7sCTWH1eT2/Hj4C5qymAT4bbybUDMb8i8EZ4Y/mLiCyCqHzot7AUKKYqoIyspJI
 n49nSwBDt/ZH7rxbBUsHP1Omw6WaG0g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-m7AFdiuBPrq5RI4N4pvftw-1; Mon, 04 Nov 2024 16:08:54 -0500
X-MC-Unique: m7AFdiuBPrq5RI4N4pvftw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso30653565e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754532; x=1731359332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YE3jbdd2VsjbSTZBjpl3sy5PbqS0FjP8JRPVWflkFi0=;
 b=sd9wpWUjP2pgSFpOsdOoquU6UoF6ifKuIvUQc25WSpTppVMQq7X345c/2cbCimfvzP
 GSIUniQrLcHigNc/WUcmPmby5zW3EQh7Qp4JJHHxZDQjl+nrsmLBxbarTbjceLeHRk+b
 zzRV5CuNXCT1laSllFF7njhAcVDoK6rZCVPD5DJ88h0pTWld/ByHpbSEmtwGIpnNeWoK
 kASvj5jdxTQZGdMTAc2VsYn+kf3lDDQ7ZmUf03TbIli9G+LkhDriKt/TekzN3vy4jqx9
 ocBR07TcS1DZh6xWHAA3G3iECJ2nxECFjurVcCGZVBPP05ZbLs29Syv03t/tVrAsfz4q
 +lHw==
X-Gm-Message-State: AOJu0Yx3cwW+5efokSyuaypMs6geFR+8uih6u2mMx54Rdp5VkCnudHm/
 4sQGF2/kxrYPqCDt17NQ9H5RLhpHUhH5iY6V/TF1RB+qwf+kQKL4+x+lDKJY8nHgyurwdyewfvk
 znlQNpyUtRaaMB3m/i6MNWyi82E/o+gof/FEpguX9GLg8qP8SJiA6vGRkr/BZ36PTNfmfStfxAr
 d3auhPcW2ryz0JMgWgM0I3CeFJDNhcgQ==
X-Received: by 2002:a05:600c:5486:b0:431:51c0:c90f with SMTP id
 5b1f17b1804b1-43283255472mr117030515e9.21.1730754531997; 
 Mon, 04 Nov 2024 13:08:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyGuabMcOjD+Im0BD9FjrVzXqRAXS+HvFXGhxfx+Bhhq7+NF/W6JSKi1fFfo6plWoFBbOkeQ==
X-Received: by 2002:a05:600c:5486:b0:431:51c0:c90f with SMTP id
 5b1f17b1804b1-43283255472mr117030325e9.21.1730754531532; 
 Mon, 04 Nov 2024 13:08:51 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e94cdsm164169865e9.28.2024.11.04.13.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:50 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 49/65] hw/cxl: Check input length is large enough in
 cmd_events_clear_records()
Message-ID: <f4a12ba66bebfe200d7f56015c1cd5af321ab152.1730754238.git.mst@redhat.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Buggy software might write a message that is too short for
either the header, or the header + the event data that is specified
in the header.  This may result in accesses beyond the range of the
message allocated as a duplicate of the incoming message buffer.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e63140aefe..3cb499a24f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -266,6 +266,12 @@ static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
     CXLClearEventPayload *pl;
 
     pl = (CXLClearEventPayload *)payload_in;
+
+    if (len_in < sizeof(*pl) ||
+        len_in < sizeof(*pl) + sizeof(*pl->handle) * pl->nr_recs) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     *len_out = 0;
     return cxl_event_clear_records(cxlds, pl);
 }
-- 
MST


