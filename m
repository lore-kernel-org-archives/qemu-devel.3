Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12996C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWM-000814-9J; Sat, 22 Jun 2024 08:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWG-0007vu-W2
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:07:01 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWB-0000LZ-EP
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:57 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ec3c0dada3so36589761fa.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058014; x=1719662814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y/peQK2HWWhn2ma2SjoOX9PrYOZzJnJW241P1DXKLDo=;
 b=M/ap3v1FDFzv52L9BGdMKUQNQMK/seFFXNZ0/qnK1Ce2cZjPAUeog8/XBeTXEktBqs
 CWvqt807w5jAB1vgWVSsmwKeVy17uQwnkZ/3RkqwDKWjqFfffJFZ1Syw47ddrMONpIFc
 AXTeT3PrCFMK/Ov/tTpC3OZmUJd+24H/kP/FDWOeO4Q+R7CwZCCCrtl2sUzFmy1EBqLa
 OR0r8glw5fD/x7UTrjHoxc9bmdlM+MfbbvinC1ZqjZQFO21HQbdhza1FswjETyTVqX8S
 CByEhtMZ4LXZgmCRHQgKZPNYnVplsdrphZuhp/ZGOUo1Q8BxVzPCV4O3aFwIP/m86lN4
 cqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058014; x=1719662814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/peQK2HWWhn2ma2SjoOX9PrYOZzJnJW241P1DXKLDo=;
 b=v2ulQSSCQhMXKEkmXrylWE+/EzhEYvV02Kdaz9tZNTcRoKgLzuNuPiDE/KVLIKdWDv
 k4jERUBxiJWtibb4gQV1+9D/XJ5XQt4zVvU1dvNwYz1cNCfZdcHSWRwlAN5iu6OudzTi
 49GNGXmdQukFXdRuPpmDhbAImkhuBfLJqYk8c88zijPTpmtBvOoJVRJX7qabP1if26ja
 n0QtAlUnCybeiGqRudm2OeAvcDuDmZG+6SCAumdPIpzYjsjeLpUGPGcbhSBDnsBAw8sN
 k/NrdKDxvBVYTTi8ZpucZDsVZEY3lMCfgSHJDvkt+tWg3869NzSRR6XmRbfIJlM7axf9
 j3zw==
X-Gm-Message-State: AOJu0YydNV8Y20bY/R6lOtwQlndVrZcwPPMMzDSl7EegL0R67ceu8LTo
 8FvNgWYIaoxZbkoySNY0JXtIyYiu6J2kVK9yhU7kvRrGtCmO4LFm8ow/F0goxcIkV6LoFMX85Mg
 pa2A=
X-Google-Smtp-Source: AGHT+IH6BamVDuq5uANDGDgTnK6QF93UssX1lloTzUE3S4rJJMLgmIUC4uCQZGTM1BJZ76pFq5QH6A==
X-Received: by 2002:ac2:4e8d:0:b0:52c:df4e:3343 with SMTP id
 2adb3069b0e04-52cdf4e346emr803123e87.16.1719058013586; 
 Sat, 22 Jun 2024 05:06:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine
Date: Sat, 22 Jun 2024 13:06:43 +0100
Message-Id: <20240622120643.3797539-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

From: Xiong Yining <xiongyining1480@phytium.com.cn>

Enable CPU cluster support on SbsaQemu platform, so that users can
specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And
this topology can be passed to the firmware through /cpus/topology
Device Tree.

Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-id: 20240607103825.1295328-2-xiongyining1480@phytium.com.cn
Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/sbsa.rst |  4 ++++
 hw/arm/sbsa-ref.c        | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index 2bf22a1d0b0..2bf3fc8d59d 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -62,6 +62,7 @@ The devicetree reports:
    - platform version
    - GIC addresses
    - NUMA node id for CPUs and memory
+   - CPU topology information
 
 Platform version
 ''''''''''''''''
@@ -88,3 +89,6 @@ Platform version changes:
 
 0.3
   The USB controller is an XHCI device, not EHCI.
+
+0.4
+  CPU topology information is present in devicetree.
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 87884400e30..ae37a923015 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -219,7 +219,7 @@ static void create_fdt(SBSAMachineState *sms)
      *                        fw compatibility.
      */
     qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
-    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 3);
+    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 4);
 
     if (ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
@@ -276,6 +276,14 @@ static void create_fdt(SBSAMachineState *sms)
         g_free(nodename);
     }
 
+    /* Add CPU topology description through fdt node topology. */
+    qemu_fdt_add_subnode(sms->fdt, "/cpus/topology");
+
+    qemu_fdt_setprop_cell(sms->fdt, "/cpus/topology", "sockets", ms->smp.sockets);
+    qemu_fdt_setprop_cell(sms->fdt, "/cpus/topology", "clusters", ms->smp.clusters);
+    qemu_fdt_setprop_cell(sms->fdt, "/cpus/topology", "cores", ms->smp.cores);
+    qemu_fdt_setprop_cell(sms->fdt, "/cpus/topology", "threads", ms->smp.threads);
+
     sbsa_fdt_add_gic_node(sms);
 }
 
@@ -898,6 +906,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
     mc->default_cpus = 4;
+    mc->smp_props.clusters_supported = true;
     mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
     mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
-- 
2.34.1


