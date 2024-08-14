Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CEFC531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 17:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seHXi-0000BS-GY; Wed, 14 Aug 2024 13:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXe-00008r-4J
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXb-0006Cd-Nq
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-201cd78c6a3so600825ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723655525; x=1724260325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvLg/jdd02raDyPuokVKWkE8Jw8u8gKV/oNxvgJVSos=;
 b=uqmmMwyHcNbl6MBKnVHzZQondDQ2RUhp1dWsR1AV4bQyREX5JoyZyKXY75WM9JMBOI
 SnXsB/d9jpfLvLQrGCt4gfyeLhU7Uy9cekdp3kKSTMH3BqEsliRz1jxlAmlSaOZzcrmA
 +2o5m4AjqhmZ9iEdy5WF/bIPgVZt3dLvqp4iuXBXu3vSPXCgZNCMdlFqSVhfwZ+fY9uF
 Bg+Kc30DAy7y8D7qP2KTOpLkct+TuPeeO4qKsqsfeE5g8bgLc89PvETonqOqjlouxwSi
 oB4DmDyu6qYIshdiYzH5dRAUyjiO6UOA0XqxQC4LqiIMb9Q2xjRj84zLWF5kVPoautM7
 Gd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723655525; x=1724260325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvLg/jdd02raDyPuokVKWkE8Jw8u8gKV/oNxvgJVSos=;
 b=BYxP6hOY1frecKmIprnO/jyxRAZ3yFkuiWP7OPMZAKoY7o6TSP5ERYyFND6r1eW7bJ
 TQCMl1f7smd0NUQ+YM24BhAqBw5o60DKYL36GoUQvq/oZkVQ9foC1Xu9vE6Lrj7N8WYM
 xsB25hk64xd1gEJhsQzuOdgzEUyrH9Lqn4i0j1KwDL5WkoxZq6+p16AsFhb/CEkesmYN
 Pzat+/uS1kzhgVPissxZzT414ovDq0040GS8fcmTTD0H5jzffATTs1NcLAdg/N7DpsLQ
 qy3W/OBLhFRW4Aexf3NQ0M14F5Hr8vzyVY/2C5uw7hLk/AO5pajFFW9pV3eLN//OyJ0I
 KIkg==
X-Gm-Message-State: AOJu0Yyqgf15LoF8ooMaQUF6TEaIAWxe1M6Sqs2h02rTOQV6AoN44s9p
 tfKSosOdggqGz9upKY4h9U3Gbp7kh8OeKpYy5wrd9hRqQjf411c3CE/CVbp8dyUYx31nwG2ydvP
 r4aY=
X-Google-Smtp-Source: AGHT+IHGIxdu9HiDMdLgXFhSMaVLm1Yyxs1pb8uJgHbAk971dPiwaG4MNBvPtBe9hZnJ8+Wx2Z9WhA==
X-Received: by 2002:a17:903:2449:b0:1f6:e4ab:a1f4 with SMTP id
 d9443c01a7336-201d638d83cmr44171455ad.12.1723655525122; 
 Wed, 14 Aug 2024 10:12:05 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1c8783sm31813895ad.245.2024.08.14.10.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 10:12:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/4] meson: hide tsan related warnings
Date: Wed, 14 Aug 2024 10:11:49 -0700
Message-Id: <20240814171152.575634-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
References: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When building with gcc-12 -fsanitize=thread, gcc reports some
constructions not supported with tsan.
Found on debian stable.

qemu/include/qemu/atomic.h:36:52: error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’ [-Werror=tsan]
   36 | #define smp_mb()                     ({ barrier(); __atomic_thread_fence(__ATOMIC_SEQ_CST); })
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 meson.build | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c2a050b8443..899660ef020 100644
--- a/meson.build
+++ b/meson.build
@@ -499,7 +499,15 @@ if get_option('tsan')
                          prefix: '#include <sanitizer/tsan_interface.h>')
     error('Cannot enable TSAN due to missing fiber annotation interface')
   endif
-  qemu_cflags = ['-fsanitize=thread'] + qemu_cflags
+  tsan_warn_suppress = []
+  # gcc (>=11) will report constructions not supported by tsan:
+  # "error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’"
+  # https://gcc.gnu.org/gcc-11/changes.html
+  # However, clang does not support this warning and this triggers an error.
+  if cc.has_argument('-Wno-tsan')
+    tsan_warn_suppress = ['-Wno-tsan']
+  endif
+  qemu_cflags = ['-fsanitize=thread'] + tsan_warn_suppress + qemu_cflags
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
-- 
2.39.2


