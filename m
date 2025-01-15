Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9DAC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY27J-0003ZY-7S; Wed, 15 Jan 2025 07:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY27I-0003YE-18
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:03:24 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY27G-0008AA-CN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:03:23 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21644aca3a0so145412945ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 04:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736942600; x=1737547400;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pdcvm4r1FFh3mjhqnqaxRGqrOq+krKeGclEgq6h25tg=;
 b=JqipSV2JR94WWepCwmGHXBKxCeO1npr9FSt7IQLQljfXmlolfry3zicPB5lkxObojf
 Igv4NED5V5HyCT0rfio+Ic8odkirgh2DLeinu9+69MvR4wNZxJpASz9nkS5xc+yXxFMR
 P+rItoHt6HZBMPNqf5sTWc6cd4h/+qc8Ck3D8Ua5vUjid8+3fRcl5JmxNDOqF9tOurRR
 jH5KtwCCejFQSY/+K+lWXXWn0Mz4TdcMqsaYL1mU1TnvF4/Naa423I/g6Sh3hVWvMS3E
 /6d95XmP1u5qHshqs6XOZfhbn+jmb2iU7DfDdtm3xkxMecYylnSqzi/KBnYfQMYrNwiK
 NrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736942600; x=1737547400;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pdcvm4r1FFh3mjhqnqaxRGqrOq+krKeGclEgq6h25tg=;
 b=XWbhZhpK6wImnDs7TrUfatBdUj8Cm9ryEMNwZ18iXars1/W7GWfgYwsEAs3sPWc3dF
 K8dCdR6HI9OdBr9pBAOiJOWC8ZmdHcGjPL0BHs1VdJCzhFs2RHKO9ZPDY8Hzn+zEaZzj
 ZtNY/XSTD+Uj+lE8taAEGa6yEn+UsnsT8aDKNG1qS6Rd6sT4y5u10qgiA45gQNw84VIA
 UlXcftchj8v00QlqJ3s06pQvohItl2cFI8mnmIaJxTOurkJ5KtHCwY3UBKmTM5hzrDr0
 dtCKY3l5ZviWn7ZzW5zBnjhJFo8J3AR/BaVJMFMp68HXeOvu7NwQiN+/BLUopEU1U0Mw
 Lo8A==
X-Gm-Message-State: AOJu0YwBeHE9ugEsxUXO/kk8MP1cYHy1+zNUR1UFrx9IHzjblYI3bdJO
 ZrXkb6biwYhoUC2Clstch/N5N1kXUQBhn9yXy5UMkDibHic5hytTQqkISCplXMc=
X-Gm-Gg: ASbGnctoiLxYduupHF6eqiIj+DqAkXLpi5tfKgpW4bmw9IvF3nUYGXg29ZV5/zrehOk
 g9dMnI65cu53qImSmlBBTQ1lM+1nJmwEE2GLiIysdyIWjd6+wZIl2vPDQfX/b2CjL7xCaEdEP6R
 juHCuJUCxevvvjUVyvxixf66QBQ8xGjEs9wwq2y1b+YMnxzy1CUdBg0N7UtUY14fnMViJfo8LKs
 7roJTF02va+rl+mOYotHoPaxP9qQ/VkB3KqpKgSXkMmucTSK7YAT8ik8khA
X-Google-Smtp-Source: AGHT+IEV4UNSyiehZCiUvatqLFajTvW+mdS5YjCdjA2R0nkjuLZuofglBpVCwU8oFvpDPH2DwYGEmA==
X-Received: by 2002:a05:6a20:841c:b0:1e1:a9dd:5a58 with SMTP id
 adf61e73a8af0-1e88d0b6d05mr51136157637.30.1736942600309; 
 Wed, 15 Jan 2025 04:03:20 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a31844ba221sm9704801a12.24.2025.01.15.04.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:03:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 21:03:07 +0900
Subject: [PATCH v4 1/2] glib-compat: Define g_spawn_check_wait_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-glib-v4-1-a827b2676259@daynix.com>
References: <20250115-glib-v4-0-a827b2676259@daynix.com>
In-Reply-To: <20250115-glib-v4-0-a827b2676259@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

g_spawn_check_exit_status() is renamed to g_spawn_check_wait_status()
in 2.70.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 include/glib-compat.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 86be439ba0ef..a553ba13a36e 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -68,6 +68,17 @@
  * without generating warnings.
  */
 
+static inline gboolean g_spawn_check_wait_status_qemu(gint wait_status,
+                                                      GError **error)
+{
+#if GLIB_CHECK_VERSION(2, 70, 0)
+    return g_spawn_check_wait_status(wait_status, error);
+#else
+    return g_spawn_check_exit_status(wait_status, error);
+#endif
+}
+#define g_spawn_check_wait_status(w, e) g_spawn_check_wait_status_qemu(w, e)
+
 /*
  * g_memdup2_qemu:
  * @mem: (nullable): the memory to copy.

-- 
2.47.1


