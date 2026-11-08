Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F1606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=OPdswz2g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cr-0001ph-9c; Sun, 08 Nov 2026 07:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1bA-0007Fk-OC; Sun, 08 Nov 2026 07:02:12 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1b8-0000hv-Mo; Sun, 08 Nov 2026 07:02:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/kSt9gob3Q/lUa6+Sff3+0Am8Lfn9qJJV+w8Sx8W8OAKSaQuzQhxqec9IpND0DmXO6Kg5WbKdUJsHcNpRRuY9llqqaFgVpka2NiB7RzCSbCfRmMVRJVe4WeenA9RvHS/i1Ok5YLiJrid2UNem7Ja8DymbPBYStj3zKMdJJb3pjHagpI0ImIhepY8V0RxlcNfVgai/7XLfGzGW1cGM1WhuoP8GyLRqg9s8IPNBHitmjuneRselQlf5Kcc86FxGjN44NwjgrZSaZvchNDuogZcutJQ+STAEE39+kwsud9xNlAVktUBNWz3amMoqwzQEjPPT54rp27GCD087E0o9m3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5IvRlreXLlhdewOWsPVIxRUsLkEY9fjPjmJHF9aVys=;
 b=dQDwoaAnk37WOTkHwhF8EPoJAVvoyoKcZNuOSS72/4fnwAsWEYMrDPeFpWoQGeo8vR1rfDTn7I8l3oYA2ESxY4Wsd703SWKsMOBO9zLb/nnN4CArThBqNVFa+fHzi8ep9RVAckxfFet60oUjnIvHioAh1/2r59JtHR7V2DBpmuyXJQiNkHFOidauMzc2NJRCubSt4ByOE5PNjZxFmhNwD5pYHa/whKOdK0oRPgjzBQgtLf2mGuEw7ur+7SRcnS5h+O00f+eBCJKBlVOxta7aByXhaeSIQVgKQhgcUt2vWhmk6b3rHoIR4TKCAte5gwnZXIDegmsR2PjReWPI0VOPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5IvRlreXLlhdewOWsPVIxRUsLkEY9fjPjmJHF9aVys=;
 b=OPdswz2gFdGFWx0vMtaFlLIavwU7YldkY0Nc8WNxJXo+N4Wm+Vz4oT+L/Ovc3l+Pook1V95U2c+K53tg3vMAvJrEA5PgH/1MfzmOGPvhzzuhG7ON0guJYUDjbwm8xMlnNdusFZa+xlpBlBiwQn2REs0qAjwrS+xnkn79PT4liLJ1H1LpzCu12+NOowAqwibr+EZ6+jL2Z5MSsTlCgWqU3p/EXqXpmYbrozteZw/A0wRJvY8bFTRp1kAKHK4P+8P79kUrCoPC5zyHuJwjDbTV83fJXTi870zAng+6o+WOjEknF5IHykEjbFhtR7CwfdgqtodTxHEn5y+4E1ybdZ2ebA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by SEZPR02MB6945.apcprd02.prod.outlook.com (2603:1096:101:19b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:56 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:56 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 23/23] target/ppc: Match e500mc/e5500/e6500 host PVR
 revisions
Date: Sun,  8 Nov 2026 20:00:22 +0800
Message-ID: <20261108120034.1755008-24-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|SEZPR02MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 786c8acd-dd0d-4858-c5e5-08df3d9015cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|261028144727099003|261102123227099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: wwg8y1RSeMatQ82rydzkwkXCPA9Gd1kGHZvKMy1djnHI79sllBcTsHyB56SBRKjG2WCQaSM684E5SXBd6DSQ5uHYaOKZV53dq96fqRrqH2lLvEBdVt2egDH+SJPIRbp/ZEUSv8duFnqiLivb12Wa7Wi9kPYvGbcBY7AunsvtsjoaohEDnIviBFcOrZcw42ZhEovp2Wv5ZqGdT8PRNHIb2SH0thAkE0fNH+oGqIVgJc2FB8f+PP62bCyyXPtW9oF/JKjw56T8Amwy4Ds/q62umIKA7HJlxLux/JkjqsbnN/9aMnBHdZq25RI0+TExDYGQ26CXZS8AVrBZ1DdzbTD6uOHpvH8z98uSCXVgDxJRmPFwHBHXDs4rtNgTXdKxyrLZcLWKbS21C9uX2dMY9VLHnnP5xxt5nXbE3zNdBwpORNHBsqh6ijIEbfu4g3uaX2jBJMWpd0eeI7BjLxPb1yEQVrpzkSFV/LCtmyXv9dLC0nPW8pZp7ShVCMEqwmtGMHM/5KqtiDUvUrDqJNS1eq7G1u6FxHQStXs27suHKQsZhe+BOHOlpFG0g+fxJPcNQ9Lez5GRxGlm6SQjrPPzwKWdazJBsoiRbXlhZEW0OL5tlM/FIqGIwEl4+gtqsRGjt2fDUBAOludsmtUq3BzgVxTlQeIrk2Wl0jeUg5GieWRAh7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU0yNy85U1VzaUNTSENLNEpNQXBBOTdWcnEzaUR4bUloalVHbEVMaVIxQW9x?=
 =?utf-8?B?c3pNNUFUclVCYVIzbmtyZ043RzY3SHlhajB1V09DUGY5S05NLzc2eXJtU3g2?=
 =?utf-8?B?OW44VDZBK1I4ZWpxSGNTeDVycDNyTXVUTEI0ZXlvV0ZQRDVIR2EzWTB4MVBp?=
 =?utf-8?B?UUc5c2x6QStrendyaDBVSGpTZHFCRllTalg4TGQ5eFZqcXVBQk5SSWM4TTRq?=
 =?utf-8?B?V1JTRWI5VlcrMG14cEpUci9wZ0g5RFJ2SHFNS204WkIvVDFJS3NWajVyTTQ0?=
 =?utf-8?B?WW00cGJhMVNnVnlFNjNNM0hrYWhtbk1HaHR1ZkY2Z283bDhTMEdlcmVuVHVt?=
 =?utf-8?B?dzZaTDlqR0F3K0R5OXJuTk1qb2c4NThRZVhwTVdPOFQycWRmY25uRkMxMkNn?=
 =?utf-8?B?WTZrUVA0V2dVSVoxV3lrY0JZR2pBVlhjQkZUMitsOGQ1ZnMvVTZ1YzlJTm91?=
 =?utf-8?B?ZVpNQnlhUnJNdzlrenFXR2NxVzN6Um9tdUVIUjk5dEh0UTl2T3ZXYlJpVFJB?=
 =?utf-8?B?WVBhd3FCKzVjbE5PcEVITHVoWm9iSVFoanprRnc4V29wUnI5OTRmMkN1V0pB?=
 =?utf-8?B?enRjRk85bm1kNDVCQlNaZjJnZG9TdDUvMWF3Vkp1bExQUTd5Qy9aZFlxQXEz?=
 =?utf-8?B?NmYxQ2Nxd1phRldyRmozTjhOQkZPMW9UNS9VMzAvWHpISDIyY2RUYW5KUm1O?=
 =?utf-8?B?QXRsR0dUS2VFbTFNdHQxc2hUZWw4bkZ4dC9HL1d6ZHpyVXZtZXRUQ3lSNDRw?=
 =?utf-8?B?anNnQ2h2SmpMWUgzdUhkN0lFZkhuOGYvdUt0dEt2YlV3cDB3MW9BRWlOOUJ0?=
 =?utf-8?B?TGVoK1pmeCs3VXFJRlFxbjlHcFBqN3lWaFpxNkxPd0cxUVE1TTV4VjJOTFMr?=
 =?utf-8?B?dDZGMU5mdFMzOWE4aHNsRkk0b2xhbjlSb2ptMG9FVFcvNDR4V3FOeEpEc0tL?=
 =?utf-8?B?QkdMVmFkZGEyYWNRSklCNE05UkVOY3dyL3VyNUJ2aU5DT2lhZ0hQbXlPa2p6?=
 =?utf-8?B?MXRDQW5adkx3bFlEUG1JemovWFpBWFljNDFLRlJmYzJ3QnZJMEZCK1I2YXFj?=
 =?utf-8?B?SE5sSGgvcWU0N1BBeHh4UGhEemUzWlozWFhPY3Q4MzhNL0pZaUVTeXU3SmJq?=
 =?utf-8?B?K2g0ZnV2L1draTZCNTRCNUR6YWNjMmNZRStvazVHazl5VmlDZmxRMmd2OVVL?=
 =?utf-8?B?eGduZlZRZ2VpQ1ZkMmllRSs5Z0JGRXo5bC9abjRkQS9CdGU2aVluOG9acDFF?=
 =?utf-8?B?Um1JbjRCWFErdUhOaGZid0E0Y1p5MHpFOFZEam5UREgyenhlN2N2emY1TFJn?=
 =?utf-8?B?ZWRreHZ2WFlRcXI3Y0tEMXRZbWRITnVZYVN4WWRBRVE3R3VjUE5jeUpNRmUw?=
 =?utf-8?B?VnJ0L1NqdUZDbTMrMkFxd2ZZSENkeUZEM2k3VG9JSmthMXZYekVBR1dydkNr?=
 =?utf-8?B?VTh2UitxcXRtdzM5aEgrdE9PWUdJNTk2QTlRQzJxV2tGSDVOZFNNYzNodXlK?=
 =?utf-8?B?bGdLUk1XS1BzNW1VSW1aaE1pRW1LUzlBei9MQy9KNnJZUWdVZjc2TjFCbHky?=
 =?utf-8?B?NURjaUFEWTkxcUprZnB3NVdDekpaZmJUUkdqT21xcWtCL0pSUW9xNHNQMFlh?=
 =?utf-8?B?N0oraFIrMHl0S0lWYjBsb1hoZG1JMDhGT2FzNnVRaVVVUTBTOHJUVTN6NXF0?=
 =?utf-8?B?QjNZOTgvWmkraURYWjBsdUVlQzkxT2tHWWQzMU9abHNGYTF3bUNGSTcwZjd3?=
 =?utf-8?B?MlcreVgvT0d4ZXhwQnRzTzkyT1VYL2pzZDNNV2xpNmxrc2ZDYVl0SlNEbkRZ?=
 =?utf-8?B?OHVaWGpoMWRMSlZBUG9WM0xRbUZERHZFUTZoTmU4VGpWeFFRa3JKZWpPdThL?=
 =?utf-8?B?aWllUWd0dEhVbUwwQ3ZZZ3I2MGVNSm81MXpaYnQxYWdVVHl4eDN1OXdxWmg1?=
 =?utf-8?B?bHRnUnFvaEV5WXhwMmQzOHVZRzhWUFkyaHB3WDJtRGwzM2hyWERWSHVHMXg3?=
 =?utf-8?B?Q3MyRGpYai9WY1ZvWUFNandsUk1VeHBHaEhwTDAvZ0ZjVHF6TXN2TlI2M2lV?=
 =?utf-8?B?RUpab1RmRjVINCtPaFB6TmtpM0JiSGZFajRWN0hnLzVVanFUL0UxVXdsaE1r?=
 =?utf-8?B?Wmd3L1hpL2ZvWjRNWXIwTFRiNWlCSEgrL1U2VE83Z05pQ1A4dWx1WVZ0aWNS?=
 =?utf-8?B?Ykx2Y3VaTnJFV053MDVWU3NmT2gvV2xRRytLSEIvQUFmUFBoMUhnaUR2WWhx?=
 =?utf-8?B?V3JLTjJ0Zngwcm1kK1pPN0ZPY1Z0RTh6Snh4amVObFp2Z0JhMHYxRm1PL0dy?=
 =?utf-8?B?eW92cE93T1MxOHdtVEpOV1kwQVJNSG4yVU11Wk55SG1BL0MybkNQUXE1NnZV?=
 =?utf-8?Q?Hi9iMO0l5QKhsmF4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786c8acd-dd0d-4858-c5e5-08df3d9015cf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:56.2030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SkoCQSlu/wTVBnuJ2xeJFnZQjaTqet3kRwPCoPrAH7fnaMHzCuzXnwnNCpjE8BF0mkTOOKUSX12nW4gmsbElZU2g1Z9oTvCoi9eOcactvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6945
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

The generic models use PVRs 0x80230020, 0x80240020 and 0x80400020.
The default PVR callback is an exact comparison, so KVM's fallback
lookup fails on various P/T-series SoCs and the VMM cannot register
the host CPU type.

Match the architected core-version field in the upper 16 bits for
all three families, allowing differences in the revision field.

Signed-off-by: Bin Meng <bin.meng@processmission.com>


---

Changes in v3:
- New

 target/ppc/cpu_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a2da7c509d..42d69d0865 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3159,6 +3159,12 @@ POWERPC_FAMILY(e500v2)(ObjectClass *oc, const void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
+static bool ppc_pvr_match_booke(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
+{
+    /* Match the core version while allowing hardware revision differences */
+    return (pvr & 0xffff0000) == (pcc->pvr & 0xffff0000);
+}
+
 static void init_proc_e500mc(CPUPPCState *env)
 {
     init_proc_e500(env, fsl_e500mc);
@@ -3170,6 +3176,7 @@ POWERPC_FAMILY(e500mc)(ObjectClass *oc, const void *data)
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
 
     dc->desc = "e500mc core";
+    pcc->pvr_match = ppc_pvr_match_booke;
     pcc->init_proc = init_proc_e500mc;
     pcc->check_pow = check_pow_none;
     pcc->check_attn = check_attn_none;
@@ -3218,6 +3225,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
 
     dc->desc = "e5500 core";
+    pcc->pvr_match = ppc_pvr_match_booke;
     pcc->init_proc = init_proc_e5500;
     pcc->check_pow = check_pow_none;
     pcc->check_attn = check_attn_none;
@@ -3268,6 +3276,7 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
 
     dc->desc = "e6500 core";
+    pcc->pvr_match = ppc_pvr_match_booke;
     pcc->init_proc = init_proc_e6500;
     pcc->check_pow = check_pow_none;
     pcc->check_attn = check_attn_none;
-- 
2.53.0


