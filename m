Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C063C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdnP-0008G7-EO; Fri, 17 Jul 2026 04:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdnN-0008DJ-Qg
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:19:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdnM-0000PV-AU
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:19:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so31594475e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784276383; x=1784881183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ipG1R7zqfI+4JcRWgtDSWVMaJatrSESmdCbgn9Vy14w=;
 b=XWPoSyu8/h78kLNJdOKVdy3PI2g8+5fllaapYjuee6yKrXFMgIxD/vGKxIiofaw0+2
 KhesyhAhq4AHzf7kgRAAEbTLnivD7clqgEfq5nvGYCPzG/I5Ook/+vu+rjybjQr/4wjz
 ucqIectM9f+sxOSW2IphFHMkw3bJuhSMNmDWCBfECg4Z8MO47x1LPS12BdiyFFbbDmXa
 U1fiibYUQJPexvLvGVmyPgyV7ecVhTwjWKpW92ZTVjRKp18DhpvF1C4PxCFZZodsBmnV
 Z79nWAmAiWpOkJ9ND1BLQ1tAJl8KugU9Dr1jMc2zQeWlBlGmYPKPr2/7dpo7Y/9WVs+u
 8AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784276383; x=1784881183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ipG1R7zqfI+4JcRWgtDSWVMaJatrSESmdCbgn9Vy14w=;
 b=EIBcH++GkwbYmrJm9LxRrmuTTRg/yHZ8AoYiwiw2RCLzK/rh8c8BVfhMyhR9vyTLQz
 z+bx8m4XruHkX2tqG+pWkgAfBt9eR+b3UZd/9TUv7k/SK8LxSraDif2Dl13arTrxmSEA
 MUNICgLy0xOLBf0MK4BxcL1aBy8rjGtJ1/hl4jfeJZxdHAEloeW2Mu8C2bbh7p+YoI0H
 f3EvQDCLVJI8RII27ZDtUj8BqSmCWqafn81NNPvjzZ/PQvCV/e2o6QnnkNHLztEIKwoQ
 Ikxc/6NiFCWl5s3r0qj8yt9m0i3AAGVR7c3rn/AX5GEooHwY3frqAT2CEuz8lnjQITLh
 hgPA==
X-Gm-Message-State: AOJu0YzCgS6uQsohh3REg8B4Xf0Iz1VE+SNkyWDJB9/0kZPk3yfm/8ec
 UrsLqqWnFbjyKPhxe3c7CJ8mO66j4+26hS3mqkq9JVJMakfxfni4gZssGdV0jprnuqg=
X-Gm-Gg: AfdE7cnUHel20Krp1GKl6Gj37VjuOAzepjYJAZPYkrX+QQNAXmdco8cTs6HVy3fgT6W
 zGqO4nSpVR+7nbQhBQWEki7RhK6/K4Jv5DTlYQ9a40i7maOYAwkAyZywygnCA89Nk0uGjJ6cMDM
 gwy/j610X2epc2QY5s7nuQXze296/4+kIBOAMYm0r2pPYrJs7Eo7+2QGaycvPZl7v/624Dr1zAU
 a2uF6UYSs7F1/hFsaulf3dOjUMV8QIavUXdOkB0vjQgfKjp2dzKHtqyUERQAzTcwPo5GdkxMqJ2
 RqSC2WjkAtyVjJRsplNoy0VOeHgiGbjwabuZqDZrP9Cui81z0SnUqXzp4gHctKH9TWtcRR1CEob
 9/cUbiygh6TLdNfS+3uiJ1Ou0luBKSU6xkbfJH2/Etv0oCqC/aVNuP6AhZCglY3N0h+Bss7FfKd
 xPS73P61ynFFdBvy09feZz47rViUwlWXKcoElmAufcewfA7FoKKBLqfwthnKwg0HUBr/7XXQel4
 If9qtTuhInwnF7LbXtsEWwSHW/hLgZOn3isKIQnYzDq5p+pKHA=
X-Received: by 2002:a05:600c:a47:b0:493:e38b:182d with SMTP id
 5b1f17b1804b1-4954a4114a3mr17222855e9.22.1784276382349; 
 Fri, 17 Jul 2026 01:19:42 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c96fecsm36504285e9.11.2026.07.17.01.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:19:41 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 1/3] tests/qtest/device-plug-test: skip pc tests when 'pc'
 machine is unavailable
Date: Fri, 17 Jul 2026 08:18:34 +0000
Message-ID: <20260717081845.2439849-2-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
References: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wm1-x32b.google.com
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

test_pci_unplug_request() and test_pci_unplug_json_request() use
"-machine pc" on i386/x86_64. When QEMU is built without the i440fx/pc
machine, these fail with "unsupported machine type 'pc'".

Skip the x86 case when 'pc' is not available. Non-x86 architectures use
the default machine and are unaffected, and x86 unplug coverage is still
provided by the q35 variant (test_q35_pci_unplug_request), which already
guards on qtest_has_machine("q35").

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 tests/qtest/device-plug-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index 2707ee59..650956fa 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -65,6 +65,10 @@ static void test_pci_unplug_request(void)
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (!qtest_has_machine("pc")) {
+            g_test_skip("Machine 'pc' is not available");
+            return;
+        }
         machine_addition = "-machine pc";
     }
 
@@ -107,6 +111,10 @@ static void test_pci_unplug_json_request(void)
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


