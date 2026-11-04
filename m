Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920AB606A32E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=hBk54/X6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd9u-0002rr-80; Wed, 04 Nov 2026 10:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9H-0002Ca-DQ; Wed, 04 Nov 2026 10:43:42 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9F-0001J5-Nl; Wed, 04 Nov 2026 10:43:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeaMtyhSzltularA1A8RWl3pzN7LK7R5YcaHpJbsy97o5Z4wU8Om0SOlDOq+0E1KYSKe5rMrN0SsvldAyLXVm67q9odbW3h9IyR8Eb2s11BQTUwkVq82IwngldOkamamDZck1hxwlUXBZq3XiumAF630XUsdWtgJ0bNVIpMWsbM7RFIodThD4xce7A14b7k+ub6wRZnlTnhj3wEaOX8HV0J+Fr3zbxzZqOgRWVQEFKstaJ+mGEkGMPtIFxJFlRFUkGOKR4Hlxxe2wbhnixDlREfus8HaPoB8QA72mBD5UK5168ZcDc362wil842vt/3UfZk0/H/BAXiDfGdoXjHchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hdt/3ORv/GplFupc1ZaGAAJvUMHkx0ZONK2blfHMywM=;
 b=TYvULLuCoTaniE/9jQq7T2XX+sTJS7xeAfjCIErt6PlYcMlFQONhVcm+guWAiBAnPYMqU7Xh3unxYaOs9A5kUlyvzb3jad4LPSrRC19NJ9Paq4AJERaLDOzJfAqoOC5523KN27OH5YfdgQB1wtlxVqqlSLTxVlwdK1Jaate94YJLtliC7iu5ial9YrrCxGrrDU61ejNOuspHbx6Ad7K9l+pdfFa49/3Uchjp8J4qHcDvlzzUBRS5jhy5fT9wiWZDUFsqFNGAOu4s32zBGtVUpj/frtKbGjN3ejZ9qOurfyqHmUegrTk9uwKcsqY41pcUkEY5iCEioaI0uviP82KWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdt/3ORv/GplFupc1ZaGAAJvUMHkx0ZONK2blfHMywM=;
 b=hBk54/X6KAZ+cPsteRV5IiRTtV1EzqVs1hXk/KCSy+8HUtx9SntGtpz23L2QUxkh16mdWzEcKZhIQVViLO6VCSzts+7BVZzG91bwsjV4fJr4T7oOUHYdqJq6COtwk6OIWkFTHEsY2Cpa1i3MxTAOLdFMMNUfQ+yzlIemQ2SC6CedCa6kPJKX3Upw31P5PjlmfU1LD6mSWJH+L1P4CFg49BJynwfTOy2IZIN0bn5Er13OxUj2avfXHkXxlbCiW0O7EaVWQyW+RsQH7px+XScGpGU2s7rSBp3i8noTKDRZyokWwhOMF9gPiXqLa5quHIzSU57TCs7AeY4GpxOW4CWtfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:43:05 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:43:05 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 21/26] hw/riscv: pfsoc: Default Icicle Kit to five harts
Date: Wed,  4 Nov 2026 23:41:48 +0800
Message-ID: <20261104154207.641511-22-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 43966c68-7417-431b-dbb2-08df3a8a5151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SdMKEIZSnWXGmCDwTZacG53Vm4GxWPDNXrFwZwtG1dVsITlxg9z6oeOeUqvRUC0tuQSbZEqyopZl9zPadL1bKVJR8UQywp3Q1xN7fCziHfJjGo7jRQIOi4HkoGJmoVjb5bChdVta7XtBn6NlKgfEJ06u2Y5jk2MeavecSsG/avBH6UYXuGZ+Q9dduvQFbz54RaD47MiT/PRVxCfSojJQnz5ubsagfWuWwSHRwGGYsonjx1ZZFpDGdBmNuKroBFlGwzt4nGoprDFYQlH45JFY+QdNzOwO5COzjhDf42PbA/bwlwUsYOInba5sEZWfB7smCGoBwbXGY9tkID1L3pSJeByB6Wlx24JAEmc9t8IsWyjQNOWsVxX+uT+5gGN+tVviJ3QW6bXvcnNDIqXwWWayzCeQWXRAVS6VGi6OsSqurancmBC6J60s4PESTNuhCDdIlk2PNBOfC8Kpbq/LchPMIDnyGi1iGmYWVVay5wKksNwONgcisI2zDfb/pCfdLuCYIjBuY+imRAmDDAlN78IU15jweorQ23JyCbORsx+PIUiNWMx9EsaPRMVc/OboitMYNjrRFmQkYHS555nCc8zUCrtXx2x/SlI6gQN2BcPbLZMfeDSFtcSEliLAeX0ivlsuXWxmWMexfcB11jw6Rkc4+d5jUX3iuYz6X2UU65A4MLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dfW9UsGhH+0Txq4MxHQOsFDkMZFEYMiQdove/gmj/4KRqOrTNXz3ZCrZSj35?=
 =?us-ascii?Q?fmFdjePhU1fADvVDVgp0aLtGwQOxTm2C3NA/uv56K07XPuJDwV8T29vuDOsJ?=
 =?us-ascii?Q?Gi2fKyxzX6NJjCupLwUaj7Qc+U6agPTDa3n98xHy7K425Usikub7MywdYt8Y?=
 =?us-ascii?Q?xt8fOG2gmA9rKaajI/YOIUCLD+4iEAwr1A5We8CCRgMmqS0z+YLhi1vIsQGo?=
 =?us-ascii?Q?1LCtxs+hsxpa355tGdRFGBM+yO/BMkdX+wu6mxooRpuKg/vTON3sF5prUD+a?=
 =?us-ascii?Q?ebeUeq+dtOudWDn5Sp8Bt+c3CqU3zQ5VK7TW3PIlRyNLTx8V7FE8ZPVfj/O8?=
 =?us-ascii?Q?snioEc2d2RF7zbHi3rky6sJYqJnGU+t8mfYle8Sy6ynBHDvbYI8yE40t26SE?=
 =?us-ascii?Q?1/ClCrXMFuunJoLHeGyRh/5GcJbDQ26bSwew/v1l7QkM8Cw4cqNaMIYFKOwS?=
 =?us-ascii?Q?9m9wD0mqO3aqxlzq2ZWy202NipCTkGwn03CMhDIvZAq2YrY2uK7XobSEpqfw?=
 =?us-ascii?Q?OLgalyi7PrIaA5nwRLw2Nnu1N1IcAn3QUXDOwYnU0uo8keA6OOc2w3fHRoX7?=
 =?us-ascii?Q?MZThOPvzHxMVZB1YDkhlgC1lxl2SricenY/TeyFlrZskWfPV16F0W+MW26CM?=
 =?us-ascii?Q?jKNC3/O6FgVWfCDKi18WdSNPnuOqh2PFgwdkV2maGqnFjsEPecO7nemFAdyJ?=
 =?us-ascii?Q?PmxPLuskhWx3EHlW6SemmjdaQvc74GXMGHxUPpGinGIJWt1Exzs/iiaU7Gww?=
 =?us-ascii?Q?YHj+5yjXqUt4owEjTTkRQeEVCoLAYR1YBQQjlPJLQ2RhxnVo8ExoBNdPcxw8?=
 =?us-ascii?Q?+xdHgoQfFSCy5jrw2bHU47CR6soPrkQOaz7X0TRqc2BZXORoY5Q6In++ccJP?=
 =?us-ascii?Q?qRqurIoEeuzNuUduoczNPwNNOjaVXKXZ3GD1jelsqPsFatX0Ml/qLK3uNB4f?=
 =?us-ascii?Q?1NWuPVlcvDJIgWniiWzLVjLMCaDYwAw3ATfjuTxwkZHh4YJ8tmSsTRRtqluO?=
 =?us-ascii?Q?3ul6IdVOOfnM5DN9OJShLD/Ey2Wj31HgGK6YElzTlxm+FT74zsSqNgEFVW55?=
 =?us-ascii?Q?WQelSYDoWmCxpVS4oRkX4z+E5zEeum2AT1l+mMyjmYWFAgTV+HDj66lLvw0j?=
 =?us-ascii?Q?o0aWOtRIB4xJuMlIJKsIS3dtlBnmawV2yGKhkGqliQYg7YaZArWnCAvHupvx?=
 =?us-ascii?Q?B8VCDQDfhwwmwAv/HeJWjlgVZZ0Ef/P826sSidFcHQ45sTgwPQWK2utCWiEA?=
 =?us-ascii?Q?sG0ggwNlhm69uCPFEULFM3+ljLUu8NkNqBD21UXK7DusiMb1iOLka5bm1wMB?=
 =?us-ascii?Q?7fXc8OlrmEdbULkZauhxqA2428FMwTnUOx8XPh1yYDGoH6tlJo8/EswN8EWZ?=
 =?us-ascii?Q?Bkj7k1L0ZBg7ie1UP/Xf9hvmNzZ88fIUFlQfUEq2WXICcsMZRXCCirfL8abU?=
 =?us-ascii?Q?c39IIJ+0qdRIOC0mMSjvdGsFeg748/vAnf6csgXK/P6z08SmA9H7etPD/Dk6?=
 =?us-ascii?Q?q03OhbotdFem+g5sjDF1mXl5wr+m+lnJKWrKvzkkbbMev78To2Z0/9hbj3/O?=
 =?us-ascii?Q?gy1wMn5pFk82cugFRdHJRIul0M1NWj+UwK5BXe2GQcW99ReDyUL/UDbPUmBw?=
 =?us-ascii?Q?bFj7TY5StCzL9lYz9S/dRnuI3vvYDqAAVbYg1RopMFsF9jtxDjKR+hwVdePT?=
 =?us-ascii?Q?kXnP9df5zQEdQZmwRLIS3Lzt+22WOBn+42sqf/dV7LK/0uyGzk0yc94Wbk2b?=
 =?us-ascii?Q?dQ6pC09Q3sITEVNoVpmYtuTUpLp3umE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43966c68-7417-431b-dbb2-08df3a8a5151
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:43:05.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr+iCIiORcymodP/LHNLw+wwd+JeBRAy0yMj/HkkE2ArH6sNAbEhBb3skRn0bZjtO4vxy5bHh0kIvRinSxmVVcE3Gz9mLEUQcqI7bhHhIVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Icicle Kit contains one E51 management hart and four U54 application
harts. Defaulting to two harts can accidentally boot firmware and a
device tree that expect the full five-hart topology.

Default to all five harts, while retaining the existing two-to-five
range for users intentionally configuring fewer application harts.
Document that firmware and device trees must match the selected count.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

---

(no changes since v3)

Changes in v3:
- Change only the default hart count and retain the minimum of two
- Document reduced topologies and matching firmware requirements

 docs/system/riscv/microchip-icicle-kit.rst | 3 +++
 hw/riscv/microchip_pfsoc.c                 | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index b0ad24f174..138289a913 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -27,6 +27,9 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 1 SDHC storage controller
 
 The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
+The machine defaults to all five harts. ``-smp`` may select two to five harts,
+with one E51 and one to four U54 cores. The firmware and device tree must match
+the selected topology; the HSS boot flow below uses all five harts.
 
 Boot options
 ------------
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index f2a838be13..90345aa262 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -753,7 +753,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
     mc->max_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT +
                    MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
     mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpus = mc->min_cpus;
+    mc->default_cpus = mc->max_cpus;
     mc->default_ram_id = "microchip.icicle.kit.ram";
     mc->auto_create_sdcard = true;
 
-- 
2.53.0


