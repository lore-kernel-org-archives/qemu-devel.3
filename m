Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC98E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQj94-0007FA-3P; Thu, 26 Dec 2024 03:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YBJtZwgKCnsvtgZnsrgfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--wuhaotsh.bounces.google.com>)
 id 1tQj92-0007E5-0n
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:00 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YBJtZwgKCnsvtgZnsrgfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--wuhaotsh.bounces.google.com>)
 id 1tQj90-0000Vq-I2
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:22:59 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2ee46799961so11939836a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201376; x=1735806176; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VGy+Nj9c83OW8O8chp58gNtXq2XnteX0cby7ElrxjQo=;
 b=qIj+i2QdTBsine+aRyNSy0mwBdbz6SUfWAuCXC1b90Ea+iRsARpXb2xPze3TX/xrgR
 B0nA3imIdUg+L7KgQJ508NW9mJNx4zEr34/gQ1vWSp63cS/MKwimXdid2IOqQblGa8dm
 EDZo7FkrHJfk5qvdYoH8p6VmdX7zB0fIgq0mcUtzo3tJzJpz1lrU+/pSPjt4u1zlHTlV
 0timW8czcvBYwISp040tDlG9k0gzu1H0wQBmE/cYZCV3/8KyYmPeLRxP4Q5uKy9k6ORl
 xBfa0A5oZtNf3qkpLp3mIUvTozS0yRdc6IgyczAYI0cUzb0OiEnpseUMiyqzYiVbXqOt
 Nyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201376; x=1735806176;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGy+Nj9c83OW8O8chp58gNtXq2XnteX0cby7ElrxjQo=;
 b=QNV1aARfyYVqgBBxnJ6Xz14UREHCcugIy0k5VQXI0mvwPos4g4BUfUc1pq5YX4/xGC
 W7JwYjHr7DGFUUGi1bS6TPZMcjv1KLXL+gefZ+m1JW3sIaUkRd42zj4JnJjQvClaK9YV
 7gSVkpdVK7mYqybqvG6qPPPTPA+djDpc9fVbExiayehmdK8tfIRBh9biEok44ptReiNs
 P5C6YW9yZpoLGESb78ljrjnNdoJEay88cKufOpwOmScdngZrxVs2CdBvqnyzQ5WwI1sZ
 Jdl0egi+Zk8pEck2cmN2Jtd1U/bEJynzsAPagkjFsrQBQ5kKUIZhWemk0YgBEYv3P7qq
 7Zhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo+xSPjcC9QREDHZmDKrRRa8NDiAVqCw+Ts2HNpXArkva3siCL3S3v72gewgUq1ZriYMYYtnXzExec@nongnu.org
X-Gm-Message-State: AOJu0YxitRTia104iRkw0uANeCIRNOKsimuwHI7d4GdIrfs3DJ5fb1XZ
 3BC1jla9c0T2dVQhDfbep4vFWbagh7ZIZhHQRPYayHugw+4xzgl4ZNraRvyprU0lptGvsFykL6G
 cA/iBgzmQgQ==
X-Google-Smtp-Source: AGHT+IHMegsaGTz7f3lYreTT/FCkGL8v+0m/rPF+CjGW6xWTCDy+nSMVYE0yC7MRLBvGJP2PsVJPzpnC1IYWaQ==
X-Received: from pfwz25.prod.google.com ([2002:a05:6a00:1d99:b0:725:1e74:6a17])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8085:b0:725:e309:7110 with SMTP id
 d2e1a72fcca58-72abdd3bf64mr33653526b3a.5.1735201376201; 
 Thu, 26 Dec 2024 00:22:56 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:21 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-3-wuhaotsh@google.com>
Subject: [PATCH 02/17] roms: Update vbootrom to 1287b6e
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3YBJtZwgKCnsvtgZnsrgfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This newer vbootrom supports NPCM8xx. Similar to the NPCM7XX one
it supports loading the UBoot from the SPI device and not more.

We updated the npcm7xx bootrom to be compiled from this version.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 768 bytes
 roms/vbootrom               |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
index 38f89d1b97b0c2e133af2a9fbed0521be132065b..903f126636f9ef5d1100c056656ccfb2b32e5e10 100644
GIT binary patch
delta 90
zcmZo*Yhc^(l+nU*!D9x6DNkDr=09a-2ztoGz`#|*F#jn7L;r()|Np;c0m>C1$z?$0
Ywog`Ma%Vh0Ig_b-VgU<}A_D>d06Rh+WdHyG

delta 69
zcmZo*Yhc^(lu^NO!D9x2$xoRb7CdZGnE#ZCA@Cs+0|QqL!~CZV4E+!GPG)41X52Pe
SmdTy*+~icIZXQJj1ONb5*AzJb

diff --git a/roms/vbootrom b/roms/vbootrom
index 0c37a43527..1287b6e42e 160000
--- a/roms/vbootrom
+++ b/roms/vbootrom
@@ -1 +1 @@
-Subproject commit 0c37a43527f0ee2b9584e7fb2fdc805e902635ac
+Subproject commit 1287b6e42e839ba2ab0f06268c5b53ae60df3537
-- 
2.47.1.613.gc27f4b7a9f-goog


