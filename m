Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FBECD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPj-0006EZ-8e; Wed, 06 May 2026 22:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPh-0006Dv-Dy
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:33 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPf-0007dj-PC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:33 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7dc85b74so328799a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120670; x=1778725470;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yMf4lyjKsv7lWurkUiyx9lzTlfXrhvijIaiDc6Lwn0=;
 b=WVUMuXbF29pyLi44GBvZXA6zKfxkqFGE+AqusvRG8IeufqBR1XIqssV7kJYzoWOXhW
 /upxBCJHkG5MTwAwMnstCcbgRV67z/GJOXZfNXHPw9apGN4wQb1i3A2wD1IpQH+QYT0y
 954Y2zgiKl4zvEKCmwbM8FrmBT512tMCP9gUG9bRVq3YXeRw52kpl9PGeats78lGAQ/E
 12M/wj7Ir3wZxUHUnqMrtB5Rks3AUpkiarZkxZH+HfukinsFbuG21/xzS5aMvLY4aF1l
 B2OMoS/BcmnKm6M3W7SEmd6yoghastuh0tUgOHEdzybeqTys51XQYqseo2WPidAoD4jz
 jQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120670; x=1778725470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9yMf4lyjKsv7lWurkUiyx9lzTlfXrhvijIaiDc6Lwn0=;
 b=AkRWltCA/KNVt1/J1wt5la25CiBGhMVoWoC5IYY47ixfavj1hDqWSfk+8UnmsRofG+
 tRgEpzbQivnXX59A37BRocf548UT8Wz1N1BhhQqw+m6oowJgdqWAi+2KFxFUGLZcs2SH
 SgC7+t+sKzX18/JZiDxpSC8ir/x1yHUn742m4o6RrxD9yxRh67+EYZZaEabQHh7/RHdB
 5RO68QRt48BiMNM4XXMEiq31vgJC3rSj/fRsPosIdIelfdp3fXpDYno6WFSnctGAF9K2
 1DWe59tRJSuLuppgf7f/uxGPYifY91F22TFdGgXg8M+YubsowuHuSDKPdDbRDThYqj/N
 37gQ==
X-Gm-Message-State: AOJu0Yy4Ka4qSTVLQ+BUMpFISEhbdoGXxKyiupRXFGaXjV+QzvkD5NTI
 jWvAR1pFLGXTDlc3T5xFisKb7ZK1aWZAk7vuisEvGji9hrUC4QIo41DFVBxo7M8BRjypJ8fr+/+
 paVJlgcU=
X-Gm-Gg: AeBDievH7DbNlGxb2Vc4riEh0kNFEBwGIlRutjceaHVjz0r7HGcdteaPYy4VWJwuIST
 MLoOMM8eWHs9HxM0j+K69MY3L4ufwEPg2s4Ec4rOLei6WIkM3ix9foFaGST+hcy8rfb2Z7Aivul
 hIcqQ8hQZHOh6JxKwjcpybZtW6NVggWy7/CVWb6Iwrig8dl0uc66ivdJo30qdEYEpoGXkpxD1pP
 l4sDq4mL6jvV+YbQrulMqDS4u92hp1o3zyUiWdkcfTyOD2m6SUktdWLMu65yYDuIkxnxT6/xLHG
 1OJ40T53MxG5SjLArWbKwyuX5UZCcNQ/aW/vO26donPi5jBITCh7tjhvTbQC6s7AuAAfKggfdAv
 N1w84g2hM1FA7onrTWQNGEseYR1geuhGx8hZ5LLdMgwbDO0yknUvn2mcR44PLWVpgcpnAiMAZJ7
 gkazeLwG6OMolkXazr2Z8W
X-Received: by 2002:a05:6820:3092:b0:694:8e28:fd87 with SMTP id
 006d021491bc7-69998c83794mr3053436eaf.8.1778120670375; 
 Wed, 06 May 2026 19:24:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 11/25] bsd-user: Add FreeBSD cryptodev ioctl definitions
Date: Wed,  6 May 2026 20:22:05 -0600
Message-ID: <20260507022219.44171-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32c.google.com
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

Add os-ioctl-cryptodev.h with /dev/crypto ioctl definitions including
CIOCGSESSION, CIOCCRYPT, and related cryptographic device control
ioctls.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-cryptodev.h | 84 +++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-cryptodev.h

diff --git a/bsd-user/freebsd/os-ioctl-cryptodev.h b/bsd-user/freebsd/os-ioctl-cryptodev.h
new file mode 100644
index 0000000000..b81112150f
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-cryptodev.h
@@ -0,0 +1,84 @@
+/*
+ * FreeBSD cryptodev definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H
+#define BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H
+
+/* see opencrypto/cryptodev.h */
+
+struct target_session_op {
+    u_int32_t       cipher;
+    u_int32_t       mac;
+
+    u_int32_t       keylen;
+    abi_ulong       key;
+    int32_t         mackeylen;
+    abi_ulong       mackey;
+
+     u_int32_t       ses;
+};
+
+
+struct target_session2_op {
+    u_int32_t       cipher;
+    u_int32_t       mac;
+
+    u_int32_t       keylen;
+    abi_ulong       key;
+    int32_t         mackeylen;
+    abi_ulong       mackey;
+
+    u_int32_t       ses;
+    int32_t         crid;
+    abi_int         ivlen;
+    abi_int         maclen;
+    abi_int         pad[2];
+};
+
+struct target_crypt_op {
+    uint32_t        ses;
+    uint16_t        op;             /* i.e. COP_ENCRYPT */
+#define TARGET_COP_ENCRYPT     1
+#define TARGET_COP_DECRYPT     2
+    uint16_t        flags;
+#define TARGET_COP_F_CIPHER_FIRST      0x0001  /* Cipher before MAC. */
+#define TARGET_COP_F_BATCH             0x0008  /* Batch op if possible */
+    abi_uint        len;
+    abi_ulong       src;            /* become iov[] inside kernel */
+    abi_ulong       dst;
+    abi_ulong       mac;            /* must be big enough for chosen MAC */
+    abi_ulong       iv;
+};
+
+/* op and flags the same as crypt_op */
+struct target_crypt_aead {
+    uint32_t        ses;
+    uint16_t        op;             /* i.e. COP_ENCRYPT */
+    uint16_t        flags;
+    abi_uint        len;
+    abi_uint        aadlen;
+    abi_uint        ivlen;
+    abi_ulong       src;           /* become iov[] inside kernel */
+    abi_ulong       dst;
+    abi_ulong       aad;           /* additional authenticated data */
+    abi_ulong       tag;           /* must fit for chosen TAG length */
+    abi_ulong       iv;
+};
+
+struct target_crypt_find_op {
+    abi_int         crid;
+    char            name[32];
+};
+
+#define TARGET_CIOCGSESSION     TARGET_IOWR('c', 101, struct target_session_op)
+#define TARGET_CIOCFSESSION     TARGET_IOW('c', 102, u_int32_t)
+#define TARGET_CIOCCRYPT        TARGET_IOWR('c', 103, struct target_crypt_op)
+#define TARGET_CIOCGSESSION2    TARGET_IOWR('c', 106, struct target_session2_op)
+#define TARGET_CIOCFINDDEV      TARGET_IOWR('c', 108, struct target_crypt_find_op)
+#define TARGET_CIOCCRYPTAEAD    TARGET_IOWR('c', 109, struct target_crypt_aead)
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_CRYPTODEV_H */
-- 
2.52.0


