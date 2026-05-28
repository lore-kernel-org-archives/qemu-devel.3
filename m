Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECEACD5BD0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 00:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSOFg-0003fF-Gn; Wed, 27 May 2026 20:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSOFe-0003eg-9u
 for qemu-devel@nongnu.org; Wed, 27 May 2026 20:05:30 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSOFb-0003eM-JR
 for qemu-devel@nongnu.org; Wed, 27 May 2026 20:05:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPf+v9MX91iwOUwMcQ3edPKuynOdkxCRLF7nPJMue3S19XSPUXNxobLPdyanDKz1+DMAeiPr00aBpeH6yIKluSX78hmAJgy2053G+bQYQHbBEcHle9KYSW7IIXzieJuFmKoQZGuT1/G6mCdI1+Yax6HnAXjW7EhTFYcm1pVqe3bMKzGI3pmqX4RFTcHPK/6/ikQdMIZvWXb3PlQ1dSitMcV6LkR+alkFhkYbhTcISfStajBXPYLfGE/UbzZ4Uh9bSwMcVQcwjf6a33aZiGoZ/4lWGZhXd7dDmBPQq3DzswAIJcZ4eFAoJial2eCBls5GyGLlOJ5Gcu+4wNAs3hcA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC0p+R1CbzUzT1FhfqvAhSJCW/bI+iU8sN1ntAUpP9s=;
 b=zMFCsDj5zyuAkW23qbqc5i7+lMqpzi6TFojIPREUbwweGCfoOhSeskI4sqLAJB8Iqz6qATbAW3OHBNUv8bHsxw0K+TjmEniIPo8T5rnCHgrVCZqRwfFDFW5TmXsOIxoa+wuPp+vdzIoQpm4cB0HVKsFQJ6iFZifOXxJ7aEOdFrBWHZZRWiJx/flrA/Ine1RaxKmXEpnzg38abxjmLPI+XeCjpHT3PnijbaiopdkEqRF4xnESwE/cv+Np0UwM2T953qlHyoEK4dkfG06Xl/Ql3a2d7P14sDlSl3rZCMHIDTq7zuwcL6ZW/wtmgRHPfc/Hhg2xM73/goycm6bRgFQSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC0p+R1CbzUzT1FhfqvAhSJCW/bI+iU8sN1ntAUpP9s=;
 b=GzAUeyna0b/zPyB98tB89+kvPYKONtSY2SzvZTlHE6W+Tl8e2wYDDscsMlLK9mI6SLLOlhKnD1meaOOaKdAezhJfKdKhpgmjkF/87Bw+bHnhUGJtVHMJ8A7QtUiX/y9UBAEHNfYYNidsPBkF0vDHyY8uT8zc5B1zudEyOSFxAOs=
Received: from SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::12)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 00:05:18 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::9b) by SA1P222CA0124.outlook.office365.com
 (2603:10b6:806:3c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 00:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:05:17 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:05:17 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 10/12] accel/kvm: Don't default to private attributes for
 in-place conversion
Date: Wed, 27 May 2026 19:03:35 -0500
Message-ID: <20260528000416.8161-11-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7bc3ae-3596-405b-cd31-08debc4ccd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Umcn0uxaSTCGHnOagPAfqbKRJjSlCM4PEXrzqyLOH9FD3U1ZymaD4rms2r1qp4C2ldgoFV/F4x4+sNB/lZQgv8Z7zchLZgHVioXLric5ZT+HJdLcshlGUOuRMY9iziVjoWRxM0PZIj0kOimRxupkcyBPwefAxCzd3xy1MjshU7kglqESDZYi4yTNYl7oPwJgXVpaH9CcIZpnmT4VnI245HZ5jZzGW0t3DYAIJocJYhLDEZ36ImdtR8MrqCHv4BNINV7vgHEDiAEgcALxpmVfwZWkGXXhrhjw8Vqc/CMLz4nWw2YxcDmGTok8byFH/zx/My99fPAlNWJNHVRwQOgG7GUf9iXOy/mlVsxFco+CMQI8O/VMfU6I7ayuf52jgfwidNteuuXf9/qjfGf+4sgXIwwCWvWcvirV6DVNfbJGIrAScOcVqiZzIiOzJXQy593/3PXDfWM7NOy80qIWy4KKQd1E4T+GbFVJ/mryDms9ivNYYR3MskAPDHJ4RXnPz0G/waOLwGlqbNjWzc2qax4m/oIMrcN4ZgV8Id1LMI0Ab6c7vlhhgH/+wBVqNEbOqRtrTkfznwSwZmobOgas6uWgCb4bOVl9Ej/FAyUwGpevn8UCyzGyJC1GMQJpo0993yrizfU2dNNE53cnP+OkgIunl/ZBDvn0KRqjGSdDmSqjORRbImNh36U1DvewnbNuNmjZ1Oygp7x7qiQEro9ZjPu6ZwI0FQxSPestJnXjGsZH3BI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gNnuTQVNtM+tDM2zsHgNzVSKGybThEIP1IQV4PR6A6xXQPFbVVPl6vyGCE++fPKJ8wCseeMerTJRLqExQIvsOlxW4RpOppuj35vqkCcG/d2ZPYyUV6PDY5CgiGWzbERyGAn+55DhVFiNp5a6REB98g+jYY5fJSB1jzI4qoSRQ/u4h3MonwGIyG0wVSXmY77lDb4TMOHl8Ihm5UXa4Lv03zutPWlRMzCrpZKUaYZIqRX5VphGvBVInc5mZhl+4k3QFoDzVMw3XHXBkfQiUM0DeqqFS0eCSqAAoWGzOVY3bRLsNJKOjNAo2wWjdLrM/1S8upJzI+lTPGJSoLlEFu6AS5uF7C99Zk1/Za/cdybCG/Tdnw5ic2vxnIZ5F6bSrmglFwNI7iM6rwrABNUHFDhLK1C/mioVmlKPUpxydrEpTJZScr99AEeIemBhG2GK4cyx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:05:17.7438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7bc3ae-3596-405b-cd31-08debc4ccd1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Without in-place conversion, QEMU can still access shared memory to load
initial state into guest memory prior to launch even if the GPA's memory
attributes default to private, since userspace is accessing a completely
separate pool of memory. With in-place conversion, all these accesses
would need to first be converted to shared, then back to private, since
the memory all comes from guest_memfd and only shared memory can be
accessed by userspace.

To avoid sprinkling these differences in behavior throughout QEMU when
in-place conversion is enabled, just default to shared. This does not
compromise guest security, since Confidential VMs will necessarily
enforce this via trusted entities, and simply generate implicit page
state changes if their default expectations don't match KVM's. However,
in most cases a guest will explicitly convert memory to a particular
state before actually using it, so even these implicit conversion
requests should be rare.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fd01435a0f..c3d399517d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1808,7 +1808,26 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        if (memory_region_has_guest_memfd(mr)) {
+        /*
+         * Without in-place conversion, QEMU can still access shared memory
+         * to load initial state into guest memory prior to launch even if
+         * the GPA's memory attributes default to private, since userspace
+         * is accessing a completely separate pool of memory. With in-place
+         * conversion, all these accesses would need to first be converted
+         * to shared, then back to private, since the memory all comes from
+         * guest_memfd and only shared memory can be accessed by userspace.
+         *
+         * To avoid sprinkling these differences in behavior throughout QEMU
+         * when in-place conversion is enabled, just default to shared. This
+         * does not compromise guest security, since Confidential VMs will
+         * necessarily enforce this via trusted entities, and simply generate
+         * implicit page state changes if their default expectations don't
+         * match KVM's. However, in most cases a guest will explicitly
+         * convert memory to a particular state before actually using it, so
+         * even these implicit conversion requests should be rare.
+         */
+        if (memory_region_has_guest_memfd(mr) &&
+            !(current_machine->cgs && current_machine->cgs->convert_in_place)) {
             err = kvm_set_memory_attributes_private(start_addr, slot_size);
             if (err) {
                 error_report("%s: failed to set memory attribute private: %s",
-- 
2.43.0


