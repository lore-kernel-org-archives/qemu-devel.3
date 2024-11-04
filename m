Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEBCD1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Jr-0007yQ-0C; Mon, 04 Nov 2024 16:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jo-0007ra-M9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jn-0005Vn-6c
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X09gUc+uwzieH0F+I0K2aed1PpK5bPTr3a80Rrc3pVA=;
 b=XaZj5gRynQWgkX9M9MvnU6g+6MVFI5fI43glcCwVDUuYjKgR6nvwJGVu4stJ9BBDTUZJHp
 lOHADfKwQLSNU5ELcWFQ3QB1rOJQSim0FhS6N8MS2k2MlyBX8ltbj5JQz5xqKwegcNrnnt
 gSr54wntViDXsncJl+gUbJ69DVehRLw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-pgFjJ9rfMfOG_cFQG0Zvpw-1; Mon, 04 Nov 2024 16:08:57 -0500
X-MC-Unique: pgFjJ9rfMfOG_cFQG0Zvpw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d662dd3c8so2314876f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754535; x=1731359335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X09gUc+uwzieH0F+I0K2aed1PpK5bPTr3a80Rrc3pVA=;
 b=pf31zBtTOsJgpocQ8MTnCPBHM4Gt5cYsKBQr8GENRnU+g3Nf4Tf9sOWhK/tbaDf+6C
 Zl5f5bWkrYakfqUuVaBLMeT2dYDxKiC/D8YPoXXuxdkUBA7ehc+6xs4voBKa/HEyzIbo
 4DlaxilDxy0ez59wdNLLIhNUUVWf3ynoYmFzqPrb5zScplZWKwABO9jkyyGZtNCqmjrz
 sE0bZw5w8pXUSQGkbM6NHzD1YF/LgbYrEC8q/nt3TFfarqeOfBJMNOqiGDez93ndzxh7
 Q2QYsvFUCWB08zYxrD/q5+Jg4efy65teSoSXfN0m5kZBV5b2chdOLSJWb97gYfE8dGbF
 S3JA==
X-Gm-Message-State: AOJu0YwZexb/zqy2CgjDlMu6NJRXlqCeVOIMhTPerVJodvVJsyz4WjAx
 jMg9sYuCQb+Ovmoe62XgN4uxMJ/ezGaSoWu5oUj348QpHxQuIjV1wRzv/6QcK6+zv0486U9tdKa
 1f6TBNb68mVW/8Xu+CRRVLCeO/t6wWemrjfpo64pOqnoeONbEGvg3MXaOLkbgppnQQed4AT4wAE
 m8p0PGLqsXsLU6nxMscKweJnGWKSRy2w==
X-Received: by 2002:a05:600c:3547:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-431bb9855c0mr199978715e9.12.1730754535468; 
 Mon, 04 Nov 2024 13:08:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm5vJf2o0XWBZy/5c3IwjKkL01awFnXbFuO3z/oIADmtka9DnnEecgzCw7asA9BGOA7RnEPg==
X-Received: by 2002:a05:600c:3547:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-431bb9855c0mr199978545e9.12.1730754535019; 
 Mon, 04 Nov 2024 13:08:55 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9403bfsm194399045e9.21.2024.11.04.13.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:54 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:51 -0500
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


