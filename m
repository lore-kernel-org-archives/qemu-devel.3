Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB2C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 04:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7oY7-0005jr-6t; Thu, 24 Apr 2025 00:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oY5-0005jf-Bt
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oY3-0003Wa-GI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1531756b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 21:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745470254; x=1746075054;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5QF5JeRFPrjQjh285riWsSUyUV7OS4PwL49o9H6ac4c=;
 b=1Vy/9/k70Kd7hQ2a7calIV40wILLJ654Iuu0n2oekXfhpxEol3KuFaCQGVDlGBIbvx
 CL9NNJyeWCAD5XaUdMKAK4pUJFYFBf3NNuL6Rqt4p9gmYr0v6fQZ4n/UxruqxfGa6LVt
 ZRWDXKRobsOzidAEBJ4t6o39XuVIGEHo6wJGZbAl2UNE0wNbe63rCOjZvu4ZQ1iscZXO
 dZxxlypq/zoNgdcu9V2kpQT7FKo0jjCHGcAvykMMYa3IKFpgfRtDWkjoObacJpwJDGR9
 W5YpJYIRmb4utZNLhmoi2vqVUMJ3f0/T1y7u2oNqPigtq+lMCxsu/5hOB9ngAmvJ8kU+
 Z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745470254; x=1746075054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QF5JeRFPrjQjh285riWsSUyUV7OS4PwL49o9H6ac4c=;
 b=XJ1bJJzlGGG4BfMgepl0Zt8aWJRU7kPUiWZVagwYsDiQmIvqxQBA1K3rbNz1r1XC/s
 p0P8F/nuKU7azsWaTsT4zTElGt8Wbfk1PxUWnCCcPdNs4dsY0eil599yNfDSbsnOUEjT
 TIyQcpFrkhBdj3MmRRrt6aYmbg/ZJv+nKbAmK48lW71gVFKf9FliKaOrRLwKSnAtpqIK
 nvBY53rur52AX2jJNe6pgDsykfkVJCzC5hfd77cS5SU+qTKXkH/q2MOuookHXipoi+16
 2uGVoOmBuhd3BQlHpJKg7FOdD5rrHHW8pcoXQ7PswzOxZxTC7Eed74BPXehfcJFgMn0D
 vIag==
X-Gm-Message-State: AOJu0YzLHz5Fm696BuqWmg7X2ln2oFyJqWrlysRfzBNLlPPyqF6tHf6F
 mosy4jI2dsr8+PuM0i2GCUsBk2XlBJgsg0QG1+ApeWILXJGTQHwlBcKhMRuPGzc=
X-Gm-Gg: ASbGncsD/75qUl3qbKOgugkbYLPP9synCK7/FX6LpOTZy33voTQ6x0xPdVmvsamjwCb
 Yu7lZ9322+alrWgvW3Zc05EMY7UkmA13nlvoGxxwPopRlV8O0N9VxiMnxd59+IexZTxz0bF3gzx
 MENPid58Sapmg/1Fvmv1ZqLIQZitpAPh6XtHTa4RVuZc2n98D5blAHiL74xGFpql0vwRDuhpcmy
 ZPgUCUp18D6BWHVeUUxQpj+xSz0Q0BBXy7iiEjzSkRYT9fGyE5Itd9r7YyP+UQvXFGfmHrIAVgK
 w+DVgU21DPlSfJABKGBcpmFY/GG4HCot/1GKPY7PJKwx
X-Google-Smtp-Source: AGHT+IFqKU96alu7CjaL28KvtseBxTAhMnoGYF0XbFMNi+uImdD9Y2RT6wbAdb2GsvFt7cnURgUy3w==
X-Received: by 2002:a05:6a20:9c8c:b0:1db:822f:36d8 with SMTP id
 adf61e73a8af0-20445d26beamr1767342637.3.1745470253996; 
 Wed, 23 Apr 2025 21:50:53 -0700 (PDT)
Received: from localhost ([157.82.205.213])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73e25912c5asm473338b3a.6.2025.04.23.21.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 21:50:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 24 Apr 2025 13:50:14 +0900
Subject: [PATCH 4/4] meson: Use osdep_prefix for strchrnul()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-buildsys-v1-4-97655e3b25d7@daynix.com>
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
In-Reply-To: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

macOS SDK may have the symbol of strchrnul(), but it is actually
available only on macOS 15.4 or later and that fact is codified in
string.h. Include the header file using osdep_prefix to check if the
function is available on the deployment target.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0a35fc3fa9fe..8ec796d835df 100644
--- a/meson.build
+++ b/meson.build
@@ -2193,6 +2193,7 @@ osdep_prefix = '''
   #include <stddef.h>
   #include <sys/types.h>
 
+  #include <string.h>
   #include <limits.h>
   /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
    * function availability on recentish Mingw-w64 platforms. */
@@ -2657,7 +2658,7 @@ config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_alloc)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
-config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
+config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',

-- 
2.49.0


