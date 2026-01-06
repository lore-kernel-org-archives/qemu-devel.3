Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEABBC9833F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGs0-0003Pf-Kh; Tue, 06 Jan 2026 18:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGry-0003Ou-FM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:53:46 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGrx-00042O-2t
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:53:46 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so10566955e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767743623; x=1768348423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V1iM8ty8kaNTueqheMi38PDIvMimzW0Lw0IOt0zr7A=;
 b=vpplm3iFsobZLPFDbjv/hcsGNw4ttFW/5fD3MG1GKrtdeS+2sNiVjy5W698Yynx9Ln
 ey6tD5I9trPYyVq+bmpABmoizy7UVtzbeVgXK9cnUoKOW3e2oHYdKF9Jv0h3r+95bk/w
 cSCEvEtzKHkKLV2avP2FuW5GJlrx713shyjdIUhJFtX+fJfzuNwheDzXIaCdsmginTg4
 nCZllIhvEeI6HRfBZaexGtmUVE65yLW9gc6YyYMQyBebm+oTLAVsfl6xowQR3Ty1s20C
 89Z9KtQ/sZVg8ylkvrE3iqlv5vUfXZQ0qnepcs7gcLHASCfwGORX5CByTTRoS3/qkmOr
 prLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767743623; x=1768348423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3V1iM8ty8kaNTueqheMi38PDIvMimzW0Lw0IOt0zr7A=;
 b=Jt12K4YEFTPC/o4W6BAxu3T8tUHzcfI1Eu/E4gY2Mz2u9mzOsqs5YvUeeWRyUUKA2F
 QHJqlBmq9ldiwxnqCbDY8uCic6M5AYRLZRH2olQzsyCLvWw+DRNYBN6F1ZdQ40CZTPp3
 DYIIgGDoL0CHbuk63ElcSdL6Avi3k6gTKanMWMy3OL0sgYwryn+A74tY95Zx7idB+jUJ
 gvhpa1806TEu4sBllsbdZ6xCs0YoC42+I6aGWzTqFnqfA+nknQhDjfIlOEFb5ojpuSFA
 ACBlIW8GUp6EI5oDhCzc6JU7tQYWGQhcj44eHefzdqhvQeDIvamkZPHhgtMMuCfP1CRW
 WbBQ==
X-Gm-Message-State: AOJu0Yyy34NNAMTo/GiqPqIJXEUJ5NDe4m/8Q2TT0FVESZ0Nl3gzkkes
 MnC29R+RIKJ4BqvQGikFYDkGkYnhYpVA1aRUp25T4hFkRzEV6R0KEVv4JLfZF7OSZFV3Dqzby58
 baIr8QVs=
X-Gm-Gg: AY/fxX7zpLAXqySHsrxBzXivl2mSR5BHRio/GBfjvrowtYjeOfU4H7tgVFqp1/2Qhgo
 6QbNd6V+5ZLnj5MV/X5O1uX9CP6EKHPDhMHK0DoiCtL+R2BHVPu/SI4pQgYM7WGwWjmdolYPikR
 J6fUxw+u86oXLpF6NInoty5v+dzYGF3ZbgJL3AeZxrv/9clVBH7Yresh2piiqOFiZ+BSv4ndQG3
 77LPPOJANOEv1nCD0qzHISbze2r4xIJzd5hGUu6ZW9UL6HpcWfCdVtW7XI73lj17WI54e2Co4u5
 FApdIcv2/vfLe7nHVTO8tovugIvhO8lJ05f1h6ZhW7caskWBRA/xStbpaU0Iia9JX10vrjd2tg6
 XWzAT6SknDsZDS8yV/xd7iuzfwMzbzjtIMLwj2ojTCFOQNLkzAnDDIDFTdBm3Hh3/DRkfbX5ky+
 O10RJR2e9cPjeSAWNljmvH0YMIL0VeB5kcFdSrZajlMIshvm1WYrUZK4BGYOIN
X-Google-Smtp-Source: AGHT+IHzSepH8qkulMxJwmfNwwO89iwX4rn5uQD2l1nbYNtJfKbCYy3lc9vtpJ4e5DRceZd9WIw56A==
X-Received: by 2002:a05:600c:1d14:b0:477:97c7:9be7 with SMTP id
 5b1f17b1804b1-47d84b0a7bdmr5796435e9.1.1767743623052; 
 Tue, 06 Jan 2026 15:53:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8384646fsm33116765e9.15.2026.01.06.15.53.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:53:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/6] meson: Allow system binaries to not have target-specific
 units
Date: Wed,  7 Jan 2026 00:53:27 +0100
Message-ID: <20260106235333.22752-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106235333.22752-1-philmd@linaro.org>
References: <20260106235333.22752-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

As we are moving toward a single binary, targets might end
without any target-specific objects (all objects being in
the 'common' source set). Allow this by checking the
target_system_arch[] dictionary contains the target key
before using it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index db87358d62d..734c801cc77 100644
--- a/meson.build
+++ b/meson.build
@@ -4275,9 +4275,11 @@ foreach target : target_dirs
   endif
   if target.endswith('-softmmu')
     target_type='system'
-    t = target_system_arch[target_base_arch].apply(config_target, strict: false)
-    arch_srcs += t.sources()
-    arch_deps += t.dependencies()
+    if target_base_arch in target_system_arch
+      t = target_system_arch[target_base_arch].apply(config_target, strict: false)
+      arch_srcs += t.sources()
+      arch_deps += t.dependencies()
+    endif
 
     hw_dir = target_name == 'sparc64' ? 'sparc64' : target_base_arch
     if hw_arch.has_key(hw_dir)
-- 
2.52.0


