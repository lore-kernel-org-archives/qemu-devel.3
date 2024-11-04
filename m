Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEC5D1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Jm-0007le-V5; Mon, 04 Nov 2024 16:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jj-0007cd-Qv
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ji-0005VR-3h
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=usD4x4c8Ymugs9Gl4cc3YR1/YhQZPAPXFQu0stQIFOc=;
 b=NY2NVe501OmYhowq9c9voZ2rJIBRoYQcJSwak2Tzi8R1KzIbNkPe25x5jbA9EJrIullMyD
 qoGRoFQXpOH3kLvKreJzrXlZBqGL4lWF5fkYAXx/RxCbrN+QTDS2Ku7FjD4hpynYYXySLR
 W+8HYGecQf2mXijcR2DRq7lQM3BC01Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-haK3J3zLNgWxeYIltyGe3A-1; Mon, 04 Nov 2024 16:08:51 -0500
X-MC-Unique: haK3J3zLNgWxeYIltyGe3A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d4d51b4efso2041267f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754528; x=1731359328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usD4x4c8Ymugs9Gl4cc3YR1/YhQZPAPXFQu0stQIFOc=;
 b=qfevMahLRI4uLyZjmnY1sMgXI39PRq6t0NKUA2H5Ru7oY8ae9SoLnNd0MYcUYyXjp3
 m52VKGdQ3BxNh2Kj9/6HbGuqK15aGXbCI7KVDrqk8zWpXMqmRbpwH3k/Tj0JX/6LirTy
 PYQIK3NGZ5jinQ15vRiU2b7JgoKBaUTyH8TBfucbYqF4f2hHYzEqvIE/PDzqA/ry+Hko
 lHFEBf0HKl3ENGOB3VHo79eaZMHlKHKXpy0oXQFkWcrzLfE5ntGJ6qql3Y2Zvf7TVkIE
 GugdE5JzW2a5F7Wr8rIUpduj02gaHerXS7qbsWeb8EO3ohxmxuVz5YvguPKC/WFsKgZQ
 HKGg==
X-Gm-Message-State: AOJu0Yzock4tr2M3yhQrx+JOu1jBmMhpWNXlCmfcOrxvlAAhIJg605oD
 k1t5iGOKPDhQMR/VM0krJ82dJC1XkOo4/6DOxKEduM1ty2X1mvAephljnJ0/FXs2lMnGdbHCfvN
 YM3VP2fFXawJMsi0CZ+NG23GtTfrD0+423s4T9kKo9bdq2nE/xqnccAF/Ndu/++X4cvGsIXLmPi
 cvbuWt55PDZ29T6BGt9xBjvMhK7MPnuw==
X-Received: by 2002:adf:a29b:0:b0:37d:3f5c:5a83 with SMTP id
 ffacd0b85a97d-38061128754mr23470787f8f.19.1730754527746; 
 Mon, 04 Nov 2024 13:08:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk1F4+4O1FfYKhwBdGgRrar/XWF8+yHFwFWAvh6G0j2HzLPX/vlkVqf2kCsUhD7dRTBNjQ4g==
X-Received: by 2002:adf:a29b:0:b0:37d:3f5c:5a83 with SMTP id
 ffacd0b85a97d-38061128754mr23470769f8f.19.1730754527297; 
 Mon, 04 Nov 2024 13:08:47 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e528sm14260739f8f.78.2024.11.04.13.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:47 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 48/65] hw/cxl: Check input includes at least the header in
 cmd_features_set_feature()
Message-ID: <91a743bd021a262af61c79cc35f0b634b2fcf3ad.1730754238.git.mst@redhat.com>
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

A buggy guest might write an insufficiently large message.
Check the header is present. Whilst zero data after the header is very
odd it will just result in failure to copy any data.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 17924410dd..e63140aefe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1238,6 +1238,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLType3Dev *ct3d;
     uint16_t count;
 
+    if (len_in < sizeof(*hdr)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
 
     if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
         return CXL_MBOX_UNSUPPORTED;
-- 
MST


