Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35047CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaA3-0003Or-8R; Wed, 22 Oct 2025 10:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaA1-0003Lw-8N
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9z-0007KK-Ku
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-426ed6f4db5so635655f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761144593; x=1761749393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsuwaPSDBJqW9x7+kDRZ6Zqv9gzfoIIzIakN2x8uDIw=;
 b=eDl2EKu7h0kPq/KF58+Y35QruJGYeFi8vY9BD5ZHlqarrTRz2K4bqavX1SjZ3XJdaF
 /u3dGuZXNzjOVVLMkzfdL9mV7oxEtI8EmE/yIv5a6rNHh9FSROoDFvhK5uTrtdBpYRNk
 Ye0gBSBhDmQ6EMMEW74FMXkmtwGwsvhwsNI5s6T9/pm5rbQX5Lmia8O9i2SKW+M9/SsK
 tzdfZ8OEdZJkpYmaA+QmLyk/z+I8vmezu428y33CUIYuNq8DPM6odd6NmfERKd/S0zvz
 3iwfbeJHZP3z12wMC4auslFwuJHUWZLAbyS7fDEPBZPs2YpCx5RMeTaSaprjwUUtnqZn
 m+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761144593; x=1761749393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UsuwaPSDBJqW9x7+kDRZ6Zqv9gzfoIIzIakN2x8uDIw=;
 b=Ip1RwlCIk6FeqI2JNTb0PIdg9IH79+vFtbSDDhRkPsJSzpryjOGyrQrTNeo3soY6GN
 /6Y/Paa5JEkgWA7EzclV3R9CTWfkHB2h71LFta6nVXyGZBj/XpFrevAXyJo0ejbLF/qJ
 9GM4OVvwKgxlsvYGxLzlcFrQcjbLPRnSxzQRYO1Wr9BD3ooqBnvYk1uERODG9r0vRVbn
 /d/acaGxpON4VzHIeCy9n1Hd497wYMYqB8nSX4ZtXx3ve9HJOyqjSD0B0viEI/z6ReYU
 Geo8dEwV6VG3CV2MWuUTJEbPeM0miBG9vd7nY5bNQrtbtL2nJQ2KaXBcAPOV+qR3XqF7
 CkPQ==
X-Gm-Message-State: AOJu0YwO+cO9cYoYYAIabZUH/kvvBlylNN5fyG7SebLDmg0W1khh3eOg
 X9LuVQ5sNv9dBlwT6K/qdS5nRCoUZt/oZdLa93SLKfxdcyfyWAqnx7md301JNsdVBlzA5Tmyq9j
 xvm7GcFk=
X-Gm-Gg: ASbGncuX4P8wLm4adbM0+EOHOwmLl/y8KCzYE4WbxWB4tD8Ae7ggSQNuB8PR1Ixwl8w
 9iuShpL7RWTFRLkazOAQ3fkTRchKto4QWvWbhY2Eb8L2+pe62sFjFo0mvONm+ATT3NjPhqhwMHd
 xsm/CW9qN+D1uC5hmyB8a6v6XRVjTgAd/Fo7nc1MNdl8aR9+HhczKhLTh0x+oU06mrVAgLtKXDm
 eei3CkOynK4DpvGhCPpUB6Qe24d+F3KYKNrfbThLSA4lGX5q1eV+8sVBReE7Tl0F6TczdO32WuQ
 vzNy4+hHLhtyP67H4n3j1BhWpK2kwJRTpT4Jwgjjtz8UzU4+nnRlQjNXqUup5kLcvS01R5wDd7p
 mSl6NEHt1l4Mp4jLJi4eZk+6M/phEymyb8dsMgRGxB5QHDUpXv5tL6VDCs+jjMjtgn5Vc+IFQdr
 trK+nXv28rLf1B47U6x/C+JpQtAFnmx8zO44ymv9cZepnOmygOLA==
X-Google-Smtp-Source: AGHT+IFEQsTxFfF868oUqDAaNuYxvfDkxLPrhkOZ8HqJOmqLuzWHvIS7Gam3GpR5kVYJsL2EWd+xkg==
X-Received: by 2002:a5d:584e:0:b0:407:d776:4434 with SMTP id
 ffacd0b85a97d-42856a89d28mr1588540f8f.30.1761144593579; 
 Wed, 22 Oct 2025 07:49:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce3e2sm25589714f8f.47.2025.10.22.07.49.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:49:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 4/7] chardev/char: Allow partial writes in qemu_chr_write()
Date: Wed, 22 Oct 2025 16:48:59 +0200
Message-ID: <20251022144903.74612-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022144903.74612-1-philmd@linaro.org>
References: <20251022144903.74612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

If qemu_chr_write_buffer() returned an error, but could
write some characters, return the number of character
written. Otherwise frontends able to recover and resume
writes re-write the partial chars already written.

Cc: qemu-stable@nongnu.org
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 30b21fedce4..5c8130b2435 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -189,7 +189,7 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
         replay_char_write_event_save(res, offset);
     }
 
-    if (res < 0) {
+    if (res < 0 && offset == 0) {
         return res;
     }
     return offset;
-- 
2.51.0


