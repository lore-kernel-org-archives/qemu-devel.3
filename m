Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA6CC79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42rc-0004cX-1u; Tue, 08 Sep 2026 16:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42ra-0004bx-Kn
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:56:18 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42rZ-0007Sp-1y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNqHReKFTOyI8ixbcImmz0Q7Je8COZVsQr5mQUNf2sU7VdANHNzFZxp10dP/+Eb+l43eYylcZv+pAwcA2vjMoP1qv4yD2jl8S9CvH4bJrwkffIosUkN9CZw+95QaLMgLizttyt0+0XilPnGry+CgqfvD0H6qjgAP2fwAt6dU6XUqRmoSP0WaJSDO2fGjJYlm0LQnpRFFImx5ZnBDz2A37pBs+Mq2tJWGSovhKQ5som3AU2F3t2aIvr21bwQOFNLRqoz80mCKCULuN93FGkTMYUehNF1+ui9m3JnqSRt+mW4rIeCcwjq3qdxgUTnS9PH1CkQNngcq/gCpj438SPTuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tea/LF5pvPpUxA//TgGWg/hH8ZSKr2mZzuauEbsqPgA=;
 b=tzlaUk8JSin7hOQk1Uv/Lsz0+tL3jQbJ0xpvuKT0zdEFmTRCyXn/Z5K713l0z+UGaUK9kEG41NZVns1HjP9XIiONh6nMAC9pQeoqG31JUbTZmLr+Qo1NX/v0zng+QRgDDaXqW/dgAYpVpXbxY9YragdOYC0r9jNmTdmkAEo4EVRAoXpAEqVnYL+5/P5b3q7Ps/HWU2qzRAl22uaGzQROMEnwqVfMQswRDOKLrnb2T7tBoEiC38ZYewGWmg/3fTCOn8dgkBSG0g94y3F6HEEWUnOMjn5q5E37X6nO/tHtK+REcmIUKmaVycAVSGPN9cv2iPobwbdBYzZyrfe0l9rCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tea/LF5pvPpUxA//TgGWg/hH8ZSKr2mZzuauEbsqPgA=;
 b=Zu3kU/ftm8pAwGdxXhho1Ukopos2yfWe2lX8WayCzkUObcGd2dYhu4R0NIw3LgUtzCC/+EebytALhC+3GjoHIzmkiRUO3OFfLhPMULEGpWeA8sPEdu6C0tGWg3ElOobMk2ux4ItyJrlBBXJQ7lhKC9xIyXCC2c9o2jGhbiIqQTI=
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:56:07 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::3f) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 20:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:56:07 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:56:05 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 16/19] i386/sev: Allow in-place conversion for SEV-SNP
 guests
Date: Tue, 8 Sep 2026 15:48:36 -0500
Message-ID: <20260908205236.838281-17-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fec758-b3aa-472f-85b8-08df0deb9a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: D0nEehI3bEafBiTywAvbtvsYMzTnyaaoTwNVICJCPoHC215AXyRvjGaT4MfsK5t2CZSzkuqX2excp91Wf+rlY5H8LINoTdpXj5/+etIVDXPTF3Ka3RH1TFYrITYttlvKIqAzjtjJrvCU68YYeFz6XIQ8YSC0A3udY2uJwIBFRe1SSieaO6hlmhgaqDNaolnvegCErlOa0MuzMj9S1zCWqDipGcnxpKMsWW+NNfkVLi1Al6gtbKwhpBFt/AvRB3LWJW5UHGUErpfLn2ttXPGHf39rbE707pXUyjiW69CfEpvnKfcHQr9e5RTIhAoOKpWddkhXLqk27ltuK3mOrTXm9HuOwjzen138INgxofoCCQfcx4uMgMRnIJnYPDG9AdHFPeSuM07O96hcvEfqFEhGtWFPYp7AwtrThQnBY55zZZGaDJDW31vEsaM7Se0vCoAvASYyWO1tfBrZTGidrZDdup659/b7hpHwW5hKnIjMLMHdOPwYYsaxKeXiOqGEkXZXqvxL0maUwZAQDkAQXHc4E8YsLlVssK/9p6/NpbV9h6vLm+slOahLI4RaahynA7/kYNlA++my/rhdqNRpCnk5Bht61wO53ecH/1xQvUFvFLkqKTO6A2CM1s6brpjFLHnUTP4HSvAVy+ZTp9b5rlLaSK8BOGSeynWqm9PhCQrYj5EJxjk2IswtdUtpLvlpwkjQg/exhgr1TpAA+jLIcqQjlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gMOIcX3BENtkT1dbQ0sZvzSMnG5VgFQuMMp27VxfYBacIL1kBivOsBslWwBkIoZ1OBUFLgwsmU3I/ACLPNAnt6bLa83OUnVNn0LPOD7Wkn1FhwMjU6rB6YA7aZXs2+Fr4pjchT8uHa7Hf/v8zJbfo79wo/cj/Bo/tbxNS5QiNfASWAvJoB4mj8mqbAQp7Hww/CEjdTiDzlEDVZjCgin+WuEtWJCqUeFmGcWubJTkR3L24t3NH/eqT1lR607XY57rhYX59a10M6+8Uev0NHV1wsvTVouvFK1NKX8ZsO9fFS7DsnJCwON9wNvXo+YlT02IftJrKfvCrer85WgFBBv7UlywgyhE6wrfNmdQmpzUJEymIRCizeMsHBPm2sbTh9fs3qu+im4T1JQ85AILCncALnQ5QuEanJqBlK4bbI1jTFfRdNpn8+vD847wqVayfJhZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:56:07.0293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fec758-b3aa-472f-85b8-08df0deb9a82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Michael.Roth@amd.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All the necessary changes are now in place for an SNP guest to be able
to leverage in-place conversion support. Allow it to be switched on by
users. KVM-specific checks will still gate whether or not the option is
ultimately allowed, this just allows the option to be set via
command-line.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 87d88b7920..dc9934d5f3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3313,6 +3313,7 @@ sev_snp_guest_instance_init(Object *obj)
     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
 
     cgs->require_guest_memfd = true;
+    cgs->allow_convert_in_place = true;
 
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
-- 
2.43.0


