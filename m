Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B75AC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm3d-0004mJ-9C; Tue, 28 Jan 2025 08:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3X-0004eT-JA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:55:09 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3T-0006di-HD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:55:06 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e06af753so3090609f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072500; x=1738677300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfNuHQWNeJu5X2wCDgIQnnHrGGyk47oR/kdhbtMYcjw=;
 b=AEVHp+e57Gd41rHDlvEsxaCHvRpz8C8nKq/vP8rT8vuiXgYysVcVqCP3zgnncC+baq
 2KcsT/2yAiQg9ZfIP52SaE44rrCWK8N+wX/ggl5nYp+4K0joJ1K0JyDwB8ug838MeNj2
 Ft8rwEpp5IH/y6N9krOJhZNBBc+t5Wx0zTBaqGxKLOLaVyKgwi6mw7gZOTeM4fPkVct7
 4x8xZ8pECXzF41McTTEXjNCZHX7oONuvgmqCcedgifJ805PKk8usHhwGsaFAWIV3tFkU
 YPYJ1rcnraGUOT3lNpsAnMJCxmv9L4TiqqkkrQZI8aGYYL2DWkeggGGmVkz/TJi6EzNn
 S1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072500; x=1738677300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfNuHQWNeJu5X2wCDgIQnnHrGGyk47oR/kdhbtMYcjw=;
 b=oE79qVJU37NHqyGk0FpQogPEfdCfXU2nQzdi4W5tDdJrnAEn27l5tVJoP0BjYfck+8
 6Al0Q7FzwRcrOeIZAXBFNNitdSakQHSNQ8yo6FafBRYwZJrpoXAyIYoN4V2OpkZPQMSL
 8Rg0Is8TFYVA5f9EESJzTAj5qMGsOHvgpL2Ue6XJvLIjx/FD5doOcfdcyamjqesWVnIY
 02yb+qhBaDDrut+rvKZO/3TjYLWMQBA8PWcxgIQSWZhpKVnlUaIk/UH7XET+3u1URjOD
 2VED6B3nAUwvqnksvNKz8KUTkn0Ooz1b5+oGfyrVh4TfrhFY15K6iBL7PKvoxJon2cs6
 +E3Q==
X-Gm-Message-State: AOJu0Yw3WvZKU5LdHCwn8pGSkuFEm2A+pWoBpRfnQVZIfmrNYmDPWSiz
 ScGgFhpoQ+ziC3l/C8Fu83rOxV8WqKn91Qv1+N76ltuLCiQ5gHyDB1lmpbJ4mXqPsqAFIlxzhR8
 vyl4=
X-Gm-Gg: ASbGncuoeIzrF3a9oWjeUUcWMXhs9EbX5niWptnTH48rgPPW+N3Re26hTiJo5Mb4StS
 2ynx8JzRndMT4OcS1sk3s8ydCqU96t0d+TUWEr54/mNl8NIvJPRcKEyDq8odCw+Qx9y81Rzs3p5
 rWxaY1lycIIHtRCuvDLuxkXk61GVN2j3NPeQKDs1n29Y9qvMm0CObH2WZKCRyZ601bHintsjkA8
 Pr87QzMWBSwHNmuMFnzr5Z7CGei3x2j8xJd3RhZ28rRJxqSsvuhXuLy+SdTxoTJllyMRIlOuMWP
 P9LZr1Sb0Y0HCxXvQxCdHScpO64BGotsCHsmX+lukhkVgHRMJT4cDX7CU9EMBquSlg==
X-Google-Smtp-Source: AGHT+IF6FaWdiPaqacNKbyj/s2k3FO3tLGIOMg0xoKeEAz10Xzv4C6qQkS0Cwu9Wf1A7n99AR/Eycw==
X-Received: by 2002:adf:eb10:0:b0:385:fc00:f5d4 with SMTP id
 ffacd0b85a97d-38bf566ce7dmr31162296f8f.29.1738072500350; 
 Tue, 28 Jan 2025 05:55:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bad16sm14540405f8f.68.2025.01.28.05.54.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 05:54:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 6/7] tests/qtest/migration: Run aarch64/HVF tests using
 GICv2
Date: Tue, 28 Jan 2025 14:54:28 +0100
Message-ID: <20250128135429.8500-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

GICv3 isn't supported on aarch64/HVF, but GICv2 is.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Test eventually timeouts :(

 tests/qtest/migration/framework.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 5629b8ba4e3..30808de14e0 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -266,7 +266,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
         machine_alias = "virt";
-        machine_opts = "gic-version=3";
+        machine_opts = env->has_hvf ? "gic-version=2" : "gic-version=3";
         arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
@@ -303,6 +303,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         } else {
             accel_args = "kvm";
         }
+    } else if (env->has_hvf) {
+        accel_args = "hvf";
     } else {
         assert(env->has_tcg);
         accel_args = "tcg";
-- 
2.47.1


