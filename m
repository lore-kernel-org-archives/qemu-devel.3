Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B2CD484A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr9s-0001DB-TB; Wed, 04 Sep 2024 10:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr9Z-0008Gc-GJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:38:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr9X-00060F-ED
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:38:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42c7bc97423so46993465e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460713; x=1726065513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7xTn5zdWRqYnD4hgi99VErID5wacqKoskrhnuQY2GY=;
 b=YH1o8xvtVxKdSgpxPhrQKm0F2h2y64eSi2IIa8818LxQrbAVfB47FmbhiKHHGN6hlg
 SgfRnxB2NIS+OHIaP0tyUKzPAmIxDimv7hCY5sYZq5p5sp7zIKUfxFqf+is5HePQJe0K
 Inmdqg5o5bTtQjWWTUYqj0kM06wzDFSRQDiLozLw/mGC4TmkjRJEr9VOhESx7H76QeDZ
 BXDYnskLubxL/Ivqd6WVUKGuhFpCd5kzrZURy98s3iXohIWKfW+5kI3AevHoITT/nLf9
 G53TKL+0sPSJLXhDtRnnvWc8bHmF9nMO5UU3+Zz76vg9cxGB1Z8ZDvsa0sViUcwvEWmS
 eMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460713; x=1726065513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7xTn5zdWRqYnD4hgi99VErID5wacqKoskrhnuQY2GY=;
 b=JAVrOKuoJDfTQk3n/K/aWqlqqE5xcXaJJDBmBOCGG0NQUdsJdjc0TNI3YteBLBeTuu
 PiLz/Ym84EuKZVb/TPmoI/hg4ha54jZCBDRawMAzAlGDu0aW1pUXZouB/zNjyeIE/fPK
 IkDyZpbup5sIyCGvq8rDJsN2ynZ+fMhLkdccDiZZLUrxORDixK6dKJW2jff2+rzt/9mF
 3GAANRxboMIa7tWyU2vCOEZCYmCVsD1HnyTvMrWLZFAcHvZymoh8sTslN4OAVwVcQ/jH
 nUeLAo70aiJNEx1XdQpjGPY071SgyA3O3++jy3PI+20GEvMitzXv07614M3frvaLMRZl
 pd3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW61ZVXcaCNf1H1quknWT0jFzJokOuFB8i4n6FX+1Xh3dcytZ3PDYow3Au+Uo8x+mXCevzim4c+v4BF@nongnu.org
X-Gm-Message-State: AOJu0YzeMqtEVIXoF40K2OpoNZ5H2swdJljvAk9oCMPo1woNVoVowWzu
 KBGkYjT5/6q4QtTzTdK93iML2hwbAqrepE99QlXSp806gbH3DowbId5ZxSpNeCI=
X-Google-Smtp-Source: AGHT+IGxnTK38AYZAsNF7xo7+79vpPaBuSfbEC9cH9kOurqoS49LOR0x6HJRKIGxnhf/Mmatrjzf3g==
X-Received: by 2002:a05:600c:1548:b0:426:59d3:8cae with SMTP id
 5b1f17b1804b1-42bb01b9302mr193323655e9.13.1725460713385; 
 Wed, 04 Sep 2024 07:38:33 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb2dcsm207088275e9.1.2024.09.04.07.38.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:38:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/15] seccomp: Remove check for CRIS host
Date: Wed,  4 Sep 2024 16:36:03 +0200
Message-ID: <20240904143603.52934-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

As per the deprecation notice in commit c7bbef4023:

  The CRIS architecture was pulled from Linux in 4.17 and
  the compiler is no longer packaged in any distro [...].

It is now unlikely QEMU is build on CRIS host.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qemu-seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
index 98ffce075c..a14a0c0635 100644
--- a/system/qemu-seccomp.c
+++ b/system/qemu-seccomp.c
@@ -50,7 +50,7 @@ const struct scmp_arg_cmp sched_setscheduler_arg[] = {
  * See 'NOTES' in 'man 2 clone' - s390 & cross have 'flags' in
  *  different position to other architectures
  */
-#if defined(HOST_S390X) || defined(HOST_S390) || defined(HOST_CRIS)
+#if defined(HOST_S390X) || defined(HOST_S390)
 #define CLONE_FLAGS_ARG 1
 #else
 #define CLONE_FLAGS_ARG 0
-- 
2.45.2


