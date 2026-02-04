Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1974EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni8N-0004X4-9I; Wed, 04 Feb 2026 14:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni8E-0004TT-C8; Wed, 04 Feb 2026 14:01:43 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni88-0007Tc-Vj; Wed, 04 Feb 2026 14:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcSAoXOdauQ8/qJNCr70LOg/rXoApiRVY+0Kqee3HVaF92nD/O8jd80DaV0xTcL7zjNbEuuwkLZGwvL7x65nhdEKrGflHgIB7W1zaRattwVBWjyqJ85aGLrW93EJK+RMf9pz8x6A5Z/9oarOjr21b5ompacw1RFoFThnA50fVy03g+imKL91Xqse96cq3RYDBuKK1bTTfhWERplRrlU+4pofDgzA40gpVnLTyftvkJrEUgbwQ1mD+e19KfrQbQtfKmRF3dgOvX8hV37gmMC8UJxQsscgS7gRAZaB02iRluHdDj7fIz2wuUwaGZxi9i/GcJIIfOeN+cjWOJZNbAJ6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCZutUdnXpAlo5H9tNNR5eRPMKnj38qI5g7YwxpMMmY=;
 b=yPsnXQUXqm3osq4yqmSl/F1JU+K85dGxvKjfHsRYeOJvHiWouZAVyIPhvP84/h4/E2gufhDDmJa3aE8Cy0ApYKlp70rDc/ALtAezmNInj1vQqdxz68sYiFlsPzs0Re1gOruzXHZLfCmBiuNvbKpNX+0RIN8D1138ZdchIebqFES1vZcgv2u/IcfNvr3bEd17aJsexaTNNgaJMo+PAqXYybZkSFcpZ6gTznJAz8+9xWNDjAhyvGjuuXaidNv/Lf6rEH6pws/ufsHG74sPw5ELRYnn5aCRKV+yp0kqdTrmItXm1sx+rEEzCf+JgiPprFKQWZY8NKnttrXhpaFhD94S/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCZutUdnXpAlo5H9tNNR5eRPMKnj38qI5g7YwxpMMmY=;
 b=eVWK80Olk6xMU7fYKLnnbmkOX2Yj16+tkeqzkV14JeqXHOLCl5YLObw3j1MMQSEzifW6GL2cxzsmctuDGFQ3P7AssBQHNvMR96/gLapdw6LtYGuNAtgOlrYvsuFPXnZdjHeMbTNfc2v3q+S4UcjmtlWGFtoDdmsQHADjUmaHnFAS80hTTar8UsbHqPL1yjTlKPBbNsBYSchsILL/8qIgi7ph2ccmTAPIgv35pqb0SQyRGsshfa9HiSRU/cAncciP6ck7o0K0/khaj+vhDoUyTedKraNTKh2p74Hri0Yfa760ElbUMQfMz77b3kfglrtaVuOIN+BPmHtmmkq6UGbEBA==
Received: from BN1PR14CA0029.namprd14.prod.outlook.com (2603:10b6:408:e3::34)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::995) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 19:01:28 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::f3) by BN1PR14CA0029.outlook.office365.com
 (2603:10b6:408:e3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 19:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:01:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:01:02 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:59 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 5/5] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Wed, 4 Feb 2026 19:00:08 +0000
Message-ID: <20260204190008.20070-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204190008.20070-1-skolothumtho@nvidia.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: a59365d9-4560-476f-ef22-08de641fcd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0dQbHhsVzArQTdzZ0dDNVVZaEdFV1M4RDNpYllSTTMvc2lWSmlYTlVvTUE0?=
 =?utf-8?B?TlovTEt6Y0NwMmRkWkJUeW5qVjBIM2xqLzdyemJIRStLVERabEl5TUtoSWFQ?=
 =?utf-8?B?Yjh2ZUdsVDBvS3piWWNQRWhNSmZ4eC9wNVViZWZtcjNBN1Z1YUZLRVBxYkRn?=
 =?utf-8?B?NUl0NmIzTkxEUFlRSjU1RDVPVUdPdjFleHRzdnBVc1NwZWJpWHhsS2Q4N2NL?=
 =?utf-8?B?U2FpY3R4Q1NmV2c2UjdHa1N3bFJyZ0FKbDREWUJ6YmNPeWlqRnJKaWJZeHJ6?=
 =?utf-8?B?Y2ppeitlMUlYSGtGcC9aMGUraUE0NHI2MmJNaVJJamNmdS92Y0xQUXZWT1Vl?=
 =?utf-8?B?VmVIU3RxUVZRYjZmTDBINEszdUlmNkUwNXJjSU5VbCtMbWR0Q2dmTFpIVGJa?=
 =?utf-8?B?YW03K0ltK3RndlNYNnFuT2JxL09KUDNWb1RsZk93Z3dvczZsdUhTVEkxK3ZD?=
 =?utf-8?B?K2hINVFJYUJ6bWRuRFM0TEMyWmZBQmdaZWZaeUNjell4TCtqWC9zNTRwclZr?=
 =?utf-8?B?cDAzalhIbXpwZG93NytOWjF2MVhDL1FoVC9CZ3gvYXQrWm5BQ09ORGpOeFFB?=
 =?utf-8?B?WVErWmRVcitMa1dRUklmbjcwK0NwdUZjOG5rZFNhK0JhUDFWbDROMDd2UmRm?=
 =?utf-8?B?WlVBdDljWXVEUmdaK3hvUlF0ZVpJQ2hHSXNrS0JTdnFHT2FEcGZOTkpSb294?=
 =?utf-8?B?OVoycU5nUlZTeGZCNDZRdG1ONFFOZE5naURMbTFOZzM0d3p4cFpPVXBPYUk3?=
 =?utf-8?B?cUZ4MzQ5a3IrR2RnUkJRTk10dERkaHpyT3hRMHJnamZ1d3ZCRjdDLzFCM2Q5?=
 =?utf-8?B?Yko2NkhSeHJLTVRBeWFCSEsvZWt2MVdFUGxLbDR0a1ZZVUtXcG41UlZ2eEQy?=
 =?utf-8?B?cU56bkVZZDJJUG43ZGVyQWVyV0VWaGVoRXhwdUZHbWFYSmczTGZkaG9UWmdT?=
 =?utf-8?B?SUhiUGZPeVdxK0lMTzhoRWpkaTFKVnp1OXVlalR2TnlCVWNDRjJMdC9DQ2pt?=
 =?utf-8?B?SDA4UXpVUXZSbzl0ZnZKUWNSLzN1VjZlWVZXWGRRcVRLbktGT2l0WWc3Um9M?=
 =?utf-8?B?d1ZpbjBJN293ZHc0a0dJZFVjSUtkcmdEZ1Bha3JEN21pTmJXejhIMG9QdXBp?=
 =?utf-8?B?UmdBa2NVOWNsWG5tZFRaMzgwaUZYMDdYVVpjQjdCUHM1N2JObWYrZ1pYS21j?=
 =?utf-8?B?NU9zMEs5VmVLWUErS3d2bEd2ZFRlZHBXSHJrakVhWm1Deml6VHNyRm9PVEU2?=
 =?utf-8?B?QmtQV3lOUjdXVjMyS0xEVjRNWmhZM2dLMWtzRStsdmV4R3Y3Sm14bnNmRWFZ?=
 =?utf-8?B?SU1vTXlDL3dFT2RDY2dlVDY3VzlxZ1hxU3JjTDd4LzdHMVBHaElvbUpEdTlw?=
 =?utf-8?B?MDJjQURsOWNaYWdJUzdYNFJqSFZJWXN4M09ici9ibW4yRnJ0a1dEUWdEYWZo?=
 =?utf-8?B?d29Yc1ZaMEZaLys3WjNESC9WYUtqbUJkRkZSZW5ac3RuL3JLUHg1c29aaWpi?=
 =?utf-8?B?VXMzdmZ1VzJaaUJIWGsrQlgraTlEb0hYUDh1bFRJeGtLNm81S1lpQzRVQlVr?=
 =?utf-8?B?ZHdFWXByWjBWRWRZcHFjb24wczBmRjVqbFU4MmVSMnEyMkRsRVdHQllBbDRL?=
 =?utf-8?B?Y05YeFFkN1ZDMVI0R1htLzB0dGVVUVYrYXBDRUE5MDdNWGt3bFR5N040WWtY?=
 =?utf-8?B?RklFZ0x4bG8ySUVhdGFnT2VnclZ2R0NOaDcwSXJqTXFickh6ZVlhSlI4b2Rx?=
 =?utf-8?B?SGdRajNZVE1hMWFCZzI2Y3NpMno3RzJrUUJGYnBXR3phTklWNzdUalNVTitw?=
 =?utf-8?B?ejRXY25LMVZMdmJ4TzU3TG9NYVZ1ajJ0ZTdMOXhCR1oxR1AvYTBjcDFuSmV3?=
 =?utf-8?B?T1VkeDhvbUtFZkpQdVo0bHNuOWdSejZFK3FTM0pTVnpOVFBHNWdEODY4eUlC?=
 =?utf-8?B?anVSN2t4RndZenFRYnI5REZVRWVaMVQvc0N0Q28zanVBS24xcUpSdFlEMEU5?=
 =?utf-8?B?bkZJWFJMWk9MeEJrU2MxbThINStSSFk5NW9xVGVnR0dOMWJiVk5odHhWSWJr?=
 =?utf-8?B?S0wyekNCLzY5NFZQV0JYbW1mS2hidzUrUmVJUjh4cmJDakZkRGlFeGxsMDI4?=
 =?utf-8?B?L3RNVDhaUjRHWUM2N0NQSE9rTVlCK1JXclVIcXlZYkdvUC9tSDJFbmdaZytu?=
 =?utf-8?B?R0FiVFZCZzRTaDUwaW5QK2JPY0dWVTRxNVVCeFgzVFZ2OUFQdkx0clptZis3?=
 =?utf-8?B?aXdDd1lJSldqcThQd0s1RlFIQzdRPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iN4m0AmhKVLI1ZJWZXmvy5AWZcgjHJYz9W3Z5NSHWJXLGB0C98YXgsLKFSoKFNxvl2AtgYyfN12FKc7xPUI4lRes8lo/OE0KC0skFV6G9jLaPEoSydB6o0FbYYkED+Vg5oNvh+Owk7ilVxJJMiTPeKE0TKJqFGViVGsR2N4MYqaa3e9nVRYaWQo5JoDy7amuULQQBd7e7dTpvPlifif+54W9vv6RdXFSL7p/DyPymCMrcKI0TVEPczZQglgqVXtcXIP9hc1Ch6LqbihYOHzQDe9uIoDTjPobA8TaH/RsQkR/85Kf7lNF7pphk4uZ9j3gI0R1c7LrnQg+hSK6yFGzJhanwVJe61hmAAApwwl215M2tdGTqzoUskBFFEs2T6LB3m5I0Qvina16SnwjQbz14bvz64wx3h+a66IdzkH3qhwKdCWP8euA6DA200n1lLfT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:01:27.9210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59365d9-4560-476f-ef22-08de641fcd1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Install an event handler on the vEVENTQ fd to read and propagate host
generated vIOMMU events to the guest.

The handler runs in QEMU’s main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  2 ++
 2 files changed, 64 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 2ca0d1deac..beffb8aa94 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,48 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_event_read(void *opaque)
+{
+    SMMUv3State *s = opaque;
+    SMMUv3AccelState *accel = s->s_accel;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_arm_smmuv3 vevent;
+    } buf;
+    uint32_t last_seq = accel->last_event_seq;
+    ssize_t bytes;
+
+    bytes = read(accel->veventq->veventq_fd, &buf, sizeof(buf));
+    if (bytes <= 0) {
+        if (errno == EAGAIN || errno == EINTR) {
+            return;
+        }
+        error_report_once("vEVENTQ: read failed (%m)");
+        return;
+    }
+
+    if (bytes == sizeof(buf.hdr) &&
+        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
+        error_report_once("vEVENTQ has lost events");
+        accel->event_start = false;
+        return;
+    }
+    if (bytes < sizeof(buf)) {
+        error_report_once("vEVENTQ: incomplete read (%zd/%zd bytes)",
+                          bytes, sizeof(buf));
+        return;
+    }
+
+    /* Check sequence in hdr for lost events if any */
+    if (accel->event_start && (buf.hdr.sequence - last_seq != 1)) {
+        error_report_once("vEVENTQ: detected lost %u event(s)",
+                          buf.hdr.sequence - last_seq - 1);
+    }
+    accel->last_event_seq = buf.hdr.sequence;
+    accel->event_start = true;
+    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
+}
+
 static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
 {
     IOMMUFDVeventq *veventq = accel->veventq;
@@ -397,6 +439,7 @@ static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
     close(veventq->veventq_fd);
     iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
     g_free(veventq);
@@ -424,6 +467,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     IOMMUFDVeventq *veventq;
     uint32_t veventq_id;
     uint32_t veventq_fd;
+    int flags;
 
     if (!accel->viommu) {
         return true;
@@ -445,12 +489,30 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    flags = fcntl(veventq_fd, F_GETFL);
+    if (flags < 0) {
+        error_setg(errp, "Failed to get flags for vEVENTQ fd");
+        goto free_veventq;
+    }
+    if (fcntl(veventq_fd, F_SETFL, O_NONBLOCK | flags) < 0) {
+        error_setg(errp, "Failed to set O_NONBLOCK on vEVENTQ fd");
+        goto free_veventq;
+    }
+
     veventq = g_new(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
     veventq->viommu = accel->viommu;
     accel->veventq = veventq;
+
+    /* Set up event handler for veventq fd */
+    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
     return true;
+
+free_veventq:
+    close(veventq_fd);
+    iommufd_backend_free_id(accel->viommu->iommufd, veventq_id);
+    return false;
 }
 
 static bool
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dba6c71de5..c9c10e55c3 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -23,6 +23,8 @@
 typedef struct SMMUv3AccelState {
     IOMMUFDViommu *viommu;
     IOMMUFDVeventq *veventq;
+    uint32_t last_event_seq;
+    bool event_start;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
-- 
2.43.0


