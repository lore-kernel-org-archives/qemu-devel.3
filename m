Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7F9FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6CI-0005ET-D0; Wed, 29 Apr 2026 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C5-0004ml-IV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:21 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C4-0004fP-5x
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:17 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so8757539a34.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474034; x=1778078834;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=umfzvOji71umc53PSuHoNWCYUoaF8ndU8jIV+mTrGw0=;
 b=uefHxCRpHr6Re6vPBgRDR6NgsYVUBKdA/idjVkme9PLdHZ6plgENdmwASsGEIQTR5I
 Q8D5KWmCjZwZX2RYBUY0TQrPx/Ci12hdJthH5FJkaZlmdt2atOn7D2GvBH6n4EmhGmCr
 BvXobSh0JLuqHQYX+Yjmc+DeBc22ORTkIc4pmIIKXL2MEyaaAQo6JKI8lk3/ijeSdBsh
 vYK3lNbRBjgpTS758YdznqZsOECq/t+Ov3CwgT0jh3OvhKZ0UGBkWVvjig/pL1NQ9hrM
 4RD2m0U2hwKVNmYSBjJjaGIWQ1ui9D4HucGA8bzBFlr8wSN9LvxkInyC2wNXK3870RXE
 8Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474034; x=1778078834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=umfzvOji71umc53PSuHoNWCYUoaF8ndU8jIV+mTrGw0=;
 b=IwtKbKGmArS+TXXEyno5xrdmrucZ/lr6PHBiyPB0hh4WZyW1FrLWeuaZEz09ZjaEmd
 0ZSwOxjan9d38zBYraTSBHE2CcgsXfJxZcHWO6IDto6xYTqt53GUDTDfVW/C2LMCehu/
 66sRRLLbkQYXrM3ogoQcovM5OdepykJTqUvX8J7G7F38l2sPbCX9dDACjd6s/ynf24xd
 8rWxPUDk2wTqfS28c1A064P08BVZb0jUQObP7L4R0xZ9Vy9x/anWvOLBpci0MMySnfLq
 QKlPNqkFwwIwpnxqeWXNX9IUdodNHzuR9jNOdTwCIUvo4lteXo1/Mm245jItaA4j5ymX
 BeDQ==
X-Gm-Message-State: AOJu0YzQwEaPOmj7hf6cbDvF7fs8Fzl8Xp5bJvtLwJ9Mo3ELYlgfFUaE
 D+o2SL10d8hveq5HBz9MH97xb8PiuDOdsZ2zTzej3B9RYet/XbJTWHvj79AxEc8r0l0=
X-Gm-Gg: AeBDiesVoWMLa9oV2WiYo+HR1Qrnu0A1ucA8A/2LXN4qkKaGX6UUIqhFc2LhXf+Ye8c
 jdtJzDodUummx8vG0ebKUN7TfgP4BXCa/B7TzIGvI0aQA6/vzHo4nFZTUUt0raeftg8c2dVrFLQ
 CoJRttVAY9qoFlYi3oxCl69qmh1vjBalkeLvJtEXZ8Q56ohpngVUTL8ieHCOChLROAPXZSINLlS
 peqQuCuRzyh0wjmAMf0YYsWe6UM/uMVTlNv0IxySp+isDadKs3EIqnQiBwBjjZ/BEq+D12C/pP2
 bKPpp8yMFRFxovNxoUY6vHgDKE6wgFeaZL6UBLIqOd6N4f6VasNrmP3dCp2rk/uzYPcSwbH3qHM
 mkclqH/yuFAlZz1Np3m2gHJyBIOrONOkyWqonyiZONPmd0qIetTWgFqAC1wFuNCnATHp0yJnhRl
 X2lgBq/541MvZ4ZFZtUFxA
X-Received: by 2002:a4a:ee06:0:b0:684:5041:9296 with SMTP id
 006d021491bc7-6966837ddf5mr2182633eaf.10.1777474033991; 
 Wed, 29 Apr 2026 07:47:13 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:47:13 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:21 -0600
Subject: [PATCH v2 15/17] bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-15-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8zLJUOP9iTXAdsPkZjgut3g1hr2+Sb8fdxbKAXICtBw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl+PABoojwjfc2/KfWnj8aAT/VRcaGmjHdrX
 YgZcMRVlpKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfgAKCRBsHNEofbAR
 APo4D/9vyEElp00bR3OdFBA4Nkhvs7HIaLLncl5HSco0FnSEI9Y2vas8JDI0F6apN3Oi4BGAoUZ
 cuzpnxH1imQKq2TZLuGZwLP43hmzzgzOS0NSjCRelswe4DViTr8hIj/wpodLGZinE8FbpPpijiR
 +Mz4gvS6Hrf9k9teF4WBxvVXj8dvls5oUAqvvWASqkq9+kCLZb/4IKbaTsMRrmbRRJW84BWDD9T
 5KeZBxnK1DfXnxOfAJ3w4BCRBFQtQ5hqhafhcNBwhCb+dloIgVSoyDsXk8Ki/GV/7r/kp+XSyWj
 aSuZTobmuyavetFD+MgU6TxWdRwovl/63H9pgru+yeQi6uFW52koYSLBcIrWGLfs9oHdL+BSFfg
 gQ7hpgSkol2KZKnX0UU/+J4OUQEQKC473yUVDjehr84/SqqJHVnyqYX7N3pObwBx29fzgvr7Qed
 Yvp9wVYJ7eF7rw5hI6FD4chHOcm3JWQCNW8xLm1dWl/LuSTGqLBZVYAqi0tUF88gn5wX05S2+Nk
 8LaJD0wbugy/5ZXM4fd7dmmLCSFi54BeD8nytH24u0tZvtODlMjFyPiIlH/x1QfiIQMiecMvZhs
 2pqx7iAf3wrcv/fWwlG1uOTJOF2/HABLGEiQ1VvRm1qa1Omoe2Vx3+3i5emeBkwJZCWvLLvqReA
 qC4e8T/1XjEZ8SQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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

Add special handler for IPv6 interface request ioctls that take
a sockaddr_in6 structure as input and return an integer flag value,
such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 2ff37a0817..aa0153bbaa 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -262,3 +262,35 @@ static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
     memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
     __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
 }
+
+/*
+ * For ioctl()'s such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6 that
+ * passes a struct sockaddr_in6 in and gets an int out using
+ * struct in6_ifreq.
+ */
+static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
+        uint8_t *buf_temp, int fd, abi_long cmd, abi_long arg)
+{
+    abi_long ret;
+    struct target_in6_ifreq *tin6ifreq;
+    struct target_sockaddr_in6 *tsa_in6;
+    struct in6_ifreq hin6ifreq;
+    struct sockaddr_in6 *hsa_in6 = &hin6ifreq.ifr_ifru.ifru_addr;
+
+    tin6ifreq = lock_user(VERIFY_WRITE, arg, sizeof(*tin6ifreq), 0);
+    if (tin6ifreq == NULL) {
+        return -TARGET_EFAULT;
+    }
+    memcpy(hin6ifreq.ifr_name, tin6ifreq->ifr_name, IFNAMSIZ);
+    tsa_in6 = &tin6ifreq->ifr_ifru.ifru_addr;
+    target_to_host_sockaddr_in6(hsa_in6, tsa_in6);
+
+    ret = get_errno(safe_ioctl(fd, ie->host_cmd, &hin6ifreq));
+    if (!is_error(ret)) {
+        put_user_s32(hin6ifreq.ifr_ifru.ifru_flags6,
+                arg + offsetof(struct target_in6_ifreq, ifr_ifru.ifru_flags6));
+    }
+    unlock_user(tin6ifreq, arg, 1);
+
+    return ret;
+}

-- 
2.52.0


