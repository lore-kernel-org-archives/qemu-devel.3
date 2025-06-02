Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A0EC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0z9-0003mH-11; Mon, 02 Jun 2025 04:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabelova31@gmail.com>)
 id 1uM0z1-0003kM-UU
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:57:28 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabelova31@gmail.com>)
 id 1uM0z0-0004Wn-EH
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:57:27 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-32a696ff4deso38090951fa.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748854644; x=1749459444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8IyhqbjoM6Y/7dTcJMbIU82rsUbs0Kd+u5FWH3M4oqQ=;
 b=i2Y0j/QNf8HjEvdQu4t3/ghzBlBbLzNvk7Yc2ak8797tT6l6UX4yUebI6PoYrJ+r4+
 HJB486iLCrIQBovo0zD4VLCRIaKgMx//LtJV7Hyi4TvdG+6VpJMIlJP96FtmzAXQGube
 BJNA0VbT/Z8om1FudWfLj5qFHV4kFsQgtZtvGCV85DykikBNIXpkQOymnvwMrIUt7cJX
 T/EWocTwB22LkUzUu/X4zvUv+PspYbylZroSR4IlcA+a0ajL9mWo0Al7QjOoT/cyQ0oj
 OTVVyiJDj6sG8305SzljpOjczdEpoQPU9Q+cqkzhTXWpHdUsLK1RdCKETFflIu/Ui+75
 EbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748854644; x=1749459444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8IyhqbjoM6Y/7dTcJMbIU82rsUbs0Kd+u5FWH3M4oqQ=;
 b=YME8S3iiOP5nThjO4lQR7j5NEpma7rzdXp9P/MDiaSlXJ9Terv4IMBplLsbGAVB030
 r8f59HtISWWlvtbhJVKW5D7fwlwtMb6jkz6Mgb5I0RarjmCjL3ZzYo5ed04rz5OYql28
 3HIyJN9K0TqDH0DA0ttfLhiaIVJWosJxJCYscnqQUOBgZHeh1AD4AzkJuN0Z97QKh3Lr
 9MWWiXLwNTaheBsX/NZ6MjP5WvJ5i7/Sd7TJN7uI7qSldWM0MQgFI58zsEYmt4Ex5163
 FIHnxVWCNJfX3MV3uZBUNgAr0C5bzxrx1iWfOZc/sWb2QS9RkCFMJUOScVm2p07ndf9T
 yEhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJjDtF+wRlSrM+k6VDpP7rPw7QTev3iKswgF0A1AnrAcKnDKe/Q1xyvA9x7I4o4f0vZZXxEqBIz/pC@nongnu.org
X-Gm-Message-State: AOJu0YzO5Bk7XrZugzl2IMJ/SJLqRX0rd4vIjE26LXDhJ0TG1APUd6Ae
 nUJKSYnvuKJ1Qcuvvev6QmrNItRAhraefTrFxMbOf2IBkvDTTJDhdwom
X-Gm-Gg: ASbGncteC3/z5ZXdjZFQ+5+4Jtm12SbmOlTVYFWgutiD2pGdRwOT/DAmHMErN944tSJ
 LKK/NlsuGNDvFSbTHLVHvyxrwwfJ0zmA1cA8iY50VamMRHh66ays9PUUUFeUe1CQtpkBwdv/sow
 u2avXwUzyOSmcQ9wXcpCJ74hyb1yb2whQKRhKxmxFl3Hqbh64w3WYenYgD2oeApmJo12HU+q3Rb
 BcUCcteQVgxoEifw6Oz4XoDr1tx4jYU4ZsRgdsAxlYt1K10i+kZDW1GyH8FxqRxx8nAPzNBcyhL
 YphRkJJYPLnSreyfYzJK/+3OPVkjeJvQtVUjB9Fk+2EFfXudclEzxwnvcf+barAOUCxL
X-Google-Smtp-Source: AGHT+IFmvsSFAskKH7wDCIRqJAYFJbX3VVUh2NIv6UB4OsBFYO2eJCWkMCnD6ZwoQZJ4d61baaTwkQ==
X-Received: by 2002:a2e:9a04:0:b0:32a:6e20:7cd4 with SMTP id
 38308e7fff4ca-32a907c3968mr37032061fa.21.1748854643849; 
 Mon, 02 Jun 2025 01:57:23 -0700 (PDT)
Received: from localhost.localdomain ([81.9.21.4])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-32a85b5664asm14150041fa.60.2025.06.02.01.57.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Jun 2025 01:57:23 -0700 (PDT)
From: Anastasia Belova <nabelova31@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Anastasia Belova <nabelova31@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: [PATCH] net: fix buffer overflow in af_xdp_umem_create()
Date: Mon,  2 Jun 2025 11:57:17 +0300
Message-ID: <20250602085719.5058-1-nabelova31@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=nabelova31@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

s->pool has n_descs elements so maximum i should be
n_descs - 1. Fix the upper bound.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: cb039ef3d9 ("net: add initial support for AF_XDP network backend")
Signed-off-by: Anastasia Belova <nabelova31@gmail.com>
---
 net/af-xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 01c5fb914e..d022534d76 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -323,7 +323,7 @@ static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
 
     s->pool = g_new(uint64_t, n_descs);
     /* Fill the pool in the opposite order, because it's a LIFO queue. */
-    for (i = n_descs; i >= 0; i--) {
+    for (i = n_descs - 1; i >= 0; i--) {
         s->pool[i] = i * XSK_UMEM__DEFAULT_FRAME_SIZE;
     }
     s->n_pool = n_descs;
-- 
2.47.0


