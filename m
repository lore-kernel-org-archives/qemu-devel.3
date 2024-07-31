Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C7C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8pJ-0001j6-5L; Wed, 31 Jul 2024 08:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8pC-0001hv-9a
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:53:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8pA-0007gN-9f
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:53:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428243f928fso20764915e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722430378; x=1723035178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3cSVkKu/r5SLLsfC0McF8QJVmIrqvnNAGcvwIC9pvgU=;
 b=DhiQxjnFni/MI+ZvhIyWMUSQNpxpFjhbLq4zFYv4alnBFN3TLO05opMFzuClTgXjJF
 na/Tncf+CUdgCWu5fSqJzM9fKwIFF7jMqv0nD7+k+O+HTIne2F6RlYXkb/ksU4pJI4YO
 A5Gm5+lR8AM4FgWKrJgTglmW06g2c+waDhLrfBiGYDuWS4XZn4U3Q14FWAwHrX608rNU
 y9yQBQNX3E4LMLNUWiAj+SWMLQR6GiwivS1LWCbO0DszqiY/+mTJAKq44wjP20MaFslx
 hmymPVs48iAKPYyKGA+/PSvNddeJZ94miqP8VoiCo6RPeA6WbcHbD/vDjBjhBNh8PAGV
 BuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430378; x=1723035178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3cSVkKu/r5SLLsfC0McF8QJVmIrqvnNAGcvwIC9pvgU=;
 b=bAG5lCEPku7L5gYSIj+7diWWatV6DWMbFssulilFGjpULdjH/+woY2Zspyrm9Qd8N1
 /11zUGHWtfwU9CWYJu2kHV915T0SFYH4+NO7grDQY5hhBEOLZIlcZROSQ59x90Wbgz9z
 F7S/wwFNXD/yTzViOQl32KZZNXlDrQ4dc+Fb2hM01FeMzA/0JOeUbiK49UrCiDViQ5gd
 ++ROW3Eah4kF7BXhn5m9f9BDFevwcD7VsL4LAK2vNKf1Smoq722GYka2WqK1+6NFrE3a
 sKWOZKTlP+ABxWK4fGjzdjTTX9mBhMkUa7VwNA6koDy8XrxW4vkxc3+K25gjqSvsRmgq
 SRmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXub0gnhEAQUl9qsItfqnketHmslTHYGfg9kVJCMmtLp2vmG5gvTHglJ82lH77VuHwcCoj5jyzdKBTGSK9MjiBoh6XXxuE=
X-Gm-Message-State: AOJu0YxVIZanaOW1lUgg89pT/7P+zgpCJZmRyJmZnJaGLZ2D74uZQil6
 F65I7Pt3D2o+V6lTyuOILZ/qJbf0bEVqPxsKiCyoYf9BHYDnW45c48Npb0GpQvY=
X-Google-Smtp-Source: AGHT+IGvLCO2I0k16XklEJhCn3AABZEILcJwlhOd7gUPhKflThf8excxjDhS83vTxc7HF2AXd2GiCg==
X-Received: by 2002:a05:600c:470b:b0:427:f196:c549 with SMTP id
 5b1f17b1804b1-42811dd43b1mr115574355e9.23.1722430378289; 
 Wed, 31 Jul 2024 05:52:58 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282baba484sm20141845e9.22.2024.07.31.05.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:52:57 -0700 (PDT)
Message-ID: <13e46f4c-a180-4b46-acfa-3449d1b172fe@linaro.org>
Date: Wed, 31 Jul 2024 14:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/24] tests/functional: Convert simple avocado tests
 into standalone python tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-7-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
> From: Thomas Huth <thuth@redhat.com>
> 
> These test are rather simple and don't need any modifications apart
> from adjusting the "from avocado_qemu" line. To ease debugging, make
> the files executable and add a shebang line and Python '__main__'
> handling, too, so that these tests can now be run by executing them
> directly.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  5 ++
>   .../test_cpu_queries.py}                      |  7 ++-
>   .../test_empty_cpu_model.py}                  |  7 ++-
>   .../test_mem_addr_space.py}                   | 52 +++----------------
>   .../test_pc_cpu_hotplug_props.py}             | 11 ++--
>   .../test_virtio_version.py}                   |  8 +--
>   6 files changed, 34 insertions(+), 56 deletions(-)
>   rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (89%)
>   mode change 100644 => 100755
>   rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
>   mode change 100644 => 100755
>   rename tests/{avocado/mem-addr-space-check.py => functional/test_mem_addr_space.py} (93%)
>   mode change 100644 => 100755
>   rename tests/{avocado/pc_cpu_hotplug_props.py => functional/test_pc_cpu_hotplug_props.py} (90%)
>   mode change 100644 => 100755
>   rename tests/{avocado/virtio_version.py => functional/test_virtio_version.py} (98%)
>   mode change 100644 => 100755

Please squash:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae1..a906218f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
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

@@ -2236,6 +2244,7 @@ F: net/vhost-user.c
  F: include/hw/virtio/
  F: docs/devel/virtio*
  F: docs/devel/migration/virtio.rst
+F: tests/functional/test_virtio_version.py

  virtio-balloon
  M: Michael S. Tsirkin <mst@redhat.com>

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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


