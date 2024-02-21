Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F28C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoZh-0003RU-Pg; Wed, 21 Feb 2024 10:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcoOz-0004Xl-Pi
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:20:53 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcnas-0001oX-MM
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:29:09 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6e458a77be3so1521167a34.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 06:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708525745; x=1709130545;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7r0K83xygSbOqxKBX8JoryJgPptOcBnumWJOEFdSHes=;
 b=IagRgFgvm8DKKGbZ4q3MOBd94+z4GSgL4m6Sd9CjrgJ9bw423c7m2pkL6zVoNkq4Gs
 k7W9ks5flC+UK0UsTmexhaz/z4NNaVRXdBSqV4oKaeLkcNMYefub0/HlbQ/zQXvB/bsh
 /x3z2JspTOuR8GzRuVZxWpMuPTzLhgunp66dj6+hXQr7Cx28+4OD5S393FGs5hcSa/fu
 vL+qKXvA4iOjPCrd/U3zOYp9e1i1xibZ9HPsI+svVb3j6dU5AfWWLDVVva8BoE9Nskhx
 ntdLK8YzF/kpga5CttCP5IzjTU4t98ubjrSdXegnlx+Zu52W9lHoU9/W4gUauJ4phMYt
 qh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708525745; x=1709130545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7r0K83xygSbOqxKBX8JoryJgPptOcBnumWJOEFdSHes=;
 b=pTEpszZPNOwBMhVcnu//Qa63xGp2K5JxXHHs6EF5v2nBJuBUoKHs8tM9Jds4fKyUR7
 VWdgL1zbDWvh5NdSz49GOhi8xtk4Vo1tcgBDK9usuRpv5exMmf/7yhnwZAA/SH9KIwWz
 9w+jsz2C3wcIHjfo+1FzC8REoOCGfsoZ0kWpj0dCIGJmryaSey3hg6uWrc29SLE3x2eA
 0xQD+9LB2C5FX5/0WOoyXuKeRLwwbxoxuWp5QtxWloeEi+J9UQOovERdWexsaaiNqYOj
 +0gqWrghnL05tueCz0IWGdPbcJS8+qh5WhRw2NYpIo9xWRDp9lhotgml24syodZ1sZhX
 0Fxw==
X-Gm-Message-State: AOJu0YzlWgYl408WfSZFvdpU0MMiFQ2IvsZTzU1Hw0/EcvK7Km4hzc1Y
 RfB4p9eYuhXCd5Hz7VWhhDNAHHk7m+SpWpsDOBB5o1vVfYNUrfH+UiNkVhSkRDEOkoSkqPxGo5M
 lYH8Wyg==
X-Google-Smtp-Source: AGHT+IFv9Q7eUxVPqCIHCqvRmuVESuj/qaZ3BNl1mzfZQHAGfvb0DozbacXzmHZrtfY8YRZ94hVn0g==
X-Received: by 2002:a05:6358:7f0d:b0:17b:638d:ac4f with SMTP id
 p13-20020a0563587f0d00b0017b638dac4fmr798588rwn.6.1708525744483; 
 Wed, 21 Feb 2024 06:29:04 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 p129-20020a625b87000000b006e4762b5f3bsm4480030pfb.172.2024.02.21.06.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 06:29:04 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 3/3] qapi: Define VhostDeviceProtocols and
 VirtioDeviceFeatures as plain C types
Date: Wed, 21 Feb 2024 22:28:53 +0800
Message-Id: <8c1c1c6982854c64af0e30982aaead3db24a99c9.1708525606.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1708525606.git.yong.huang@smartx.com>
References: <cover.1708525606.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

VhostDeviceProtocols and VirtioDeviceFeatures are only used in
virtio-hmp-cmds.c.  So define them as plain C types there, and drop
them from the QAPI schema.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/virtio/virtio-hmp-cmds.c | 16 +++++++++++++++
 qapi/virtio.json            | 39 -------------------------------------
 2 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index f95bad0069..045b472228 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -29,6 +29,22 @@
 
 #include CONFIG_DEVICES
 
+typedef struct VhostDeviceProtocols VhostDeviceProtocols;
+struct VhostDeviceProtocols {
+    strList *protocols;
+    bool has_unknown_protocols;
+    uint64_t unknown_protocols;
+};
+
+typedef struct VirtioDeviceFeatures VirtioDeviceFeatures;
+struct VirtioDeviceFeatures {
+    strList *transports;
+    bool has_dev_features;
+    strList *dev_features;
+    bool has_unknown_dev_features;
+    uint64_t unknown_dev_features;
+};
+
 #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
     { .virtio_bit = name, .feature_desc = desc }
 
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 26516fb29c..42dbc87f2f 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -300,45 +300,6 @@
   'data': { 'statuses': [ 'str' ],
             '*unknown-statuses': 'uint8' } }
 
-##
-# @VhostDeviceProtocols:
-#
-# A structure defined to list the vhost user protocol features of a
-# Vhost User device
-#
-# @protocols: List of decoded vhost user protocol features of a vhost
-#     user device
-#
-# @unknown-protocols: Vhost user device protocol features bitmap that
-#     have not been decoded
-#
-# Since: 7.2
-##
-{ 'struct': 'VhostDeviceProtocols',
-  'data': { 'protocols': [ 'str' ],
-            '*unknown-protocols': 'uint64' } }
-
-##
-# @VirtioDeviceFeatures:
-#
-# The common fields that apply to most Virtio devices.  Some devices
-# may not have their own device-specific features (e.g. virtio-rng).
-#
-# @transports: List of transport features of the virtio device
-#
-# @dev-features: List of device-specific features (if the device has
-#     unique features)
-#
-# @unknown-dev-features: Virtio device features bitmap that have not
-#     been decoded
-#
-# Since: 7.2
-##
-{ 'struct': 'VirtioDeviceFeatures',
-  'data': { 'transports': [ 'str' ],
-            '*dev-features': [ 'str' ],
-            '*unknown-dev-features': 'uint64' } }
-
 ##
 # @VirtQueueStatus:
 #
-- 
2.39.3


