Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5FFC3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyh-0000hV-Tf; Wed, 07 May 2025 19:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnye-0000fJ-O0
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyd-0007AR-0h
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22c33677183so4516875ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659697; x=1747264497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGmrC9Lpdjuz6pj+NV/O+8IjV/h+/Pk7pyNiZqlJEW0=;
 b=eyBRZDObxziNIhXqd0qHGWpxIxAU72VjVm/DVVx47QLC2mTqopv4Kt1k/+niwuI2Ns
 0tg9QrIh3PjmGvaJRF+P62Ars4JpY74lgvHK2gGPQak6/wVlLszzfFHoOv1jM0KdTjgC
 FJ3ynU7aEKOdOMhuhgJ/HsJstsFrG7i/1pNxuYhAs8GfXM8jAU7CdS34z7pcYIj9TYD6
 niBqtMUCxWqmkg+bdHsk+oLzh6M/uvDHbtIaUHg67xaMrfznRl1m06MQ7bPeicAzkl+i
 0Qt0The++7p5OLTwN/iV+vH2tbveXXndQrxpHRFcR2SYojwoUFELcKrfgN3nd0Y1c61P
 Aj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659697; x=1747264497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGmrC9Lpdjuz6pj+NV/O+8IjV/h+/Pk7pyNiZqlJEW0=;
 b=Cg+PpMVVEyKTVnncynSGt9mXyjXGK0JIuufPWlDEj7gZTtGaShUygkqrsiPAY8HEZ3
 4dBLJXdZrmqqHLyXmruxVpeBOckUQKuPNA93zw9NGfaBRIpuL1zJTjBLYApEiRVi5xav
 xTXSYA+4om1OCJnHK29k7A6bdPeHxhhZr1CGiJ0dMFoITAGDmgd1rdECCelAENDf+VWD
 BmfkxtM4vU0RWdWgUYOBxcYgfErPsK7EnEtPHDPZegvBA1I6mGiNPn+D1eX2SdYWN8NI
 ZY9vh6ToqvrMQE55TM+w8zQ7RMCi7zFUoHQZUKdAA7OtIWfFGiFOlNjJ/uESVZfo9pnL
 e6XA==
X-Gm-Message-State: AOJu0YwfK0rE8JoxpbH5UYcmMgvfJZJcJ47hG2+bU6oL6seRZgg28tXP
 WxtMF0SMCPV4cKk6nkdRaKRMB7xGhpULVEvTRqD7UryJVepXSVzqFVutz5ujVQ/B0JjsZjSLiqX
 LA+bePA==
X-Gm-Gg: ASbGncvsCPAKP18skToB2CbGTUNVyi6uNmkzHw5Rj2SxsBgXrvY+pKn8AwJlTvoLvfm
 Ueb3jWxyD2iTAv1EUnruQ0RcdDeQoEFJxUQLkkSGx3e+XEdNk2zmyUZ5Mgusqf8cO+WkeH7JoTf
 AJl2RgSpPDxB3HPF+4UwpJtbyLy4dhhbDCyWYBzybOzFk5Tya3kEpRzwMis7atotWXgdrqK5KAQ
 QAjfY1nD9Op9BrW+sJrRDQyIyxmRuUk0TA30owgsjtAnN72pRaFi3lGP8rwwIFy8X0ZRXM5/PMG
 gKISpuxWMsgYnPi5zPf7QgiMDvUYI+PEFPiHXCk3
X-Google-Smtp-Source: AGHT+IEani3JSVOhs5Z5oWh2cz6RTifIrIFSNJCuEeLYVx7K6r7hOXxD8yE6NX3/bdvZ2VnDbsVIvA==
X-Received: by 2002:a17:902:e743:b0:21f:61a9:be7d with SMTP id
 d9443c01a7336-22e5edfa34bmr75155445ad.49.1746659697678; 
 Wed, 07 May 2025 16:14:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 07/13] qapi: add access to qemu/target-info.h
Date: Wed,  7 May 2025 16:14:37 -0700
Message-ID: <20250507231442.879619-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Add a default include qemu/target-info.h in QAPI generated code. This
allows runtime conditionals to use any function defined in this header.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/qapi/commands.py   | 2 ++
 scripts/qapi/introspect.py | 1 +
 scripts/qapi/visit.py      | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 7b172f7c081..7776c84fe64 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -319,6 +319,7 @@ def _begin_user_module(self, name: str) -> None:
         visit = self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
@@ -354,6 +355,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
                              c_prefix=c_name(self._prefix, protect=False)))
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "%(prefix)sqapi-commands.h"
 #include "%(prefix)sqapi-init-commands.h"
 #include "%(prefix)sqapi-features.h"
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index c70b97a455d..a16d6bad012 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -190,6 +190,7 @@ def __init__(self, prefix: str, unmask: bool):
         self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "%(prefix)sqapi-introspect.h"
 
 ''',
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 82caf8c5f0b..6836eb8ed60 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -342,6 +342,7 @@ def __init__(self, prefix: str):
     def _begin_builtin_module(self) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 '''))
@@ -356,6 +357,7 @@ def _begin_user_module(self, name: str) -> None:
         visit = self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "%(visit)s.h"
 #include "%(prefix)sqapi-features.h"
-- 
2.47.2


