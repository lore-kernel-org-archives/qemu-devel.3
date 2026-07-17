Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE9AC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdnW-0000NX-Ta; Fri, 17 Jul 2026 04:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdnU-0000A0-VI
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:19:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdnT-0000Pm-DC
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:19:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so31595085e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784276390; x=1784881190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nLGpY643O2jZqKfla4Bau/QPP9FMH2aQ3gASY/wfNjE=;
 b=rYMhiDZIiO8qs1tNV5gibG+2bqWZGBwSzVlgkYQUy8YiNPAIRX4U7GQi8PCJd7/JWQ
 Vl94WNeOrTII5TT350ZvR/nBjeVA4A6szxL/Ht8+vCeMAV7Rhww0zTBYIDN3Dl+7k0qA
 5lbrRFD/FRu9JauIkLgYG8h88Q8CrVD2S9Mg1ORw24V9El0Vdmjby96gdpYdqk+XwFAE
 kmhcHvMFs0xDSPE9AERY5jELtSlQ9LJ5ejJaZsTTNUV8o2sSk7KDH52C0HAPKsky6rvY
 KHQzcKUaMw0JU3H5gK5gn1kYDhIVxye9vWUcV0RVhUQYHBDpp7zQfFiXKxqCAYV4CopU
 OU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784276390; x=1784881190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nLGpY643O2jZqKfla4Bau/QPP9FMH2aQ3gASY/wfNjE=;
 b=BYMfoALS0caQfS8I8EIJgnXcxDcdeXJKN2k0CzjCkWsH+eGbVDRTbUN65DaPpFxwen
 JtkDsg8DE+yKwGdebXXjXxXQYrnYftCXWdiVkvGf5ebrwE6w4LfPP1xtJnDdAi1PuNvZ
 63h7ZLpEQ9hxI+vEPd27pfx4Bl4IYF7BGjSLK5ERs3AY1qPFyWRDJMhjQexjRTOKot1O
 CYqr96iSTBZXafQEmhXDQSYp0NArQ7vqQhCkgdBQrK0rCoETUb1uwncF2s3/tiG27IAH
 TrnPJCrTFuCVLfHJoA06tJ7iKx9YMsRQHjmrDjQ8Oo7pcfB4Xf+4HPSCxpmt5c77kORa
 ML+A==
X-Gm-Message-State: AOJu0YwoHDf4sfQqGmumU3R2yq/wj1jZSFFDYA+VnQxWnGpO/90We04x
 cq22PhS9wI+4KS2/AwqckhtnK9ZQBnWSbeUF5LEOnjrc3Jv7hhD0/tKgOPsfGvVbZlk=
X-Gm-Gg: AfdE7cni73ikJ+Vp4o+ojGdU5iBGmTbR0JNT1paXbtUwFZm22kngmBsUaa+gwMNmmt0
 NTwOfAsD9fg6lMYVfSvtGVhI6QxktO1H+bMuiYvpFuyfm+45L7o7M0eBbcu35iJP9HOa6NTZ8/q
 bjTt2L/WrYOTSIG8B2jVxhqybjI+nK8sLvtxQceGEWp8Kvw4efH6+ZNwsFqbecpPpUBYJXRYz1v
 I1L8T4zet0lSeWFVhiegesYcxhYF4llxe6+fLvON9vpuCqq92LWSgEyXMmPRZEaqe4vdapda5z2
 IilM/jTQ7BWuWjclejdYMGg00tdAQbWxLc4Yoz4ZJ3bYfdZmKy+vKB5hOy+zh/74+f3LnRiUZWt
 4TtcJLx24rLiAJApAXrf5D3LOMOHlh1TzZbn6URTGJ9UQPEIfiZQglF7ZfAGFexGCfZDtUWVKK3
 EBvN9EBleUPXVMIp4X0toX/3hrNhjMkFTsPcC8PZHPhLQCaW3Df0af6Rj7+LtKKdW1784xDz4zY
 RiSa3O1XjtJBNWjESWE5nYu/dq1GVdTMh+5pcL/cTEf1y3UrM0=
X-Received: by 2002:a05:600c:4692:b0:493:bcef:565c with SMTP id
 5b1f17b1804b1-4954a3e6dd1mr16862565e9.1.1784276389415; 
 Fri, 17 Jul 2026 01:19:49 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c96fecsm36504285e9.11.2026.07.17.01.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:19:48 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 2/3] tests/qtest/drive_del-test: skip pc tests when 'pc'
 machine is unavailable
Date: Fri, 17 Jul 2026 08:18:35 +0000
Message-ID: <20260717081845.2439849-3-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
References: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rohitashv Kumar <roohiit@amazon.de>

test_cli_device_del(), test_device_add_and_del(),
test_drive_add_device_add_and_del() and
test_blockdev_add_device_add_and_del() use "-machine pc" on i386/x86_64.
When QEMU is built without the i440fx/pc machine, these fail with
"unsupported machine type 'pc'".

Skip the x86 case when 'pc' is not available. Non-x86 architectures use
the default machine and are unaffected, and the corresponding _q35
variants already cover x86 under qtest_has_machine("q35").

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 tests/qtest/drive_del-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 30d9451d..4c32da59 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -258,6 +258,10 @@ static void test_cli_device_del(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
@@ -332,6 +336,10 @@ static void test_device_add_and_del(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
@@ -403,6 +411,10 @@ static void test_drive_add_device_add_and_del(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
@@ -456,6 +468,10 @@ static void test_blockdev_add_device_add_and_del(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
-- 
2.47.3


