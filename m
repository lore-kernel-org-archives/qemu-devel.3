Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B71606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQgTk1qW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUTj-0003vW-Bo; Sun, 01 Nov 2026 07:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavhadia@gmail.com>)
 id 1xNSW1-0006Zq-5W
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 05:10:17 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavhadia@gmail.com>)
 id 1xNSVz-0000Zh-Np
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 05:10:16 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso615600a12.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793527814; x=1794132614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qH6ite90XrQgwVrKxwUVy9zH4hj5U42obetdpMO0lFs=;
 b=PQgTk1qWf/T9i0hNGVwOQppHyKbZSbv1LmBZFokgOqC6DfEh1NtgCci1bI2Lgfclgf
 YZVLa+jCFc/sGBrLH4v17DLXsvN6pOmHm9qN2BuZNuhbfzvqMwYPtBC3K/kUKNB1W5O4
 gd/aWtmHeof8wFxHQ/YhZQiLgv3vPw+czaXIbbvzboOHQtd2Fklx8mDNgRNeAcuP3s9J
 9ajNcjnnP/gcFCH+3CsBEC+WpnnytszqQvBrH7PLRSfXV04Q/oHBQP16EvonutnLffz+
 Mzh0Psk2kEcYDcWd4722qYw9V5slg7WjYmJISgsJPmQx22SzXS2Eq/vpPbTIkIycAj5T
 EUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793527814; x=1794132614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qH6ite90XrQgwVrKxwUVy9zH4hj5U42obetdpMO0lFs=;
 b=2lFnhsiTLk5WX41o4sjWEuSJ/pagjqyTAhe6hAwELBPb7rJUepjZXTpsOlhaoXxBzv
 TWazsWS+2m1inJ9yVaY7ctR5yLnu1ajZv6TNnkFGZr44ytFeINgtEC1gGCwYURNnwv/e
 5CbPXrQ1vMOGg46LAknOA4UuFpkvD0CX6avBshxEJibCAw6b1EaTpCOP/ae/HhmTLgNQ
 eUDwccgiCfYsdR3Wuwjq59nsvBlkDCs75G9BEhIjugmvpUKeFSrBrkCYpibx6/2nVLr1
 c275RKQLLJIoM1InXV/GwajdekcdOs6u2NDnlTHLiSeTJVcmGBSoxS/LxoySq1r+JV0g
 ZJMg==
X-Gm-Message-State: APuU4Z+/0K0qCXa0OVCqVEAd0qaQNPz9JGD9oYwwKNcz7cua8EipMP3c
 /EbrLUP0CS3Gth8fDeTlY+oV5lZuZU8WhrzEro7HIHp1LyxwpsU1/fenOZSeBSTG
X-Gm-Gg: AYBFou0v9t4iVoFBrTqFQI5Xoc3R2GoBlDAlXabsmtRQbU4RF/iMu6HR3TyNhk0Nqbi
 ccATDhO934l2V2YjLylaoRNUPjyBDJ8n4cnpQ4zNN2fSUnb78NwxyhLL+pu4jm7NfCiVE+bWD0A
 ZQFSqinzEXAwCBZYcw7pOrJ4r1YMjaQQ3StG4o5ahemUtCq46JHokGSE7/96ksCcIHb7e9kO1J0
 wCc/mqH9xTqbofilNTFBC7rPfGBAQtMN46PTqtKJWpIe2BxYPTX7j2L0L9hjpcaCyWsJYqHtiSO
 yQrgXUBncwVHybM1EKUYMYW3QEy0XVGy9E9RzutvJ8uvvkf+nnDzaDdsP/MO2sy75HIRO5VtwA0
 LbPI82v1ttHyWbH8gbGhE2khYS0mPfF3yEJ4es3beQ+LTko6hnNciJtHAJwuSsnb+mXdLmLlTgB
 23t1WDNDhq6jK43o0Ifkeunw9AslE9/T748OLhvah/Zz4T5q52beXTSgHPYF/cMfnMToUR6OpRN
 r/Oh+XgrJdmWbt9xDbLauw2KMyzjlv8RKvZMR7SfN5Yl4RxEDd7D4LkQtF5LsG+N6gXg9BCics5
 i/eONlimvRUkW5kvfbHujouY
X-Received: by 2002:a17:90b:17cb:b0:3ac:9ed8:f309 with SMTP id
 98e67ed59e1d1-3ae89736030mr6307640a91.29.1793527813681; 
 Sun, 01 Nov 2026 02:10:13 -0800 (PST)
Received: from oslab.. ([140.120.15.183]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e949077sm14429336a91.9.2026.11.01.02.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:10:13 -0800 (PST)
From: tavha <tavhadia@gmail.com>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, amit@kernel.org, mst@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 tavha <tavhadia@gmail.com>
Subject: [PATCH] virtio-console: Fix typo in comment
Date: Sun,  1 Nov 2026 18:10:08 +0800
Message-ID: <20261101101008.72831-1-tavhadia@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=tavhadia@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Nov 2026 07:15:59 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: tavha <tavhadia@gmail.com>
---
 hw/char/virtio-console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index db9d8ca797..3374a4630a 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -259,7 +259,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
         /*
          * For consoles we don't block guest data transfer just
          * because nothing is connected - we'll just let it go
-         * whetherever the chardev wants - /dev/null probably.
+         * wherever the chardev wants - /dev/null probably.
          *
          * For serial ports we need 100% reliable data transfer
          * so we use the opened/closed signals from chardev to
-- 
2.43.0


