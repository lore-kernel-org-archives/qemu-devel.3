Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434D1CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWc-00009q-TY; Wed, 06 May 2026 22:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVe-0007UH-6e
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:43 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVc-0000Yv-0Y
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:41 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dea20cf21aso354782a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121038; x=1778725838;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gIyjcjDwEGY+mpVVIiM9bd7yEozKdmCDd7sqT0gqEs=;
 b=DfpKVel8bbaJOBBXWC5qPknw23BI71SN+LIHKXoXhfHqg21PXv1sZTuf5vW719mPz+
 ZkiclCAD3MYFk23+NedJQXtju4+gE0Ki4ylS0V1+32XjeUVDccKkecJwzGypFC0VsprV
 nruqW+vEH9ElDt4y1n88J45a6sMgNE+Ygz7E5iV2/SJFO8OxOwYWNEU3kbRhB7uK61qd
 iKNJkKRZrPokU803+IlqRo9JE7dfbnuDlTbICf+0+X5vtA1443Qr+qi6D2mUFBxyVJ7z
 zOXRdHdBsi7Fdw5CMBaHVuXM/AN4rdRNlnazwvO4LkPmmZdMwPaNAQXRy3VaE9X1/HCF
 9LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121038; x=1778725838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4gIyjcjDwEGY+mpVVIiM9bd7yEozKdmCDd7sqT0gqEs=;
 b=FXWdWWmWwd21Cu7kty4mWHurDNUWxtfRPOxyUKmi7nY/e16GtkUF6wzHda8YHCfspe
 nvzm+Vk/jwvVlg2l0lMxkhqrzym+zVG7rtCbULCmvQ0hf0WHSgp+pk/VtLb39zCyhKMV
 bWr+NlugEXrwmsamWkwIUGCXyzSqysIsljOdB9T7EcS84MNE8sFHk8e56Al0f1wv2qsv
 Tq7uY5kk4bs3IB/hb2hn1S4abMSOQYUfIt4iooFCTxsdRZFsUsDYCMl8/mD6naVVpWGc
 E6SxgIqs/AlEhx8NklFxpf9WHC8OP6BI10AplJtM0wWzD3Lv0N3r20dgfHP0X+QMj9jf
 k2cw==
X-Gm-Message-State: AOJu0Yy7+ZTfYkzbarPe6SJge6rLRferFlnFKQWl+R7ZOmd4zQtj2ikI
 BccWtsUGzucU7562ZOfEWfMVN2GncYWXLAaJ0I2ZhPsS6ozWhP/BqEo79oraG6fgflaX4XBcK5A
 TgegKvOg=
X-Gm-Gg: AeBDies+yJyYU9rDWoMpmvlD2LkI03HKC3GmqsTiRQ25oTOwKa8lpaVpJ9XK++LxUOW
 iscznWqQHrFH1fYuMMmwd9jRGVhjeyTjcmWQK8da7O+awBFgfeu593vOYk6KLNNL9VFxmr1zd9z
 4YyhWDWi+so88CYGx9ledHBlqIS/rHmSse0sW5g9AZXScPreu6dsLAPMgf6Um2dXZXpUdgM9I3L
 oHPkOhoE3e5a7LiEa1rRIlsBgoMhUhDjWnXn/jaulrUTT7c2mweCQMuvoki9SqX8RNkQuqiPOHJ
 BwL+ZOkLXGKL51lysX0rQVffsYvbFo/gQDD/YwPgIVtWlO8zwIRaY1+0qh/PcuonoBFs3+D8MtN
 0MeyNJu11ErXCs9v/opWq/DNnY9AYams9Nn8RlMukygLjl5jZsvHJFNZ2hLu09kab3QYfRSd2jR
 GkpVZYsywQKGMUkb9tG+cZ
X-Received: by 2002:a05:6830:378e:b0:7dc:cbaa:d730 with SMTP id
 46e09a7af769-7e1def3deabmr3727687a34.8.1778121038660; 
 Wed, 06 May 2026 19:30:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 17/25] bsd-user: Add target_sockaddr and safe_ioctl to
 syscall_defs.h
Date: Wed,  6 May 2026 20:28:19 -0600
Message-ID: <20260507022827.44499-18-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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

Add struct target_sockaddr and target_in_addr definitions for socket
address handling and safe_ioctl macro for safe ioctl system calls.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 81f567cb33..0612be8bbb 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -537,6 +537,20 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
+/*
+ * sys/socket.h
+ */
+struct target_sockaddr {
+    uint8_t sa_len;
+    uint8_t sa_family;
+    uint8_t sa_data[14];
+} QEMU_PACKED;
+
+struct target_in_addr {
+    uint32_t s_addr; /* big endian */
+};
+
+#define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
 #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
 
 /* So far all target and host bitmasks are the same */
-- 
2.52.0


