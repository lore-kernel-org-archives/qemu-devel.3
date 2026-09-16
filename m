Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371BAC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6vFG-0004b6-Hg; Wed, 16 Sep 2026 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x6vF5-0004a3-OV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:24:28 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x6vF4-0005fg-7B
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQuj1C47K6t/HbpW+o9Lt9MMfVNJSS3MN3uCbYpkQujXwr+bkt1fNPU2LldJjA/f+hdLBwf+rfOXZ9wWBqIsMSZ7xiQkqI7Hw7PbzzDu8rjoqoU2yqnJe1Fx4cUfArN0N4biAVprrburpAVEus4VYzF1ASy8qPOFooqwDGTyuiErYSGqqUGkjUSXR6OBphoF82NfMvQIkuRFJmkrPZysef8WSzy4Yr+llYN/Abada42pb0ww6WQKEbyYcibfV6gzNupGyuJbt3TErLkfz+ycGeASH3VLNvIqEwwTHWCsTH4cTWDsEVbdWFZyk4DfNZnn8CJyDIaQMYI+l4xS0lUlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhCAWjE9Jwbkv/2TRFOBW498jquBVoqoJ35h2DL2jrk=;
 b=ON6MvoUdb5fekj6T664TFoYgXOFkMihPAks2N8Om0lp0noW+eNMd1yyetICFH1GMPxHNTv0fUQEUEp4I1H6tIe8JNco25/ETOacWiZRA+1bElSp9AX8tLK5pq/Ou4CtJDSGsnBFBSMaUOA7QycksYpN+H3zVy+q1ZV3mX+c2inQmKunxrITKW6ew/wkEehT15YNthUKOx9DZgydE4lKFe0IiWoPs7fn6uN0dCqRuicwKMuHYeMQAyloVPyvRqSB9PntE6RuMd3SI9f6Ruc5qtHaA7jXj4h5oqjglNoO2IP/VM2Za+Hkz2/yZo/MuIro1HNXJCAX8WniYLnEI5ln6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhCAWjE9Jwbkv/2TRFOBW498jquBVoqoJ35h2DL2jrk=;
 b=iGwI5zlhBTtVtrL03jk8p9Ioh66DUvusF4fEw+XhxYAyzsSCbf3BJQA3nC9gUNe26CUFwa/xaVyHH0/pwbE9hSXcBg8uLLeAGyPHWDbEeQV5NlrE3BoNaa8lXqTiMjB9XMRhZUu5KfmDoGVvjjwRm+KrjIDCDsPmMMit1qpsBpkjP8ErNAUgQ5vOIDyYtHndZKZh+mc6olqDUxd03SNT3iR6JEqOBsS/JADftQl9Yl5sJua94DkVLw5iDLEOv1+Z1Rc1Ugwn6u3WPrJXpHkyBGDOMizUvuS9qb0FT3AGDs173pt1H4Yb22BQIqY7DS4NNgz2XXZ90YnRtwyonByEkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by MW4PR12MB7213.namprd12.prod.outlook.com
 (2603:10b6:303:22a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 19:24:16 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 19:24:16 +0000
From: Tushar Dave <tdave@nvidia.com>
To: devel@edk2.groups.io
Cc: gaoliming@byosoft.com.cn, ardb+tianocore@kernel.org, sami.mujawar@arm.com,
 jiewen.yao@intel.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 1/3] MdeModulePkg/PciBusDxe: honor fixed BAR addresses from
 IncompatiblePci
Date: Wed, 16 Sep 2026 14:24:06 -0500
Message-Id: <20260916192408.928411-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916192408.928411-1-tdave@nvidia.com>
References: <20260916192408.928411-1-tdave@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::6) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2980e6eb-0e3b-45e6-e037-08df142818cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5/AjdSdXtqS1uJLh0i3GonSbnE3Tdf8LgEzQ3tiqDyE4252qmAfMZc4p+7795AIaqTD9fGym1FZyvsIZHzVGyo8MWTuy21nUjuouRaiAtPjB9A3fXStX4yTqj4wZsnbpO0Wh+r6U0oBuqt0kmCIQfm1JqGvuCnOBQuvzwT6OK1cg9V+v25Q1hTh4n9+xzSC04+n8p0N69wPVf5WoeD0rxitOnkgRfcdLw2MyVhAkOMsX/BPA4iI8M44b4MXSimDiaY20VfxBRhgqd/1KKAuM9po7bLorSMwtc+4l++KjsLdva6WpGDu/poOx72eLjbiI47vY51AeN7Lll14XuGqXSbk3tt5UkLfVb8rsFeX47ooylhcRAOZkk+aAPmyWQFFNVTH/gpulmURMfOgnHrTUnYyKoDhk3xuVqs2STo4WBc/P7SAVnf6MW1QM89dosTI2c8XdJDcX2gaU4I8Ib0CACP7vN+wV4cCRjEckRPS8iHj+LZ+BewxRWpvvfhbMdwYosJjrvZWs4AHRF+zeIk2SWLVZOmNwWp4qAFsOt3Yge00YzAYP/Up8Oen1vwTrNarKHvuFJRoBksxCe9dhcz3V2FBNxRi6cqd6Xy5FcWem6EvsjGyW1w1Lj5r7oFX5QgS6a7RNyJbqs2c39YBlwXidIzfhN+o5gMZXHzgmrugtWos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBaOVfg+pCIa1ayVjTQRedL47PP2HdbjyuF1vuShrp6vLBKEFUQQy0bwUhJF?=
 =?us-ascii?Q?LKWwxceC442aN13IWoOrLaLidVvS1l/EcOwkFgAgvrJEJYzlUyU2GinIMERP?=
 =?us-ascii?Q?kZS3WTN3+/S33N51j8xCBoXGYORGFoUifMB5d0B2WYJ/pyU3hRI2OzTKziQu?=
 =?us-ascii?Q?RPRWc6pv4pDz11xrTbLzlTszMhFxmbwx6WKJ3iNuJsVGhQ9Yfo73qoWzd5jA?=
 =?us-ascii?Q?Fezih3F69Dj3jKzaMXY3eScV8XnDoDv7rtLDD2p2xGWvjacHzxiDQouPcfWt?=
 =?us-ascii?Q?UtBCefJpMJapUYu3GUMHLjPdpnGYP3foH4LVJPFdlKXQDEhJsS9AjBfJJJ3p?=
 =?us-ascii?Q?dr7EpLtwMFHnpLhHsTn6f7MDIWy5JnntAUVA5kL1HyIAjnvAupuY42DYSz9B?=
 =?us-ascii?Q?QsdbOhyedSIsVf2t3oaGtQsLEkTozBrmqbJl54pg5LFFeXTYINs+AFSbUj3u?=
 =?us-ascii?Q?XKn0s7WpZL36x3BSDBf9aneTFh3vwo2hKlHFGxeaLU8tC0M3cM9v2UOgwyaw?=
 =?us-ascii?Q?nkv6TDS8bxbgpErFrW66oy51LVkUohhGX9De1UrjY8qvgXdXUYkbt+/eW7is?=
 =?us-ascii?Q?nH7iwiWTiefOAwfh3LHzyWaKqgDVtNeVzsUgAfLDByLnP7lCZKkjm7QXE2Zm?=
 =?us-ascii?Q?ZX7VNNuMCu+30h3hmfSnGsiGifkiUx3tzh7Y8bJWjE/TmH+yfn3ALWFgWYYy?=
 =?us-ascii?Q?ut3EthMPQtKp4qmmg5B9Iuucs3KgMAb30nkKnXJqM37jXcpEbcUe5BdG7NvD?=
 =?us-ascii?Q?Fii0zOQ/YHqV28f/m1DiIe6uq008qDAS5ta3WcbDWIiq/3IAnumDh68GX1JJ?=
 =?us-ascii?Q?GLR/G1ISEwGvKlea8cbDbfIdZx4rPk5nnNYjsdx+wVsNb8NgRRydFp38cROR?=
 =?us-ascii?Q?rLRXfjWWWmnR6aW8MIEchGzHFZbevbgRdghLvWaub5lQRWSES1PzaHKayh/c?=
 =?us-ascii?Q?wKu+rufWwOJA0Qb+kvJ/ElM2DE6b9sIjtVRL+SR6o5oMkE5mrsT6W+lD8lQB?=
 =?us-ascii?Q?aam2Hoq7gOkZfQL/R1Vs40ZEC3hOGi/7rN+uWqSFeiVbZVrAHURLNK9KthRy?=
 =?us-ascii?Q?vfXqRRdjLOVb6gB3XNk3U9KUOlObs0c15madbvQFGvJnniMENKFtGvOPHEMq?=
 =?us-ascii?Q?M6Gt7i6NYHaaTn1BJQRnbrlgBp/v8XpNHlEOLgMRotm601qcoUEyzimFbulm?=
 =?us-ascii?Q?tvhUtHvE33Um2iqUW1bkQi8r5ubVuZduvM83t18NBjZzM1t0hSKOhxVB/Xwg?=
 =?us-ascii?Q?xbs1KRHmQ/9KMlQPKjWfEpbpxFWcFJf/moYAzlM0gOWogFGilnsmObRNSJnk?=
 =?us-ascii?Q?woqXNtnF3GDX+hrRc6k8bFxo4kNWrTEVPvqlR9TeuRGrUMrZsHgxwx1YT3LM?=
 =?us-ascii?Q?kp1vAmrh7+/n46kmm+8pLIzvVhCpp9rRm8rRcSAjKIgzY5pJx30hf9/ghZRn?=
 =?us-ascii?Q?jZmF1l7gPCODduj9UiXi2nayCGiC1nfv7GqKyZPymadloJkX4DgK9/qI7Unb?=
 =?us-ascii?Q?90qM4x8juXbqDJ5G4n+K4IR+b8xmXGoDvDVBiSXyKEr/NqeOXaWbmx7lOAzq?=
 =?us-ascii?Q?SpjGaQOtJJOBh1VhXe6KJwFxF2nPuzBUIcebfFcidnwi0O98Zps8d8WhKloW?=
 =?us-ascii?Q?bg2g2BwhTn0u5aSOvbP2dMAlPgyrcJO50tmLU9LICXT+nadmNYwbgdp/aLn5?=
 =?us-ascii?Q?msHczUxOwpcHlKhtm2cGt6trXm3vE9UEPicKGM6IT6XktKYw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2980e6eb-0e3b-45e6-e037-08df142818cb
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:24:15.8362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwsVySTBCUzfM2/cqZn42kr8uwTaoXIGEs4fmTIyPPygT5AsxbvMwj02VEpidw9DLQZGzf18bZexeOi0Ycl8gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=tdave@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL returns ACPI address
descriptors describing PCI resource requirements. When both _MIF (BIT2)
and _MAF (BIT3) are set in the descriptor's GenFlag, the descriptor
represents a fixed address range.

Extend PCI_BAR with FixedBaseAddress and update the PCI bus driver to
preserve and use this information:

  * UpdatePciInfo() detects _MIF|_MAF, records AddrRangeMin as
    FixedBaseAddress, and marks the BAR as fixed.

  * ProgramBar() programs FixedBaseAddress into the BAR register instead
    of the resource allocator selected address for fixed BARs.

No functional change occurs unless a platform driver supplies fixed BAR
descriptors through EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h              |  2 ++
 .../Bus/Pci/PciBusDxe/PciEnumeratorSupport.c         | 12 ++++++++++++
 MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c  | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h b/MdeModulePkg/Bus/Pci=
/PciBusDxe/PciBus.h
index 01bce28b1b..dbec57bd54 100644
--- a/MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h
+++ b/MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h
@@ -96,6 +96,8 @@ struct _PCI_BAR {
   UINT64          Alignment;=0D
   PCI_BAR_TYPE    BarType;=0D
   BOOLEAN         BarTypeFixed;=0D
+  UINT64          FixedBaseAddress;=0D
+  BOOLEAN         HasFixedBaseAddress;=0D
   UINT16          Offset;=0D
 };=0D
 =0D
diff --git a/MdeModulePkg/Bus/Pci/PciBusDxe/PciEnumeratorSupport.c b/MdeMod=
ulePkg/Bus/Pci/PciBusDxe/PciEnumeratorSupport.c
index ae94462f60..b7c132cc10 100644
--- a/MdeModulePkg/Bus/Pci/PciBusDxe/PciEnumeratorSupport.c
+++ b/MdeModulePkg/Bus/Pci/PciBusDxe/PciEnumeratorSupport.c
@@ -1638,6 +1638,18 @@ UpdatePciInfo (
         if (Ptr->AddrLen !=3D 0) {=0D
           PciIoDevice->PciBar[BarIndex].Length =3D Ptr->AddrLen;=0D
         }=0D
+=0D
+        //=0D
+        // When both _MIF (BIT2) and _MAF (BIT3) are set in GenFlag the=0D
+        // descriptor carries a fixed base address in AddrRangeMin.=0D
+        //=0D
+        if ((Ptr->GenFlag & (BIT2 | BIT3)) =3D=3D (BIT2 | BIT3)) {=0D
+          PciIoDevice->PciBar[BarIndex].HasFixedBaseAddress =3D TRUE;=0D
+          PciIoDevice->PciBar[BarIndex].FixedBaseAddress    =3D Ptr->AddrR=
angeMin;=0D
+          DEBUG ((DEBUG_INFO,=0D
+                  "PciBus: UpdatePciInfo BAR[%u] fixed address=3D0x%016Lx\=
n",=0D
+                  (UINT32)BarIndex, Ptr->AddrRangeMin));=0D
+        }=0D
       }=0D
     }=0D
 =0D
diff --git a/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c b/MdeModul=
ePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
index 8f3cff3eaa..169011e647 100644
--- a/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
+++ b/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
@@ -1276,6 +1276,17 @@ ProgramBar (
 =0D
   Address =3D Base + Node->Offset;=0D
 =0D
+  //=0D
+  // If EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL supplied a fixed=0D
+  // base address (_MIF|_MAF in the ACPI descriptor), use it directly.=0D
+  //=0D
+  if (Node->PciDev->PciBar[Node->Bar].HasFixedBaseAddress) {=0D
+    Address =3D Node->PciDev->PciBar[Node->Bar].FixedBaseAddress;=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "PciBus: BAR[%d] fixed address 0x%016Lx (GCD 0x%016Lx)\n",=0D
+            Node->Bar, Address, Base + Node->Offset));=0D
+  }=0D
+=0D
   //=0D
   // Indicate pci bus driver has allocated=0D
   // resource for this device=0D
--=20
2.34.1


