Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2211FD30006
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1miy-0005Rc-21; Fri, 18 Oct 2024 09:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1miw-0005RP-J8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:08:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1miu-00046C-Ld
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:08:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43055b43604so22059405e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729256934; x=1729861734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UGR7iSHGk8lfXN3BI6BgTa5CAUmbS2zygpRbJKf8t5w=;
 b=kKHnGHIXXolvu+BprCJoStvyumqyX30npudFEIGeQK4Vx6MaCa0VfXWplxTepo55Xv
 5BAFnqi1ThFa+6xCwojJBGNs4oTcOpaFF13Sc2OnvpEYPYHIG9WLmtKXoHW9/CS2y0sJ
 gxgFs/QAc9VFgSKRuAJHMHovrB/8pZBqbS6JvGuXC/u1jpFQKmJstFlWtjnLgKkCBJMJ
 I6zVP81Fs6hfY6lVglU1iFIVEP3p4HsxmIHcOtEN5oZ8IgXk1oXrie/+6HrhK2gtJFOe
 NFzpXI40Q/hXC8OKFZ64NLkJAKgPHRYDRHbTZg5XKjiwCetLuJY2SwdxWRCXZhc4ITI+
 BU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729256934; x=1729861734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UGR7iSHGk8lfXN3BI6BgTa5CAUmbS2zygpRbJKf8t5w=;
 b=pkpmhbt5WNKlAKvQWRBM84CTzJSAcr4/yQq1muxYuyXEjOERvhCk/EpwHbpbaDnqKp
 Vhqm9nNUJTho9LSCSabflxHbFDMED6hgC7VuJdJMVypJkMlS0Pj00KkTimxaB8mg/dLl
 8O53Yhg9wGNBdWgdaela5w38FstsfuCQLfxLIF3wdzgF1ik5eUTiwdqsMj1WvthVXZss
 Z5ScIxvZFZOenW7ndnM2LVM3lmhRKnUMG7udw8WPNt3gasyCPJLFsScfikOIm7NiMpEQ
 XoAmcsO9gl2w8z7L/I7qO10YUjAuGhuf32GXg6Oo+qCTxe8bfYfsPjiYsP0K/+Cy4XbE
 vMWw==
X-Gm-Message-State: AOJu0YxBJSE0tlbyJw+Kwt6yFnqlLFs+p+/HO+7NqrFqmTjTcX1LnIGm
 y3D2hoWtvsSAJw8l/y2nBepV6v1B6Qf/eaPKKNLlIIgS0xub7F/kK0h6L8cVk0bhu8hnO1FmzkH
 v
X-Google-Smtp-Source: AGHT+IGl3KdWfiD1zpfXHmXX0zoQ2J8TI+ubGEq5NYqngZw5i7YbCreQ8PxW3SdMQyl4WeTEsQbvRA==
X-Received: by 2002:a05:600c:3112:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-43161691af1mr18517555e9.32.1729256934386; 
 Fri, 18 Oct 2024 06:08:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316068ca06sm26979065e9.19.2024.10.18.06.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 06:08:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Christophe Lyon <christophe.lyon@linaro.org>
Subject: [PATCH v4] scripts/symlink-install-tree.py: Fix MESONINTROSPECT
 parsing
Date: Fri, 18 Oct 2024 14:08:52 +0100
Message-Id: <20241018130852.931509-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
must be parsed with shlex.split().  Otherwise the script will fail if
the build directory has a character like "~" in it.

Note: this fix cannot be backported directly to any stable branch
that doesn't require Meson version 1.4.0 or better; otherwise it will
work OK on Linux but will break on Windows hosts.

(Unfortunately, Meson prior to version 1.4.0 was inconsistent between
host OSes about how it quoted arguments, and used a different quoting
process on Windows hosts.  Our current git trunk already requires
1.5.0 as of commit 07f0d32641e ("Require meson version 1.5.0"), but
the stable branches are still on older Meson.)

Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
[PMM: Updated commit message to give all the detail about the
Meson version compability requirements.]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is essentially back to version 1 of Akihiko's patch, now we
have a new enough Meson; I just updated the commit message.
 https://patchew.org/QEMU/20230812061540.5398-1-akihiko.odaki@daynix.com/
(I have dropped the various reviewed-by and tested-by headers because
I figured the passage of time was enough to make them moot.)

 scripts/symlink-install-tree.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
index 8ed97e3c943..b72563895c5 100644
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
2.34.1


