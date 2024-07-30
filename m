Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C19C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 18:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYrjb-0000VB-AH; Tue, 30 Jul 2024 14:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYrjZ-0000U3-RO
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:38:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYrjX-0002z8-Ub
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:38:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so919405e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722364682; x=1722969482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/vtdDzygxbBO8QiNi6T+/m4mj8yS9Esv77ee7pN9FY=;
 b=gIU5IQp7UmX0r2I0E17oi6z3VnGton/my7oypF0ncORMk5WtlXmL3CITMNIfpSSGBl
 3d/FYvv2bD1XyDt9u455mlTDMHjaEzhl0r3TJo56/0ukeLl4I1xgBKgl3BCVXz5jEY9f
 iIeC26RslaJwv/vcnz2NoH2ZCCsdIT9DnCfkdKXxbdWTqGkV+cLuCgedWkGOyGHiIYXK
 5lx/+NKwOHIKzddbKCk9RJvvn3bhFpvH5AocrX3Yi/+opJ2vGKYaTPxF9d966WjJFmXF
 DasG8T2ghd6BDLHoBfY4Qm8jBMC2pXpQdo5hTh6gSc7WUowXj0N7rZA2a8rp91fYDj9C
 OrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722364682; x=1722969482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S/vtdDzygxbBO8QiNi6T+/m4mj8yS9Esv77ee7pN9FY=;
 b=LTzuLdTChhL5JdEWbS6dxIIc7QAupT3tEfaUu6I9uPdVU7Ru8sL1vQdfTJKB9v/jSC
 0zGZpuJcJSGO4GawBHxlEN5WjvCpOHchsL4oJpkXf7JZUMt2cXPvmRQsYlKgVIhm15Qv
 YyJpfClZO+3UP84lDy6uGgZrpt8YoSdEdJUgtA8e9aziXHm2qfb/sLOOGJHNAZHc7shO
 1KYOgmjnY0rpw8IJVqhoRzDnkqHBPdBGiHKh4f0gYseAx0hdDq2QUk+tcEBDmUPmWoPT
 CkqVPLOJ2kFl14CXWZjR7O8Gj5iNEKdP50MFXIzoo9ElReRD0ohXSm5h4V7EyNhLjg59
 f95w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzPy2SC8QkKTJDWZk6YhCv9u2B9DWr0fKlgDwJ90pChkl1ZLdzgP4pr9KImjcUJ0aO6kZD1OeMh6tyBe3cQ891tqEHhf0=
X-Gm-Message-State: AOJu0YyyxbWLIL6cZ9o+c2ciQPDp1gdZzQz7wfC9Zx4ixukd69uqJdf0
 V/Dyfhtwo/vcI2s55c8sYHISs7XA7I1oanUszzaZh0TzHRL8KcXG8iKnDyErj0k=
X-Google-Smtp-Source: AGHT+IGjVBg0NUuIY0v5mJAyQkAQ9ndyw/9Wjs0M0Woh/WEbvv3ZIQju6FF0X1R8kGWx0NjHZtCqOQ==
X-Received: by 2002:a05:600c:4fd0:b0:426:63bc:f031 with SMTP id
 5b1f17b1804b1-428243ee336mr19833385e9.1.1722364682084; 
 Tue, 30 Jul 2024 11:38:02 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057a6283sm224096665e9.32.2024.07.30.11.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 11:38:01 -0700 (PDT)
Message-ID: <f318834a-92e2-4305-9156-3c392b44f751@linaro.org>
Date: Tue, 30 Jul 2024 20:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/24] Convert avocado tests to normal Python unittests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> This series is an update to Thomas' v2:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg05805.html
> 
> wherein Thomas suggested someone could do the asset caching updates
> while he is on vacation:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06228.html
> 
> hence this posting what I'm calling a v3.

Changes included in my PR (can be considered as v2.5):
https://lore.kernel.org/qemu-devel/20240729152714.10225-1-philmd@linaro.org/

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae1..a906218f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -317,6 +317,7 @@ F: configs/devices/ppc*
  F: docs/system/ppc/embedded.rst
  F: docs/system/target-ppc.rst
  F: tests/tcg/ppc*/*
+F: tests/functional/test_ppc_74xx.py

  RISC-V TCG CPUs
  M: Palmer Dabbelt <palmer@dabbelt.com>
@@ -336,6 +337,7 @@ F: include/hw/riscv/
  F: linux-user/host/riscv32/
  F: linux-user/host/riscv64/
  F: tests/tcg/riscv64/
+F: tests/functional/test_riscv_opensbi.py

  RISC-V XThead* extensions
  M: Christoph Muellner <christoph.muellner@vrull.eu>
@@ -1830,6 +1832,9 @@ F: hw/isa/apm.c
  F: include/hw/isa/apm.h
  F: tests/unit/test-x86-topo.c
  F: tests/qtest/test-x86-cpuid-compat.c
+F: tests/functional/test_mem_addr_space.py
+F: tests/functional/test_pc_cpu_hotplug_props.py
+F: tests/functional/test_x86_cpu_model_versions.py

  PC Chipset
  M: Michael S. Tsirkin <mst@redhat.com>
@@ -1896,6 +1901,8 @@ F: include/hw/boards.h
  F: include/hw/core/cpu.h
  F: include/hw/cpu/cluster.h
  F: include/sysemu/numa.h
+F: tests/functional/test_cpu_queries.py
+F: tests/functional/test_empty_cpu_model.py
  F: tests/unit/test-smp-parse.c
  T: git https://gitlab.com/ehabkost/qemu.git machine-next

@@ -2101,6 +2108,7 @@ S: Odd Fixes
  F: hw/net/
  F: include/hw/net/
  F: tests/qtest/virtio-net-test.c
+F: tests/avocado/info_usernet.py
  F: docs/virtio-net-failover.rst
  T: git https://github.com/jasowang/qemu.git net

@@ -2236,6 +2244,7 @@ F: net/vhost-user.c
  F: include/hw/virtio/
  F: docs/devel/virtio*
  F: docs/devel/migration/virtio.rst
+F: tests/functional/test_virtio_version.py

  virtio-balloon
  M: Michael S. Tsirkin <mst@redhat.com>
@@ -2969,6 +2978,7 @@ S: Supported
  F: include/qemu/option.h
  F: tests/unit/test-keyval.c
  F: tests/unit/test-qemu-opts.c
+F: tests/functional/test_version.py
  F: util/keyval.c
  F: util/qemu-option.c

@@ -4127,6 +4137,7 @@ F: .travis.yml
  F: docs/devel/ci*
  F: scripts/ci/
  F: tests/docker/
+F: tests/functional/
  F: tests/vm/
  F: tests/lcitool/
  F: tests/avocado/tuxrun_baselines.py

diff --git a/tests/functional/test_info_usernet.py 
b/tests/functional/test_info_usernet.py
index ded973253a..cd37524d94 100755
--- a/tests/functional/test_info_usernet.py
+++ b/tests/functional/test_info_usernet.py
@@ -19,7 +19,7 @@ class InfoUsernet(QemuSystemTest):

      def test_hostfwd(self):
          self.require_netdev('user')
-        self.machine = 'none'
+        self.set_machine('none')
          self.vm.add_args('-netdev', 
'user,id=vnet,hostfwd=:127.0.0.1:0-:22')
          self.vm.launch()
          res = self.vm.cmd('human-monitor-command',
diff --git a/tests/functional/test_version.py 
b/tests/functional/test_version.py
index 5e566d76b1..3ab3b67f7e 100755
--- a/tests/functional/test_version.py
+++ b/tests/functional/test_version.py
@@ -17,7 +17,7 @@
  class Version(QemuSystemTest):

      def test_qmp_human_info_version(self):
-        self.machine = 'none'
+        self.set_machine('none')
          self.vm.add_args('-nodefaults')
          self.vm.launch()
          res = self.vm.cmd('human-monitor-command',
diff --git a/tests/functional/test_x86_cpu_model_versions.py 
b/tests/functional/test_x86_cpu_model_versions.py
index a5f27c737d..a7294b4b92 100755
--- a/tests/functional/test_x86_cpu_model_versions.py
+++ b/tests/functional/test_x86_cpu_model_versions.py
@@ -217,7 +217,7 @@ def test_none_alias(self):
          """
          Check if unversioned CPU model is an alias pointing to some 
version
          """
-        self.machine = 'none'
+        self.set_machine('none')
          self.vm.add_args('-S')
          self.vm.launch()

---

