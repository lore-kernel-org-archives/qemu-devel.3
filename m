Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D84CEFCE3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGsL-0003SR-N3; Tue, 06 Jan 2026 18:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGsK-0003S3-9Q
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:54:08 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGsI-00043z-T4
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:54:08 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so10890535e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767743645; x=1768348445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFqGUVdaGL5hKXTuiPftJmIe7QhJeV9Pn28O6Z8yDB4=;
 b=sK5U09hBzNSWg32HsQoiLCcuyhk+hyzd1nDMvc2LUh9gYfcfNJfmh6DYjHqGrTUqI5
 z3ng0uKQ422Y42pfvcpsEsSeyUn5krUNA/Szeu3l5h5v/38oh94Fekmh3hn5MWKeUDma
 +Lq0XadlZac0TAMJklDB3iXnLrF/CpORW21c+mPQV546i7Yvbev6U4EeBQjVOGz7qIh3
 s8XlJU0gl7+a9JCTkfS9naZt6AdSBcsRTcDzaeZwZGAFfPCN0d0BqIikofcqc8kdqYSa
 CvnGpyIJkJLpYadYUh2KoCKvE9Ois3g9SdRwaQbxFKaZt0KpEmgMOizi2RTDNmT0BJoi
 IV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767743645; x=1768348445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aFqGUVdaGL5hKXTuiPftJmIe7QhJeV9Pn28O6Z8yDB4=;
 b=D4fV0W7lA7dMbKMeiX/1VYv397ikbz0CeLI6A5+0GpU3mzfr1tUKkOPQa+RvRUDTPz
 HQYzPVuJCmWBZUXWXKhtUCbodJyoDAJHAHvX4j02bRo80grzfopDgCgTxi+ibj0gxDkR
 txoMjphlBHYlELiQQW9434NTWM+SJ/r+K34dmH1ntT1Qc6WHTA8UAy9U1cLzD8ct6BAg
 9GztJSyJTZjrQcmN/gGGsBip19UuzkSuxIdWTvZD5ljqc3GkvMaPz6c4QptY7Zd1SC0t
 7UXGyNJ47BqP7cHbFmW4lOZiS+oooXVh9iiem/p55NBK4OxuxsIy0UNrBmQQCEqFBxi8
 skVA==
X-Gm-Message-State: AOJu0YzG0a/O4t8+zZ20pj4qoy7coRxAh77B2LWBCepda4qHeVfvjLFn
 x/Sc1IEZWzSQscudwkInoPRche+or49nqlpNktDGoJ5d07hFB3pylImFGSy0Hnf+nwh2T8vwdJf
 L8rPLxTM=
X-Gm-Gg: AY/fxX4FZSz0gFWemg/J2kCEXCM3orpWpEjXaXtoJl9aKnoSFjnRjmC78kYVOueZ/aO
 ANHj5k5MuQxFQ2togwngaT1iOpcdl6KukF3Qip3c0720Rm0Stf6vXsbGqH28zLl5PiFDDJvAuJo
 sOlYhQZJGTSLoON5RGqEEWqzpIza7nQzSDUzhgod/yn9HHWg6l7WxbavLQ/bZNzrv9uSr0ZKjD6
 PcsmLGqnSBL7Ki6Z2k16pwt7+JrNgYMvzHYkdBTGieTuiEpeXkhofiKPW49VHFbwl4hE2a8e9Uz
 aknLbz0yTzjPcyP0nV68wke+cClhk+cDbMY6FCITEu8TX1itZpRqEhprsMRjW5xVVNfXZXdQJ4Q
 gqkCNT3WbRNxbZAmuPLHD8L+CnjiSfJOV9xe9wzEMtytbOMEE93avgSLWg9BFgBAQtzZa0Paq2T
 GEzmAjJsPTX9SiDhD+KaCvgctd8zKUViHhoup/TJPA6DsZd9WXH0miCmnkIysz
X-Google-Smtp-Source: AGHT+IFPV+8Ws1zO2uC6lmPDi/DsYFhrNoywweoRoVeDhDNe2h+kPv4GJZjx1WJAyjMPQsrvusqT0Q==
X-Received: by 2002:a05:600c:190e:b0:477:7c7d:d9b7 with SMTP id
 5b1f17b1804b1-47d84b4099amr5748335e9.33.1767743644976; 
 Tue, 06 Jan 2026 15:54:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c78sm70385355e9.11.2026.01.06.15.54.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:54:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] target/microblaze: Build system files once
Date: Wed,  7 Jan 2026 00:53:30 +0100
Message-ID: <20260106235333.22752-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106235333.22752-1-philmd@linaro.org>
References: <20260106235333.22752-1-philmd@linaro.org>
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

Previous commit removed the last target-specific use in
system units, we can now build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 3ed4fbb67a7..b30b8f70ace 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -17,4 +17,4 @@ microblaze_system_ss.add(files(
 ))
 
 target_arch += {'microblaze': microblaze_ss}
-target_system_arch += {'microblaze': microblaze_system_ss}
+target_common_system_arch += {'microblaze': microblaze_system_ss}
-- 
2.52.0


