Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6F6CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVS4g-00029i-4z; Fri, 05 Jun 2026 06:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4d-00028q-5Z
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:47 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS4b-0004UJ-DR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyQnMufXLrrTxZ1JwZo4oq4sDgOLUEkoqxt7jqw3aaRje9SfgYjQ/BNKeZxBGPJMpBhfSTntqoMDZITialBhYPv1idaHT2K6Ngjkc7Fj3qJ0kG36BPazM1ZURv8U5blfM5jY8lRkrgUAIk2QiLKpfpw8jpe6HcMbpnyqGknz1xC+hF+mE2McSRBWxmcvSuUWjQHB/d43wLQk3e2yod+m+X2RXVwIDzpnTbwWuKaV4ggNR9n5z7FmUjR6/9h5LAtQiikRshB3SeEugXO58zM0OW/skdWXUWAg6pJe57RGeCkk9t02CfGbrGaTk8noGFiifBCUvfAsxTzuVcuSSJtMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JjRVLPg18/m3oc1Kyfyb2cyPkMUMa+/MISjDnjAY5Y=;
 b=j9tnme5FBwOMc4RFfBh23lNDOKPP8T+B6s2xefWjKZ8/nYTQW8Vq15zwwTicB3TqRagwVeFoG8vtyvzQz2TkRbSN40fU1rw87L+51OUl7yX4D57yx9NF3378R439jOiWQS8Ktyu5lGx1dBKN5xVVIGTyWXwFtPqODNRBdZL+wZymuF3AXSRCJudKoX3+rqkVyY/h/vdaQdiSLfzsBCTnFE/8u9JDOEOEt2pwDTtSNQhgmddjOp0KB3my8fhD/Uc5IBTSX/xbMyfveSfVUuXzFJ3E1KOH7LDgC65LggXKGkIqmRpiUV8M9fjSCt9gFvoOQGUInoiDmkAnb6BQIeH7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JjRVLPg18/m3oc1Kyfyb2cyPkMUMa+/MISjDnjAY5Y=;
 b=CDadHbD+KGE0lYDdjzZDD7QMbmqxeRB3FK/+zKBZY4D+TqmtEICDFkHtdvbFxry++Kc5oJHbTFT1R6LIhXQt/8qeKq/nJnk5mzMTQ2XyRS6I/HZI7rnbVFVRcxG7f2vXopGpz9cDRpQqrzYrhZOpdYEuiWE+rskkuSwmGcp6zhY=
Received: from MW4PR03CA0358.namprd03.prod.outlook.com (2603:10b6:303:dc::33)
 by PH0PR12MB999113.namprd12.prod.outlook.com (2603:10b6:510:38f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:46:39 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::71) by MW4PR03CA0358.outlook.office365.com
 (2603:10b6:303:dc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 10:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:46:39 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:46:36 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v10 4/4] MAINTAINERS: cover sp-mem under Memory devices,
 add R: tag
Date: Fri, 5 Jun 2026 18:46:09 +0800
Message-ID: <20260605104609.1739911-5-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|PH0PR12MB999113:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dca3a12-164f-4df0-34d3-08dec2efb967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|56012099006|18002099003|22082099003|43062017;
X-Microsoft-Antispam-Message-Info: LCiAR5hH33Ku/r+aSQ7Pa4CNnKHWCpaOpCAgVhp8dCJvuylz5FBTSMovoX6wKIaZO8sBb3sXPGybQClQdWSVtdsRRMToJJyDbCuHovbofViNgx2E8RLObXwZVdez+ny2mAqz5ES+8Ufc+YWpVyVlMjN1hxBBOFDahzNxFCidHk5XYWF+txdpGJb7/Caxw2t6rryg/euNUl/j2nNbDeUVJVRYjEeoMimx+gYE0K2wbGdSeHl5WpmBwzdphmlI5+xGO84CN8EemL+opPQ/okTv1wuTCEpzD8TPy3/5GRnTqSHN5DOTr1jHA8hWsFscQwY0LSS6apr9USEne4nQEkUIEOAtprEufkUzczKRuomM7RSZDmypXKq+Y7wDL5KWky4xtCe/IEolviGIl3BxWK3eYhRYI2O5obCGvW7Fq+ial7EgB3dcZNSm0oK3hSWy9D5oiJfF40q3wEfYWDsub/X/Jswm//uJ39m2BepR+ikw/9qnwvZZF3cQwnzIGN+AkuvlS05oTNdmyDuyqJZKadh2kMQ19IiIUMnj/3+BPjT6xKrxA86Q8YBjGDhkIqIk4/UDWGA5mwsATYzlCQhg9YJ+60FNDZX7R5SPr/HNja9hBJO635pHEBnLuhOO7Q7nkeNX22aT4hiVMVBKVi0mDCwuNY8jQ7qJrGmW2RuMhcoPkgOaAKxc4QpykgMRyEyX0HJ5cJokNqkQqRZa6cI0ASly8V0//B97BJ5+31qkZkA8AkOg8mvwL+wcUsC298/vigdRYukbwBhRP032i8auyMfK/njpJA+zn3qdofb9b/pC3jw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ey18PX5skf2VZHO6H+zNM4AFJvrlNy+EXT4XSgtEO2ho4qb3Gk4AoXem310vwtyT6/n4L9Qxl0A5ksNKrHp+LJYycQF3BITORc5FE19AQbteUzLw1e0pTqkaSEAOlUPJo9bUb00zTmpCGuQMFJ4Jm0p506DQdhIYI16iD/kGknRb3EmlKnuAoAeB3Jqr1doXi2ZKi6wfmhCUPADFsPM0mGhByBVrcykAhdvSm2G7J+Om00246Sy23UtjDjI4Oooy1tb812KSGTQ39fgxmwPrRPvM/V6eX0FYXhAyNasKflc2SdGr9rIO3tEydhQMW3JPUhV6btyZclJC2Ju7YgOOPys/KhmLd3zwpj9uHpFS5SKNSa7y7SxmOaUTUxbsn8vQKNrWKQzs63eXMGokbCeh8TQ5wsjeghzuzQWtsq1TutD3yS6ZZx7LIiTBZY4w9oLo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:46:39.6073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dca3a12-164f-4df0-34d3-08dec2efb967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999113
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7752917d8c..db34f6cf17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3361,13 +3361,16 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 Memory devices
 M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
+R: FangSheng Huang <FangSheng.Huang@amd.com>
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
+F: hw/mem/sp-mem.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: include/hw/mem/sp-mem.h
 F: docs/nvdimm.txt
 
 SPICE
-- 
2.34.1


