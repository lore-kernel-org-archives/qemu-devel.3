Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21803EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTfi-0007rG-03; Fri, 06 Feb 2026 16:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTet-00069g-PU
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTer-0002hE-4d
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so13119935e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414391; x=1771019191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpZtyXf20pDRBHXGipb/CH1eAlwIqfkOm5zEYUBKpGc=;
 b=eqkYqbmoAUM1UbaqUuJzZm4aVc+FJx84S2WQuPk7qaJ+Y2Ua8sV/AprCzQHCFrgwZQ
 1fnUiVLfrHYVFksUQSiRz8ColuInLiuNwUeghd9O+SFXLplCBm+6T36LKMbp2vfuaZAy
 HBoEI0beDpcaTb5ja85sEboyW2FpiZ5WYnomJOC4NPUJ1Syxd55le0WUzZStNqaKeVAL
 qnWKjv51tNJyAOYJzkWSHw5PMfabsyG9DFCx7JfAJRFRvY+yUutc+FWDPTEw3etWcYxA
 nl+XXdEkPtyzJFAV8FVuxa2DMy/VXDcM7s0NIsn3PGZiq3VSU7oTaTQ3K5B4s1AAoqhP
 LKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414391; x=1771019191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZpZtyXf20pDRBHXGipb/CH1eAlwIqfkOm5zEYUBKpGc=;
 b=MC7NMQB1oOUjO8NhR4VnlN3SOdELJ8J3j78ppcLkDaZbxf61lELxeH/xbyROSebOq5
 Hx/jxydHPzOw5tyWdNmJPgP3zm8XOlMsnOIADLxTb97JFs5FDCTUcEEfRAbeuxuI42dW
 zaJ75MpGPgbS95MuJvXZvEcEHbYilPKivthzIEsS8i63mDbWkjRro5jxs1trZzJEMai5
 PNaYImWoqAw+LBjE9whu7fTVUdyYeULRxUiPD6bRmx4phrQiMHYiQHj23qsxwWFWQYbw
 /9Aratq6XE+DHDBHoJiPtNlIE5h6hBVbMhM5FLq0TYr/FD8+2vO9JPJmDZ58nR/OruS5
 0d8w==
X-Gm-Message-State: AOJu0YyYtPsG8E0WGclKmQCFns5fMXwr+XfO/BcO7eGSMIHqEf1mTdWv
 5YIiRUMIBbiO5JxUPRNcX8kE0wD4lc2UYjcBAGEkHu+4grTW9vVRSZUiku1Bh1uMnfPtuJ+TrwB
 9VsjeVEY=
X-Gm-Gg: AZuq6aJ/8IchTaq4Cg1YMpXE9fqE+6adpNHGI9Upak5dTD8ShXogBTTxu9CAVPApPzB
 6J6jrC0GnqxxYqH2whAM1cpcGC3rfsMvL6pKnECd+76EpnIuIBu53AfW70GYa9PbxAr6yquiK5z
 BE3CoCS60Ch9tXAH5BkbQEFnTPg9+TLoZ878YkiUyjqLECA2NFY1zS/1/s6zHJulRfr+ilRY2G9
 Npg2iHr58nhLcyN2re85njGtjbSZ79j0fltt9ncRl0v/BHwb1juvPnQDPDuTdLB55VwDyCnEk6r
 /hMEvdo57DA73EcV2dteVqFjyvwfowCiHcKAjyfIe2urX9jseAiIQ2JVMEJeUlD42aOLfutjHbi
 VrNZwXkg7/m/IjtqyfnMlcFjR3rQBBMKb0+A4E6nMZTI9VtElbN+6FIHCrWu0U+OsK+LRp+Qzij
 n29w73lk2HmM73BxDwsnYJz78ZyGhRMEzyWwNSyszX4hghK2oXK+MyyTvn9dMlNv/K1cEcRmo=
X-Received: by 2002:a05:600c:8b0f:b0:47e:e5c5:f3a3 with SMTP id
 5b1f17b1804b1-4832021613fmr61617135e9.24.1770414391165; 
 Fri, 06 Feb 2026 13:46:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b20fasm9180626f8f.6.2026.02.06.13.46.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 15/30] configs/targets: Forbid SPARC to use legacy native
 endianness APIs
Date: Fri,  6 Feb 2026 22:44:33 +0100
Message-ID: <20260206214448.22008-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All SPARC-related binaries are buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260203230054.23667-6-philmd@linaro.org>
---
 configs/targets/sparc-linux-user.mak       | 1 +
 configs/targets/sparc-softmmu.mak          | 1 +
 configs/targets/sparc32plus-linux-user.mak | 1 +
 configs/targets/sparc64-linux-user.mak     | 1 +
 configs/targets/sparc64-softmmu.mak        | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc-linux-user.mak
index 4ff4b7287d2..d3f0716ca2d 100644
--- a/configs/targets/sparc-linux-user.mak
+++ b/configs/targets/sparc-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 57801faf1fc..272fd46f6db 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 7a16934fd17..3e6c72e793e 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 7c2ecb7be06..3bbd8495210 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 8ee6d057682..8a0290c2093 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


