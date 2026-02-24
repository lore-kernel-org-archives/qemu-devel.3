Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F23CF4BB71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux2J-0003mM-Qp; Tue, 24 Feb 2026 13:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1n-0002ZD-Ez
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:04 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1j-0004DV-GA
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso49514925e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957253; x=1772562053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMrzMs+5qnZDZw4ON9RGg3m4noDl7C7vdt5vXBtXLZI=;
 b=oKuQH81BSX49qKwVvPO/OEKvLevFxyAyZC+ZDK+gUemW2c3rQfxXqKETRhCB41D5r9
 qi/EMRQOKvHrQQQfGU6jePuV369v714eMvNc/sqPaFwIuXb2JCdUoW6vm2iTIOoDfRpj
 N/LRJYTXW0AtIStHKmKedlSqohJjzEXVLMjKnLPXtaXRCSJ1YVV9icYVLoVkheBjtef2
 1wIbEwZzc8+RtY0PnF62Mv84oGb913td2iFERB2eg3hyWb4n3SrLlrv4kDQqqPowE/K1
 4sQSEaSblxkGJZV6bO5MIE3vVJts8T8dEBwX4imuJEwLdMNVu/fUulq2qMBg5mqwi8Us
 s9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957253; x=1772562053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aMrzMs+5qnZDZw4ON9RGg3m4noDl7C7vdt5vXBtXLZI=;
 b=M4iCc4X/nv9ca33t3o6E014luSELCojK53hIrTqbBQxzSvSa/yP9r/blc2Gh1+xURc
 6d2Dg57c56EgULPHKvwuHnQQPh/KAacB8WrXytRc2ACMRhWGM80z1yqa5A5tU4FbeUu6
 C541UDxaVcKVNU9jBonvvqT5UVPlmqLfLw1/Mip0CFoYnbFsyF7RXAuH+byS/+ZZNyC8
 wJQVnCN9BbzVin5rCpPKPzPxQjrUJib9/4EKtSZfXeXzsMoye8zjcHAzU9sykr3AhV6i
 TE+lMJbU2wE8IXXLZ34eNY2fp2u3AuPsQW4SJjaJLNhsnJuzFUg5oitffeIPY9kfFoSu
 lcIw==
X-Gm-Message-State: AOJu0Yy7rvfSPXOk0bkI+ZbHYmi71J8c7C6xxO+65RqAKPUVDXq/OI7A
 R88FE35tDWDyRYOmAxu/0A6IQd25FZlUmbbDCCXhsGgYmlE94bRXUcZ24ARsfNnNT7yWw8TU45n
 g41tHpR4=
X-Gm-Gg: AZuq6aKnSDMDRvuSElkzLIjmafyqE0zSxA1H5abh4lichgC5vf/Pf5NjMjKbGuDZbBG
 UGxifuTSHYoy7dr9gassaoaA3w1sgdHDHyEWW8Dq2rducFb1YNETcr0kKSzq0ApSLfcMtfTOFft
 0oucDOmCSheuUB+OyRbnUQYt0f8EWWafhPiccjwVboltZnpOV4fXf7/OrsSjbF0E8+pL4z+72Zk
 EpKqPheNHHlK9EHFfIKfTH/BUyodS3xZRVr+NUCvnIWzFz/aB52XNHu2qQgaBVM1+hrcyGSWEta
 NkiEhTFB5mu6LWnWP58tTyJ45BGJrp/hkfXnx7xTcNzMtpwiWouGusdsWH4EikBzCTT6ks0MKMH
 ITSIsPgRhbJTWhry91OCmSxT1EWEHPEuQBYqaKHo2A5rVNFxWM1s0SUlEj50nmCBHbAIqaUoWbR
 UQyhcRCL57uyD/AA57Az3ZRM345nZaZaip+7vjsbZd7gjtVDRK1hufEiHcw4t932AKcIx/wwpp
X-Received: by 2002:a05:600c:3484:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-483a9603734mr220477695e9.13.1771957253172; 
 Tue, 24 Feb 2026 10:20:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483b8917aa6sm23038225e9.28.2026.02.24.10.20.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:20:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 05/10] hw/acpi: Build stubs once
Date: Tue, 24 Feb 2026 19:20:11 +0100
Message-ID: <20260224182017.99865-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/meson.build | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index e1e848327b9..1c5251909b4 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -6,33 +6,36 @@ acpi_ss.add(files(
   'utils.c',
 ))
 acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false: files('acpi-cpu-hotplug-stub.c'))
+stub_ss.add(files('acpi-cpu-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true: files('memory_hotplug.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false: files('acpi-mem-hotplug-stub.c'))
+stub_ss.add(files('acpi-mem-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('acpi-nvdimm-stub.c'))
+stub_ss.add(files('acpi-nvdimm-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'))
+stub_ss.add(files('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'))
+stub_ss.add(files('ghes-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: files('pci-bridge.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'))
+stub_ss.add(files('acpi-pci-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
-acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
-acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
+acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
+stub_ss.add(files('ipmi-stub.c'))
+stub_ss.add(files('acpi-x86-stub.c'))
 if have_tpm
   acpi_ss.add(files('tpm.c'))
 endif
-system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
-system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
+stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
+stub_ss.add(files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
-system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
+stub_ss.add(files('ghes_cper_stub.c'))
 system_ss.add(files('acpi-qmp-cmds.c', 'acpi_interface.c'))
-- 
2.52.0


