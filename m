Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF4606A89A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ngBBhMfA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTcJf-0000lc-I4; Wed, 18 Nov 2026 04:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXvk-0000Xg-Ph
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:10:00 -0500
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXvg-0005AY-5Z
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:09:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sq0e1d18ujKG6MACx4dQzwPsF3CIzv6iMGi2i2ZcurAEI/hZZFUM3pqeaTYIvyMhde9A8G8rW7cgzl3ajlPys+ZaxtE+uf4iHvGlP8RwjWXQF7xFHG7neGyxQNLQUkSik/jlUlw0uH98woHeshGiYEj8NEfL6OLk3ZjWQI+IbuhosHFyHmClNNHQdHlYffEoCv9k5/mzeMfLZ+5eWgI9ey4iGD44yxrk86i+QULKjbJKkmoMEVQ8j9LfGu64nas+dP3JvBCd7mTSkzJWW7aMexw/xES8PpHrLEQWkGe1gZ2mw1jzgp9S7zhfbMUs4N4q3tLfCBHPRzKM6fLot/9EFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcBubTyfgIEtevutxvwydqZUWKDPXHiZWMHvo3nL+S0=;
 b=cxVwfyg2ktmFM5spOxdsGwJoET620XuNYNhz49NknFUFGKS46hCsbCjqZ8PI48ChToYi7DsgGEX29vkMT/GkLFKFKX1j66sO9eGCsdCFsW1Cs/fzvouuJnP2UYqj8wnMcF7PoEL7zl57wul2YGMHRokpfo64uZ3qziVsABYSEDbxE9YSgjuRWePIjW4nNQf5z5J6P2pF6g7pMe1QuWda3BJZwBcXctEBfIXgML8BQijDorLHOVf6u5O+YV0vE0glPFQaiV0/6bl87WGTyTAviPTFuLmg2DlepTTHy5GkVdLEApRNeIoKrPiI38l7jYE8nNLYKbPxreBM6RTVNCryLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcBubTyfgIEtevutxvwydqZUWKDPXHiZWMHvo3nL+S0=;
 b=ngBBhMfAxjNbwOFcMuP2yCDvg5KfOrPzkhTpmK6s/OscOmW4K7mOYIOTIr8q/s046Wdno1O2+DwGiVTtA2cMm2yoRudV5Euw3hA/X1sH6EChnKBIjtSoHnAaxa5gFb+gJcK5cilYStiqDAi0F1M5PXz5hr+hCcWmbA0rCAxm7HM=
Received: from PH7P220CA0075.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::11)
 by DS6PR12MB649431.namprd12.prod.outlook.com (2603:10b6:8:416::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:09:48 +0000
Received: from PH7PEPF00000007.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::2d) by PH7P220CA0075.outlook.office365.com
 (2603:10b6:510:32c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 05:09:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000007.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:09:47 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:09:44 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>, <sarunkod@amd.com>
CC: <richard.henderson@linaro.org>, <mst@redhat.com>, <farosas@suse.de>,
 <lvivier@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 4/4] tests/acpi: update q35 IVRS expected blobs
Date: Wed, 18 Nov 2026 05:08:31 +0000
Message-ID: <4cba98a64e2c60d7ff09e6a2ecfae31818ac064a.1794484966.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794484966.git.Ankit.Soni@amd.com>
References: <cover.1794484966.git.Ankit.Soni@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000007:EE_|DS6PR12MB649431:EE_
X-MS-Office365-Filtering-Correlation-Id: 339d915e-8a80-49d4-e1a4-08df45322ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|261021123027099003|11063799006|56012099006|261026140227099003|261022115727099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7x2SrYNS7rQJZyJCyXdhIrkJOerEk5ERMLln8mWoI+DrZHCIbepjCNdy+DCrkckT2Kl923ePQWusPXfQl6/vTw4mHbzfd/nGKYLMtebbkwDdwwRSjOqjF6jjT9MRPXp/fCKW/1u/hZIqo4k0y9KoD8JlSWEDTTruUgD7AF5sM/ti4l2p2hF3FY5vBpn0wARecOLPCt16K0LCYsVMT+MvxvKPwqs408+PFjMkGmHbDbPWFxm5X+lm4FEalHtfQFR0uQF55MfjU1Hmx0X53sPMA3yp/2h5yKX3y0hdHpnp+3dj33MeQtEffPqh9VlAeQY337A15xX2/IJaxRe40g44Zu/g3klSoayQ3Ylx+7Oh3xHYzkPIbXuq7ilRIfDddiDoa3c8lWpIyufWvhk6V/Qv4zGGbv3gnVhmUPj+OzGGdz9LSv/Ndvd82i2GhmCpOdu6URl4+VtdLOA5yLcJl+DME3VyKH/PTkAaOxT6QZ2WeQIoAiF8R5BwKvoVI48Nfageu7JbhbMAQJC4t+F7IUM1eemeOpeEZOm5a2wUNfnK9qWbKQ2/yesnhb2Dp3yoqy+bK7IqcgkL1GnohfB0MOUl9z+BDU5bKVRox7NIxZ2nh3PpYFHjFfqXJU/bkzgc7zdh0To29K/m0pYn9Wv6Q5PAHwspn9BBddgjSy2pxdlHPIgpSI0mrJw5ZhG82wVMzpB+vgPTgwFP6bDO7SRSzcN6+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(261021123027099003)(11063799006)(56012099006)(261026140227099003)(261022115727099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0jHg/NH24iT3HlvH9NzZqLUOZYv+vB9yu2h08K0ECJUzlIMQuv52UpaKJC+mVdD3jxuiSiSbbsZVTPdAZoHMoM2pzpIcRkjzxyTHHHTx3q+9oT1+ZIUtcommpIrwVz6Ci12+gMKJRwsHxitxZJ1EPgoqeLvHVPMt5mEAs28yDAaeaLeUYzqT3gbbP6dNKwP9zeJ5PnS8v/JztJ2nj3SSEbdu+XBb0+lzGUWhiKJD7uAfrf3wLEElh1T9AM0sGWErYr/wTsBThie4TAqqT1EB1gjqFh6y43q9fYXrHv2sN8OTZZHDlhqUtVYEhP6GsUQP4REfljs4jPpGxAGfXU26SRajCyxKq2b5HRBHn3Y3DzMHEbVD27WldhDhn7BkAWWnjyRmZxilCXTELXXlGknL9oGq9ot+au9kjnryrYmz7zoG7ldTASofKGH4vHb5Pg5/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:09:47.6615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339d915e-8a80-49d4-e1a4-08df45322ab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB649431
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=Ankit.Soni@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Nov 2026 04:50:53 -0500
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FCH stub at 00:14.0 adds a PCI function, so the q35 IVRS
test tables change.

DSDT gains Device (SA0) at _ADR 0x00140000. IVHD type 0x10 and
0x11 each gain a Select entry for Device ID 00A0 (00:14.0).
Table length 0xB0 -> 0xB8. Later IVRS offsets move by four
bytes; type 0x48 IOAPIC SID is still 00A0.

Differences between disassembled ASL files for DSDT.ivrs:

 --- tests/data/acpi/x86/q35/DSDT.ivrs
 +++ DSDT.ivrs
 @@ -9,9 +9,9 @@
   *
   * Original Table Header:
   *     Signature        "DSDT"
 - *     Length           0x000020FD (8445)
 + *     Length           0x0000210E (8462)
   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
 - *     Checksum         0x45
 + *     Checksum         0xD1
   *     OEM ID           "BOCHS "
   *     OEM Table ID     "BXPC    "
   *     OEM Revision     0x00000001 (1)
 @@ -3210,6 +3210,11 @@
                  Name (_ADR, 0x00020000)  // _ADR: Address
              }

 +            Device (SA0)
 +            {
 +                Name (_ADR, 0x00140000)  // _ADR: Address
 +            }
 +
              Device (SF8)
              {
                  Name (_ADR, 0x001F0000)  // _ADR: Address

Differences between disassembled ASL files for IVRS:

 --- tests/data/acpi/x86/q35/IVRS.ivrs
 +++ IVRS.ivrs
 @@ -11,9 +11,9 @@
   */

  [000h 0000 004h]                   Signature : "IVRS"    [I/O Virtualization Reporting Structure]
 -[004h 0004 004h]                Table Length : 000000B0
 +[004h 0004 004h]                Table Length : 000000B8
  [008h 0008 001h]                    Revision : 01
 -[009h 0009 001h]                    Checksum : CB
 +[009h 0009 001h]                    Checksum : 77
  [00Ah 0010 006h]                      Oem ID : "BOCHS "
  [010h 0016 008h]                Oem Table ID : "BXPC    "
  [018h 0024 004h]                Oem Revision : 00000001
 @@ -33,7 +33,7 @@
                                      Coherent : 0
                              Prefetch Support : 1
                                   PPR Support : 0
 -[032h 0050 002h]                      Length : 0038
 +[032h 0050 002h]                      Length : 003C
  [034h 0052 002h]                    DeviceId : 0010
  [036h 0054 002h]           Capability Offset : 0040
  [038h 0056 008h]                Base Address : 00000000FED80000
 @@ -75,7 +75,7 @@
                                    LINT1 Pass : 0

  [054h 0084 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[055h 0085 002h]                   Device ID : 00F8
 +[055h 0085 002h]                   Device ID : 00A0
  [057h 0087 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -86,7 +86,7 @@
                                    LINT1 Pass : 0

  [058h 0088 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[059h 0089 002h]                   Device ID : 00FA
 +[059h 0089 002h]                   Device ID : 00F8
  [05Bh 0091 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -97,7 +97,7 @@
                                    LINT1 Pass : 0

  [05Ch 0092 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[05Dh 0093 002h]                   Device ID : 00FB
 +[05Dh 0093 002h]                   Device ID : 00FA
  [05Fh 0095 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -107,8 +107,8 @@
                                    LINT0 Pass : 0
                                    LINT1 Pass : 0

 -[060h 0096 001h]               Subtable Type : 48 [Device Entry: Special Device]
 -[061h 0097 002h]                   Device ID : 0000
 +[060h 0096 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 +[061h 0097 002h]                   Device ID : 00FB
  [063h 0099 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -117,12 +117,23 @@
                                   System MGMT : 0
                                    LINT0 Pass : 0
                                    LINT1 Pass : 0
 -[064h 0100 001h]                      Handle : 00
 -[065h 0101 002h]       Source Used Device ID : 00A0
 -[067h 0103 001h]                     Variety : 01

 -[068h 0104 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
 -[069h 0105 001h]       Flags (decoded below) : 11
 +[064h 0100 001h]               Subtable Type : 48 [Device Entry: Special Device]
 +[065h 0101 002h]                   Device ID : 0000
 +[067h 0103 001h] Data Setting (decoded below) : 00
 +                                    INITPass : 0
 +                                    EIntPass : 0
 +                                     NMIPass : 0
 +                                    Reserved : 0
 +                                 System MGMT : 0
 +                                  LINT0 Pass : 0
 +                                  LINT1 Pass : 0
 +[068h 0104 001h]                      Handle : 00
 +[069h 0105 002h]       Source Used Device ID : 00A0
 +[06Bh 0107 001h]                     Variety : 01
 +
 +[06Ch 0108 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
 +[06Dh 0109 001h]       Flags (decoded below) : 11
                                       HtTunEn : 1
                                        PassPW : 0
                                     ResPassPW : 0
 @@ -131,29 +142,18 @@
                                      Coherent : 0
                              Prefetch Support : 0
                                   PPR Support : 0
 -[06Ah 0106 002h]                      Length : 0048
 -[06Ch 0108 002h]                    DeviceId : 0010
 -[06Eh 0110 002h]           Capability Offset : 0040
 -[070h 0112 008h]                Base Address : 00000000FED80000
 -[078h 0120 002h]           PCI Segment Group : 0000
 -[07Ah 0122 002h]         Virtualization Info : 0000
 -[07Ch 0124 004h]                  Attributes : 00000000
 -[080h 0128 008h]                   EFR Image : 00000000000028D1
 -[088h 0136 008h]                    Reserved : 0000000000000000
 -
 -[090h 0144 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[091h 0145 002h]                   Device ID : 0000
 -[093h 0147 001h] Data Setting (decoded below) : 00
 -                                    INITPass : 0
 -                                    EIntPass : 0
 -                                     NMIPass : 0
 -                                    Reserved : 0
 -                                 System MGMT : 0
 -                                  LINT0 Pass : 0
 -                                  LINT1 Pass : 0
 +[06Eh 0110 002h]                      Length : 004C
 +[070h 0112 002h]                    DeviceId : 0010
 +[072h 0114 002h]           Capability Offset : 0040
 +[074h 0116 008h]                Base Address : 00000000FED80000
 +[07Ch 0124 002h]           PCI Segment Group : 0000
 +[07Eh 0126 002h]         Virtualization Info : 0000
 +[080h 0128 004h]                  Attributes : 00000000
 +[084h 0132 008h]                   EFR Image : 00000000000028D1
 +[08Ch 0140 008h]                    Reserved : 0000000000000000

  [094h 0148 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[095h 0149 002h]                   Device ID : 0008
 +[095h 0149 002h]                   Device ID : 0000
  [097h 0151 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -164,7 +164,7 @@
                                    LINT1 Pass : 0

  [098h 0152 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[099h 0153 002h]                   Device ID : 0010
 +[099h 0153 002h]                   Device ID : 0008
  [09Bh 0155 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -175,7 +175,7 @@
                                    LINT1 Pass : 0

  [09Ch 0156 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[09Dh 0157 002h]                   Device ID : 00F8
 +[09Dh 0157 002h]                   Device ID : 0010
  [09Fh 0159 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -186,7 +186,7 @@
                                    LINT1 Pass : 0

  [0A0h 0160 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[0A1h 0161 002h]                   Device ID : 00FA
 +[0A1h 0161 002h]                   Device ID : 00A0
  [0A3h 0163 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -197,7 +197,7 @@
                                    LINT1 Pass : 0

  [0A4h 0164 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 -[0A5h 0165 002h]                   Device ID : 00FB
 +[0A5h 0165 002h]                   Device ID : 00F8
  [0A7h 0167 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -207,8 +207,8 @@
                                    LINT0 Pass : 0
                                    LINT1 Pass : 0

 -[0A8h 0168 001h]               Subtable Type : 48 [Device Entry: Special Device]
 -[0A9h 0169 002h]                   Device ID : 0000
 +[0A8h 0168 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 +[0A9h 0169 002h]                   Device ID : 00FA
  [0ABh 0171 001h] Data Setting (decoded below) : 00
                                      INITPass : 0
                                      EIntPass : 0
 @@ -217,6 +217,28 @@
                                   System MGMT : 0
                                    LINT0 Pass : 0
                                    LINT1 Pass : 0
 -[0ACh 0172 001h]                      Handle : 00
 -[0ADh 0173 002h]       Source Used Device ID : 00A0
 -[0AFh 0175 001h]                     Variety : 01
 +
 +[0ACh 0172 001h]               Subtable Type : 02 [Device Entry: Select One Device]
 +[0ADh 0173 002h]                   Device ID : 00FB
 +[0AFh 0175 001h] Data Setting (decoded below) : 00
 +                                    INITPass : 0
 +                                    EIntPass : 0
 +                                     NMIPass : 0
 +                                    Reserved : 0
 +                                 System MGMT : 0
 +                                  LINT0 Pass : 0
 +                                  LINT1 Pass : 0
 +
 +[0B0h 0176 001h]               Subtable Type : 48 [Device Entry: Special Device]
 +[0B1h 0177 002h]                   Device ID : 0000
 +[0B3h 0179 001h] Data Setting (decoded below) : 00
 +                                    INITPass : 0
 +                                    EIntPass : 0
 +                                     NMIPass : 0
 +                                    Reserved : 0
 +                                 System MGMT : 0
 +                                  LINT0 Pass : 0
 +                                  LINT1 Pass : 0
 +[0B4h 0180 001h]                      Handle : 00
 +[0B5h 0181 002h]       Source Used Device ID : 00A0
 +[0B7h 0183 001h]                     Variety : 01

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 tests/data/acpi/x86/q35/DSDT.ivrs           | Bin 8445 -> 8462 bytes
 tests/data/acpi/x86/q35/IVRS.ivrs           | Bin 176 -> 184 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 50691d93ed45b697290ca32d0f56765fc3a77379..07cd4eaaf76e5673e7791f9e6b5a6d0458667d14 100644
GIT binary patch
delta 54
zcmezC*yqIM66_Mfr^vv-cyS|_ygZkOY)pKxQ@ntK>||s406zX;M}v5dct@8Y9tH-H
J%?<Lki~xvc4R8Pe

delta 39
ucmeBk`s>K$66_N4SAl_n(RCx2ygZk?OiX;RQ@nt`^kifCfX!3ns~7?63=2>I

diff --git a/tests/data/acpi/x86/q35/IVRS.ivrs b/tests/data/acpi/x86/q35/IVRS.ivrs
index b3b809c65f026fde0a49a2243a3216e7b8c87502..523b6832103193389825b8e3b3bacf8e4e7e1c38 100644
GIT binary patch
delta 77
zcmdnMxPy_)Gb|{02Ll5GWBEib4Mv-Z#!6BP7#Ns-0P!y%{>{MP0hDD}z`!Ud=rb|f
INF0YO0KA<LlmGw#

delta 69
zcmdnNxPg(&Gb|{00|NsC<LQZ98jKbbjg`cHFfcIv0^;8c3?4ukh6N0af`T3s^NobD
G$N&IUc@K~P

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9803ce61b971..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/IVRS.ivrs",
-- 
2.43.0


