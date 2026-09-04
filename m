Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5AAC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQ9-0001YA-H4; Fri, 04 Sep 2026 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ8-0001Xn-38
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ6-0000e7-Db
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so11438545e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526405; x=1789131205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RCBCqNf55K7xHMoHzaj/l3Ean3qG59R7LnRcJutki7o=;
 b=EOMty5P5aEe9kFVcI2eUGoQQFaaCdsjHFV9FW4qU8HLkxeN9GeEhszkH9Bsq8BGPa+
 hYQYTdqTt+obobieQwZxunOZgOh5ixwBJPnCezl6s5zNdFR5H91LStVU+dnEkYd9GLVE
 2xIuf3YfAVL/xcPmAmkPF2D7xqsANlVaoh2Z3mTTysWiifKc4sWEj2gB16Jc9AQN0SpY
 dKbyqkV14w45vJu8jbvmrEPGFNJUfspZRiZ32ZMGzTq4kNR7sK3od1uY7IO8ZqV2hYJ6
 PdnYLGAcU7q69PXMjvKZpCnBcm1ktU4uZuc6x/Cau28snTGeGvQximEJ54BDp4PCY4s0
 WnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526405; x=1789131205;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RCBCqNf55K7xHMoHzaj/l3Ean3qG59R7LnRcJutki7o=;
 b=Bs1CeIFZ4bO4FHpRCg1TZemVostKtdpnibp8HsJpt20wPreV7kTBV05Ud1NnL3k1Dj
 G6sWG0KcAsAReBMdAW1h20sc5Af8YwxqTMemA/QJmmqbvAV9BP/KVVDIjwuO+LRgJbGp
 g15JktcxptEA81fqQ8HqW8goSVMk530M6y/BFS67AB99Zrx/HCRYpbMlFbmJ9B3BH36G
 euX91zYsRNKSYhO7mV/SDIrt/09/r9bEE7lcL1HWJCehcdb5TXuZsdURcaVZY9Xsho+w
 TJAVNoEZf9Kh5ee86svpwQBooE3Ml6RHuhd5CfbI7ovLg4KpvbF5x6jx1mmLpCbe5qrk
 mzlg==
X-Gm-Message-State: AFuF++njU2EcSD1kV3m68b/gg+QKw/8qJ5cQbxAgRL4A5YgDXiXLikLr
 luCJIItgX0Jv9yU+dxK39Jr737v46wsbO/ZhdUYW4kGst0QFA7CG8cPQ9njiJR9hhIE=
X-Gm-Gg: AYBFou0+EySjlbF78udnWUwiYwLkhOuQMIbH1rRRmx39NjpuFXYOpUnobpG5wVv673h
 1MGqHrr5u4UMFq7OlCGit9Wwc4CVomDtaVHq74WZrqnEWztFiSgVS7d+vTDjbkDit17J9fbFGGG
 mHIUBcCa6+k7lMvnuKF2Q92rsfL/qewR+xDH2QIZZszAkLwpqaJT/ec7+SN5iVZtQPlscMGcON1
 Gb+edEAeiS2wmg3qofhw0dcqhGmzp9V91gThqwUvJApfIgYq+0nU9w/arpIRZImlmKWRMhDSkGf
 Zt5/+MHyuMKzCS2yN7G7I6wv/vzdixjK7jZXB/3f8Hh0hTpAs9N2Ulnqgp8RhX332r3hb8V1qXI
 goGLWApU4CieCrGvHQ68Jh7GZxuACDBNj2f7mzkJ/bURQTpsE829XinlBzAIfyIYvoTIrKI3hZ9
 a4yHPUc1rj+GS50ptXonN36LD7kwg8QRULhdyiLSkqJiVpHK14d7AewShGmgUb
X-Received: by 2002:a05:600c:4e4b:b0:49c:f13e:e50 with SMTP id
 5b1f17b1804b1-49cf8925f99mr42441115e9.13.1788526404530; 
 Fri, 04 Sep 2026 05:53:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771e9absm69124345e9.9.2026.09.04.05.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 56A44613B5;
 Fri, 04 Sep 2026 13:46:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 093/105] tests/tcg/xtensa/crt.S: align .text section
Date: Fri,  4 Sep 2026 13:45:47 +0100
Message-ID: <20260904124604.2207440-94-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Needed, else we get this error:
dangerous relocation: l32r: misaligned literal target: .text

Previously, .S and .c were compiled in different steps, with different
options. Now, with meson, we have to provide a single compiler command
for all the files (no intermediate steps), which is a *hard* requirement
to save user from dealing with compilation details in arch files.

One consequence is that .c + .S combination gets
-mtext-section-literals, which triggers this. Easily fixed by adding the
.align section.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-94-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
index 909872cd385..de8fd8c1cd7 100644
--- a/tests/tcg/xtensa/crt.S
+++ b/tests/tcg/xtensa/crt.S
@@ -6,6 +6,7 @@
     jx      a2
 
 .text
+.align 4
 .global _start
 _start:
 #if XCHAL_HAVE_WINDOWED
-- 
2.47.3


