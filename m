Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0471C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8mK-0000tk-4a; Wed, 03 Jul 2024 18:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mH-0000rJ-6B
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mF-0004u9-MT
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3m1Xw9Ub15rW4o3esEC0MkiVgr91nuiCfcAKrltL4I=;
 b=gLXVBeNnXJ8IB6Sds6w6bO15BWiBQbFy/VAYVAqPhZycinXuGop37Xx/dJ76cAoqTKXRy6
 GzD94knMuvc0WSOO4n1UvTI5IGze/C9y6s9rwv1Obfa1qdmeG/H1SdjxjwYhCVjgw/xTL2
 vJsEau0NLi6t7JHHh7NxWozi/uyaj+U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-onQhYNbOMBGVh91aRUk3gw-1; Wed, 03 Jul 2024 18:48:37 -0400
X-MC-Unique: onQhYNbOMBGVh91aRUk3gw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57c93227bbeso2848118a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046916; x=1720651716;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3m1Xw9Ub15rW4o3esEC0MkiVgr91nuiCfcAKrltL4I=;
 b=WoByO90matRelWjwdZpiunVKCI2hCsRtIILv4asopnMPOTnrAutMFZzstoJNAXhJgQ
 ZailbZbX52iHZ4q2mvykaQf8jz1k1enSCohC/tqejEDEznpuHigHpodlJgToszqA6/cT
 5PdD/FkLpOQUS0vtiIxSIQ/QBn1twtQBLForIWVfa5ocmKaNUERXF2iIMYjp6lsSeF2W
 kYg7bgwlQi9hq5BDghRHsmRX7pdAWLEbdOhAi8amHABDM/gmBHidQ4SIFdnIArlxgKw3
 zFH+ba4WVkdNA/x0WZd5FM9jVYRA7MdpBa5MSIYXkDZ1LTZTeIeatxfvEAPGGvK4fv8P
 K/Nw==
X-Gm-Message-State: AOJu0YwfTPivsk2ln4DUgPd7RQ6UmdmJwyQ69UkVFczdgd/u5VYOq+/v
 LU5doCoJPLr3hWFn0sXZPcxlK228v1TpTAcrZXMxrQ0v5b/jzOcSKRfByVbpLA52Wgg/q4zMD17
 bWeOpJ2UmIIZXbMTaGC9q9FRpNKRTH2ILvydATK4L3I0PMQxYtDfGJkfSFF0ODMsuvkYr4p5JW5
 Oqb/b6A1nEZGaF/eUoqCuG4qe6Zjzo4Q==
X-Received: by 2002:a05:6402:358d:b0:57d:4ca2:fdab with SMTP id
 4fb4d7f45d1cf-5879f0c68d1mr8884830a12.3.1720046916445; 
 Wed, 03 Jul 2024 15:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8UBCVXWDCCux2Am9uUGEs2H0c4tVgBuv20zn9EgbKXUA7mtcJj51lLPMzIURZgiDFAqzcGg==
X-Received: by 2002:a05:6402:358d:b0:57d:4ca2:fdab with SMTP id
 4fb4d7f45d1cf-5879f0c68d1mr8884810a12.3.1720046915828; 
 Wed, 03 Jul 2024 15:48:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861324ff85sm7692218a12.29.2024.07.03.15.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:35 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 54/85] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Message-ID: <e349062727c7b35ac4c9bd08c534f64f571389fe.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


