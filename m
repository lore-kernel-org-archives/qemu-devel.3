Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6095C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyl-0000jY-Dz; Wed, 07 May 2025 19:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyj-0000iE-6n
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyh-0007BW-DM
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2264aefc45dso6270915ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659701; x=1747264501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OQrmhMkBbkRAe+AcaFWJpAW3Ke/6y++HEbniG6kC24=;
 b=TWFe/eB7WTi0O55ObIAdj6hN2eiRF9yegOlUbqKRLOJ6iqVJftEi/p9QQDYOU2xTZ9
 UjdfGUoNx/7Aag0SfVT4MAvLOqCwcoe8sJGmRUSwCIMWFjowTCtH0JDXMWdLSNDjC6xN
 tgqQwZMxVSUG69vCoPLa9UuSAqqWSLHurSa1NiEYOAbIUhGTvOi7F2A3LHoem5PwIIZK
 no6y2Lffk29W/1rht/IvMs+Uy4atWbhGZJo5kbQBvJkCOdr8O8MAW5Jkr1cPOkOiFO8K
 gYxQHU0fLBtlVd17oLgevhLREZ91vIvXUCi06j1Dn7dulaJwvWfXMU9h5J2nPbtMK/rq
 XscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659701; x=1747264501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OQrmhMkBbkRAe+AcaFWJpAW3Ke/6y++HEbniG6kC24=;
 b=jlvVLfUSgHYFFlG4QoWl9oRxCQSU8My9BzxSKlJhWR1baC/sz3A4iYF1RA1SOik5+p
 OWWESqVktMJpHG9/92wRvUQFm//XtR+p+hQUxyQYSCZ4RbTYAAroRK+6nx/7T+IKsMXG
 UH70uFxPUPoO6xiA/hg7y/jQ8gxyiXXV5IJN6p5uMzEZo7ZtRfjaPIfjZvFLevorfIqk
 zl/x4/bO/y/v93HvQS1RVJQDZlOuM8Iy4cU2sceGlZZySsfXeE23FaBS64a0EoQi1r1t
 +Ari+WqhtgpL/sGLK6ZMoEGobkX5/mODQZxxI6oxnJTHQGdKz6P2P4m8cWF0A2IBTv+8
 i7Qg==
X-Gm-Message-State: AOJu0YyC129nZsrCd/c6V00jT5iRrTZGKwn456TilmlYZ7WZnr8GZnj4
 ndzorBs9RNEv6QznJUw6YyHB2Asz5amT8SMtVJJ6kN1ODdMbxpf/5Hh4pLXDqp32i3KRkzfNXVn
 yIIl+eg==
X-Gm-Gg: ASbGncuXFea5cd3s5Lycc21lbv7/dXiZ0NioPeyfCJrXpFCtVTa5qp6N5HaD18+9kCj
 oCedY/cDKVzaR3OBgyxm9aOOrrw7eIvfQSWd9oJtZyrOg2Xcnpi1sxaBoHG1026SyjM+LI9j59h
 2N/oekycTn0P+/t+zVjA/babTCY+hxulrxjXea/vd9edL7WAHdNAOVV0DGOjuBd8BbQO6E6q8UM
 8JTha6sTa5oUJmhUpNWu/qUH4HAiLr5DiQO/6piqkyxQUAXtJqzHSEi3zc8ng9oIf1TQd66wiEK
 xhOS2Ow018uuAlXaQX2y0CrHtgLeuZPHIVkI0uae
X-Google-Smtp-Source: AGHT+IG+cLuyPBEBE6aCAH9b7LPAbekby9wzqk444JvrOJITMXNwzzJmL0XyNhpUZAFNtYLfOOfWvw==
X-Received: by 2002:a17:903:287:b0:223:536d:f67b with SMTP id
 d9443c01a7336-22e8dc8f2f0mr17748245ad.38.1746659701254; 
 Wed, 07 May 2025 16:15:01 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:15:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 11/13] qapi: make all generated files common
Date: Wed,  7 May 2025 16:14:41 -0700
Message-ID: <20250507231442.879619-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 60fc958ec10..b8aa33ec9db 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -144,7 +144,7 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
   if output.endswith('.trace-events')
     qapi_trace_events += qapi_files[i]
   endif
-  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
+  system_ss.add(if_true: qapi_files[i])
   i = i + 1
 endforeach
 
-- 
2.47.2


