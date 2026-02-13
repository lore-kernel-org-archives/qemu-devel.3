Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49A5EDF17E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqwmf-0007Zv-Ec; Fri, 13 Feb 2026 12:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vqwmd-0007Xv-1v
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:16:47 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vqwma-0006wr-ET
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:16:46 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2aaecf9c325so7874735ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771003001; x=1771607801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B2QC7hLfF9zjfQ04CPizme4X1fY5wq+GdA4jvJ9NH8A=;
 b=GeCzpLpjZ530LZPgATRDPm2khp9XQyP3UyHn01x9DD9DlaKdRA1tpj4cVIgwXk9sLr
 UnDvtxKLMGfZtJgM3k/QixDrqVORX4Tw1yPvZjoPYJSLeENpF3Ej++cDOxp6vG5uhBAk
 riCZ4FI7K87rGvG/jkp37OYW/M1FtgGVE8X3ndxNEVGncP7eBbcnDn6CO9wqdbhGBdSY
 lMQAeX0aF2MUn0pdeZZQGDTKK3MD8AU/ocBfst/x2/KyjismRD1rXXQAQLEksMF0cpaZ
 M3FGAeZbvAbTB8JzL97syGf+iE4mgU/9qRonqzKGmViwEjhlqFWkAwxm6wjaPGkZlyiH
 aWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771003001; x=1771607801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2QC7hLfF9zjfQ04CPizme4X1fY5wq+GdA4jvJ9NH8A=;
 b=E4bwrfkUJ/u4P152Na3Q+am+e2eu9Rk6WKIh1fONEhCv9bi/O2+YRNYW0s06/520WN
 h8AeQTxnh+r4nssX7KIdyEZrC/W0P8U/kfjgsEwnMulGUTFdhfBdF+jeEKPeASoIVo/Y
 d8ZgOuNU/+hZJR3jmynka50yXObuvpQ2EkmTx8LTGyq9+S/oXIfz4HqntHP5hCvkcinz
 1djar/tOaRcDkjd0llQDVP6PzGx27wMJIGo0Xg+VySRORggCn4hyTO6YdEofEhW7IAlU
 pkjoLdIymfyMmr2/9ykbCIftG3iEnGYjTYkJVm4N/hRIutf2TvUawjsCtyZpZYcK73ZT
 qnbw==
X-Gm-Message-State: AOJu0YxRhTG1gEF8Kv8Bpu1A/VTXPFVo4kPj1P1T4zbIh1iIXnH8gVY8
 Tf2t5HGjRERCfnDDJvbCDgfK8UUfMVjJVD6Ea3Sx0KyNwBcwXOZ8QaTXbTXcHTtQ
X-Gm-Gg: AZuq6aJXn87oKJui1pL3crkZBVccpocSyrJ2KWHIjKxVgV7x+gRwQsHvJafr72wpngF
 iIGE28k8EO2pCkgltimKcj5r5+T80EeWvS3r88yTzeYgF78DtMBtfZNHdxsNiEL2KnGURrCc9wg
 DPRmF/8pNEN+NUweGUE5lwD+xYaPOhU0iP/AYFtX9jIo2v+Y/ICnlcv8vQ/BIlNjpxHNVkPcf9b
 CGpBoX5o5e5SdlWcf5f3HfGGE4rpSg2iyDvnNgM7nUcmeqUvZbJ92WAcgOGnqdWv6NIxlL8901G
 ncRQSKjGEUTzkwgOFxgiy+hPAiw53/W/cRJxA99zASj8FjuIllDwvQtFRZ5BrjgrVbwYOK80x8N
 vWLlo3LxxP2uRXBm5Q3UKYKqPZoJlPdrxUMZ5S6m1L6p/CXEeZB4CeV8ssZPLHWiIl5AVw2WhLn
 nHIEou27GQZiYwuYkxSxsTr/F6NIFUJ58q9ZI=
X-Received: by 2002:a17:903:240f:b0:2aa:f5b4:9a2e with SMTP id
 d9443c01a7336-2ac97445ea2mr9336925ad.11.1771003001469; 
 Fri, 13 Feb 2026 09:16:41 -0800 (PST)
Received: from localhost.localdomain ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29998c45sm87095575ad.88.2026.02.13.09.16.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:16:40 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V4 1/4] qapi/misc: Fix missed query-iothreads items
Date: Sat, 14 Feb 2026 01:16:19 +0800
Message-ID: <20260213171622.55629-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..1f5062df2a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,11 +117,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


