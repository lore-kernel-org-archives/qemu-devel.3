Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04679EE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTdO-00055P-4X; Fri, 06 Feb 2026 16:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdM-00054c-Lv
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:00 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdL-0002Mn-7D
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:00 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4832701b9b7so5695625e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414297; x=1771019097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3x0hcITYXuIkB3B9R8cqrzFl48FfUN7FUqWhhnyoDE=;
 b=QdCiPm1xsx4ocjrhyj9104MpvzjU0dtDK4hj8KJRFXSCqxUx5DrIXN4RbiXPkrzXH1
 CGlSKG+pHOZ9lasExm9gWEf0AuB/yzI3VVGS83Ub4g8q5EHRcvX18zADWNQVygyPOBzd
 nHi+PLHRRIASCBk3hYbYBJLTQUi5JzK/EPsIttmTTDS+SD9mzKuLGNqhGsHR2DMO77oQ
 y+SS2pk+uloiq/HG5ju+sU3+RYArE7qu2q0t4BskFCrZe+Xu8OtNzqqlYazhs26zSVSp
 VMrQ7kdNFwPry1i+o4Ttyw87X45H+CafTL5XIMFPXWx/Y7JFrqADQx5ODD8qzQrT2n9I
 9PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414297; x=1771019097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L3x0hcITYXuIkB3B9R8cqrzFl48FfUN7FUqWhhnyoDE=;
 b=VcG6+SzSbLxAcJqshwvUkAQVxIlDa25UOLP7fUvSY6mbWskff5xnEbL94iX5l8cilA
 D2h266ZEIsXZPUbTYstvWFKj9fYseG+l6iSr3/0MRDKatSZszDuOZTewVtib2l75FP3h
 Wrh1GE9siOqG2XRiWCMhc1XytdlUz7Ik3AN6/EQzf+d8SfEOXp0U1H0N0wXaEKudWedG
 0hYqQMQNF4v8T0a+nmUSJOAXZ0w59/fsQrw0vNQ1+iBlgep/69KN6cgmHZkd8VO8U5oe
 yL7z+ZP91Z+2GdvQVShhzov+kTU/N/AzutIY29mLGndgwpp73enKDOn4H8HtI9hq0VgM
 xS5w==
X-Gm-Message-State: AOJu0YwWT2yeyW8+2whmWRfoNwl4d3yaaVZM4m7t5rLfg4ctr53kGwF1
 QBrVVvLqx+29JRpH/qAbduapHcZg93IL914B2vDQ1/rQiA17JFKGzrbmBZrWV9ldZj+icihVypQ
 SnIxuNgA=
X-Gm-Gg: AZuq6aLnME5IEfRgpxA9eCw17v5P6WAzc0RFGfNP0Ro2gEuGtoCDJrUgcTRjdUFX2uD
 5TkNufdZ53/dlqyiHUQGYlB3VpvyCqJJOJAdljGfYkKk/Icm090Ag/JJZgQp8iWq4Omw3Kqsgqj
 ygON5w6/+WeShToRUSYVEdlqcisyzl/iSBQxIt0fp1FEWzlfTkRg+fhOz9bjrhQzkzEeB+GMZNI
 F9kzEBzbJuMTIR+GMksgbHwsBABe273B2M9Td1xvWQZ+vfb4FfcPtZmv15N+2w5HKzhLIlaIPv0
 Jn/J1k5sCbX8fDp3GN4hYuaMnCZeVPAxfvBQ8ees8fqwS1QGCUebXSOspS6Rx+66N+l5HUShU7v
 cIsjd8CRyUCCdmQ1aRXVGWgVFcpP//7pH4wp7WdjDePbsuASMLOWUbINSDeoyHz9VUI8+QUvLH4
 V9nWtOlGe9HFcXnBza+79P53sEjzWQqEwbp7ScsYDkw7/lbhOlX8cd088H8+AP
X-Received: by 2002:a05:600c:470c:b0:483:103c:b1ee with SMTP id
 5b1f17b1804b1-483201da9bamr61356065e9.8.1770414297084; 
 Fri, 06 Feb 2026 13:44:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4832097d8dbsm44175315e9.4.2026.02.06.13.44.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:44:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 01/30] riscv64/test_boston.py: fix intermitent test timeout
Date: Fri,  6 Feb 2026 22:44:19 +0100
Message-ID: <20260206214448.22008-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The recently added Boston MIPS board selftest times out consistently in a
machine running 'make check-functional' with -j 16:

18/18 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-boston
      TIMEOUT        120.09s   killed by signal 15 SIGTERM

The reason is quite boring: it is testing too much stuff.

Note that functional tests aren't supposed to be used as stress tests,
e.g. it doesn't have to test every single corner case that might hit the
board. It is supposed to catch most common user ooopsies. A timeout, in
this context, is most likely to be considered something abnormal slowing
down the emulation, not a lack of CPU horsepower to run all the tests
before timeout.

Some of the tests claim to test odd CPU SMP numbers to either "ensures
proper core distribution across clusters" or "validating proper handling
of larger asymmetric SMP configurations". But there's no SMP/NUMA check
made anywhere after boot, so in the end we're just testing whether the
board is able to boot with 7/35 CPUs. As far as these tests are concerned
we could have a completely broken, but bootable, SMP topology with 7/35
CPUS, and we're oblivious about it.

Remove the 7 and 35 SMP tests, keeping the minimal CPUs (2) and maximum
(64) tests. With these changes we're now able to run the test with a
good TIMEOUT margin:

17/18 func-thorough+func-riscv64-thorough+thorough - qemu:func-riscv64-boston
      OK              61.28s   3 subtests passed

Fixes: e71111e26b ("test/functional: Add test for boston-aia board")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Message-ID: <20260126174534.9860-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/riscv64/test_boston.py | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/riscv64/test_boston.py
index 2582df96f21..ec09544095e 100755
--- a/tests/functional/riscv64/test_boston.py
+++ b/tests/functional/riscv64/test_boston.py
@@ -66,25 +66,6 @@ def test_boston_boot_linux_min_cpus(self):
         """
         self._boot_linux_test(smp_count=2)
 
-    def test_boston_boot_linux_7_cpus(self):
-        """
-        Test Linux kernel boot with 7 CPUs
-
-        7 CPUs is a special configuration that tests odd CPU count
-        handling and ensures proper core distribution across clusters.
-        """
-        self._boot_linux_test(smp_count=7)
-
-    def test_boston_boot_linux_35_cpus(self):
-        """
-        Test Linux kernel boot with 35 CPUs
-
-        35 CPUs is a special configuration that tests a non-power-of-2
-        CPU count above 32, validating proper handling of larger
-        asymmetric SMP configurations.
-        """
-        self._boot_linux_test(smp_count=35)
-
     def test_boston_boot_linux_max_cpus(self):
         """
         Test Linux kernel boot with maximum supported CPU count (64)
-- 
2.52.0


