Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CF0E6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOvj-0001eW-7g; Tue, 03 Dec 2024 04:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIOvh-0001eN-TY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:10:49 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIOvg-0001Fc-DK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:10:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a2033562so42920165e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217046; x=1733821846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4bHh0kKdBtmzzcHdsRt/PoJrfV1LywQT2NnEsM64kA=;
 b=SvmMLTrtExMM7g2qrGIRQOr4NfFrLrwSrfemzCtP+aNyITAsofNMEuid/R8Ft5L6Mo
 KUVJukG7eTjHcFPMdgUw3IpHquPQ961Vildq4k/TP8dA+U/h5zo8eu4wobDhJiPRYBLJ
 v/YPIW+SeWiISkNQ7GjNhj7MDFZ16gcFyhY++QKdWMaucb30BieZSrW+lC3HWYCpT3VM
 mC4nHLinjyE/3Cjz+Saejlb2bsqUtpuY94+KRD/V65/UOhg2k93J0eXGJm6inkCgZnOG
 7RSdIBHNXeJC8T66/O7al576WgcSCgsgTc40432VAcr6LnhKSVSgIyp3VsCfgqkvO/k6
 wS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217046; x=1733821846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4bHh0kKdBtmzzcHdsRt/PoJrfV1LywQT2NnEsM64kA=;
 b=CmJN+ZHRWXyPLb+j1saMlXh/a2aDC0Kkw7izrjmKXezoyCsf025Mw2KAVAwb+jajjs
 QT48UC9Av7nRlg38feHWtbPXkWRKAYxU2UJtiZi1c18daq+CKgmOXk9gVExarExLj5Bk
 D0Uz+nAtertuMNkG3VFi6HO31PjJl3VIa8ZDOyBDVe4DaVtwC1YFZQYE+VBWIfJD7lHh
 Zgb30Hg3GhUF8FBFfFu/sY0BCVHkX2z6vJs4hmK8QiPk6wpiDxVYeM3qla2qbMm3sNMn
 c3P1ctD5OMx1DrhAuCToeY25H7sG7QtP8ORm8BpxR9Vhxvbiz/dHz1a/otkwroI1xEF1
 xszw==
X-Gm-Message-State: AOJu0Yy4dDerX5boA04rA1eJiK2Wz8IsXsqcU3wsE/Cg7D10MXI0XRZw
 A/1Hxi6uGVwQgZkPC6XdHuGoJ8KXpFP7sUbUUYBLwev3XRHC4VAZHJ6Gf04D2dZMlgrC6kuDitF
 Z0O0=
X-Gm-Gg: ASbGncuwizgaSiueTvk/lHf8NtEXG9YO6FujmujH2yZ3M5vyqeVyildxhx64yUKKFCN
 ExxH2LQYbf9zbi5WMeYP3BbH8UWBZgf45dhZy8s2HAdPTT3YvxrbdIGMpYYQqmRZ0jmQUbHIKbb
 oRQEUj8u9QqQoEhWAf2o8dIVf2ryyEaQda2/T4i0Nll2CUOL3Y/WKna+tS+e4KoxIwz/ZoGjvQj
 ImFAWP9wZwhIpDqZqeV7Z+THTtFaQEcc7bydCPBBQPUHMbU9h29Y8vjJpakqgLmCf1/xfgl
X-Google-Smtp-Source: AGHT+IGZ9poAHH1KON0ivXiax5aCEePWIgYfWzCQZI1fkkbvl45eGw6rdxXPgXswotHOlms5JCrD2A==
X-Received: by 2002:a05:600c:19d2:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-434d0a03be0mr12522245e9.23.1733217046193; 
 Tue, 03 Dec 2024 01:10:46 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0d9bc5asm180591495e9.2.2024.12.03.01.10.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:10:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-9.2? v2 1/2] tests/functional/test_version: Use QTest
 accelerator
Date: Tue,  3 Dec 2024 10:10:35 +0100
Message-ID: <20241203091036.59898-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203091036.59898-1-philmd@linaro.org>
References: <20241203091036.59898-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

When testing with a HVF-only binary, we get:

   3/12 qemu:func-quick+func-aarch64 / func-aarch64-version                                      ERROR            0.29s   exit status 1
  stderr:
  Traceback (most recent call last):
    File "tests/functional/test_version.py", line 22, in test_qmp_human_info_version
      self.vm.launch()
    File "machine/machine.py", line 461, in launch
      raise VMLaunchFailure(
  qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
      Exit code: 1
      Command: build/qemu-system-aarch64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none -nodefaults
      Output: qemu-system-aarch64: No accelerator selected and no default accelerator available

Explicit the QTest accelerator to be able to run the HMP command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_version.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_version.py b/tests/functional/test_version.py
index 3ab3b67f7e3..d3da796991f 100755
--- a/tests/functional/test_version.py
+++ b/tests/functional/test_version.py
@@ -18,6 +18,7 @@ class Version(QemuSystemTest):
 
     def test_qmp_human_info_version(self):
         self.set_machine('none')
+        self.vm.add_args('-accel', 'qtest')
         self.vm.add_args('-nodefaults')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
-- 
2.45.2


