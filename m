Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D060A261B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Uq1MbN4U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLORQ-0007zI-PH; Mon, 26 Oct 2026 13:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xLORN-0007ts-0M
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:24:57 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xLORI-0007HJ-St
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:24:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOcx1GaPkePnUiK2bJudWYdY/LVzX9JvrGP07YtPYKP0uQVGNNHFpOI4fNtuNXLy+JqOHJqIfWhc6uWo5pDWFghScF/TTxZfK09lcfcc1kzU5bQtg8t7VUsJ3ZHwHbBdsTt2LXqYArpqXlDFGfB8FXbSx4MHV4Zz1gnZvpPN/bsFgCArUVxiFSk8GU5OO9dwWFSOXq3qmzuNFdoJj05cwevtyuPZyCALf1wSa6qstwoUZssr7UJhypIzf7BEHNMgA6bHXN33NvNf4SxNNaXsUw9ic5nCeyvGPGA9sU1SxJVn82fn91Ng1c8y7x2N6v5OOIc4Dt9qxSqUSxNHA8dXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n5BPPppsIUu00gJjRF2NswaS9bY/rt2ssb0+MruWag=;
 b=UG/CtvnXgXV3uPGqogMfNxjBjw2KVJuk3XXapKyH7G9yXdlcnp8kpff6CWMDOSO4qGH3yKpy3AAt2YvMgnKUpUn28KSL7yBs25IFBk7XA9hsF/gnArq+3G8G2MLmDX11p/8fP5YPnjuo//o81qCsSXSlJvEyjtqdfn3yhnacY/xb+XAxsQOjEyJEl26PxTM44EE9pdQqabSj26ywj0cwKHi22gDUODzykkPfg3UZO0Fvk8I6wt5jwl8TVjlJnh0CSc0+HFloGePa5TP54+mg8dStTbQLEPssXLhisU3mTLITIHtOLn9YvdaoTgJhaJvxw1EFDZhIxNLUuXpgz2+zCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n5BPPppsIUu00gJjRF2NswaS9bY/rt2ssb0+MruWag=;
 b=Uq1MbN4Ui8GNcpgWHOVRGZdxvox6/xuMtQ/9UMG6A3l2huntaI0MKwshDhctgiJUrAw3Xf0XOm9AvKbk34ZVK/uRkGw/8ZsVHyLgQ/xakaK93FC6KoRMnrUG8kruyOWP8tttbDMh5FH+41eynIC7bqyy1rcGHd5cHqM5Vb+TNQc=
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 17:24:41 +0000
Received: from DS8PEPF000000E1.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::26) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 17:24:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E1.mail.protection.outlook.com (10.167.23.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 17:24:40 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 12:24:40 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <thomas.lendacky@amd.com>, <huibo.wang@amd.com>
Subject: [PATCH v3 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Date: Mon, 26 Oct 2026 12:21:49 -0500
Message-ID: <20261026172300.2061829-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026172300.2061829-1-michael.roth@amd.com>
References: <20261026172300.2061829-1-michael.roth@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E1:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 458f6d81-ccb7-4e2e-0c05-08df338604de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|261026140227099003|11063799006|56012099006|261026121527099003|261021135927099003|261021123027099003|261021121427099003|261022075727099003|261022113327099003|261022105027099003|261009223027099003|10067099003|32116099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: KSbgFRSDAPcMLHIHIRh7f5LQvqxpHvwPdVOszRK8lZ0NJ5rUj28znNYVq1H1qMGglGYEDw3v+sf06Hf0mz6gwFc4opLU4Ct2XHgIRx4uJQonAj9s3mBKq1hcbNYV0gNiQnVWeXvN/NWmGyT6AujJ4fczw0AE9jXmzzBddmbqaOnzteOs5lNdii4MwQEtzmy0050Gv7nFr3OC9a3Ru6h+12kH/+51NcPLIntuiBlMeKS8ROlZ1PkPskd2IMJH8QONA7X1XsZ4sTi8FOM80hwklMcu7vkKofF31N3/oB+MovuEMuEc6TZy0GxW+JsZ4xePaDapPOM8ZZPi0RjDICQZTmEdscfaZYRRAUISO9OkFyfOBhQrzyGwyvL5vbvKvdw7t8fg3E9rf4kz6a9j8WYoC+Fa/P0vtkxF1sM7k3OxaF4h9+qrKxfVYNkqNdfz8LBHPIRJigbnnUeAdwaWe9Xa1QCYP5SqPAMyrgakPASM+PZeTd07GO8yx20oFsXh+YzDOPeYp3M1IQ87IgdDjOwLFqcS89NO5iTV1pBoM5eV5cxuAsITLl/ZzAyZ36cMUIjlXWRvZ5QK9BPx7jEC5T7PyUQbvFzPgCgOrByG5fbdFmpaKRPCSoD7azJqbCy8zmscibfHTMpOYWGOrKCx0k4X+Wj9A4WNhuPblbIx2WyLaRGoWEUkupVmLz/viYkl/F/sZfy9b1pHYl2Hd9OujUuTNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022113327099003)(261022105027099003)(261009223027099003)(10067099003)(32116099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: luL6UiQ4hakPwAk1w9WdtnOlZNKfwfXeDWpNFZWQHu1yjwgrKF0fntnBjSVhJT0nmQWlomz4tgArgqSJa0xHx6lYBnyiY+REfvoqSndY2AKh4Y3fF7mtXuJUe0X+drZFSgO0UBHgb3y/dhkYMrkjQSyLD57GY4SQ6qXGFwZq75h6lVuLAuk613/tcb3B3cOomfeXSNxZS1CPc+hjE9uyZ32+x5LL/+gSLXIPQeHYhjXZdFSTPFtHuwsSM9d2n7kEeDgoRLPoYFMdHDkkwyA3MqJ2Fi1iIKV8Qb7+piNZu45uYEd/LhVZYJLNcJ6zYcjrrtMBjCnfwSjgHixQWp3jWBqdu+ZNsxJ1++2Bw+6uL4hw/K62CpG7RvpNXnSBS00JE+3w3DU9xBPxQNK+m9S/qkjOWVEn5tH2m/3e3r0WBinTGJmsyx1Xnkqdeg+dozAd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:24:40.9374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458f6d81-ccb7-4e2e-0c05-08df338604de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GHCB specification[1] defines a VMGEXIT-based Guest Request
hypercall to allow an SNP guest to issue encrypted requests directly to
SNP firmware to do things like query the attestation report for the
guest. These are generally handled purely in the kernel.

In some cases, it's useful for the host to be able to additionally
supply the certificate chain for the signing key that SNP firmware uses
to sign these attestation reports. To allow for this, the GHCB
specification defines an Extended Guest Request where this certificate
data can be provided in a special format described in the GHCB spec.
This certificate data may be global or guest-specific depending on how
the guest was configured. Rather than providing interfaces to manage
these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
to request the certificate contents from userspace. Implement support
for that in QEMU.

To synchronize delivery of the certificates to the guest in a way where
they will not be rendered invalid by updates to SNP firmware or
attestation singing/endorsement keys by management tools outside the
purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
obtain a shared/read lock on the certificate file prior to delivering
them back to KVM. Only after this will the attestation report be
retrieved from firmware and bundled with the certificate data, so QEMU
must continue to hold the file lock until KVM confirms that the
attestation report has been retrieved/bundled.

This confirmation is done by way of the kvm_immediate_exit callback
infrastructure that was introduced in a prior commit. Once the callback
is issued (after the next KVM_RUN), the attestation report will have
been fetched, so the report and certificate data fetched by QEMU should
be consistent with one another, and the certificate lock can then be
released. The included documentation updates have more details on how
this is handled.

[1] "Guest Hypervisor Communication Block (GHCB) Standardization",
    https://www.amd.com/en/developer/sev.html

Co-developed-by: Melody Wang <huibo.wang@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 docs/system/i386/amd-memory-encryption.rst |  77 +++++
 qapi/qom.json                              |  23 +-
 target/i386/kvm/kvm.c                      |  10 +
 target/i386/sev-system-stub.c              |   5 +
 target/i386/sev.c                          | 338 +++++++++++++++++++++
 target/i386/sev.h                          |   3 +-
 6 files changed, 454 insertions(+), 2 deletions(-)

diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i386/amd-memory-encryption.rst
index 6c23f3535f..da6f1a3693 100644
--- a/docs/system/i386/amd-memory-encryption.rst
+++ b/docs/system/i386/amd-memory-encryption.rst
@@ -228,6 +228,83 @@ schema for the 'sev-snp-guest' object)::
     -machine ...,confidential-guest-support=sev0 \
     -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1
 
+Certificate-fetching (SEV-SNP)
+------------------------------
+
+When an SEV-SNP guest requests an attestation report from the host, it may
+optionally request that the host also deliver the certificates (and
+potentially other accompanying data) as part of the response.
+
+QEMU can be configured to provide this certificate data in the following
+manner::
+
+  # ${QEMU} \
+    -machine ...,confidential-guest-support=sev0 \
+    -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,certs-filename=<certs>
+
+where the format of the file is defined in the SEV-ES Guest-Hypervisor
+Communication Block Standardization (GHCB) v2.04, section 4.1.8.1, as::
+
+  Returned certificates are identified in a table starting at offset 0x0 of
+  [the file]. Each entry consists of a 16-byte GUID, a 4-byte offset from
+  [the file] to where the certificate data starts and a 4-byte length
+  representing the length of the certificate data. The table is terminated
+  with an entry containing all zeroes for the GUID, offset and length.
+
+  struct cert_table {
+      struct {
+          unsigned char guid[16];
+          uint32 offset;
+          uint32 length;
+      } cert_table_entry[];
+  };
+
+Because QEMU supplies the certificate to the hypervisor prior to the
+hypervisor actually issuing an attestation request, there is potential for
+the certificate data to becoming stale due to a firmware upgrade or other
+host management activities. The ioctl which enables certificate-fetching
+support via the KVM hypervisor, KVM_SEV_SNP_ENABLE_REQ_CERTS, documents
+the following suggested scheme as part of its linux documentation (v7.3
+at the time of this writing), and it is highly recommended that all software
+interacting with these certificates, or performing operations that may
+affect their validity, adopt this same scheme for interoperability::
+
+  The recommended scheme to do this is to use file locking (e.g. via
+  fcntl()'s F_OFD_SETLK) in the following manner:
+
+    - Prior to obtaining/providing certificate data as part of servicing an
+      exit type of ``KVM_EXIT_SNP_REQ_CERTS``, the VMM should obtain a
+      shared/read or exclusive/write lock on the certificate blob file before
+      reading it and returning it to KVM, and continue to hold the lock until
+      the attestation request is actually sent to firmware. To facilitate
+      this, the VMM can set the ``immediate_exit`` flag of kvm_run just after
+      supplying the certificate data, and just before resuming the vCPU.
+      This will ensure the vCPU will exit again to userspace with ``-EINTR``
+      after it finishes fetching the attestation request from firmware, at
+      which point the VMM can safely drop the file lock.
+
+    - Tools/libraries that perform updates to SNP firmware TCB values or
+      endorsement keys (e.g. via /dev/sev interfaces such as ``SNP_COMMIT``,
+      ``SNP_SET_CONFIG``, or ``SNP_VLEK_LOAD``, see
+      Documentation/virt/coco/sev-guest.rst for more details) in such a way
+      that the certificate blob needs to be updated, should similarly take an
+      exclusive lock on the certificate blob for the duration of any updates
+      to endorsement keys or the certificate blob contents to ensure that
+      VMMs using the above scheme will not return certificate blob data that
+      is out of sync with the endorsement key used by firmware at the time
+      the attestation request is actually issued.
+
+  This scheme is recommended so that tools can use a fairly generic/natural
+  approach to synchronizing firmware/certificate updates via file-locking,
+  which should make it easier to maintain interoperability across
+  tools/VMMs/vendors.
+
+As such, QEMU implements this same scheme by waiting for a read-lock on the
+file containing the certificate data before supplying any data it contains.
+In order to ensure that the lock is not released until after the hypervisor
+is finished fetching the attestation report for the guest, the lock is held
+until a subsequent exit from the hypervisor that indicates the attestation
+report has already been fetched, as which point QEMU will drop the lock.
 
 Debugging
 ---------
diff --git a/qapi/qom.json b/qapi/qom.json
index 4810d53e58..8884a1eb66 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1104,6 +1104,25 @@
 # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
 #     is enabled (default: zero) (since 11.1)
 #
+# @certs-filename: Certificate data that can be passed to guests as
+#     part of an attestion request.  See the
+#     :doc:`/system/i386/amd-memory-encryption` documentation for more
+#     details on the usage and file format.
+#     (default: none) (since: 11.2)
+#
+# @certs-timeout: Maximum time in milliseconds to wait to obtain a
+#     read lock on the certificate file specified by @certs-filename.
+#     This is not a cumulative value and only affects how long QEMU
+#     waits before returning execution to the vCPU and informing the
+#     guest of the timeout, so the guest can still continue retrying
+#     for as long as it likes, which for linux guests at the time of
+#     this writing will be about 60 seconds before the guest gives
+#     up and disables further requests.  If this guest-side timeout is
+#     insufficient, set this higher to allow more time to fetch the
+#     certificate.  If the guest-side timeout is sufficient,
+#     set this lower to reduce the likelihood of soft lockups in the
+#     guest.  (default: 100) (since: 11.2)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1117,7 +1136,9 @@
             '*host-data': 'str',
             '*vcek-disabled': 'bool',
             '*secure-tsc': 'bool',
-            '*tsc-frequency': 'uint32' } }
+            '*tsc-frequency': 'uint32',
+            '*certs-filename': 'str',
+            '*certs-timeout': 'uint32' } }
 
 ##
 # @TdxGuestProperties:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index da922f72d7..9f7bdf9618 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6651,6 +6651,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             break;
         }
         ret = 0;
+        break;
+    case KVM_EXIT_SNP_REQ_CERTS:
+        if (!sev_snp_enabled()) {
+            error_report("KVM: Encountered a certificate request exit for a "
+                         "non-SEV-SNP guest.");
+            ret = -1;
+        } else {
+            ret = kvm_handle_snp_req_certs(cs, run);
+        }
+
         break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index d97536cca1..e53f1bbefc 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -34,3 +34,8 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
 void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
 {
 }
+
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run)
+{
+    g_assert_not_reached();
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 11072b00dc..3cb2e9cd0c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -186,6 +186,8 @@ struct SevSnpGuestState {
     uint8_t *id_auth;
     char *host_data;
     uint32_t tsc_khz;
+    char *certs_filename;
+    uint32_t certs_timeout;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
     struct kvm_sev_snp_launch_finish kvm_finish_conf;
@@ -1701,6 +1703,278 @@ sev_snp_launch_finish(SevCommonState *sev_common)
     sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
 }
 
+/*
+ * Cases where -EAGAIN is returned on an error path are expected to terminate
+ * after the next call (e.g. via a qemu_open() error) if they are not transient
+ * issues. These potentially-transient issues are still logged however, since
+ * they are not expected on a well-behaved system.
+ */
+static int open_certs_locked(SevSnpGuestState *sev_snp_guest)
+{
+    struct stat locked_file, current_file;
+    int fd, ret;
+
+    fd = qemu_open(sev_snp_guest->certs_filename, O_RDONLY, NULL);
+    if (fd == -1) {
+        error_report_once("Unable to open certificate file: %s",
+                          strerror(errno));
+        return -errno;
+    }
+
+    if (fstat(fd, &locked_file) == -1) {
+        error_report_once("Unable to check status of certificate file: %s",
+                          strerror(errno));
+        ret = -errno;
+        goto out_close;
+    }
+
+    ret = qemu_lock_fd(fd, 0, 0, false);
+    if (ret == -EACCES) {
+        /*
+         * F_SETLK is documented to potentially return either EACCES or EAGAIN
+         * for contended file locks.
+         */
+        ret = -EAGAIN;
+    } else if (ret == -EDEADLK) {
+        error_report_once("Potential deadlock encountered while trying "
+                          "to lock the certificate file");
+        ret = -EAGAIN;
+    }
+
+    if (ret) {
+        if (ret != -EAGAIN) {
+            error_report_once("Error while trying to lock certificate file: %s",
+                              strerror(-ret));
+        }
+        goto out_close;
+    }
+
+    if (stat(sev_snp_guest->certs_filename, &current_file) == -1) {
+        error_report_once("Certificate file no longer present: %s",
+                          strerror(errno));
+        ret = -EAGAIN;
+        goto out_close;
+    }
+
+    /*
+     * Locked files should not be changing; this violates the locking
+     * protocol assumed by this implementation. Indicate the need to
+     * retry to the caller, but make sure to log it first.
+     */
+    if (locked_file.st_ino != current_file.st_ino ||
+        locked_file.st_dev != current_file.st_dev) {
+        error_report_once("Locked certificate file was recreated");
+        ret = -EAGAIN;
+        goto out_close;
+    }
+
+    /*
+     * The locked file is intact and as-expected, and it has not been replaced
+     * since then, so the fd should be okay to use.
+     */
+    return fd;
+
+out_close:
+    close(fd);
+    return ret;
+}
+
+static void close_certs(int fd)
+{
+    qemu_unlock_fd(fd, 0, 0);
+    close(fd);
+}
+
+static ssize_t get_certs_size(int fd)
+{
+    ssize_t size;
+
+    size = lseek(fd, 0, SEEK_END);
+    if (size == -1) {
+        error_report_once("Error while determining the size of the certificate file: %s",
+                          strerror(errno));
+        return -errno;
+    }
+
+    return size;
+}
+
+static int read_certs(int fd, void *buf, size_t buf_len)
+{
+    ssize_t n;
+
+    n = lseek(fd, 0, SEEK_SET);
+    if (n == -1) {
+        error_report_once("Error while setting certificate file position: %s",
+                          strerror(errno));
+        return -errno;
+    }
+
+    while ((n = read(fd, buf, buf_len)) != 0) {
+        if (n == -1) {
+            if (errno == EINTR) {
+                continue;
+            }
+
+            error_report_once("Error reading the certificate file: %s",
+                              strerror(errno));
+            return -errno;
+        }
+        buf += n;
+        buf_len -= n;
+    }
+
+    return 0;
+}
+
+static void snp_release_certs_lock(CPUState *cpu, run_on_cpu_data data)
+{
+    close_certs(data.host_int);
+}
+
+/*
+ * NOTE: It is not expected that the guest will call this in a tight loop
+ * where error reporting would flood logs. A failed certificate fetch results
+ * in a failed attestation request, which results in a disabled attestation
+ * driver in the guest usually.
+ *
+ * However, one instance of such an error is usually enough of a clue to
+ * to identify the component of the system that should be investigated.
+ *
+ * So, to guard against a malicious guest trying to flood host logs, while
+ * still providing reasonable debug/error information to the user, use
+ * error_report_once() throughout this function and its supporting helpers.
+ */
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run)
+{
+    struct kvm_exit_snp_req_certs *req_certs = &run->snp_req_certs;
+    SevSnpGuestState *sev_snp_guest;
+    ssize_t certs_size;
+    uint32_t npages;
+    void *guest_buf;
+    int64_t t0_ms;
+    hwaddr buf_sz;
+    int ret, fd;
+    hwaddr gpa;
+
+    gpa = req_certs->gpa;
+    npages = req_certs->npages;
+
+    sev_snp_guest = SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+    if (!sev_snp_guest->certs_filename) {
+        req_certs->ret = 0;
+        return 0;
+    }
+
+    /*
+     * By default, any errors encountered below will be forwarded to the guest
+     * as an EIO. This will likely result in the guest disabling its driver, but
+     * it's better than crashing QEMU.
+     *
+     * Leave the special cases, SUCCESS/ENOSPC/EAGAIN, to re-set the guest
+     * return code as-needed.
+     *
+     * Errors that are useful for debugging QEMU will still be logged, with care
+     * to avoid busy/EAGAIN paths/etc.
+     */
+    req_certs->ret = EIO;
+
+    /*
+     * -EAGAIN from open_certs_locked() indicates that a lock could not be
+     * obtained on the certificate file. It would be possible to set
+     * req_certs->ret = EAGAIN to immediately inform the requesting vCPU of
+     * this condition so that it can retry again later, however, linux guests
+     * are currently hard-limited to a 60 second timeout, at which point they
+     * will assume misbehavior and refuse to continue issuing attestation
+     * requests from that point forward.
+     *
+     * Avoid risking triggering this by instead busy-waiting on the QEMU side,
+     * which allows more time for QEMU to wait on potentially long-running
+     * tasks like SNP firmware updates/etc. which may be holding an exclusive
+     * lock on the certificate file.
+     *
+     * The down-side to doing things this way is that too long of a busy-wait
+     * will result in soft-lockups in the guest, but the guest will otherwise
+     * continue normally afterward.
+     *
+     * If the QEMU-side timeout is reached, then just go ahead and indicate
+     * EAGAIN to the guest, at which point the above-mentioned guest-side
+     * timeout will trigger if QEMU's timeout exceeds that of the guest. But
+     * that's better than killing the vCPU, which is the only viable
+     * alternative at that point.
+     */
+    t0_ms = g_get_monotonic_time() / 1000;
+
+    do {
+        fd = open_certs_locked(sev_snp_guest);
+
+        if (fd == -EAGAIN) {
+            int64_t t1_ms = g_get_monotonic_time() / 1000;
+
+            if (t1_ms - t0_ms > sev_snp_guest->certs_timeout) {
+                req_certs->ret = EAGAIN;
+                return 0;
+            }
+
+            /*
+             * If some other process (QEMU only ever takes a read lock) has an
+             * exclusive lock on the certificate file, then it is likely because
+             * a firmware update or other long-running operation is taking place;
+             * it's a waste to re-try at a high rate.
+             */
+            g_usleep(1000);
+        } else if (fd < 0) {
+            return 0;
+        }
+    } while (fd == -EAGAIN);
+
+    certs_size = get_certs_size(fd);
+    if (certs_size < 0) {
+        goto err_close;
+    }
+
+    buf_sz = (hwaddr)npages * TARGET_PAGE_SIZE;
+    if (buf_sz < certs_size) {
+        /* Communicate to guest that more pages are needed. */
+        req_certs->ret = ENOSPC;
+        req_certs->npages = DIV_ROUND_UP(certs_size, TARGET_PAGE_SIZE);
+        goto err_close;
+    }
+
+    guest_buf = address_space_map(&address_space_memory, gpa, &buf_sz, true,
+                                  MEMTXATTRS_UNSPECIFIED);
+    if (!guest_buf) {
+        error_report_once("Unable to map guest buffer to provide "
+                          "certificate data.");
+        goto err_close;
+    }
+
+    if (buf_sz < (hwaddr)npages * TARGET_PAGE_SIZE) {
+        error_report_once("Unable to map the full guest buffer to provide "
+                          "certificate data.");
+        address_space_unmap(&address_space_memory, guest_buf, buf_sz, true, 0);
+        goto err_close;
+    }
+
+    ret = read_certs(fd, guest_buf, buf_sz);
+    address_space_unmap(&address_space_memory, guest_buf, buf_sz, true, buf_sz);
+
+    if (!ret) {
+        /*
+         * Looks good, return the certificate to the guest and prepare to
+         * release the file lock once KVM signals completion.
+         */
+        kvm_add_immediate_exit_callback(cpu, snp_release_certs_lock,
+                                        RUN_ON_CPU_HOST_INT(fd));
+
+        req_certs->ret = 0;
+        return 0;
+    }
+
+err_close:
+    close_certs(fd);
+    return 0;
+}
 
 static void
 sev_vm_state_change(void *opaque, bool running, RunState state)
@@ -2051,6 +2325,41 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     g_free(sev_snp_guest->kernel_hashes_data);
     sev_snp_guest->kernel_hashes_data = NULL;
 
+    if (sev_snp_guest->certs_filename) {
+        unsigned long certs_attr;
+        struct kvm_device_attr attr = {
+            .group = KVM_X86_GRP_SEV,
+            .attr = KVM_X86_SEV_SNP_REQ_CERTS,
+            .addr = (unsigned long) &certs_attr
+        };
+        int ret;
+
+        if (!kvm_check_extension(kvm_state, KVM_CAP_SYS_ATTRIBUTES) ||
+            !kvm_check_extension(kvm_state, KVM_CAP_IMMEDIATE_EXIT)) {
+            return -EINVAL;
+        }
+
+        ret = kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+        if (ret < 0) {
+            error_setg(errp, "Certificate-fetching attribute not present.");
+            return ret;
+        }
+
+        if (!certs_attr) {
+            error_setg(errp, "Certificate-fetching attribute not set.");
+            return -EINVAL;
+        }
+
+        ret = sev_ioctl(SEV_COMMON(sev_snp_guest)->sev_fd,
+                        KVM_SEV_SNP_ENABLE_REQ_CERTS,
+                        NULL, NULL);
+        if (ret) {
+            error_setg(errp, "Failed to enable support for SEV-SNP "
+                             "certificate-fetching requests.");
+            return ret;
+        }
+    }
+
     return 0;
 }
 
@@ -3320,6 +3629,26 @@ sev_snp_guest_set_tsc_frequency(Object *obj, Visitor *v, const char *name,
     SEV_SNP_GUEST(obj)->tsc_khz = value / 1000;
 }
 
+static char *
+sev_snp_guest_get_certs_filename(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return g_strdup(sev_snp_guest->certs_filename);
+}
+
+static void
+sev_snp_guest_set_certs_filename(Object *obj, const char *value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    if (sev_snp_guest->certs_filename) {
+        g_free(sev_snp_guest->certs_filename);
+    }
+
+    sev_snp_guest->certs_filename = value ? g_strdup(value) : NULL;
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, const void *data)
 {
@@ -3361,6 +3690,12 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add(oc, "tsc-frequency", "uint32",
                               sev_snp_guest_get_tsc_frequency,
                               sev_snp_guest_set_tsc_frequency, NULL, NULL);
+    object_class_property_add_str(oc, "certs-filename",
+                                  sev_snp_guest_get_certs_filename,
+                                  sev_snp_guest_set_certs_filename);
+    object_class_property_add_uint32_ptr(oc, "certs-timeout",
+                                   offsetof(SevSnpGuestState, certs_timeout),
+                                   OBJ_PROP_FLAG_READWRITE);
 }
 
 static void
@@ -3374,6 +3709,8 @@ sev_snp_guest_instance_init(Object *obj)
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
     sev_set_feature(SEV_COMMON(sev_snp_guest), SVM_SEV_FEAT_SNP_ACTIVE, true);
+
+    sev_snp_guest->certs_timeout = 100;
 }
 
 static void
@@ -3387,6 +3724,7 @@ sev_snp_guest_finalize(Object *obj)
     g_free(sev_snp_guest->id_auth_base64);
     g_free(sev_snp_guest->id_auth);
     g_free(sev_snp_guest->host_data);
+    g_free(sev_snp_guest->certs_filename);
 }
 
 /* guest info specific to sev-snp */
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 7725f92e19..4d9e9b44b4 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -15,6 +15,7 @@
 #define I386_SEV_H
 
 #include "target/i386/svm.h"
+#include "system/kvm.h"
 
 #ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES /* CONFIG_SEV */
@@ -198,5 +199,5 @@ void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size);
 
 uint32_t sev_get_cbit_position(void);
 uint32_t sev_get_reduced_phys_bits(void);
-
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run);
 #endif
-- 
2.43.0


