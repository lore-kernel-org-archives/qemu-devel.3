Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E398606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=L+lMnWwk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1aE-0006dU-4u; Sun, 08 Nov 2026 07:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1a5-0006cx-Qi; Sun, 08 Nov 2026 07:01:06 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1a3-0000V3-MW; Sun, 08 Nov 2026 07:01:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQscELv7v8USUgfpx3mWhxT+R3RtTq8rr9iAkO4ujptor46DGN5rAiKwfZCNYLCr1FSQ3/bWe2rtnIw3fGKMp+mtqNjwnWHvTQKySvsS97YfE56a2eLubRPr8/FrRfpZGLfPAz9zEzdJvwXWC+fiogLD4PoC2lHk1LVldxSWmVEcR+0i4ne3MdVJEBOUjI3YvKReQ0y3d6kCh1s65yfj69JnqprHFVxcdpYjWH94A+0zO88wkWQlCc6o2M4X3sDoz8mL3A589Zysl8k9XWdPQpcGoZWUxukPlvnb55OXSzC88Ju743U93GNByCr1ola//UnL7QKbsq50PGaZhzaH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL8oJAnb8eNooCaeN+QGdDiBTuGKMdEnq1WHgTtk0vE=;
 b=yHZGomvpUKrI3G9PoPvQJdz50ow6UuVU3/wFaSBH0wFJ6C7i+KkczheSMQeB1XhLMkFPXihKyNW2UMaYddbYXbCsMLQA8cyrkdZkyB1zaa/4gfaLS+K4E2dEwnCD20RAxiyrfQoE2hxez+pnMdbvtuDT1LfIq65Ad58z/eIPbZesLJCPlbESnJ5OEyNfprR0UFx4RCZNe8DKsmObwCclJw7s55s9HBiiTawKFBf5vFYWK3fCW4tzNXMDSDBTYc1gAkdVOUhk5usK31hgWRRiWCeR9AMh/NUrETYSSgwa3Efsm/br7Rr9sHbvWBk9/DS9tu+DppRO9VtL4l+9MyMjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL8oJAnb8eNooCaeN+QGdDiBTuGKMdEnq1WHgTtk0vE=;
 b=L+lMnWwkEpCTqp+eCLr4RModw6By7hPzFv+kZFOfNRw60M4LCu+cZi2ZK+aa+H79VsxACDYa6b8Cx8WdlRzA2hH7tyb5XA1E5ThcCiPEqLkJZCMkqCJe3aM7KNFp04a2yKFhfjPeWjKS/Yd+ngY69+XZ2pVCs7QPMMc7HBFOI1qFxO2wN0GIlUj5qkSiSjULhGm8uMFzCGcx9qtNJSdGfyYM0hiYL9TRJ0K+b0Z9UTHOxvkYFm+yHskf2aqMGH4uipB5HlHbVvwQEdDsUMEPbWzN3S2ZK/R7SOKumBYYHpcT9RfBG1ASNuauqbGygreNbGwxApM2wQYetSwAJRpOEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:00:53 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:00:52 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 00/23] target/ppc: Correct Freescale Book E CPU models
Date: Sun,  8 Nov 2026 19:59:59 +0800
Message-ID: <20261108120034.1755008-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|KUZPR02MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: f88fed94-8b93-4a9a-ef30-08df3d8fefdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|6133799003|10067099003|3023799007|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: eM0IqXu77f/NpiTC0l4u2aG/DEtPwJ5QKjsBckm5jceH6/KEFXj11pxgB+9Tw6Ud2FIMLRKYyp570LSd/XTF77RI3xTd9OHWQt6W+EvKuLHCt7MmL7HanH1Q2EAy6HZu/mNnYggX7jZy/fT2TE9LFv+2984buJrhSeF8mXsGO0ugavc11F8VCHUUhDmMYTVV1hiM2/p1ebcO2zpT7h+ueOdeoiW9QRaKOecWEy0Z9YPWeKstDIVUIdWcSG4VdmdpGOb86B8yKUS6MgnnTm7IlopIcwnUK8O85NRDQvtAvHYWkjlTGuj/qUwhyeCHBgVrGIThw2EA1jGrOOsllMxZ+YW+Ef50ZNDfbZMez1sdW9SXAwHehnTngCuGrOTaItlNPn2Miund8k/YT1Un3E1U89sBtq65vXVKrfXseUlWj8QyyGS+IyPyycZdWrteM0kAtpHi/mHltEd11kI6z/obEBxQOGhQfWNCzsfpXFocIL/sFNQM+HfgX0vpnFwbQtkW0hPKsLMjphj38SARY3U3XJcIl14xL3qzNxv/Az7T168a+mvNFDeJd+FbS4VNmmtbVRwRvUFH1cXw6fFt+IoPACpJSPh+MyVOGO2Vp+bKXOnFlRfJFXT6X2FgRumJmWkgsikqjq+64gMzLOT++zGBI32Q7faRQkv3eYV0RvsoHQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(6133799003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009221227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0Q3OEFXM2VsZHNWQ0Jkd01Sb0pKZUFBV0tZVHRSazFsV3lyTFpxcmRsWnF6?=
 =?utf-8?B?T0FiaE1PejVJeUpGbGlWNnlBVWRpcFRTQS9kQVpqNktTekNzL21GTE1wNVBm?=
 =?utf-8?B?WGZ3YU9UdlcwaE9sQ2M3NXpxcDJtRjkxSzhwRlJGaVhISHl2UWVUSlpjMHY2?=
 =?utf-8?B?QVkvbDQvZEpmWXBKMDRhMmkrUUhCMTFsSzNqWEY5VnM5Y3l0QUZEUFdhRElz?=
 =?utf-8?B?NFlYWkZmTk8vVnFUeitramp3WTd5SEVrbDlGdUJDaDROcktIN0hwSUlvTndL?=
 =?utf-8?B?YmkrMTF1NWUzRWEyOHZ6WG9ib24wSFRFWnNOampUcTY1UldnM2JsVVNzVEtW?=
 =?utf-8?B?WmQ4cTJRYWZuQ2ZUaUVadzZHRjltRm84ZDNVZkNOYmhjakVyQzR4dXF1dUZF?=
 =?utf-8?B?NDRwRXlGY2ZMWnFDQmNtN0lJL292MHJYczdXZXNDcWNRSnpkWm5YMi9pRTB3?=
 =?utf-8?B?Titsa3VWNkF0VFpNam9QYWRoMVJCNmdkZW5abENlZnh5a1lpd2JYbjVZM2hi?=
 =?utf-8?B?amFTRTAyUjFLUTVoWXVYUzZsREpBeGMxeXZwSE5XeUNmbHZyWGxoSWZyd1ZB?=
 =?utf-8?B?SmxmM1I2eFhOUFkweVdMbUVpdmNGRURmMi9VM2Izc2lrbTVnNlBSaHZkR09z?=
 =?utf-8?B?Y2JXRkNPcU9lVHRmQ2oyd3NlUDRtT2VXRER5am5XTkFuNlgvWkExTWRKOVpm?=
 =?utf-8?B?NVZGOTlVV0UzZXJyMmtIb240alhGNmttcFZxVWNyUHBCSlErMjAydVZNZTJW?=
 =?utf-8?B?MzRQN1RJbjYyTmRGbFl4bU9xbUtKSjk3Qnp1NmN2bm5XbjZZZmRUTVJCZ1di?=
 =?utf-8?B?dlhJQ1FDVlA0VjkxM1B4dlVSOUUxMWpsaEhsc3NyaHBKYjhKbnhwbzdHV1ZI?=
 =?utf-8?B?SU9KWlBiR25nWWRvZFh2NWpLbjBBU0Mwa1hqN24rUGVRaXlhNWZMcXVScnNC?=
 =?utf-8?B?Tk4ydWNtQ2RLcVJDRlBCblp5dzlXcW1NUzMyZzJPM0pHbFpnYWtuTGV0UEF0?=
 =?utf-8?B?Q3RHWkNTT0FLK29HZFFYampOZVJNdHFrSjhCc0tucFJWZll2ZkhISlg1SE9Z?=
 =?utf-8?B?OWFuYUVNVnEzMlh0WnJXbmxhL0hNM2lodndoMEF2K0Z3UzJPb2VmMWlXRlhn?=
 =?utf-8?B?eC9GellaTTdIenhCY3IrdlVJZ0pxNTIwSmZiZXZGa2xQb3I0bjA2OExjTGp3?=
 =?utf-8?B?NG1MYWE4UHk1VjE5OTFubmR4MExmYWcxRFR5aFExUmNGNE1CYTdPRDdrSSs1?=
 =?utf-8?B?MGxhYWVkejFxS3dvZ21Td3VjTmg3ZGtzOWRtUi9FUnpkVXdveERpWllIMXRC?=
 =?utf-8?B?MjJIa09PUkV3S1YzTmcrN2NiOXcrNXpqdzdrKzdvZzZsMm9uSEc3WjdNZmo3?=
 =?utf-8?B?bkMreDNMbURWK0xkak9NWWZhV0VXV1JWMm1URUhERGxYZ3Q2NWFlbzlQZ1pq?=
 =?utf-8?B?MVVyek43WXo1RG5aN2p2Zm9aTDF6WWRwNFVlTjJsSHJUR0ZRY3JFM1V3UmNP?=
 =?utf-8?B?WUlBV09CekEvYjdsQlJXcUdVTkptTHNodW1FYVlnYmtBTisyR0wxcXQvSEdy?=
 =?utf-8?B?TDg2TE5vL0gvaTRLVEhsZGx6Z3NjaTB3K3Nic0syRGIrVnkzcE11bXNvRGVn?=
 =?utf-8?B?TWxlREtHVldTSlFoWUptQVZ0aWZGbE91amNGOUxsVGZwRnlRcWV1bE03OEpF?=
 =?utf-8?B?WG9xWUR3NkV2cWVOandpV3VnTjllZUFVN2tYZDQ1YnlhY0dMdzdha2JFQm1p?=
 =?utf-8?B?dnVjME81WENWaUZwNG1YMUplTG5GKytGQWVZVFk1QWx1UzZ4bnUwZEdHeVV3?=
 =?utf-8?B?SUdXaWRxakoyRGVXZ0hnSFpwb3k3NmplSTY5U0ZQQlFXU0g2TUkxZE5DNnhD?=
 =?utf-8?B?N203MlpNQkZXbEd5S3BQOHBnZ3pNWi9veVdoL0RrSGw4MXBsdDFPMnN4em5m?=
 =?utf-8?B?Wko0eDMrYzZXVllEbDJtSVg0QTJCRElKelBiZE5RKzZiWmgyS1VkVzlCNmRs?=
 =?utf-8?B?VTdPcTBVU0tBNVhBRFRrRXo0eEN6MDdpY2Exb0hoN2pDZ01TQ2FzU2FSYmRZ?=
 =?utf-8?B?S2dOc2o4bnlLVWFuV0Yvb0U1VkwvYy9GaVcxM2hvN0FFZDVtaEVleWJFVmFv?=
 =?utf-8?B?M1hBeW5ET3UwY3JTTTJQVEM1MVZDUGpJU2pYbzJHNFZ3OXM1U1hNc1FNbzVL?=
 =?utf-8?B?QmJyZ01RRlRUdmpkb08xSnQ0OU40ckcwL2J0M0pOZCt3eHVBVndobHRoKytz?=
 =?utf-8?B?TkQ1MmlITzJEYk1qVDBlb3NMS3lsemNSVmsxVVdMaXJ3QytUM3VtbU8xOE5q?=
 =?utf-8?B?OUxlOHFQOFJ0OWZUWlZydTR0VVNUU29aZDlNZmI4QzF6YW9lcGh0dkpZNW16?=
 =?utf-8?Q?FyoltQiR+Bo3+nUY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88fed94-8b93-4a9a-ef30-08df3d8fefdf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:00:52.6298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmSdD9zMSkPZ/YkKDi6/Ii7ShFF9DxGQywUeJFTFv6y+V5k9nu7sU/Lfc7aaq/cImNcV4AkIGkQG2W9fav7z4R02OiJbvdZumO9w550/OIU=
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series corrects SPR access, cache and MMU configuration, and
instruction availability in the Freescale Book E CPU models. It also
fixes host PVR matching and adds system TCG tests for e500mc, e5500
and e6500.

The patches are grouped as follows:

- patch #1-#3 and #5, bug fixes to PIR write access, the MAS5 SPR number
  and cache block/line sizes (qemu-stable cc'ed)
- patch #4 and #6, complete e500mc/e5500 L1 cache configuration and
  remove redundant e6500 cache geometry bits
- patch #7-#11, register the missing cache, MMU-assist and several
  control SPRs
- patch #12-#14, split the PowerISA 2.05 instructions into integer and
  floating-point groups, due to differences seen on e500 series cores
- patch #15-#17: Add TCG tests for illegal-instruction exceptions, byte
  comparison and parity results, and FPSCR field-mask handling
- patch #18-#21, complete the e500 family MMU configuration, correct
  PID register counts and express MMUCFG/TLBnCFG with named fields
- patch #22-#23, fix EPCR write width and host PVR revision matching
  for Book E KVM

Changes in v3:
- Cover the new system test directories in MAINTAINERS
- Add the missing SPDX license identifier to the README
- target/ppc: Build e6500 MMUCFG values from field encodings
- target/ppc: Complete MMU configuration for e500 family cores
- target/ppc: Limit e500mc and e5500 to one PID register
- target/ppc: Express e6500 TLB configuration with named fields
- target/ppc: Keep embedded processor control within 32 bits
- target/ppc: Match e500mc/e5500/e6500 host PVR revisions

Changes in v2:
- Group ISA 2.05 features into integer and floating-point flags
- Use the first free bit for the floating-point group
- Align flag definitions and comment endings
- Enable the shared ISA 2.05 integer flag on e5500 and e6500
- Align the FPSCR W/L behavior flag comment ending
- Rebase the PPC64 test entry onto the Meson variable cleanup

Bin Meng (23):
  target/ppc: Correct PIR write access on e500 cores
  target/ppc: Correct the MAS5 SPR number
  target/ppc: Correct the e500mc and e5500 cache block size fields
  target/ppc: Complete e500mc and e5500 L1 cache configuration
  target/ppc: Correct cache line size for e6500
  target/ppc: Drop redundant e6500 L1 cache geometry bits
  target/ppc: Register L1CSR2 on e500mc/e5500/e6500 cores
  target/ppc: Register L2CFG0 and L2CSR1 on e500mc and e5500
  target/ppc: Register MAS5 and MAS8 on e500mc/e5500/e6500
  target/ppc: Register PWRMGTCR0 on e6500
  target/ppc: Register IVOR42 on e6500
  target/ppc: Split the ISA 2.05 instruction feature group
  target/ppc: Enable byte comparison and parity on e5500 and e6500
  target/ppc: Ignore FPSCR W/L fields on e500mc, e5500 and e6500
  tests/tcg/ppc: Add Book E illegal instruction tests
  tests/tcg/ppc: Test byte comparison and parity on e5500/e6500
  tests/tcg/ppc: Test FPSCR W/L handling on e500mc/e5500/e6500
  target/ppc: Build e6500 MMUCFG values from field encodings
  target/ppc: Complete MMU configuration for e500 family cores
  target/ppc: Limit e500mc and e5500 to one PID register
  target/ppc: Express e6500 TLB configuration with named fields
  target/ppc: Keep embedded processor control within 32 bits
  target/ppc: Match e500mc/e5500/e6500 host PVR revisions

 MAINTAINERS                                |  2 +-
 target/ppc/cpu.h                           | 45 ++++++----
 target/ppc/cpu_init.h                      |  3 +-
 target/ppc/cpu_init.c                      | 99 +++++++++++++++++-----
 target/ppc/translate.c                     | 10 ++-
 target/ppc/translate/fixedpoint-impl.c.inc |  6 +-
 target/ppc/translate/fp-impl.c.inc         | 14 ++-
 target/ppc/translate/fp-ops.c.inc          |  9 +-
 meson_options.txt                          |  4 +
 scripts/meson-buildoptions.sh              |  2 +
 tests/tcg/meson.build                      |  1 +
 tests/tcg/ppc/meson.build                  |  5 ++
 tests/tcg/ppc/system/README                | 24 ++++++
 tests/tcg/ppc/system/boot.S                | 92 ++++++++++++++++++++
 tests/tcg/ppc/system/byte-parity.S         | 33 ++++++++
 tests/tcg/ppc/system/fpscr.S               | 75 ++++++++++++++++
 tests/tcg/ppc/system/isa.out               |  1 +
 tests/tcg/ppc/system/kernel.ld             | 18 ++++
 tests/tcg/ppc/system/macros.inc            | 56 ++++++++++++
 tests/tcg/ppc/system/meson.build           | 39 +++++++++
 tests/tcg/ppc/system/unsupported.S         | 31 +++++++
 tests/tcg/ppc64/meson.build                |  2 +
 tests/tcg/ppc64/system/meson.build         | 33 ++++++++
 23 files changed, 554 insertions(+), 50 deletions(-)
 create mode 100644 tests/tcg/ppc/meson.build
 create mode 100644 tests/tcg/ppc/system/README
 create mode 100644 tests/tcg/ppc/system/boot.S
 create mode 100644 tests/tcg/ppc/system/byte-parity.S
 create mode 100644 tests/tcg/ppc/system/fpscr.S
 create mode 100644 tests/tcg/ppc/system/isa.out
 create mode 100644 tests/tcg/ppc/system/kernel.ld
 create mode 100644 tests/tcg/ppc/system/macros.inc
 create mode 100644 tests/tcg/ppc/system/meson.build
 create mode 100644 tests/tcg/ppc/system/unsupported.S
 create mode 100644 tests/tcg/ppc64/system/meson.build

---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
branch: ppc-fsl-booke

-- 
2.53.0


