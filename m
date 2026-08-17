Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A887DC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2aj-0008Ni-JQ; Mon, 17 Aug 2026 15:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZG-0006OS-Ba
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZC-0006V9-3U
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-495590dde14so47154795e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993212; x=1787598012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pRVn12OZURVOkefSN5IC+KPyhyzqGTNv//YQOD1+l6Q=;
 b=FLFVoerdoNx6OKEtdK9LwbsYCnTNqYPmCQksjBE+tPUW+Choe4ux/ds4A6rOw8Vlov
 OG4zpcbhu24xyvjaMBXozfw/sr0gSqBfOwIOWIQMMUA0U2zG9LMVh86IRe3kLh5RAzeM
 sS2giGHKf1u/T1Ssb3Ay0emRKrBJ8nzKYC+x3LVrgef6C24bpS88yU6Xq/VtJpQDSHdO
 b1kfRc452iEjOc0aeVl0/n8LAaNC/Qrd5Hf8JJBPw+sQt2pg8b8b3SYyD/+29ZM79nHQ
 i06MXmKeG3fA9dudjaDGZqGfDd2U++guameGVQItOjEW0qVuFq3pp/kywXDcvFQOcPu3
 OuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993212; x=1787598012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pRVn12OZURVOkefSN5IC+KPyhyzqGTNv//YQOD1+l6Q=;
 b=bVutwUsoBd+Vi5o19SfXWsQML6zUH8PDrdz5N9tTO7qpZ0rFfj1vy3wMLvLXItYIYe
 RJa4lJOq3POtlbNainz6Rq9ge9/DEX0oyB739laSPWMCkKPztKDzSYaFgD9topjQP5hO
 OOCG5bu5VzpjNUaQ+j5VrES3nNlLq2qzbrd+0HU/EM2SjVK15MrQDI8ft1bq/2LQMjZW
 byY8Xnf4ENlsXRN8cKsFgDSJZeIk1nwX6taUaEe22rFwvUreIMYJirfr5YB0+OKB3pQv
 z/oZNB2qH1U9jRYVBBLpECfKg9PXxf5My9GIT59aWtTkfDFHfUKZEXivSiD8oTbejiaS
 5h5g==
X-Gm-Message-State: AOJu0Ywwta+rVOf6OeBYu3J9z4qMFscmG0xOwwDBQAdN0c4lz3YWYa98
 0W1Tl8Szn+DNhxxw4iq9ds2Gwl6B9EU74K0CBtywbuV5y6wE6pxFBw1wPexFI+9QVBzS1pVcVVQ
 rhphO
X-Gm-Gg: AR+sD13vzVF1Onwdshct+9kNGngyIIYPYkI8i4+BttSUVcEVcr+vlJihO+DdN6/JlQ0
 ojeUABbby8UCb/kN6O//KNwfL7GszLbidRbE6jn3+KZ5kZH42zmvvhTqbteu2L4AkgN/1wf5O4d
 n5kg9gt6r7j3Tcra6mhi076jZBBWPFcLGBvPETr5+YPsqT93v91hTI8CtJNpd4nP5aiywk3K0fS
 iZ/nnyhuAgrZg1lTB1kcUeSbIhazQXwQ/qyTdLQI5PTQD8gvlbTnMrD/cquZ7D9OZqk0vv7oWh5
 XqPc72f60/BoH1JuTEkbWRb8uYQ1a5UQRzWQ8IdVOXvRyGvEhhp303B3zIygP7g8sRM7l0Y3oti
 jIh8Dbq332aZmR2xPQoGh7+/eH4e+IfKdgLIdpyZNEziEQXGWMLdJ9sVHyYEBE2AwAXMAY2478E
 r95YgMpHCLXdgHpeffqCNXQt7YYsk0E0yJ0lay1EX9DOXpIN9AOQ==
X-Received: by 2002:a05:600c:46cf:b0:499:8807:345f with SMTP id
 5b1f17b1804b1-4999fb8a0f0mr33016805e9.13.1786993212517; 
 Mon, 17 Aug 2026 12:00:12 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.12.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:11 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v6 24/25] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Mon, 17 Aug 2026 20:59:41 +0200
Message-ID: <20260817185942.1065143-25-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=den@openvz.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

These tests pass with parallels format. Add parallels to supporting
formats for these tests.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/256                      | 2 +-
 tests/qemu-iotests/299                      | 2 +-
 tests/qemu-iotests/304                      | 2 +-
 tests/qemu-iotests/tests/block-status-cache | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index f34af6cef7..1a4c9c6885 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -26,7 +26,7 @@ from iotests import log
 
 iotests.verify_virtio_scsi_pci_or_ccw()
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'])
 size = 64 * 1024 * 1024
 
 with iotests.FilePath('img0') as img0_path, \
diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
index a7122941fd..d8c4399446 100755
--- a/tests/qemu-iotests/299
+++ b/tests/qemu-iotests/299
@@ -23,7 +23,7 @@ import iotests
 
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
 )
 
 nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index 198f282087..1ebf999930 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -23,7 +23,7 @@
 import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
 
-iotests.script_initialize(supported_fmts=['qcow2'],
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'],
                           supported_protocols=['file'])
 
 test_img = file_path('test.qcow2')
diff --git a/tests/qemu-iotests/tests/block-status-cache b/tests/qemu-iotests/tests/block-status-cache
index 5a7bc2c149..ade3d5b169 100755
--- a/tests/qemu-iotests/tests/block-status-cache
+++ b/tests/qemu-iotests/tests/block-status-cache
@@ -131,5 +131,5 @@ class TestBscWithNbd(iotests.QMPTestCase):
 if __name__ == '__main__':
     # The block-status cache only works on the protocol layer, so to test it,
     # we can only use the raw format
-    iotests.main(supported_fmts=['raw'],
+    iotests.main(supported_fmts=['raw', 'parallels'],
                  supported_protocols=['file'])
-- 
2.53.0


