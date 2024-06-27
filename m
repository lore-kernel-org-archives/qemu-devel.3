Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5F3C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpMN-0003wd-5N; Thu, 27 Jun 2024 09:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLm-0002Qv-22
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLj-0006cq-Tj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:45 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70673c32118so3808609b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495582; x=1720100382;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tYtFORlnbJN2+36DGKZvH4uH8NkkbHJaO5uVtPxgJZE=;
 b=rSJK99kK5W6uCphpWOC+v4YGxL8ZILNdhrJa5Va5ybMNK7R0Qnvy0bH8YL1I5VXEns
 gKF7E6jt2tjJxiKL/rJlbgeEIHtRTNsLnvAY6uFiyRygRJ0cvJ9AkP2Gk7nsGZph64JM
 cJnZolehVFqZDDoWhPWY2AJzejjJ8M9+vyUjaKJ258WmFgg6A32c9BGk0j8c/vKWSOpu
 uaPLyxQPygIwae78oEemGZGoBZR12hPXM/+GEaD/sNRBe5jgfZpN33vXmxotihhPnIUM
 DYWvBf4Y1qVQ5bwoQ9AMsuiw8ruXKJTdnpOkvUPLg17qPXMOGmK9bdrNGcLInb+shwnw
 jR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495582; x=1720100382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYtFORlnbJN2+36DGKZvH4uH8NkkbHJaO5uVtPxgJZE=;
 b=M9BJwgbGu9QtLPkxMk8jCZDbNVoPLGqk3a1ThxZXNZNiTEEmZejZR/vpi3ieUgmMzv
 +QRzufSGP2tnp3ItDtkXhQU26nytxA2CbIThurlEhd1NL4ez4etuUuS5P2JwZygB54Xc
 4XvZ+Qqd539qUfiDuHkEWLk2QaKY5B+eNlCUlJKK75kJzoa8cjc+GgcL+JXYN0P4yPny
 udzO/tt63fIhz31/KcAy0J0IAD/N1JjhMxY043VntnG5Rgsuh0QOcLwUraJn6oN0FGut
 QBERvTUylnYxMY2IhGscnRFoizxKSjxan4bB+07KUKARnaYfOmBlL2WreyBMiVJUgRGH
 m24A==
X-Gm-Message-State: AOJu0YwBjmq5cS8pxdLnr4wEYo+OmJEMSYrz58GwhHtnJJkXzol3tm1F
 2kOdAN3RfMV4oo2EsqQ64pY+ODme/SV2w02yTBzk2IKPAI5AeGjOdpZT3snBSTY=
X-Google-Smtp-Source: AGHT+IFXFWZxtxNetDL0x3QR81Q4NSGV4KUcXaVakXLBlruN2EYupN0blY/9gL/zVeN/j6uHx6EZmA==
X-Received: by 2002:a05:6a00:1d1d:b0:706:6cb2:ed17 with SMTP id
 d2e1a72fcca58-7067455be23mr14036044b3a.2.1719495582624; 
 Thu, 27 Jun 2024 06:39:42 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706b491008dsm1338261b3a.57.2024.06.27.06.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:39:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:58 +0900
Subject: [PATCH v2 15/15] tests/qtest: Free GThread
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-15-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

These GThreads are never referenced.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/vhost-user-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f66..929af5c183ce 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -928,7 +928,7 @@ static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
 {
     TestServer *s = test_server_new("reconnect", arg);
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
@@ -965,7 +965,7 @@ static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
 
     s->test_fail = true;
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
@@ -980,7 +980,7 @@ static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 

-- 
2.45.2


