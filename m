Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50515606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Djx9VL+L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOVT-0000iv-Hd; Mon, 26 Oct 2026 13:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xLOVR-0000ia-1c
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:29:09 -0400
Received: from mail-westcentralusazon11010037.outbound.protection.outlook.com
 ([40.93.198.37] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xLOVN-0007li-BI
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icdK8i5P8ID6/q6m8qRs8HRySENNBvXtXx9/Tk40WxGtxh6crL7nCcN1qLg2md/cB/RmGDut1zMSKJO2L9jhfgS+7FhC0LEYcvsUPxkvgmEF2Iiv7p90RwlWsx5xQ78Ls0Yae9a9wQKVey3QlERE5zEO5BpXJaLnKRU9oJKA8t810uZpM7FSTZl19OkIe6l4hguEX09EA3tyUzIpXYF2pu9eItVILprfvi8SbBHQlrW88yLPovXMEAZuLfAlvz0iaHkFp7XHvYYscHs+VMMJPV5p2Knjozdw4gN5wsbG5wVmu+bq0ctVQ4FNHzfXipYzmCvh/kwOR0W4psDJw/4u4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0mZDQjaGEPUsEcJlsaJdLNBjSDyVJAVUnetdfI73aA=;
 b=bisoflDbOVuq8SOkHPy/u+LZlw9hF93mz7UM7w7Yg9YsYGrEUZ1O/4eMIx5bdDovUSlPnr7qst0kE35XMdKEXHK7fkGuPv8lm/TGMYFN76aHE8doaDJcdKhkNeYuXJlLwPmPgPcrDcHo0HYlGMOhEcP2jPVFqNCt8zJlAEYaRrMCxODNAzC9uca2jkaTiju+wJHkMv+HjbYLDub3riCB41n+ACS8BZDbhaJb6YKT1pcxZe/AFvK4/3E/dDFZbIeDc0mFlZJLwKSUYor33t+R/Ui1jzXkjHFEki0mBu40zh0lmSRzI5BNbxvawFuUiM7XAoBZnnq4MbNfjFBoSqLR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0mZDQjaGEPUsEcJlsaJdLNBjSDyVJAVUnetdfI73aA=;
 b=Djx9VL+L3aBVAtV7mRnxfGHDhxtHTD90923hSCOaKelUy1k2MZ2zu1A+kO9LdQMWoS4NFp6s5F6ev2FCg9o2VQUsJ07+sI/XpYJwoiS+mbxGQwifAQ1TkDR5QoWtYo6ce9/9WWb7lq4k6PvuXXigkAEnSCZURkfoWN39KaF6Wew=
Received: from DS7P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::18) by
 MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 17:23:54 +0000
Received: from CY7PEPF000000EC.namprd04.prod.outlook.com
 (2603:10b6:8:25c:cafe::11) by DS7P221CA0024.outlook.office365.com
 (2603:10b6:8:25c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 17:23:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000EC.mail.protection.outlook.com (10.167.247.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 17:23:53 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 12:23:38 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <thomas.lendacky@amd.com>, <huibo.wang@amd.com>
Subject: [PATCH v3 0/3] SEV-SNP: Add support for SNP certificate fetching
Date: Mon, 26 Oct 2026 12:21:46 -0500
Message-ID: <20261026172300.2061829-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EC:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: de0644ec-f209-4c14-8242-08df3385e875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|13003099007|261026140227099003|11063799006|56012099006|261026121527099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261022105027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: W0wdBQtIaAkkpN9wJT+4J2oJc1becuDu40moVtkh0Avzu+sFhgGyorNqknJfrZCj7OLA0kv63AuN4vbZsTWQNg3AkcabLszspA33mupV3KAJdQZUxjRHP1nxO66STLYhJTkaOQjtGWJNKOL7slY7Hpers7HBoGhQSAHy6w7ybc7m3g8zkZuzHNIZqjnixAd5nsdktG8L8CONOPSye8yPR/X8rJYd2kfXFtzChYuWEJPS7vXVL17A/0oPNwcWaaQ7bTZ7w0Gqcw8FctAfjzZ+Uvv9h0cx78iuoNKb7vocJx7ZoQZbWze2R0LRJmsHUN3XL6J1ptl0nfTSlST4Q2QvOiJNVS4T+cLM6hsD5WVuWMk+CwvRQnuDDr56f+v9skKWFKLeFUEDz5GG5Yd4bwqQHzE+BANEaT5dE2YJtxekxTVB4u/l2cub29qDywodr3S5Mfe+EU5Y+H3GUwCk51xAyiDPRJxXRrInmHuZSHZ5HuOwIZlTCBuoxV8wkEkn6YfquCwXYBDz6sbAAFQqOJk7h8XncJtU7A7+q8RjFqC+IsEp2A1JUceoYTEC2B5pQuM0FgXR3pftp6a5rj3t38gvaAVZrb/YRgouHqtt3eESWTeWwQfeLTrx0NV4tXNMpZCY2plidEUmKTSU/0Pf5Qu4oabstluXZBILbw5oCVkTGQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(13003099007)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F0ZiMH1H+v8kslmLZSv88tg/daEQJ3NoPSBAaf2HnHen+5x/4j5YSnGkDEHbmXVygeA4mSFspz5OnRYv71IgwNGY11v5g7ouUQS7FwSEH6SlOSB3pDkKgzmUfXJcME9dRVUXwJvR6adOhSEKSu8SlVcawawZcQZFzCGAfakGt4VEaLCmejFaESpAfRdq4Ln3lV421O2Y3mrNl8KYkRgZLLitDs4StZlSvrki5sBUpRdLUkSSd1QtfyZcHjVAgj+uKueF3G2DP5kr/VOKoFRBaNQ9QOux3kWQbMZ5NZW6pGFmdz60ZtD2BtxBd9+aOZFqWZC4MuwQXJwqm5A1s45NJY77dnnojVojG/GQVRMEsG+0KUOn1TNUqZyjhpYsEAQEXk7TgqJGX2Nd1ac/++92bCXdZkww2yo5BhOXPOygvke37JMLrxTEoorTk0VeNujK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:23:53.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0644ec-f209-4c14-8242-08df3385e875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000EC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
Received-SPF: permerror client-ip=40.93.198.37;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patchset is also available at:

  https://github.com/amdese/qemu/commits/snp-certs-v3

and is based on top of qemu master (d731492832)

v1: https://lore.kernel.org/qemu-devel/20241218154939.1114831-1-michael.roth@amd.com/
v2: https://lore.kernel.org/qemu-devel/20250120213116.521519-1-huibo.wang@amd.com/
v3:
- add QEMU documentation for how to work with certificate files (Markus)
- address QAPI scheme formatting issues (Markus)
- partially re-use async_safe_run_on_cpu() infrastructure for handling
  immediate exit callbacks so that multiple vCPUs waiting to release
  read lock on the certificate file are each handled correctly
- refactor certificate file handling to thoroughly log unexpected errors
  without flooding host logs
- propagate all unexpected errors to guest rather than terminating QEMU
- additional comments/cleanups and other fixes


Overview
--------

The GHCB 2.0 specification defines 2 GHCB request types to allow SNP guests
to send encrypted messages/requests to firmware: SNP Guest Requests and SNP
Extended Guest Requests. These encrypted messages are used for things like
servicing attestation requests issued by the guest. Implementing support for
these is required to be fully GHCB-compliant.

For the most part, KVM only needs to handle forwarding these requests to
firmware (to be issued via the SNP_GUEST_REQUEST firmware command defined
in the SEV-SNP Firmware ABI), and then forwarding the encrypted response to
the guest.

However, in the case of SNP Extended Guest Requests, the host is also
able to provide the certificate data corresponding to the endorsement key
used by firmware to sign attestation report requests. This certificate data
is provided by userspace because:

  1) It allows for different keys/key types to be used for each particular
     guest with requiring any sort of KVM API to configure the certificate
     table in advance on a per-guest basis.

  2) It provides additional flexibility with how attestation requests might
     be handled during live migration where the certificate data for
     source/dest might be different.

  3) It allows all synchronization between certificates and firmware/signing
     key updates to be handled purely by userspace rather than requiring
     some in-kernel mechanism to facilitate it. [1]

To support fetching certificate data from userspace, a new KVM
KVM_EXIT_SNP_REQ_CERTS exit type is used to fetch the data similarly to
KVM_EXIT_MMIO/etc, with an associate KVM capability to detect/enable the
exits depending on whether userspace has been configured to provide
certificate data.

Add support for this exit in QEMU. Additionally, because some of the locking
behavior relies on kvm_immediate_exit, add an some infrastructure to allow
for callbacks to be registered and executed upon a kvm_immediate_exit-induced
exit from KVM.

See the documentation included in the patches for more details on the
expected usage and kvm_immediate_exit handling:

[1] https://lore.kernel.org/kvm/ZS614OSoritrE1d2@google.com/


Testing
-------

For testing this, use the following host kernel:

  https://github.com/amdese/linux/commits/snp-certs-v3

For the guest, any 5.19 or newer kernel will do.

A basic command-line invocation for an SNP guest with certificate data
supplied would be:

 qemu-system-x86_64 -smp 32,maxcpus=255 -cpu EPYC-Milan-v2
  -machine q35,confidential-guest-support=sev0,memory-backend=ram1
  -object memory-backend-memfd,id=ram1,size=4G,share=true,reserve=false
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,id-auth=,certs-path=/home/mroth/cert.blob
  -bios OVMF.fd

Something like the following simple example can be used to simulate an
exclusive lock being held on the certificate by management tools performing an
update:

  #include <stdlib.h>
  #include <stdio.h>
  #define __USE_GNU
  #include <fcntl.h>
  #include <unistd.h>
  #include <errno.h>
  #include <stdbool.h>
  #include <sys/types.h>
  #include <sys/stat.h>
  
  int main(int argc, void **argv)
  {
      int ret, fd, i = 0;
      char *path = argv[1];
  
      struct flock fl = {
          .l_whence = SEEK_SET,
          .l_start = 0,
          .l_len = 0,
          .l_type = F_WRLCK
      };
  
      fd = open(path, O_RDWR);
      ret = fcntl(fd, F_OFD_SETLK, &fl);
      if (ret) {
          printf("error locking file, ret %d errno %d\n", ret, errno);
          return ret;
      }
  
      while (true) {
          i++;
          printf("now holding lock (%d seconds elapsed)...\n", i);
          usleep(1000 * 1000);
      }
  
      return 0;
  }

For requesting attestation with certificate data attached, you can use
something like the following tool/workflow:

  https://github.com/virtee/snpguest?tab=readme-ov-file#extended-attestation-workflow

The format of the certificate blob is defined in the GHCB 2.0 specification,
but if it's not being parsed on the guest-side then random data will suffice
for testing the KVM bits.

Any feedback/review is appreciated.

Thanks!

-Mike


----------------------------------------------------------------
Michael Roth (3):
      hw/cpu: Add async_run_on_cpu_after_accel()
      accel/kvm: Add kvm_immediate_exit callback infrastructure
      i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for certificate-fetching

 accel/kvm/kvm-all.c                        |  20 ++
 cpu-common.c                               |  66 ++++++
 docs/system/i386/amd-memory-encryption.rst |  77 +++++++
 hw/core/cpu-common.c                       |   2 +
 include/hw/core/cpu.h                      |  33 +++
 include/system/kvm.h                       |  11 +
 qapi/qom.json                              |  23 +-
 target/i386/kvm/kvm.c                      |  10 +
 target/i386/sev-system-stub.c              |   5 +
 target/i386/sev.c                          | 338 +++++++++++++++++++++++++++++
 target/i386/sev.h                          |   3 +-
 11 files changed, 586 insertions(+), 2 deletions(-)


