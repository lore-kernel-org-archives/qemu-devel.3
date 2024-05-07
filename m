Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A016FC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Jyq-00066B-Sn; Tue, 07 May 2024 08:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Jxx-0005lf-Dh
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:30:44 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Jxv-00076E-Ov
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:30:41 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e367c2457bso22553661fa.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715085036; x=1715689836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sliD5j3ZsW+Ih/VrgBbXH2a/MnjoDv1oe45cMQ/IOgo=;
 b=RuyzOz74ucJoZ/ZTU8wfy08MCYBqrTw3ZR/D0eLYXGOfOdPb2dd3MGmybs/+VafoB6
 WgRCjom7pNkBKMmRl+BdyJY6CsRV9HIXXZqowZTazPSFZjePVviY7tjOOg71ZABqgcJI
 +EEnklpir90PNPGX5L0NCpMgqRMbnV+IGpVan0ALfu6n162eSlSM/NOFML+m2RZa6Zwi
 f/90zjWW2yvmBENayhQ1a6e4+SP6VAiUh4lXeCxSsDzLs01gUTTIiz79aPEl0of0O8om
 l8QGBRcVlD/2nNJNTc5/tCRfECs0tB8Jb1iKOX2YJOpHsUS2adA7HjKpGj4/PwO7vEBI
 yyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715085036; x=1715689836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sliD5j3ZsW+Ih/VrgBbXH2a/MnjoDv1oe45cMQ/IOgo=;
 b=ZPT+VQQWaGPhcorcpgqH8hZrCDfjAX7TI48e3EVt5o3h4s7iSi2P1UOZX+FuiMAmcE
 ilnqHb3uOYjynD3T8ojITTqFgcfN332CIzub+wuW4l9T1h33r63mp9O38N4W7W/HHztG
 vfh8tt4skyPfMZ/McaIuFY+mMcDKj2ZzfvkpiwTO8WsmHtwE9KDfAssKUW0OfjnnjIpl
 OffmraRumLpZwAHaxBaBO3ghJHJuYuPMaDa+9NLmKmx96EmxTTUsBPkixdAB/gXLdEZv
 N12FunxrvNtUng0Y7llQg3ESKjZOL6mBrtoI88120aDdX25I2buCR2UWWtN13ZF+PC6s
 yhBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbyBs1bFey3sdvxHfHbnnrSwa2gfSl/zq1txG+BzFfctnjk4YtQdhAsUrGimO6cranK/WPI4sK53tXa2Br5IOxTgr7+4s=
X-Gm-Message-State: AOJu0YxAvgE6hzhqUOkA1FOQF6Tj4QDRVC5sDbyZ/rN0ynvXDJSgTQZn
 LqfFifJuDUomZQUJDiA8HBRwa4r4wvOYSee/Y2UpMGtNHPCc+NkIMkUZK6NJswiwnPsvJBS58vT
 8
X-Google-Smtp-Source: AGHT+IFU5bqN0ONfSVTfpeV/wpmjsODw400Eeiy2TodFIAkGxfc7gOjpN6t/Dbs31AGMUYCe70PL6w==
X-Received: by 2002:a2e:9297:0:b0:2e4:f8e:3a64 with SMTP id
 d23-20020a2e9297000000b002e40f8e3a64mr769862ljh.30.1715085036211; 
 Tue, 07 May 2024 05:30:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a5d620a000000b0034ddb760da2sm13072941wru.79.2024.05.07.05.30.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 May 2024 05:30:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mattias Nissler <mnissler@rivosinc.com>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, john.levon@nutanix.com,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] system/physmem: Replace qemu_mutex_lock() calls with
 QEMU_LOCK_GUARD
Date: Tue,  7 May 2024 14:30:23 +0200
Message-ID: <20240507123025.93391-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240507123025.93391-1-philmd@linaro.org>
References: <20240507123025.93391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Simplify cpu_[un]register_map_client() and cpu_notify_map_clients()
by replacing the pair of qemu_mutex_lock/qemu_mutex_unlock calls by
the WITH_QEMU_LOCK_GUARD() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index d3a3d8a45c..5486014cf2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3086,7 +3086,7 @@ void cpu_register_map_client(QEMUBH *bh)
 {
     MapClient *client = g_malloc(sizeof(*client));
 
-    qemu_mutex_lock(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&map_client_list_lock);
     client->bh = bh;
     QLIST_INSERT_HEAD(&map_client_list, client, link);
     /* Write map_client_list before reading in_use.  */
@@ -3094,7 +3094,6 @@ void cpu_register_map_client(QEMUBH *bh)
     if (!qatomic_read(&bounce.in_use)) {
         cpu_notify_map_clients_locked();
     }
-    qemu_mutex_unlock(&map_client_list_lock);
 }
 
 void cpu_exec_init_all(void)
@@ -3117,21 +3116,19 @@ void cpu_unregister_map_client(QEMUBH *bh)
 {
     MapClient *client;
 
-    qemu_mutex_lock(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&map_client_list_lock);
     QLIST_FOREACH(client, &map_client_list, link) {
         if (client->bh == bh) {
             cpu_unregister_map_client_do(client);
             break;
         }
     }
-    qemu_mutex_unlock(&map_client_list_lock);
 }
 
 static void cpu_notify_map_clients(void)
 {
-    qemu_mutex_lock(&map_client_list_lock);
+    QEMU_LOCK_GUARD(&map_client_list_lock);
     cpu_notify_map_clients_locked();
-    qemu_mutex_unlock(&map_client_list_lock);
 }
 
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
-- 
2.41.0


