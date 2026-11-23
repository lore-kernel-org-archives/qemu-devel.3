Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC61606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q3aUJWlk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcGI-0005Y2-RA; Mon, 23 Nov 2026 17:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcGA-0005Vs-FE; Mon, 23 Nov 2026 17:11:39 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcG6-0007DL-Gq; Mon, 23 Nov 2026 17:11:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBc51IRRK59t/iQJUxHtnwL4ZTyh2uLsVEBPtlNyj8RiBMpCw3AHVCaOxBKlF+FmXVG3vZkJhU8d3udZI3AqAITiRSnXlcKcM6SZ924StBNCEVxkk6NlxAnvqaFE2RD4qmuZ2EoIwWsFRYeBiRkdxPk7pnOuPdAE+mW+iGqqBbIAa+amqA5N0NbqYQA5doMkfBSFe3oRDHn9JUOVT6DoiTktIUe5fl7SWr1wiIGD0YybYTHpiGbRtYlBjKVUrw4PbbJRJAy8pA1jwLj1XFDs2WZEJHa4u8hK+pAJATcwej7wib2Gka6x8RwZ91INnHljH3QP1+qS4oVsG3rFUf6XmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGs2rN4vnBNE1GaeiPyj9QkOIPCqWNQQpuvIJW7a5B8=;
 b=x3ULSFIHH2m8sLsvyc/pePSreULfQ0oR/BNOQOiC4VsYLe+PRjU1BFMLnf308cQSeCIhb9eKSdUdi8S/vKnBupvv9bdqr3ufKkKIHcatFB6iZOdLtN4j679c6bQE0MbPXAIqy5gHMDRpQ4wOQkInpkvl8LUi2hwOGV96ANWxxAtQqL7925xPG3aDR0VOOqYo8rALMkmQsb32pm3eFaoxMqqyEM/zTZqecXxO7djfRlAeFDpDEUmnBrnXR+ZYQ1iTmQ1UbBYzMohStCtURvz1QWz14zF+oDCV8cs+nlC4Z2byk4LP5g8OfOQEkeGEY/6g1QxAZuMTWEp5D1LCKwa/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGs2rN4vnBNE1GaeiPyj9QkOIPCqWNQQpuvIJW7a5B8=;
 b=q3aUJWlke0N7RjMHKUEPjeMwMomvfroG42Zc4uHT0CeH7TUt8/XYaDgSaCG0FqCj5sZ2SiQft8/HzWSvQvTjA9uJ61s3E9ZsEXx+R3pDXijQcr2lN06mpIFbrJ+vZpg0QZyRZP/vZLNjKKMTtWZW2l3gHVAiOYHgkmONvQwUXbERngRH7Y3ZyYDV9AIZ2lNNJd2nYl4WbbABW9L38rGSXaYVZ5habc9d58J49wEDTGNJI1irIkm7aJbzILx8dqQsdlOJWCxCJzlXdB1mqh6oKQg6uKN7SlJB/IQy06n4dmwLSBQhR5NlmkdneIy55RWQ1DJsZHwopDgS5sHOPgJXiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH7PR12MB6979.namprd12.prod.outlook.com
 (2603:10b6:510:1b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 22:11:24 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:11:24 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, clg@redhat.com, tdave@nvidia.com
Subject: [PATCH v3 2/5] hw/pci: add validation for fixed BAR configuration
Date: Mon, 23 Nov 2026 16:11:02 -0600
Message-Id: <20261123221105.37029-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123221105.37029-1-tdave@nvidia.com>
References: <20261123221105.37029-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:130::21) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b44d86-f1ff-4336-c67e-08df49aeb651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261022113327099003|261022105027099003|261026140227099003|261022075727099003|11063799006|260925022911599003|5023799004|260925021311599003|56012099006|261021121427099003|261102123227099003|10067099003|261009223027099003|261026121527099003|260925021911599003|261028144727099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: W/1RyRFlENGYO821YR/ioogA0i+N6hGwIhmiC/su1JXb215wMx9VPcMqi3POXHaMFcagJgMrqM/pELalTFLmPjXWCBxBU/mAgVyAg1Uoddv0DDesORXpJb8l4ERY+VH2xtKDbeUahbFa0WDTqlQHl5f9CLHhc5oUjtCVvjsT2wwV3Vfwfl+XyTOWpoES6r7TAN/NKvSL4MBY86KZgiwhLb9TiaqzyJf+x3Ahcuc6PE8NS6dV5v699gvniOcla8Lxyida0uledWOKrMFcYcrYbiJN/+lSVjFQCDzTqcbLEZcPT1YEdRDMiFahnYgTogGs4LtkO6XR85mOsgmqSPOdKKijYMRCzhv5Q0nqhWKTjkFiC8xDneD1MgtANWORMAN5BZAC0Ks/kJEM7P2iA/mhQmHpxX/zweVnOp+MDcbhV8pMjNqjrZYFZ83KG6WsBclVrlaBIbLtgrDxnOibL9XY8vtCV39O3AFd5xhux+eTXNkMV1NgBMjEVzB4Tza8nvmwF8+Un0aO/QO3+iFD5i6a0T8e8OLK2qqYtS5ZQKT7IjI0IiD4WM+V+LlNWYqSw8RkK3PcBq4cs5sfA4DDQyYN3li6xb7YqUuswNOAXAXpu8W1qRKK3LV7xZhtO3qN6SoMhbVb9Anm+Az+pMkfwVVLzi0qXoBrSs0LJspfReMWPbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261022113327099003)(261022105027099003)(261026140227099003)(261022075727099003)(11063799006)(260925022911599003)(5023799004)(260925021311599003)(56012099006)(261021121427099003)(261102123227099003)(10067099003)(261009223027099003)(261026121527099003)(260925021911599003)(261028144727099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1Q0RVBuWHdWd1JadmFEK3EyZjlFL0VBRVBDZmtTKzJTdjNyRUcvQmhNVGNn?=
 =?utf-8?B?bm8xZFFBeVZZOSsyZ2c1UTZXRWV5RlhUVzZWN0pxZXhFcXlHZ0xtY1BRM1VM?=
 =?utf-8?B?a1ZoVzA3Rms3b0FpcFNkZVpmWVd1My9meUFrREFLcURyOGFQVGJzY21xak5r?=
 =?utf-8?B?TEhvMjVmN0tlaS8yOTNhcHlDSjVHRXlKYjlKZmYwZ1grUVhncHdwV2w0TU5o?=
 =?utf-8?B?cEpkbUc1eHgySUlGRUl1RU0ySWRvZXoxMjJ6d1VzQ3Y0MEppc09KRHNDOUx4?=
 =?utf-8?B?Zm5ybHB2LzJtUDdMZDNTcURLcHFWL1pZYUFqSUlnbXR2bmxUb1JQdmtMQmgr?=
 =?utf-8?B?UjVjOGovTk1MTW1uZ3ZFeWg3bTE0SGY4aHdoY0pSUFkxUGpjcjMzcUoyNEE1?=
 =?utf-8?B?djI5RjE0TE1hQzNjMUxEZWxscS84MkJBeEFKL0ZqbXFnV1hoS3E4QmptMits?=
 =?utf-8?B?akZRbjJFL1d0cWtlZE5QWXprK1JxUU8wc0MyUGorS0Y5YW1oREdORHUxWjN6?=
 =?utf-8?B?Z0h6WkFaRHZYWGcveHRPM212NjF1MjQ0YXprSmcxeXQzYk5Pa3RncnQ0T2Jj?=
 =?utf-8?B?QWRMSERqREFmZjRTaFdDTERhRXBVSnUyVHRiSEhxMGhhbjhaSStZZVFJSjVY?=
 =?utf-8?B?cVJUVXZvV0tDRVBaS0YxdHVETktPRmpjVEF0Wm44NDg1WnVOSHN4Z21CSnY1?=
 =?utf-8?B?M3A2cENUQUlDNU0rTThES3o4djVJa0pIdnBwWkk0aUVyWG41azJSN1VjMzI2?=
 =?utf-8?B?MittRFd1Y0J1elpHMm5HU044S1pqeTNuRVEyRWNlS3c0aEl5YjU1VzM3d0VT?=
 =?utf-8?B?SFM4MUx4dXl4YWlNS05ESnNINmlPMUdCZTJ1K3NPSEFMK2s0NFFSV1lZSlhP?=
 =?utf-8?B?S3RERnFFQjMrMWtVVStqWExpR29EbHYxS08yRlBYRDRKd3NWVWlqSE03djdC?=
 =?utf-8?B?MjhRb1NmelBrQ0tQV1NkUmpmck5VY0N1bTRId3hGVU0rRjFicmpmejRBSEYy?=
 =?utf-8?B?K2Mra2pJTjY0em92MUw2eitQaThmYTkvNjBiRG9ZenF4NWxGc2xUSC9BMFBn?=
 =?utf-8?B?OHU2bVdNZ2IrMFowYTE5UzZpKzZ6TW1EL014dzVEZ3NZblA1dnI2NFc3SWp4?=
 =?utf-8?B?YURIZEtXV0x3ZFpRTDEzVWN2Y01ORVRUWUQxREFGMzdJRVRlOEVjTG4wSE81?=
 =?utf-8?B?ZDB4RWhhOXN2ekpMUHA0YUtucHAwcDd0bUhEUTY0ZWpJdUJzTDBCMXBFUGFl?=
 =?utf-8?B?V3VMS1p1SU5WMmp0TTV2SW12c0o2YzZJYitsWHV6OTZEODduOS83NnZkTnRW?=
 =?utf-8?B?NG1FRVovMnJRS2dyWWVlMStwNG1UcExRdVprdFhPa1EyVTNzbGt2cEZmbEt3?=
 =?utf-8?B?am5oMWdIRlNDNHlYcUhxSnA3aFRXNnBQY3FFWmYrNVVrZWxkWlVKSkpaTXBX?=
 =?utf-8?B?WUt2N20yNUtlTktKUWVlbklFZ1l4WFBFZVhYVFJIbDJCbmFUQmFBckRHZTRk?=
 =?utf-8?B?bjFIQWVkM0tjUUxwanlTbXlIYkVBVkhPQmtKV0w0bklKVWM3YXBneFVHTEti?=
 =?utf-8?B?b0wraEwvZjRkcVNNMm10WTB2RGNrVk5GY3cxLzBjd2lrUVhCdEVPcktkdXp4?=
 =?utf-8?B?REJ2eUdxcFFyT2N5T2VHWjV3SXRqMHNCQXR4M3FIUWNVWVFIRlRvWXJEaXFO?=
 =?utf-8?B?S2FiT2lPS2RFV1ZIK05Gc0ZHbTBmaVY4VmgvazNHcmVnOGZZSXhQY1pobDJZ?=
 =?utf-8?B?dDl0M0lpc2lmUXlFRFJWQzIxS3dYV2wzc1dNdHhiTThlaUdMdkJYZ1JUZWlF?=
 =?utf-8?B?TmoxdVFQb3FSYy9aTUgyR0o5bnVjVU5vaWttVVkxek85TTJISzliMEZlUkdi?=
 =?utf-8?B?d3NGdE9MbTFFN2VEeFNlYTdZZUh0TjdyZVkzUVNCTU9vczVtaXRqOEViRUts?=
 =?utf-8?B?TmFobUpRTnJGWm5jLzFQSTBsbXFQa2s3RkRmUldOSW1jSUVxYUpPdWkrWkNP?=
 =?utf-8?B?NEJEa2pnbFdISWd6UnU2U25oUFd1djlJNmFuZUY2Z3lqN3hwbTgzVUVFek1v?=
 =?utf-8?B?dnA3dVk2Ky91Vjd6REdsVzdySDhkTTJ2QTREbUlxc1dVWUNvdE8reCtGNzE3?=
 =?utf-8?B?TXNUUXBFV2lNYnRVUGJZa3ZYdDJxakxjaXFkdVZ0SXRvK0tZUXRUVEg5MGl6?=
 =?utf-8?B?OWZPeXF1bjNRRjhVS0pjaXdXVFZlWm5kVUpKZG9YRnVLcHFJTWZ0azRlVmgy?=
 =?utf-8?B?R05oMnd1SlRUZ1V5NDRQUXVHdWlYOWNkRUlWZTAzNktsY3dlZkxHV1BOQklo?=
 =?utf-8?Q?oYsz66LWwAupg0VFq3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b44d86-f1ff-4336-c67e-08df49aeb651
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:11:24.2989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nSOdPFAJdU8onjUloyHM4aWHBgFk2TZAS48jsUh/89upggHcvuwIxX8L2sVdme1eSWRFYI5p8dv+5kzSF1GiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=tdave@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Validate the fixed BAR configuration specified through the
fixed-bar-N properties on PCI endpoint devices.

Configuring any fixed-bar-N property on an endpoint device requires
every memory BAR on that device to have a fixed address. Validate
that each assigned address:

- is aligned to its BAR size;
- is within the appropriate PCIe MMIO aperture; and
- does not overlap any other fixed BAR.

A 32-bit BAR must lie in the 32-bit aperture. A prefetchable 64-bit BAR
must lie in the 64-bit aperture so that all prefetchable BARs can be
accommodated in a single 64-bit prefetchable bridge window. A
non-prefetchable 64-bit BAR may lie in either aperture when attached
directly to the host bridge, but must lie below 4GiB when placed behind
a PCI bridge.

Under a PCIe topology with a root port, fixed BAR placement is
all-or-nothing within that root port's subtree. If any one endpoint
device below the root port has a fixed BAR, every other endpoint
device below that same root port with a memory BAR must have all of
its memory BARs fixed too.

Endpoint devices with no root port in their ancestry, such as those
attached directly to the host bridge, are not required to match
their sibling devices. One such device may use fixed-bar-N for all
of its memory BARs while another sibling device on the same host
bridge uses none at all. Per-device completeness still applies
regardless of ancestry. Once any fixed-bar-N property is set on a
device, every memory BAR on that device must be fixed.

Report a validation failure through the Error ** argument and leave
it to the caller to decide how to handle it.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/meson.build              |   1 +
 hw/pci/pci-fixed-bar-validate.c | 376 ++++++++++++++++++++++++++++++++
 hw/pci/pci-fixed-bar-validate.h |  22 ++
 3 files changed, 399 insertions(+)
 create mode 100644 hw/pci/pci-fixed-bar-validate.c
 create mode 100644 hw/pci/pci-fixed-bar-validate.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 984c7327e5..150085c997 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -19,6 +19,7 @@ endif
 pci_ss.add(files('pcie.c', 'pcie_aer.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
+system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-validate.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 stub_ss.add(files('pci-stub.c'))
diff --git a/hw/pci/pci-fixed-bar-validate.c b/hw/pci/pci-fixed-bar-validate.c
new file mode 100644
index 0000000000..774f363572
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-validate.c
@@ -0,0 +1,376 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * BAR address validation for fixed-BAR placement.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
+#include "qapi/error.h"
+#include "qemu/range.h"
+#include "qemu/units.h"
+#include "pci-internal.h"
+#include "pci-fixed-bar-validate.h"
+
+/*
+ * Claimed BAR ranges — detect inter-device and inter-hierarchy overlaps
+ * across all fixed BARs system-wide.
+ */
+
+typedef struct {
+    uint64_t    start;
+    uint64_t    end;
+    const char *owner;  /* device name, for error messages */
+    int         bar;
+} FixedClaim;
+
+static void fixed_claims_init(FixedBarsInfo *info)
+{
+    info->claims = g_array_new(false, true, sizeof(FixedClaim));
+}
+
+static void fixed_claims_free(FixedBarsInfo *info)
+{
+    g_array_free(info->claims, true);
+    info->claims = NULL;
+}
+
+static bool fixed_claims_overlap(FixedBarsInfo *info,
+                                 uint64_t start, uint64_t end,
+                                 const char **owner_out, int *bar_out,
+                                 uint64_t *start_out, uint64_t *end_out)
+{
+    FixedClaim *c;
+    guint i;
+
+    for (i = 0; i < info->claims->len; i++) {
+        c = &g_array_index(info->claims, FixedClaim, i);
+        if (ranges_overlap(start, end - start + 1,
+                           c->start, c->end - c->start + 1)) {
+            *owner_out = c->owner;
+            *bar_out   = c->bar;
+            *start_out = c->start;
+            *end_out   = c->end;
+            return true;
+        }
+    }
+    return false;
+}
+
+static void fixed_claims_add(FixedBarsInfo *info,
+                             uint64_t start, uint64_t end,
+                             const char *owner, int bar)
+{
+    FixedClaim cl;
+
+    cl.start = start;
+    cl.end   = end;
+    cl.owner = owner;
+    cl.bar   = bar;
+    g_array_append_val(info->claims, cl);
+}
+
+/*
+ * Check that the BAR [start..end] fits in the window [base..limit].
+ * Both ranges are inclusive.
+ */
+static bool bar_in_window(uint64_t start, uint64_t end,
+                          uint64_t base, uint64_t limit)
+{
+    return start >= base && end <= limit;
+}
+
+static bool validate_bars(PCIDevice *pdev, FixedBarsInfo *info,
+                          bool is_fixed_subtree, Error **errp)
+{
+    const char  *devname = DEVICE(pdev)->id ? DEVICE(pdev)->id : pdev->name;
+    const char  *overlap_owner;
+    bool         has_fixed_bars = false;
+    bool         is_64bit;
+    uint64_t     addr, end, overlap_start, overlap_end;
+    PCIIORegion *r;
+    int          overlap_bar;
+    int          i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+            has_fixed_bars = true;
+            break;
+        }
+    }
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        if (has_fixed_bars) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] is a PCI bridge, "
+                       "fixed-bar-N is only supported on endpoint devices",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+            return false;
+        }
+        return true;
+    }
+
+    if (is_fixed_subtree && !has_fixed_bars) {
+        error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] under fixed-bar root "
+                   "port has memory BARs but no fixed-bar-N= specified",
+                   devname, pci_dev_bus_num(pdev),
+                   PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+        return false;
+    }
+
+    if (!has_fixed_bars) {
+        return true;
+    }
+
+    /* Completeness: every memory BAR must have an address. */
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+        if (pdev->fixed_bar_addr[i] == PCI_BAR_UNMAPPED) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "missing a fixed-bar-N= value",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
+            return false;
+        }
+    }
+
+    /* Per-BAR checks: alignment, MMIO window, overlap. */
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+
+        is_64bit = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
+        addr     = (uint64_t)pdev->fixed_bar_addr[i];
+
+        if (r->size - 1 > UINT64_MAX - addr) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "addr=0x%"PRIx64" + size=0x%"PRIx64" overflows",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                       i, addr, r->size);
+            return false;
+        }
+        end = addr + r->size - 1;
+
+        if (is_64bit && !(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH) &&
+            !pci_bus_is_root(pci_get_bus(pdev)) && end >= 4 * GiB) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d is a "
+                       "non-prefetchable 64-bit BAR behind a PCI bridge "
+                       "and cannot be placed above 4GB",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
+            return false;
+        }
+
+        if (addr & (r->size - 1)) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "addr=0x%"PRIx64" not aligned to size=0x%"PRIx64,
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                       i, addr, r->size);
+            return false;
+        }
+
+        /*
+         * A 32-bit BAR must fit in the 32-bit window; a 64-bit BAR in either,
+         * except a prefetchable one, which must be above 4GiB.
+         */
+        if (is_64bit && (r->type & PCI_BASE_ADDRESS_MEM_PREFETCH)) {
+            if (!bar_in_window(addr, end,
+                               info->mmio64_base, info->mmio64_limit)) {
+                error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                           "[0x%"PRIx64"..0x%"PRIx64"] outside the 64-bit "
+                           "window [0x%"PRIx64"..0x%"PRIx64"]",
+                           devname, pci_dev_bus_num(pdev),
+                           PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                           i, addr, end,
+                           info->mmio64_base, info->mmio64_limit);
+                return false;
+            }
+        } else if (is_64bit) {
+            if (!bar_in_window(addr, end,
+                               info->mmio32_base, info->mmio32_limit) &&
+                !bar_in_window(addr, end,
+                               info->mmio64_base, info->mmio64_limit)) {
+                error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                           "[0x%"PRIx64"..0x%"PRIx64"] outside both the "
+                           "32-bit window [0x%"PRIx64"..0x%"PRIx64"] and "
+                           "the 64-bit window [0x%"PRIx64"..0x%"PRIx64"]",
+                           devname, pci_dev_bus_num(pdev),
+                           PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                           i, addr, end,
+                           info->mmio32_base, info->mmio32_limit,
+                           info->mmio64_base, info->mmio64_limit);
+                return false;
+            }
+        } else if (!bar_in_window(addr, end,
+                                  info->mmio32_base, info->mmio32_limit)) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "[0x%"PRIx64"..0x%"PRIx64"] outside the 32-bit "
+                       "window [0x%"PRIx64"..0x%"PRIx64"]",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                       i, addr, end,
+                       info->mmio32_base, info->mmio32_limit);
+            return false;
+        }
+
+        if (fixed_claims_overlap(info, addr, end, &overlap_owner,
+                                 &overlap_bar, &overlap_start, &overlap_end)) {
+            error_setg(errp, "fixed-bar: %s [%02x:%02x.%x] BAR%d "
+                       "[0x%"PRIx64"..0x%"PRIx64"] overlaps %s BAR%d "
+                       "[0x%"PRIx64"..0x%"PRIx64"]",
+                       devname, pci_dev_bus_num(pdev),
+                       PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+                       i, addr, end, overlap_owner, overlap_bar,
+                       overlap_start, overlap_end);
+            return false;
+        }
+
+        fixed_claims_add(info, addr, end, devname, i);
+    }
+
+    info->any_fixed = true;
+    return true;
+}
+
+typedef struct {
+    FixedBarsInfo *info;
+    bool           is_fixed_subtree;
+    Error         **errp;
+} ScanState;
+
+static void scan_bus(PCIBus *bus, ScanState *state);
+
+static void mark_if_fixed(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    bool *found = opaque;
+    PCIBus *sec;
+    int i;
+
+    if (*found) {
+        return;
+    }
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+            *found = true;
+            return;
+        }
+    }
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+        if (sec) {
+            pci_for_each_device_under_bus(sec, mark_if_fixed, found);
+        }
+    }
+}
+
+/*
+ * True if any device in rp_bus's subtree (the bus behind a root port)
+ * has a fixed BAR.
+ */
+static bool root_port_subtree_has_fixed_bar(PCIBus *rp_bus)
+{
+    bool found = false;
+
+    pci_for_each_device_under_bus(rp_bus, mark_if_fixed, &found);
+    return found;
+}
+
+static void scan_bus_device(PCIBus *bus, PCIDevice *pdev, void *opaque)
+{
+    ScanState   *state = opaque;
+    bool         has_mem_bar = false;
+    PCIIORegion *r;
+    PCIBus      *sec;
+    int          i;
+
+    if (*state->errp) {
+        return;
+    }
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        r = &pdev->io_regions[i];
+        if (r->size && !(r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            has_mem_bar = true;
+            break;
+        }
+    }
+
+    if (has_mem_bar &&
+        !validate_bars(pdev, state->info, state->is_fixed_subtree,
+                       state->errp)) {
+        return;
+    }
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        return;
+    }
+    sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+    if (!sec) {
+        return;
+    }
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCIE_ROOT_PORT)) {
+        ScanState child = {
+            .info = state->info,
+            .is_fixed_subtree = root_port_subtree_has_fixed_bar(sec),
+            .errp = state->errp,
+        };
+        scan_bus(sec, &child);
+    } else {
+        scan_bus(sec, state);
+    }
+}
+
+static void scan_bus(PCIBus *bus, ScanState *state)
+{
+    pci_for_each_device_under_bus(bus, scan_bus_device, state);
+}
+
+static void scan_all_host_bridges(FixedBarsInfo *info, Error **errp)
+{
+    PCIHostState *hb;
+    ScanState state = {
+        .info = info,
+        .is_fixed_subtree = false,
+        .errp = errp,
+    };
+
+    fixed_claims_init(info);
+    QLIST_FOREACH(hb, &pci_host_bridges, next) {
+        if (hb->bus) {
+            scan_bus(hb->bus, &state);
+        }
+    }
+    fixed_claims_free(info);
+}
+
+/*
+ * fixed_bars_validate - scan all PCI devices, validate fixed BAR addresses.
+ *
+ * @info: carries MMIO window bounds for validation.
+ * @errp: set on a validation error.
+ *
+ * Returns true if every BAR validated, false with @errp set otherwise.
+ * Whether any fixed BAR device was found is left in info->any_fixed.
+ */
+bool fixed_bars_validate(FixedBarsInfo *info, Error **errp)
+{
+    ERRP_GUARD();
+
+    info->any_fixed = false;
+    scan_all_host_bridges(info, errp);
+    return !*errp;
+}
diff --git a/hw/pci/pci-fixed-bar-validate.h b/hw/pci/pci-fixed-bar-validate.h
new file mode 100644
index 0000000000..f4996f27d9
--- /dev/null
+++ b/hw/pci/pci-fixed-bar-validate.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_PCI_FIXED_BAR_VALIDATE_H
+#define HW_PCI_FIXED_BAR_VALIDATE_H
+
+typedef struct {
+    bool      any_fixed;
+    uint64_t  mmio32_base;
+    uint64_t  mmio32_limit;
+    uint64_t  mmio64_base;
+    uint64_t  mmio64_limit;
+    GArray    *claims;
+} FixedBarsInfo;
+
+bool fixed_bars_validate(FixedBarsInfo *info, Error **errp);
+
+#endif /* HW_PCI_FIXED_BAR_VALIDATE_H */
-- 
2.34.1


