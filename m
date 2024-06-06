Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDD9C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAKQ-0006S8-23; Thu, 06 Jun 2024 06:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAKN-0006RH-Gu
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:26:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAKL-0000OM-QB
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:26:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42121d27861so9008595e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717669596; x=1718274396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i02CoQslFzum0YZSIl6mR+mSGbtebWVBNoZvi4aXxSU=;
 b=YAywtvlF5vg/sY2wdMwvBhsSOCHoCMu+51xk6OAxXXamnATvmE3brj/CmUVoH6ZMLq
 2hJwD6tX0t3N0W49Q1sQiCh3IS9KVtbB7F8dHd4gQgAJb/uDhWtiNhuI6fDMuYgg3zMv
 jzbcvv1aEAPhUBTx4rbDhLnh8Q7YDdz/bF4FxX2floEGRXbFOhwueTcK1LFwtXn2vnTV
 z8VgZjy/QHZnRsc9V9DunTQ79UInl8OSIvHEW31GIHe2x3i0ccV8lpU3DJrBOp7JL9sB
 ndyd2HkcxSXJZYMRcToOJNYS+H/XfaWPzcB2uzUldvYmDzGDPm7KabwJXklBd/emDRzq
 xFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717669596; x=1718274396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i02CoQslFzum0YZSIl6mR+mSGbtebWVBNoZvi4aXxSU=;
 b=YY4/ABujqYQIKKbh0hK/mkO/jy2BNeCezgneYY845QAMn09ZARAmkarJ9S1Z+bAPm6
 sysnGlW+5kSLev9I6xIC4Xn59sa7162RAROycx14RmkT5bUsMhx3iVP319Puj/wuoJxV
 3pZX/BOzerEE9kngTcyw0RRofNnBoYUYP+iraqP834lJzBAyU2TdbGg6i+2S5D3sVohH
 pt+moFSgDanyyHrRqcrIL4O2Buno3GKJ4aNAc6punqpIMFps9dAlZHQrzw28bIxRkHSc
 vzrXRj6SMcPiMlFlVZxkfsnz8hEd7Jtvdt7hWQofVW2OougTMP96eIc7CdP+nXOLYJIx
 aqVg==
X-Gm-Message-State: AOJu0YxtS/ZqFMuKdHmDj2ly9Nmh528Ky2wTAlSMew5KqRiRoVDuKyYQ
 zut389N9+F4K5EGjcXk1UE9QjV/A5nzyxybjXK+a53wTBPgcY95H9Ou7KEcq9wLY2+1k8xH9ZkB
 txKs=
X-Google-Smtp-Source: AGHT+IF32WnJc/Bqk6NkXNrIVaDQ8Vh6CSYorv3SAs0395rBHwtgeUOC6AIMSWQQsmdwMpXI5ZU6gg==
X-Received: by 2002:a05:600c:a48:b0:418:f991:713f with SMTP id
 5b1f17b1804b1-421562e7046mr42967195e9.23.1717669595766; 
 Thu, 06 Jun 2024 03:26:35 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215814f11csm51460525e9.44.2024.06.06.03.26.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 03:26:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH] tracetool: Remove unused vcpu.py script
Date: Thu,  6 Jun 2024 12:26:31 +0200
Message-ID: <20240606102631.78152-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

vcpu.py is pointless since commit 89aafcf2a7 ("trace:
remove code that depends on setting vcpu"), remote it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                   |  1 -
 scripts/tracetool/__init__.py |  8 +----
 scripts/tracetool/vcpu.py     | 59 -----------------------------------
 3 files changed, 1 insertion(+), 67 deletions(-)
 delete mode 100644 scripts/tracetool/vcpu.py

diff --git a/meson.build b/meson.build
index d80203f1cd..0c45c948d0 100644
--- a/meson.build
+++ b/meson.build
@@ -3226,7 +3226,6 @@ tracetool_depends = files(
   'scripts/tracetool/format/log_stap.py',
   'scripts/tracetool/format/stap.py',
   'scripts/tracetool/__init__.py',
-  'scripts/tracetool/vcpu.py'
 )
 
 qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index b887540a55..7237abe0e8 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -306,13 +306,7 @@ def build(line_str, lineno, filename):
             fmt = [fmt_trans, fmt]
         args = Arguments.build(groups["args"])
 
-        event = Event(name, props, fmt, args, lineno, filename)
-
-        # add implicit arguments when using the 'vcpu' property
-        import tracetool.vcpu
-        event = tracetool.vcpu.transform_event(event)
-
-        return event
+        return Event(name, props, fmt, args, lineno, filename)
 
     def __repr__(self):
         """Evaluable string representation for this object."""
diff --git a/scripts/tracetool/vcpu.py b/scripts/tracetool/vcpu.py
deleted file mode 100644
index d232cb1d06..0000000000
--- a/scripts/tracetool/vcpu.py
+++ /dev/null
@@ -1,59 +0,0 @@
-# -*- coding: utf-8 -*-
-
-"""
-Generic management for the 'vcpu' property.
-
-"""
-
-__author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
-__copyright__  = "Copyright 2016, Lluís Vilanova <vilanova@ac.upc.edu>"
-__license__    = "GPL version 2 or (at your option) any later version"
-
-__maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@redhat.com"
-
-
-from tracetool import Arguments, try_import
-
-
-def transform_event(event):
-    """Transform event to comply with the 'vcpu' property (if present)."""
-    if "vcpu" in event.properties:
-        event.args = Arguments([("void *", "__cpu"), event.args])
-        fmt = "\"cpu=%p \""
-        event.fmt = fmt + event.fmt
-    return event
-
-
-def transform_args(format, event, *args, **kwargs):
-    """Transforms the arguments to suit the specified format.
-
-    The format module must implement function 'vcpu_args', which receives the
-    implicit arguments added by the 'vcpu' property, and must return suitable
-    arguments for the given format.
-
-    The function is only called for events with the 'vcpu' property.
-
-    Parameters
-    ==========
-    format : str
-        Format module name.
-    event : Event
-    args, kwargs
-        Passed to 'vcpu_transform_args'.
-
-    Returns
-    =======
-    Arguments
-        The transformed arguments, including the non-implicit ones.
-
-    """
-    if "vcpu" in event.properties:
-        ok, func = try_import("tracetool.format." + format,
-                              "vcpu_transform_args")
-        assert ok
-        assert func
-        return Arguments([func(event.args[:1], *args, **kwargs),
-                          event.args[1:]])
-    else:
-        return event.args
-- 
2.41.0


