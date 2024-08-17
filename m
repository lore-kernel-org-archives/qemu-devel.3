Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54666C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 07:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfDRE-0007vb-EK; Sat, 17 Aug 2024 03:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sfDQx-0007qD-AQ
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 03:01:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sfDQr-0000y8-LR
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 03:01:06 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d3d662631aso1607812a91.1
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 00:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723878060; x=1724482860;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uoLVcxBvzTNKoye12hLBhREbMjSKAq5KzLpEfss6xGc=;
 b=csrjC7qOTl4lGMqH/3AuVEmK8uFBy8xa2lh9R+EPkmBvHi/jbY+uI3rS9qh7u1cXP3
 63TwjH4s/1MYrf2mT/1faTXoIyAd7MWv+LJaSOK5kC6hJN1nNJjIU9sasidKeYSx12UL
 qh3h3MQu+Yl9m0N0id+w1NYIpq2Ti/Iw+XFddF1aTgt5N7kXNGHU/QDBcpGZqtD+7nHa
 4ccIxo7/2/4J1bQtg4wZ2PiiYp5t3yabxt0uoDseBBvz2Gd1j9kO18zBJOvsAHrCuPRS
 SLgAt0Ptesd3U04WHb45Sjo1fvo2mPyYSihnzg3+BGJTRWCFWYEJQq02ytixRulfruRK
 rF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723878060; x=1724482860;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoLVcxBvzTNKoye12hLBhREbMjSKAq5KzLpEfss6xGc=;
 b=doKw+1zF3Vfms6NrSj76k2XvEE8NrXD+E4rGsl73xF98kZND6w7lqOahYvQYRAPhB0
 /UiRVc30IDLOy+2fL39l3myARnpayi3giJhHWPR2ZlrdWmXNCoP0R+1TmB4dk3QfWl1h
 uy7OYszIUJIsnbN6nWYeLi3/KZ1/QaIsxSqRLKj0c39SLyJucoKBItdJ7u747RZyq7+e
 Fwi2w+JePW3IKvpQH9PxOTNYOXMMZFst48YnNRWWBileSDzFb+YP4C5AF8hfmCwb/8dI
 az88IFFOq36BxxTFR2dttX4Nd0dGMIf2lGvTgznQsOp6pDi2qXfPWXdW01E5jvbnGr8+
 Doqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJvuQj0zYUZK+jSJqTMRnXwseNpVVCpKtv8Hcnn/q7JilCYRrUSEcO50to5Y7TQVnh3w1M2sniK8zkkCSYYNGLhHNgsEE=
X-Gm-Message-State: AOJu0YyELqBmwtLBj79DMmDgL1mkQxkhBSPtxMpt9crdKmddWG2TIca5
 CQK6Yl+AAomOmv/RToD3gphjL2OWgPkH48q9t/AhUhETBR2hrYZa18YoPeS4fq0=
X-Google-Smtp-Source: AGHT+IFWNnVrH2kAKqHPajUMreUxC6PlucG3a01HO1LyGQb8RDDGP7gxPlaDkIhWYqHv48zO4+Pjvw==
X-Received: by 2002:a17:90b:ed0:b0:2d3:9137:2375 with SMTP id
 98e67ed59e1d1-2d3dfdaadc6mr5755199a91.4.1723878059770; 
 Sat, 17 Aug 2024 00:00:59 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2d3e3c7d7bdsm3051174a91.44.2024.08.17.00.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Aug 2024 00:00:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 17 Aug 2024 16:00:43 +0900
Subject: [PATCH] net: Check if nc is NULL in qemu_get_vnet_hdr_len()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-net-v1-1-699b5591ad3b@daynix.com>
X-B4-Tracking: v=1; b=H4sIAJpKwGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Nz3bzUEt2UZBMzQwtL00QjS1MloMqCotS0zAqwKdGxtbUAbmDhN1U
 AAAA=
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
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

A netdev may not have a peer specified, resulting in NULL. We should
make it behave like /dev/null in such a case instead of letting it
cause segmentatin fault.

Fixes: 4b52d63249a5 ("tap: Remove qemu_using_vnet_hdr()")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/net.c b/net/net.c
index 6938da05e077..4c21d91f9450 100644
--- a/net/net.c
+++ b/net/net.c
@@ -542,6 +542,10 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
 
 int qemu_get_vnet_hdr_len(NetClientState *nc)
 {
+    if (!nc) {
+        return 0;
+    }
+
     return nc->vnet_hdr_len;
 }
 

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240817-net-dc461895a295

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


