Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB0DC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn2xf-0004xx-HW; Thu, 23 Jul 2026 19:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wn2xd-0004wa-5U
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 19:36:17 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wn2xZ-0001d4-Gv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 19:36:16 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-456f7012050so729339fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784849772; x=1785454572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d16CZApBwdbjAv2BZVQc7wNcffZyxmsi63Xs9rslxdM=;
 b=QzN8EiHNvVhPVFiDYeSrPnwssJYO74uyEeLre4ehsPjja4jKwtS5rzIUDn3PaCDt+4
 pZhu29Vic1KZ7VG2wTshREOb2bRbypYaWlgcp+6hV63mYe0vbcvscvv+27HwDap5SPbw
 BvC4rydRiZCzc095/zQ2OGWnxtha+TufkmthR1vvXgdgANGcdXE1qjGRdE3vD2ZN9wHN
 nyPfe7+5GWp9LIG6HXU6x/z1/TZjMuLiVmAJYqfr8CYsiXpGYe9AKz/Cp/3Q4/f3Z9+K
 PCJQ2Rzg22aaMNwMYiUbWWFZuA/uon89mdgnWj6m1qr7Tpv1sEgYII+vYs8A+Y7KytTa
 h0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784849772; x=1785454572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d16CZApBwdbjAv2BZVQc7wNcffZyxmsi63Xs9rslxdM=;
 b=nuDl4Muj9CKJoODHLkfmGksrw9o7LGdblOnUGja49VnCNJmSGnhCRPD8fhfMqArVQq
 +Wz8zSElQ8XuNXeLNNjWqOwOHNjQlUUbcH7YdQWlZgvfRtlAFZuC17rYk8SJbCELE7vy
 IGTH8rJAlOCqRGBa6mzj5FJt4bFwwv3VKDFES/AMdWdRaXwnl0gFrDuQJnvvi3auPOC7
 RDaL2PCWcC+nhwhC1vipYTWFrNuL8nhPURRcginrQZoJ1Cud7vrPq6cEMMhJC2u9YnUh
 GfgDvdXWUMOw+D4Utej6yg25lCUAXkWTf7vIIsrgRb0LWXEmSuzHYAHfW+raT2XiqDwN
 me5w==
X-Gm-Message-State: AOJu0YzcH0l2UAER5EvJmtL7q3BxYcQm94L/NVLOgzejKNvr4FR+xRBN
 2ikhNuJQervNWpK43Pdg29SdpUdFMiH8OMPVtDN3jb6sOYFNa4/hyG+W7T+bHa32
X-Gm-Gg: AR+sD12cpOVWgd0Vpps5vHvXwMlWaSdiN9C6Ekk2vdCTY3/RnqEMKNJAfC8mZmGabxC
 9s+iy3GEKNmOFlP0mIYc450KrdIJyziK7MCRlSbys5sV82EjUPfdX1S0hRHlwooZ8RffbCj0eH/
 o2MyLdXcolRsregHdGIF/PXs0VnA2zhMIK04xzrO2/5tEELUIeoUL/0FuPiJZkskjrrCJWUeERd
 m86Gt+QF7WcrG5ubwE7GSBHFxC1Jxq9UyXTLLK2cUG1hqa3x4NaCVrjjBJV9Vr7hOAAjVpbu3pg
 n7TJKiVSqxAdDm5x/0Ir3YGpzP+sBMw6K20myxwQ/exv+HMr7NqlO4BHPxUtX7GWHCRZ6n/LOTF
 COTLUVmgVnMl2rM47/UvWJ3C967CkJsolz0hwbfds4Ip+R6jgz7abRIkpNNTu/29FDCBUA8xqqQ
 VTFvPUjGYnYUecJkVVej9uTXM=
X-Received: by 2002:a05:6808:3190:b0:49e:d43f:1b94 with SMTP id
 5614622812f47-4ab380fc337mr2158575b6e.0.1784849772333; 
 Thu, 23 Jul 2026 16:36:12 -0700 (PDT)
Received: from HPE-2MQ6131DV6.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab248c6667sm3631997b6e.0.2026.07.23.16.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 16:36:11 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 3/4] hw/misc/iotkit-sysinfo: make sys_config2 configurable for
 SSE-310
Date: Thu, 23 Jul 2026 18:36:04 -0500
Message-Id: <20260723233605.805-4-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723233605.805-1-simonxhy0404@gmail.com>
References: <20260723233605.805-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add sys_config2 as QEMU property like sys_config.
- Modify the sys_config2 register on the SSE-310 for the NPU configurations.
- Currently sys_config2 is configured to report Ethos-U55 as the NPU type.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
 hw/arm/armsse.c                  | 21 +++++++++++++++++++++
 hw/misc/iotkit-sysinfo.c         | 11 +++++++++++
 include/hw/misc/iotkit-sysinfo.h |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 1847c73322..cf8f6c25d1 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -806,6 +806,22 @@ static uint32_t armsse_sys_config_value(ARMSSE *s, const ARMSSEInfo *info)
     return sys_config;
 }
 
+static uint32_t armsse_sys_config2_value(ARMSSE *s, const ARMSSEInfo *info)
+{
+    /* Return the SYS_CONFIG2 value for this SSE */
+    uint32_t sys_config2;
+
+    switch (info->sse_version) {
+    case ARMSSE_SSE310:
+        sys_config2 = 0;
+        sys_config2 = deposit32(sys_config2, 0, 3, 1); /* NPU0 = Ethos-U55 */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return sys_config2;
+}
+
 /* Clock frequency in HZ of the 32KHz "slow clock" */
 #define S32KCLK (32 * 1000)
 
@@ -1496,6 +1512,11 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                                     info->sse_version, &error_abort);
             object_property_set_int(OBJECT(&s->sysinfo), "IIDR",
                                     info->iidr, &error_abort);
+            if (info->sse_version == ARMSSE_SSE310) {
+                object_property_set_int(OBJECT(&s->sysinfo), "SYS_CONFIG2",
+                                        armsse_sys_config2_value(s, info),
+                                        &error_abort);
+            }
             if (!sysbus_realize(sbd, errp)) {
                 return;
             }
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 21e161bdc2..0905949ef7 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -31,6 +31,7 @@
 REG32(SYS_VERSION, 0x0)
 REG32(SYS_CONFIG, 0x4)
 REG32(SYS_CONFIG1, 0x8)
+REG32(SYS_CONFIG2, 0xc)
 REG32(IIDR, 0xfc8)
 REG32(PID4, 0xfd0)
 REG32(PID5, 0xfd4)
@@ -87,6 +88,15 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
             goto bad_read;
         }
         break;
+    case A_SYS_CONFIG2:
+        switch (s->sse_version) {
+        case ARMSSE_SSE310:
+            return s->sys_config2;
+            break;
+        default:
+            goto bad_read;
+        }
+        break;
     case A_IIDR:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
@@ -144,6 +154,7 @@ static const MemoryRegionOps iotkit_sysinfo_ops = {
 static const Property iotkit_sysinfo_props[] = {
     DEFINE_PROP_UINT32("SYS_VERSION", IoTKitSysInfo, sys_version, 0),
     DEFINE_PROP_UINT32("SYS_CONFIG", IoTKitSysInfo, sys_config, 0),
+    DEFINE_PROP_UINT32("SYS_CONFIG2", IoTKitSysInfo, sys_config2, 0),
     DEFINE_PROP_UINT32("sse-version", IoTKitSysInfo, sse_version, 0),
     DEFINE_PROP_UINT32("IIDR", IoTKitSysInfo, iidr, 0),
 };
diff --git a/include/hw/misc/iotkit-sysinfo.h b/include/hw/misc/iotkit-sysinfo.h
index 36dc702c53..1c1b2758d9 100644
--- a/include/hw/misc/iotkit-sysinfo.h
+++ b/include/hw/misc/iotkit-sysinfo.h
@@ -16,6 +16,7 @@
  * QEMU interface:
  *  + QOM property "SYS_VERSION": value to use for SYS_VERSION register
  *  + QOM property "SYS_CONFIG": value to use for SYS_CONFIG register
+ *  + QOM property "SYS_CONFIG2": value to use for SYS_CONFIG2 register
  *  + sysbus MMIO region 0: the system information register bank
  */
 
@@ -38,6 +39,7 @@ struct IoTKitSysInfo {
     /* Properties */
     uint32_t sys_version;
     uint32_t sys_config;
+    uint32_t sys_config2;
     uint32_t sse_version;
     uint32_t iidr;
 };
-- 
2.34.1


