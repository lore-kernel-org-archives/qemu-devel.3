Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A44C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vbk-0008T7-4z; Tue, 15 Sep 2026 12:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbZ-0008Hp-LM
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:57 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbW-0003V3-Au
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:57 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f6c7a4aso404524566b.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488103; x=1790092903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CbPrT7PLvBDymN3EeZkp0K9KuC7aLbOtM142o2glIGU=;
 b=GOcxTr8IckRPJK5EJ2LJxvDgzFr6uZTMTILlhPWEVIKSGVAeps9fg1RXZKwy+tY++V
 MFvenDVFZ71An7bu60CucXjLz5xklTBuadnun8zEHh4LjvTQikGCUcUsr6EQk6UqeCt6
 uCWiCw/WjDOa7cD747nyC+ON8HaWPBkaWntFkI9vdZlzZ6pOwe0GQivXpOtojho1sEIf
 cpVfPwsRdsXcks1hY99qSkiEGQbRydQlz2sOM2BsW99LNfJhZc0xydsT8GrupFboygMA
 SArd5i0O/mb7QZF+ka5eTFpK27NoKSnLMltv8hJetjj1zYnl/fNtyUo8LLab6jSjseVb
 Y7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488103; x=1790092903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CbPrT7PLvBDymN3EeZkp0K9KuC7aLbOtM142o2glIGU=;
 b=V0oDRF8rXThawkBX65aL0we1au2As3II1YNN3zw7mDNnGre47Z7GNxh697qt+qedQI
 gnSCXzRT30Qf6dgsjh1ouZUViK/7rYnRk9LtN8RHc/ajlWonkJXfE0ECNaye3tpuYrL4
 SSSpYO1EkIcdzCmz2dmvVITTabRAXX3utaE4JaMvmEpnplyXLaFIzGV4t9hsXCPcq7Jw
 6D2W62Y413qwe9NVRjlJU4EVx1CpOOAtd4ZzZh3OtN6LUB0IS6veCRrdSJHL731667mz
 oYbxeCJWCvSV9pANEweKPPWtliKueDSDDXfu7HTIMQyPM3tMBOOl2fvi+g6r9wyiD2mV
 4D+A==
X-Gm-Message-State: AFuF++mvTV9z+teD1+pNi4YA/MqOqe01E7Yhr/9ZBHgp2oLv1AnxSLw3
 cT2kNAthtbSeMnYXVywFOma/+flBXCnMZlImgspcKmWFNRiFGy6xD9McyQ/Iqw==
X-Gm-Gg: AYBFou0oOOD3KWP2b7Y6BjVPFDbINah2sCqTwgdWH7hYKgvSA4NFyIBQ0T3xnmwcgQx
 mtOMM2HkCUHzoXzXGjwgA9wctbDUAmhMF1P68SulpOB7EOFrvvNcNDMxX8CK3W/SOS4lr3np/aw
 vIGfixpU8A1iCjxJoezNh6zSGMi1lKyBI1qA0k7d9dvog4Ok9QEeVA4/qeGyeqm1CBocQHPgpow
 h4uI87MZ9Nz2sLSh1bGvq/cDkt7LWNi3SWUW6yBMf+PGR3yxN5fttcNA2FZOy15jMfLgaBKs8rM
 PNynztlljiGlyRnEl0t1hyE6g84i+h00MCAtotIvVdldfRYgAj+dCnW5U5eSjN+wjGeIoUCxYlh
 FOxA1NBbs7q5GmIhPFMq6ILrtIksmfM63vZ5TVKvzSChrLuSUj66MXBlHR3fWzMRay3MXrfvDO/
 fJ/hiA0fCbja2FxHkwu+dIrzIaDzZIYO6eyZo4gV1Zz0YDoGIE7JihWcpqGBzYpfiNPt7Lz4CSL
 zerHWf27kYUtNSIfOZ1st9PZqwRWz7mkMkpfN71eHQtUQ==
X-Received: by 2002:a17:906:f597:b0:c25:541:fd3a with SMTP id
 a640c23a62f3a-c29b84d1bd1mr499723166b.7.1789488102788; 
 Tue, 15 Sep 2026 09:01:42 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:42 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 18/20] hw/core: Add Remote Port files to build
Date: Tue, 15 Sep 2026 18:00:42 +0200
Message-ID: <20260915160044.345788-19-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add the Remote Port subsystem source files to the build system.
These files are compiled when CONFIG_REMOTE_PORT is enabled.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/Kconfig     |  4 ++++
 hw/core/meson.build | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index d1bdf765ee..25f553e189 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -38,3 +38,7 @@ config SPLIT_IRQ
 config EIF
     bool
     depends on LIBCBOR && GNUTLS
+
+config REMOTE_PORT
+    bool
+    depends on PTIMER && XILINX_AXI
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 8fe776d2c8..74021c5f6d 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,6 +26,16 @@ system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
+system_ss.add(when: 'CONFIG_REMOTE_PORT', if_true: files(
+  'remote-port-proto.c',
+  'remote-port.c',
+  'remote-port-memory-master.c',
+  'remote-port-memory-slave.c',
+  'remote-port-gpio.c',
+  'remote-port-stream.c',
+  'remote-port-ats.c',
+))
+
 system_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
-- 
2.43.0


