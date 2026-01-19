Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FC8D29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufQ-0006rK-1Z; Mon, 19 Jan 2026 14:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufN-0006pK-1o
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:57 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufL-0001Uh-2s
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:56 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so30439535ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849913; x=1769454713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAwgkxcCnnqe9jCM08ttRZ7hAqumVGJ7T0ER05F6LwQ=;
 b=f5f1N0879vdmzEt8fX7HzriwVfPEhS8dbll++v6qOS5CD8VIE5tE5pOrS50cWirEfU
 rpKhO4KvnKwtVl4I/AsTX3yvotR5KSyTFbfiwanY1yVGwcUbEpg2sGBhAgkRJYZoqJjq
 WD4hCJiwadl4VLfpujHoyIdfOGrZ8HI51lTxe2jnaYovCViyPva1dgbrO5qLwu3Xv+yi
 Tnn40upEyDkBmRRR3O1N7kt/B2sc5xqv7lzEuxuxSQOj3l7yJ2/MIaU3H80H9IYBgusu
 zqO78dt1KZotAPWABHlOEyRf9cDwP/S3vjHSCCmAgiM7XEsS7npX4A6AMqFKw4nViQgQ
 ynjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849913; x=1769454713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAwgkxcCnnqe9jCM08ttRZ7hAqumVGJ7T0ER05F6LwQ=;
 b=Ab0k89rkXTt7b7k4JfkWBGsq1sdgv4L8XLl8HkNR7ty6AumjC0Mq0MdifJvNP1x7Q1
 08GWwnd3bwD+UnT87GwSzfBiBdehhGBhr3bXwN1w2wfy3xEmDuK3k3sYb+NOwE4mZDNG
 H93jpI7Ww3hVgxr8E7AzxPJu4xYOX9xa6D0R0qyl4wa1w9CC594YaETxeDjdFY7ALpOB
 aD5sy0QvsyfgEKvuID8OnSEBGCQUubQt76vkJAHoj7GpvoD1YgJAfVr52geB3zvmhWjM
 BDEZOvxCeNrElU1loBf61bDWHZHplCjZDUTJl3hbPGN1mANEmN2kKhQr586QvGiWaCuL
 wBjQ==
X-Gm-Message-State: AOJu0YxnYrw7LO8B+GnzzE2tFKICajCPRo2YfsQPO/EhMlMKf49YPRHm
 iHPUJpDIwHX/a98HSMFuCmoFAWo5zBD2tucdo6vR9p4aWTgYHpj+qcoFkoiy6xJeXrYncLNNKab
 P6fwA
X-Gm-Gg: AZuq6aKmkhSmkBnVHW/yPa+fpRb+eGAwc8hPSvobDQTVgLpZc9hyxtdA7MJzQ+UdHAE
 oRHBgENr8rHTA2cSf3xAjVfTdv5haNwBtEWREpF4lG9XYRMJbx7YfRKIqFpRs3Qi92vyiNeLw7p
 h2g78I/Fp72es7pDqJ4y8supFkXs5r2Vk+2AgSIzUp9jn29yLd73sJ4yz1UNq81en16sGsaLvts
 VDreMIsdLKBOw1NUhv7lNls0srFNerUxc+K0/lh6h7rTxNFHvP4kTfVbIGKlBqHepW4ygxpuPYg
 Z7zXv/b/+zDeAHSxCIo4JVdCd49LCPBUkCNPRMq4Fx33z7pjLa+qOMCNvvGLYe5e7RLNReTyNjc
 2N0tFl3UusQoIeFJoHVhVIp8eBDWoLz0ymLBCVYstXWMAqs2GvlnIIhI6oWb+N2mXPjTtu+BCqD
 OjRLBd6/mqsMa1uYUlgW51Vd85d8JqSiR/B4DuqcG724JGjUSRR4vnw68iLFO+MZ+kOYiYH724e
 4M=
X-Received: by 2002:a17:903:11cc:b0:298:2616:c8e2 with SMTP id
 d9443c01a7336-2a7177d6fbbmr110460095ad.53.1768849913395; 
 Mon, 19 Jan 2026 11:11:53 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:53 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 09/11] qga/vss-win32: fix clang warning with C++20
Date: Mon, 19 Jan 2026 11:11:35 -0800
Message-ID: <20260119191138.811069-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

C++20 deprecated such constructs.

../qga/vss-win32/requester.cpp:380:32: error: bitwise operation between different enumeration types ('_VSS_SNAPSHOT_CONTEXT' and '_VSS_VOLUME_SNAPSHOT_ATTRIBUTES') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
  380 |     ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |

This is a false positive, since VSS_CTX_APP_ROLLBACK is not a value
defined in _VSS_VOLUME_SNAPSHOT_ATTRIBUTES enum.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qga/vss-win32/requester.cpp | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 5615955b6f3..74489fcd0ae 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -377,8 +377,10 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
      * To prevent the final commit (which requires to write to snapshots),
      * ATTR_NO_AUTORECOVERY and ATTR_TRANSPORTABLE are specified here.
      */
-    ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |
-        VSS_VOLSNAP_ATTR_NO_AUTORECOVERY | VSS_VOLSNAP_ATTR_TXF_RECOVERY;
+    ctx = VSS_CTX_APP_ROLLBACK;
+    ctx |= VSS_VOLSNAP_ATTR_TRANSPORTABLE |
+           VSS_VOLSNAP_ATTR_NO_AUTORECOVERY |
+           VSS_VOLSNAP_ATTR_TXF_RECOVERY;
     hr = vss_ctx.pVssbc->SetContext(ctx);
     if (hr == (HRESULT)VSS_E_UNSUPPORTED_CONTEXT) {
         /* Non-server version of Windows doesn't support ATTR_TRANSPORTABLE */
-- 
2.47.3


