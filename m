Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC521EE57C2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzV-0002QW-Se; Tue, 30 Dec 2025 16:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzQ-00027z-EN
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:48 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzO-0002lx-2S
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:48 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so6064692f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129044; x=1767733844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X7ibe+zOWYAfY6rtdYT7opXCQK7sUSxI1ZrKDvOBvKI=;
 b=lS7CIZ5KLrVdPV7fIhbyPsHD7JVg+wA2pAXNJCclBQ7jSHWXRNdcIoQJorFmFMLmjy
 BG3sM/cDUdggbiEVpGNhZLl4/2n8BPL26ld0pFIv+pI1L8Tn3HZzutKRqgqLEuQFodPu
 ov4L7ui38IBBpizZ2VLGq/Q1yGz75d5N3JsS/U0f7PnMngW530yCEKdIye9hJdJ5lx2I
 9jL8BZ1wlrmq7wFwWTeCsj2yb7HUhoURXokNx7Qy3B7lcam7sR4FNsajKkFjjIIEgUFF
 hL2WvYkr8fQ6XscTIhr3t4wde7r5PQgwCkRFuN5Zf04F6byXFB8L3P1pLnvRwMkVYOL7
 lEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129044; x=1767733844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X7ibe+zOWYAfY6rtdYT7opXCQK7sUSxI1ZrKDvOBvKI=;
 b=tE2aXso5XqoBVCUewWQULxaCZb5dPviwdQhQHXzQcfrnyyu+8dzz9rcFqcUrJGwVTq
 e3V4Dfy5egOtzJRKBRljHRVrj2q4jfm9QhZBkQfv45aYaEH+zGYg686REyywS7HWjKsk
 4KbQHOr7oWDkAYkdAbFVfOj9BgynT4MwrWD7Hon4OI4bgz+r2908c8zDcaauw1XMFz2i
 Ow1NWcEyun1CvOBV+bUu0dwGwh+s4UP8OkTtm5mCSNpIgQVJj4Z0mpjlQdl77FtCLT0b
 HkwpPIsQL1wH6rh29ROwBbC4JbOHMfkctYwGQsFgnDi6mYNUUnhMaFCoBekXdC32QszY
 eU4w==
X-Gm-Message-State: AOJu0YzeOEMU/XrU0eFQ0xwbthQK9WvneS4gXRm8KU+YlfPQ1uj5rtr9
 EU/uikr7W3p6bB0AzlWpGvH28a9GEvx4ioUO9V1nGIx/QdYNEu2VUdXyDYu9MiwoVPrTvAc7rNh
 D7AFCOwM=
X-Gm-Gg: AY/fxX43yTHP88dYfMqw8HIRvdiBmPfUyhpqb6TeDsiEEtqG9L5tIR7SKXScTjSJew0
 yffkWljY1QncKtyirawxWMc+gCUBeHNoUH5OVEKw2AMB8rJlclIC7SCz/uAncx/gD3Eckp4njQ3
 urgt+7HRclfvj5LwAEu8iHap1w9tAD4P1Ph22vyqeIDLIoB378/tE7bWdVxSnFq5v1ElJ5jGNjv
 tWIOWou3X2/zbQFlsYuTOfvsVkzXHgxl5HOj4kgYc7rBkgUdxpaXSuRcswLz0aC/jNLksgkx+TR
 EvorrxSK197R/rAP3mlepJWBywmdDHj+EeYoiwnEW6bztJNLPKCWY5Zh5627aNJ7UQazhuy2oud
 j692RHpGi+jbFV3aQucYQVl9E/XMFSvGrIWua5QapA31tej7Dxh6qRiQ4RFpecNMDbizEQ82zkd
 ZCfkQFFA2GmaPKyEsw53tSZDtWebR34qMR8EE/Q7+lUShKVJvIxVinggAsYSY6
X-Google-Smtp-Source: AGHT+IELipBGLFYyhF5cIgG9vpPnIgWYHDqmPC8eWg9Oqlx+xtxqO8+B/CRqyJwFGgd3TeFhXz64gQ==
X-Received: by 2002:a05:6000:22c9:b0:430:f72e:c998 with SMTP id
 ffacd0b85a97d-4324e51081bmr46269596f8f.51.1767129044302; 
 Tue, 30 Dec 2025 13:10:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325d10cc48sm60041048f8f.16.2025.12.30.13.10.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/34] configs/targets: Mark targets not using legacy
 ldst_phys() API
Date: Tue, 30 Dec 2025 22:07:47 +0100
Message-ID: <20251230210757.13803-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Luckily these targets don't use the legacy ldst_phys() API at
all. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
hide the API to them, avoiding further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224151351.86733-7-philmd@linaro.org>
---
 configs/targets/avr-softmmu.mak          | 1 +
 configs/targets/microblaze-softmmu.mak   | 1 +
 configs/targets/microblazeel-softmmu.mak | 1 +
 configs/targets/rx-softmmu.mak           | 1 +
 configs/targets/tricore-softmmu.mak      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
index b6157fc465d..baf20fb7f2f 100644
--- a/configs/targets/avr-softmmu.mak
+++ b/configs/targets/avr-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index bab7b498c24..cf635798c90 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 8aee7ebc5cf..52feb957b48 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_ARCH=microblaze
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 1c250a6450d..3a90f1b9977 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES= gdb-xml/rx-core.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
index 781ce49a62f..5e018d81068 100644
--- a/configs/targets/tricore-softmmu.mak
+++ b/configs/targets/tricore-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=tricore
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.52.0


