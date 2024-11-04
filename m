Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3FAD1BDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84YP-0007Ud-H8; Mon, 04 Nov 2024 16:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84YD-0007So-KI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Y9-0006t8-AF
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730755428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YES/BaGPLolp3I4A+ulCB6t6e5td1yjQzn9Wkx1/9XA=;
 b=BA0/ohVtKWYQxLR+kcJfG5ELztIZm3/WWUETM4xhv1C+nHDVPXViK71+s1lz7LGd7B+X3g
 wDLU54CeLs6OwsAz+2QurJKardUcOG76WQMpmrctkhzuXO4c4iPmy+auuFjUlVIoAMxyGl
 Nf/o9aRiR2R2cvVzdF/yLTZQ6ElPA4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-1ja-N_1rNhOOSACL3C1uQw-1; Mon, 04 Nov 2024 16:23:47 -0500
X-MC-Unique: 1ja-N_1rNhOOSACL3C1uQw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso30753725e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730755425; x=1731360225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YES/BaGPLolp3I4A+ulCB6t6e5td1yjQzn9Wkx1/9XA=;
 b=CG9I2ivKdfDQfEXkyCqhnXUTiVNrAlQm+IojixxpasNoCDx3Z7DCjTVigMJ69SxtuB
 ZLf+4kr74wXRmEAo1sPn5T1jDG8HUOrq/izQy4o1z8xXTYuRQbuZ9K/mEdXMg52ZTDXF
 HltpGtaSFji6VPKd3uHJaCDHSYap5TJB0VptlAZQER830jh+Q0HHnHABFTea/JgULmwd
 h1S8Wmt5CvR5U10HRypOBa5PHJKLJOLCOZ2hi2uy8SQTxUUw0m7vlFjHClSXFBxReYt+
 tZFSsC4B/bxehde1bUqUiYuVXGwawQ2cNsca9U/W35nt07inH+vwIQwDCpfU7jq8JsME
 RNzw==
X-Gm-Message-State: AOJu0YyIEnMdVTZ9UIQ0bFM0mkp7Fa/uQgkA0BEpu0/oPIv9pNAcEPLq
 az+1ywj+6uVnPm/HHHRjioJqPsMgkGwpI/I7qvsCvfaYWv3Xl27W2bcXM3EUgEkgjapaj8LpK0n
 BOmix40r3cUxsbmDyAXb0mIFWFD7K/sV11Gkr8e/K05CZQ5aPZhG7nTa6p+FC5CtKr+WrNJlkYs
 dAiMOJ0fsGJg4AT2aPLppeXeR5GpDJIQ==
X-Received: by 2002:a05:600c:1909:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-432886e57e1mr98137605e9.11.1730755425293; 
 Mon, 04 Nov 2024 13:23:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0T/2EEwOGjnhy4TnYT5mhVJDEA2DhqW1Uf8aTmUtmcn68dDJvwTEEhnUZvHlJgdD3ymCf/Q==
X-Received: by 2002:a05:600c:1909:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-432886e57e1mr98137445e9.11.1730755424903; 
 Mon, 04 Nov 2024 13:23:44 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a267dfadsm1547085e9.0.2024.11.04.13.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:23:44 -0800 (PST)
Date: Mon, 4 Nov 2024 16:23:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 51/65] hw/cxl: Check the length of data requested fits in
 get_log()
Message-ID: <f9f0fa2438c6934aa76b06e9a6cef283176ceb8d.1730754238.git.mst@redhat.com>
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

Checking offset + length is of no relevance when verifying the CEL
data will fit in the mailbox payload. Only the length is is relevant.

Note that this removes a potential overflow.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 27fadc4fa8..2aa7ffed84 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -947,7 +947,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
      * the only possible failure would be if the mailbox itself isn't big
      * enough.
      */
-    if (get_log->offset + get_log->length > cci->payload_max) {
+    if (get_log->length > cci->payload_max) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
-- 
MST


