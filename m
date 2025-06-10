Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C317C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyYh-0007qI-VM; Tue, 10 Jun 2025 08:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyY4-0007K1-NK
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyY2-0002fk-Qa
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so1431947f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560269; x=1750165069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2mSDVhtmA7a1w6bXLskGx4/lyl+bFQibV5Plr1VjhU=;
 b=tVJptq4f8M8HSJwdqxbvIo1jXZRAY3k5DmRIxQ3voLKszt/8GDHs5pVKw55Cyn6qzm
 9TwyCg8ZoRuu0vkbwkKArkIG/1AtrVhHkhXgPQiN795ls6lp9I9kz4KCuFUJsth0f6VO
 YYOSBTGdotTNhjgaGg8adD9GbY5OZY4Gg8ecbIceljH03ChDbu4RPyjRw3yoeDO3t+5r
 QiQCkibxouimE5z+8njl+xWZp/TjqkwKrSB6R0xgAPum9n9LxWKj9EvB7vDBzVxNfykm
 6N8GMW7U/5PaH7xALI1oWURbP4QNy0GU0GWIhu5S+sa7MMZWo9jYGzN6uq+feTs2yI8W
 70kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560269; x=1750165069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2mSDVhtmA7a1w6bXLskGx4/lyl+bFQibV5Plr1VjhU=;
 b=chUm3E3j6BkIZgXLNbg8mRBmFwIiYNIHOX96yNMuD84qcmj3OJDaioxamZnuc13DTO
 CTBr3/KcmBF7ziJzxoOjYaKXciiX9vUIlZ+AvQkOghvKR0XOELena0autAArqiU3yFQq
 zZPgtclxPeIrIjNrmfRY7yJJyZR2sVfprWODSYt4fPOr/2+U6YkJO1T7v6jgVHDXXGEf
 368/pP+omOnlAu6TsrzOdIYkMULNB06Qb9DkMdpswbPg0jYCkZJx0LmcL3NkgbWDkWMB
 QFHZtxOsjvSA8tMJEV7HLjdUIgU9CVxDJud5rwRPYb/5sR3Krmk2StRXi7fIrwVtBm21
 WeEw==
X-Gm-Message-State: AOJu0YyT2qgJMQQ692jFb1WB7zGu5w7PykvWLaX/QIJtdV/REUrzkHAo
 1rpOTQKNeDl4TBuX5wjf7yJZ5fGP1fiNdwuZ9InqIIaQm87K/Ak4D0UalNXcZJz7Qiti8S6arZx
 2Aik15Ek=
X-Gm-Gg: ASbGnct3ymruG6T3RPxbYEqUWKptZizBlsNwXrc+EerlRLio7UVlwT7YMmcx2CLVEKQ
 0En5zNjS2/jefO3wOxh79knkOgUslVxD9ngERTmxlWC5ejkYGm5F0QKv8oClevQ7NUb4Vcnwv5D
 GkbM2i4VMqQp4Db9JhENEGvvNfRUkU27/xkj9MJ9voSjtWwt3Jcr4BnGdcsyKHVt/0BMG8xzAPl
 dn59DPY8ojQh/GJsu3bYqKTeyfwNR40a7+JmCRq48VOhB5LwUTcv5BNqk80S3KTTFsInEpitAsS
 2So3arW6GV4k1EvxwgrMaZumQTbUB8m3XgAo3kljl1mT3Ilj0hO0DAI530aoT+6KHZucdVQPsO3
 bToTWB9NjbKOpKNq9Bq0E/vvXfRiusMcshSulSf/dfg==
X-Google-Smtp-Source: AGHT+IGfkq2A3ZMPM0oSF977Z98ahugrMDiXCoKlrrk13nnbhndMa/UTXhMkxxyIJepVhw55pi7Epg==
X-Received: by 2002:adf:cb13:0:b0:3a3:76d8:67a7 with SMTP id
 ffacd0b85a97d-3a55140272emr2374750f8f.20.1749560268675; 
 Tue, 10 Jun 2025 05:57:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244f516sm12187491f8f.74.2025.06.10.05.57.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 16/24] backends/tpm: Avoid using g_alloca()
Date: Tue, 10 Jun 2025 14:56:25 +0200
Message-ID: <20250610125633.24411-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

tpm_emulator_ctrlcmd() is not in hot path.
Use the heap instead of the stack, removing
the g_alloca() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20250605193540.59874-3-philmd@linaro.org>
---
 backends/tpm/tpm_emulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 43d350e895d..4a234ab2c0b 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -129,11 +129,11 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
     CharBackend *dev = &tpm->ctrl_chr;
     uint32_t cmd_no = cpu_to_be32(cmd);
     ssize_t n = sizeof(uint32_t) + msg_len_in;
-    uint8_t *buf = NULL;
     ptm_res res;
 
     WITH_QEMU_LOCK_GUARD(&tpm->mutex) {
-        buf = g_alloca(n);
+        g_autofree uint8_t *buf = g_malloc(n);
+
         memcpy(buf, &cmd_no, sizeof(cmd_no));
         memcpy(buf + sizeof(cmd_no), msg, msg_len_in);
 
-- 
2.49.0


