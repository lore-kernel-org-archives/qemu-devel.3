Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15ABC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfMl-00054P-2e; Fri, 20 Jun 2025 13:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLG-00029t-4W
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLE-0004ZP-6A
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso23783765e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439750; x=1751044550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPJSNIxbqzKOSf4D3TkCziYLBeocw+mnHZA8vqJidSM=;
 b=GgPy48lcrL8sFbKQvxwn6vYoYY0W3RGL2asCr/c4j+B02yN+Gh4NE8gGCo8ArYclvn
 24SaAl3hbeldxHfXCfJ5JrDheTaRrwJFrW+g+p0gOX/t1NBqvxA8APPrCY9XL1adGqo8
 o3PSpHVR66N8XfykpWP8yGb9pn6ME5QDP2t7O30QfLOJlUidW0uCC7hxb7JpyGCh6sDE
 KMRV+a9kI5KjlKRg07yQvTZexc8jy2+ywhAisaOI0/RJ99O6J+I1yiGfYntpyjNs50/L
 UmCcN5JBs39GmqGMaDWnHkTWmzCRJwoZ4U36k3wX7ix+FC3LkHlzxg4UN9Xo8XmbBImw
 6ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439750; x=1751044550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPJSNIxbqzKOSf4D3TkCziYLBeocw+mnHZA8vqJidSM=;
 b=llDLbwewBopGr4PWj/6eHAcxEqEihWaMg4o/8auWhOv6mhplS/uF7rSrcJy3nnxOJo
 198q6PGKwd0YNts12BsFcfrNrLoduc0gPfEahX7L4ylqcdT1hsKThs3HHbIIvkKQDois
 qh8BWKMJC3u3liixUl1GSaoBPetn0RnpDs4Kz+O319GvEDEdby2NcRUJ8/yi4hHqEObB
 6vuYEIr1RjM2QGbVf0TwDsYRqpOO/NmFvTvkqel5HeE1vKmmu1z8ae2cHdWzXj3NzAg6
 e088nYoYzW1BeYS/Klxo7XQ3Ms5AztsfPr+i9DkD4QT4kl7rZlvC9V23upEwYml+AGdp
 IRcw==
X-Gm-Message-State: AOJu0YwmfPM0o41syovrTT6keaAVofJvCZVVGLJE+IQQG2mTcWNidqEd
 IdzjxOhwh00yRGFNMXidMI43GdqtJ6EoEqEJzC1sZqsZprMcF8kO5PyJaiIeOlYtRlXkivWsOkp
 pu6iE618=
X-Gm-Gg: ASbGncutG0L/2lJX052WcVhDWS8t1bkVghzE/sW5yfUdvpIFPfD6jp7zaF8udvrzALw
 dme+k4gqFj34MswkSp/Q2K21dx0vPV5VNwdb3mDZN11vnLF3jmbEFUMjV+nRmexM2yOCk1wIfal
 7fSOCC5WGRS9pvC58UNapH4hRxir0upVplBQ1jAslpC8+y08DzyqvPzsXb4wmkjWDl0r23afdTK
 Go4G54PCUKGxkuD+Djs5VUqu8EDbMMdfTE56xdlZuq5y3f+wjsilzIODwM2omm2nJpY4Gv5VkID
 yoZSrP7URM59kZQrPnvaghz9tkHXe9c5JEzJfSNM+Nn5tUHKvUwCoj2VgphU+hrV6oKrL4eDryA
 qC/nfu1+NX6LErlJxb4Gmlv5vcYpxOLC2pCgm
X-Google-Smtp-Source: AGHT+IGuf27OP7fKC7iXwo5V6a83W1vl1YhCYQcU4HVE3+1OgEtm3eJUA/kvR2xT9rv1TOQffBoD0g==
X-Received: by 2002:a05:600c:3e19:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-45369d6bfe4mr9408855e9.30.1750439750404; 
 Fri, 20 Jun 2025 10:15:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebcecb5sm65655875e9.37.2025.06.20.10.15.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 26/48] accel/system: Document
 cpu_synchronize_state_post_init/reset()
Date: Fri, 20 Jun 2025 19:13:19 +0200
Message-ID: <20250620171342.92678-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index f40098c1c92..b1b9dce27d0 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -43,6 +43,14 @@ struct AccelOpsClass {
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
+    /**
+     * synchronize_post_reset:
+     * synchronize_post_init:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers to the hardware accelerator
+     * (QEMU is the reference).
+     */
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
     /**
-- 
2.49.0


