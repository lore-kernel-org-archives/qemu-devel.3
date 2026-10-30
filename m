Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470F606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1tPVULUl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMm6Q-0000Xd-Br; Fri, 30 Oct 2026 08:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xMm6K-0000X9-L8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:52:58 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xMm6I-0002v1-16
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:52:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TydajpAWWogYtrRiBxyNmErKMMvhBQfr9RnD/IjDB/SqRFyUVvJs47Zy71L+20jJbm9jjLVAoQOjL1waxxYxnnLEi2uP3WWZU+EUv4jA4XKjsJ2+y1u5Y9NBZzz3/U7jMDyGIIWx1H1J8tTzDhTUdPPdRD/gPBrEyJ8MafSViQCisD3eapuokMSDGEEQGyZBVzmyi/FNErKX8iE/YoQ/8wzCF5R8BKzQ3vN/FFlAW2BJKidfxUYt6UoGhLFnvKW8bqb1VMrsTF3cQ+Vtfkt+xRoCsVcocwkp7MUUCSClEzNeY8eP8692YRtjJkxM9IOVWXU1j4Jht/a/q9BCD/mCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRZpM7PSDE2vCIaOors0Vrcklo+aiO8Zls0ZANDcEJE=;
 b=pqvfxb2PPfMY9niAZnN/3M43oELb4iLPc6UW1i24q7SEXflIzX4RmeI3N5mAoeKMsnogBdLFXtoMUmNddPUQb321ZAeT9/HiyjLlH3mJR6PjCG4Xi9xIEz8iYqTJZhnybiZvNodLum13ASh1K2cMDXsfSkYyzl84Q/qtLrK2/isriJUBF7q22nD/ldqoOzZV356cwSez80ByD9B7bQ3V35W8i0YDaqjMTPerko7bfztVcwkpG3HNCr8RvUc2cMGqhd2rLMxiht5l6/mgsnocDuG7v2SoDvjkmnV0j/9KkhfBGZLsFKmLYCubT7zOtauzKl3KCZ5rVg62B+UlTbDF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRZpM7PSDE2vCIaOors0Vrcklo+aiO8Zls0ZANDcEJE=;
 b=1tPVULUlIGIfrIuxb0L1/Adrumu90vlIyurVv9ItwJAHR+AEs5pfKrQYKXAQGqPXyr1jmzLrI4E8KnqnhO5zyTx0comXeVLv/Kal7lfMGUUNVpjNdTuqgv4gD1aeln1uMJ5wTVd2R3jACseGw266VfSPA7AUnPSHXcKaO4qjVrk=
Received: from PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::25)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 12:52:45 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:510:326:cafe::31) by PH7P220CA0003.outlook.office365.com
 (2603:10b6:510:326::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 12:52:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 12:52:44 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 07:52:44 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>
Subject: [PATCH v4 0/3] SEV-SNP: Add support for SNP certificate fetching
Date: Fri, 30 Oct 2026 07:49:32 -0500
Message-ID: <20261030125228.2160752-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a357de-831e-4927-9398-08df3684b175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|13003099007|18002099003|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|10067099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: DLU8ZzdVJRKRc8bB9vIdBCB089ZbJKmgA0VLsOzkcwaWLhb5orRl29V0oncwINRGSMPipgQ9FWT3x/1UuiK7JG22Xu8cXOjLiiGwI0V9BxE7htk/CKIOP/CxQ6phrMm+uZpzxnKtFml9lrEc89oIAhYlvGyK9GRTrzVfSXrVc2DMGmJEodGIvyaILxCPzVvYl0zDC3cn19n7LWHAp+sEEgtjHe3Rs7zZE9fGEV33JB0T+jEDPuKleJAn2sHHWt6QIJpzSIcqjQrNWY3m0xs5sBrc6q51mMpMKRhEHNzwfkKTaYSmOewtUpe4/pyNKQA1QDqcCTNC2lSlzXQe27mK7JZmlihxxF1+GbUe88MerdIVU5M981mK/7Pg6oPqto15GmNGnOkfdi6q4F59DClr0pMY93K7iu849DYdUFBvYWdSi+kBLbyGsnm/GemrOTE6l42uR4GiehAKU8+/ms3JiGKLKLOaIFAU0mmwJ+ZbnFdHzme3+O8yp+AGjo25k5tR4Vxa9mUfHMBPkooxgOZF5NXeKKEzXVz4XYoaEB/uYTAVzwoD4i5NpCWywqDi3TjoX8WApmjXkcCi2gHyBzBNCOMO3ILfczG1mpAYUPKOBrPJIFxNy1VNLBFMIIuvi7ab8u5CN4XAgBV4mAcEjhiHumYv93IbOU5CLBdtPpAUezY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(13003099007)(18002099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(10067099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5JopW4uJxILLqwcFuA1EG+jvAnm3FNL4c4qvsjvd5FJuoaL0jjxQwGF50TQyTIeG91H+6+ocDzz0wX4Ik2yt5N9hGlUtLLiid6jlynGPcIcyTP5gEpB8+LmIk2zBpd03XKxKP+geGb8n8O8Xll/NaD5eziv5Vj8iCnK4S0DYw5wl6VROXPo9kf7KAPP2OmHfFWAYibxstED7fNTNiZOpuwYPjTV+nGxLtWVV2NPzjzglDubea7bEy/L1SU9N3SGOfAR61zH4Duc3MT8o58CH9Ju+b2xJZpTfGvJwL4v26rBGttiJdYA8YKYlJyr0CFNyG1dMtpCL1e8X8DEAZxlr3+EJvY1phsjk1G1CymOrHruo9XDSqCeu36LrAkh9ClEN7XKO0u1UgzTHPexVWmuJGR6dzFVoUJancnj/+CJs9wpGoUU9UtoX8sLusKVoVsak
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:52:44.9505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a357de-831e-4927-9398-08df3684b175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
Received-SPF: pass client-ip=2a01:111:f403:c100::f;
 envelope-from=Michael.Roth@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patchset is also available at:

  https://github.com/amdese/qemu/commits/snp-certs-v4

and is based on top of qemu master (b574eaf640)

v1: https://lore.kernel.org/qemu-devel/20241218154939.1114831-1-michael.roth@amd.com/
v2: https://lore.kernel.org/qemu-devel/20250120213116.521519-1-huibo.wang@amd.com/
v3: https://lore.kernel.org/qemu-devel/20261026172300.2061829-1-michael.roth@amd.com/
v4:
- Use 'int' for 'certs-timeout' in QAPI schema and avoid subtle upcasting of
  uint32 (Markus)
- Fix up comments/documentation for readability/grammar/spelling.


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

For testing this, use a recent host kernel (7.0 or newer should
suffice).

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

 accel/kvm/kvm-all.c                        |  21 ++
 cpu-common.c                               |  66 ++++++
 docs/system/i386/amd-memory-encryption.rst |  77 ++++++
 hw/core/cpu-common.c                       |   2 +
 include/hw/core/cpu.h                      |  33 +++
 include/system/kvm.h                       |  11 +
 qapi/qom.json                              |  23 +-
 target/i386/kvm/kvm.c                      |  10 +
 target/i386/sev-system-stub.c              |   5 +
 target/i386/sev.c                          | 363 +++++++++++++++++++++++++++++
 target/i386/sev.h                          |   3 +-
 11 files changed, 612 insertions(+), 2 deletions(-)


