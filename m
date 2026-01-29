Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3F1D46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGy9-0005g8-0p; Wed, 28 Jan 2026 20:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGy5-0005aP-0N
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:37:09 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGy2-0003u8-BN
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:37:08 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29efd139227so2688945ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650625; x=1770255425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlNKtUy4USsxxNT1+cEEs4UoNHKdUf8Af8k1ySB//Nc=;
 b=LxIdCnPZOj/3Fo8ePM1aixQ8B1aFE17W6N8ZD43qSXakY0oWdRm60sMdmH4twhZmNV
 cXlXWpkj44C+q2D7J3ab1n8u4mBwJnnIN9LXccUKXJ1MeeEikF/Xzc5wTZ1j/YN1mQy4
 vC5k5NdI1KMJHRcGKfwKaI+DclPJYU7lEvg0tipxh5AqbODlXHfnrV2MChmrKBkFbHA1
 25Xnnhfm46z/GgCMK5KwIzT/Y/GmdVGRS/IbUYnxjVsHNw5iuLUzlRbxzoTxYRw7t/cs
 gsVpz0NC7z2K4Wx1jXgG8fy7QBNzTHsIoaUW1yu/C2Vc+n4pg14tDpMYH5SF6Xq2W5dF
 sohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650625; x=1770255425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rlNKtUy4USsxxNT1+cEEs4UoNHKdUf8Af8k1ySB//Nc=;
 b=fNr/PiSo9OuEmvBQ5LmSnl6pMqyOhSYUV4XV1q3WxQKBMkA6VOMkfGp/BlKjKd+zt4
 5qnSUStA89E1NxJV1If8c48PBthAWsj7eF0bnBhpRJWJd2+Zhon46uIHIaH2YSji+eEw
 L7uPw/i/h95p4CUJyR/Xf0QTvhK0/43rGZzj6NwaZbhY/y+Fobf/uzm2rZa2Nn7oqOMI
 8/Wgo0abYsVP6jw3BTbsHiO6jL5+1Lk/4mtcRoi211VP6HHRya8oF+arKtNnCRjyhK1l
 shVXpamqQekynGDk0BRzdFIWQ8ZcYkPkREP6jNhwoo0EIrcS+EzDa00Crhxlj9lEnjKI
 RSWQ==
X-Gm-Message-State: AOJu0Ywk+dk3DB6Y3EkTJHFkEsIN2jYHJlxVAl5yPoVMgJvADIgOPTPj
 Zt2GqOlDodpo8vg4k1t9czyuC8GPpBvVFzgHpKQ3EK/buaEFchH9yrLCObUxMZYG7tkDSKvAvE9
 Hhxwj
X-Gm-Gg: AZuq6aJDXKWo54hxCCMUl4z7QESsW0YRM+9dwLqMoZzvw88tuLy3BNvhZST15tdLBXF
 vxQs6V6g3J8hYwY2Pfd2Xaqo7KYEYWh1dVZ5v4FDJcALaZsyVJp4nMeps6xmif7w1YP45bnuIIu
 77heB3UyNp096emVqMFPqeCV6rrez1mmLwmI6CqKtYFgKVSi1qOdGM6nmRrfxOwA6vhZALXtP5U
 7SKBp+WAuUrLQpcAbKs2xX0ty+NvXjql545x8FxPUG1tqA+B7BUKzPS0kBcLPlp5D/LCqE06j69
 Q3MlKLbXQ0ZjsJH/CZuFr07ne2A2XeXg5LroaarnT495XFic8SgQBYkiL7hKNpm05CmRjNx84CM
 iwRbAQMYQHzazt/ugwGrGNBax/0nnNQO3JnOhOQec8caUDmvjt/IgM6ZlwqQE/aKoCFtNx7WY+1
 tWgnMz4Smah8PPByp3TeEJ4Xeuc4m8AQOEaNHaM79xusuhcXZeVhGff2mCFVTIITyX
X-Received: by 2002:a17:903:1a2b:b0:295:9cb5:ae07 with SMTP id
 d9443c01a7336-2a870e34aaemr69292435ad.38.1769650624964; 
 Wed, 28 Jan 2026 17:37:04 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4173a2sm34889095ad.30.2026.01.28.17.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:37:04 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/1] meson: fix build of qemu-system-microblaze with
 --enable-modules
Date: Wed, 28 Jan 2026 17:36:58 -0800
Message-ID: <20260129013658.3961469-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013658.3961469-1-pierrick.bouvier@linaro.org>
References: <20260129013658.3961469-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

A previous commit wrongly skipped including the generated modinfo in
case hw_arch dictionary ends up being empty.
Fix that by adding an empty source set in dictionary in this case.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3280
Fixes: e8efe5ff4 (meson: Do not try to build module for empty per-target hw/ directory)
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 668f1aa919c..cc0dfed0667 100644
--- a/meson.build
+++ b/meson.build
@@ -3958,10 +3958,6 @@ if enable_modules
     if target.endswith('-softmmu')
       config_target = config_target_mak[target]
       arch = config_target['TARGET_NAME'] == 'sparc64' ? 'sparc64' : config_target['TARGET_BASE_ARCH']
-      if not hw_arch.has_key(arch)
-        continue
-      endif
-
       config_devices_mak = target + '-config-devices.mak'
       modinfo_src = custom_target('modinfo-' + target + '.c',
                                   output: 'modinfo-' + target + '.c',
@@ -3971,6 +3967,11 @@ if enable_modules
 
       modinfo_lib = static_library('modinfo-' + target + '.c', modinfo_src)
       modinfo_dep = declare_dependency(link_with: modinfo_lib)
+
+      if not hw_arch.has_key(arch)
+        hw_arch += {arch: ss.source_set()}
+      endif
+
       hw_arch[arch].add(modinfo_dep)
     endif
   endforeach
-- 
2.47.3


