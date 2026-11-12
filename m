Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0A606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MU8sg3v6;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JqQbUWyh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYwH-0001DM-OQ; Thu, 12 Nov 2026 12:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvj-0000QX-O0
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvi-0001b7-80
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sqBpAzyqfEQcH9rl/bb7M8TwEN+j4MMtl69FAHbaUo=;
 b=MU8sg3v61+40VnP2g8HVMX4BPDHdmDT0wjwZjiEyEA8bW8pFDTxywCXA5WzpqfGo20fPqx
 exS4pHtVCyJ+794RvoYoYuVv5vIzcw68ChW+2jj8R/4fIo6+hpEfO2l5mTUA+BVJlNTp6J
 kS7Ug8qTceG6OIdsqyUFOgQXAZiR+iU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-gSSTkbulOgyV8IAMwLBPMA-1; Thu, 12 Nov 2026 12:49:44 -0500
X-MC-Unique: gSSTkbulOgyV8IAMwLBPMA-1
X-Mimecast-MFC-AGG-ID: gSSTkbulOgyV8IAMwLBPMA_1794505783
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b175a69ab8so40980a91.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505783; x=1795110583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+sqBpAzyqfEQcH9rl/bb7M8TwEN+j4MMtl69FAHbaUo=;
 b=JqQbUWyh/a8vL5sa4qbDHe+/wQJZP892qwKK6Utk8nTcf5wfWaL5PEbVl30ojmskVa
 fvPF7M4gezmgPefKqpPBvTiULGBOT+buQEvEnCEJUuK+aMJlHzJSevSEbRYrBLfFgj1h
 NUidy59kTHG/1xvXryPCMHyrZAV65YMQgwrm+Dov7A7Bjry6xm6/W/uvHiOVY+dLyE4f
 1AGDyo9m1u7o6zHHsZlRZzryzPAJyNWfzydOG9syhyr8CW24A1W7M8WWHzLPr1dQEFBc
 GF9tgrKI0P9cNqGi5nPk06d96UdFCVqZ+UmiC7d1hk3uWGrexe79MTOUMhCVAXOttR/O
 a33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505783; x=1795110583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+sqBpAzyqfEQcH9rl/bb7M8TwEN+j4MMtl69FAHbaUo=;
 b=KAPR+LCpkVsrmd36ssO+9UhyNjMctOLEnwcfBY37tgbXno35fl2rOajqrhmp2JZURI
 M5mYuG7gv6blixFA+7hbr/TzeJ9+YujqVc4TgvbFYp7QgLquqP4u3lTuWzNSvR62WmR8
 +CoIQkcTu0+eAB4zyxpkQDQHcLXYLtMHyGNiDbThebh0BbGU8gT0OIjSlsymn1tZxWcG
 EO4akT48/vDbJZ6l1vidazKrbx0oJ0HqxAfAzTfrIdkmfl/Wqyx0NlZWyU18Kg1TtKRD
 0bFbh1XXgZBILli3rMXx93S9dZlsEH1nwGx2+ktj3kCNfzVlj/nltt+ksLf0tGsMzgqp
 Qwng==
X-Gm-Message-State: APuU4Z/L6kFCN0sLKmOZWDfLlEEy+3Amc1/CVxagQtjuchi4nZApSVEu
 jLWqzh6qnwR6WRavn8UEkv/Pdhr9JNZxNnZks5VwEDzVJhDWWytkE04eaReQ1Q9s2tjXw6c0URR
 1tngBf++HP2zqcWNErhmNMsOW5fOkwOwHQoxVwOzEoh5LdfbfDmcLSwWIGzdXuDStATrJxfZmFi
 5bW7lYw1/qVNdaAHUzaT29qLOr33QEwJF4dKFJCSujkg==
X-Gm-Gg: AYBFou1ac/DP0dHwLZ6lPbO3HpWmQmG0ZtmdaxwEAkLI/htS9poApifyLlq2lrePOca
 aaosLhUeM5n8hqd153nLVQZ4ZUy/klj1NPvuPdIKCjdjdo90forTb+WsXMv9F78qizRDpbqyXib
 ne+Yx6i6B91wbfll6bx3CDimHUONhhQRuU7qrVfSbNqMZsUcAtiUZqFnegpKM42jDL2RyYLoPt7
 RWjiHfgwrT2ZYseAw894sKKsOgmgSGkkgFf6RMFaeyMSPoUbF9TUhhLcCwzK6vspk5WAObbVAS1
 rCGCqh+NYjzdrZWONTRryUPPfUUh6h8viehc5/G3LC4IZ2VIJdqMSXw6u/UZIw7g6EFSl8YCHh2
 c0hqblKL/vKmFQcJWH45csnZO/MG5NXZvGlCgy0jaS5RkXg==
X-Received: by 2002:a17:90b:2d08:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3b182f26e76mr6567040a91.49.1794505783041; 
 Thu, 12 Nov 2026 09:49:43 -0800 (PST)
X-Received: by 2002:a17:90b:2d08:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3b182f26e76mr6567005a91.49.1794505782421; 
 Thu, 12 Nov 2026 09:49:42 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0fdbdsm5664821a91.10.2026.11.12.09.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:49:41 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 3/9] hw/usb/dev-mtp: Check length of class control request
Date: Thu, 12 Nov 2026 18:49:00 +0100
Message-ID: <20261112174907.158825-4-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112174907.158825-1-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

usb_mtp_handle_control() reads a 16-bit event code from the request
data without checking that the host actually sent it. A request with
wLength < 2 makes the device act on stale bytes left in the control
buffer.

STALL requests that are too short to hold the event code.

Cc: qemu-stable@nongnu.org
Fixes: 47bff13cea8d ("dev-mtp: add support for canceling transaction")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1c14770a9c..1a26f681ce 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1525,6 +1525,10 @@ static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
 
     switch (request) {
     case ClassInterfaceOutRequest | 0x64:
+        if (length < sizeof(*event)) {
+            p->status = USB_RET_STALL;
+            break;
+        }
         if (*event == EVT_CANCEL_TRANSACTION) {
             g_free(s->result);
             s->result = NULL;
-- 
2.56.0


