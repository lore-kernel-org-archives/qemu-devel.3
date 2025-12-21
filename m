Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF14E67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKM9-0001pY-DL; Sun, 21 Dec 2025 09:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLi-0001LH-CX
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:58 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLg-0001Lj-Bs
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:53 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so2926011b3a.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327030; x=1766931830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L51uaKTVgxyKMIF4vldQB1dPrYARBcQxc3sUNPphHw=;
 b=eX/KbLvfS2VDdxqiwi2+U9cYWvhZ+uW4cXrftu83xrg3CYJ9eWkmsjqD8PeAXWFG+N
 kUL89+85TXvoHKrKo8cKB/iYLVCOebSBAswpxw36Du+qujaEAhQ3591kyqiRa1OwKiBJ
 5vl8aW1e1XMwG2ABMkyAP9dxjh/bAFXeU+s7DH/qhwvsMp2kMC3Es7FtHwCIbH8VKFZ2
 NM6HlRG1BtW/OURgA5misTgXCi+TOwBdn6SbYJ6ZbHShyKImEM0iBgTcf4KLv5jVwjPD
 bnoVRsszmHlrO0miMxjHjTsr+kzyLuc4ff7D7lhAB7jr3Ne6md2HJa1MPqQEand19UA8
 EumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327030; x=1766931830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0L51uaKTVgxyKMIF4vldQB1dPrYARBcQxc3sUNPphHw=;
 b=TGjuteJVcR98T5Qqd9jTctSUXKBSgEuRmTSRFnm9QzqelhUbMF2chukypgW6cykHmb
 reqK8FikxKpY7ZuHBpDBhNQhAqfkfboKQYaDW8ROkXusg6//g4q2/47xZlhJ6NGvyRrU
 6t45+YfCwV1Sc3dZrUd0dXPH0DlRZVdwFAmgOQgAW79DfgSVDBuZv5n8FuSo71EQAU/C
 V3l7zGz8pWvBoJc8r3AHeg39jTz2pNOzoX7x0AbIcG2VYASYxJOM/bkWEmsvhuo6GX6Q
 OmoxeJe4Af6t/AINFF0w/R/0HTwPvvuQqfAPzapaYwXuMdGqR92H8DH9XgMdpTZhsWvw
 eevw==
X-Gm-Message-State: AOJu0YzRBHBhIrqUJgBb3HG+AZp8Bv/gquJGxK1bWot87AyIM9JGctmr
 7L90JjT/WsdGACzTfbEL+SFLQALp4khm4ESy2bzXO8e0EDjjHrKIQB5R6RvxbgxGtV4=
X-Gm-Gg: AY/fxX7SLNiou/z51E//ygcVFroj1Yebqz6thlVbAL4cpzgofEyPTTehu6x6auSzUq1
 ZuP0IVFROl0NeNkmONvxrwD6jPUf7IOFMlUbZWw+pSI52V9zl9tw9PvHIaodmx0uJE2a7IXTAu6
 EHlI+Z+f3RP/c/IE4+R3zh6yrjVDKDYEyg1KuJRgpe4tf11ph2wuFbsAmeNtu6iJoq3+4wTrP7K
 WNSC3S+yxR9fcHhSCYSQa/nGPX2fInWYVMwxEG25EuhAvQBAvGlS6DNa93zmwa6IiKhnaevPccg
 D0xpT9tTCpAjz6iuymNKEWTgwu6HQx4U/gt8xod9txYVu6cPtIV0WiFcuKKZHqMLEQsyliha2n9
 68eJFuqzyog4y/AOsv6RwLfWCCMMeVhl//C3dg9P1JfRpZZhHivAM/a5nRPaZlFd+CW3oB8XTmX
 +yWnr1fQhTEpiOLf626g4=
X-Google-Smtp-Source: AGHT+IEiLRToAUJMCSGTEtKUnhhjPHenbVqSZ+B/6+bNpjDbZ9IJHVMCRTVNFQNEqa1kfMsAUPp3HQ==
X-Received: by 2002:a05:6a00:451a:b0:7fc:da5:f85c with SMTP id
 d2e1a72fcca58-7ff6607b30dmr7547030b3a.38.1766327030412; 
 Sun, 21 Dec 2025 06:23:50 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:49 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 09/10] scsi:ncr710: Fix DSA register
Date: Sun, 21 Dec 2025 19:53:16 +0530
Message-ID: <20251221142317.266293-10-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement byte wise write handling for DSA register instead of using
the macro, as NetBSD driver accesses it byte by byte

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index dd453991e0..0ea1fc43a3 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2078,7 +2078,21 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         /* Linux writes to these readonly registers on startup */
         return;
 
-    CASE_SET_REG32(dsa, NCR710_DSA_REG)
+    case NCR710_DSA_REG:
+        s->dsa &= 0xffffff00;
+        s->dsa |= val;
+        break;
+    case NCR710_DSA_REG + 1:
+        s->dsa &= 0xffff00ff;
+        s->dsa |= val << 8;
+        break;
+    case NCR710_DSA_REG + 2:
+        s->dsa &= 0xff00ffff;
+        s->dsa |= val << 16;
+        break;
+    case NCR710_DSA_REG + 3:
+        s->dsa &= 0x00ffffff;
+        s->dsa |= val << 24;
         break;
 
     case NCR710_CTEST0_REG: /* CTEST0 */
-- 
2.49.0


