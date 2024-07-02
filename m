Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD986C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeD9-0003no-0u; Tue, 02 Jul 2024 10:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCz-00038j-Cq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCm-0008UC-D1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3m1Xw9Ub15rW4o3esEC0MkiVgr91nuiCfcAKrltL4I=;
 b=W3VW8c7kY8m9GB2o+H2rbZvWdtymoNlr6JBtVNaCZZ/5oSdB2Z3JJZcdUKZSKzMYicOP+u
 LjpHQZnJUR1dVlXn5SlVdOr48O+TQyQYjcXke1JshHOF9pe03WQsj3Ub6WWhXOwJPP4bVA
 tA4VTbkQKFejlqrTrPMRToCUgSRJZDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-mvfk0eRONjejOoDZDgbL_w-1; Tue, 02 Jul 2024 10:09:58 -0400
X-MC-Unique: mvfk0eRONjejOoDZDgbL_w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4258675a531so12042875e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929397; x=1720534197;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3m1Xw9Ub15rW4o3esEC0MkiVgr91nuiCfcAKrltL4I=;
 b=mg1rx3WnZd5+UaLRp2estZ+q174sxddDdM0ZkwXAs1ymUimQRTauOlbejhlzNvYIK8
 yYpSZ17Fdi7PPtSr+BpPmGrm4sArHijV8wZE0PWO8vC/rSd8Bv4cto3pIMXEFsSNGBHv
 XItzHc+fvmuFMUTG343/sYB6ByYOrbk+RG2B9wTZc3IucsniiepcPJNK2KHhaL7CwzR9
 QVLZWTVXUK22buDAf21lhobucdEkt8AZ42esT0i8DegKfkmS0g1N8VFVOc7GNBWFyaV7
 xfHbW+FYegtrCChn4Y5FREXctojtUNt4cVknJx5NXT2rBQj3+zKXNydIoiCTSjjh+JLS
 NQ8Q==
X-Gm-Message-State: AOJu0Yw3ZJJx+NZCp4Q3i7qSQ6EvR4MGhPlscic+Z+as+CHwHKtfSOP6
 d55tRRcE33pUFpREtayoNFWSiF/m1izsgCPlz+zNNka7lfFyG4Z+A5IY/9wqaRKY6V6EBwbNjvu
 l3WBuHtfN+vy4OBFPjiLGDqjMV4lW2psFSqAkxF3gGzADOQzbfnu3w1njLi9Hk9uNRJvWkU9rQS
 6FMFYqfSmn3OI3oOdGSKYfLwAolEd/Cg==
X-Received: by 2002:a05:600c:4fd6:b0:425:6fe4:5472 with SMTP id
 5b1f17b1804b1-4257a00aab9mr58442915e9.2.1719929396849; 
 Tue, 02 Jul 2024 07:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk/LF8ZodaFy/BNUOoJ/VaWcxPCUuYc5QH9ugeJsd02gz8Ub+/tUp56Ox4TYW1JhlBnTWJ5w==
X-Received: by 2002:a05:600c:4fd6:b0:425:6fe4:5472 with SMTP id
 5b1f17b1804b1-4257a00aab9mr58442605e9.2.1719929396264; 
 Tue, 02 Jul 2024 07:09:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1481sm13327925f8f.55.2024.07.02.07.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:55 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 57/91] tests/qtest/vhost-user-blk-test: use memory-backend-shm
Message-ID: <e01261f2d69ea4eaee139b64816327e7e35e145e.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

`memory-backend-memfd` is available only on Linux while the new
`memory-backend-shm` can be used on any POSIX-compliant operating
system. Let's use it so we can run the test in multiple environments.

Since we are here, let`s remove `share=on` which is the default for shm
(and also for memfd).

Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100527.145883-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 117b9acd10..ea90d41232 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -906,7 +906,7 @@ static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
                            vhost_user_blk_bin);
 
     g_string_append_printf(cmd_line,
-            " -object memory-backend-memfd,id=mem,size=256M,share=on "
+            " -object memory-backend-shm,id=mem,size=256M "
             " -M memory-backend=mem -m 256M ");
 
     for (i = 0; i < vus_instances; i++) {
-- 
MST


