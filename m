Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A99CD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsL-0007ql-F5; Sat, 02 May 2026 13:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsG-0007pJ-Sv
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:29 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsF-00076F-25
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:28 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so1641379a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741885; x=1778346685;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qVHsZe4ngIvpRdqqCMu6dp3o/tPpN9CND5GXRK01V14=;
 b=uA8BFy2Xx3npzkSMcnygYo7FHZaFxG1Ur/ZmhMAMR+Ll00PggK4d+qlSoXDIz29U8L
 sKhGYfy+3gSkMT+ZRmUV1XOJqLvsWY9kDC4dbMFzWK9nH6zYdMtu+kWlCopVOgJtcqIE
 OYEWIMAdRttVA4NHCTINt8Oc/UBePa3kpedBzEMmJcURzLM6QbMJefUKAIUZioDZWc8w
 y1kYR1yFvAuO9MItE0sxsJ7gdQxbRlOkfFTHDZw7j/vocrZuWmuo8MgQvKGejrf5io+a
 1n/aDX1pJfy27+iPX7m+74o8LGuvheak1tgA3FWSPgR5SVQf/C+OKqeQGtnhaurgwcoD
 uHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741885; x=1778346685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qVHsZe4ngIvpRdqqCMu6dp3o/tPpN9CND5GXRK01V14=;
 b=DHskXriBost35bZTM0Ktx+hOPQynvTGy7k+iDTosa3f990rSf5IOGPnnILoMoF14Vc
 DYaBz4eP0ZMwf1ubRr3kgwv8mZnZzS0IwWh6PRpF4qhlqFDqDecJom2rnmE3uqRC/T+X
 RXARfkKoVc/ni03vy493YlFZT1bw/B+0I5vuuoqraP4THdprDkr5V2TNTyTaYwqOrY0y
 Joh9HEuwccZGTO7ws2GJYge12MemGG7c5r72ZmTsFkSRvfiZ1JeSUP2WGVt+ZlguKbI3
 9x6nOHqxHqrRcAhZCfcYKESUxIf9ig1lH9worzEffyA15o0oPFF20H3rs8ECUirUAXOK
 k5GQ==
X-Gm-Message-State: AOJu0Yx2iwQmkMrW8i5mTUW5YPdYwhbMp9XDvzkGTPsoVyxaPJdPI26a
 Z8TEmcDuUbtji/1RP2GnPd4GukWIA0/6IW2JIRd9Jas8FbQWKUqtHmN5vIgLEqdUQlFA8YaYZOl
 Lkc6ImPQ=
X-Gm-Gg: AeBDievjW/k8rPaqxKac1hX4W+4/JyZyVEdrGNSbNzFqOAWYBHbmvz+2lZ18qVu6rPC
 gnHFhhrBoRHUbrQj3+PiRgOQP8V6t7XqwMnfVbz2bE6xsf9+Xaa/S8WwuEmxlWeEooS2dzW74xg
 mfEYw3LphXh+/icnLR6ICbi/98gUvgp+6udBJR8DdZUz4g1dsNFaY0qtUmon778/VqVCauJEQhE
 lZf+1eXeHALxmvVN5DvJOx5o8mULZ5mTVI02g2gQX6wrmPdYPdrgc/5D0U1GYe4Dn5ocZ7og7lA
 Y/KALeosgxxjnIfLnmsUXSKTKvhcweW2DguEMldo8ELSLsbBGiv9jw5FYSYIy5XXOzdVkCJ94wu
 PnoJ3TuTNx1dhJnLCFHFy+jY9vnT+uHI5IIMb19G3wK1WR1slIZmWd53LCbVxBzNvfYve8WlcI3
 iDsjDoM0Ue2gPLk52trI/3
X-Received: by 2002:a05:6830:4112:b0:7db:d229:d51e with SMTP id
 46e09a7af769-7dee12923b3mr2722724a34.12.1777741885285; 
 Sat, 02 May 2026 10:11:25 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:29 -0600
Subject: [PATCH v3 08/19] bsd-user: Add FreeBSD ioctl type definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-8-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4137; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=VQctPPUZ1MsmJDflBe2adcPZTQvBBMJqH9UJpN4JatI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/QexDfjd7McfZ+dU4fl7Tx4Sa7kLm8E8n3U
 6Ql1ndwQS2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0AAKCRBsHNEofbAR
 AMRxD/41bxcYpvXeEx/Y6oRC65wEhk3ebD9CaFakS6muHZDJ4w+hTFhozzVu9udS/NLJjdehDUZ
 rhooBIeTI3o0pgZO8vy3QADUO2HCjLCnN9D0fcTm/0dcqS2rkv4BvL9lDLuhDMgDiixPN11xt18
 pM8jOZojfjZrDIyU2Ru95DsxDmM6PT6IpX4jgSfTYdNiIWwmCLSq1ewpr+uqqiN+wcxcnl5uSfR
 3B7DWUIRsndtjWcuFvbJvRqhbWv1mXi0bk4RVD29VaaZKChT//wObE/MCp1mRISk3+jImXbp1Sn
 Cy2/eIuoOJjGkJYgAZt07LXMA/LZjfUNFYQjkGUowweqPGDfsh7UCyIbAGzNXDsPwU8dqOHE9RE
 /1jzE9HSlzeJKrrS3tZOHLn5Ntcn0ARHEZ8ULXPhNv+/yQs1ZLlGpg+qgoPxtXsBBr5jJ1MN9dT
 itgNaqEq5ghwrKQe/Qpkab6XHa7Rv6gf/+hi7WHC1PBJ34RAKsd5iSTV9qKTBEZXAD2RIeZjlty
 uXUkIKN8KZ5xoT4iwBSpwAGHn7PK7z0SpElo6bDoqv9X7/h0ApYhpYzc1i0kFloBQQqOLCBUY0i
 JxNcpEzZ8WW4JftySgBeoNISrt/zpMpB/Gb0yi+qJhL6UdJ3AurjOz1qEiW+iOrbm45NicesNRK
 vIe4OwIvQFjix4Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add os-ioctl-types.h with STRUCT macro definitions for ioctl type
registration. This header uses multiple inclusion with different
STRUCT macro definitions to generate both enums and type definitions.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-types.h | 109 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

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


