Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7D4C531DF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9RR-0007eS-2N; Thu, 22 Aug 2024 11:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9RD-0007Sr-Nk
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:09:23 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9RB-000527-On
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:09:23 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so737132a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724339360; x=1724944160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cUhzbDO1c4TVr/5fHme4bDVdctPUWA406Qmu6O3nZE=;
 b=UyQdEYgp/OaUJPvLPJ9X/6+OX6fYhYbgE1sK9rjQZtCWVUSo8xSwJ/zx8urt43Catg
 ytDieAnvxQWmWyPCYBAyUChitZ4LtpQKmox+te0nEY8lhWIOFZiLZuvIPJ33Cmfn5p3s
 y3cTQxhn0egQ4/zb0D67Nh0Wz0CWz+MlA1i2xmVArlRJXXvSaShoO+dFiuCFwKis1OE8
 uD81PGIGSzYAleYCWhAZxsSSZU/KDVoLw2LMJUexz1Zjzk2Art0CfBWjJQVYmkQCUwXg
 wVn2jxNQBZT4kUqB9eytkXug9hCYVPhLjvJuzcnGg1w23Bo1UUTZHrjKs54gXVPgFfpn
 8lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724339360; x=1724944160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cUhzbDO1c4TVr/5fHme4bDVdctPUWA406Qmu6O3nZE=;
 b=jQdp6JTkIWxfyMzX2xEiD7ELPv8nLz8cS0koE1p7sq0Kbsh2USSFW2d2UFlhIbafcE
 r95UphuBEIiksBNDFpsZU5bVad0rL3CmQ5EIaOizJ+xR4TdYv1UQPHE4yqU8z+FhcwaM
 kgko1tOrrBj3XbzAnT9vcluaSqQbTX6J1v8d4ngmMRgjC4W0lvTUElLceuvFES+rZrpo
 8hn2E4sPxJsSRn+5vBPLjIrrDKm8AToxtAV60CpGjT45jTJ1DIc0XpDw7oWzDEDkr2jj
 BRLjXeWdeE2WiE5REKRLEuVw66F7YjITG+GbPamI6tvu/XfgYuuOh3L5Q8TSLw9E5dXq
 jkAg==
X-Gm-Message-State: AOJu0YzX2RB6sBBJgOk4J1eUhWuMkgvSlPJViA/70riYmfLqKB50N9pi
 BjZ7A5ye4rU87x/DTKILKtyFcH0vl6a/jAr+20Tt5F0pPf0f9MyvWiAjGg==
X-Google-Smtp-Source: AGHT+IHky4Et50cZ+iuguauLB28SxkMo5O6AdajkaYSf2qzZO9zdpcBCUAU5dqtchRlKn8o387WWBg==
X-Received: by 2002:a17:90a:ba96:b0:2d1:ba43:1303 with SMTP id
 98e67ed59e1d1-2d5e9b9a03bmr6526231a91.21.1724339359905; 
 Thu, 22 Aug 2024 08:09:19 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.175])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613919fd2sm1991567a91.13.2024.08.22.08.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 08:09:19 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v5 2/8] crypto: Support SHA384 hash when using glib
Date: Thu, 22 Aug 2024 21:08:43 +0600
Message-Id: <20240822150849.21759-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822150849.21759-1-dorjoychy111@gmail.com>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

QEMU requires minimum glib version 2.66.0 as per the root meson.build
file and per glib documentation[1] G_CHECKSUM_SHA384 is available since
2.51.

[1] https://docs.gtk.org/glib/enum.ChecksumType.html

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 crypto/hash-glib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 82de9db705..18e64faa9c 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -29,7 +29,7 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
     [QCRYPTO_HASH_ALG_SHA1] = G_CHECKSUM_SHA1,
     [QCRYPTO_HASH_ALG_SHA224] = -1,
     [QCRYPTO_HASH_ALG_SHA256] = G_CHECKSUM_SHA256,
-    [QCRYPTO_HASH_ALG_SHA384] = -1,
+    [QCRYPTO_HASH_ALG_SHA384] = G_CHECKSUM_SHA384,
     [QCRYPTO_HASH_ALG_SHA512] = G_CHECKSUM_SHA512,
     [QCRYPTO_HASH_ALG_RIPEMD160] = -1,
 };
-- 
2.39.2


