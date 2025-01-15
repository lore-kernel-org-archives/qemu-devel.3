Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916F8C02187
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjb-0001FY-78; Wed, 15 Jan 2025 18:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjZ-00015D-0u
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjX-0003rp-6D
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so1475135e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983413; x=1737588213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtVr4r34NQSIQO5b8dinugUm7VG2kyr9M3gSUVOEACI=;
 b=c1vEzXtqwVykYLPn1fI5agGsAcr9JAQA7oLPYXUKi2U8pUjSwSgYxgcIOkaAai6zdo
 yh2OWMOIG0/QYSawczdQ3hq0indRG0eFkeywl2HvQyEGoJv5jb8ceAisKHLFJCPWhOkD
 gT2m7RRzRJ/ZpEDYsPTAMqXum75kZVX1AbeUd4aZBzy+EJZYBnntiEC/7Gmi2Hr8jKzl
 MVyfbJGzOxtlXS6a6TSvI1YhXrzcSiOI7oIqF9PfDB8vokBdQ5gB2Z4bJoaNKNoas9Cr
 vQAioPXFTzR+gHAqdOtAGJSC/bLsLa+nYucOVJQ+pC5G3Qx/YIoyn3SXTo38utZ7CQ1J
 UVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983413; x=1737588213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtVr4r34NQSIQO5b8dinugUm7VG2kyr9M3gSUVOEACI=;
 b=S5E+5IUsqvI4qa7IuZ6ByY+NOW0OVhaZqisOXB/zr0MXrDy5awRwR/TflE5vrqoA7M
 8nTVDak5/fymv0hum4Zcj1f7GC+RfkmtA0lc+e0X5uUb7DxlYiH0ugDR+w2o0N5TSOSG
 DyJDeWqEiT9pPyWjjswsDUtGQNhz/zC45QdsfM2AfvHu52P9Dug6l0TYAg05l0eWJrWO
 z8BOgxmT+HkDm5hDC2WzIqv06kZ4pHIQEr1+GaEiHvxcO5IGGjc+7rITjnwSCCcSPNRH
 fWN12LOcbXOSHgt70m8DvTFb/YISWkLdztwcm71zf9Df2kmm2P7AqtuZ+xZPc5tYDnWh
 PX0Q==
X-Gm-Message-State: AOJu0YwchH3XIat7MvJn1zd23mbPDiunDzsUZG2OMW2n8o/uclMtDLQy
 pNFboVacmVgh/e6srFYQ2bi759pK66X/BBBwMyl/p97NmrGy6PPqFxoFB1D5XcsNLpQA1h0MwLt
 z3Dc=
X-Gm-Gg: ASbGncuu3yTbZCTObA3E5y94CEHFpzuXAPg/7Wtb4lg+eO8k+mX3fh4eeCzLWYGQe9S
 GkktCxjMIi9GVKGTyM2nJkQBX11xs99zMbWZTxo6P3JVtvhX0U8KwQ2VAE4/qmGWkMGqw6XZ5Qj
 4o6w8TiR3fCo0Y9nrFKT0SOJkhvTunusbXuLMJY2dptGHREAhAdTD7UAUV41WM4nhiYRBmPon54
 ctNWvjX3u6+H2dIax24q+suagsnfzzO+Jw8K4gVVSEEABMdkVU/UdFby2+ickw5uN5X7sIVIV1Z
 aiENflPKqpAsVMDzY18mV/NkvJkkBTI=
X-Google-Smtp-Source: AGHT+IFqETvma2LLKyg0yB6yeVeoENyeDtumRwcDAA8uvIiSiSihe37ZvLYtPYCcoU1HDvdZVopRNQ==
X-Received: by 2002:a05:600c:a09:b0:434:f1e9:afb3 with SMTP id
 5b1f17b1804b1-436e267863emr268361935e9.3.1736983413393; 
 Wed, 15 Jan 2025 15:23:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749935fsm39309645e9.3.2025.01.15.15.23.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 08/21] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
Date: Thu, 16 Jan 2025 00:22:34 +0100
Message-ID: <20250115232247.30364-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
via the 'extra_mac_registers=off' property. We removed all
machines using that array, lets remove all the code around
E1000_FLAG_MAC.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/e1000.c | 63 +++++++++-----------------------------------------
 1 file changed, 11 insertions(+), 52 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 3d0b2277039..14d2133cd80 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -127,10 +127,8 @@ struct E1000State_st {
     QEMUTimer *flush_queue_timer;
 
 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
-#define E1000_FLAG_MAC_BIT 2
 #define E1000_FLAG_TSO_BIT 3
 #define E1000_FLAG_VET_BIT 4
-#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
 #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
 #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
 
@@ -1218,46 +1216,17 @@ enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
  * n - flag needed
  * p - partially implenented */
 static const uint8_t mac_reg_access[0x8000] = {
-    [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
-    [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
-    [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
-    [ECOL]    = markflag(MAC),    [MCC]     = markflag(MAC),
-    [DC]      = markflag(MAC),    [TNCRS]   = markflag(MAC),
-    [RLEC]    = markflag(MAC),    [XONRXC]  = markflag(MAC),
-    [XOFFTXC] = markflag(MAC),    [RFC]     = markflag(MAC),
-    [TSCTFC]  = markflag(MAC),    [MGTPRC]  = markflag(MAC),
-    [WUS]     = markflag(MAC),    [AIT]     = markflag(MAC),
-    [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
-    [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
-    [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
-    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
-    [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
-    [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
-    [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
-    [RUC]     = markflag(MAC),    [ROC]     = markflag(MAC),
-    [GORCL]   = markflag(MAC),    [GORCH]   = markflag(MAC),
-    [GOTCL]   = markflag(MAC),    [GOTCH]   = markflag(MAC),
-    [BPRC]    = markflag(MAC),    [MPRC]    = markflag(MAC),
-    [TSCTC]   = markflag(MAC),    [PRC64]   = markflag(MAC),
-    [PRC127]  = markflag(MAC),    [PRC255]  = markflag(MAC),
-    [PRC511]  = markflag(MAC),    [PRC1023] = markflag(MAC),
-    [PRC1522] = markflag(MAC),    [PTC64]   = markflag(MAC),
-    [PTC127]  = markflag(MAC),    [PTC255]  = markflag(MAC),
-    [PTC511]  = markflag(MAC),    [PTC1023] = markflag(MAC),
-    [PTC1522] = markflag(MAC),    [MPTC]    = markflag(MAC),
-    [BPTC]    = markflag(MAC),
-
-    [TDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [PBM]   = markflag(MAC) | MAC_ACCESS_PARTIAL,
+    [TDFH]  = MAC_ACCESS_PARTIAL,
+    [TDFT]  = MAC_ACCESS_PARTIAL,
+    [TDFHS] = MAC_ACCESS_PARTIAL,
+    [TDFTS] = MAC_ACCESS_PARTIAL,
+    [TDFPC] = MAC_ACCESS_PARTIAL,
+    [RDFH]  = MAC_ACCESS_PARTIAL,
+    [RDFT]  = MAC_ACCESS_PARTIAL,
+    [RDFHS] = MAC_ACCESS_PARTIAL,
+    [RDFTS] = MAC_ACCESS_PARTIAL,
+    [RDFPC] = MAC_ACCESS_PARTIAL,
+    [PBM]   = MAC_ACCESS_PARTIAL,
 };
 
 static void
@@ -1419,13 +1388,6 @@ static int e1000_tx_tso_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool e1000_full_mac_needed(void *opaque)
-{
-    E1000State *s = opaque;
-
-    return chkflag(MAC);
-}
-
 static bool e1000_tso_state_needed(void *opaque)
 {
     E1000State *s = opaque;
@@ -1451,7 +1413,6 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
     .name = "e1000/full_mac_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = e1000_full_mac_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(mac_reg, E1000State, 0x8000),
         VMSTATE_END_OF_LIST()
@@ -1679,8 +1640,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
 
 static const Property e1000_properties[] = {
     DEFINE_NIC_PROPERTIES(E1000State, conf),
-    DEFINE_PROP_BIT("extra_mac_registers", E1000State,
-                    compat_flags, E1000_FLAG_MAC_BIT, true),
     DEFINE_PROP_BIT("migrate_tso_props", E1000State,
                     compat_flags, E1000_FLAG_TSO_BIT, true),
     DEFINE_PROP_BIT("init-vet", E1000State,
-- 
2.47.1


