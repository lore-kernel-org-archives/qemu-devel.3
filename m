Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02157C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfe7Z-0003j7-TV; Thu, 29 Feb 2024 05:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfe7Y-0003iv-Fs
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:58:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfe7W-0007gl-Fq
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709204312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+gxeeJcUQjAy3SqvxBlO0jLM/NRP9qgi5kknMaeZSsQ=;
 b=cPdNlHz6VvIywEx4NbZWUVqUh+MdDotX10fNT/2mmE6JxAhRrVMfW0PCBrq5F23BzYN5wo
 Zl9BJdByRsbeBk0MRf7fE/ruNHfyOyAjgXmIBkvxYCsEd7DrTue6tSGZbtohIu2UiMwjRk
 tRR57x9qAIRp4JUnINx1z0OGKgILIS4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Teita05iOE2uNSw6uOqZWg-1; Thu, 29 Feb 2024 05:58:31 -0500
X-MC-Unique: Teita05iOE2uNSw6uOqZWg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68facaf1c37so7979386d6.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709204311; x=1709809111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+gxeeJcUQjAy3SqvxBlO0jLM/NRP9qgi5kknMaeZSsQ=;
 b=hVotAqNz55ZxU277pTfTc8teoQ2286qN+FUNbfMu6vt3Wst2pCZ8DAG9h7OhvcgTCg
 MXf9U7GBG0LSq++IGlrTF+Mt4QClHnsvH2QAjg+3koIs6OCDhld+ON8Gfol9nsvKEQ4H
 0ffGonYAWZQFbDWK2HmccSHuH7O+CUdRQdd/tfbMh7P4EjOuGZmlU1Wr0uR9p4qBVxyy
 DMOiy+bf6GarrGreU27XKNfpeaCxWsvLz7K7ovsf4/oS5wABo9Q0tZgu5ZniktAj2eFl
 RDEvcErI1XZ9572QyK/VSOeTvXmdzsG9VxFs3EayuVt6sP5HBORZKytbcH2xE9ANSlZW
 LlAA==
X-Gm-Message-State: AOJu0YzJ9xoTs4lEoblzgmfr6L92Wjq90H8pBM3taDaT0+aFv8Xcgggu
 MOG3DtK522u8K3KUmEs4OXV7q0cpjOePir7ySxhGGO3HftYIzYc78N4ijhpg9VhJ/CVCgft6yFZ
 oaLyHtmxRN7WIKJaucpw6zLysATYYdb3sEAM3pDaRLB1LEHOxK/aSrYsWnLpHLzWQfsk6u6XiMe
 SSjllNtR7OrTQnXjKpV3ry4CJANlDfbK/itpBh
X-Received: by 2002:a05:6214:186a:b0:690:4629:cf82 with SMTP id
 eh10-20020a056214186a00b006904629cf82mr1528944qvb.37.1709204310853; 
 Thu, 29 Feb 2024 02:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEylpieQOjlwC/axGdUs9NfKIQaMgW0ICT/vVFzqBpaPI+Lg0vBCB/LJLfDBGolQ10buPl3hQ==
X-Received: by 2002:a05:6214:186a:b0:690:4629:cf82 with SMTP id
 eh10-20020a056214186a00b006904629cf82mr1528924qvb.37.1709204310541; 
 Thu, 29 Feb 2024 02:58:30 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 q14-20020a0cfa0e000000b0068f920768a5sm591497qvn.140.2024.02.29.02.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 02:58:29 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] qapi: Fix format of the memory-backend-file's @rom property
 doc comment
Date: Thu, 29 Feb 2024 11:58:26 +0100
Message-ID: <20240229105826.16354-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reflow paragraph following commit a937b6aa73 ("qapi: Reformat doc
comments to conform to current conventions"): use 4 spaces indentation,
70 columns width, and two spaces to separate sentences.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 qapi/qom.json | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 2a6e49365a..db1b0fdea2 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -668,19 +668,20 @@
 # @readonly: if true, the backing file is opened read-only; if false,
 #     it is opened read-write.  (default: false)
 #
-# @rom: whether to create Read Only Memory (ROM) that cannot be modified
-#       by the VM.  Any write attempts to such ROM will be denied.  Most
-#       use cases want writable RAM instead of ROM.  However, selected use
-#       cases, like R/O NVDIMMs, can benefit from ROM.  If set to 'on',
-#       create ROM; if set to 'off', create writable RAM;  if set to
-#       'auto', the value of the @readonly property is used.  This
-#       property is primarily helpful when we want to have proper RAM in
-#       configurations that would traditionally create ROM before this
-#       property was introduced: VM templating, where we want to open a
-#       file readonly (@readonly set to true) and mark the memory to be
-#       private for QEMU (@share set to false).  For this use case, we need
-#       writable RAM instead of ROM, and want to set this property to 'off'.
-#       (default: auto, since 8.2)
+# @rom: whether to create Read Only Memory (ROM) that cannot be
+#     modified by the VM.  Any write attempts to such ROM will be
+#     denied.  Most use cases want writable RAM instead of ROM.
+#     However, selected use cases, like R/O NVDIMMs, can benefit from
+#     ROM.  If set to 'on', create ROM; if set to 'off', create
+#     writable RAM; if set to 'auto', the value of the @readonly
+#     property is used.  This property is primarily helpful when we
+#     want to have proper RAM in configurations that would
+#     traditionally create ROM before this property was introduced: VM
+#     templating, where we want to open a file readonly (@readonly set
+#     to true) and mark the memory to be private for QEMU (@share set
+#     to false).  For this use case, we need writable RAM instead of
+#     ROM, and want to set this property to 'off'.  (default: auto,
+#     since 8.2)
 #
 # Since: 2.1
 ##
-- 
2.44.0


