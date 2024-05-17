Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83673C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7z6l-0004wx-TO; Fri, 17 May 2024 11:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6V-0004uO-Sn
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:48 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6S-0005Nk-PJ
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:39 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e6affdd21so1969720a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715958154; x=1716562954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EqzMl8MHvvQIdbxxo0G9Us5dJc+dAGwQg0EfUlU33w=;
 b=aR6yVKyi1k01OxaYReXTHpXIn9A9R9e5pjG4y9MK41YmPKP4iLokXbH54nbYlu/GOj
 ff1xWzqsAapOsEm4nG8+9St0vqsde6ym96idQXL1iG3qHTz6RlFw5frnPNb99/PqTh+Y
 VvoCJih1c782juIuOOxT67X+XpUz08Q73OWGYnvmjXCL/xCuN6FlImulMbh21lRfTxTr
 zOwRRQul5/DwQjmF7MLEgUEqi3QxOm10ERaDyIsOjG+aqyh87aMFHxyGWUdX/MN3Dgr2
 vMc/YOoKCiXi2zq0lZM5MDN4fPsdSOy2cPNpfn32qXbJHQ17UBz0EXg03yCRGkDJ+kSV
 IJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715958154; x=1716562954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EqzMl8MHvvQIdbxxo0G9Us5dJc+dAGwQg0EfUlU33w=;
 b=ki//4EKyVEltU5+NjkgUlgaX+Fm/GUMOIqcjCufHzGUktkLx25fkMCzXx2kekUFb08
 C8yP29ayTHGUwLChKZAEvPqmtifnUaOrL1fsbyfrC/I8mF+rru8JkWehJhGN+TVsiou5
 rJHFZwtD+8bcqhfz/vky2ivO4EYTy4ZwUS43Zn2V8GY3sytm+99MRi9vQjzyGvAGFgRB
 aQoiI9dj8X1lX7p0n//mbloF5GzwVrWUNL+cizc3Z35BHFu4PqfIb+XroqXg3JjxsCYK
 BUvG/oxrKBMQC3jpCH8SjQjmnyejeV15iJNxRNpid2CAe6f/1XmMVrFFp+2rfFdp93va
 5JJA==
X-Gm-Message-State: AOJu0YyhIIpXyygeLyB6yMe9GlGFsHySVSmsw1/ZJk1MKL5ykQuq1DDo
 aagGT3Yba51aCLTjJ+5kAr+EuYChtnHBzxQYAnTM9/oSS7lfbT0mPPNF9c/4gnhzYwpY1R+fpgr
 5
X-Google-Smtp-Source: AGHT+IHgGSKw63YZ53eSXrYzwb/gxyTMukX8aUAo45lPpHjjT8iOT2UpFYOFc0FNdnUnNhqZipKYQw==
X-Received: by 2002:a50:8757:0:b0:572:47be:831d with SMTP id
 4fb4d7f45d1cf-5734d5ce595mr20099116a12.20.1715958154717; 
 Fri, 17 May 2024 08:02:34 -0700 (PDT)
Received: from localhost.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bea66f9sm11957369a12.15.2024.05.17.08.02.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 May 2024 08:02:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] ui/console: Only declare variable fence_fd when CONFIG_GBM
 is defined
Date: Fri, 17 May 2024 17:02:23 +0200
Message-ID: <20240517150227.32205-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240517150227.32205-1-philmd@linaro.org>
References: <20240517150227.32205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

From: Cédric Le Goater <clg@redhat.com>

This to avoid a build breakage :

../ui/gtk-egl.c: In function ‘gd_egl_draw’:
../ui/gtk-egl.c:73:9: error: unused variable ‘fence_fd’ [-Werror=unused-variable]
   73 |     int fence_fd;
      |         ^~~~~~~~

Fixes: fa6426805b12 ("ui/console: Use qemu_dmabuf_set_..() helpers instead")
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240515100520.574383-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/gtk-egl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0473f689c9..9831c10e1b 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -68,9 +68,9 @@ void gd_egl_draw(VirtualConsole *vc)
     GdkWindow *window;
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+    int fence_fd;
 #endif
     int ww, wh, ws;
-    int fence_fd;
 
     if (!vc->gfx.gls) {
         return;
-- 
2.41.0


