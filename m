Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A85C624DD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25bp-0000H7-Ad; Thu, 03 Sep 2026 07:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25bk-0008BJ-7N
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:27:54 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25bh-0006vi-Ev
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:27:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OikfO3/waBcBBgvhBa87oZ0MjjQd/EIyiAJg5NmtECTouh08b4TddVwgBa8xohKZysFX7/eB1lN733xRvgRPRCKLlk2wWn0dbvYeZRc8iC2iFS8qG+YZiV86uxJTkUARcaRoLwt4x0bNlEA5IE9V1MDtXKBV2fVRlkoCQOMOoJABFsPjCkRMvmIt2pYWwf3v2bkRHQ2VJRiHJCRa/RvWYy76ZS18gJd0RXx1bGe1IALs0Fsr29E8q+aOAP6x/wttDojURHFH5/AWburMC7MCnnxCBYpu6Hl3VCBPY1BJ1BlbHSrZSvFfr4UhJ2ddUsukJc0NMJYNKuYrNpT5IKUIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsMQISJQ5rY6YaDUWd+C1ICOoUWWBfyGIx6aVvaGDNk=;
 b=QQ/HcO4ujCKMAF8DDZRhnf6j3UmkNhSnkDyLnXmm61EULc5A07uDqaux6qJB/JCjMj0OnMFw+UcDty1UuLbzrRQY88MQUfR6OtCEwkdpz5qZDcCXuEIO5K2NccLpjUe6DYcFwMxkgx+/C3wRky9RE3XdhTZkLAr9pgny8HATthWmBLwTjVKHIZDQmtw2nUNnNNKjAP8Uwn3Ex0BY6LSGAj1sQAFrirbqAAbA2/6vrmEo9KSi8wZ/ZVa+0YUI76dlqY2Lz2crpkoaxfAtGTAjLB/xVDsi/h+mP+/c35SvHhqdcdFnB8Q7f42XEcLjPfVF2B0p9LHelFbBONAB0tSRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsMQISJQ5rY6YaDUWd+C1ICOoUWWBfyGIx6aVvaGDNk=;
 b=B07gSXnozBU4LcmyjB/iLLWxGFq0ZmNGeNmFlfzwS+oKglED3w0rmjHOgBXDqyZQgI/OCyYmY7wL6gaKFu0GcUehB4Omyn6bBn0glyqvNUcXIVqGveGn8IzSfLzaN/8vdWsIBUu5wgM1RSNzphDFjah0BR2e7mC9v53Xsa36e1erLRHsmASdUuFo/mTRkT4jYh1BNQNRwMqjHij93BlSNxpLaL1OG0JtIB4KHIbzQJnbnMLqB8AcSqOhFeiE3o2emYciV09kecpZztJhTAfzTUWC8CU9KY+3u6jtasYXdxw6SENVC8gkckHXaAx3EM500yxIAY+g1HrdatX7j9Fi6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by PS1PPFF2E6AB00E.apcprd02.prod.outlook.com (2603:1096:308::2b1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:27:20 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:27:20 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>
Subject: [PATCH 33/33] MAINTAINERS: Add Phytium E2000Q machines
Date: Thu,  3 Sep 2026 19:25:13 +0800
Message-ID: <20260903112532.3276678-34-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|PS1PPFF2E6AB00E:EE_
X-MS-Office365-Filtering-Correlation-Id: 85eec4a0-9d7f-4339-1ab3-08df09ae4201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0qQvdL8JqVl9bEb7Qa4Ne0j+zdnmPSXOoe84cLoz9y4nEmAdOJsOINZRVWHzOauJx7Gp+WROuPV/wfypXTWMiaydX/9BJ11x9sGjaP/n1TYwoz6CsydJ+wyLd6AWzN5WNiTjSeGcu04WskYaK/UIRWaGaLdkiVntBMcesmtnT2uTEyjrTfnuq5HmxJsaFVifnkGz4+bniElwVWWjSQgUL7I3h+SVgrkm50OxjKMlsJl6J8bzK9J99qTN0lsatHGN32yDZmqx/GDuN6ZDpkIJM6x8K49yEd7JmOoyiiTSbm98qfiqr3z7W/+N0LohYCFF8n0RPwp/4xd6cTXrYQJxHQg+HsMlR9JdP/23va10DN6zD3z7KNQGAf3+3NkZbtMZSGWSRl8edoJLm/EvmPlYHckeGKgMEbjJJMN8g8hE+ZJQ6pqeQGmg9cNgeFTYctCVkjvXwDOxCTKTEyNkhezTLpwzD12nE3+sBshmp57/dnExHSxRTLhkyfzKQa98Np4NxapULPTzMM//QK0NBPeM1JogaPdS5MHgBRHnsttv5IdYidDiLdAfmbPKvWsJvLTUQ2+vSSHVnU3qbzVmblsorrH4g9Mnmau0+/lxcIngTsGnnNsbcrRQEXleuD/micTFsngu/wpCJpnAanRcALnMVzJZOkLcqk8oFM2xiaxnGrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em0wckdPSStJcm1DMlFRRWt0SnVMblZGYXRNcEpNcTVNWDZiU3ZLZlQySFc3?=
 =?utf-8?B?UjNGSGdIUWJnMTZ2aWNhbHFwUGNlSEdpWWlsRy95SW4zdkZNWXZqV1E4V0lu?=
 =?utf-8?B?SGFzRFk0dGo0MXUvQmZpZWkwOXZYdDM0K3hOMFZuS3lEek9nbkpHMU93N0xS?=
 =?utf-8?B?QXRSZTZPL1lram9nSmJ0OGFKTTJ5cU53SlV5aUc5dXd6QUVtK1RwMkZOZUd2?=
 =?utf-8?B?cEkyODBETGJPU3QrOGV5ZHRKdmh0UlRmak5MOFZPcENpdEVxWmdpOCtoREc3?=
 =?utf-8?B?eHlTclFkMS94YURZZDkrc01tWVR3OFY5Y21heFRRM2phVmhuSjFleVlOc2oz?=
 =?utf-8?B?VjEwZ3hIbG16clVtOGg2Rkd3bFFuLzU2NldKN0hVUU1TNVNmaDU2dk9qWFFz?=
 =?utf-8?B?RzdiMU9hSllaaGpuWlM3K0kxSGVGb0dTOVJpeFE2TkhEekhNMmNnWFpMSklr?=
 =?utf-8?B?TFN0eXFWSVdMODBqdERRSFpiR1U1Tmw3TDZtMkdGeWpyeWh0VzdydDBSRVY5?=
 =?utf-8?B?Yzh0WU9rTTUrUTFobXdvREczMnJZcFh3Y3NNV2NOVVB3cys5T2VFWkhwZ3hs?=
 =?utf-8?B?VmFmd1l4a2NQMzhXWjdnaE9tM1l4RGRtUXNBUis3ZVVwNHFrVFFUMkMzWFh3?=
 =?utf-8?B?MUg3Ri92M2ZqdmJwVkp6amFQVkNoU21sOHpSRHJWZkEzeEg3QzE4dzFPeDFy?=
 =?utf-8?B?UW1NRlY1eURnb2RjSjdHejVKNTJsQWsyRk9sNXlkdGVjK1UxM0FiSjBMS1pi?=
 =?utf-8?B?N21rNHpranJ1WXlYcVV0cHpzMEFabzFxQ1JTZTdEcFFLblUzdldodGc1TkVl?=
 =?utf-8?B?WkdzdjRocTlrbDNpaTlxM29wcWx3RWpua0ZlbGZScjRqcXU1V0cwNk50NU1G?=
 =?utf-8?B?emxFb2xjTGgvU1ZWMlcyNUV1b0FGWVVLdUNNaUkrQ0VkMGRleWdaRGdGcnVP?=
 =?utf-8?B?aE82STNEK2tnTXpoWnRZeERJRnFJWmZScXhmOUhmR0dxcjBYTGpqL3hxam1l?=
 =?utf-8?B?RE5Gam1tQlpiUEoxVEY3Z3I1aFNiaFZlSnVBeGlBN2U1ZHA2a2Job2lvYWpX?=
 =?utf-8?B?elFQZFlHUk5TTENWb25wcFpsQTdoY1prVWg1bnBvSTA1SW9vQWFkK3ViM0xv?=
 =?utf-8?B?UVdvSmZPb3NWYmV6VStjNk1WUGg3dEs5VmNYdEZBZ2FGUFc0QU9zQzlqRERz?=
 =?utf-8?B?ZjdGSnQycEVGTThFV1p5QlhZT3MzdFpDellwdklrWFVLSHlJR1ZkMVdiNlFj?=
 =?utf-8?B?cTd5Z1FLVjVpUDZBeHhNekd2MXZyZThUUklnQ25CbWUxMWlYUDdBblYrQk5W?=
 =?utf-8?B?bzRPUkMzZFhsS2N2Um1hdTBHbWF5MVdkdHFxV0RteHdNVW44SjdwaHpVcTBE?=
 =?utf-8?B?dmdBeDhHWVVtNjVjRHdtWlE2c2w4VFFIME5neGJhNWhQY04rSU9ZR2M3Q0JB?=
 =?utf-8?B?QUFCWmg3UkhjNXh6bVNMVXhmbG5tUTBINXhSY0JUSlBiL2RMdkxqd2tlaGxK?=
 =?utf-8?B?RVpvVytnTkYySlZDbzJHT2FkRlo3em5YMHhVc0JRZDIxZ01JNkVpZVdDRlpq?=
 =?utf-8?B?elBBeWIwM0NMODdSREFYS2lGVXhiOEhUOFVlVFlyaStJSFNKRmVBMGYyN1dy?=
 =?utf-8?B?ZW5tUmhpb3NBSzU4SUlscmtkeUNiSUVLejV0M0gzTWdyYWxuRUV0TUdqQ1VU?=
 =?utf-8?B?enlyK2pjbkpzY2VaWEYvQ2JLb2pQalYzZkxBSUs5NzZXR0hBb0xyZ1UvUytP?=
 =?utf-8?B?YXZnaGovM1Y4OHJGVVVuOTJaaVMzdzJ4R3lPNkZibk56bnowTmlsZ1RsSDlS?=
 =?utf-8?B?bWNoWU1jVXJEQzlodTZieVBHaGN6VFpyQTlRQ0UwN3NTNGJFZWw1Wmd1Qkwv?=
 =?utf-8?B?UFpCZDdLUGRqbkhGUVc0R3Q3R2YybUdrZHRCeXpJUGtEa0JxZGl4MGpRZ1pk?=
 =?utf-8?B?RFNzZnFPakJtWktTa3dEMkhsODh0MDVwQ21oU1ZZSklhZFphdlhiclA2TlQ0?=
 =?utf-8?B?U3ZSWTBHSk42M0daMnphV21HTHJWNmh3RkEvMTJWaDlsSDlvUjhJd3ErbGs3?=
 =?utf-8?B?bk1GQkxtS2RLQ0pDMSt0MW81RSs2eVpoMVE3ZURIN1lreTJWbmdSUDBBVWJR?=
 =?utf-8?B?bkNpQ29CVWtjbXdkb3FLdmpmK2N0d1JkSHdzcFVCUEJQRU5KVFVpWmJOVjNB?=
 =?utf-8?B?ZnQyNm4xb1RPdENFVHhyczhtY21ZZk5TdGlBYTBTZ0Y4bE1wTGVFem5WdnA0?=
 =?utf-8?B?RzhUeVRIVVhNVEs5Z1hmQnRXTFp5K1ZRVllCa25mSHZiMVpMMkRoZDREbGg3?=
 =?utf-8?B?cGs3NExlaGYxdjJHeHJIa0tUWklLMVhlZW42c2xhOVdHRnRIV05YejFHTGJ0?=
 =?utf-8?Q?K74uOeILU+idpRGs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eec4a0-9d7f-4339-1ab3-08df09ae4201
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:54.6843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erxrwETiax3YfbsWF7kEfXYq7leTCdWmseKZIGdmvzu8YCUIpGbx13NCkcYwrZG1twpLpE5dyw+lyemsHldM5k44hchUTiH2H1t8Lkki1tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFF2E6AB00E
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The Phytium Pi and E2000Q COMe series adds board and SoC models,
documentation, and boot tests. Group them under one entry so changes
reach the machine maintainer and the ARM list.

Cover the machine, misc, SD wrapper, SSI, documentation, and
functional test files introduced by the series.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c915c5f996..4c80ee2244 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1011,6 +1011,20 @@ F: roms/vbootrom
 F: docs/system/arm/nuvoton.rst
 F: tests/functional/arm/test_quanta_gsj.py
 
+Phytium E2000Q machines
+M: Bin Meng <bin.meng@processmission.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: docs/system/arm/phytium_e2000.rst
+F: hw/arm/phytium*
+F: hw/misc/phytium*
+F: hw/sd/phytium*
+F: hw/ssi/phytium*
+F: include/hw/misc/phytium*
+F: include/hw/sd/phytium*
+F: include/hw/ssi/phytium*
+F: tests/functional/aarch64/test_phytium_pi.py
+
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
-- 
2.53.0


