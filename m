Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3B3C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp61G-0005Mh-2d; Tue, 26 Mar 2024 08:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp61C-0005Ju-Or
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:06 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp619-0000fn-O7
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ea9a616cc4so1920518b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711456502; x=1712061302;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vX1JmAtVLzm5Q7uBUZ/7EOpmvFGga3JnBjC96Zw0g1A=;
 b=uOS6f4i7CSNTH/0RCXPG2DGfCO0nibQknadqKOOrhYEnQ9idYO7eJu3jYmNN1j1gQa
 kkoWqgbl1xieQfON6VTvx9owKgNLeIJz8swkbCbYctPe5FDjkSkmiP5MIGUig1SRazEq
 Qv2bIj8P05PUUyXh6raMzPJAKS3DUh0OZ6avRmxxcr+ckBvqBluPTdsgsfkNkuT/5ipr
 MhKHJ2dL//dyEou5VcUZJ4L3mu4ohEsi55T4nizWPktr+cIec3HGlSK0nPkNPItTlK7q
 SORXhDaW76Y9o4Pdm5RNepeRkUXz4NvlmAJTyV84Oa9b1YTLWgaRfw53c9URGfJnzPBY
 m/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456502; x=1712061302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vX1JmAtVLzm5Q7uBUZ/7EOpmvFGga3JnBjC96Zw0g1A=;
 b=pgZvpM6vJ6B5/5ciXnvg3LExM3MfRaHhIVxVRvKB7nPP4GMkBZRc8xQXxIzK76WOSY
 h2OWmUxmnejeK+svvnDoo55XUKqRVv7vr2Pxmpr8Sb2BA06NFXKlCGkr2BnyzlpARYtI
 EKgr4WeJXFCoXXPRuf1mCj8LQFDuoPacF/pAj1yLfmCWZ64JD6nN7iiGY4qAqQOuXysC
 ILjSYN5SmpBuMG9+y0SvCyAmxVAyIHDu+c6KYNhc6WIuwL2a2E3N/qpSVGrXoaSB7Xsi
 LLMMurAbI9Me42uKVFfUlfkB4p3PvLnmbG7MvIdJy0+PrmM6K3MWQxMbioq1NXut6tou
 U1pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNiOQvW0/+y7FcYYeDLBCFdP6RMSDLIDgDakYb4VkqyrBf3YZPiTCFmMEmC+uiAxRx1swHlf+v13NPO4T5t0f5NUdmh+U=
X-Gm-Message-State: AOJu0YxPrgDfPfSI9DjQsWBYVAeULS4gzf1ZurDMdNMx09ckdY1T0gux
 stMHGw36sn7fxCOo/RVpaVV7IUFH6TqX4ivr5CgV5O65WVuFDGsGpwpapUrtSq06XnrI6XiEqEI
 q
X-Google-Smtp-Source: AGHT+IGw781NsosIuzckyyEsihtawzJRU445U3WZQZZ9yet6j29luU2rY6CvelCTeUSAXSot+lhwww==
X-Received: by 2002:a05:6a00:198e:b0:6ea:b69a:7c71 with SMTP id
 d14-20020a056a00198e00b006eab69a7c71mr3453844pfl.19.1711456502215; 
 Tue, 26 Mar 2024 05:35:02 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 g4-20020aa78184000000b006e5a6e83f8esm5838952pfi.134.2024.03.26.05.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:35:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 26 Mar 2024 21:34:23 +0900
Subject: [PATCH for 9.1 v2 2/2] meson: Fix MESONINTROSPECT parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240326-meson-v2-2-d9f9003775e9@daynix.com>
References: <20240326-meson-v2-0-d9f9003775e9@daynix.com>
In-Reply-To: <20240326-meson-v2-0-d9f9003775e9@daynix.com>
To: Beraldo Leal <bleal@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.13.0
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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

Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 scripts/symlink-install-tree.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


