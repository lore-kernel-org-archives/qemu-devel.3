Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB74CF8853
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 22:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swqMn-000501-KR; Fri, 04 Oct 2024 18:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swqMj-0004z1-Ge
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 18:01:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swqMh-0000f3-S3
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 18:01:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20ba8d92af9so20390485ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728079294; x=1728684094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B9aeWbyilAxD5P5/MJ59HQbUx4/6MyklNnTK3nyBp6g=;
 b=NIhZjziwqJSP3jHvZ9PvgZSRCf15qWrgnqBFMZljQX6QZIx3lMizBFEiiQQ7ifDl8V
 pUUAVgcWbRhISr9GvMt6ZHeGp1qQqX4FoV61ah2tUDACO441lEB4PZJg1b3/zsea3GyK
 1QVvkUqewT0mJWVZxj2O5oN65401jJzLR92QJZeoA/G+UOi4lWVTEnSJcCDIQG7T3yy+
 cHNb0EN4bktUHdLaKr6Y7lhT1zTPaGn1RRkzwYeoX+g/PqhRyXzyMwi69UwNw7mjUTb0
 usajmkEyUGwxKU0BseEf8HRYSy8Kbp1Ulzny1npR6X78naGsf+4OG95fo6HDJ0XDOPQD
 I0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728079294; x=1728684094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9aeWbyilAxD5P5/MJ59HQbUx4/6MyklNnTK3nyBp6g=;
 b=ApVNKr7CF0YkXetKrrac/9pAKZm/zrdjsknjKXSQQAro/Hj1I8zI3Y/RPnF0OjjjpY
 a6qyUD1L22I6xIGOlF8W+NR0mi0ISVklBkSTAFgPs+J5fa5IGFJWqzVZgtADPpTSGKs3
 3bc6DAL51GU1McIce3nHn+Om/tqnmgDO0sJxaqdbz6IE0/uINrH+O5sPM7deTjnljZJH
 A+IO7UQ02ez4YlfQ+7U5fuhMPqCQEty5c2J2q0GpBxDVqZeg9lbI0PoGO8JF0s6LDeWd
 EBjKnaJPF0pyawaqA2sGkGJIvqtqqsOCttvPit4hnsrRTRJAeMYCvMM08124FW0L+yeh
 GfWg==
X-Gm-Message-State: AOJu0YyYRq6Af0cdhrV6lew09myxTKQZSqN/qnFHD+pWaQ1zDAmJIYqC
 dv4dS1jtWp9/sqKkWEfGl8lPbWnOlKmvW1T+BzUN9IxY2HmGdpHfO6xVQdctXvOUR4yW+OoNnx7
 h4pU=
X-Google-Smtp-Source: AGHT+IE+NgML1OLUemowJJzI0gj42h4mW35RAJS5ldlXMkiO/5bLsLZzlR77enrqcI3DDeHF0jgtTg==
X-Received: by 2002:a17:902:d491:b0:20c:15d:c328 with SMTP id
 d9443c01a7336-20c015dc480mr43687355ad.56.1728079293787; 
 Fri, 04 Oct 2024 15:01:33 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13968ca8sm3054375ad.210.2024.10.04.15.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 15:01:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] meson: ensure we enable CMPXCHG128 on x86_64
Date: Fri,  4 Oct 2024 15:01:23 -0700
Message-Id: <20241004220123.978938-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Alex discovered that CMPXCHG128 was not enabled when building for
x86_64, resulting in slow execution for wide atomic instructions,
creating a huge contention when combined with a high number of cpus
(found while booting android aarch64 guest on x86_64 host).

The problem is that even though we enable -mcx16 option for x86_64, this
is not used when testing for CMPXCHG128. Thus, we silently turn it off.

x86_64 is the only architecture adding machine flags for now, so the
problem is limited to this host architecture.

Meson compiler tests are supposed to be independent of environment flags
(https://mesonbuild.com/Reference-manual_returned_compiler.html#returned-by).
However, CFLAGS are used anyway, thus masking the problem when using
something like CFLAGS='-march=native'. This is a meson bug and was reported:
https://github.com/mesonbuild/meson/issues/13757

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b18c2a54ab5..af2ce595dcc 100644
--- a/meson.build
+++ b/meson.build
@@ -2867,6 +2867,13 @@ if has_int128_type
     config_host_data.set('CONFIG_ATOMIC128_OPT', has_atomic128_opt)
 
     if not has_atomic128_opt
+
+      host_flags = []
+      if host_arch == 'x86_64'
+        # for x86_64, x86_version must be >= 1, and we always enable cmpxchg16
+        # in this case.
+        host_flags += ['-mcx16']
+      endif
       config_host_data.set('CONFIG_CMPXCHG128', cc.links('''
         int main(void)
         {
@@ -2874,7 +2881,8 @@ if has_int128_type
           __sync_val_compare_and_swap_16(&x, y, x);
           return 0;
         }
-      '''))
+      ''',
+      args: host_flags))
     endif
   endif
 endif
-- 
2.39.5


