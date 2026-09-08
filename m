Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9902C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIs-00025C-Py; Tue, 08 Sep 2026 06:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIr-0001ye-QX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:43:49 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIm-0006jE-HD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:43:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7giaBNCz0JXHwRjhhL6b9GTDYi6EdVxXxYGWWilcYIY7NVLILJtAJOY7K0UiMsYvsvEjMi3jwaHH2dMu9ujXrJA/WZZaM4gC5Ioxh0WEQES4nux4IouQgKgXDjfmwmZAgQi7pCErhRK3MdcNEEWDFtb5YZo3uhG6uCEwdIxYaPbRzd6qnCdjTU0vYQqn7ilL5/mIMOgWH2K1rhnzCDTmPwgXHSEH+x4I9b6gCVeS2ogY6mpzwpxiPLTdmuPiztUuRco2egn9k+qXxG3Qe997ITUXYnF0O6MIddO1jlfBcA48r51P3CzEGZx9FAs+UrvA9a56m7+8BNsgb9K04x1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsiJNkMY68Pi9PwpfmWU2nMUxTz6x1oLxr9SiN9Ujcw=;
 b=IIEJXn8pnllJb/cRWLZEbw36bs1irW0VMkUtkqP0MecSR2/FeU/rskO3AwnoFawzXlylRFFGDa8VcWyrJTuWAeh6DTPqrGFzPodLQ47ewQIEls97dioAia5wOSSNKYIur2O7RvWqGs9gR2EZqa2WChW2R/HRyNJeyF/v4DU4lPEJhwZ+Gd9gV31D5dwiN3mV1UhKwBv/ee76Cx2cYYD7b6FTIYufuwV0YGotXGa19B+KwNBI49HN17i6+GK3UrdM4bRKuPsjsmqn/CBsuE6yvEOtVQiQtsU/eO/EJqRWxO4FIlYbewFnaHXNDtIgUzNemNX5z4lCJQ4C408+5rAvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsiJNkMY68Pi9PwpfmWU2nMUxTz6x1oLxr9SiN9Ujcw=;
 b=KyRU6Vj01mm8KL7jKLY7AaQRRdDzJ3m/UWqbhjMT/Vz2m3fSkV7IpOngiRp8tzhgE6wzohJ0cfHafwfsdSvIjrfPKDZTcH9zD4C+SNYr8YgRszUZEMfolF9Spuf3W5xvbp3qsCc1ivUus3D2HMPI0URfm+kKiNTsSbFPazc7AN1V4uo0/ckG5DT7A8XaVoqnytAgHCLxRU617oKsKIeGwO8z73QkGVpRl8zk31OnmD88SUHwpQHEu8Cuk63x6r/wxSsk4avN1V/XLa8Vdg+xd7DhJcTGVB1zVf4XfT15i64m+dr5vifQ4wIEDsiqFWUytBTV3kTyCxaG73hNmRXLCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:43:34 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:43:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 32/32] MAINTAINERS: Add Phytium E2000Q machines
Date: Tue,  8 Sep 2026 18:41:41 +0800
Message-ID: <20260908104159.1621764-33-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f18c008-21e2-42be-4580-08df0d95f800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VCvtrJjqi2OJEWhggtaiz6kVqDx5xKjKhRNLZIpi+ZuA/hoIiUaImLa+4oLwE33W668iRu7yXDrQtHywYG57rYrqyrpT2Co9zmmh4zfUzKHSCvkgtlLNDE3PBK7C14e1oRB8J0POWlitF2fx9zKAaftiX81a3nX2eQoDTbYw+59T4tGvKQHrJthVXAnH/WZZcM/kzfBQpILaivPH9gjnxNEVp5W0iiNhpXDT7PvrW4W87TpClWzkIh4wZslApNyPWLz6BJiSlP0T6/WAtONCzaOVwwysLf8hvhNH+v613w3H+cujSFyVYQ+HyZzWSJcPlXLHKrhhwZhti3lTPZPyM70Jme6RAUri747ygnMcgF16la8XdHQ0B7ywuRBmLD/lZ9O8zij00lSww1vgKxQj6no64zHv1W1S0FCpnSyC74yBT8TFNHbJLhDqsiBK/4mZVRj7u5OfYTVeY061Z/E5bFDsWs224kQtDadVs70Z2lCPPKRVKuwTDN2RUynsGPSNCx2XvLLVUkLhrca5qXrqB9LNuuaYdTLS9bi7mLAlT7Cu4D9jFElwGmjSGEOn91EG/DTLf5Tx2j8XvCmUxH7vrylB2B8YNH12EfpGrOYOz562GlLD3Ozx4OCijWVuv/LCs3RkSHgwPJs6o4legEHtW3YfeamxmK2v5hk2JKrZRMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdNeHdUQUJKNTNPbnhaK0Y5ZzdWYks1K1Y2b0lNaHM4LzlxMUFuT0xucWtQ?=
 =?utf-8?B?VWw3dDUzWEtpWWEyd0FoL3JaWGRydmliay81cU5TME9LdFRSNEE3L0VUd1BT?=
 =?utf-8?B?Z2ZieWRkdldVY1U1VDVNQ0QxVml5MktBQ1d1SWdwQndwN1ptN0ttcUZjenlI?=
 =?utf-8?B?aTdzT3hTUEtYY3pKbGR5Z3hWM2MvTGhnTUVLQkxIdzRYdTVGb3lWZjV4NjJO?=
 =?utf-8?B?OUhSTjVOMFNDbFZnMWdobm5ZN1NjNWl5SVBpdk41cUh4TGtlNk5FN01vVm5y?=
 =?utf-8?B?Uk5KdGpRTmh4c3BlanFWVU01Sk5MeG9nTFNSTzJHQ2NXRkw3L2t0TndnZStN?=
 =?utf-8?B?R1VqV0FMbEsxV2UveXJmZklZdFlaeDJzdVZJb0oybkNBS00vRUdZUkpoaDhN?=
 =?utf-8?B?TTJYNkFTRnNTMENkckhjbkwzcXdyZFpXMHlaZ2Fhb0g5b3B1cDhlL1loc2oy?=
 =?utf-8?B?eEdmR1kxUzVCck5Nc21TOGNRZXd4UE8xckF1bHI5QUpUUE1odGNTc0FvNkFK?=
 =?utf-8?B?dEd4N3VONlJscENRM2FwNFRQWmFBSjdjaTVScnZsZkVqWU9ONUV1eEpraXNY?=
 =?utf-8?B?RC9XVENrNjZKWXV2SzhTUHJzMHpUSnJoeVlobWo4cHRwSGFRWSttTE5PMnB4?=
 =?utf-8?B?L3BCWEQ2MmZMRStCZzgwZFdnK1k1VGQ5R25tNm1xcktqSHgyUytFOXZhNFBR?=
 =?utf-8?B?d0ppM3cxcE5ZNHpMYXp0MlBkY1o3aGJKZUdKS0I2djRFSnBtUmx0a3BhakVG?=
 =?utf-8?B?ZTZzMjY0Wmh3NGJPbWdjSnEzdllpQzZKWmkzWm1YenUzMjZtOTBpa05HM1Z3?=
 =?utf-8?B?NWwvVm03UC80a2RxbHpaZVMvbHhjd0grVmEvcU0wcGhjV05OM3dGZ0lTbjFs?=
 =?utf-8?B?ZGF4dnpIcExiaWZ2aGhRcGNVOWRCdDN1bkFtWkdJQys5SnRUalZMc3R2OHNo?=
 =?utf-8?B?azJzQXZaOVBmK0R2Mm9GWmhTSUsyL2FWck8wcEVzQXFnQzBxc3drTE0zNFVm?=
 =?utf-8?B?T2M2cEtrR0Y1ZVpEbkFBTks3VFBqcWZnRTcxVXBobG1qTDNiU3UwMVdjODZm?=
 =?utf-8?B?clZ1MHZROTlVQlpPMmhEZkRHVXVIS3ZNcXcrbDlOK1ZhQmJRVzZNM3FrbU5r?=
 =?utf-8?B?aDg3emM0djlsWHVTWFcvOGg2UGFNdE5BODZsY0xuNUxvR3VHaWhFOWFNSTYw?=
 =?utf-8?B?Z1Eya0J5c2tHNnpWMDFxMjJDYlRFMi9jempWeWxDb1ZNcmFDRU5tVVhERmNT?=
 =?utf-8?B?TkpUQlJLaG5zeU8weWFLeDQ4UG1GaGg0K0tWU2tBMEpuSzJ0eXhzdHVYV3Za?=
 =?utf-8?B?VUFsM3VCbTZ1QkFocTdDeXZKVitrM2lzZGVzb1pZTlR1T1p1YStQQ3pEejZH?=
 =?utf-8?B?VStWekdjNWFYVGhjWFlvS1FQVVVDYWR3VXNxY3RvbEJXakx6Yk43UEtnSCtM?=
 =?utf-8?B?ZlZFQU5lOEhkVVRZV0JndWlSelV4NXB4cys5OERDUnVwM0VQY1JpLy8ya0ZE?=
 =?utf-8?B?RHJrTmpWUnlXK3lmdkI5TkVqV2ZkNS8wZHM2dHhoZnpnZXVpTE9LY0ZrRzdW?=
 =?utf-8?B?SjdvZ1FDZWN6ZXR6cktBZm96NlpndjUwdy8rZUhXUmxtMkpXckoram9PeFQz?=
 =?utf-8?B?TFpEakF1ZnZoRGdORWliL240ZlczWTI5QnE0d0FNU05IZXhFT0VaVnAydTBV?=
 =?utf-8?B?YVJjZDJVSHhxcEdWNWVhdTltQXZZNi9ES1Z0ZFZ0WmhGbnZjc2RoczAyZXdC?=
 =?utf-8?B?KzduV1o4VDgwUEtHWEN6Tm9UOVN4Tk13SmduTWNHUVVoeERWWFJ0aFZMdDgr?=
 =?utf-8?B?UEl6aVJ2TS9TVVRRTFNqVTkyNTBMdEJWd0JYOXpHdzJGNTVQQlFKRkJ4c2RC?=
 =?utf-8?B?M1J1TmVjTmsyTkg2U3hHSjZLeEZabjJjWkFMYnVmMXZMQ2tJa0ErbWloU2ZB?=
 =?utf-8?B?UnpiUFhkV1RKaklwMGNzNmZsS0toMjNIQUM5ZmFzOWwyRlhCN2JVR01xZGRi?=
 =?utf-8?B?UVNHMkZJUE8rY25CNjduVWJ4K1RvQ1BnRUNaN29qMXpxdm1iNzB2RjJudFVD?=
 =?utf-8?B?cHc2WGFFNFI2OEJRTHpRUFE2bFp0bThzYVgxc25jc0RPV1ZIcXhUekIvMDk5?=
 =?utf-8?B?aEEwVmtxTEduOWtCdkN1bmxRb29PQ1FhOWl0QThvUTZUV0tlUEQ3aUJWanVI?=
 =?utf-8?B?ZUZvUDVMYmZwcXNUc3ZqNDFMU3JVWk13UmpSUHdkUUNScUpldzhvc2JDOE9D?=
 =?utf-8?B?NnJuU3lqMUhTa2xxTjc2YWRmNXJMd3lad0pXNzhMM1BEN3Uwc0JjVm15Nzhh?=
 =?utf-8?B?QWdtQVVKa0JJV252cUMydGVPaG5UUnQ1eWJGKyttbnNpN2pDVHlLSUgybGVO?=
 =?utf-8?Q?pCxaCGDM+vTsbQMs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f18c008-21e2-42be-4580-08df0d95f800
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:43:07.2877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpR1gmTjT/RoKD9mqhsovO/VIntmcdxGT4ual4fPCRACHTiKNNuHiDvtIfvPhIiZDHQM1xYTV7kmqnPRVyJU0tgJLFEPw6OclI54jTet59U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---

 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d577cdbda5..6fb382eb06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1012,6 +1012,21 @@ F: roms/vbootrom
 F: docs/system/arm/nuvoton.rst
 F: tests/functional/arm/test_quanta_gsj.py
 
+Phytium E2000Q machines
+M: Bin Meng <bin.meng@processmission.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: docs/system/arm/phytium_e2000.rst
+F: hw/arm/phytium*
+F: include/hw/arm/phytium*
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
 R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
-- 
2.53.0


