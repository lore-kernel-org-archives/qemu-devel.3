Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FD3C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7ZX-00040T-KZ; Thu, 05 Jun 2025 06:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ZR-0003z7-OM
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ZQ-0000Um-6c
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Okeje+ixEE/+O4/VwY4A/s56SZZy0f4ZBr76iuiWX8=;
 b=BbgjoyQbFWqHdYoY76edQyUigayDYLWrlSQWONZ+QzBrmzvbkbGU9WLxVi6ybbGSWsFFmR
 4hryCY8yy4fzi101rMECGndnG7TIksvAk8CqqSErVm6oTZBW7Fsyyza6PUYEcIsi9BRXbO
 VdNJPO3DBrCZXQ9HjCYR9um81LAIZw0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-mA-Td3uSNWWp9S5G8a-DiA-1; Thu, 05 Jun 2025 06:11:33 -0400
X-MC-Unique: mA-Td3uSNWWp9S5G8a-DiA-1
X-Mimecast-MFC-AGG-ID: mA-Td3uSNWWp9S5G8a-DiA_1749118293
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450787c8626so4273125e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118292; x=1749723092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Okeje+ixEE/+O4/VwY4A/s56SZZy0f4ZBr76iuiWX8=;
 b=C5iBrmjIcPm5FtppQT555hOdkfRpAiI76iAnx9Q0wuEW7pxRyOb2E19KXZz6mDg+g5
 r8PjPbSmJOaBcqWT0r3+in5zYk4NtFS31r7gk/A2zhUjK0iVLBhD9Q8dOOFEOvupJnjg
 pyz4Rud0AQPGailElrwpqqCmO1CX80jzO7Gy8BlBoV7uRHA7+iJ2jnrhC8nhbt3xNikH
 cakrNXYxD8FcFm9RUP1yYx0sF68jwqcl6VMan5rJi33ixMM91w9Eqoil2PsmMtme3pwV
 nK/bJxuGUeoHJMbzFu0Ew9yLNkx1VyKP+5NRJYb1WRPpv/rexwqRFwxtp751sB/anTox
 GFWA==
X-Gm-Message-State: AOJu0YwpeN9IZI8HjWUy+YjsL9GmbL148jMrwSvCVtrMGdxatTKYcSjk
 DFUe9wraMqh6NKdWQxANxX1ypkf7cmHtAV2mHDQYtKCGNmPje3CsHlFDJhhsctYQo3qYa4L6mpm
 b6j4bO2bFe4NQUIzHYAx3ARxLgvUnMBbjX8tK1o1LrubA0HvfF1/yS3zjm8FEw2Aqw6rh6yMvWL
 iX1TF5pqER4jnaXhSRZFdm5usEuKUrKJQQMzcBQBBW
X-Gm-Gg: ASbGncsV2WIUIQDdN5UY1f17ga6j9/jI2LdKQLy05bcdzM/nU7sJlfn+J7a6skckt2s
 6xWMWj7gDph1fX2UvHOvweIRH4vebF/q2oYb7XIX9QR3FVmQXlRHFpYloBGTh6wcbUk+ZeqWgVV
 NFxwbbpfJrNkYawamvsKIVyiM4DKQyTqsqkPa/8JZ60c+TmME2vUPgAAdZc0MPg85coEOCieMkH
 xZ4DlN/IYe3qXa3oM2XblMMmIsyMR89nsCqaWJMxYJ8B/XIp7pQmBKGCDnXpk/zbyo4rMUmbycH
 nBxRvSQY4vTyABwQk6xsiv7T
X-Received: by 2002:a05:600c:1548:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-451f0a72bf1mr63683055e9.9.1749118292274; 
 Thu, 05 Jun 2025 03:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv4BZlg7IQTIK1NtDnwdTwqHU4dpxMBjP2efyRRoVPnkVzK7U73suZEbmV9UEg/7tm7sE9wg==
X-Received: by 2002:a05:600c:1548:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-451f0a72bf1mr63682765e9.9.1749118291820; 
 Thu, 05 Jun 2025 03:11:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b962sm23785081f8f.7.2025.06.05.03.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:11:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-rust@nongnu.org, armbru@redhat.com,
 mkletzan@redhat.com
Subject: [PATCH 2/3] scripts/qapi: add QAPISchemaIfCond.rsgen()
Date: Thu,  5 Jun 2025 12:11:23 +0200
Message-ID: <20250605101124.367270-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101124.367270-1-pbonzini@redhat.com>
References: <20250605101124.367270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Generate Rust #[cfg(...)] guards from QAPI 'if' conditions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py | 16 ++++++++++++++++
 scripts/qapi/schema.py |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..a8ea5792c11 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -199,6 +199,22 @@ def guardend(name: str) -> str:
                  name=c_fname(name).upper())
 
 
+def rsgen_ifcond(ifcond: Union[str, Dict[str, Any]]) -> str:
+
+    def cfg(ifcond: Union[str, Dict[str, Any]]):
+        if isinstance(ifcond, str):
+            return ifcond
+        if isinstance(ifcond, list):
+            return ', '.join([cfg(c) for c in ifcond])
+        oper, operands = next(iter(ifcond.items()))
+        operands = cfg(operands)
+        return f'{oper}({operands})'
+
+    if not ifcond:
+        return ''
+    return '#[cfg(%s)]' % cfg(ifcond)
+
+
 def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
                cond_fmt: str, not_fmt: str,
                all_operator: str, any_operator: str) -> str:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cbe3b5aa91e..0fb151b5d89 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -39,6 +39,7 @@
     docgen_ifcond,
     gen_endif,
     gen_if,
+    rsgen_ifcond,
 )
 from .error import QAPIError, QAPISemError, QAPISourceError
 from .expr import check_exprs
@@ -65,6 +66,9 @@ def gen_endif(self) -> str:
     def docgen(self) -> str:
         return docgen_ifcond(self.ifcond)
 
+    def rsgen(self) -> str:
+        return rsgen_ifcond(self.ifcond)
+
     def is_present(self) -> bool:
         return bool(self.ifcond)
 
-- 
2.49.0


