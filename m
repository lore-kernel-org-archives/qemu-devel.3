Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45FFCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 07:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDGfJ-0001RL-2U; Sun, 04 Oct 2026 03:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfG-0001Qn-39
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:42 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfE-0006CF-IT
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:41 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e630052ebso1044362eec.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791098979; x=1791703779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MwfDJHjDBFDCIZj1c4Xf4y4GCGqkHkL+PFUd7yAaTts=;
 b=oRjmr119oVTwuTN8ZI5+/CIGnCs/DmrxTGzIOfnB1rWq6J0xYnOWN3rcSIXrr5yjaZ
 06g+mRlWFT2v/3RnL/6tsutEf4jFzDMoj8vn5kGMAxKGXAL/z0i411EmaVPGIKS7vkyG
 kTPPQ0ROtVWhwamgcY446Ta9OHjbt4iUvTLMkUzDkl4tZXfNGV/Ve2UYNBP9AhObhUxG
 PJRFtU2JGYb7PqWsR59MlGWtWiYc8bDvN5sFk1ZM5cX5Qt0VKt0mIjhDUHQDG+SPyZyk
 cZAvFeY91eMExm/aUtDdhe0w0XXuAaCE6R2rXlQMKn6KhTVpW7VkFSLAoPzZbcusCbEU
 utYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791098979; x=1791703779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MwfDJHjDBFDCIZj1c4Xf4y4GCGqkHkL+PFUd7yAaTts=;
 b=WmvX+oEET5pQA7JQDA8t64yThYU5+13Ck2SWGnyvGkIn9NqchYZoKZFz3SC8UwfrU4
 44pNxcwVBSUxnvfkGI4b5WT/A3H301EASk+0iq3Ypx+Ew0WJ9p/69TZzW+R3pPKRqDLT
 w2k/ToE6qIjMXcM+Bm5zt/W1a0WIe9n3dPbRKx97A81mhreV5/su2Fpj6OQhOamBtnug
 +6TxMuIqNcl00EB55EXjMgUrP/eKVumVG52GCXUjVe08TgsIODpMvHYS8Aehsy1q9lpN
 js9GwTf34+ZFHWfABuERFYmne4g+A1BTIsNzl6FetpDc6pHBCzXA02jLmywFTBmrZ9LK
 z4Kw==
X-Gm-Message-State: AFq9FYJKInb++BnsHLecncWK6/xLH2drrzmEZucUqjgF/lqp4am7gO9E
 EaTgJOsUyRQ1k+8jFLCZWThPZ0QejC0JKFdg1Cy13qZ13Ydr9jcK4VmeLETG0VeT
X-Gm-Gg: AYBFou3TAI/aQ0DbbRV+4coar91pjSOYwcWNoTkdCDZV1tmRhZFBIqW3pzEdKRSPW08
 U1zqKHyfxgng/mpZcudM1Hfnh4id19OLMoxQAk9BxdsVn5afl6Ro6Q0ELn9kgS3b2smoDx9kwLw
 y20eGcoaLZ8C80X19kY6XYx6YuU3fcA6ZjaVct8Js/ZDAtP0Kqjh1kk469L9fUnW57Zingam35T
 XNmsYm6ecWWiDsbDVMDjKOx3mRfZfJAUqkT9yMGRBWfG2KMnfTbkWsi8zuAe3+d94B+e1WpJmEv
 WGun/48LOZTVY4QDbAAe/dvBFqWwwXXAUM/6wA91vt/9Az7Btws+P/dMm4nBtsQx7Pw0OLJYEWn
 biCeCfRrWM4HhChPxTNr+iRozii7G3gmsrY5qEOhD650jdUDmT7al35SmdUVMMIDAF+aVGvXoSa
 mI6wOQ5OB/o510cD9qweIqMxTRP6AruI+3icYLCV2HCXDfwt+9M/yeUN8POa4T3bCNbymcGYqzs
 HXsAeNPd2kDan1jdQ==
X-Received: by 2002:a05:7301:9a90:b0:34a:586e:84db with SMTP id
 5a478bee46e88-34f14f0b781mr9302984eec.2.1791098979176; 
 Sun, 04 Oct 2026 00:29:39 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-351270204e0sm3036770eec.1.2026.10.04.00.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 00:29:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/4] Revert "target-info: Statically initialize target_arch"
Date: Sun,  4 Oct 2026 15:29:23 +0800
Message-ID: <20261004072927.1142-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261004072927.1142-1-luoyonggang@gmail.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This reverts commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.

Fixes: e934c624f3 ("target-info: Statically initialize target_arch")

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target-info-stub.c | 2 +-
 target-info.c      | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target-info-stub.c b/target-info-stub.c
index d121b8c017..4a8630b5f5 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -26,7 +26,7 @@ QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
-    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
+    .target_arch = SYS_EMU_TARGET__MAX,
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
diff --git a/target-info.c b/target-info.c
index 012b384036..bd126613b0 100644
--- a/target-info.c
+++ b/target-info.c
@@ -24,7 +24,13 @@ unsigned target_long_bits(void)
 
 SysEmuTarget target_arch(void)
 {
-    return target_info()->target_arch;
+    SysEmuTarget arch = target_info()->target_arch;
+
+    if (arch == SYS_EMU_TARGET__MAX) {
+        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                               &error_abort);
+    }
+    return arch;
 }
 
 const char *target_cpu_type(void)
-- 
2.55.0.windows.3


