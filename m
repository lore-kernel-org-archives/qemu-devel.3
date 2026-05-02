Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A77CD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsW-0007ui-Dv; Sat, 02 May 2026 13:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsP-0007tM-Fj
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:37 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsO-0007DJ-28
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:37 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47c7b282e21so443198b6e.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741894; x=1778346694;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/5WwmT1Nl2SLuj37J8q9Pa4m4CRjwDyjCSwrLxZuNc=;
 b=krrlwkIk+a3p6yWR7gimgVvMsFVIxsGA+gcOGGhKQihXerQoGw7y1YBKGpCgxXmrqQ
 i+0bxfkSRhozikOUn0xGaLrTPT8Jy5zZLO89Xlx8bRMDpByBQ2SEq0NRYULxtfYUCuvN
 idhqNSM8OCd76l8BcodjPJ7dsQCF5lh51FG+xtmz8+Z3cCFhO873+ApSZvQCvdvAF0eG
 av1wD77cbAJriXjpEd+ofCKph+NaL1J/i9xldDiL8k3CX8Cn4nY6J5CTcuBVBFZ0tZYc
 e5gLN+oPW4XPi9q1HKx76RylW4x+hKYRPTUupSS+dTkc75gj4Qpsd026WuMg1PL9eoEx
 Lyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741894; x=1778346694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u/5WwmT1Nl2SLuj37J8q9Pa4m4CRjwDyjCSwrLxZuNc=;
 b=M0QF7e+Tt8gKbw/468SLQUacEsgrIcRIeDECnv5gOPrrTh8+eRKDMxWd3C+hyAqwm/
 39ixpRM5Dg1uONrRf1ZB1wYXY5U6KjVoUzLxLALGcaYUI7YK6X3s+lp8CEQG87JzbaQd
 ELGFU3k4faVNI9LicvlZlnl4b/TSw8G/l0k9Hhyi5oUcwstw8b/7PCt/S3dCuTT4of+y
 EtpTBMtyUp1mkEyEQ6Fyk8rpZ0aM78V/nHMyYt8j5gW0aAONjOHHiirQLpucDKi7tfWL
 LoO94n691taDxApW5dBu5FgRaycGqTF8aumHWhVwwFv9GznjybES1+I64G40Woaa94x2
 7AjA==
X-Gm-Message-State: AOJu0Ywq+X4ZLlCk2gTziEyFtz90du+Gs+Xy3WSdZZuajO+PR743JQGL
 avJmJoci3wAlTmtbZcCijOhJ0uLLZSy4WV7pDZ184/JfhWMsaG939AOVMbB+YgWRlQdy5iN4+2o
 05uYfM6c=
X-Gm-Gg: AeBDievIHNGI0DqwTM5rUxcbfB1fWWonmsUAgGnb1PFgXEi7SxLmLN4HLiw0dYHKqZy
 dmMUhzHmCk2QUYNV9EV92XEie8oqZAww1zp4OGvWFgmiM2FpYOXmDpn227B9owI3XnNl8070Owo
 fF33UlIzcDWDpAxB8ERHMKhvE4h/S8WXKxW9G/o2XonSDZjlZaad/KsruJrSKva71zjEOvrgbNR
 4HftaWAGu4hNPNWR0ZKBIPOo9X7X3jfvU1grASEFkX81GL0bQdPR+VK7n2HPzjEGi8DG/i4Nxw8
 eO27lirOr75k6favb3957Av0dv0gvvhEpm5a/yh7fS5y9HTvyW79K5wJgrs2pzzDimnwYtnFrCM
 jgRzauR3oxQYWoeJbaUMPHvC2o6xY0lVGMBy5md+BNSIcfdBSM/bvM3RCEOglj+DP9trktktAWM
 njMoCoUnVmucQ1LtoeZmKc
X-Received: by 2002:a05:6808:4fcf:b0:47c:34fd:d391 with SMTP id
 5614622812f47-47c8931483dmr1855816b6e.46.1777741894102; 
 Sat, 02 May 2026 10:11:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:37 -0600
Subject: [PATCH v3 16/19] bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-16-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=0Px4FKlaWpUQPC6Iuv07IPtIHSjzI5LaoVqTdqZiEKE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/RX/9KVzSpTREEhhpujFMOtrWPqz6/Nn8nD
 I1AfDydcjWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0QAKCRBsHNEofbAR
 AMrMEADOzaVIfrnfQw8j2cw0Em3bdhq9X+BkCFv5K02uJYASaZIDvjkCsxPwNvruFgBNOmKzEMc
 DqDvkdJ4a5VU7p/BjwImjcvs/FFPOjklFdpW2H3v9pzRxxQGyDfv7Foive7EuICEjFx+Q8SARnj
 Fv/JicgSLJf3wlBbgOdfKMRg6Gsf6+3a6qy2OCBqx0jMuFo3ujXKNZLtyduV5cHlcFhCP72g2nc
 Bat4ZVj4MiKG+dLkxscw55hgPgeGJl0g7bLvlQ5Hk/1QLGiM5jhNoLS4w4W7R4dJvB3QMyRJPGT
 8JPGKgPevIQiZg/LSOMvi+DR+YgD8FpuWwLbkSQKlrkT7DK+LAUajhjl3KNsDKg5K/7FOrsyFMx
 dk1TbWAHkiFy5T8+JrtcFbCAFULbvxfBK3jwJXhvgl0XP5uGXzmjPRhSzmIIdpK8nKTXV7KAZO8
 l1y2HGwl6krtZIUB2IDTxhUVpu2sGgBUSlFZXymBYao3ORpmvc7KK2r12Zsdh85vFp5nQdIQ/1N
 zq5b0lqc1LbGi9z1zjeJenNaLR9BqIH+AfaWE7cPvw2aOSUb/v32psPOdmggbdRWD8oFVSPakL3
 pqaeupRYm2Ymgsi01ynkMUjUboNpsgA5P6LUJbfCTRzwwn8F5UG99gfzhAgukdds0jVvlX4Kxox
 VJHslF6qklTJKXg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x230.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index d2eb9105fc..8d25d84dbe 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -260,3 +260,35 @@ static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
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
+    tin6ifreq = lock_user(VERIFY_WRITE, arg, sizeof(*tin6ifreq), 1);
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
+    unlock_user(tin6ifreq, arg, sizeof(*tin6ifreq));
+
+    return ret;
+}

-- 
2.52.0


