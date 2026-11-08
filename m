Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41958606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=KeqV3yaG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cj-00013z-Un; Sun, 08 Nov 2026 07:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aT-0006lE-12; Sun, 08 Nov 2026 07:01:36 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aN-0000V3-VF; Sun, 08 Nov 2026 07:01:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBA/O5KTIWHoSNZZlaWsvvuy79yDToIv1MrdwtNvPZEh3WJ3yhAFLwUNNee3beeZFfUxoemqz/mwSJjh/eUBVTIrIECGcI6dJYXQ/BSNAe0ECGROvKbjtBQLrm9J/LlS1UGsQTz1obsfcbh+rPMzdK+Be+tOUfnFOS8hZyzfNCksBJifRysOx5jJ6MHU+pwbnnsYzn6KaUgs4Gv0uoi849CFm6/kTsmTh1PX4Z7THBCKXCb8pRPgVWZmjqdq/nFLJgtcH75+QLfI1iuNELu7wjhfRUBvbodUI6kn6r6mTEGultVrGKsDpaF2zydaXFFpgORsoeOsKu4zxojVfHceqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66CfXJKJZDtG1nLLg8rHcoUA37Z06RIVA6uaYv7582c=;
 b=GF13PQubk9jYc8BNdDjBiZk1O0hM9xs5HtBxKkxnstVNnkZ0xagsb2EnWW/I9UH7lPt/0hmip58rn3bR2IQ5rxsgMKyDE3jBplMVfHtwLNtGYxkNlQAR6Rcs95qEDojcipItgt2uKDZZBGgLC40UK6NzZxEqSf18W+DQ5DfxcEsB9bjpttWS8BvavEnFa5JvJquN+IhOcbliyh163VZrvOgTcU/nMudWmPakg2F827cinr1gosVTs3FvWhEiO+KpPSZPaX7n71n1FUOkOJzoYvSucqEyV8MLIog/RC774OIF0Nm0cFQCd2CU+YCquctoqJ/OuSa+HhgRrNMo977gOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66CfXJKJZDtG1nLLg8rHcoUA37Z06RIVA6uaYv7582c=;
 b=KeqV3yaGnMzwOqw/djuYT1hgYOuZuDh1Ia3AZro9Uj0C8QC/8B0BnGndaPS7Y2rSxSCYELkRb9xkWYQy/0hn9u48uBJH5RsftAmMVGEgqJKH3WVoz2MfNzVBVgYjxogxsCjuiEVNnvuvQcZwqw523tkrm+ceogBD52cRiz+bCdNWJfGjiEkJBxRidUdII3BdcmufRTtEfvcSgy++BtnWvlB9tbjzCNZz0qjvYvmMo1iWQn2Aiea1rBF8doN+37qXYWdCLBzo20DJgyTeCU2Hx1QeJDl7zcjoS5XEAJ1HV+lOmzfAVCuLkjbsBDUiAJpqWgG0WiYPKTnQFxUghBKFXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:12 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:12 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 07/23] target/ppc: Register L1CSR2 on e500mc/e5500/e6500
 cores
Date: Sun,  8 Nov 2026 20:00:06 +0800
Message-ID: <20261108120034.1755008-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|KUZPR02MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 472c9035-65ab-4ad7-2918-08df3d8ffb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|10067099003|261102123227099003|56012099006|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: cm/wc6H5JLBTEyzh7fD27gSffULZtHJMmcZT3JqYmgcQx+TvK11C2PDeVjq4/uaxUUhbeq9o3DJjYimvIjH+vx9ti7acNhpXCYmxNS8sg6eKnS0rX+tifaivugpKULPajxqFgFM1T/fqLqOI8iR4KeJGZqMazw9cdt9kIDOtjhYi0OQRQ8qZjNvOfTxJyltqJC/a0DrOMhz0JY0agqZtx3LP8TWipXOq/Z5v8iszIVx0igfOxyFKOr+0c5rqrSsyLkirOgWQyfJaW1m2iluDp+vhpZpAhUpT6OXnqgTjf81mezZIVWkti2W0zcDM2f0iVfJSf4UXPBt2Axa5a7eDGXAinc5f2zXMkTu62OrA7dOJTS2rRnHRZLXduC39JLn/76Rde+TXfSoHU2UVPxlj38iyPcY+RWlfR6HLuglWFNTa9P5VpYZMCOGoze19su850SaoZpMM82Sw9nqbi/A+xHEiv4xevjV6nUdDd89o9rPpEGjuN12isnTbpOsvIKJTUFe7K+0521JQN+GwMRcya8672OPKlQlcMh7mBN3OycAoWVmenDTjFoGLXTDr6B3IRUi024hLTbUVPOK8e3I6DAMdSa751ThMbUKE2v/cB4Y9sVuyl3hJfNz9PfV4OFaaMs6v5+/eUfaMRgTsBkU9ivHuNKbmwcQ1lx/PcBRH5q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(261102123227099003)(56012099006)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQmXNEpIqGIqHdHpkYguwq2voB+AY0PDDttzMpKW67MZeHOlj+FT1DMKWaRS?=
 =?us-ascii?Q?orLQpWflGH1D7M1FGX5otNv6pdl0fVeIyv58I8NV9Kr8QeE40rFEclHc2qrw?=
 =?us-ascii?Q?W2E3hgVM1JO0pFjxaqDvNPnAoRamxQbdQOvRhS6wj9IeW+ewqtAnb4GHvqcY?=
 =?us-ascii?Q?LV0NlaNMJbV4gK8FoWRzQyNjjCO9/5m7ODFCGr40PlFeSZ88Op1xgEvIEzpr?=
 =?us-ascii?Q?LOnPJFQgCnSlNQzwFE3AxT5F/nsgslkyX81jNqYNu+Dit2rMF8N4Za8SrxUC?=
 =?us-ascii?Q?AkudMc5DujNHtjRxQgbqmF+TvsPcxUeaoy72coy2aYWw6HbTm375/gfu6eOB?=
 =?us-ascii?Q?7XEKFoK6hWN2v4PmPNiLcN4EgpBGOBxsoYGMV/1JSSZLLztuu7HNNxb5tGxO?=
 =?us-ascii?Q?4e/azWSTm4GWEV9s39Pj9jgrexBnyEvojnfNhy0BbUiU3M+FgOXvI5N6eCPA?=
 =?us-ascii?Q?3k+BpS6uvl7bC6Ai4mWfToRJztqsNm99XS1TdvH7i0Q1GQGmMaYghfqVS4ew?=
 =?us-ascii?Q?f+gUtOSmTmdnbyOgG+vKKLBCRY+Kyn95wSG8PhNnSBm0bnDGri/1zR12q8aW?=
 =?us-ascii?Q?jlTmte0i7lZMeCBWxLTfdKXwoCRtCrOKkGJLIu5EubhY9XWB/fNmoRKPlJe7?=
 =?us-ascii?Q?vdXyoJeXw58ilGg81TBBD7gRa5s8rUB0ZDmoaTc4bRzrq5UekbVKCXvQoJsk?=
 =?us-ascii?Q?XtDSi2S//FqzHiFhwPgRYT9ZpI19CW3YSihHh6xEcCgWUBSBZLo84ugrREU1?=
 =?us-ascii?Q?eLZUbGmkjfknyYDtnH2BpXk0EtfIkbggHbbsb0NBXeaccA9xtfM7c8DyoYeT?=
 =?us-ascii?Q?hxKKf+S9IM1pRsuXE02KjJ632xIySnrYm8OkYPMi8j1OoR2j8ar5cd5apENf?=
 =?us-ascii?Q?uAmPTlsjVrlHiLw6VU/xUVfV9NnjyLZpO3IKAJp9CVjPakyOXYG4XN5AHRc6?=
 =?us-ascii?Q?CVJnGbLtI5y8EALV28n1wap4nB3yoI8KIW1c9+TztUJiOzLwBca8itfQUZCy?=
 =?us-ascii?Q?TnUfX0VIEQzZgvDyFV9aizYuXUCB/zsWSGV4a7B3e17OYjWbxLTAskp+B8Oy?=
 =?us-ascii?Q?wGsdTTkk4e09Q8x9/Vj58cIu9S5fKY2rkjVULgulu34UuXUEWYRfAczSUSjA?=
 =?us-ascii?Q?tH5pTUHPZo5WsLEGUX8wyplN/Qo2LIIYxSGg8y3CGYyWxJWi629eAEZtAG14?=
 =?us-ascii?Q?ZqdcSdMuul+Mt5OXj3QlXZbcWoBH8i3o1aAe0K2KTUhvYGaNtubvebnA6UCt?=
 =?us-ascii?Q?UEgQrUZpNo99lEsmOY3WupMhezg3hcor8jI75urn9O73Ac+Hy7mQi7igp2XY?=
 =?us-ascii?Q?wK5kNR6Fsq5DCd4QAcPe0AO91XevONAKkDV8qd83gz4feaVRvsfw0fDJbTDB?=
 =?us-ascii?Q?4Y+DLIKrHrfvGOG8Jhu6HSJSvssiw3Offzdd5326MIBKZsdhVOgtaX4YmMH3?=
 =?us-ascii?Q?WLO24/iRCeeLJD4gztIJ4bN2ZNdEQn6UqB7rueReZEj0GjId6FOF95Wf4/+8?=
 =?us-ascii?Q?zOc/ivc4586HVWprHMxXdJHyYl17prirkc3+kTkV9V2qsmtti7XjsO10XNv4?=
 =?us-ascii?Q?k8hJMTtNL3kUR2aVGEXPo6iwoCedo18CEgJWWOwFh4SI44XudKnlZJPVpU2q?=
 =?us-ascii?Q?rjt3/JdktCr+IPnp+8asuMYCNMPzMPOhRyaN2oVuSVSF6pOSwru7u7vBTPAy?=
 =?us-ascii?Q?EJ2+SH8zfphWxilprnuCvAxD1qrFf1AcEDLyspEN8uKA+O9c6FmvtCvrZuEB?=
 =?us-ascii?Q?K3OnyWt2H1WIkQVq/HvXLtKLAu+98tI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472c9035-65ab-4ad7-2918-08df3d8ffb96
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:12.1773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdq2o36ZVh9L4zRW/j4aQtE6HvJPORvAKDDg7ZYIf2oTlR0M52ey2b7YlVfP/6Ux02R9XRBZHQ+JG9jxFWm6I9TCEfGlbj4wX799gy8adTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
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

U-Boot programs the L1 data cache stash identifier before entering
its C initialization code. The e500mc, e5500 and e6500 core manuals
define L1CSR2 as a 32-bit SPR with number 606 (0x25e) and reset
value zero.

Expose the register on all three cores, excluding e500v1 and e500v2.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference:
- E500MCRM (Rev.3), section 2.14.3
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.14.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.11.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v1)

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0cbc55c470..0dea3a9d2b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2040,6 +2040,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_DSRR1       (0x23F)
 #define SPR_BOOKE_SPRG8       (0x25C)
 #define SPR_BOOKE_SPRG9       (0x25D)
+#define SPR_Exxx_L1CSR2       (0x25E)
 #define SPR_BOOKE_MAS0        (0x270)
 #define SPR_BOOKE_MAS1        (0x271)
 #define SPR_BOOKE_MAS2        (0x272)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7a569970bc..5db9ea8b70 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2965,6 +2965,10 @@ static void init_proc_e500(CPUPPCState *env, int version)
                  &spr_read_generic, &spr_write_e500_l1csr1,
                  0x00000000);
     if (version != fsl_e500v1 && version != fsl_e500v2) {
+        spr_register(env, SPR_Exxx_L1CSR2, "L1CSR2",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32,
+                     0x00000000);
         spr_register(env, SPR_Exxx_L2CSR0, "L2CSR0",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_e500_l2csr0,
-- 
2.53.0


