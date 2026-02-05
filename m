Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32F1ECD994
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38I-0004Yi-Gg; Thu, 05 Feb 2026 12:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38D-0004VH-OT
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:05 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38C-0001ST-21
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:05 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45f09874c4cso809380b6e.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312423; x=1770917223;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sGGsAFCM+5iKqyCwwz5fJSuB+8WqYSxP7Fxa60ztpoU=;
 b=f9TcV3zcj15GKF9fImyp0tEdwsdDajNpOw5Ipd/ueoLGlS1LY/YllioYnmA+ShNMKK
 wRg0cD3DQkrAi8yJ8B8A0cCRPRcLzf4GMZ+REprlCyBS+bLvM2CiHYQaABmZczj6ofRX
 xSS/Z8PofgszwPpc0TtOfDayAobnquo79jJ5iAAcF63C9Y9gpPxP/k6gLGil8dgvNYhH
 2bjQ6+PwT7VDcfUohQqfS528joO5OylfD1PzYd4+LmIIxzdxFJHdIHfvyXTJXKK6TIMH
 ET2DepYT+Yi9kTn0usIem4IQJ9wdeYxpOKrB2jKxx+Ipl3iVE06EiCgOUWMqK2XrNUIr
 XYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312423; x=1770917223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sGGsAFCM+5iKqyCwwz5fJSuB+8WqYSxP7Fxa60ztpoU=;
 b=ZW7OvNNTXH1z15CxPUIcH0gS9/j3ArYGxI+lFJbzUQycHYKDRFYUhM35mOJsqCQObh
 b1Zj86O3rs3ijRNGuLQ4qplciDC+A6Rv74HxtJyNl1a7EIznntlx3Xj4ssXDjpmNhrj0
 hZ9x5ucwnvqpGiRIAjRlTPGdsh67ol8m0ssbb/bw8Qp3BYahny4j/9qIip0XFvXiwg9S
 KZEiljtlZsUOHjd0iMlG5fXXped/RlmHVHqJee9/rUDU9Sj4PZeofB5YInabP5+mGxE4
 StIPSr1kANFVHRuS3M3hXLzpSH3RqaDcpehr5KQmMpe6q7CEixJ0xaNSf5/DUg1WahPD
 nuiw==
X-Gm-Message-State: AOJu0Yx3FTNg4Sd/nLgkeYm/ITYRsjCRGfKHFVtiMn4s04+NvMjSLON0
 /9JMW2GvqtxfBN6g9KdMitgIgv7OfLyAVHYEeDn10eKExo5n6nGvL9ZaNVJydO7NdJc=
X-Gm-Gg: AZuq6aLBOk3mt8ITbUHIsA56E3LEqZ55FdLQgAHJYA0aJBbkKCJ/5ZVX8I2gThkRJH2
 GXL26EqUD8+zhxF4RpeUtICzNG/O30IyD+M+yFxCZO0D58A3Aak975BDaN6mKPM91UdlKDkodAd
 mxwzAnh9vfy7P+DiGhZ+IWv9wGSFSi/1bBU4ntME7uV03pKSH/9XLY7l3kGEvgb7BqEQQTR2hKF
 /2v1waVRk5RUJwkcQj0WPMaToQ4bNJydX5UL6PZK7nNRLnmzZ+SN7arLx9n2D3iO61RSLHXfIwq
 jsB9V0RqOBIHngVAovm589KJot7FZrl51BKNWnpSQzvrrEzwzFQeOXchAuPpTQbnOTjZ2OQGCdy
 chafiR5Ul4ASifDqOdFTSNq4DwbckmHIMSTRl+wfqkeCFgsDnIdLnAbEhaeTH/LM3BeGEhcNPWQ
 WJDcJsFdZY
X-Received: by 2002:a05:6808:6901:b0:45e:f88b:1e47 with SMTP id
 5614622812f47-462fcb642afmr3461b6e.61.1770312422945; 
 Thu, 05 Feb 2026 09:27:02 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:27:02 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:53 -0700
Subject: [PATCH 20/24] bsd-user: Add message queue implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-20-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3541; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=nKXAa3T6zR4KAOQoocdZ+gW738kupf2pGtZbZmUp+zA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLbHX7n2j4sNO1HoAgiaVQm+IU42z1o6Yog2
 oTzurjGlGGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 AEakEACpxCF4V4rybn3HhlI1QuUzfjidxKtswVKNYhs7COkAe9KT6eoxYgLgZEO9Ex1IDULSnDw
 gNI+Nw/SpPsD41R+39Go6CitXtIV99eyWGBOdHa9TJau5M5hRSmZ6L/CWufD+ZSGaL94tgFkuRO
 kMZlb4ze6+cebacboE11/SPINZgXeosauh6hq9wpzDeV0xY3Y97PuXC0uGf4UdGsgXYAT/NCuO7
 JC51+jVZMUy75R2xzBjaXjfmlVfYBroFwf4AXJMJMM7mqt3f0zxNsPW32f4qk0V8HreH+pCAyLs
 Jts12pCzD5D3/yw5DCyT5P909pHOMP/efWUcfjMC1BEuR03UPdMOfNnYIMcvK98AcUwAWxLsaz/
 6+hDyBAi6sOzBRRsmgWZaWPvu+5abshPBbdB2ONkJdMl11YbE92k99bwX6J8ZHBp7yPl4Y1s1mY
 7yYqk6GgbBXQyxRtRJ+UDDWspdgmxJ9ZrTHUOdHKR3s2n8t/XqqXrwQwsz334Mn8K+K+RX7ifJY
 fCRqojKp9mPaJjMBVnJTRiN3c7NTR8l3DE1q/A0Mhi82n+A/FUhaBxtnB9y8USdw4gmWrMX9SHj
 eIkR7yk5oaGTZHEf3ibI6WJ558l2MrGpMuFtABGSGdD+bfmTMpBS6p+I2AjnPBEe6aFqjUATfcu
 Fx5X1su11aR6uOQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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

Add implementations for:
- msgsnd(2): Send message to queue with size validation
- msgget(2): Get message queue identifier
- msgrcv(2): Receive message from queue with size validation

Includes bsd_validate_msgsz() helper that caches kern.ipc.msgmax to
validates message sizes.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 27f4497d76..0025c97f78 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -281,6 +281,101 @@ static inline abi_long do_bsd_msgctl(int msgid, int target_cmd, abi_long ptr)
     return ret;
 }
 
+struct kern_mymsg {
+    long mtype;
+    char mtext[1];
+};
+
+static inline abi_long bsd_validate_msgsz(abi_ulong msgsz)
+{
+    /* Fetch msgmax the first time we need it. */
+    if (bsd_msgmax == 0) {
+        size_t len = sizeof(bsd_msgmax);
+
+        if (sysctlbyname("kern.ipc.msgmax", &bsd_msgmax, &len, NULL, 0) == -1) {
+            return -TARGET_EINVAL;
+        }
+    }
+
+    if (msgsz > bsd_msgmax) {
+        return -TARGET_EINVAL;
+    }
+    return 0;
+}
+
+/* msgsnd(2) */
+static inline abi_long do_bsd_msgsnd(int msqid, abi_long msgp,
+        abi_ulong msgsz, int msgflg)
+{
+    struct target_msgbuf *target_mb;
+    struct kern_mymsg *host_mb;
+    abi_long ret;
+
+    ret = bsd_validate_msgsz(msgsz);
+    if (is_error(ret)) {
+        return ret;
+    }
+    if (!lock_user_struct(VERIFY_READ, target_mb, msgp, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_mb = g_malloc(msgsz + sizeof(long));
+    host_mb->mtype = (abi_long) tswapal(target_mb->mtype);
+    memcpy(host_mb->mtext, target_mb->mtext, msgsz);
+    ret = get_errno(msgsnd(msqid, host_mb, msgsz, msgflg));
+    g_free(host_mb);
+    unlock_user_struct(target_mb, msgp, 0);
+
+    return ret;
+}
+
+/* msgget(2) */
+static inline abi_long do_bsd_msgget(abi_long key, abi_long msgflag)
+{
+    abi_long ret;
+
+    ret = get_errno(msgget(key, msgflag));
+    return ret;
+}
+
+/* msgrcv(2) */
+static inline abi_long do_bsd_msgrcv(int msqid, abi_long msgp,
+        abi_ulong msgsz, abi_long msgtyp, int msgflg)
+{
+    struct target_msgbuf *target_mb = NULL;
+    char *target_mtext;
+    struct kern_mymsg *host_mb;
+    abi_long ret = 0;
+
+    ret = bsd_validate_msgsz(msgsz);
+    if (is_error(ret)) {
+        return ret;
+    }
+    if (!lock_user_struct(VERIFY_WRITE, target_mb, msgp, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_mb = g_malloc(msgsz + sizeof(long));
+    ret = get_errno(msgrcv(msqid, host_mb, msgsz, tswapal(msgtyp), msgflg));
+    if (ret > 0) {
+        abi_ulong target_mtext_addr = msgp + sizeof(abi_ulong);
+        target_mtext = lock_user(VERIFY_WRITE, target_mtext_addr, ret, 0);
+        if (target_mtext == NULL) {
+            ret = -TARGET_EFAULT;
+            goto end;
+        }
+        memcpy(target_mb->mtext, host_mb->mtext, ret);
+        unlock_user(target_mtext, target_mtext_addr, ret);
+    }
+    if (!is_error(ret)) {
+        target_mb->mtype = tswapal(host_mb->mtype);
+    }
+end:
+    if (target_mb != NULL) {
+        unlock_user_struct(target_mb, msgp, 1);
+    }
+    g_free(host_mb);
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


