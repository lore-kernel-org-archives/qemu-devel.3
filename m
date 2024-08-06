Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67FEC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJj3-00054t-98; Tue, 06 Aug 2024 08:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhj-0000TS-Ew
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhh-0000N2-H5
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:19 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so54930866b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948855; x=1723553655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMm3A0DabsjolGXhyPhZ1sZzpOJXfaTPvfWzaUzLVvw=;
 b=SmbFAtbBPrGEkMuqRRb54s1Mewcnumej2DweE3kd3GdlqyW1uheRnTWocWgZHvBPbj
 2YvBY5T+24pigPU4uJoRzPfbmWwpcWdTnO0OqaOeNQSjz74jRs2kMOGRRfOemwVuphYh
 756EoKTqB/+jk2vgF6b05Gc7EHDly/PxF6p9G5qSmh2nQaqLJQ2O9pj+ITMTfL5yVKi6
 EoZVpgbG6cmUEdDWff5jcHtM7p8SwxOr6D+S/c8lAMOQsFJ+0k9Sgi8myjfEKlWIw8VG
 /gP5syLzgR38PUNIVhLp7q+eeiBtGUKMGxv/n+kmn3nsNytHpiYXeUaRAS4x/QKexbFQ
 HG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948855; x=1723553655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMm3A0DabsjolGXhyPhZ1sZzpOJXfaTPvfWzaUzLVvw=;
 b=p4mQlJBJS+xEsoPDd4JorTAXV6vsN/HnOk8QRWplEnLT2SVoo7fEEvduK/ryPRNSo7
 Fj89u8UVTC94jBvuAqdc8PIOtlC0r6WejwwpwOtmtY8scVYsoVTuvlEdimwu2V+STUdU
 uOnsXM85JgQZ5ISkl05s7L6rgBH2RpQRE2V9JcGjsqwxIizafr/U4j7LzuVpsZ1vWUgA
 eBhtSjFcsAgwukfvvGC98M3+gd9ozgikMeWnY3CYwQp6g7EK7Aps7P6tL4B1oxX3ZKWe
 sNcAp8VYvKpBhh8ph7h67SAY53Wrr+NwnZzjdg10RASvEkQLuIYFMMXX6Imb8eSrCMZi
 Q9Nw==
X-Gm-Message-State: AOJu0YzSCl1bX2nMfdOHCX9prx3pq/QwoIxcU2oAIGqaz8dOLspB2zUk
 oFJ9NhrEECMsJ6a+s2wID7IYqiZUvZz0VqGPu67abQ0/tkW8g+QannIZYy8Vc4W0Xrld7A0xzzH
 D
X-Google-Smtp-Source: AGHT+IH24eR79lDqIaE2q6DNcV5o2zg5AdeRNNb2Klp0VvlkZeCQ8kqmCVHJWCRJCsLUmt8xuxUqZg==
X-Received: by 2002:a17:907:724b:b0:a77:b516:3023 with SMTP id
 a640c23a62f3a-a7dc4db2a1emr1035988366b.4.1722948855304; 
 Tue, 06 Aug 2024 05:54:15 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3c7asm558455666b.14.2024.08.06.05.54.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 22/28] hw/display/virtio-gpu: Improve "opengl is not available"
 error message
Date: Tue,  6 Aug 2024 14:51:50 +0200
Message-ID: <20240806125157.91185-23-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

If the user tries to use the virtio-gpu-gl device but the display
backend doesn't have OpenGL support enabled, we currently print a
rather uninformative error message:

$ qemu-system-aarch64 -M virt -device virtio-gpu-gl
qemu-system-aarch64: -device virtio-gpu-gl: opengl is not available

Since OpenGL is not enabled on display frontends by default, users
are quite likely to run into this. Improve the error message to
be more specific and to suggest to the user a path forward.

Note that the case of "user tried to enable OpenGL but the display
backend doesn't handle it" is caught elsewhere first, so we can
assume that isn't the problem:

$ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=on
qemu-system-aarch64: OpenGL is not supported by the display

(Use of error_append_hint() requires us to add an ERRP_GUARD() to
the function, as noted in include/qapi/error.h.)

With this commit we now produce the hopefully more helpful error:
$ ./build/x86/qemu-system-aarch64 -M virt -device virtio-gpu-gl
qemu-system-aarch64: -device virtio-gpu-gl: The display backend does not have OpenGL support enabled
It can be enabled with '-display BACKEND,gl=on' where BACKEND is the name of the display backend to use.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2443
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240731154136.3494621-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/virtio-gpu-gl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 952820a425..29d20b0132 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -106,6 +106,7 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
 
 static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 {
+    ERRP_GUARD();
     VirtIOGPU *g = VIRTIO_GPU(qdev);
 
 #if HOST_BIG_ENDIAN
@@ -119,7 +120,12 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     }
 
     if (!display_opengl) {
-        error_setg(errp, "opengl is not available");
+        error_setg(errp,
+                   "The display backend does not have OpenGL support enabled");
+        error_append_hint(errp,
+                          "It can be enabled with '-display BACKEND,gl=on' "
+                          "where BACKEND is the name of the display backend "
+                          "to use.\n");
         return;
     }
 
-- 
2.45.2


