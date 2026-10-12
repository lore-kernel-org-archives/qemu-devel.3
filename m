Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E928ACA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJSR-0005pR-O9; Mon, 12 Oct 2026 13:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRW-0005G2-I1
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRR-00078m-Oy
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so14607545e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824638; x=1792429438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gtJIuiD6IgmZZ6Fngidu3aK7yzPsm3ikKpy/MHqPRF0=;
 b=vMfs/XnHF74NgnQR98+hr8C/5vKj0ohjchKUOxsUUbmfUB2HdN584a/5ta/14vtl3K
 L3dxu92lLYOVc/E5LfyWRxvfiiYMpm2dfer9n0HOm8vhO2Ii5nwGT9XuWiP78urLZMz+
 asqKstTovTyfDfIMGm+27elGeH4KI3H3YB0CdFpMbqMlxVYxU//EobqdJjlgmZd/2ltb
 6pJKzmlz6px6VleT1QY/aupxKGXsv+Rm9jC7UZg4nkckYwWdOAJkvXci1zEW8Jxstsyi
 DJm2qgj0lqJ2kYvkM0EQA5X0kM5nrCz+GDdj3dYhQHUFBYUEFrKy7d7qZXmUhU/NLbaa
 mRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824638; x=1792429438;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gtJIuiD6IgmZZ6Fngidu3aK7yzPsm3ikKpy/MHqPRF0=;
 b=Z1coP2WC5ntRWqHjrIYO63x/xHNeNQsQuGTaAZq0JSiyv/+tu1g6qYuvDJMY4+Ugdi
 zvRvn4iRHz92nMWMQ3Z3tbEmJfwO2sjLvbAlqtelX+JUzG8YIB3GM8RSjoh224imCmwq
 UvhRA0vgrUd3hN85+2Y8tTr9Fvj2dfMKryJNIn7hCRU/0BrY4TtNy2kUr3FnT1EZGHy/
 gyL0k07tiu/9XOMpaF4btUdxxr01djPZ7dB/PWVvpDP6CXU3M0gcyF4VlpfLYmkf7Xfq
 yZs+CiXegYL/qBm6Hj7H3l2pPcZDidb+GDEJSqllHleeRrOHI408R5iYVqU71MUuWMGZ
 zyGA==
X-Gm-Message-State: AFq9FYLS1Pl+2Ph+prUrYysKbUOssexsqatcvO+Rl75g1gt2UPc0qqP2
 neA1PmKcG9wuU1++7+ZHfeXw5SAFxLr8rYaua4r2ydjNXLZYfuj2wxSa1ONPtq91+OY=
X-Gm-Gg: AYBFou1oVQtdEL+UR1yzqSvk1an1QqYOiiTLTCPY8BXvpUN3FXcT5J29YDmAVTaMp0S
 3OjQqSe0W96CTCepiwFgurSQILou5LqBikjxBD062YeHlOdj30/1TwUvduJ8MM1k5Y46g74q0Ov
 KW8jxMExLQTwF8DFRx5CHpb5WmzW3ujRxKNS9yi7IkNh1tQ3RsoMUFR/kY1gC3D4Fr1pg4h2poC
 7na9s0FDfT0GvzdpzNNTMHi3c/XsNyDj3feZneLuQd5OCJlXeJc4tMQGyysPWM5dpgq+cIydXha
 bQOE0l5T6KIUbXk7VSyOg0ZyZiJkDvrJtDwJTXbiCB+iwPLElPDmqyzg44S1BgEBIbaoc51t8Yu
 rAe++quBW3bBQuwcxJ1WM8cFfbZTFBkVIlFeVljOZCK/QyJOU5UVGdGx7+J/UIbJVz5nV8X4qtj
 URjwuuFGi4FTPbi+O0tewJH/UwR+4xjJVNVECpTWsEJuOJVu+zhhwCzCdBbJ46n90qkVWcKg==
X-Received: by 2002:a05:600c:e549:20b0:4a1:96cd:2f6d with SMTP id
 5b1f17b1804b1-4a196cd3280mr78655585e9.1.1791824637776; 
 Mon, 12 Oct 2026 10:03:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bbbdd75sm232040225e9.1.2026.10.12.10.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 247326086D;
 Mon, 12 Oct 2026 18:03:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 11/16] tests/functional: split aarch64 tuxrun into tcg and
 kvm run
Date: Mon, 12 Oct 2026 18:03:25 +0100
Message-ID: <20261012170330.1144446-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Add an explicit "kvm" run to the tuxrun tests. Although running on an
aarch64 host would probably have defaulted to "kvm" anyway we want to
exercise specific features later.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - pass "host" cpu type for KVM run
---
 tests/functional/aarch64/test_tuxrun.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 7dd50c3de17..0ef1b126fae 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -32,6 +32,16 @@ def test_arm64(self):
         self.common_tuxrun(kernel_asset=self.ASSET_ARM64_KERNEL,
                            rootfs_asset=self.ASSET_ARM64_ROOTFS)
 
+    def test_arm64_kvm(self):
+        self.set_machine('virt')
+        self.require_accelerator('kvm')
+        self.cpu='host'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARM64_KERNEL,
+                           rootfs_asset=self.ASSET_ARM64_ROOTFS,
+                           accel="kvm")
+
     ASSET_ARM64BE_KERNEL = Asset(
         'https://storage.tuxboot.com/buildroot/20241119/arm64be/Image',
         'fd6af4f16689d17a2c24fe0053cc212edcdf77abdcaf301800b8d38fa9f6e109')
-- 
2.47.3


