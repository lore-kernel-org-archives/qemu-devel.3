Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ED0EDE9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4qr-0002wf-Ho; Tue, 10 Sep 2024 13:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4qo-0002bN-Tw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:40:27 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4qm-0004sb-OK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:40:26 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d8f06c2459so3791173a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725990023; x=1726594823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Z1RdXPVj5atb8+PpKq/fmgLYxIn7PDouvny9pPcuV8=;
 b=KQU66zSz8WY+kPtomntX64bsSCZNxiUZ9vyp8nOClT/mC6AISHAfZHqs8+CcOuGV4/
 Za92ZhRjMYNnB5xZbn7yp1ssqk+8c+aVyDRhhPL3elcv2M/Xlg3vEGSUSRtMMP7+Za6v
 RedqQxDg0ZYqsJKAq3qLr5PB1Q8++30fUiT+tvUtqh291fT8drIP3+02r73brZFEJsF5
 OuC/31zZK2n4AYEYzwp8NgZRkNDs2EO9oW6fX95Qx8IybsaljEUEiP7dGxabHLjCUjL8
 X7iGt9gTxOzcWndhHzweIJN6ApLtLtKXa+ELdyBFcUTlO9N0ZYavTnEAiyxuQ7PR+FsD
 c+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725990023; x=1726594823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Z1RdXPVj5atb8+PpKq/fmgLYxIn7PDouvny9pPcuV8=;
 b=XGBAeL0foZhzPFZMlOT2En90B4myjXFl3xHug2p2qMFVl3675uEgD4qJUMDd6NHPIz
 Mp/i+q6WULPxwgholl4OCm4IMIiJHpcpGZWZcKXjXf4EODXgGkwUXwM5KbwUm0PZHQpH
 w/uFt8TMYQi5D8m45qhB+uQlwY0mmIqs2HUVd4UE6wWi2SPYBb/54CVu2nBOuGCaQkGL
 Yjv8XyZGUOt5nIfNrb4VkNjyHy1afKJu4N142yhB8peE506/ne/wbvG7oC6b6+QYAaUh
 2aNcEXVz902i4xxtnRN+MDHJ+qeIX03gSWTv+m+ds9Jw7ujwXP8pz2KsV9IZVfgjrrbX
 hiWg==
X-Gm-Message-State: AOJu0YzswMM0OOWWlRrPYPJ2HVcjPIc7k7iDlm1HEDKxFvNPqP0BNx+9
 j0mMMb+1yoCC0BtLDLMMubRNwValgO73OsEkJahRbwb+cv3qZbQ8QNKxNLWDUYEeP5XxwuGmtDR
 Bz4m2bg==
X-Google-Smtp-Source: AGHT+IG6zIVst4fam3ycj2QQzyd81h1e4xxXf0bTor2s5c8iE8a6MWU0szq+VZSbcxp0XJSKGVESRA==
X-Received: by 2002:a17:90a:3f8b:b0:2d8:ee39:47d with SMTP id
 98e67ed59e1d1-2dad4efe336mr14872686a91.2.1725990022993; 
 Tue, 10 Sep 2024 10:40:22 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04966d3asm6682751a91.38.2024.09.10.10.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:40:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 1/3] meson: hide tsan related warnings
Date: Tue, 10 Sep 2024 10:40:11 -0700
Message-Id: <20240910174013.1433331-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
References: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

When building with gcc-12 -fsanitize=thread, gcc reports some
constructions not supported with tsan.
Found on debian stable.

qemu/include/qemu/atomic.h:36:52: error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’ [-Werror=tsan]
   36 | #define smp_mb()                     ({ barrier(); __atomic_thread_fence(__ATOMIC_SEQ_CST); })
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index fbda17c987e..8a587bd52cc 100644
--- a/meson.build
+++ b/meson.build
@@ -504,7 +504,15 @@ if get_option('tsan')
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


