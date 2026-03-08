Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51735EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMim-0000iD-Ov; Sun, 08 Mar 2026 18:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMik-0000Vr-AJ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMii-0003HR-Ll
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439b94a19fdso6875169f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009330; x=1773614130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XM9jeNcCgTiWmoXI2IRnHd+zaADJdT6x62UupLcOabs=;
 b=d9VL+W/UZhbJanCqsseEFP9CGgXDK/G5SJiNpW0ynxr+94SMlv4raFz72rz5Q+8z86
 kjE0Vz7ktTQiQx3cPpVTbLRhyvKaVdGqNEMhmBp8m+YtCDcv5C+dSkznvDrw/1YUAZxk
 1JoaVO4Veml08ZnsdUZpZOiGpuqq2FhbCELJhVze7OT5HO/VNn1lCXwU8cJBsQzy8k24
 gHpZ6/irOT93DJP4a7qt0E2TZh1zSe/ghn3SpS4c/FGlsAYUGy6/8tdnGfuy2j1h7TB0
 z5U6C4Js8WYYVQqUbGb13h68NZQvkRlXEU/gNx95TuySbZsb1GMzTfBhAk56SoTdnEZR
 vVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009330; x=1773614130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XM9jeNcCgTiWmoXI2IRnHd+zaADJdT6x62UupLcOabs=;
 b=igni1m/TDkQOET3jTsC7CDwwMkbsbCvdZOF6KXZH8l4QuKlNcpbBKGZw+44YuVMxlq
 KlivyZG9lwL9IqBBw5HYyTpNnopm22IwFcxZyWLyOj/jLxBH9gvVUFre7LyDycvE5jD0
 zpDznGQb1xTqnlbkc3aWf7B9GN+XxGb/emPNKNLfSgm94kMuOxww/c0crQxflai9dPF8
 wW55hZHuHjWRnJNec418kYMfpPef+R1bJOn12PztEKaHqvUF7xK/edXeDTXULwKDcegz
 qA7jnzhZwcYhZlUE3grbq8TvGmpAougdr7CPJWVfzBRwTBtA/WuH+kb8mdRCFIwcnjWk
 QXww==
X-Gm-Message-State: AOJu0YyoYOMgcmGBYLBHfVcTPyCqTPdG8L0PiK3f+On+lpGDZk0hqivN
 GU6jcEwFDqTfhoCcGheTox2oVVQhXs50HYNlPg8stf5ylJeNDJ2PHINadMlqYEa6RHE48VPSO0v
 Bl+9uyJM=
X-Gm-Gg: ATEYQzyAP+yhCiGT5+CKimb//zv/FFmpm+UmZvZXv6fult3w+abfoSf7WhGwrPxGd2O
 PMusoNQXRzMCLmHUXMivJi/pEVxufLTs3zqLo7yhf+P1+QfPHkuzNJKrvwhB5WiAbAeC7gcK84k
 6pQiJIlNM7kIMLFRgCqMfvnzwvLeKooxD13B8NTAoiMQbTd/YiX2me1gaBlZPUXpHjZ1FOEh5zC
 IGJgg1GP9qDEQMvQTGrRicuY93eaAQdiQ7ZDJob0wz4FnbwZrt8PYSHIJ/a/lrV1Nxv5CpcRcVn
 jyE2cqZE+2NbkzwOGUM5kc78/9cDjKfJat0Fhv2lF01588q856hFgZoA4gwk10TZvRtzIqq0B+I
 OiFtv+X4jvFxdv3NqlJV44VIgDTRLDvkFzBxKYvQkTBywj7pDrJAOoYGqE2WzM/eu2jR6/1bSJu
 7cL/hv83Mv81Xb8xD26YxFyvaAv0gmqOlSPGbmFkHq4TsrSeI/Qze3myW+0w6kPlQyCNL1v3ziO
 HuVQg==
X-Received: by 2002:a05:6000:2388:b0:439:c1f4:302a with SMTP id
 ffacd0b85a97d-439da6543efmr16297624f8f.11.1773009330183; 
 Sun, 08 Mar 2026 15:35:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae49177sm21015655f8f.35.2026.03.08.15.35.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/49] hw/acpi: Always link QOM interfaces with system binaries
Date: Sun,  8 Mar 2026 23:33:52 +0100
Message-ID: <20260308223433.25503-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Now that acpi_interface.c only contains QOM interfaces,
unconditionally link it with system binaries, regardless
of whether CONFIG_ACPI is set or not. It is now easier to
deselect hardware models depending on ACPI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20260225035739.42848-5-philmd@linaro.org>
---
 hw/acpi/meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 66c978aae83..e1e848327b9 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,6 +1,5 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
-  'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
   'core.c',
@@ -36,4 +35,4 @@ system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
-system_ss.add(files('acpi-qmp-cmds.c'))
+system_ss.add(files('acpi-qmp-cmds.c', 'acpi_interface.c'))
-- 
2.53.0


