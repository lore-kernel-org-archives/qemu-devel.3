Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44518CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWt-0001Zs-2s; Wed, 06 May 2026 22:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVa-0007Tv-NF
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:42 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVZ-0000Xp-0W
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:38 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dea20cf21aso354757a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121035; x=1778725835;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XaSml2dtAsMaM0n+gsWmiN67y1iciKC5NnWPliXUBY=;
 b=ylF7AvOKNgBqNVvMvh40UdTA/aHTylj3QIFioKLCK4UlxQj8hlbeF0IibqkFJBK4fP
 NYzpHckTHtbe+a5GI/IoqwXuHu797ZJjLxtpdlyo8qsa1GlelNgMXgLciS2qNNrpKgHV
 YxPVTzXjzSQh6ufWB4Xc8MHbIOPcC7smb/B0WK0IDFiwNmPAHVfZmIGQnQ7FqDgH8+kl
 eL/kxnjGwhAieC6OjFT5/8nuG7rFNdTBJCFbwCUhoQLyDBVPhhfeSdIiDs8ODG9jcjSo
 yXL4/6wsDpdqcgbQ+XB+jtv8g+J9a9mipzCar5jS68Cy/qL8TAXN1zlEpBpwQE1BsjNn
 muQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121035; x=1778725835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5XaSml2dtAsMaM0n+gsWmiN67y1iciKC5NnWPliXUBY=;
 b=N0130v7wAeK7jPpB3lTvcS70tk95XTOLRuJ/4ud2dPns0k/QbK61+fPKKfKu93wTcn
 6iTAtcSgZRbW4w95LLhPRkkwMqWh305V0+rKoqLYCSvG4rTNVSrtzqbQXuWgowE1m89U
 ZfUY9N8eOL5qV0PNiFmQoD5+xnqC541a6NlsfJ8zacMaadMA0dqdIzRj5Ku2BeGvGHdJ
 WFfR/O/j7JBULqXu3mEUTmJaXRwo/IuFpIBmLJPLalFIkRhKQdz90pnzLOuhyucBgTAw
 UreD4b6oN46w4IFKeJmom0Gbukc6DsIUqlLHnQ+KfnSYOsVCbN8VgMVdZzz9UOpoS54A
 a0Jg==
X-Gm-Message-State: AOJu0YwYyHXLA0ydP3Aya6RzSw7iBjBV31t0I4vikSgM3vwJ8Qmg9pUQ
 3/8jglOCLc1RftllSBToONbmwGQheYuPMlDvpF5vjNAjaGq6hMpweLA16jDDxMbx2U9+2bO31tp
 T7zYtT8M=
X-Gm-Gg: AeBDievnQkj4dm4hLRQ0Mn8fLCubx6KInljlZab0DFqsAPT6DvA8A4tc8cCScp3f0s3
 4vow7nWvwQ25qYy1Fipr5es8eqyCeFknmlhhno4f1tMpdsScmttBSNlXyLGH23akMpz6/JlB8pe
 ieWTUX7iXIeJPye9hHYAL86CiQ7b0Szb/iXnnaR5ErxEICLOi5lW3sxJggJAiXMDd8RZEXjzXg7
 dkOQD8aLY+vzciCbFKLdyJGyvr3FCFtLHJUnIbjQTBr1MNQvvVDLPxDEgS9vrihhwyvecZEAqyB
 cHJ9ir7B/BXcYhldpjjK6M7WlGtt1GiSW6dJcSJv3jOKJJojsTmNwQT3bh6USZ8bsnBN4TV+N6i
 tkUwdpsbM3luQ+IhBtbO7f6gFiTY/A7QfViwpJVOJpJd77vp9SzjqcNIVLuswGDHn5VCeDZwK4l
 3LrRKGhkWLZ3oagZcSVblCdv2shuhcsKw=
X-Received: by 2002:a05:6830:608c:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7e1df0d2a5cmr3641414a34.14.1778121034935; 
 Wed, 06 May 2026 19:30:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 14/25] bsd-user: Add FreeBSD ioctl type definitions
Date: Wed,  6 May 2026 20:28:16 -0600
Message-ID: <20260507022827.44499-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add os-ioctl-types.h with STRUCT macro definitions for ioctl type
registration. This header uses multiple inclusion with different
STRUCT macro definitions to generate both enums and type definitions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-types.h | 109 ++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-types.h

diff --git a/bsd-user/freebsd/os-ioctl-types.h b/bsd-user/freebsd/os-ioctl-types.h
new file mode 100644
index 0000000000..496d1e991b
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-types.h
@@ -0,0 +1,109 @@
+/*
+ * FreeBSD file related system call shims and definitions
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+STRUCT_SPECIAL(termios)
+
+STRUCT(winsize,
+    TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT)
+
+STRUCT(fiodgname_arg,
+    TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifconf,
+    TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(sockaddr,
+    TYPE_SHORT, MK_ARRAY(TYPE_CHAR, 14))
+
+STRUCT(_ifreq_buffer,
+    TYPE_PTRVOID, TYPE_PTRVOID)
+
+STRUCT(ifreq_char,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_CHAR)
+
+STRUCT(ifreq_short,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_ARRAY(TYPE_SHORT, 2))
+
+STRUCT(ifreq_int,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT)
+
+STRUCT(ifreq_ptr,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_PTRVOID)
+
+STRUCT(ifreq_cap,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_ARRAY(TYPE_INT, 2))
+
+STRUCT(ifreq_sockaddr,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_STRUCT(STRUCT_sockaddr))
+
+STRUCT(ifreq_buf,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_STRUCT(STRUCT__ifreq_buffer))
+
+STRUCT(ifdrv,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_PTRVOID, TYPE_PTRVOID,
+    TYPE_PTRVOID)
+
+STRUCT(ifgroupreq_ptr,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifmediareq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_INT, TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifstat,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ),
+    MK_ARRAY(TYPE_CHAR, TARGET_IFSTATMAX + 1))
+
+STRUCT(ieee80211req,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_SHORT, TYPE_SHORT, TYPE_SHORT,
+    TYPE_PTRVOID)
+
+STRUCT(lagg_reqport_lacp_opreq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ),
+    TYPE_INT, TYPE_INT,
+    /* struct lacp_opreq */
+    TYPE_SHORT, MK_ARRAY(TYPE_CHAR, ETHER_ADDR_LEN), TYPE_SHORT, TYPE_SHORT,
+    TYPE_SHORT, TYPE_CHAR, TYPE_SHORT, MK_ARRAY(TYPE_CHAR, ETHER_ADDR_LEN),
+    TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_CHAR)
+
+STRUCT(lagg_reqall_lacp_opreq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT, TYPE_PTRVOID, TYPE_PTRVOID,
+    TYPE_INT,
+    /* struct lacp_opreq */
+    TYPE_SHORT, MK_ARRAY(TYPE_CHAR, ETHER_ADDR_LEN), TYPE_SHORT, TYPE_SHORT,
+    TYPE_SHORT, TYPE_CHAR, TYPE_SHORT, MK_ARRAY(TYPE_CHAR, ETHER_ADDR_LEN),
+    TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_CHAR)
+
+STRUCT(lagg_reqflags,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT)
+
+STRUCT(lagg_reqopts,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_INT, TYPE_INT, TYPE_INT)
+
+STRUCT(in6_ifreq_int,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT)
+
+STRUCT(in6_ifreq_ptr,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_PTRVOID)
+
+STRUCT(in6_ifreq_sockaddr_in6,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ),
+    /* struct sockaddr_in6 */
+    TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_INT, MK_ARRAY(TYPE_CHAR, 16),
+    TYPE_INT)
+
+STRUCT(in6_ndireq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ),
+    /* struct nd_ifinfo */
+    TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_CHAR, TYPE_CHAR, MK_ARRAY(TYPE_CHAR, 8), MK_ARRAY(TYPE_CHAR, 8),
+    MK_ARRAY(TYPE_CHAR, 8))
+
+STRUCT(in6_ndifreq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_PTRVOID)
-- 
2.52.0


