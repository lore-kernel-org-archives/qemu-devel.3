Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E76CD3444
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWK-0007vF-Uh; Wed, 06 May 2026 22:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVZ-0007Tp-Fr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:42 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVV-0000Wt-Gh
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:37 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de7dc85b74so331680a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121032; x=1778725832;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yMf4lyjKsv7lWurkUiyx9lzTlfXrhvijIaiDc6Lwn0=;
 b=EAGsDBezp0qaC7VWjl5+z93anpnht8Gt1xyc0slpSFfvuq/2nWUo2Sbz0uJTE/gKN8
 TX3bLcIX25P5kg8L+OKtB9UpcN5GlNe5xXT7heHlU8Io0tA67S6n1/n6pVzkIr3m+Cxs
 iHzw14xbfgklM9jEHdLCXjGtHitwllgkMpW3MdYWioi4CXJ0VB8qp+jOwoNIk6+xCzjm
 FT8fOJ23XJMwK1qy8LJQxxz2dTS/R91X6uu74PRHQUX7496PxjRkc4RkUAaL9e1rVK5i
 VQQ85+zl9UTQsHYmfRlcHEVqdTpGHnkdrmxUvgYcTLn+oLfg/6NVbnDpwuzzPz24SAjC
 bBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121032; x=1778725832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9yMf4lyjKsv7lWurkUiyx9lzTlfXrhvijIaiDc6Lwn0=;
 b=tMv9K7X75bqWJ4xY+vwTDr1Dd7QFqcq7rhAy63a7s4trPh/6jk/c2zFsZDKwPDD6Nc
 MTRV+4iCBC5xn/Uo5qfZ4QcAiXkBeVfb1LTxzr3pq+UjLEHdGXbC7RyZIGWC662wIPqG
 6KeFYJSM/iJa5W8Cm+k0KqMorF2nGbXIUKSnhcXj5BTyVyuFrEcS2BiaNnvHTYfDSIqo
 +APVuOGwtNxqbYX7MDbrS+Bj+mKYSuOXjic8xT1IBjd+0Z3bYSGtG8m8zYTYItJ6D0a8
 8BusL/16NWVWxOCA3vdMkTXwhfQizwPnAAD/X8Ezawz++n77ncieCTwz3478WmetePjz
 0tPQ==
X-Gm-Message-State: AOJu0YwIVvdjyYEUc3pwjVad8kzZ2gxko2g6REiV/GmF60ecPvvg0S0B
 GGqL8uQ3/xMcDD1egjIjlXEv6kPkE6+5AITLffglxy4dzZs7biHDB0vsRKWDq0MbuomST/WkQCv
 BbbZkR0k=
X-Gm-Gg: AeBDievJ87AsGGR2njPrtQGjl4zham6uTq7kqRYG097ZXFtA2UN9DO6+v5Yz+U1Xr/l
 AxVQ5Gweze+DcdFJUQ+TBHnHBg6FWT6Dojjcbm/3FMHA5VDZbfVYCIteEXn3W4oGqFoh3UdXsmT
 3aWy+CtkWv2EfaujTdcTNHAyYPGYx8r1YuM2y2/ARDF3bmNyAZdqrFo9LW6cYHyFfTzU78RUnFc
 lLqUSCe+pY4p5hdpAU50l0I45hl65YNF1j+SdZ4BKeXWj16zm9SM02zRyu8Jd9e9VfLF05WEi2J
 MDnKH4MY9nA7lGqTxdkbdXPzc1+gY9/EooG1Rx50abgfZBlwAL6YfZoqszbD+1dcE37gbRSKPVD
 4BUNP2X+Ye7KlmJhxKb4bnUyBNZYmQmMCnRQ5MAsgGrPq/bG5jGwfS9pr1/KImz8OHH1wdQKfgT
 rGIsZ+QAcb9X8CSK+3a7HZ
X-Received: by 2002:a05:6830:390b:b0:7dc:d0cc:91b with SMTP id
 46e09a7af769-7e1df1cdc20mr3710614a34.26.1778121032090; 
 Wed, 06 May 2026 19:30:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 11/25] bsd-user: Add FreeBSD cryptodev ioctl definitions
Date: Wed,  6 May 2026 20:28:13 -0600
Message-ID: <20260507022827.44499-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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


