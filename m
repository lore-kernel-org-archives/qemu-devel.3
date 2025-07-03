Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBAEC83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHdV-0004zV-5H; Thu, 03 Jul 2025 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcU-00048L-1t
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcR-0001F6-0W
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso3616346f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540200; x=1752145000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7agq2/z/dMVKZ8AYrQE6GIlp8fdEIwRrjWbdb+ua6k=;
 b=lzC21RcpLL9gk0CaJQYKGVpurAbcGWTPbpIwdgCkc7j1B3qgHooyXPASA0z4hxLFAJ
 FztpDvDBNfhIgkkf0ItxKJcu1zXoo0FqgihRgbl3prwy1YIBXnBX8xyz01IMgHHAaFmB
 S2u+RtE1x4h08crw+GJcypM8ud8/v11JoeDsvP1mYBbhN+WdjgmU3ZysYXCm5bLfZH4s
 8Wj6TT73TG9Ac6ZHaSCm8pE+4Dg5KNxy5yRlK0ywEZ2WYzdiHeJ5q7dEcGdnKjJQTu9R
 8FaEwRQG291UJgbgOG2jNfujMbLgS0r+MaBLdKuxgWNRwzUlPmGGTGFB7SBvKpos8ql8
 /vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540200; x=1752145000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7agq2/z/dMVKZ8AYrQE6GIlp8fdEIwRrjWbdb+ua6k=;
 b=SRBq/PLU72AxgCBVbP0ficaZFgHOZd4qZnm8yg30iq6Y4inWDm2N/COQSvvw0Skn1d
 sQ1JJlQ23sgHwPGg1qRbISkQ7asMYxXUlj1vMnEeX1rlPIuxBryTflXM3xQWn8M94RjZ
 pV2qYBQ9euhR6GmzBD+WPcATZvZAW9kUVWSamO2Orx4VFPVLrXfSQ7uEhz/l9GwdZQ8K
 NKzvIuJfc30Hxe9pzlKvwwwhjlxiFkUSy9fRIyAWWGq4R0w4XXvQrtXrWk++Gb4HtSGz
 iXbvhKIQjc8YrfONTXhWYfxQEwz65I9C7WRWqIEPStf6LJSkOxI3fME6L7EPUlGwdf67
 UkEw==
X-Gm-Message-State: AOJu0Yzbxa4pmItNa0hUH2dKWMC60TToLuaU4s01hf0TqryBRa0ZXJJo
 jjFhPyyPo1wAo2yJDNuz762L8MbX0rkn6FeK/iSI2VM8mqFpvJQ4qvTHidderxeQ3wzMF3hISBN
 6GEqWvU4=
X-Gm-Gg: ASbGncsobbcnmkf0vy0OcC7ytAGe8meHxVoDhREeKARaNMStngOBw7cbj2Ee1/96n4e
 c++cmsns2bU4sZ3IKRbCC4+DiPbZSV8p0Uf0JHAmCRMsAC7dNMBXzUqSauTcHL1jOyr+eu1iR8M
 ubZWoX9oD0hKrEAOrJx7M0TVpY+go2+6hZnPUOz3Rpr5fHGJS4d/CjYKC2jXG5zjX84TZNyg680
 oSq0CJ0l0mdLRDupKsyfYH2HExyUaM9dpIhwiHfF9EP6I/IDcoseTqINC51rsZhXmdYEARn4opP
 iK+3ylnCmwH0qIk5onifYVvbNW3I80sldqOc2JjHePPvZ0nlcOnol2VjYGn3GZWNdikD5MjDrB4
 rYJ6bRaSc+lkglXoFEz594Q==
X-Google-Smtp-Source: AGHT+IHy4W2SuuO+zy9xHO+kTkw3zE4vw5kmWtlB6VNsrS7nzuVM6IdbSgdtrT0YjiMzG2J3cn28YQ==
X-Received: by 2002:a5d:5c81:0:b0:3a3:621a:d3c5 with SMTP id
 ffacd0b85a97d-3b1fe1e66cemr3890751f8f.19.1751540200502; 
 Thu, 03 Jul 2025 03:56:40 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f923sm17945567f8f.89.2025.07.03.03.56.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 11/69] accel/kvm: Prefer local AccelState over global
 MachineState::accel
Date: Thu,  3 Jul 2025 12:54:37 +0200
Message-ID: <20250703105540.67664-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 264f288dc64..72fba12d9fa 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2588,15 +2588,13 @@ static int kvm_init(AccelState *as, MachineState *ms)
         { /* end of list */ }
     }, *nc = num_cpus;
     int soft_vcpus_limit, hard_vcpus_limit;
-    KVMState *s;
+    KVMState *s = KVM_STATE(as);
     const KVMCapabilityInfo *missing_cap;
     int ret;
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
 
-    s = KVM_STATE(ms->accelerator);
-
     /*
      * On systems where the kernel can support different base page
      * sizes, host page size may be different from TARGET_PAGE_SIZE,
-- 
2.49.0


