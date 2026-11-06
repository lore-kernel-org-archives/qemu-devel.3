Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81979606D806
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZU2hXiY4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFIi-0000jT-RO; Fri, 06 Nov 2026 03:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFIY-0000h2-2I
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:27:47 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1xPFIV-0007xN-As
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:27:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvls44tvrqnPfArLswq+uak+Lev13Dyc0SpJEtJxoXQ+Tl6BOXkq8Fuf8PJUVE9aR8SHUYZrAjoeewedHS3Qnlw0I6bVcJKz4g67Fo6eUkVuW4iM0kHncX+IA5hMWaoSvRdOuAHscIIcTUX71v112GS8qHS6vo1DfCiFnEcNkm+WZaOdyqyjGA3mW1sB027PP4CymlbTw05s73p/UTlAjgzKCSUFUTVZGx1DAYpOZHkhkYdGzvBJooL4qZo0aMK2+aehwPbOQgKKVIg+24UccQ+yHINB291Bh0dBk2S1C3hlz9eDMD2ht7HynTJJ54Wi6soTKfJNDe0/4enQhIwgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKSTEz3y8OXp1acuIvnq5pjfEnfzXalLl6g0cgHkkDM=;
 b=reNAkYZI/oI82Lf40dBl1urlVDUOAYkOCaqLW76maKJeH0NYL3nzMoASwkYuhHWqhl6rD2KeSAgxpLr3TsxGb7mu9ipUkQwdZUC1wBnAKzreO09xtPxPHVi7TNiqflPzfoSK57CrKUhfyq3SMwL83BMFy+qBIA9XdUPhiDoht/QGROpMOyqc7fj91HK9Y9z6ujehIwDoaFo/IiohKO6rKnel+loanyniZDJPKUTg8G+9GML8zGkjAElCA7uCGNKupzJ0Za2IDnDmLsrPH2W8UCArSUH9TplImBIs/ep61BYjPaXFimyddl3hHZeC7pEAaXrieR5v6sr5Jfu0yK4ddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKSTEz3y8OXp1acuIvnq5pjfEnfzXalLl6g0cgHkkDM=;
 b=ZU2hXiY4jc0VAveJ1fp2eBDB99Tw9FXXNtJbBCLYWDl7D/VnOl6bg+rNL3ydSpkn9nCS/B341Q70fuH9k8+exfUHFwQKSi/oJ2WTKX/fJtmugZGrszXcStPLBfq4HOoLOu3Kz94wiS7cqTQLQnetZ6O4K1vO/SU4XOLnZ499G3g=
Received: from PH7P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::26)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 08:27:36 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::ae) by PH7P220CA0019.outlook.office365.com
 (2603:10b6:510:326::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 08:27:36 +0000
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
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:27:36 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:27:33 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC PATCH v7 3/5] virtio-gpu: remove the artificial IOV mapping limit
Date: Fri, 6 Nov 2026 16:27:09 +0800
Message-ID: <20261106082711.813336-4-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: aeba192b-3578-44a6-27de-08df3bdfd03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|261021123027099003|261026121527099003|261009223027099003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TI/UZZIt3dzGmxOtOS0BVM1fLlhML5eNMCMYNdLRqJAMRUXRu3tO6efFFpV5tW14MXGJzjnwWWxl1AH9EI2IEKyg9cbu2iYWqccN+dF55HuMyUe5Aka1HlrzUR/BnPGzdSUQ0gfD8DKGokzVrv7pkOVnzsrCgsJbrf48kSonGT1F5IgA7zMqZQtE8V8u2yGoj9HbHimIEAlllOxPHJdv+Xz1FOPSfWdP3//7vTn6pn2UCpPBz1YuYyeU5wLP20xWkEpwHhOC0x8VEyR+kQ+LUWBfIgOOzHB91PVhWKM4dREH9zWrfHFKNQ5qbPTRIdPreogUptRE84O0LCAwai0/zrOy/LH/FV+dN1b1yzpFE9xaJyrcOYZBk0U23+MUCBWY0MO7I2ksECVkFoykHOZ5DHi8woZ5F1/De+7Xfhx2LqGacdZxewUk+xjFA/hLxCKiZAGyrXVaM8aXbwcyQamUdydGyye/imVu5OMS4Gj/SZTOyPRJ8LWT+u8lU6qcvJhvvmLqaXUyYrOMInh5VPN4RPvZcZQug+ORw8qCDPJDQBNtloPhIYNgl8GMTtf8457vLeDlBHmHBDezHo0pinzMw/FwpJSODNLoFe2QkLPtVf7p+XgNV8Dl7Q+xjYuyh0k+JW1m0sB2htIbQYoElflDpGklcveGvOD5caIw4DFyk60wGf4EczDKU+tGnDQozdcuIkJ7P3lgpU10Ol9b2hlWpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(261021123027099003)(261026121527099003)(261009223027099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +/Q5lmkFvXjOdcUGFJ4riQPeXEU9/1o1OGmfeQLYrvTuVtn+sJD3VxftZpkEmeE8wbh6c9DbRvFelyMAcvmjBdKjb7VH7L+jazrhURevc1npjyI/D0gDd4mUmExecIC8TXCNy2CeCbKDx7QaS5gdQQBKvvtiUw98mHYYIlpCG0wU7ze72JmvTuNtYswa6Unli6ZdxvZSV8hSW3/I5HS5Jas16FTKndBSbHEtiA5lHDcVjYbLCoB8y901o97AxuAne0WHCOqDblOa64BQQjshMzBGw3Nm6Ll158hXV53MMgRwEmgoand2CHHubQjFKuSrbZTBhaE9IjZSbQcF090n8u+fdpHvbr+eQp1IKZW05+IBSA487MEcabCFKd/sIlpTpICq33oQzoR14Fru4asph2YBTFo6Jx4PqQqw62NKgB5GXWDvAKGGGAgYw28RZCNq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:27:36.5828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba192b-3578-44a6-27de-08df3bdfd03a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Userptr-backed blobs can require a very large number of
virtio_gpu_mem_entry elements when their pages are not contiguous. The
guest virtio-gpu frontend forwards that entry count and does not impose
the 16384-entry cap previously enforced by
virtio_gpu_create_mapping_iov().

Drop that QEMU-only limit so these larger userptr iovecs can be mapped.
Keep the existing allocation, copy-size, and DMA mapping checks.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5d43ffb9918..3df7e3507f4 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -990,13 +990,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
     size_t esize, s;
     int e, v;
 
-    if (nr_entries > 16384) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: nr_entries is too big (%d > 16384)\n",
-                      __func__, nr_entries);
-        return -1;
-    }
-
     esize = sizeof(*ents) * nr_entries;
     ents = g_try_malloc(esize);
     if (!ents && esize) {
-- 
2.34.1


