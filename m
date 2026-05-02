Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538FCCD3427
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsB-0007nG-2z; Sat, 02 May 2026 13:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDs9-0007mw-Hi
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:21 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDs6-0006zv-El
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:20 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso2595352a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741877; x=1778346677;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8rpruV1+UHQV55pY2gJJC4yEtZAqwr57MV7/5Hwoml4=;
 b=DZ0escL15QC5NllOP2MIxvYA1EBJvhWPjNAkuDDtjp7UyIc0K1MKX8zkSzrQ8xVG4J
 ef3ekVbrsSXAKF0EV6za2kgM32Xq8WZnGQHVLMH9z8yZD4ERNH6GjrniGxbTKbJnY6ya
 v5zolqkzumagnMTfhQHe8iAeCwWM0NObAQ4wJpekrII4+IoMVKUH5nwCYQUVXZisag+v
 WdEd8vDkvBxwAXVo95CyHAuK2HA31W74qvs7rz8po/uw5tbS23bRXLlx9qsdTjWCpfPo
 07IPbgGxDQSdvNC1yCLvTzDA4rRpsT/tBfEprw6T8nBTGW1nETy23zdYEsqgaEcc0VXX
 5P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741877; x=1778346677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8rpruV1+UHQV55pY2gJJC4yEtZAqwr57MV7/5Hwoml4=;
 b=le014o6KpsPS89D5I/wLyQNT0cc3JYAH7PCyf0bwFmzgx/qZMbqIpIlnE8j0afYSUn
 GMd4k95LWHl7C+EW4zVhyZTuyv3RWQYMRY/vMmXN1OKa+7TMBUs3Bt3ZVsQ+Y4k7S7hT
 IOZi/+/gxCSp/xc3IRrd7o31HVVXA8bodr+tdi9RiHJQuEuhZ9ixtLKoCljv0Cpl2Bj+
 5aNa0mkwRy8LiXApz414bkqU8IIfMsehwqouxG8vMlV7DwZU7n77oEySKTZfnV7UUQTt
 33C0PtPkdBzKqS64tPuOhtAVck2QYiBRX4bKp2aWMmA9HIFqzWcA5um8XoL9MsEF3JPE
 +ZaQ==
X-Gm-Message-State: AOJu0Yz2CFBCjp8b1tTqDr915JUR6Mbo/3XVvGrkmXWjyzugHIfusEae
 imOVDqGVYdkDZn8p666NdDhcg/RghcEwXgiAIVBZ50l4ifAC5dc38wh18lJ9qwBDdP9D4cDxiYP
 w2po4E98=
X-Gm-Gg: AeBDieu5s6ClUCawESoYY7Dxn0KtHsFI7b0ouHOfidpMWYb+5Xycc1f2eRufC/+4ZLr
 mgkurptGXtMzWZQqN7ydyOJNMc5OyUc3J+097wx+0Gg0SxwP00KZAGNPFq4MANVOj361yA1M9UL
 Rf40d3uSsf4nkzWhrjfbrhqPT5dWUMyWeBD9gir4MAVKxtPJIRvJ4fBybX8XoSr7B+RqzKHOC52
 HcPNtsIasCeMTervY32GlN+V4XNtVyCE8Rbm/AH4f/BlXmGbqpKzM6CBM62sYcJPENiVHS4zjVk
 XnPThruRnaZCH1Iz35cmZvKTrecNmmFiV+lqDh/nWZhpN1KFzF4Zko2drl6Ce+BYpdAWYoEzsPJ
 2dVDk9BV9fYnuf5ntbCO8vUdhCk4NZyWvDqTQJ6kgDCNOZsZr4aNwUAP81HPemiXvcBiprEPQ7d
 1TxM0oiXrUb8KevJzXzKjv
X-Received: by 2002:a05:6830:6b04:b0:7d7:fbe5:e9b3 with SMTP id
 46e09a7af769-7dee11e6b2dmr2164088a34.3.1777741876995; 
 Sat, 02 May 2026 10:11:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:16 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:22 -0600
Subject: [PATCH v3 01/19] bsd-user: ioctl: add common definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-1-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=SSDuJGLAHSn2lULS+9Ubyrr5Kig3p4lTT3gRT8PcNKY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/PjWWv8FG+518ze7jl5epvYBjwre9y82dS6
 0pAFu9wno2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYvzwAKCRBsHNEofbAR
 APozEACVqW7Dr9i2BZsKxYKsCegmf9+UQtIimIUJvkOdV1PQovMmLtDNW8JGiaEMZz/6vW2Rgyw
 VPhfOr9GtcM6Xu/opFS7JuIYKvmrQyRdD/wD3Nc6kMGhKlMwReC49/URi1e7vuAnA8lTCigH/o2
 7I78mOigfrX5NlQcNxkvwmXbacWzJzHzqGoYc0FvDCCi6blwO6M4PoaA31KadyGYWEnriyqZdKu
 JDAbr7smbzU6AJddCogBr/0+AGMow1/HTYa5o+ANRVHCCb3QiImg35z8EE3yAd8oeXDgloa/oUJ
 cGp63U4QJvyWv4MtVvLKnWhZjhNC7rtgVIX6HXWaXG8jh+HfTej14GJ+ivatoSLXHEduxKiyqoJ
 Fgl/uNRjJSPWdX9tyFX6nqp2mglwDi9j2rqvlijxXHQ9EQhNhzKMWIL9TUYbUP8QNwH0CUcHkWt
 CV9RsfiQbWxG3o0PlYDdBOy63/DtRtmZKo+TZu3gWQe+1IZd8DMloQTQ+JXMQiqLLEH4DdSly6G
 yg0xH12mK76hMfHVSW2KBr4JB5GoQZ462qqlvqnHtpanuLsiQHdK2kWTANXC69ymoP2tvvl37OP
 i46el6EC1fLwUpE0k0MOcvgxW3gcNk4SGtuIM898EiOvBSdnCWTWQN/yjsu1QJIrCsPJYwWhWm3
 2MO7eQNuIHwKaeg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Modeled on sys/ioccom.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-ioccom.h | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-ioccom.h b/bsd-user/freebsd/os-ioctl-ioccom.h
new file mode 100644
index 0000000000..3bb9ef2710
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-ioccom.h
@@ -0,0 +1,43 @@
+/*
+ * FreeBSD ioccom definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_IOCCOM_H
+#define BSD_USER_FREEBSD_OS_IOCTL_IOCCOM_H
+
+/*
+ * Ioctl's have the command encoded in the lower word, and the size of
+ * any in or out parameters in the upper word.  The high 3 bits of the
+ * upper word are used to encode the in/out status of the parameter.
+ */
+/* number of bits for ioctl size */
+#define TARGET_IOCPARM_SHIFT    13
+
+/* parameter length mask */
+#define TARGET_IOCPARM_MASK ((1 << TARGET_IOCPARM_SHIFT) - 1)
+
+#define TARGET_IOCPARM_LEN(x)   (((x) >> 16) & TARGET_IOCPARM_MASK)
+#define TARGET_IOCBASECMD(x)    ((x) & ~(TARGET_IOCPARM_MASK << 16))
+#define TARGET_IOCGROUP(x)  (((x) >> 8) & 0xff)
+
+#define TARGET_IOCPARM_MAX  (1 << TARGET_IOCPARM_SHIFT) /* max size of ioctl */
+#define TARGET_IOC_VOID     0x20000000  /* no parameters */
+#define TARGET_IOC_OUT      0x40000000  /* copy out parameters */
+#define TARGET_IOC_IN       0x80000000  /* copy in parameters */
+#define TARGET_IOC_INOUT    (TARGET_IOC_IN | TARGET_IOC_OUT)
+#define TARGET_IOC_DIRMASK  (TARGET_IOC_VOID | TARGET_IOC_OUT | TARGET_IOC_IN)
+
+#define TARGET_IOC(inout, group, num, len) ((abi_ulong) \
+    ((inout) | (((len) & TARGET_IOCPARM_MASK) << 16) | ((group) << 8) \
+     | (num)))
+#define TARGET_IO(g, n)       TARGET_IOC(TARGET_IOC_VOID,    (g), (n), 0)
+#define TARGET_IOWINT(g, n)   TARGET_IOC(TARGET_IOC_VOID,    (g), (n), sizeof(int))
+#define TARGET_IOR(g, n, t)   TARGET_IOC(TARGET_IOC_OUT, (g), (n), sizeof(t))
+#define TARGET_IOW(g, n, t)   TARGET_IOC(TARGET_IOC_IN,  (g), (n), sizeof(t))
+/* this should be _IORW, but stdio got there first */
+#define TARGET_IOWR(g, n, t)  TARGET_IOC(TARGET_IOC_INOUT,   (g), (n), sizeof(t))
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_IOCCOM_H */

-- 
2.52.0


