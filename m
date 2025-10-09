Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35412CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6xv3-0004ql-2e; Thu, 09 Oct 2025 17:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39iToaAcKCi8YLgTOPXRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--navidem.bounces.google.com>)
 id 1v6xv1-0004qc-G3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:11:23 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39iToaAcKCi8YLgTOPXRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--navidem.bounces.google.com>)
 id 1v6xuz-0004eS-EN
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:11:23 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-269880a7bd9so30887545ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760044278; x=1760649078; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q0tFtzyt+FjI6rkGDEv+WSzzOsZAtXdzvzGPwjAg5wc=;
 b=JfO/w8rL8WaHQatX7YfUfJewwkgh9+Wzj+5nG13gAe9vq5uH3jjivSFfbgRFMuS6Jy
 hzKnG2WTLpdHkDkMyJgu8W01r6vQYetxrI1VfG2mxYY/WGD7R9VX7lz0Cy75Wb4rV5ll
 L+ZhAGFXC+633VneFhKwocIibu78CDv72k090iV/5GfOL8mBZfGaAf1gc/2qL5Udphpe
 yz6Mt6F60D6tdZYidp43n/H+en2efWBVmzBhj66Xiuke+Je9xgE7qa6+UdAKOsSAhRgg
 94SXeJ0cgmIXUCuW7fesVHe8ce0dCOXNlhRX5U7l+lTyarDwpve9yjy12kNyUAM8/KiR
 qbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760044278; x=1760649078;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q0tFtzyt+FjI6rkGDEv+WSzzOsZAtXdzvzGPwjAg5wc=;
 b=vPnoFBgrcsGUA0iLI52vmMqUyR6AJT8aQf+7gQJz1l6BeRWBgCZAF6ZDAOSSwgmIo3
 Zp59O8lJuE1pvwgUkhXViCL9pCP8XSp5SSXpdAXq8NODAmmn7NDGshnpv8LobA7inbKX
 sbe3x7BU9jFOUUxsPBoGWkXjRZI3TcfJ621ZqkdxyujQLnUa7MMPVIaMqz80vm3YLSTB
 Rn8tLvsMsMqS948stJ8QN8vaAwaGemSQz7O1tXmnkvs86GEco21EPNvQDAbQQbLq7Kv/
 DfQBttQH5LEhq1ouDeFG9hS1PVnZeFWPxlweXeIVtn1nlZPyXJdYA8cQQYgQZI0+mr/8
 m1pQ==
X-Gm-Message-State: AOJu0YzOve9j72kLIYq46gp6nWFgtSAnYZAyTHOkV8pVyLAE1TGTAqkN
 ensU4/gBBymh1Hu7sxbBpzrTQi0ORLeevUc8WoJTyQvLIgngbqiSGF3sZxIAHh06F96b13M8Qjr
 LP2U6nzRgcwdYaYxLIvEZSnaV0Sx7I2npWkcRTOLHjCu9Pfk6x1YjdPpA8eR5QjXyxO4eFan9ML
 hKHkQAv/XtAvhWMjvHUPitPVQgYVl4d5YtOsXd7SVr
X-Google-Smtp-Source: AGHT+IEjxUHtaBRgvdS8JX3l6pH1dqgm6gpXAUAFlRBkb7BZToCZxiuU3uswLKIrLiiCg8ho1Wy3UgYBYxbG
X-Received: from plsa9.prod.google.com ([2002:a17:902:b589:b0:269:9eda:4f2c])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ecd:b0:265:57dc:977b
 with SMTP id d9443c01a7336-2902741e47dmr104890575ad.61.1760044278280; Thu, 09
 Oct 2025 14:11:18 -0700 (PDT)
Date: Thu,  9 Oct 2025 21:11:14 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251009211114.2214848-1-navidem@google.com>
Subject: [PATCH] tests/qtest/fuzz: Add generic fuzzer for VNC
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, navidem@google.com, zsm@google.com, 
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=39iToaAcKCi8YLgTOPXRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--navidem.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add a new generic fuzz target for the QEMU VNC server. This allows the
generic fuzzer to directly exercise the VNC protocol implementation by
connecting to a VNC unix socket.

---

This new target increases code coverage in the VNC subsystem
and related networking and I/O code.
The baseline coverage below was generated by running all existing fuzz
targets with the oss-fuzz corpus. The new target shows significant gains:

----------------------------------------------------------------------------
File                       New Target                Baseline        Change
----------------------------------------------------------------------------
vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index ef0ad95712..2e802ab226 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -247,6 +247,10 @@ const generic_fuzz_config predefined_configs[] = {
         .args = "-machine q35 -nodefaults "
         "-parallel file:/dev/null",
         .objects = "parallel*",
+    },{
+        .name = "vnc",
+        .args = "-machine q35 -nodefaults -vnc vnc=unix:/tmp/qemu-vnc.sock",
+        .objects = "*",
     }
 };
 
-- 
2.51.0.740.g6adb054d12-goog


