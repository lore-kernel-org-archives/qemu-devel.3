Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1A6E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9eo-0004Fj-Eb; Thu, 19 Feb 2026 14:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eh-0004Bk-T0
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:43 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ef-0000qz-9c
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:43 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4833115090dso12652615e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529139; x=1772133939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYn8/zWMQreBHiYTbtnq8fqyE4iLLDhnD59BMr/8LeE=;
 b=TIu3ytztXiFqPLZ8YDWhBoWr/xFie6Qv0Pc1q9Pz5TFK7x+EXI43ScCne865tbwobp
 cECDAPqYWlRd8Zck3r8nMMHEzeUElTLV0ywAQ9J4IYP33Wyx79IPrzhoWRdY8OfbWdO+
 UhMWWAKHH6B4HpEOZMwzX+S3TK6Oi27KJ7he2ijIfSq8YT+HRwOYeWf7xm3omaH1Vmpq
 DZ44G+MUXZreShedbHb0HMyrwcRawKZjF8O3GVZa/YeFLCZnU/I2q1jptbGDDI7FefMG
 R/3SEDqbqvrZodjqgbnVfiYv6Kvwi8v2cxT51oawc5Dwm/M4QQH7PmQmXLvEjLmjd4Xd
 5Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529139; x=1772133939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jYn8/zWMQreBHiYTbtnq8fqyE4iLLDhnD59BMr/8LeE=;
 b=ZusR8x3uLxjXsCXol/bmvYKQBJ2nrEvUmid+vUFVF8dQEA2c4Qf06MVIfCUiM3hiGo
 QJpSNiySPG95djDhRVWQik386/pTm/6HgqmmYfW3arCXUz87o2wYyLvk1NJgmPzLkYHG
 zzczAsiAZY2rxu46qGFtbpCKS1HbIUbZ6n6iVxEC8GsTPAvqzC7E01P09McrxN6ssE7o
 QdM69c5LAP8fyyEM7G5f2qaMJaHxdnYMLam5OzsVj5qP+l7+WRFylzmBnilCKH1jZiGt
 u5PDV/8TIKolsHdXVPSj9M//Z72xipCMn8r5heRo24jQPtym3wXwmqKTKjDXJlyeSR7F
 N3lg==
X-Gm-Message-State: AOJu0YzynLk763axXVbc6Xxl6f5mVX40km9CMXsgYxyz2wIsotQKjK9w
 f0JA1KVGvwKQpkfwAOMXqD0s0FZzl9n8SC7Fre/j/dV+o9vMEbJQlnQG7UBdnIyRrKWojQk/IIx
 gwK26MjDaCA==
X-Gm-Gg: AZuq6aLimFxzhzn53fZni0ia8cgJp2QXWIdx4eJ2I606grXphsCsLqX26SUIG+RylW/
 uiHbVuIX4N9rxDNYfuGLfYooRwte8Kba2BQd+XgspSJvHmlGA++I1hcFpZneyszujklqIOoKn4t
 oOhDFVCpLjSCiokwXsdRW6xQe1DF56/ypnuY/SRU/QTKux125VZ4gEVbiZo5dY3zWVM/ETb83Eb
 d6ULApX17DDwBz/c1FP4JZ/zPhj1Et1k1++o9j7y/fhdY8SoPMZO4cnNNKWiUF/NGWDaavSwnyK
 nX3KajbzljSQka2B3FgqtDwtrx8oRxNWYAQIV7zkiGxUwrBAPbI9TI8f1OvnbJOyeL9GWDjq/Q5
 bnjQh5xojoN4E6PCrS92ZlYUobGxMp5T3gPNCTDxaWu32OxeuAnuIjjf67Yni6036Sv6+vo5Koo
 H0dQnqUFDJg/kKiCKZTVwdYbfscDebkGfbFbvBK4gzQf20nDLCzwhf1QgTm4DbmBB5fR2+Q1la
X-Received: by 2002:a05:600c:5295:b0:483:9139:4c29 with SMTP id
 5b1f17b1804b1-48398a48450mr102159215e9.2.1771529139498; 
 Thu, 19 Feb 2026 11:25:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b3e0dsm36224425e9.1.2026.02.19.11.25.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:25:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v2 48/50] target/s390x: Build 'gdbstub.c' once for system
 single binary
Date: Thu, 19 Feb 2026 20:19:50 +0100
Message-ID: <20260219191955.83815-49-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

There is a single qemu-system-s390x binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 096b7dcc42e..6f98ce34d73 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -3,7 +3,6 @@ s390x_ss.add(files(
   'cpu.c',
   'cpu_features.c',
   'cpu_models.c',
-  'gdbstub.c',
   'interrupt.c',
   'cpu-dump.c',
 ))
@@ -34,11 +33,13 @@ s390x_common_system_ss.add(files(
   'sigp.c',
   'cpu-system.c',
   'cpu_models_system.c',
+  'gdbstub.c',
 ))
 
 s390x_user_ss = ss.source_set()
 s390x_user_ss.add(files(
   'cpu_models_user.c',
+  'gdbstub.c',
 ))
 
 subdir('tcg')
-- 
2.52.0


