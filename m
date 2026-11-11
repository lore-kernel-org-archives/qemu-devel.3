Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B1606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T/Mkrv1C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR6wD-0000yQ-L8; Wed, 11 Nov 2026 06:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6wA-0000xG-Jb
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6w8-0000rf-S2
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:22 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so18389655e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794398179; x=1795002979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N+OdrHs+iKhUjVczeBlqSS33OSxvir4oYX1NU4l4KTw=;
 b=T/Mkrv1C7j5ZS4qtAghX+rPkaX1/2EmhK4a+eVejGIzQd7YjsrjwTLqaSvud4xtFUX
 TA+FjMtqUBJ5B9OeqSq3Gzcu5gTc/cbh/HwFX9GEVORrW9VwjNSTR4o0iPNyYPVhh8GQ
 JMLYTlreEaLMQ7NkAF2R5hk8ruCxb/LPdmfnkU4T7XdnG2tI1hXzRGmNX4e/9GSN5d+r
 wYbGKjuyeyN9Et4VZ4uYWXBxWkwW8rOISQShMa7V4GbKvfSvuU2ffVqnWvAysEfexUNa
 9Md374WXl6Mso+G8GyxLWjCLSPNlkknIxKQexdtQgrK2Xb7p8ogtn3nmZg2Ldc7tSmfB
 KOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794398179; x=1795002979;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N+OdrHs+iKhUjVczeBlqSS33OSxvir4oYX1NU4l4KTw=;
 b=WpFb4goI16VgCM+p5Tg6vbbZJPJO/rrZCvpK2FdVQKFej1YUzz6B/218mpPuRkaciF
 GvuWPgTPI+Tfe96n3noKYUm3AbElrq6wQOqpKqMlXgTWsnSePCe3gYzyAgfR26ggzCBE
 UyMH2fjJpsX/113+BjNThVNdPOJG6II7Pjyb7IdOK0KcGh5yNxCpg9CZixnIgqc7EkL8
 YtKUP8cxbrKdUAPAt8i0lvHTktsy7DFsEe0mOCkZGZvbX8TWVjB3wnHAUgsv9oPezn/f
 fV5K5XlTzgdf2Z8bJCCWb/1evwFkkMIe/nKAoz/CGNYR1L0mpN5L93OfNNGdrbk8ahVw
 OhJQ==
X-Gm-Message-State: APuU4Z+maN1dF0SQIaj+UxoY7rfqZT0BzH0i0co3AwiTw5no9LkPukHS
 vaybXestjsAwTR9e0gI5Y1MOP8UQBcVJtphrjtIcW5zMZ+Ljo2qYnW9v++8wxCDAZF86y3v8AYS
 zsaX3
X-Gm-Gg: AYBFou2BMpucJ/LHd92h/VjK3Y4NgwkF4sQNogAT2TnpkLYcWn2uVe8kiLlclcUaCGz
 AuGM9j3ElHgXN6siW4o6YAZcjYrM91+XyRGBsJkWIsiNmitWedA5qIumdhjsXJNpOx+Jan1ndnk
 9lgGnmMNXQoRY3ETOeGMXI5dana4LtS/xqihGCNH0NpQ3iPHGQxUm7O2/jXlD3biAwr6SAILejJ
 CTMfkitcib0pMqh7RAFqtgnejYEYgOhzMhrEzIAfzBEHBq4zF9oiqAligNg5OrOqY/NE9k0jhr4
 ylUBcqBTxRfqgrNtAxY/euUsdT/spU45W4vC21+rpY6zpjUtbM+q7zFBdkPQNJmxRFIgWES/J6D
 2Hu7Zjwf/PiR6FbJ78RTPGva2mPCcOUnS697xzKUvwQCX6xewLq8/IRc11Gs7PnI5OZ3oJHTuwH
 N3Ud34APZIWvF0WVAY44BRQsV4mQGaiLufaGaWe55HPmGzNzaq2ICdV10GjpW+ApeDjXa8t60mR
 wDhQkKq1Sr39aI1hLy4UdL0hUSe4fZKDZC+/agIp0AGIaFMX/27KJvduSsg7JGXf0b1jVn6m6N3
 fSvbF5TKcsQtzoF7CtepoGhgxxumzDAZb3iufDe6EwbUEuCSNb8FwRuJnH6RGh5SPsNJ5G549GG
 GCCNC8nJygY9glir3bG6ywR55hmLOVD0d/SP4v9q4xMdeFoxvv0NKHthCXjhh9Z6z+uOGLi3WrK
 3yAlIONVl9lPEBx8rcm5n9PKGNZekHnc/td3/QRccmCSirGTM2gWpTfQfMSTvyRQhIVgosNmUSE
 ttvp0g=
X-Received: by 2002:a05:600c:4f84:b0:4a1:e92b:ae4a with SMTP id
 5b1f17b1804b1-4ba093b9a3cmr36753405e9.21.1794398179253; 
 Wed, 11 Nov 2026 03:56:19 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm128158315e9.8.2026.11.11.03.56.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 03:56:19 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 4/6] virtio-snd: don't allocate pcm_info zero-count buf
Date: Wed, 11 Nov 2026 13:55:56 +0200
Message-ID: <20261111115559.18557-5-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
References: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

g_new0() might return NULL, which is UB if passed to a memcpy
implementation that does not expect it (not in the usual case).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3778
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 89406f0a3a..a7d749f24f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -267,6 +267,11 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
         return;
     }
 
+    if (count == 0) {
+        cmd->payload_size = 0;
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+        return;
+    }
     pcm_info = g_new0(virtio_snd_pcm_info, count);
     for (uint32_t i = 0; i < count; i++) {
         stream_id = i + start_id;
-- 
γαῖα πυρί μιχθήτω


