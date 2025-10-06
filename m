Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759F4CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 22:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5tu1-0003xs-5V; Mon, 06 Oct 2025 18:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NkLkaAcKCpkG3OB67F9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--navidem.bounces.google.com>)
 id 1v5tfk-0001rl-Uc
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 18:27:13 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NkLkaAcKCpkG3OB67F9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--navidem.bounces.google.com>)
 id 1v5tfg-0003lm-LV
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 18:27:11 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-77b73bddbdcso5147461b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1759789623; x=1760394423; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B1cXNv96lcACiX7KRO44PZdVnnzKGIL857R1BiKOs20=;
 b=XkBR29xuegrdhs4px/cm2zNQPhNZqQbdcJSn9UtgBKYEabNUbOpjPa7sgbQouJ6sdk
 6MAn7LL3jRCxZDYVJs21gFajRLTMgl5YYEgb0F9JlIHPN0UxDyj25OwMrZt6T1l3S36P
 /Q7ZlaHpGDA3yiu2ft2AWpB44Bzd9cigsaGr4KCMBUQX55cK6OPfJ84+4XI/qNo+/Djg
 Zp/abr/OMe88aYq2pyffD9gzwcZb4fXq3VhOM06lwBCS79f83svO5RzwY1+S1PwIqJcG
 gR3sGCarY9wUb6pzkPNzlXIqc8a+8jHjJHFv4J4OfsKF8KdT2PqbwV2hybeyZ6rx27oV
 1L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759789623; x=1760394423;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B1cXNv96lcACiX7KRO44PZdVnnzKGIL857R1BiKOs20=;
 b=Roe5i8qnXAz8zyJyfi9hS9O38JPGLGW9DL1BjPKqZoiGHm+YMfN9yfptw2hVT4k+4J
 mMx2vZoU5tTWEbU5uvZeWH0jmBN0WQNtYQ+9qhZ8YERUp3zQftTsz+ar4PaqlSOX6Nrq
 4tKRBGWU6IRRVatbFMRNZIMrszHkcZGxVtSCn2uU9NKor53LtOlJ4FUBH51mXoA90cJb
 bLFQsfIqdzrRXdWb49NyHiYhwJ8YJ1Te/XQ3GLHxHEbOAYImySRV4SomeX4QiyCxOX0Z
 DAePNG8K42yXrTMrY++Dn9GiHnqa39twLQN1DYnYQW/n0eY9xXEBJf7KBHy0Dwm8Cpr2
 G8pA==
X-Gm-Message-State: AOJu0YwLyjEC70Tc5OIRt3wzlJ827p+Vkss8Hb4fdPsmf8cb6qUsWHEE
 wFYWqAYx9akil0qaABaZOe0VZlmrVcTAcCVDYXYpkb5K4NXQM5zjV3fq3YZmPfHRjHm2aHkBRQB
 N/ZkDVhCZR94Pt/URkrdjUlW6kB4feJYI/2XnxOyNKC6XmDw1MDEtdzQRx/J2eOpD29rM5Xl9E/
 5hViwVH7QxlB1y1Snyz2zRNmf3ZMWuJnMFJBKxYOwL
X-Google-Smtp-Source: AGHT+IEkpb2p+/PFysoyC55IHtwzNRQsCkjQHs+at9LcQJ9t6I+1hufmzrVf7dmnTYKvfF4XnFBDXrBvyZV9
X-Received: from pfhq23.prod.google.com ([2002:a62:e117:0:b0:77d:4a42:1179])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a62:fb1a:0:b0:78a:f579:15bb
 with SMTP id d2e1a72fcca58-7922fab21edmr940098b3a.3.1759789622991; Mon, 06
 Oct 2025 15:27:02 -0700 (PDT)
Date: Mon,  6 Oct 2025 22:26:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006222642.691067-1-navidem@google.com>
Subject: [PATCH] tests/qtest/fuzz: Add generic fuzzer for pcie-root-port
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org
Cc: navidem@google.com, zsm@google.com, Alexander Bulekov <alxndr@bu.edu>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3NkLkaAcKCpkG3OB67F9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--navidem.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Oct 2025 18:41:55 -0400
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

Add a new generic fuzz target for the 'pcie-root-port' device. This
allows the generic fuzzer to directly target the device's interfaces,
which is not sufficiently covered by existing fuzz targets.

---

This new target significantly improves code coverage for the PCIe Root
Port implementation. The baseline coverage shown below was generated by
running all existing fuzz targets with the oss-fuzz corpus.

File                     New Target      Baseline       Change
-----------------------------------------------------------------
pcie_root_port.c         67.7% (86/127)  10.2% (13/127)  +73 lines
gen_pcie_root_port.c     68.2% (45/66)   28.8% (19/66)   +26 lines

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index ef0ad95712..fd2ae47ca4 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -247,6 +247,10 @@ const generic_fuzz_config predefined_configs[] = {
         .args = "-machine q35 -nodefaults "
         "-parallel file:/dev/null",
         .objects = "parallel*",
+    },{
+        .name = "pcie-root-port",
+        .args = "-machine q35 -nodefaults -device pcie-root-port",
+        .objects = "pcie-root*",
     }
 };
 
-- 
2.51.0.618.g983fd99d29-goog


