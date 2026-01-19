Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0604D29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufM-0006or-NX; Mon, 19 Jan 2026 14:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufI-0006mg-3o
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:52 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufG-0001Tl-Jn
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:51 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so31100985ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849909; x=1769454709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvR1Snlpk2uTlHbA8GXZk1IgzFIJTiP7/Ri0kDL87U4=;
 b=nPfwgSmawEpuoBgpf3JpG33ecbJmyGe69lqlGlnamfyITBwP2HGx4BrVvkeJsVMI7B
 2NiF/+SNuCTDXbd3j5ZeH6MNBy1X3IO69V9NkwXqcFgzWFhgdsoecKr3Vs0or4fwX/Pa
 40jSUSXGNSv3FbR6cZc305DSLmbBFs5XV9RkoB8UpBYzQk3AZbn84hPFCYnklxj7aTdg
 X1H3YBB9Yquh+JuEflQauGUWzvBiRDsC7FImkj5b4T4DciDSyke+9wOIydtSnWxlmD0b
 OPJx44nooZUfkPdnGXUY5p57oZ6CnBXtUIW27nva0P6ohO0pe663/XABkTJLqyUGb0Yh
 8DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849909; x=1769454709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UvR1Snlpk2uTlHbA8GXZk1IgzFIJTiP7/Ri0kDL87U4=;
 b=GbF6ohWYbgmtZ36JkXriPTqyREjQgbfeNPgafpY4VTic9SGBebzmx5ZPfZE9WSo7a+
 POtrHNsxsxnPZ/ukF4w42FrO/S0olg9ebvHg47xz1uJ28nvB1UNcxjNWUYAEIw8V8Jca
 VoJ0N1HiWgi0fB02+SDC8V81Bk5Dr222UznU4R2L2JZ+hFli2mHgsOp03gpWI+2JaDOj
 g6ovCZaGUomgvTDWlrBNGuCqTHsfgh4bnzTb1Mc3A8bLg4g2zfxsI2FVpqOog5ohA/ki
 BMEKEc4WnG3+T4UEZXRFtaQ4nUBSe2RSRoGMkyIeqmBMauqxvpBYd9z9z31Vq6fCbHuV
 i4pg==
X-Gm-Message-State: AOJu0Ywvb2gZv3eTUXSpkHjsNfbdjb6KxSii16GxEsOT7pQ5f24rdDAM
 MdmFXE2c3QqKLybQw/OM423ZGr9+PYyEuWNC2oQwqD5nZrzE/Td8kr6ib6LMnwKSCKUlizIBk6l
 rBUu+H3Q=
X-Gm-Gg: AZuq6aLTH7Mmak6WE5i0ptoLP1oeuhSjvHNMWB4Ju6NUW+zN+mBAEcKbNmXCG8Sahn/
 id+Bgo/D3lAoeJmA6GtWg+5FR0m8aPGu9SXkqKa0mSMmtiIAJaSB7qOBCKU5dv4348asiOBHI/e
 mO4Bpf6DZpkvQwyEhoO5+GYUjbX7Zb6+OY8KbrRaPi+FUpv7ESpVgUm415/B8nbwDEcMrPmedin
 RzXE4PNBXCLS+sQryBlPZjG2KWpvePfuEeUlR4LyQJvt3hg/42aPA4u13pes/WxAo050nteFhDT
 1C9iJlgjbT0tb6/4soQPFHJPyIGoXRfXhO6HGet6Qh/PrL7YaKmGGW3J+/ISkti9qIWqBkarKqL
 2Lt2LiORFw97xeIe6ZVwsWQd5naFob8gHRhs47ze8jDt7SLsVbS8MtBG4bX0msWbb2fiM3i5enV
 Kl40cDPc7ul98rnmVs+KnxQUdtik+bFjUPAS/jfCd1cMef93hjQS7q6ZT2Ib7Iz9Sk
X-Received: by 2002:a17:903:186:b0:2a0:8963:c147 with SMTP id
 d9443c01a7336-2a718949960mr118785695ad.45.1768849909041; 
 Mon, 19 Jan 2026 11:11:49 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:48 -0800 (PST)
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
Subject: [PATCH v3 04/11] plugins: define plugin API symbols as extern "C"
 when compiling in C++
Date: Mon, 19 Jan 2026 11:11:30 -0800
Message-ID: <20260119191138.811069-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x641.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3fa..e44f863d839 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,10 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -1210,4 +1214,8 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
 
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.47.3


