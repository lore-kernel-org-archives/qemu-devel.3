Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5CEEE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQRx-0007o2-6x; Fri, 06 Feb 2026 13:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRq-0007mU-CW
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRo-00055O-Tn
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:54 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so8871475e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402050; x=1771006850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApZj1/uOnPVUnEhnGSPBwrshtRIOJ8WxMqGa4plL9Zs=;
 b=L3RyOIpeu4T3IAGixkepsWIJ688gW5WofNn9SscTxLhbQw10bMWAP0/Bhh5CJbJ0rQ
 3WlwM1eMG8FWs8+VEmM0Fyg96vwythJN0bqSSdoKyTxBt69ZbbufgPJVxKmOBnF+b/nn
 bw84v18/3YzlFzFjb6dcis14gUMBS6sftprFY6JaMe5ERA7Bj9c5Lc0CTvsb2mTrD2gO
 HukOc4Zl7YpH3BG+ZscAvPaR8ugBJqLEXyvvHhGRJuYjT+sRgDMxIFPDvnGTV85+BljO
 WbLw387rbz8JKn/4uLnZn3doWUwBtoaDWNzMNGYPi/QVByZialBdxRIstsyLG+dk0nYM
 Fz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402050; x=1771006850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ApZj1/uOnPVUnEhnGSPBwrshtRIOJ8WxMqGa4plL9Zs=;
 b=CGSdv2HSqasX2cSStdAr3NSLZZkAgv4wI1AV0Q1nS4zF3c1KftrpxzBuYxUaUg+FlW
 quyKW83Zof0mJafYRbiANC0hI7JMWLoX0n4HkvJgvHE7nRStwulE0QpfJL3Bg2i5QS8D
 KgRAwgGHdBLDisxrumutyF252+F95VWPNwwQuuBKdh5B5UFY3P6PjdNxqygaXdwuw1xB
 iPXamlG0egcU1OT9Bmuu6e8GYMlNg4RAF93IZeT4PxSnNCA0DpJHJKaE0yJ/IHJWLH4y
 /IVPDL615KyHPyTpYxPF2nWIVxP0AUZ3P5fSecS1GQOlvO9xcDatj4sf7REFnYzPG/Z/
 cCtQ==
X-Gm-Message-State: AOJu0YyML9RrWuRsqzpFThSrHjwk2Cc8SopvoMtD7a1aWwH9ht02wCUf
 sj2Du5mzGaDpd5T1cN5tyZqVdFPYU/vAT58BvxKdLdxkPE8Pwg2hlQv4o23jjQ6DRbCA88a1E7x
 s9zDd8UY=
X-Gm-Gg: AZuq6aIz2dR1I17V24m6tvsg39ofRR8QawRH0u27pROCXDMfH4mOHbx7g6Qkxpzk1XA
 GwXfsdXhrxUEPZjt4a6QnD7RGwWbCEO2C+pAvXCFOEce1sXyL5uuVX2bD4YQwcfsgTKA0BsRLqJ
 1Fs5ZPQAHzV7KF9y8Vvku9qxO1Xf/1jGjrFOr8uhaeE57j84PXWpogi7+iUmMl7maLmHV0x3JqM
 n+3Te/LXJ+niXpJ1vJl/SkgqVM+CRZanyvgYuspQ+lzpKNeEX3uv1BbjiImHW6xp2njrHEHEEP3
 T3tizNqgxbudlgjm3IzjlknzyENdiXKLtvDTsaH6tiJsj6IZsHQ0TjeeP0c0HlSsuAj2svsYPJj
 Y2Qdmmle0jA3AtKzHteQ2deAFsA8v3Hmc8obhwuJaxzI12HM1u7I8Akb0RPp0YhzTRfUIWy05HB
 t2JoSZcnXQ7EjlGPIlK4t+YhGRL7OD43oG4UVRSxPYWrEF1FD++m4djwLYNAgH
X-Received: by 2002:a05:600c:1f16:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-48320227d98mr56790005e9.35.1770402050316; 
 Fri, 06 Feb 2026 10:20:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320719bd2sm64294185e9.11.2026.02.06.10.20.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:20:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/10] target/s390x: Build system units in common source set
Date: Fri,  6 Feb 2026 19:19:50 +0100
Message-ID: <20260206181953.18683-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Except the ioinst.c file which uses the TARGET_PAGE_SIZE
definition in the ioinst_handle_chsc() method, all other
files in meson's s390x_system_ss[] source set don't use
any target-specific code. Moving them in the other
s390x_common_system_ss[] set to build as common objects
ensures these files won't use any target-specific API
such target_ulong / TARGET_PAGE_SIZE, thus forcing to use
the appropriate types instead (such vaddr, hwaddr, uint64_t,
...).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/meson.build     | 8 +++++++-
 target/s390x/tcg/meson.build | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 3b34ae034cb..096b7dcc42e 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -20,10 +20,15 @@ s390x_ss.add(gen_features_h)
 
 s390x_system_ss = ss.source_set()
 s390x_system_ss.add(files(
+  'ioinst.c',
+))
+
+s390x_common_system_ss = ss.source_set()
+s390x_common_system_ss.add(gen_features_h)
+s390x_common_system_ss.add(files(
   'helper.c',
   'arch_dump.c',
   'diag.c',
-  'ioinst.c',
   'machine.c',
   'mmu_helper.c',
   'sigp.c',
@@ -41,4 +46,5 @@ subdir('kvm')
 
 target_arch += {'s390x': s390x_ss}
 target_system_arch += {'s390x': s390x_system_ss}
+target_common_system_arch += {'s390x': s390x_common_system_ss}
 target_user_arch += {'s390x': s390x_user_ss}
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 515cb8b473d..17c9374d09e 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -12,6 +12,6 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
-s390x_system_ss.add(when: 'CONFIG_TCG', if_true: files(
+s390x_common_system_ss.add(when: 'CONFIG_TCG', if_true: files(
   'debug.c',
 ))
-- 
2.52.0


