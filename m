Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B50C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 01:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpIR5-00023W-3O; Tue, 26 Mar 2024 21:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIR3-00020a-Ti
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:50:38 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIR2-000848-72
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:50:37 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e0d6356ce9so19659165ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711504235; x=1712109035;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uREyk6RWhynxkM3LrQEj7fmpTF8ERnyaJjFlw7xKBgk=;
 b=iKCPeQ3SenFUh36E9PsQo077Pc5UCJU6I8nGJcKky/Gq+63atN0MJF7Al0RYOIR+u2
 8h2ffDDylFPVRyQafocxlLWjGFwQsTeeqAcbBh4wPin8SiXi5W3hW4N2AmltAF176/3C
 DxJCq6CUwL4CLQYz4P48gGTLGYwaByKp+W/XWlzOSzdFtOpu8wNSwYliA24CKhWXHJNA
 N9gWgwTR26meH80vIigxkrtSlFgmZvMbOZZW+UxNRVGw+RqS5RIv0Rwhk2Sc5BV4qcOk
 nOcPCk7V3Sl4RV7JWK9UgllDVZPO3UcT5fos6n9XhbEjg5o6ZXwiJQ7BZa4ecOsP27F3
 UDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711504235; x=1712109035;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uREyk6RWhynxkM3LrQEj7fmpTF8ERnyaJjFlw7xKBgk=;
 b=R4pJUX6Nbj4S0gPXo43v/99zsqpHjHjRadS/ZU27W3fzMKbvWp/FXwVtST7R+dvggQ
 npcxLtEQQKRkaLPT1Mme35hdEqmRKCod0qeWfNcG4wkLW93/cN18klPB0uMN8uQzJYG1
 FG/9Qz9TmfLX/9R1S93doax21XgDm8DkEvdP+eu1OO3VBl+LlpMmd9Z34SGZ9fuY6VAX
 ou9zTPEmuiqtSJ6bKtLm8Dq9iY0WyyHRs3PpkiqWeArO/muIC3KJjQdGOSRWADLXbL+W
 oysTvEViEhHgOfZLTEHkdlJ7mcLOdvGY8Pq6Eimj5IWcqVK9KHh+peODlXeJm+aQQ6kD
 UoQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDIiRWp4IVAAjb08wRs9TGYg3NHrefFpeKxpwDT99MgDHJxa9JuOuhqAfSvqsgwyPmfF7sfTnLc+3yDRGLmdC90GxBDEw=
X-Gm-Message-State: AOJu0YzXxqTHgHIh49BI/sLSgbby/oA6Hun/CXpIhl34/tqZ/pgYyBYB
 NPmGERLy2uozTpKsREakLtNGVu7rIJMz7G5pyZHGbCW3QpFjxr0Y1h/k2Xd89pk=
X-Google-Smtp-Source: AGHT+IEyjhf/HpFqzeTNpW9EIau15kfS5+0EBYTSjnFR43PR2i/61HU1Pvg8VfbcT7gfACtv2FfyCw==
X-Received: by 2002:a17:902:ce8a:b0:1e0:ca47:4d9b with SMTP id
 f10-20020a170902ce8a00b001e0ca474d9bmr6091515plg.29.1711504234908; 
 Tue, 26 Mar 2024 18:50:34 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 x3-20020a170902a38300b001dda608484asm7785894pla.57.2024.03.26.18.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 18:50:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 27 Mar 2024 10:49:22 +0900
Subject: [PATCH for 9.1 v3 2/2] meson: Fix MESONINTROSPECT parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240327-meson-v3-2-7e6cdef1be8a@daynix.com>
References: <20240327-meson-v3-0-7e6cdef1be8a@daynix.com>
In-Reply-To: <20240327-meson-v3-0-7e6cdef1be8a@daynix.com>
To: Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
must be parsed with shlex.split().

meson<1.4.0 quotes arguments in MESONINTROSPECT with the
Windows-specific format on the platform, which is incompatible with
shlex.split(). meson>=1.4.0 uses shlex.quote() also on the platform and
fixes the incompatibility so make sure meson>=1.4.0 on Windows.

Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 configure                       | 5 +++++
 scripts/symlink-install-tree.py | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 3cd736b139f3..57c2f1a2273d 100755
--- a/configure
+++ b/configure
@@ -956,6 +956,11 @@ fi
 $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
      ${source_path}/pythondeps.toml meson || exit 1
 
+# Windows needs: https://github.com/mesonbuild/meson/pull/12807
+if test "$host_os" = "windows"; then
+  $mkvenv ensure --dir "$source_path/python/wheels" 'meson>=1.4.0' || exit 1
+fi
+
 # At this point, we expect Meson to be installed and available.
 # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
 # We ignore PATH completely here: we want to use the venv's Meson
diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
index 8ed97e3c943d..b72563895c56 100644
--- a/scripts/symlink-install-tree.py
+++ b/scripts/symlink-install-tree.py
@@ -4,6 +4,7 @@
 import errno
 import json
 import os
+import shlex
 import subprocess
 import sys
 
@@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
     return str(PurePath(d1, *PurePath(d2).parts[1:]))
 
 introspect = os.environ.get('MESONINTROSPECT')
-out = subprocess.run([*introspect.split(' '), '--installed'],
+out = subprocess.run([*shlex.split(introspect), '--installed'],
                      stdout=subprocess.PIPE, check=True).stdout
 for source, dest in json.loads(out).items():
     bundle_dest = destdir_join('qemu-bundle', dest)

-- 
2.44.0


