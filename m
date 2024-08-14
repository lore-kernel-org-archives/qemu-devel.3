Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C27C52D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMgZ-00022F-Ch; Wed, 14 Aug 2024 18:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMgX-0001xi-VR
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMgU-0007La-FG
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:41:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so2702395ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723675297; x=1724280097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BA0vIbfMo/Ez2DzL8kYXbRUniB5/Y+edtyx+BnopKwA=;
 b=Fd74EX9L6YEtAnGPwwpxA1UGpXv65qOAejrKcULnerI2e8zP2JG0KGor+OlPP3MEZM
 oZsE0bD4ONYFNdPXC2GSHaZZ266X70Jf195VXOzTio6NkzSxKiCLZFKJlwMKK/oMt5F1
 zinQHgGmgJRyHrlx9QK9lOpkQM/n19WAc75LVAEOzLqkyFKnCeDiS/vtlUrixmLId4XK
 TQZ31oGRL+v4hry0BBLo42dJ48uL+1hs7lIAVU6UnD+kRZW4DSS/IwbzsTAs+iz0X4Qo
 o5HAcqK+OTg+wDeCFJYNSDqtm5v2lfph4HM1TjiUaF6da23xJsEsOYvJbPwv+b/EXegB
 exFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723675297; x=1724280097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BA0vIbfMo/Ez2DzL8kYXbRUniB5/Y+edtyx+BnopKwA=;
 b=sJq65+QM6FMGVKfj8tiD9VMyePcuLoVrvuFkY1dFgHorczSClrpa1xo8PXYmP/GfXD
 253n8oPr7VmEFY20kjhJybia46FhX2mkt/0LUPIPrnmh0tPPSp5XdR4ZsKfJKHA7xDWn
 7JZJKglDbOsZ4bAkK0tg1OeCq4pG2cUGTYS0452R5oSxiKQuBShFkcOSDlVFVlRISws9
 6uoPD4ZuIiAvF1EN6cDmvhy7fRHZGNUYTl9mLolxS2SG1o2eLDD9esVqysj7tFognifX
 rW8q0DZy+0YzHikm1yzpgo+HNnMPVyyju/864hetWRpW0Cfml1Z2r56djV0UB+EpWv1R
 lEQQ==
X-Gm-Message-State: AOJu0Yw0EEwQqy+tJxdQMwld/LUSrxgZYCSJpxMn3BDsYwg76Owq3PD5
 L0Ag9AhJ2x1mIkpV29GUgaLXL92J4Cnce9QiehFdXwe51rS2+HaAdrs6Zm2Dh39qKUGo8i++FVE
 lpzE=
X-Google-Smtp-Source: AGHT+IHLOMuA2xNQUnJ7j4Sv3gvsivnE3ZDnjeWx9uHlBTc7JPSjJLnmaTR7KYUm/tE1ewGigV07vg==
X-Received: by 2002:a17:902:e807:b0:1f9:e2c0:d962 with SMTP id
 d9443c01a7336-201ee519f73mr13281165ad.31.1723675297099; 
 Wed, 14 Aug 2024 15:41:37 -0700 (PDT)
Received: from linaro.vn.shawcable.net
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03b2874sm1225595ad.308.2024.08.14.15.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 15:41:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/4] meson: hide tsan related warnings
Date: Wed, 14 Aug 2024 15:41:29 -0700
Message-Id: <20240814224132.897098-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
index 81ecd4bae7c..52e5aa95cc0 100644
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


