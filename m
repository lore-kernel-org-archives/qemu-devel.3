Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA3BE9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57J-0000CD-Bt; Thu, 19 Feb 2026 09:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57H-0000B3-K7
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:55 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57G-0002zh-4D
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:55 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43767807da6so790935f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511692; x=1772116492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUapFwKk1B7hoKjOMc6Aky/R8hTLzdKuAY1fsScAA0A=;
 b=IIsmyRc0FkDAmC1Aco6/30zgfcd3y/rHlYyEUQbHJe6PSow7J4axVXKqEt/O79yOsX
 LK5DF+sU41a3TIq/wYlUTGsXLeKMIEDbq25H3+QvW4cDGp60rKwEaWJw7nMfeTt7D11e
 4AQ9gV7dnNWDM2mHkNuK/wgdFQJEKghBtNWUVvj3gRisXzuQqgY+WPsfTpZGKyYJel88
 AU24/4GNypwO9djY+WkTG4yMY9gcRynaNtPHDJJyBz8oX3/BQa0dtNGpUgrvHz8CU1hj
 H6E7ZD5B6rFPj50IhJo9+rtxxr9DB5bOs/PuvXZvXFmZ8EHCQawBWJeDmeVTHHB0xAPV
 elFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511692; x=1772116492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hUapFwKk1B7hoKjOMc6Aky/R8hTLzdKuAY1fsScAA0A=;
 b=WoyrlkiZGlO1hCAc1/J1AFHLlrSQQkH/vi0bKvKkeKuMU07GrSdxN66C54HDllN+SM
 dM7JNtu6WnvXyZwaxvD2xthSqbktZo3kfUHOsgAWTc7TV3IO0iggHUD0LRUafRgABQ0U
 jZeN8komFpueuwnnw8F0lUp8wvWeOahKNqYgRcLM3OSqT3OnDP1suH/7eTWnRoHG/RFK
 6tUGmmohTSgtZi9s/PD5nz9wFIMcw/2oltVwxe2W1TWEm0mAWC7VmN3uE5hhzGkzcuUF
 2RZ7VO1Wg8Rs4ide7lFsOT65AkAIQjT4ghcu3t//SGgg3RAVVGHZtcZSNvis0W2Uee1a
 kzrQ==
X-Gm-Message-State: AOJu0YyeBVgDWAy41Ou/zgzPnK5JfZ9bBkhbrZhzEgy9sOSBGPBodlJx
 1/Ds2rfAsn4ZlzrRCRgLvdnGN4L7iR0VqOU1CS3EgesKmBozx/xq5djhXn9rqF9K
X-Gm-Gg: AZuq6aKlM8vXopDgc3g9tBpEYyo2imxw1+zTY0oO+TwuauhDVoEpyqirLdp/UqhVnBE
 eypq1w1Ad1Pc4s35jEp4jV5H/pJXdWwXfMHYSfKPF4JQgpug4qnY2hqDn5Y8mlB6ZXzlUvvLD+D
 hvo2ozFEYrTNeGVm/bRUWbDt42AeBfwg6p0Z7gK2FECbko5fV9OIL0M3VOVJN/jIuEUWV6N3u7o
 Fnv96UIPPhfmKOKVVS9MahZz9G9Loo1D9o3YD63osX3fU+6PYKTqbcO50QW46TNHFLDosxKp2Ly
 RreJeT6m5DWaI5qd4ppum6jzoC0eYDoLuBIZTaD87V7UIBLuorCuc9AMSHwhGBOTicYCpvuSclW
 e9rZK15hqgH7sLrjb+bMWn8L2lJD/ZPQVvxiplD9hEFl2EPgYPjPTLWdtXRkqGespDSOIIGveL9
 9Cir4CpERX7pEirnP4woGdUtvWCCgIeuNb8PY+TC5fTYp6YBxqhn/r/X2NMCs888h5flp5
X-Received: by 2002:a05:6000:1447:b0:436:14d2:5414 with SMTP id
 ffacd0b85a97d-43958e52a6dmr8967925f8f.55.1771511692230; 
 Thu, 19 Feb 2026 06:34:52 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:51 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 11/33] hw/core/fdt_generic_util: actually realize device
Date: Thu, 19 Feb 2026 15:33:10 +0100
Message-ID: <20260219143332.3316679-12-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x436.google.com
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

Actually realize objects with TYPE_DEVICE after main
allocations done and properties set for qdev.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 2a3862b9ac..43fa862f31 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -681,6 +681,30 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
         fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
     }
 
+    if (object_dynamic_cast(dev, TYPE_DEVICE)) {
+        DeviceClass *dc = DEVICE_GET_CLASS(dev);
+        const char *short_name = strrchr(node_path, '/') + 1;
+
+        /* Regular TYPE_DEVICE houskeeping */
+        DB_PRINT_NP(0, "Short naming node: %s\n", short_name);
+        (DEVICE(dev))->id = g_strdup(short_name);
+
+        if (object_dynamic_cast(dev, TYPE_CPU_CLUSTER)) {
+            /*
+             * CPU clusters must be realized at the end to make sure all child
+             * CPUs are parented.
+             */
+            fdt_init_register_user_cpu_cluster(fdti, OBJECT(dev));
+        } else {
+            object_property_set_bool(OBJECT(dev), "realized", true,
+                                     &error_fatal);
+            if (dc->legacy_reset) {
+                qemu_register_reset((void (*)(void *))dc->legacy_reset,
+                                    dev);
+            }
+        }
+    }
+
     g_free(dev_type);
     g_free(props);
 
-- 
2.43.0


