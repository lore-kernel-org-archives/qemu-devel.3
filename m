Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A8606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=icgbdhBZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFNR-000388-GW; Fri, 06 Nov 2026 03:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFNJ-00037V-16
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:32:42 -0500
Received: from mail-westus3azon11011067.outbound.protection.outlook.com
 ([40.107.208.67] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFNH-0008S0-5c
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:32:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNa5KKja658eeMZ/gfJc9CTPpmYANcRyXcqQGV+NfXD0dfpR9WBVxkdw1PamrjHXQWTTx1AACU33MdcVz+7tfOIX1sRSMNHG7DU7ntdwKqaKSypUXxwLSP0+Dgr9l3Ab+NuM8v3DYvzXtNYV+5Q7hPP60xu1EgpygwaRWtth7dtq/OyjEl+nzuKsuMPsnrEWC5JIgL6Ge52eat/wbXfuEsPKaWnuNr6ecFnL2XDMiQuT/picxDS+Qhri+TWrllQvZ2A7abW+OHrYrIuwebr78m7CUPuXrQ71ir7bhO8mp8Yp43GVtIt7V7pOMACeQfZTY2BoafcI8wAOsUlmGE+Z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3VwuQDtrWXDS6YwVjbXU7gr7158NyxlxKBIXd90YpY=;
 b=WfAAcAkJDe4n+aTMG0ozFUjjZ5ARo9Tae7wWpbk4f+jzvVF3gaV8oxZXgtYi+0nLcqUaMNFRaxTLPQcIPmQJ0duUO4UaWb3IVRgbKrF4iMySaRN3Ypyij3C7WwT/czSOui7+VfDjSUiOUApasOw7iPMnrP7mdJZFaXoRbJrujnAcDGNz58ozccMTA3RiNZbHmOygydEGUnD4++8F73fPbC60w/mPkis4m1IbciBG1PR5pWizJjLstWOUz6JzmIqNrNzYTb2p5ilSatg2ey5qlMWoyIRAjo5fXvj1LvoPA2GjndezHeLmVgoFDZW/RF/vV0aiRcmBxBhSCBnPH4Pw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3VwuQDtrWXDS6YwVjbXU7gr7158NyxlxKBIXd90YpY=;
 b=icgbdhBZ87zX/74/KnYu9FXj6zsO4BSBavyKvQ8Arn1Tl6NipgRppOgPS+qPPkjVHE+sgTbcuk9BG/kAzakFZReNTXEiKIllt2VlF6/THLwYdDLUdPguhD24WXdFraV2Ls5qtzWVDpqt6qpIHe+/TI9euvXwKdzAVTho/Rdc9Ec=
Received: from PH7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::18)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 08:27:32 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::a2) by PH7P220CA0011.outlook.office365.com
 (2603:10b6:510:326::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 08:27:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:27:31 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:27:28 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC PATCH v7 1/5] virtio-gpu: Update Linux headers to add ROCm
 capability set
Date: Fri, 6 Nov 2026 16:27:07 +0800
Message-ID: <20261106082711.813336-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106082711.813336-1-honghuan@amd.com>
References: <20261106082711.813336-1-honghuan@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa159cf-6928-4562-50c4-08df3bdfcd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|261009223027099003|18002099003|22082099003|261021121427099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|56012099006|10067099003|11063799006|261102123227099003;
X-Microsoft-Antispam-Message-Info: GDWkBqjpZrvp+5xjRlElvGgJhMjvO24nbRZJUEb0/NuMNbNRvLKKHuRyyDXWxLHdu79QRd/qp1hLqaDR4ANpD/xpunbKW0EGZroRY2xSZuQfwZMmyGePPJLnlgl6CdvYpgMCIN9w1ut2FzOyEvkGFJFsyHcDzGhA8922cWc6gRsr6Ue+d0b5IBEc64h+tnlL+JaArHngt1lF5rpeWCaEf7Kqc9fhr8sz7QgQwiMB+MLBIS8yo2w+S5q+EZYv4k0HvNhUh04C5lm5zfdXdsWL1o37twpBkBUTRJV1GPqm7J+6X2bY97g7nIwklx99FU6LIFTuemrypK3siLehX4axyKU+XkX1uCjOGmYNME9U197PYDXLKS2QbdX/mTznmtwpd6KOPdrTQ3WX4qTJDmscR7nPRgIB9juxHGEb5sVa5DO8R2ekFLnDg20LPtVnxaZ/A6oeiLK59/mhKH1/RqNZsx7oERtKtEBs1r14x7aSjVlu1WbtvPFlaVGOhFYIWHkSbyHS59f1A6sCbv7wklXsDWHW8Yjley52Fch9zemVvB6YaCu7N3bqMXoBesMjSJqO6loLKMlzMmZ8md1vK6KmjRdaRqRELHIZ14OwcdejRg8V3wlC+dNav/WLa/QyhXDezyS+GbBm/1bLgTlztwUwbSs/b0CUEr0MxE4xxOYiShhdr+39Pqa/fcTsyLi9DRj6MGWXXuwxHv9W+Jb5OK1Ivw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(261009223027099003)(18002099003)(22082099003)(261021121427099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(56012099006)(10067099003)(11063799006)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yhkmgs6/nP789jYyPvdvCfK+WRGdoEsjbFAvCaA0etkmoTur8taLyIYTvn4LvplAL7iR9bi1KAxu+kRc0AhygK5TDJu08SWZ7fXAnGfbOb4LebDZSZ8kanrmadNw3b0pDM2hsYzm8/mTZs1+iCRLy93CRSbr2+k0BVoFFmziAHchCJTWUUwhzUWz5UX2rprrCL39Ld87R31wIFFAMVHs/Agdq6qzysqqJkq0TlsCXnQmAk7CsROAJ6/cuqI05LnV9FUDWg7+FVZe2fzMmj7Qw75uGuEEIRvch4efXZ4pfJH4qL2ZgsL51hZeO8nI8scjHmBad4nvl7qeidZWHMdU6iV+ed65GiGoYYf+UBkeOl/BD16IQ8sg86Z5zdvtwibiBku40EE+aOCVfG3K4HJelYyyQ+FofFGXor8nhQdgtjy3/8jCm5D22oix0MWTicfv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:27:31.4424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa159cf-6928-4562-50c4-08df3bdfcd29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
Received-SPF: pass client-ip=40.107.208.67;
 envelope-from=Honglei1.Huang@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add VIRTIO_GPU_CAPSET_ROCM to the imported virtio_gpu.h so the device
can advertise the ROCm capability set to the guest.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/standard-headers/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index c67f50f56cd..976bd225875 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 10
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1


