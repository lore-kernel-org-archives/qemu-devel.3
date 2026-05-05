Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59514CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAvg-0001GB-Ub; Tue, 05 May 2026 04:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAve-0001FR-NK
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:14:54 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAvd-0006HE-5y
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:14:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWrEQ0mN4GGAB+AlucBZgcz2UHrFsT7Ep2YOPyPdXYOPyKcVzPLPwp/aru81isIs1NevI91otFYXeDh8gMlxZGJSr1QIiardcMALo7VLAtPPokx0SrDWBP0GpSurXxcSnYkKt9vHf8sHeDhWaEW6UWrWvUA9WK8Z/LBwC2i+LUZL9Su2wl4gUl7m2a0XK1z0jvmheSt36Jzznwha6dushXgBLkpEwlqDbdoEEN7cX1orkwIYOxDXoA4SHJUxn+C8s9Cjm/zfgFxQ94OPkLRkmymQDahijPRUPY7VSgnGrH70RI5Ga/pdDpZ4pzGr6ot01iyBMWsN38Ag4LNTEDB2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CovMgv6/zzbKydeU86gWST+1tD7jwhDGYRj6zfO5ugc=;
 b=U0SPB7WVQG1/6CpW2ZA70aDsJJyXb/iArM9B7HcaV0UQvMW6U3hnCCNG6HbltNtLeylzRciot2KsMmXz0Y3AW+8c6nRLe9eLm0mq02ffkG7vrYXBXyOBtqWlKbqcrdppDia3z+Ra7tnTeY/C/Egse5bIuWrBnrt2p57uKQC1Srm/fyojZQRj1Kp5LToIRzxXyIVM/DBiTMdmOe/5v5nUOtP51b7m+tQp5DbM6FOhIsKBGiW6Iez0rq3b3VgVuC1aEi8obIgcW5K8VlVAOhI3NgQxrvsE/S13AIfQTu2TeTdEwfOqh714XD5RkSiRusXmvRGg5fOiM7czACXCwMJiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CovMgv6/zzbKydeU86gWST+1tD7jwhDGYRj6zfO5ugc=;
 b=GaxRKHfLVnxkDVtRwIPTyt5KPfyNBWaQNog8wUL2E9wEgW0hzYi6jVGXoYXK+SmscZbPvVJpEBGkZuuSJZBIlB48vfcDs0Sx6w860WJ4hP+pfnco/+xUUnZrpdDwWjuAvZIgaWQdYRmsbvDwrFGKlGb8LFGzIos3FgJQbYCZwdJ4oOxfO9g2nEMK3XjHoa/e7Vz2/wYkKmYuBDjKaeD8Gc4UExy/nT6dSF1vQDfQ0ZifjWsW0F7lFyLymXv5CH+YhNdFZ21My3SwxDLU/FbkpLJP7k1pVql+CskmU2Gk0Z3xAxWaaoEQT0q1b6XuoogDRDyn9WLlFi9OBEvbWC1CFA==
Received: from LV3P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::15)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:14:46 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::1e) by LV3P220CA0002.outlook.office365.com
 (2603:10b6:408:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 08:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:14:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:31 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:14:28 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 01/14] scripts/update-linux-headers: Add typelimits.h
Date: Tue, 5 May 2026 11:14:10 +0300
Message-ID: <20260505081423.28326-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 16502d46-fd87-46b4-9931-08deaa7e5e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|7416014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: M5nwT/rJCtbvjMVFznJHDT+owRkIrk5h+aCA/fWz4YLk6mRspJNck4DZ57N/2Uutk4Knt8Ca5NHdvRFjzyrNEP+FtIqSyMC9ylncbftzAzbw9p55bMX9InZM/KgDQ8iYGstNLqPBGFFCIf3pDUgzClmx9Ts5JkidMUNJs9Nr5/Pp8b5rupxRiKfP/FIgcMxDxMshB1eKQJMHGg7omIg10uxJe8V/W8Cna2L0ZUe2Nb1YxDcBKBqwOh9KIfbUziSpHIKl8/iS78g0bDGCKibwjBLZZgW+kBcylbezxvozGApApas3gMpDLlzMR7YEVYEE9AVJz8TqGMmouyG2d0SJm0pZnpMWmLdFRYrJMYkKaxkW3/lr9d8KBOvQdZW2lofn//7K/lV70q3XAlmymJFTmBQzvkHo/gyGKeE69K4h1RX2+eJlwRpGSAw/tWM08yQkIi2K0p0U+oapP9gsju4B5GQP3je0fVAHm3qwrHpfODTRmQMGHhlGvLQAcxGBn+3oSCohbnl0dpJWr6PCtiIAG1BOF9xmkqi2mjCDWX7dvl8zQt0E0cgKFCh3AtgSiSGAD7dF9+EVmeFj5myp1m00NDHKQOtdK/SiVxSNjcWS4QKO/+nQADUSbby4fcLiSlmDKfDqMIn/7b3CDhF5u6WskbKrp4IyJgGbD9fP0Gf9APihjVlytNZu2siMnrv1Jnm40MkB4w3xqSqJHy1n8DF4qC3HNYUFmuFkBICb9JGe0R4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(7416014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TFBDteq6/gy8juS6SjBoMJtkG/qjubEF3Wv58Z8jNYIlqNEpts91VsGd3fkYB9I5ZL6l39fn4Zs2fmumcIxUyT4IZbIgwEOLhwK2xRF+/x/zg3VtUfuEdkEaClwZcAGIloPBuwkZ42UEqJBOGldTVc5nFcXyOiHDaq2uoSaukxwOQmWJFBEe/IrVr3kYOPZ51LOfHQkv1NAtDcp0KkyCQzvDAcBv040NJXkEuL2Y/Pl8eC2GZu9Gxhoft6Cjn3dcmvZ7nIp9Fpvg59Y3HwPYMibv9FdpX9bdgTgaWTd2das+osnNtlVdQXVXM6OYzahePGrqJd8tAadwyjywjkheXo35DAogpVajXpAOe5uT8DX3+5v6xbVpi12qn7Uev4FB8eJnpF8mhtl+lFtVFkJgj7blOrjxgrTPZZ0BpJ9uC2vxKHvZuqCP1zJwesCVp32Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:14:45.9099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16502d46-fd87-46b4-9931-08deaa7e5e80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=avihaih@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Upstream Linux added include/uapi/linux/typelimits.h and includes it
from ethtool.h [1][2].

Teach update-linux-headers.sh to install that header into
standard-headers to be able to update kernel headers to versions that
include the above changes.

[1] ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
[2] a8a11e5237ae ("ethtool: uapi: Use UAPI definition of INT_MAX")

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 scripts/update-linux-headers.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 386d7a38e7..da367acee7 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -60,6 +60,7 @@ cp_portable() {
                                      -e 'drm.h' \
                                      -e 'limits' \
                                      -e 'linux/const' \
+                                     -e 'linux/typelimits' \
                                      -e 'linux/kernel' \
                                      -e 'linux/sysinfo' \
                                      -e 'asm/setup_data.h' \
@@ -250,6 +251,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/pci_regs.h" \
          "$hdrdir/include/linux/ethtool.h" \
          "$hdrdir/include/linux/const.h" \
+         "$hdrdir/include/linux/typelimits.h" \
          "$hdrdir/include/linux/kernel.h" \
          "$hdrdir/include/linux/kvm_para.h" \
          "$hdrdir/include/linux/vhost_types.h" \
-- 
2.40.1


