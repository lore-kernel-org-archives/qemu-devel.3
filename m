Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074D6CED272
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy453-0002Ny-CI; Tue, 08 Oct 2024 02:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sy44z-0002EM-Pf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 02:52:21 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sy44y-0006Zy-Fn
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 02:52:21 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e260b747fdcso4793807276.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370338; x=1728975138;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R1d7TDzHibv/EJuj9skVG1YdSpRjycErvD1ixQRqV18=;
 b=JsfdUDwcq8b3hLJxgZ3yqpwaPODxs+QKrDSQulc7X+mZ5sTp2wnYQuewFej5z4ucvx
 ENg28ezCNcSce5ZHmFNqw9QLTrqSvy4MD5k5pfRGO47K5/EKd7VEhJs7l9iNHG0nRavi
 1E8i3jxj/v60iVhIA3SMCrV4sEkQ5WyKekXsktyAxc/uEG1b2Pj3q+MuQazuWCwYX2x9
 7a/ly77hlew4+uG7RvtDmv2W9CuCsCVtrQZP6NVgpxSXIG6vIugpDKT+lGjDwV6JOupM
 TWnRs1Ek+0luGDbEK7SnwMwjJBNI/SmVGiFAl7e55KjZo/LbObhr5U3TYgeJ8UabUZ2n
 dZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370338; x=1728975138;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R1d7TDzHibv/EJuj9skVG1YdSpRjycErvD1ixQRqV18=;
 b=Q4O1GybhvTM5ZZXKD6Q1zKL1mD5hSbEc/sUMmqNgPEBvbMeCCYSi8UZyblyTBtJaaR
 R1ApFN9aDz2GB8f7im+W6VmhKOJWf2h6/Yf8JfZkZ0ojhO+Shv67t88nDsizTqDB67dI
 PX/QUVrINJeHIzIteafMAbkwihCh51h0owLJEWGfFOgmxHY1gS5VTTVaJPPFgvxL5qFh
 u7xtFJWtnVGMurKVK3TG9bC/8NzWJSybrIvZjdOMaLwa1HlnEj+s1XtfOs4lkpLx/0QF
 Viv/1yUSPb0gyByiDBbGR3RDMOGCjhpEkAhfE3SOW2/n7XUhzzPZR3y0QfSNWwue59Hd
 9oEQ==
X-Gm-Message-State: AOJu0YzQmxa+h1Td/AgSvmdlmVS9G3C85DftAWUawYLOm4U9BNX6lT+G
 LZ0Z3Mnp5qjUHDKmVkHVKhZwKK0HnxAMVD8rsAS0wFpK3KO/Sc9k1eu6ndJZgAXMGy13ZzgBm4z
 iT3g=
X-Google-Smtp-Source: AGHT+IFyGdTwdB2dnbmjggR66QYYcYwSp+mRMj4MaBhJQmLJHND0RjHZxn8iEEbUmL6BhVnfsBuRbA==
X-Received: by 2002:a05:6902:1b09:b0:e22:4f74:9590 with SMTP id
 3f1490d57ef6-e289392b69fmr10035686276.27.1728370338132; 
 Mon, 07 Oct 2024 23:52:18 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71df0d7cfa4sm5483182b3a.196.2024.10.07.23.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:52:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:52:06 +0900
Subject: [PATCH] tap-linux: Open ipvtap and macvtap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
X-B4-Tracking: v=1; b=H4sIAJXWBGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwML3dzE5LKSxALdJENTo1TTxKQkE1NzJaDqgqLUtMwKsEnRsbW1ANN
 khjBZAAAA
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::b33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

ipvtap and macvtap create a file for each interface unlike tuntap, which
creates one file shared by all interfaces. Try to open a file dedicated
to the interface first for ipvtap and macvtap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap-linux.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/tap-linux.c b/net/tap-linux.c
index 1226d5fda2d9..22ec2f45d2b7 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     int len = sizeof(struct virtio_net_hdr);
     unsigned int features;
 
-    fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
+
+    ret = if_nametoindex(ifname);
+    if (ret) {
+        g_autofree char *file = g_strdup_printf("/dev/tap%d", ret);
+        fd = open(file, O_RDWR);
+    } else {
+        fd = -1;
+    }
+
     if (fd < 0) {
-        error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN);
-        return -1;
+        fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
+        if (fd < 0) {
+            error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN);
+            return -1;
+        }
     }
     memset(&ifr, 0, sizeof(ifr));
     ifr.ifr_flags = IFF_TAP | IFF_NO_PI;

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20241008-macvtap-b152e5abb457

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


