Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAADFEDA08
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZJc-00041F-SB; Tue, 17 Mar 2026 14:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJa-00040j-SJ; Tue, 17 Mar 2026 14:38:51 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJN-0002se-Sd; Tue, 17 Mar 2026 14:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTNYWt71rMOLIkvsCHOA/ZdqYkAW8h48TKJ6AHDlWxQAQ2pDWHXkCFBgdgEY1d4OXXCGtEFvWtFfaBQkW8jl2T/NSXAlCNs9amwTkr/ycN6b5e9ZVxCrFOFWtwZIJu1JwNIqkI8j/NjMkHTZapO2C8rGzzv8eDRu+c2nh96qExcuEUD4ZV1Z7KJjzYo4pXumO3GBMDMTgZzNyjlcKruKUpzFCnGl2FXF4AVU8C8AI9vG+27VNzjuy5AqxC5z0YYOjGvx5w8+xIB4JsLO26++4VbjdexNBT8KLbOmNVOfGrIaTBp1+SXEcUZIDYl+pKRuP7Kd3vz+eY74SEJWUskfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQg5HFCEQgzfJypJep7H9aV4LMJahMa34nJjvvaz6Dk=;
 b=koGG9KAVihNO4byyKaEpPL4Yx8sYbH6guLrClii3qOAzYUuR3p86MQ/UNgLr5CA/ezi1wMtqhS86BV7lZzyqcozTUBM7UcsTlik8hbj7LcNmULiHenJ5pR1j1CNIQrbQw2a0dzLaAkJBztnRvPdlut935ReM9gdF26OfFix5M0uq7Ti9J8EqxiLbvsBV5DDLAJeMCY9cLgS0gIx7PH9R45pI50trbqkeASm2Oxy1/t8vsPGKt0CQWbVIrRrFrgB9CveUmw7bJfNucmRG9kX273ZAX1gOrdMIAVJi0RRwUmFkUS0guJ3HM3tECVjYVpaVBz+suj4dYQP72m3/3fd6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQg5HFCEQgzfJypJep7H9aV4LMJahMa34nJjvvaz6Dk=;
 b=b3xN6VMHqBPlUJ+XVqYquECEn7ssfjDH3hughi/wNDdtoRgEf15p6K1zsb+vMPXcx6Zu68bUIGJGOa4tPpYGgEEG6Kp5GpGw4tv3hPPKbzijQkSLR5l/Pliu/blsG6vKIOVcuB0X2yYhZWjIeAdM3g0dD0XwUzEW0wEuSHEMMnKQsVpKQHqLH+Yj9A252WFLHoo2AxuNONPaIvKpp1iqGUFusgK59uTKe28oSV351viCzCiAtTo7HhNTpZKDO5u4Rg1LkvlhYCQrfdMzgD3CAp5n2ostSojEM1uhq9gZhSyFN7+V2O/Rqb0t9qQDv45zPye8IYDsO5Q9YdQmm3lCRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 18:38:24 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:38:24 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 1/8] hw/arm/smmuv3-accel: Check ATS compatibility between
 host and guest
Date: Tue, 17 Mar 2026 11:37:48 -0700
Message-ID: <20260317183755.3721625-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317183755.3721625-1-nathanc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::34) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: be4a22c3-d9d6-464a-cc8f-08de84545f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: LQiCcTdjBFP6Vg/tV85oFLcQvnjmxReonvumBy6Gt3Z9Ojy8jq3QZTv85gi/sU6NJZa7lKmpD8a/wdcU6jw5QbnHsPKwGe21ghzXYtxRRkGxXzAnc3tHnO7XfUzJqKYNauzJnvlCZd24XuFhAEZpkXvaDxJQ2HdfjNU0KTzqMwtRGatNEMwAfD0Rqlr+d/1S5jSxFzSwkzYEpIuneklXrFXXRRZ13omAaMQIaDY/eCq2ZU3HQV1Loc1LHpA4lwbdcWrQqwdmbnMJ5+qEhY+D4YKhB4OWYDDF+GqQoFWGjvjnx37eNT+Q8m+ONK8m9Vn5Z/7UmwZt/dcdno7vUGUGEwJEEC9jM0IKmIb1HDgZ5yECOnoCWOCWxw6tn/BhHHVjzX2q795Jfp/rkixt9nPZ/NDVUoc0PFqjzBaXxH9nDmO89Ctcizm9P3tppvfWM9NlDf7zMLL0dCAkh+xDRCoWTFYMw634BjWg8sJHz4Vu+sxoAAlIWFJugMT/E7NrjHcaaS8lvy7DoaqrSnabpq1kmaOcRjS19PscV+C/Ok+lFc8JealTQl4kznfp828fc14hcy0lzTkIiLscg6o42euulEJTHNhDGtRotrDKLXsNvPsa0jtyntLeJ80AgnPo1xKaMV7JKYkItJbOuVCybmr9YsC4cLghrO0ygPS44NMRWcQZvxTTAHpypq8R1PxueiXzWJwfFB5VUqf7Nmr/3IGMiiUgL38IcRxxZ0scxaaSHlY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?93cAcvJeY6yL9JLHvESnG6vl6NfVPKqfc0ShqLApGMlg7pmF73Cg1057Dc9l?=
 =?us-ascii?Q?xC5/RXxClk1i214+kCsn/q25Q6/eJcrAEE5BkGOOWzwksdKJSvoZVFSop+3U?=
 =?us-ascii?Q?hZrOX7vgQVaYmmbA8hdZJ2lZdL5btNS6OGj013fhKhr70JJyTsyon2k2iSqU?=
 =?us-ascii?Q?KhY4MMtJQOf4mbPXdzMycf+i26mm+DJ0X84ejcdnOuS9HE/VPbbdG7nxMG8e?=
 =?us-ascii?Q?+tMWMPgjwqjtHElfG8AHlH8RwphTFnw9jHJetjbEXCMkwHPyHBciJbeK9qNu?=
 =?us-ascii?Q?dPglwsEErN25uuxk6nOOWW2HF6qwWoNmg2gm26LIUaP1G5fVPCC9o1mKHGnH?=
 =?us-ascii?Q?2VStF1TpctHKT6OzT5o+41EQ4PiotX/Q40vnSslq7O3kyCt44RMtCLgLMYG0?=
 =?us-ascii?Q?qScc7RX+kKFhtsrEvc+uXqvMj/q1eOvqDt+er/F7LE3HPmBvRgDmjWf5ZsUH?=
 =?us-ascii?Q?92EFCeeXhpqztNVlh04oZ+Hqi2jHi+wQr6GPdWVEH+vf1jaQq4gx67s+9gOC?=
 =?us-ascii?Q?7pIJ5M0wHR2/9hV9q5ffBoLW6p6m02d5v/I0I34rXKirA1cGb7zOm97gBjwr?=
 =?us-ascii?Q?4kftwaSFYDBSvT9JNgNsnTBIUy1I7MGg5eqDd1YJ9oO9nAKBrvZKORDT89Kt?=
 =?us-ascii?Q?Y48rX1e7IGLN4t3149IuEw+dyKnn/SLwp9mqUvQaElAD6E9Kb+llNdL1wCF2?=
 =?us-ascii?Q?eSrp/2ABunTqAg8T45EmXqaHM8v5a1FG+blGbHChX3ql7wPHA6uaxUWj40xR?=
 =?us-ascii?Q?Uxju/FsH9l8ZYe6bE9EKdeyo0BGhyoZm6x0yAsSaskxOxdRIkXiNixqNvOhd?=
 =?us-ascii?Q?ZcjSo9LNDu1EZjUcFTuaCKlJ1mflCaLt5xjEHfR6I/1urCO7dkT16vyAYDAN?=
 =?us-ascii?Q?ev2z1UJihYVZsFc1TBEAVpnWqm58y7BOrOcI5XlA4+ye9umLaLjEr3G1KYX2?=
 =?us-ascii?Q?kF4hmU/dIY+x+Bz603N101ZZ+lmyyaNjN+yWG0a+iYU+9FPQMMyxFQDkuiHQ?=
 =?us-ascii?Q?3K2z5UVcRihC+4CGNuaOhwIpJpuM6b0a6eHXKyivgMHGbU3z7f8PqqoXdSZX?=
 =?us-ascii?Q?okPKGq7Au2SgmXAvg/17HpZNJwFYg0G4kXnVrIz8HSNWK26hw1DW3CRUiXAS?=
 =?us-ascii?Q?aGpaj4QyOckliZADDtbrAM2ZjtXsqhVNYv3DQ3VCtGeefjc6gl/PRNgMvUfk?=
 =?us-ascii?Q?6ZuoTNNqmu1+g+87yUW9EtGGY/lvHwyQWsesHOcm1o4kYoSHUPExDeyLiZ6t?=
 =?us-ascii?Q?XNpBJyEwejosyevULbzoFGzlYttUNLJAO8elkpMlwCwFuQJhGOOFBZKOClot?=
 =?us-ascii?Q?Y47CzB6wwr4KCfGRdFrz+K6DN8sc/Wbj8ENJ8NGkInXoE9YQ/YjHgfEvbkZl?=
 =?us-ascii?Q?9+UNRx8C3Ep4rK9hHr3AIuULTnzc0ajbQBh5oj2fcov6GKPGaTAPNrOo79tt?=
 =?us-ascii?Q?6x6bJcHusFIHrrQ70V+9Eg5fIxbmsGvAJ0C05N4sSlZ6jteciMLWIuKTTokG?=
 =?us-ascii?Q?blHqm4qPODBN6vMXmlNYYwAm4F0nZmOP6fDXezillo/DYMVBdIq+wwhLucvQ?=
 =?us-ascii?Q?L8A6dVe66mjXM7JZT/TjPgf9RFrEiyLg62Nz+/xyp1iULT0NLA2FQvOGrfF3?=
 =?us-ascii?Q?wVy8WbIqrYuqQ9Tj5SqA/bbgs48Oe6aw1qqsXWfvGxBoicdP5ykD8fsGxKsn?=
 =?us-ascii?Q?vcAWYJG+BIX2H16k08c4er9XrjmdKWu1ZCy4Les+dQUMXYHENidwVMtMqrkP?=
 =?us-ascii?Q?E4u8j+RXqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4a22c3-d9d6-464a-cc8f-08de84545f6b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:38:24.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56mRe2Ijfeud/dKPJUufKDp7SRiw7og1GXz9IYUu+/Ej05Q9Rui8cQgHazxvkKbr6Gc2ChfSUXNCVpXkhZAuqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Compare the host SMMUv3 ATS support bit with the guest SMMUv3 ATS support
bit in IDR0 and fail the compatibility check if ATS support is opted as
enabled on the guest SMMUv3 when it is not supported on host SMMUv3.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 17306cd04b..2bb142c47f 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -101,6 +101,12 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                    smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
         return false;
     }
+    /* Check ATS value opted is compatible with Host SMMUv3 */
+    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
+                FIELD_EX32(s->idr[0], IDR0, ATS)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Address Translation Services");
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
-- 
2.43.0


