Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7912AEE36AE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqahF-00087A-FP; Thu, 12 Feb 2026 12:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vqahD-00086R-WA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:41:44 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vqahA-0002WK-4y
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:41:43 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d15b8feca3so30831a34.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard.net; s=google; t=1770918099; x=1771522899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKo06MhGRsampsYGV+hkgGqoCl32gdVA9X/y9dLvz74=;
 b=FZDw9L0x8etCZ0jiXQerNRxb7kXDMnAmumFbwc2mzghxwoXq0QbQUNBYpfrvIpC2wV
 xNncPX0UXvUTovXhbaF14ugm1gWGYnuwu7XIK3ulifvwWhKgaZXuCFoDlP3MRqTZj1Dn
 qvbjrq0CjINgGj7970M716HTPzSYwWx55Akz2SrUZIr7nqHy5kso27fzIIOfdD74uTBN
 9/n6a9sq2KD55+jXqs9SAM7aKOb/hk6aZRlBMhCndLvK6HHVrTYJLGuLqlUvLclRXSnw
 /BjwkTjRhkCSJjkLP+XAGpoaMrmGKM3J/zX0lrKG0KacBrIwjSwgVFok6xedFd+AhE8/
 QNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770918099; x=1771522899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NKo06MhGRsampsYGV+hkgGqoCl32gdVA9X/y9dLvz74=;
 b=gmOVaB1xBrSlFiwqAxyA29Ln1FHR+IoX0DL97QgHwg5id2NWeHCvGwZhFjZ6oir7Xd
 qZQR7gcu2HrQeXnk5hEiQwZRC6G6ZTdCYqYYSWZsEfZg9tPbH/bXk6uVu5Xw5wXbZUsu
 PRHhvKp/VrKlbwH/MK94zhcGgguNJbL4t527IPoBVpAzHG63/KozeVsnRMv0Qw7EtJA7
 XAVNszz030RGaoDJ2ZeTw+8NieSgr5aAp5juJSFAuTb35+vcC/JTuDehjmxdUfR5kpVn
 GBiuKEXzHpvM5imEgXAbg3NIk7vs5g4VTHeEJrKEvgswl9E/vjGEsDWCTznhb1VPnWwA
 MYaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzur3N2Si8L1ptBVPaC8a9FzZkX0h5do/wAbQ/rKh/kqtqR5xqUnzbg7cM4iARo8tS6woFCVBwECjY@nongnu.org
X-Gm-Message-State: AOJu0Yxpw+Y3Y8hOFecn/WX/ODjlKe0RlP4QjLOQKks0OFGRtbCx/4x4
 7qHuYLHCbpxRHRdlrJQeYS3l3boqEH9mgQk+r+nKbId1fx+9vt/E5vfv53QNM05/KMI=
X-Gm-Gg: AZuq6aLPkzdANXdC8q8hPRAXEVpjrrmnQSZWdhCKgLEOxMfbXqEKi/092TFDTH013fw
 hUE3i+jojDo80noLU++lLa3lO6GGugrM8Tpj1lsLoQIE2yCKzVUvYwvA5uKZhv+Oj4lX5gaVadi
 1CxXFM5WhzqKgeSMXnE9oj12Q7V6EBo70VYzHd37MABzEhM5+C3z09SzbpSYdPP65Sze4tpzZNI
 woJ8eYHV4cJ3dyfJ0/ZjZ/QY4CbHT8UQm/ZczCbcsRDKTpSqCr9F1o10XweeawTK220Do2qLzhn
 GFfvcTldvC4XhvIGHVmAM9leD8jI6RSLkTpdpM8ZWjqeVnYZpt5wmCmyMmMhpyE6jW/TM11txoq
 23cHaYc1udwbF+eOsIeqHe9pTNRrUc9mSaIR9NNfeWUMnNg3CJAFhHUSs0kBli7NI1xVv8itX1N
 D++Q8LdeITzaUzQNnP7y2gZ4YpY7+9ZQ0pnZv9NBc3EIfTuSPSsD66meE8tZwMenZURE5R1pD5M
 oTHIAo80c4Fmy+Y
X-Received: by 2002:a05:6830:4116:b0:7cf:d9a3:12cf with SMTP id
 46e09a7af769-7d4b3fcd2c4mr1802868a34.16.1770918098770; 
 Thu, 12 Feb 2026 09:41:38 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:ac4f:9c7a:97e9:f745])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-7d4a76e1e59sm4082731a34.17.2026.02.12.09.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 09:41:38 -0800 (PST)
From: Corey Minyard <corey@minyard.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yunpeng Yang <yunpeng.yang@nutanix.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>, Corey Minyard <corey@minyard.net>
Subject: [PULL 1/2] hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel
 config
Date: Thu, 12 Feb 2026 11:40:49 -0600
Message-ID: <20260212174103.504520-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212174103.504520-1-corey@minyard.net>
References: <20260212174103.504520-1-corey@minyard.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=corey@minyard.net; helo=mail-ot1-x336.google.com
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

From: Yunpeng Yang <yunpeng.yang@nutanix.com>

The following IPMI commands are added or modified to support getting
fake LAN channel configurations from the `ipmi_bmc_sim` device:
* Get Channel Access;
* Get Channel Info Command;
* Get LAN Configuration Parameters.

The fake LAN channel configurations can be specified from QEMU
commandline options for device `ipmi_bmc_sim`. Inside the guest OS, the
configurations can be retrieved from the device using some IPMI tools,
e.g., `ipmitool lan print`.
Note, there is not a real LAN channel. The fake LAN channel is suitable
for testing purposes.

Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>
Message-ID: <20260105155648.1037077-2-yunpeng.yang@nutanix.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/ipmi/ipmi_bmc_sim.c | 302 +++++++++++++++++++++++++++++++++++++++--
 include/hw/ipmi/ipmi.h |   1 +
 qemu-options.hx        |  26 ++++
 3 files changed, 319 insertions(+), 10 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 3d4fe1a699..d88aa22b72 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -27,11 +27,13 @@
 #include "qemu/timer.h"
 #include "hw/ipmi/ipmi.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
+#include "net/net.h"
 
 #define IPMI_NETFN_CHASSIS            0x00
 
@@ -70,6 +72,7 @@
 #define IPMI_CMD_GET_MSG                  0x33
 #define IPMI_CMD_SEND_MSG                 0x34
 #define IPMI_CMD_READ_EVT_MSG_BUF         0x35
+#define IPMI_CMD_GET_CHANNEL_ACCESS       0x41
 #define IPMI_CMD_GET_CHANNEL_INFO         0x42
 
 #define IPMI_NETFN_STORAGE            0x0a
@@ -101,6 +104,10 @@
 #define IPMI_CMD_GET_SEL_TIME             0x48
 #define IPMI_CMD_SET_SEL_TIME             0x49
 
+#define IPMI_NETFN_TRANSPORT          0x0c
+
+#define IPMI_CMD_GET_LAN_CONFIG           0x02
+
 
 /* Same as a timespec struct. */
 struct ipmi_time {
@@ -170,6 +177,23 @@ typedef struct IPMISensor {
 #define MAX_SENSORS 20
 #define IPMI_WATCHDOG_SENSOR 0
 
+#define NBYTES_IP  4
+#define NBYTES_MAC 6
+
+typedef struct IPMILan {
+    uint8_t channel;
+    uint8_t ipaddr[NBYTES_IP];
+    uint8_t ipsrc;
+    MACAddr macaddr;
+    uint8_t netmask[NBYTES_IP];
+    uint8_t defgw_ipaddr[NBYTES_IP];
+    MACAddr defgw_macaddr;
+
+    char *arg_ipaddr;
+    char *arg_netmask;
+    char *arg_defgw_ipaddr;
+} IPMILan;
+
 #define MAX_NETFNS 64
 
 typedef struct IPMIRcvBufEntry {
@@ -215,6 +239,7 @@ struct IPMIBmcSim {
     IPMIFru fru;
     IPMISensor sensors[MAX_SENSORS];
     char *sdr_filename;
+    IPMILan lan;
 
     /* Odd netfns are for responses, so we only need the even ones. */
     const IPMINetfn *netfns[MAX_NETFNS / 2];
@@ -265,6 +290,36 @@ struct IPMIBmcSim {
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN      2
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE     3
 
+#define IPMI_CHANNEL_IMPLEMENTATION_MIN    0x1
+#define IPMI_CHANNEL_IMPLEMENTATION_MAX    0xb
+#define IPMI_CHANNEL_IS_IMPLEMENTATION_SPECIFIC(c) \
+    (IPMI_CHANNEL_IMPLEMENTATION_MIN <= (c) && \
+     (c) <= IPMI_CHANNEL_IMPLEMENTATION_MAX)
+
+#define IPMI_BMC_CHANNEL_IS_LAN(ibs, c) \
+    ((ibs)->lan.channel != 0 && (ibs)->lan.channel == (c))
+
+#define IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED    0x80
+
+#define IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS        0x00
+#define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT      0x01
+#define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES      0x02
+#define IPMI_BMC_LAN_CFG_PARAM_IP_ADDR                0x03
+#define IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE         0x04
+#define IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR               0x05
+#define IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK            0x06
+#define IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS        0x07
+#define IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR     0x0c
+#define IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR    0x0d
+#define IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR         0x0e
+#define IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR     0x0f
+#define IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING       0x10
+#define IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS       0x11
+
+#define IPMI_BMC_LAN_CFG_PARAMETER_REVISION    0x11
+
+#define IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(v)    (0x0 <= (v) && (v) <= 0x4)
+
 #define RSP_BUFFER_INITIALIZER { }
 
 static inline void rsp_buffer_pushmore(RspBuffer *rsp, uint8_t *bytes,
@@ -1231,6 +1286,25 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
     }
 }
 
+static void get_channel_access(IPMIBmcSim *ibs,
+                               uint8_t *cmd, unsigned int cmd_len,
+                               RspBuffer *rsp)
+{
+    uint8_t channel = cmd[2] & 0xf;
+
+    if (channel == IPMI_CHANNEL_IPMB || channel == IPMI_CHANNEL_SYSTEM ||
+        IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {
+        /* alerting disabled */
+        /* per message authentication disabled */
+        /* user level authentication disabled */
+        /* channel always available */
+        rsp_buffer_push(rsp, 0x20 | 0x10 | 0x08 | 0x02);
+        rsp_buffer_push(rsp, 0x04);  /* privilege limit: ADMINISTRATOR */
+    } else {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+    }
+}
+
 static void get_channel_info(IPMIBmcSim *ibs,
                              uint8_t *cmd, unsigned int cmd_len,
                              RspBuffer *rsp)
@@ -1240,29 +1314,29 @@ static void get_channel_info(IPMIBmcSim *ibs,
     IPMIFwInfo info = {};
     uint8_t ch = cmd[2] & 0x0f;
 
-    /* Only define channel 0h (IPMB) and Fh (system interface) */
-
     if (ch == 0x0e) { /* "This channel" */
         ch = IPMI_CHANNEL_SYSTEM;
     }
     rsp_buffer_push(rsp, ch);
 
-    if (ch != IPMI_CHANNEL_IPMB && ch != IPMI_CHANNEL_SYSTEM) {
-        /* Not a supported channel */
-        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
-        return;
-    }
-
     if (k->get_fwinfo) {
         k->get_fwinfo(s, &info);
     }
 
+    /* Only define channel 0h (IPMB), LAN, and Fh (system interface) */
     if (ch == IPMI_CHANNEL_IPMB) {
         rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_IPMB);
         rsp_buffer_push(rsp, IPMI_CHANNEL_PROTOCOL_IPMB);
-    } else { /* IPMI_CHANNEL_SYSTEM */
+    } else if (IPMI_BMC_CHANNEL_IS_LAN(ibs, ch)) {
+        rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_802_3_LAN);
+        rsp_buffer_push(rsp, IPMI_CHANNEL_PROTOCOL_IPMB);
+    } else if (ch == IPMI_CHANNEL_SYSTEM) {
         rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_SYSTEM);
         rsp_buffer_push(rsp, info.ipmi_channel_protocol);
+    } else {
+        /* Not a supported channel */
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
     }
 
     rsp_buffer_push(rsp, 0x00); /* Session-less */
@@ -2045,6 +2119,135 @@ static void set_sensor_reading(IPMIBmcSim *ibs,
     }
 }
 
+static inline bool is_ipv4_netmask_valid(const void *buf)
+{
+    uint32_t netmask = ldl_be_p(buf);
+
+    return netmask != 0 && clo32(netmask) + ctz32(netmask) == 32;
+}
+
+/*
+ * Request data (from cmd[2] to cmd[5] inclusive):
+ * bytes   meaning
+ *    1    [bit 7] revision only flag, [bits 3:0] channel number
+ *    2    parameter selector
+ *    3    set selector
+ *    4    block selector
+ */
+static void get_lan_config(IPMIBmcSim *ibs,
+                           uint8_t *cmd, unsigned int cmd_len,
+                           RspBuffer *rsp)
+{
+    uint8_t channel;
+
+    if (ibs->lan.channel == 0) {
+        /* LAN channel disabled. Fail as if this command were not defined. */
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
+        return;
+    }
+    if (cmd_len < 6) {
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+        return;
+    }
+    channel = cmd[2] & 0xf;
+
+    rsp_buffer_push(rsp, IPMI_BMC_LAN_CFG_PARAMETER_REVISION);
+    if (cmd[2] & 0x80) {
+        /* The requester only requests parameter revision, not the parameter */
+        return;
+    }
+    if (!IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    switch (cmd[3]) {
+    case IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS:
+        rsp_buffer_push(rsp, 0x0);  /* set complete */
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT:
+        rsp_buffer_push(rsp, 0x01); /* Authentication type "none" supported */
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES:
+        /* Only authentication type "none" enabled */
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Callback" */
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "User" */
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Operator" */
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Administrator" */
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "OEM" */
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR:
+        rsp_buffer_pushmore(rsp, ibs->lan.ipaddr, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE:
+        rsp_buffer_push(rsp, ibs->lan.ipsrc);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR:
+        rsp_buffer_pushmore(rsp, ibs->lan.macaddr.a, NBYTES_MAC);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK:
+        rsp_buffer_pushmore(rsp, ibs->lan.netmask, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS:
+        /* TTL 0x40 */
+        rsp_buffer_push(rsp, 0x40);
+        /* don't fragment */
+        rsp_buffer_push(rsp, 0x40);
+        /* precedence 0x0, minimize delay */
+        rsp_buffer_push(rsp, 0x10);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR:
+        rsp_buffer_pushmore(rsp, ibs->lan.defgw_ipaddr, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR:
+        rsp_buffer_pushmore(rsp, ibs->lan.defgw_macaddr.a, NBYTES_MAC);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR:
+        /* 0.0.0.0 */
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR:
+        /* 00:00:00:00:00:00 */
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING:
+        {
+            static uint8_t community_str[18] = "public";
+
+            rsp_buffer_pushmore(rsp, community_str, sizeof(community_str));
+        }
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS:
+        rsp_buffer_push(rsp, 0x00); /* LAN Alerting not supported */
+        break;
+
+    default:
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED);
+        return;
+    };
+}
+
 static const IPMICmdHandler chassis_cmds[] = {
     [IPMI_CMD_GET_CHASSIS_CAPABILITIES] = { chassis_capabilities },
     [IPMI_CMD_GET_CHASSIS_STATUS] = { chassis_status },
@@ -2089,6 +2292,7 @@ static const IPMICmdHandler app_cmds[] = {
     [IPMI_CMD_RESET_WATCHDOG_TIMER] = { reset_watchdog_timer },
     [IPMI_CMD_SET_WATCHDOG_TIMER] = { set_watchdog_timer, 8 },
     [IPMI_CMD_GET_WATCHDOG_TIMER] = { get_watchdog_timer },
+    [IPMI_CMD_GET_CHANNEL_ACCESS] = { get_channel_access, 4 },
     [IPMI_CMD_GET_CHANNEL_INFO] = { get_channel_info, 3 },
 };
 static const IPMINetfn app_netfn = {
@@ -2119,12 +2323,22 @@ static const IPMINetfn storage_netfn = {
     .cmd_handlers = storage_cmds
 };
 
+static const IPMICmdHandler transport_cmds[] = {
+    [IPMI_CMD_GET_LAN_CONFIG] = { get_lan_config },
+};
+static const IPMINetfn transport_netfn = {
+    .cmd_nums = ARRAY_SIZE(transport_cmds),
+    .cmd_handlers = transport_cmds
+};
+
+
 static void register_cmds(IPMIBmcSim *s)
 {
     ipmi_sim_register_netfn(s, IPMI_NETFN_CHASSIS, &chassis_netfn);
     ipmi_sim_register_netfn(s, IPMI_NETFN_SENSOR_EVENT, &sensor_event_netfn);
     ipmi_sim_register_netfn(s, IPMI_NETFN_APP, &app_netfn);
     ipmi_sim_register_netfn(s, IPMI_NETFN_STORAGE, &storage_netfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_TRANSPORT, &transport_netfn);
 }
 
 static uint8_t init_sdrs[] = {
@@ -2174,9 +2388,25 @@ static void ipmi_sdr_init(IPMIBmcSim *ibs)
     }
 }
 
+static const VMStateDescription vmstate_ipmi_sim_lan = {
+    .name = TYPE_IPMI_BMC_SIMULATOR "-lan",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(channel, IPMILan),
+        VMSTATE_UINT8_ARRAY(ipaddr, IPMILan, NBYTES_IP),
+        VMSTATE_UINT8(ipsrc, IPMILan),
+        VMSTATE_UINT8_ARRAY(macaddr.a, IPMILan, NBYTES_MAC),
+        VMSTATE_UINT8_ARRAY(netmask, IPMILan, NBYTES_IP),
+        VMSTATE_UINT8_ARRAY(defgw_ipaddr, IPMILan, NBYTES_IP),
+        VMSTATE_UINT8_ARRAY(defgw_macaddr.a, IPMILan, NBYTES_MAC),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ipmi_sim = {
     .name = TYPE_IPMI_BMC_SIMULATOR,
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(bmc_global_enables, IPMIBmcSim),
@@ -2198,6 +2428,7 @@ static const VMStateDescription vmstate_ipmi_sim = {
         VMSTATE_UINT16(sensors[IPMI_WATCHDOG_SENSOR].deassert_states,
                        IPMIBmcSim),
         VMSTATE_UINT16(sensors[IPMI_WATCHDOG_SENSOR].assert_enable, IPMIBmcSim),
+        VMSTATE_STRUCT(lan, IPMIBmcSim, 2, vmstate_ipmi_sim_lan, IPMILan),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -2232,6 +2463,47 @@ out:
     fru->nentries = size / fru->areasize;
 }
 
+static void ipmi_lan_init(IPMILan *lan, Error **errp)
+{
+    struct in_addr ip;
+
+    /*
+     * `lan->channel` can be either 0 (meaning LAN channel disabled) or
+     * a valid IPMI implementation-specific channel.
+     */
+    if (lan->channel != 0 &&
+        !IPMI_CHANNEL_IS_IMPLEMENTATION_SPECIFIC(lan->channel)) {
+        error_setg(errp, "invalid LAN channel %d", lan->channel);
+        return;
+    }
+    if (lan->arg_ipaddr) {
+        if (inet_pton(AF_INET, lan->arg_ipaddr, &ip) != 1) {
+            error_setg(errp, "invalid ip address '%s'", lan->arg_ipaddr);
+            return;
+        }
+        memcpy(lan->ipaddr, &ip.s_addr, NBYTES_IP);
+    }
+    if (!IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(lan->ipsrc)) {
+        error_setg(errp, "invalid ip source %d", lan->ipsrc);
+        return;
+    }
+    if (lan->arg_netmask) {
+        if (inet_pton(AF_INET, lan->arg_netmask, &ip) != 1 ||
+            !is_ipv4_netmask_valid(&ip.s_addr)) {
+            error_setg(errp, "invalid subnet mask '%s'", lan->arg_netmask);
+            return;
+        }
+        memcpy(lan->netmask, &ip.s_addr, NBYTES_IP);
+    }
+    if (lan->arg_defgw_ipaddr) {
+        if (inet_pton(AF_INET, lan->arg_defgw_ipaddr, &ip) != 1) {
+            error_setg(errp, "invalid ip address '%s'", lan->arg_defgw_ipaddr);
+            return;
+        }
+        memcpy(lan->defgw_ipaddr, &ip.s_addr, NBYTES_IP);
+    }
+}
+
 static void ipmi_sim_realize(DeviceState *dev, Error **errp)
 {
     IPMIBmc *b = IPMI_BMC(dev);
@@ -2259,6 +2531,9 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
     ibs->acpi_power_state[1] = 0;
 
     ipmi_init_sensors_from_sdrs(ibs);
+
+    ipmi_lan_init(&ibs->lan, errp);
+
     register_cmds(ibs);
 
     ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
@@ -2276,6 +2551,13 @@ static const Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
     DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
+    DEFINE_PROP_UINT8("lan.channel", IPMIBmcSim, lan.channel, 0),
+    DEFINE_PROP_STRING("lan.ipaddr", IPMIBmcSim, lan.arg_ipaddr),
+    DEFINE_PROP_UINT8("lan.ipsrc", IPMIBmcSim, lan.ipsrc, 0),
+    DEFINE_PROP_MACADDR("lan.macaddr", IPMIBmcSim, lan.macaddr),
+    DEFINE_PROP_STRING("lan.netmask", IPMIBmcSim, lan.arg_netmask),
+    DEFINE_PROP_STRING("lan.defgw_ipaddr", IPMIBmcSim, lan.arg_defgw_ipaddr),
+    DEFINE_PROP_MACADDR("lan.defgw_macaddr", IPMIBmcSim, lan.defgw_macaddr),
 };
 
 static void ipmi_sim_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index dabbb9ec5d..3134a85c58 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -45,6 +45,7 @@ enum ipmi_op {
 #define IPMI_CHANNEL_IPMB                0x00
 #define IPMI_CHANNEL_SYSTEM              0x0f
 #define IPMI_CHANNEL_MEDIUM_IPMB         0x01
+#define IPMI_CHANNEL_MEDIUM_802_3_LAN    0x04
 #define IPMI_CHANNEL_MEDIUM_SYSTEM       0x0c
 #define IPMI_CHANNEL_PROTOCOL_IPMB       0x01
 #define IPMI_CHANNEL_PROTOCOL_KCS        0x05
diff --git a/qemu-options.hx b/qemu-options.hx
index ec92723f10..01f2923cf8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1144,6 +1144,32 @@ SRST
         is set, get "Get GUID" command to the BMC will return it.
         Otherwise "Get GUID" will return an error.
 
+    ``lan.channel=val``
+        channel number of the fake LAN channel. It can be 0 or any
+        integer from 0x1 to 0xb inclusive. If set to 0, the LAN channel
+        is disabled, otherwise the LAN channel is enabled at the
+        specified channel number. The default is 0.
+
+    ``lan.ipaddr=addr``
+        the ipv4 address of the BMC LAN channel.
+
+    ``lan.ipsrc=val``
+        the ipv4 address source of the BMC LAN channel. It can be 0
+        (unspecified source), 1 (static address), 2 (DHCP), 3 (BIOS or
+        system software), or 4 (other source). The default is 0.
+
+    ``lan.macaddr=mac``
+        the mac address of the BMC LAN channel.
+
+    ``lan.netmask=mask``
+        the ipv4 subnet mask for the BMC LAN channel.
+
+    ``lan.defgw_ipaddr=addr``
+        the default gateway ipv4 address for the BMC LAN channel.
+
+    ``lan.defgw_macaddr=mac``
+        the default gateway mac address for the BMC LAN channel.
+
 ``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val]``
     Add a connection to an external IPMI BMC simulator. Instead of
     locally emulating the BMC like the above item, instead connect to an
-- 
2.43.0


