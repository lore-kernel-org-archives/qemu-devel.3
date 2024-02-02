Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECFBC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVucj-0007H4-Ut; Fri, 02 Feb 2024 09:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rVucj-0007Fl-3K
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:34:33 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rVuch-0003Xi-Lt
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:34:32 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so1831502a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706884350; x=1707489150;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAFMx/3dfUbawmFigzJK21LcfSzUA2GsILyY+5SKPng=;
 b=oDv1DQ5xNsp4AV5YOxmfUIV1zlGbzuQbYn1AjowxsWFuVBKMPgpXW9UkYiYJ/1ScON
 E2FNlmgFQ+Y8zN9LKrjj36ahZ+h9Z+hHmWNmIFcmtx1ntg3nHcRMIduOS0V/TQLS0kcP
 dWzfHVDs5o/sU9utPrEV6KOJhDKrr/2MtuOIf5M2BHEol77GPWv8Nii7UxF/jLAQa8Oe
 2ZZ5MWQeBZuIBszqP9UJFlaZ+GNuTq9rwTDz/PcFYaL7M9iaIfwSNvdTegns9BiFVl9P
 9IA9S6zGtoVzqcWzfmTxXkPuQJauv54RDBznLi0Kzq7KzKHLFW9dtIti9FVpOZXmPIn6
 YAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706884350; x=1707489150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAFMx/3dfUbawmFigzJK21LcfSzUA2GsILyY+5SKPng=;
 b=ZDg56jydFuoZ1FagYi6ywYehn9NB+KprpedgkW4+rIHHtWG6qXtdpDE9OH6NXLRsd0
 JifT/aKSetEALxJwxl8rUdeFWzEEKe9XiOUwbiS/ODLFWoomY0PpF1hEc6fXvLWFEPEX
 1qPyFeZ+SmvIcn7OCmGVbweFf4UJddOtpr9L3wqGENBllzOOMcsskLo5133bm9Yow6wj
 44bYwwJs67sRFBqmiP6T07/5MKqnXgdyQ0zKxSAnt46JzzgVBTjM5bNKVA+ExqjzH1PC
 2c03AYtXbohkGWFsg/tuwTSo06Dt5qsvt3OkhXoA1OG07/lNShGut849bNkUskVOBGKf
 63cg==
X-Gm-Message-State: AOJu0YxtEt4bb3cVDEkPB+LxpSiBahsMsYje+q4tDTPPv6OsYuEXXqS3
 Dp7ljzw80x2KAWdahiIfGDuFr+CA69ZcB7wxSCH6XWjL9UmmkMxUQNa3A7nlYj2ERCw9l9/4lBa
 AltDsww==
X-Google-Smtp-Source: AGHT+IHgq2Mv2XkcRvCXDJ0KaFTULXjZmhDEh4PpqKMqh2OQKtB7+iR+2wUmkTzSRCONypa9Y2sQTQ==
X-Received: by 2002:a62:e311:0:b0:6d9:b588:2053 with SMTP id
 g17-20020a62e311000000b006d9b5882053mr7944872pfh.2.1706884349175; 
 Fri, 02 Feb 2024 06:32:29 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUbL/8Rp1oxBqyoqLzA0VftqHDyU8QAHgeFHxvvIT8eLp8I1EjroL9U58/rqiulSmgHpvaYcNdozYRV+kAQjsb9281ERajm8KwghHIkuqtl7zdHM0uEYnLjpdfmTnRdyunf4hENb06P5A==
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a056a000b2000b006dde023cce8sm1684703pfu.57.2024.02.02.06.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 06:32:28 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 3/3] qapi: Define VhostDeviceProtocols and
 VirtioDeviceFeatures as plain C types
Date: Fri,  2 Feb 2024 22:32:17 +0800
Message-Id: <4ce51ef3d64fe2b09443cd0529da91115476b35a.1706883915.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706883915.git.yong.huang@smartx.com>
References: <cover.1706883915.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x535.google.com
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
2.31.1


