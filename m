Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D5606ECC0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=uVnHPTJW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOetj-0004MS-CL; Wed, 04 Nov 2026 12:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesO-00037x-RY; Wed, 04 Nov 2026 12:34:23 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesM-0006Dv-IL; Wed, 04 Nov 2026 12:34:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uViaxySErs07u9Et0WCWuDDzRzwbXmTgo6av/C4Z8Kjphy95J5in2GkOFdiWYhGmXy7HFK7r1irXnNesb3sJyDFatHsM/m0ScozwchZbefP50fReDfXOmQ2dw2M/qQCIujzGMcDP8Pd0D0lgsYH20XY0CcKl5V4vmSMsySi1kV1RRMBwFhEJQdv6lPECsttUjQMfzppDkBjN76rat5XXK0ShkwjXG0fCdGyLQJNimIGpB7WekApM9X2pgA7ci1nFjDBpne3wWkQFyQi4lAcNPASPb5TQ7NggYwTWFb8MdSrVpOt9pFHpj4uSW3qMMIVgJSyR/xV43po9tkCYWzEkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tNlEBeQl8IQ/Y7CIVQrbHH7url8RtJrLVdsGvYxZUI=;
 b=EdpnAFXkySvNfu5j3IZV+TW1M7BM7ks3SOMKbDPJw/hCy/ufXqWE28tRXfapbOYxvyna2/eCXEj2epPY8HeQOkPjFQtWT5k+zwAJDg1MHRRkbIf3j1C2wM3s8XEE/326S1KLXren0zQnYPaIb0BpNrTeKSakoFP22ywEFiKG5COK1pusgOUMMPXIkTOBgyMa5RyOSzywktUUICevJzfl3ckLJt8MK7BdEpo/kYnEfA3T2n5iWEUqi79XQgQ2+Y/jWjokaIOrlOCsdjSuky7IqKfZmFwLKrpwgFaxu4E1ZWWCaoQwJZ4WmTDK+1TPQ9nUxfVmuR6s0f4Muj8U+fee6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tNlEBeQl8IQ/Y7CIVQrbHH7url8RtJrLVdsGvYxZUI=;
 b=uVnHPTJWlIpCyZutJO3ffy8CY+XfSvV7D4DdXgHc76/53fSqh1vgTrWTiU6IZZa9p10u4i44GwpOxGYDgpDcgCcyUhSChtszoanjzOVWz6gzzkYbs7vxChyWBhm5GWfWq1oJH0sISVX4ybTHdtntAPzWWWg8XCg2iVXsBblwM/SyWWgTVP+a8VHYTdwHu06iRfSKX3hekzemx8EnXnCuxB5MgZ5ANbIZNDcHJvm1c4cy9oCx90PMx88YMd8iDNus6SGcaqvnIuCOEofgJ2NpljM45ZqByXc+jRPPwihBLmZz3Nmq2RWxl4zs1l8PA4slFuH3dQlSbFmukdevFUxQPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:04 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:04 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 10/17] target/ppc: Register PWRMGTCR0 on e6500
Date: Thu,  5 Nov 2026 01:33:13 +0800
Message-ID: <20261104173329.706635-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173329.706635-1-bin.meng@processmission.com>
References: <20261104173329.706635-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUXPR02MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f655030-83cf-472a-2a9f-08df3a99d22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: BhbTaRa+TOTp1vGAMKrGox2hWFCgTdPwzkOHRyFHvgAR2rB3l/Is/fPo+JSOTP0PKvcnaQ1IVgutemc4Sb5SBXRb1kN2ZKkJiw8y9G0Tl5bwdN1i/BDv5+kOZ96vb/naMUtaIbH/QqGgXSPi3JBvA7imw51fTihJPlspe1T41YDWLT6guVOtQg6tMEe6e8JteUPFA/7OWUvta7u6QWeHEZEdC9Bf9eRSdLAWvq7tRI9dgsWNGB88Vu7i86+yBrpcdKDsOEQiPjvjy531uFbiFdcNu7l4l9PBC7KSDg1KT+DMmMLqAJ4q5I0FsUsYqg+P6HGnOEnWRHfcM2USnoJ6CrJqBzSvQjxfydqQWF8zdnWOu24HrZQBlUighnX7kyPe9puFB2vY1pcqy1zw4m02YF3KixqMhPHx1oirYTlLAZgdN+6uF2IIwAVtGheBWhIyqAydKulBA1dTYeMs7Th8WPAM0Rl0E9MGWo/OqH4022A7aKg2aLRnatnH5ImWi6As991lMekaVe1rNLdrQQuzxnN8Vqk6rG+Ssn/pfLnVJquNVtP2Mj00KCT6uyrhok9s0iznVlZKWZ2zuRVTKCPo3KpC7C9wgzDHJ+kNcC1yAs26naN4SGhtI9IrrBkcrYmGxFNCuvpmWbX9d8E4Zllq0yFjTIbWYFhM2xnqlDqEWHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IF7A3M9NpCIPIsJ1GGCTHc53v3nwLsUsBpApgpdchZfiWkOmtOxqpwoZtMr?=
 =?us-ascii?Q?6RxwtNpHIYj356BvxtPPrne1DxaEH8sXqUIjbieTl5jZORa+jOO9jB9QjT0A?=
 =?us-ascii?Q?cElb+G+XbvACYfFfAff8TSNsC+2Fl5FoZ+eqrE31ngMcGZMW6WffdszrOlZ8?=
 =?us-ascii?Q?+TZ7PCOu6yj5g/BQ7+/Jslw0zC6abyG9ngbt6oaNob5VCmZxn54cKXmazTTY?=
 =?us-ascii?Q?21AfksjA43VVrdi5oUdvqqQG3KvLOwnbMuov2E0rU4TiR9iJVho2eBub7C9N?=
 =?us-ascii?Q?z7APIbulqvltCDjB1q/F7LG9XemmipkNKYHJo/Sy8ZZWq2H+v+GSoAOq6rOo?=
 =?us-ascii?Q?96PQh1N3rHamthypAyHWejPZf2SwPXKAOCmZ0fc2fyu0YDMxrkZp9Th62pDf?=
 =?us-ascii?Q?MAhCoL4UQ/tzHtmGSFJCYdLfVTy/tklE+h8QGF9uNlEEe0LHVf3fgh6tLgsu?=
 =?us-ascii?Q?OYGiXSil1wdW7fl3jRSYmMts3xiUtEhraoEhtm0G4fqf9qGxYx/nTbiRzy1r?=
 =?us-ascii?Q?0HeNeHiA0+75MS526o2dFKVxuxQ+QVKWNWXl3q2aXo07q2k1RoHSP2j8GUsH?=
 =?us-ascii?Q?GeM3vIlmK9ixu73K01KFUjz84sNuvwntKCVsmNdC534AljB46B9chnZbke+2?=
 =?us-ascii?Q?mFKH0zC+xSprVTsiP3KlPNmfVSMiGEC9blO85NQELTYjwk53vgpHzm22NT3K?=
 =?us-ascii?Q?wUXnuRRK5RqJ5LDrOpNxyu3Br/W8j5hnkQTGwRBVvvoX+Nk5WpfgiiAMNAbT?=
 =?us-ascii?Q?SuUaBLSJkw9wcFbeTmD/Y36jUFwzZYUvWSRfX9kj+06HNVEQKF0LXxhFSpTi?=
 =?us-ascii?Q?OBRe4jcI+YXnpSp1mQ9ntnP0YdpNrOWZ3HB3lmHNQa10IuUzrTh3tux0kn52?=
 =?us-ascii?Q?fDePH0FsVJ5nHtaCFBidaOvdj+RII3bJlPxO4Rn1VCsHNehbKg/htD7KfUFM?=
 =?us-ascii?Q?E5kRa4LEhUqeyvaV3lrrx9UBYSCAVcamT2zwyJaA0E3DMJxPzyu/TWE9ciME?=
 =?us-ascii?Q?HkuWFEXyddRyJkgY5ephkutNP8zIybZc8RHTmsopmMmcCOXSr8qOA9I482Gu?=
 =?us-ascii?Q?ksPlZBjCdxRpLbhVrxO7M9OTOB/hBm5SreuRIRapnt+nd6oakwbEH6Lnrp7V?=
 =?us-ascii?Q?Es4myWFPsqWPnUy5oE804nx4i8GZuRCMGeBTqwuluTdMK3j+LOPMQyMTgemk?=
 =?us-ascii?Q?fD5IzjbTRIszzkDt8nkMgHj5eRFtENAvEjrg6YdIUNNONZSQW7dEduJa2+0I?=
 =?us-ascii?Q?JdCuw7z40IfpXMN2LMkloW0qBs4Mjiw/zlmIYXNKPbKKn2cZaPHSY7q8RI7V?=
 =?us-ascii?Q?Srjaa59Y87+Cm79p83qHEl0DPOjjQ+soFDA+w1sczYKR5pMtkrZBd3OSDOs9?=
 =?us-ascii?Q?TsTbxaoaHpRBJSNwjBUg4kNxEyQyhVpqIjdujzOOwKXEHZ1Ee53GjWO0i2b/?=
 =?us-ascii?Q?+1RZHAis0HR6yl+wpjTxjMqeOBrIS/UvsEg7yLjidR5uhEFdNYeeIiNNgs60?=
 =?us-ascii?Q?VZjTxVWVfRH8znlhMq6/Zt/RL2FCR64eFlx/9cKlCQaLw2nXCZoKbQQ8TzRF?=
 =?us-ascii?Q?MsIfiBrGvi+CjjKjudhf1A5Co5mXDpxlHHiSdyDQaQoODwIjFWGF0/VPMjnw?=
 =?us-ascii?Q?ill9IGy3u0ii6TYs5fjETA3emh9xAPKWTEr2VlolAjCx/5f0VfOIyU4CiKmO?=
 =?us-ascii?Q?KCO1Rcct5pc9VPISxbGWIPBdJCW5GhR/oKzwSX3Pcf1C5CtdDI39PebPgcAy?=
 =?us-ascii?Q?3wwd1PvtNIHRfhETSJujMg2j6xlOL3E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f655030-83cf-472a-2a9f-08df3a99d22d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:04.1340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDLd0rJrQ64Xe0lfWz2JLDCCC296yIGuQpIydnUnduddeiBKtrHhrmLr0e4jP4nIutjBTvtExzOT2P1zMh4mKVmyDheNylp3S+uCY0Hoquo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB8801
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The e6500 core manual defines PWRMGTCR0 as SPR 1019 (0x3fb). QorIQ
U-Boot and kernel access its fields during processor power setup.

Define and register PWRMGTCR0 using the existing 32-bit SPR storage
to retain the programmed control fields.

Reference: E6500RM (Rev.0), section 2.7.7
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e93f699f83..2bc0e36c5f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2348,6 +2348,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_Exxx_L2CSR1       (0x3FA)
 #define SPR_ICTC              (0x3FB)
 #define SPR_40x_ICCR          (0x3FB)
+#define SPR_Exxx_PWRMGTCR0    (0x3FB)
 #define SPR_THRM1             (0x3FC)
 #define SPR_403_PBL1          (0x3FC)
 #define SPR_SP                (0x3FD)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7bb4e4bcb2..cc702d7c7d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3026,6 +3026,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     }
 
     if (version == fsl_e6500) {
+        spr_register(env, SPR_Exxx_PWRMGTCR0, "PWRMGTCR0",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
         /* Thread identification */
         spr_register(env, SPR_TIR, "TIR",
                      SPR_NOACCESS, SPR_NOACCESS,
-- 
2.53.0


