Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6DBCD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoQ8-0007H6-JH; Wed, 06 May 2026 22:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPy-0006tg-C1
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:50 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPw-0007ha-Sa
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:50 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-42fdab683a9so203515fac.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120687; x=1778725487;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ry/+AD30vqQ1SM10FWDtz2pfyCCIJfoXwGJ8k1dXU+Q=;
 b=nrFUFIJ3vp9AIoDVbStv/5bWmHAHbfpH35TGdqOFuElOwFyR5JHFMaY/6TPojcP1gD
 lAGNsObrIvV7sGs2ikQxZcv3bRxs6S1GBroCXNdG5nNrXxFVPfeIx7GimyFxp2NPvsUa
 bQOXv115uUUBtCanhnhPiqXOCOuOIaYXr4HQho5ShanIPYWgeQNWhQEAGzeidXrh8m29
 c6ND6LLWtL9RDVbQAh/Czx2Q6VRgC0LzCqpLgXT8ip+kbKEj0ZQ9l7GHzRR0E4pu1wXV
 R1LRZXOIIGfudnwVdb3FoHjxrs3kcILLF307fyxvVgr0kohWdL4bHHqiYxCAqIWffSgF
 2yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120687; x=1778725487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ry/+AD30vqQ1SM10FWDtz2pfyCCIJfoXwGJ8k1dXU+Q=;
 b=n99nD7hJwRGDOtwdXuqohHyeOf6OdsbmvJfPmk6IZrrTwt7sQRuM74yO2TGKLWhZ4j
 YOF/ZXZ9q6sXoePIc2yjWSXVvBamdvRGbfHrbOm29DOdZWx5/SsyVotxB4g09w5vPkyH
 oa1xRZcDpLN5qwp/dhIRK1N75J71CQnyt5K1cGv6QrptWNze9Y0EiV3V+Z11nzXSYDDT
 87MHzyphpCMCabejnmutwF/CULubT5EvPIe7EbbuilmD4xvtU6MABb5tS0fFFE5WPTTn
 L0vpRTU5l1zE656pwUJ8EqKqWRMXxyzN3wGnaJe0ff3KHoamTIcS40wpiHz387S26l0I
 1I7g==
X-Gm-Message-State: AOJu0YzW4UNLsOn3qCzZhDHciyMxxizqhkp8+FqFQ0VnEhaiSlN98SNc
 NQ8yav3UqidTkILFcDCeg5dpn2nvFiR3sLadLgOTNeoDwr2W/BAM66ebdCFR+1YLoTbmxhXIdep
 p58+8n5U=
X-Gm-Gg: AeBDieuJOWt3njaVaSW5JQTxw9Wz0moeA4lTFnhx9Rj5Vd0UdQIsjB+km/15HiK97L6
 lScG4jXQLgMjuKUyzYlNrbjxXJdwEn/WYSngdP5//y9P8Tt8QeFccS+82lUcc92wWOdwBeHDe6j
 ij99px3Trftq34FaryssT9X7PeoM5cTgPen1Nfk78n7v5GNSLB/x7xxht7ixvzqIAFDCsO0rLc7
 1oV4NxGebqjULW2oY+067UdozqwQmsPM1Aqb69yjvAUt0Fs/j/tzpcf1LlAtQf34qwrZQ5PsCVv
 Z5L5jST1V2gsieZ9psPiAagUs9nHmrGvjMUx9PvssRXSdnQ8SwxRCF4Dc2AhYZmj8FCHlrP/lTj
 YMarnJ4rXCHCzG8XjQdLzJfzhWjJJQ3l7D9L0Qdn6ZuM7ty6Sxc1jd3G+LjD+wexWPrTGE0JuX+
 nhm7Rl4hva8T94XwHhkgJY
X-Received: by 2002:a05:6820:f010:b0:696:8ccc:55a0 with SMTP id
 006d021491bc7-69998d22f89mr3388223eaf.42.1778120687342; 
 Wed, 06 May 2026 19:24:47 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 23/25] bsd-user: Add do_bsd_ioctl main function
Date: Wed,  6 May 2026 20:22:17 -0600
Message-ID: <20260507022219.44171-24-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::34;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x34.google.com
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

Add main ioctl emulation dispatcher that handles table-driven
ioctl translation with thunk-based structure conversion. Supports
TYPE_NULL, TYPE_INT, and TYPE_PTR argument types with read, write,
and read-write access modes.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 100 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 8d25d84dbe..3940a69260 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -292,3 +292,103 @@ static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
 
     return ret;
 }
+
+abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg)
+{
+    const IOCTLEntry *ie;
+    const argtype *arg_type;
+    abi_long ret;
+    uint8_t buf_temp[MAX_STRUCT_SIZE];
+    int target_size;
+    void *argptr;
+
+    ie = ioctl_entries;
+    for (;;) {
+        if (ie->target_cmd == 0) {
+            gemu_log("QEMU unsupported ioctl: ");
+            log_unsupported_ioctl(cmd);
+            return -TARGET_ENOSYS;
+        }
+        if (ie->target_cmd == cmd) {
+            break;
+        }
+        ie++;
+    }
+    arg_type = ie->arg_type;
+#if defined(DEBUG)
+    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
+#endif
+    if (ie->do_ioctl) {
+        return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
+    }
+
+    switch (arg_type[0]) {
+    case TYPE_NULL:
+        /* no argument */
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd));
+        break;
+
+    case TYPE_PTRVOID:
+    case TYPE_INT:
+        /* int argument */
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
+        break;
+
+    case TYPE_PTR:
+        arg_type++;
+        target_size = thunk_type_size(arg_type, 0);
+        switch (ie->access) {
+        case IOC_R:
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, arg,
+                    target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type,
+                    THUNK_TARGET);
+                unlock_user(argptr, arg, target_size);
+            }
+            break;
+
+        case IOC_W:
+            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, arg, 0);
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            break;
+
+        case IOC_RW:
+            /* fallthrough */
+        default:
+            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, arg, 0);
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, arg, target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
+                unlock_user(argptr, arg, target_size);
+            }
+            break;
+        }
+        break;
+
+    default:
+        gemu_log("QEMU unknown ioctl: type=%d ", arg_type[0]);
+        log_unsupported_ioctl(cmd);
+        ret = -TARGET_ENOSYS;
+        break;
+    }
+    return ret;
+}
-- 
2.52.0


