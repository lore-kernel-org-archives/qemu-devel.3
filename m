Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105BAEE6B45
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPw9-0000Mn-NA; Fri, 06 Feb 2026 12:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1voPw6-0000Lv-21
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:48:06 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1voPw4-0005II-1s
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:48:05 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4042f55de3aso1983767fac.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard.net; s=google; t=1770400083; x=1771004883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDTi7HslrZikJ1EUQBDRsEFUZ77CfEi18p0+zH03j1s=;
 b=Y9lNJWXTbQIqhQAaAtgFO5zVpQRg/87kSoM1rMX8lCW/qreuuiikPVa6stL98C1DZI
 N7Y1IH8Ec8Mwiiub4x73m6oWGpV9sJ+/CQdArFBqShP4t2GWOXzBNgkiLlMao6sm4Lxd
 rTLPzIBLBl32xB2rGgHHyH60HxlwkggelhZ8ZgYtWj/py7KXsUcs/6yk2psu7h/7ahbL
 eE37pnHl4snojCFmRPqe16wtPtTqWMnBbdNmVgCwQMZZcbI53YBiWl+sKyMdXhoo/qFf
 GYasq6WschDExnz5DIRCfy/R+w+BpjNMbBqCeUc6V6y5t8E2KZbZLKnIEWhhOBpVP4qg
 7R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770400083; x=1771004883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yDTi7HslrZikJ1EUQBDRsEFUZ77CfEi18p0+zH03j1s=;
 b=Ar01nbPlvYG+N46eqQLIt//B4o3WzIxGLQz36mMaQLlOkSwVtvXnY16cdke/vn4y4h
 +IHgjCdNUFey58dyMzSqO1SGTlHGfKBI7uFa+DUhAZ/q62m6zJ9Kz/UtLhl5Tcuvql/4
 fSw4CyvOy/dicwCt26bkN1EZEqydWlGwTiQGQPRRO2NaEU5PatmUOpij6mLasrIYXTfJ
 bkzW8DJ1/tvpo2yQmyqi5SkDFzOi4CGT2AH0oN56prjflHjhiWlKAWQT1tV4+7zHwMVP
 8xuIK9om2xLa8dkiRFdWH5PYNjSKC6KGj8Wa9E/R4l7I7X15mlSYF3ifXjRCRYzL3+FI
 5gAQ==
X-Gm-Message-State: AOJu0YxUiJdD6/8QGgruIbw+hy+cDE7Vq/1sFmKYN8iEBkOWcn3Swp3U
 EEDbI2AJttxqXei35MF4gH1WxdQiiBrcZpuzLhMvXk9uarCpoiaTjjO9og51nnMw3zWI6vvIlE+
 jPnaWpFY=
X-Gm-Gg: AZuq6aKc6uuzirbV6g888XwWIMnDURLbwEZ9qOyxht1sHRKgaBQyhS1uqRjaxCvQ2Jr
 mqH5MJsQYmFdHhEpYU0FwgV+uvomd3mdA8xIwL2andg5z/ShEm8w/aFpeC5/znggSNDuZ2nyTBS
 oreIwRtCxgHLT2LxwG0scfO/y5/8V0naXP7dIKN0OL5iRHpCXEjltLRGgBIWqAtRjMzHjPsAeyc
 Q5dvQhNushFjCWF86I8D0Ng+fTBfn7tGNpeQXcn3o+tclC6BrDXUMRvFfmFeJXTS/7hF80YprZE
 /J7xHXxWo9iL4WScCufBX9I39uBjDXTgmtHlE2cqPbkiUIliFWs4z2v+9GgvjpLq81NQL40OvtH
 k6cH3S1Lc9DBRvdqmJ4x6Wdti3MbF/rRAu6LszrsoyN+wvB3pKJfQtvB7hf+ba2v4bwpCdNE/jv
 l4AFmSISSH2uSdxhSMgF+gWlIgBrSga6hov8L9MtW/xfXBbOdPYAsi/2ifMsJpDsUErh+ekgyRF
 EElVQ==
X-Received: by 2002:a05:6871:3842:b0:404:44eb:ee55 with SMTP id
 586e51a60fabf-40a757aeb5dmr3814572fac.27.1770400082624; 
 Fri, 06 Feb 2026 09:48:02 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:aed7:ea82:7abb:dd28])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-40a99644531sm2112256fac.10.2026.02.06.09.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 09:48:02 -0800 (PST)
From: Corey Minyard <corey@minyard.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Yunpeng Yang <yunpeng.yang@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>, Corey Minyard <corey@minyard.net>
Subject: [PATCH 2/2] hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel
 config
Date: Fri,  6 Feb 2026 11:45:29 -0600
Message-ID: <20260206174755.3190469-3-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206174755.3190469-1-corey@minyard.net>
References: <20260206174755.3190469-1-corey@minyard.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=corey@minyard.net; helo=mail-oa1-x29.google.com
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

The "Set LAN Configuration Parameters" IPMI command is added to the
`ipmi_bmc_sim` device to support dynamically setting fake LAN channel
configurations. With the fake LAN channel enabled, inside the guest OS,
tools such as `ipmitool` can be used to modify the configurations.

Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>
Message-ID: <20260105155648.1037077-3-yunpeng.yang@nutanix.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/ipmi/ipmi_bmc_sim.c      | 110 +++++++++++++++++++++++++++
 tests/qtest/ipmi-kcs-test.c | 143 ++++++++++++++++++++++++++++++++++++
 2 files changed, 253 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index d88aa22b72..012e2ee4fe 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -106,6 +106,7 @@
 
 #define IPMI_NETFN_TRANSPORT          0x0c
 
+#define IPMI_CMD_SET_LAN_CONFIG           0x01
 #define IPMI_CMD_GET_LAN_CONFIG           0x02
 
 
@@ -300,6 +301,7 @@ struct IPMIBmcSim {
     ((ibs)->lan.channel != 0 && (ibs)->lan.channel == (c))
 
 #define IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED    0x80
+#define IPMI_BMC_LAN_CFG_CC_PARAM_READONLY         0x82
 
 #define IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS        0x00
 #define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT      0x01
@@ -2126,6 +2128,113 @@ static inline bool is_ipv4_netmask_valid(const void *buf)
     return netmask != 0 && clo32(netmask) + ctz32(netmask) == 32;
 }
 
+/*
+ * Request data (from cmd[2] on):
+ * bytes   meaning
+ *    1    [bits 3:0] channel number
+ *    2    parameter selector
+ * [3:N]   configuration parameter data (from cmd[4] on)
+ */
+static void set_lan_config(IPMIBmcSim *ibs,
+                           uint8_t *cmd, unsigned int cmd_len,
+                           RspBuffer *rsp)
+{
+    uint8_t channel;
+    uint8_t *param;  /* pointer to configuration parameter data */
+    unsigned int param_len;
+
+    if (ibs->lan.channel == 0) {
+        /* LAN channel disabled. Fail as if this command were not defined. */
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
+        return;
+    }
+    if (cmd_len < 5) {
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+        return;
+    }
+    channel = cmd[2] & 0xf;
+    param = cmd + 4;
+    param_len = cmd_len - 4;
+
+    if (!IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    switch (cmd[3]) {
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR:
+        if (param_len < NBYTES_IP) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        memcpy(ibs->lan.ipaddr, param, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE:
+        if (param_len < 1) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        if (!IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(*param)) {
+            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+            return;
+        }
+        ibs->lan.ipsrc = *param;
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR:
+        if (param_len < NBYTES_MAC) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        memcpy(ibs->lan.macaddr.a, param, NBYTES_MAC);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK:
+        if (param_len < NBYTES_IP) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        if (!is_ipv4_netmask_valid(param)) {
+            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+            return;
+        }
+        memcpy(ibs->lan.netmask, param, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR:
+        if (param_len < NBYTES_IP) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        memcpy(ibs->lan.defgw_ipaddr, param, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR:
+        if (param_len < NBYTES_MAC) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        memcpy(ibs->lan.defgw_macaddr.a, param, NBYTES_MAC);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS:
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT:
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES:
+    case IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS:
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR:
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR:
+    case IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING:
+    case IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS:
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_READONLY);
+        return;
+
+    default:
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED);
+        return;
+    }
+}
+
 /*
  * Request data (from cmd[2] to cmd[5] inclusive):
  * bytes   meaning
@@ -2324,6 +2433,7 @@ static const IPMINetfn storage_netfn = {
 };
 
 static const IPMICmdHandler transport_cmds[] = {
+    [IPMI_CMD_SET_LAN_CONFIG] = { set_lan_config },
     [IPMI_CMD_GET_LAN_CONFIG] = { get_lan_config },
 };
 static const IPMINetfn transport_netfn = {
diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c
index 3186c6ad64..9bab0d84ad 100644
--- a/tests/qtest/ipmi-kcs-test.c
+++ b/tests/qtest/ipmi-kcs-test.c
@@ -262,6 +262,144 @@ static void test_enable_irq(void)
     kcs_ints_enabled = 1;
 }
 
+
+static uint8_t get_channel_access_cmd[] = { 0x18, 0x41, 0x01, 0x40 };
+static uint8_t get_channel_access_rsp[] = { 0x1c, 0x41, 0x00, 0x3a, 0x04 };
+
+/*
+ * Get channel access
+ */
+static void test_kcs_channel_access(void)
+{
+    uint8_t rsp[20];
+    unsigned int rsplen = sizeof(rsp);
+
+    kcs_cmd(get_channel_access_cmd, sizeof(get_channel_access_cmd),
+            rsp, &rsplen);
+    g_assert(rsplen == sizeof(get_channel_access_rsp));
+    g_assert(memcmp(get_channel_access_rsp, rsp, rsplen) == 0);
+}
+
+
+static uint8_t get_channel_info_cmd[] = { 0x18, 0x42, 0x01 };
+static uint8_t get_channel_info_rsp[] = { 0x1c, 0x42, 0x00, 0x01, 0x04, 0x01,
+                                          0x00, 0xf2, 0x1b, 0x00, 0x00, 0x00 };
+
+/*
+ * Get channel info
+ */
+static void test_kcs_channel_info(void)
+{
+    uint8_t rsp[20];
+    unsigned int rsplen = sizeof(rsp);
+
+    kcs_cmd(get_channel_info_cmd, sizeof(get_channel_info_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(get_channel_info_rsp));
+    g_assert(memcmp(get_channel_info_rsp, rsp, rsplen) == 0);
+}
+
+
+/* get ip address (specified in cmdline): 10.0.0.2 */
+static uint8_t get_ipaddr_cmd[] = { 0x30, 0x02, 0x01, 0x03, 0x00, 0x00 };
+static uint8_t get_ipaddr_rsp[] = { 0x34, 0x02, 0x00, 0x11,
+                                    0x0a, 0x00, 0x00, 0x02 };
+
+/*
+ * Get LAN configurations
+ */
+static void test_kcs_lan_get(void)
+{
+    uint8_t rsp[20];
+    unsigned int rsplen = sizeof(rsp);
+
+    kcs_cmd(get_ipaddr_cmd, sizeof(get_ipaddr_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(get_ipaddr_rsp));
+    g_assert(memcmp(get_ipaddr_rsp, rsp, rsplen) == 0);
+}
+
+
+/* set/get ip address: 192.0.2.2 */
+static uint8_t lan_set_ipaddr_cmd[] = { 0x30, 0x01, 0x01, 0x03,
+                                        0xc0, 0x00, 0x02, 0x02 };
+static uint8_t lan_set_ipaddr_rsp[] = { 0x34, 0x01, 0x00 };
+static uint8_t lan_get_ipaddr_cmd[] = { 0x30, 0x02, 0x01, 0x03, 0x00, 0x00 };
+static uint8_t lan_get_ipaddr_rsp[] = { 0x34, 0x02, 0x00, 0x11,
+                                        0xc0, 0x00, 0x02, 0x02 };
+/* set ip address source: static */
+static uint8_t lan_set_ipsrc_cmd[] = { 0x30, 0x01, 0x01, 0x04, 0x01 };
+static uint8_t lan_set_ipsrc_rsp[] = { 0x34, 0x01, 0x00 };
+
+/* set/get subnet mask: 255.255.255.0 */
+static uint8_t lan_set_netmask_cmd[] = { 0x30, 0x01, 0x01, 0x06,
+                                         0xff, 0xff, 0xff, 0x00 };
+static uint8_t lan_set_netmask_rsp[] = { 0x34, 0x01, 0x00 };
+static uint8_t lan_get_netmask_cmd[] = { 0x30, 0x02, 0x01, 0x06, 0x00, 0x00 };
+static uint8_t lan_get_netmask_rsp[] = { 0x34, 0x02, 0x00, 0x11,
+                                         0xff, 0xff, 0xff, 0x00 };
+
+/* set/get default gateway ip address: 192.0.2.1 */
+static uint8_t lan_set_defgw_ipaddr_cmd[] = { 0x30, 0x01, 0x01, 0x0c,
+                                              0xc0, 0x00, 0x02, 0x01 };
+static uint8_t lan_set_defgw_ipaddr_rsp[] = { 0x34, 0x01, 0x00 };
+static uint8_t lan_get_defgw_ipaddr_cmd[] = { 0x30, 0x02, 0x01, 0x0c,
+                                              0x00, 0x00 };
+static uint8_t lan_get_defgw_ipaddr_rsp[] = { 0x34, 0x02, 0x00, 0x11,
+                                              0xc0, 0x00, 0x02, 0x01 };
+
+/*
+ * Set and then get LAN configurations
+ */
+static void test_kcs_lan_set_get(void)
+{
+    uint8_t rsp[20];
+    unsigned int rsplen = 0;
+
+    /* set ip address */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_set_ipaddr_cmd, sizeof(lan_set_ipaddr_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_set_ipaddr_rsp));
+    g_assert(memcmp(lan_set_ipaddr_rsp, rsp, rsplen) == 0);
+
+    /* get ip address */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_get_ipaddr_cmd, sizeof(lan_get_ipaddr_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_get_ipaddr_rsp));
+    g_assert(memcmp(lan_get_ipaddr_rsp, rsp, rsplen) == 0);
+
+    /* set ip address source */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_set_ipsrc_cmd, sizeof(lan_set_ipsrc_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_set_ipsrc_rsp));
+    g_assert(memcmp(lan_set_ipsrc_rsp, rsp, rsplen) == 0);
+
+    /* set subnet mask */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_set_netmask_cmd, sizeof(lan_set_netmask_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_set_netmask_rsp));
+    g_assert(memcmp(lan_set_netmask_rsp, rsp, rsplen) == 0);
+
+    /* get subnet mask */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_get_netmask_cmd, sizeof(lan_get_netmask_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_get_netmask_rsp));
+    g_assert(memcmp(lan_get_netmask_rsp, rsp, rsplen) == 0);
+
+    /* set default gateway ip address */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_set_defgw_ipaddr_cmd, sizeof(lan_set_defgw_ipaddr_cmd),
+            rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_set_defgw_ipaddr_rsp));
+    g_assert(memcmp(lan_set_defgw_ipaddr_rsp, rsp, rsplen) == 0);
+
+    /* get default gateway ip address */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_get_defgw_ipaddr_cmd, sizeof(lan_get_defgw_ipaddr_cmd),
+            rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_get_defgw_ipaddr_rsp));
+    g_assert(memcmp(lan_get_defgw_ipaddr_rsp, rsp, rsplen) == 0);
+}
+
+
 int main(int argc, char **argv)
 {
     char *cmdline;
@@ -271,6 +409,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     cmdline = g_strdup_printf("-device ipmi-bmc-sim,id=bmc0"
+                                       ",lan.channel=1,lan.ipaddr=10.0.0.2"
                               " -device isa-ipmi-kcs,bmc=bmc0");
     qtest_start(cmdline);
     g_free(cmdline);
@@ -280,6 +419,10 @@ int main(int argc, char **argv)
     qtest_add_func("/ipmi/local/kcs_enable_irq", test_enable_irq);
     qtest_add_func("/ipmi/local/kcs_base_irq", test_kcs_base);
     qtest_add_func("/ipmi/local/kcs_abort_irq", test_kcs_abort);
+    qtest_add_func("/ipmi/local/kcs_channel_access", test_kcs_channel_access);
+    qtest_add_func("/ipmi/local/kcs_channel_info", test_kcs_channel_info);
+    qtest_add_func("/ipmi/local/kcs_lan_get", test_kcs_lan_get);
+    qtest_add_func("/ipmi/local/kcs_lan_set_get", test_kcs_lan_set_get);
     ret = g_test_run();
     qtest_quit(global_qtest);
 
-- 
2.43.0


