Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE19C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXwqs-0005fG-EY; Wed, 15 Jan 2025 01:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXwqq-0005el-DL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:26:04 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXwqo-0006XT-FT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:26:03 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2161eb94cceso77607265ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 22:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736922361; x=1737527161;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pdcvm4r1FFh3mjhqnqaxRGqrOq+krKeGclEgq6h25tg=;
 b=Xq5jWB4N8crDa6D42Wy5UbO7Ep62/K8RwYu7HmVzKY7pOLdhTxe+MJVQU7s8GRELHH
 aa60qc2/jXhKmoydxoVqD66R51ARVXV7nHe1L+Y5Sc2HU1b6oQjN77IH26wdfYn6D6fH
 in8QFiNZbAp550I/Nuz+I73zx1B2cuj2gVG6CoMvM7mI4CnP943zFJ2Sex2Yn3p1plev
 sHEZCFRe7Nwx/c/DFEwgF4nt4nyd8QRnBkL8uZ5L7tZP5vGUnWFfK7chlrlD6Jtd2tTp
 iBJbzrKpGFVCD+kKeLaUFcNS3+JjvhOaPS5vd6XqAjxaEJ4uGihj5d4zN0GbXsuY/TDB
 HMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736922361; x=1737527161;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pdcvm4r1FFh3mjhqnqaxRGqrOq+krKeGclEgq6h25tg=;
 b=ubauyHrgLhpkbjDclwUv9tbhpqip1aWZLx+Js/5dceQIyRgYOkLbrrwu2m3A0Gicpc
 TmpfqDHW4P5mMt0d+Ru5OrgbYGYmTICpDUfyrewAKCB2+5ND3VZQnteg/BpvBQufZxXx
 xBBLPm3jI2yBps7T6ltVtYn1PiN2nWMYCEPjIMQKppuhEaYTad4zijoh4I7ndGbetceM
 69zFACV0Y+ZFoxkgMhRebHLGXIIXjmmUIrb1xvGepjm1crZ3sRMlFIOZ/CQ9e/+P/0Qq
 IzYo4HK/z31fOTDYlFEDSO9CYQTAryupIvpEhKNN2qyq04Or3Wl7c5ZUYgn8kl81bedj
 rpVg==
X-Gm-Message-State: AOJu0Yx4c9z89rNwOSXCa1S7//w7RAb4VXo5qOWmeiKpHEFnshRXaPoQ
 XsvYDDzoShL3oB46InwI6uZrIN1QL4HA6aj3xhyowYyy5G9xdq++Sz7rvM/v2W0=
X-Gm-Gg: ASbGnctmTyq1iJO32nElDDT83PLdy66TYh6lMBZW+ASETcEzyCrKW71ZVhO946M2/ZD
 SbD075tlqkP4fBcly/o+VjufgthTYmT6f581Ni/L7H20rFHtmGdnXLB3/EjQvQ2MaVOl0C4FRDi
 qti5sZYfwHGZeQDEQGa2M9DnARvjk7AZJVROV8crxbvbhZvTor2lRIYesyI2eu+0lldlOV6Y2YE
 eSVF8F8s8XBiL3PdmtBbjO3lB36HPUQA6ZrSQwi+mWfVaeY73itgDbzji0=
X-Google-Smtp-Source: AGHT+IG7TdAwhLeVX2A4dCE/eNC9Oh9DqjvjsX2UJ9zSLDGU0IAo3zNr8oAgWMDKgfV3YU9AVXhlGA==
X-Received: by 2002:a17:902:e84f:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-21a83fc6db1mr389792495ad.41.1736922361061; 
 Tue, 14 Jan 2025 22:26:01 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f10f97csm76565705ad.16.2025.01.14.22.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 22:26:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 15:25:46 +0900
Subject: [PATCH v3 1/2] glib-compat: Define g_spawn_check_wait_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-glib-v3-1-bd3153344698@daynix.com>
References: <20250115-glib-v3-0-bd3153344698@daynix.com>
In-Reply-To: <20250115-glib-v3-0-bd3153344698@daynix.com>
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


