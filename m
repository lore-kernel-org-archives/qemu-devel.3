Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975ACEE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh6-0001pE-1B; Fri, 06 Feb 2026 16:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTgH-0000Be-83
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:48:02 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTgF-0002oK-HM
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:48:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so16894455e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414477; x=1771019277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xX3OzH+aczthwEYCbE8Ln4rdrjKtAZElQmwQMIWYpk=;
 b=AcXdKN4xRyhRthHzBxxeWdfQVL1yBbo7zBAQ8LBmFJ8qD51DslI15l7Y0I08oQGBWb
 ZqQBpDv+vgnEFjBsOxoAjZo2o0XNnom2vMCDFLEnZZsonPomtISZxgeGavKv4+4cmtpp
 DG8PqwK0ITOy/Kn8Q6GP0TsZrRWXWolddj+27TE4rJKPlUFxT/H9W4PYMwlj3cnl/Po9
 7rkpVUgde5gif5ejiHAfj0yeovV7Vsuoev5o9GWGzc44DvfsTubhiE8G1UiUHsDExkSv
 XBW/go8LuO5wJQZ1dd3gkSuDMpE9JQatplLpOavt811gGa2kSHqI9xPNT0SyAfTr0gBn
 t0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414477; x=1771019277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0xX3OzH+aczthwEYCbE8Ln4rdrjKtAZElQmwQMIWYpk=;
 b=SqEfro/kcjv5hWIeieYA5vscv6l4Nv1Nag2Zdvbmi6PirXrLmAUCVhXk8FM44uSHvY
 S6E8adyS2Q+kQENDPLfKPRWbLozX07oVKSvl8BgHPLbbPc6sRKPkzTE4dE051JGtPCut
 JYnVLnAZiPQhUDqobqUq9Gdkeb8/wxNLcFhr+uzrbO61qM67xGo1kSYHRfiB0P44TrMV
 9GC3Vc3kU7Ccqi9ed8RY4HqcSHO8qsPm6tn4jlXXUgaCK2SJE6P8/hR6JvkHXRbi3j1b
 PeWqC660RbwXA/XUEPL4h3nitW12khHfNypbrs1TqqiX5Mt4zuVWOqUbUVQxPfE1J3n9
 dRnA==
X-Gm-Message-State: AOJu0YyTL8xBCEy9A2ISUXYcN1Ya+Kkf0KfoY24XiiSA2qgOi+MxwRhF
 9mQMAXKCi1KZmxZ7uYTjpWm5FcUdbYtsDNjPECQT6RRBoqMCdHaC0p59vmVR2AYMD9xmMIRMWXJ
 /MdlEg10=
X-Gm-Gg: AZuq6aKzh0/nUGcGtc1KEi/T5Fzegf8Aj0FIDSDJc+eWQtd9eQJ1RQXc5F3eBMtpULg
 DtnIepuLFlQGCSAAwMB/zn+Yi5O5f6dNcsnMAqYsoe0s+PJ4h+Yn04IDdvcpyjwW6ojHz2HkSCQ
 zhyAJFeyvEOc/Dnc8rPCw6gbQD/sHHwuF9jmLzWoOjJFgK4Ssd6XhtbChzBmEurEPT35dBcmIJo
 ycrvkikunuKuXpcPZBpwBELrVStcrCwgWGbDR8IHqD+zQEt6mGO39rRFPMfiwTCUomwaqTlz33t
 yYTFqLiTh25l7nGCfni7w5WWngDUndyhVB80s8rmG/AE3z2WNAp8drVwzSvZIdEt/96eTxpxY6r
 8KP0Lc0rcyrR/dRP8fu5r9Y5wSRUdloaeljP9rYrzDrfdBZOk8GwqbWDWVXENX5OfBsU5U0DpCL
 b8HutqbStbuHRbDAQlikAhJvjrnFT1bEZxFhtRDDXUrEx46kDcGzfm1QN8ESMGe8ngNwm3jTc=
X-Received: by 2002:a05:600c:8116:b0:480:3b26:82c3 with SMTP id
 5b1f17b1804b1-4832021b549mr51593325e9.20.1770414477368; 
 Fri, 06 Feb 2026 13:47:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206d87c7sm70472395e9.7.2026.02.06.13.47.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 28/30] qapi: Add hexagon to SysEmuTarget
Date: Fri,  6 Feb 2026 22:44:46 +0100
Message-ID: <20260206214448.22008-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260205030617.266625-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 907cb25f751..ef8575b6eb9 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -28,6 +28,8 @@
 #
 # @loongarch64: since 7.1
 #
+# @hexagon: since 11.0
+#
 # .. note:: The resulting QMP strings can be appended to the
 #    "qemu-system-" prefix to produce the corresponding QEMU
 #    executable name.  This is true even for "qemu-system-x86_64".
@@ -35,7 +37,7 @@
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
              'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
-- 
2.52.0


