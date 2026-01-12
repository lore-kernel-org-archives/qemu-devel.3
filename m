Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4333FCF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQny-0005ff-Hx; Mon, 12 Jan 2026 17:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnw-0005NR-P4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnv-0003kT-6U
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso54729575e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258469; x=1768863269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5VhRifJM9Iof3yw9WrgKYOUkmZnR2wsi7wQcQWtIss0=;
 b=YeZhbVFJXRfWPOwyadgvtpEAouAvmtFI9r2FACXIgVpnqYFd3es5DZdwzr4SW1p8dk
 Y5fz1BL0wte0HoxzP3KtXQGWowst6CwfRGo/dbrZJwUzdAmEXp/8gzCQRYj33APv+ggI
 0RRXpi0PnT9sukCxlia34FmGUPBimuc3Oj0Pzr5eV7VKqO1x3d9htvB9pgpfjhSb27xY
 6QR6DAaeJ5Qs8+yJu5aJddAJMKydDCKmxsPSmZ7t+HljN36AEb0S7DwHC6o3jvyj0fLN
 hABhGkB4NtPFIgBenn1aqJTYD/j4rRIvGFkjdkiXJcpb3jN3UTHkzoIwgS97GKE4KftE
 +6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258469; x=1768863269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5VhRifJM9Iof3yw9WrgKYOUkmZnR2wsi7wQcQWtIss0=;
 b=QOhCDPhLfh4sFLWus37GGq770bTN0CvlBFyBjptiUq8RrzfPitP8oVFhBkwV0EP7t/
 fpnRM/Z08bpCpatTWdlkGEHxJKq9J1h2sjDNgIygsfyShaaZuLc7vULZakXTbfjqiLyy
 uY7s6kkjwOzLHNUp7b1xvHlDEGNsHOqNxQLXe0Pxw+Rq/zc8OJYAi0evZiN4oSk5PrCH
 SwnKdMad7kgXBe2izRBC65E3PpBE4OW+hspy7+AFW6Ighx2dER6RBIWygJDbCat1SnXu
 EBpc7nt+JnVnzoJptY2E2nrdrFo8L+s/qx5fQH19+RP3Oc6Q5VjlccxibosnuJAjBopM
 mbjw==
X-Gm-Message-State: AOJu0YwAzB6SkDutf7uLqZIU+/RIXeiyfswJ6rFWLBHKgtwEnmX9otPS
 99dM/LNZwlwv8iDDKpQIW62w+RYQhsaIQZhmJV3qRP101Sa/cz4E9sgHoelJmtJXX78ON97hr4r
 RvawHHDY=
X-Gm-Gg: AY/fxX6f4+zJJJ8qrarI4utzTCh0Poq30mDFFgOSFruwZX7U4upQp18lWmaOZMDhvgQ
 UZaOUamipNSI07+tRaBMJMzolXnoTrRyYOviVKHlnQcyv9xekELwc3bqJrh8NPgKNcX5PTvVsNK
 0uJiXSg6AWVm0T3jcuTQXJQtXIBhRPlsd7I9A4PSonM3yMV3o/arp80bniQLjeoqaT0lN2x2n3V
 pQKmbacLTOvgcJwOjkDB4affxj8a1nqhGK+C5i7ia3fBHp7Ip6Ow+7YXzaMvnQCh9DlwAxw9UOq
 z8KJU1RO+jry1fhTfGQrD8aD3SK1zRxayer9fCs7m2KJPlx3Rfa9mQpduO7qnP1aNTNmm+XU8Af
 GQYalqGr/JbZabP9Tm85c+UYp7jB5UK3pU9iQ6sfH9n/5unNBvxjM7D+ehYvJpUQE8qJ6ZuwLQt
 4NJdWvSnzBT0tJ/Utvj+s/+yCZ14L5bOItom4T/EzSOe883/4HvNkKSUkclD0VGa8DhGjyLbE=
X-Google-Smtp-Source: AGHT+IEIpgjsE4xlqo6qlZpEQGra6pSLlCdg3wtCrKL1GXSYR3LxY6WROZU4aSch4Cxd3Fls2SDOIA==
X-Received: by 2002:a05:600c:5490:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-47d84b33bc0mr256391495e9.24.1768258469283; 
 Mon, 12 Jan 2026 14:54:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ed9eb72b5sm1392925e9.2.2026.01.12.14.54.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/61] target/sh4: Build system units in common source set
Date: Mon, 12 Jan 2026 23:48:43 +0100
Message-ID: <20260112224857.42068-49-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Since commit range 42c90609b8f..82a1e739010 we remove all
uses of the target_ulong type in target/rx/. Use the meson
target_common_system_arch[] source set to prevent further
uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-3-philmd@linaro.org>
---
 target/sh4/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/meson.build b/target/sh4/meson.build
index fe09f96684b..221700bcf8c 100644
--- a/target/sh4/meson.build
+++ b/target/sh4/meson.build
@@ -11,4 +11,4 @@ sh4_system_ss = ss.source_set()
 sh4_system_ss.add(files('monitor.c'))
 
 target_arch += {'sh4': sh4_ss}
-target_system_arch += {'sh4': sh4_system_ss}
+target_common_system_arch += {'sh4': sh4_system_ss}
-- 
2.52.0


