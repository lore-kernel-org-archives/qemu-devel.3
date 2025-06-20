Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1250BC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUa-0005iO-1T; Fri, 20 Jun 2025 09:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUY-0005Yq-74
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUW-0004uR-Lk
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a528243636so1159206f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424951; x=1751029751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5LZcCqNpH4GazYoT4HEePjvcf7hcAUKrr97H91/oS0=;
 b=OwuGRA/4rWsALA1SholNrd6ABxL+j8EhWV8nJOyLyRjDDXSQamSBiNufgEJl9kR/Vq
 /k7fNjRuHZ51du0IM+Qa5Id06pqAnfSsd/hlh3W09r2OIIRBrwPLffzt57sKQUE52+FW
 1vGFZky5SURlASTdj4xjQ61oJhX6weLmxhy8FERSOKh0SbWfQ2C7OPlYP3hoDAbIutcA
 4UfHYZeGVuCFB7UtwxJG1yLqjQAIhvVDhKREdqXXrU4gHeMBHZYjLyRbfxtf/2PFJYaB
 mf4hYKmYB0yffOoF4Wh0gMq6e+m+dqUZd04ObV9C2GOzPheLa4WAgKBbErBExXzvgPNg
 isHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424951; x=1751029751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5LZcCqNpH4GazYoT4HEePjvcf7hcAUKrr97H91/oS0=;
 b=o1ksA//G9oJvZJAgsQQ1hZQyufVu37CmTmRzHUvwOz8/cEc0hOpK6CRYrc3QAHlFuZ
 Y8TU9oJOVn/sH45A70FdZdTe+o6jC0KSXjrz8IqPtMn2RVy0A+IZ4nWDNg/xwSc1Pnlq
 crfRCQrsfZGVCWCsGiyhqihGAPJkximiXwfegD6222YrrlBrTr+IwDsNPdy0w69k74jz
 J4HUyn89m6ezuFjM+0464FE760+gPxfKBzHgzEPsFzKmW/JUrUwHVqDdpbbqgVTPKKk9
 ZaLOb2na6kzspa4X2G0P66hSECs9gKYhp69Av1UKfwA8xLECpGTTDnZVzXxuf4tUhgnG
 ctoA==
X-Gm-Message-State: AOJu0YxL5KFhkiUy1iI9DKro2XBmTq/x+SRhJ7ZDF4r80MwadzTmkMAP
 MTqbZg7Y+JOT+zYr05gpiTAA7YAXlD0LS4Nnosn7Xrdfi78mQ+zGPDOo/YQCe0eM2gEueWih0W+
 ZL0asV+s=
X-Gm-Gg: ASbGncv7nYLOQPtojF2m7hvXFc1iFCwSsoI1gFiwW+jdkGaJgpiwGT3NNgmzoAV6qu6
 p+pr55evGogz10bizWBc/i5CyA1uUuhnus2uoc6hhA8f7RZpDKFL+lzMWRMdeAz6jBQoOdy8y1D
 OEa5TBFMHfXbmrfXls9gU5oUL80wsjehpmKzwQfq+dsjfl2XlYyBu/Qdm1CjZYKKky0CPjg4I2m
 9cuVcI7El8lwdb2wt7PfNSVyIySs518+TaOJPAZW2Jl80yXYZI39XJYr8bn7AoEqZp3RGo5kzOZ
 g8QCXthFeVEHRuVAZlpkVu3YS0uNNrIQpemKbNMhb1JJ93jIadHhSZGChlM8KLkqj7y8AVr++g8
 EHCbdb6crYxTCJ+eHvwbt3aGBx33PGJwTwHpV
X-Google-Smtp-Source: AGHT+IFC6yofAEZU9uIg4ElHVXtdVlW8O/y3B6pNs8rlLb+5bVvaCqliz0NCeVD+ukrt5UnUQmDjdA==
X-Received: by 2002:a5d:584e:0:b0:3a4:e841:b236 with SMTP id
 ffacd0b85a97d-3a6d12d8c86mr2406728f8f.33.1750424950626; 
 Fri, 20 Jun 2025 06:09:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117bfd9sm2076809f8f.57.2025.06.20.06.09.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:09:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 21/26] hw/arm/virt: Rename cpu_post_init() ->
 post_cpus_gic_realized()
Date: Fri, 20 Jun 2025 15:07:04 +0200
Message-ID: <20250620130709.31073-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

QDev uses _post_init() during instance creation, before being
realized. Since here both vCPUs and GIC are REALIZED, rename
as virt_post_cpus_gic_realized() for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a9099570faa..da453768cce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2032,7 +2032,8 @@ static void finalize_gic_version(VirtMachineState *vms)
  * virt_cpu_post_init() must be called after the CPUs have
  * been realized and the GIC has been created.
  */
-static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
+static void virt_post_cpus_gic_realized(VirtMachineState *vms,
+                                        MemoryRegion *sysmem)
 {
     int max_cpus = MACHINE(vms)->smp.max_cpus;
     bool aarch64, pmu, steal_time;
@@ -2349,7 +2350,7 @@ static void machvirt_init(MachineState *machine)
 
     create_gic(vms, sysmem);
 
-    virt_cpu_post_init(vms, sysmem);
+    virt_post_cpus_gic_realized(vms, sysmem);
 
     fdt_add_pmu_nodes(vms);
 
-- 
2.49.0


