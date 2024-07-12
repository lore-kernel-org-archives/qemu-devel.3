Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A735AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 06:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS9ic-0008GC-2W; Fri, 12 Jul 2024 02:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sS9iV-0008FT-Ux
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 02:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sS9iU-00036d-7K
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 02:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720765512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iT0fonEGBs0gDj4Bso1KFkUkZkGB0kk4Pcg41JLEbZY=;
 b=DXQTcQeZ4slQHufcQXTEuT40+rH1eMSZgesBUpOMurCR0LRYbuDfq5fcwUgMKPUI/MzBcF
 VBEPI1q5pG78+9EJoJlvwfZZvs0YfLyqCIbJDhH/IOJb2EMepByrmfzwPn3Vy/VmBf85s0
 ovoRvoOAQmNJbcxzFb8XQLLYpt/9DE4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-o86ytNMzNcGsgQU6h0_Kgw-1; Fri, 12 Jul 2024 02:25:10 -0400
X-MC-Unique: o86ytNMzNcGsgQU6h0_Kgw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c9f6677d8eso1628439a91.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 23:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720765509; x=1721370309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iT0fonEGBs0gDj4Bso1KFkUkZkGB0kk4Pcg41JLEbZY=;
 b=DGiWIvcSVhQNN4KHpcvmh+tG2hLjzrIAxlD0r6dXtRVyiPzBI9wqhIVTg1+wb3h6m6
 Y+lDilKUJbpUdk0YayalmZep4t5c18hvBltToIe7pTdOKfxet+hqHjNVGqmJ132F7aWj
 6uceAAXfZxXTv07RDIRsXGgQ8JXGcZtIXrCKwtU7q6oHdc6e19eHvfqa/xWl+iqCz8Gw
 oJD6pgFCgd86aQo/H0RNfCR1//Ac9ZPVeGcSLuB7jHmtk0XweuBsMdK2WDAZ6gXl4M4L
 H8vttqNHP+P2QIdUdw93QQD4jsYpu9mn8n70bw+atg8WRvXSvdnPtwgE64hbQJd/aaah
 Zmog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWDP2V4aSGmAZ15oa0KLUBLPKpKxhMnwk+E38plMgZws/v4/eSdrj04v5oEXcOnEhad6FoUeb7Ysw1nhe8oPU+DoKEuxE=
X-Gm-Message-State: AOJu0Yy5chIiG5H11ZBynt779l5lgfJmytTj8POswGaYF+9Qun5coRjb
 l7poZdNnpBKR1yGlZ2YNPZ6w38yf4Qo/DsW62m+wiftSXnjA8Y0ugAb51yT+0O6WwlWpzZLYIj8
 myBiHYjpQ21uysPytT+uYqRUQV6BWZa0iYjbtBhVdjcZp0x0BMQ+9
X-Received: by 2002:a17:90b:4ac7:b0:2c8:3f5:37d2 with SMTP id
 98e67ed59e1d1-2ca35c2e8d2mr9178489a91.20.1720765509112; 
 Thu, 11 Jul 2024 23:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKPLq4bwEEQ7m8jDmGIKGh5tkuQOLxMspeJp/ScuWtkpjEG2y3Abw2oXmm+w7JJi3TWkuZOw==
X-Received: by 2002:a17:90b:4ac7:b0:2c8:3f5:37d2 with SMTP id
 98e67ed59e1d1-2ca35c2e8d2mr9178479a91.20.1720765508778; 
 Thu, 11 Jul 2024 23:25:08 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.30])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2cacd404020sm644893a91.18.2024.07.11.23.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 23:25:08 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: philmd@linaro.org, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/vmcoreinfo: make guest format endian safe
Date: Fri, 12 Jul 2024 11:54:52 +0530
Message-ID: <20240712062452.31457-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Guest and host formats in struct FWCfgVMCoreInfo are written in little endian
format. However, the hypervisor host might be big endian. We need to do
appropriate conversions between the formats before comparing the values. Fix it.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/misc/vmcoreinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 833773ade5..e00df95e29 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -21,9 +21,10 @@
 static void fw_cfg_vmci_write(void *dev, off_t offset, size_t len)
 {
     VMCoreInfoState *s = VMCOREINFO(dev);
+    uint16_t guest_format = le16_to_cpu(s->vmcoreinfo.guest_format);
 
     s->has_vmcoreinfo = offset == 0 && len == sizeof(s->vmcoreinfo)
-        && s->vmcoreinfo.guest_format != FW_CFG_VMCOREINFO_FORMAT_NONE;
+        && guest_format != FW_CFG_VMCOREINFO_FORMAT_NONE;
 }
 
 static void vmcoreinfo_reset(void *dev)
-- 
2.42.0


