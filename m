Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28060A4AFD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=flbWLE5d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqBh-0001ov-Tc; Mon, 19 Oct 2026 12:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqBg-0001o9-3P; Mon, 19 Oct 2026 12:26:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqBe-0001SC-43; Mon, 19 Oct 2026 12:26:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFiURI018882; Mon, 19 Oct 2026 16:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=5Jocex4sDbN5k68WqE+Ry/zDwy4iSxxxeztjymuvE
 zQ=; b=flbWLE5daG8VFwA+E1WAXsOXjzIZSniFCGyPUtoqTvhy0Z5dmaIEEpcw3
 LZTM2NjKxip10hyRBP5mH75dT38oywAI8J1QJfJGq7IWJQ1YdPymvby7j9T0B9D0
 guxoOvRh+SKu4eLrdGQIwS3Zzj7SZmhwZfhA2dqpFaWt2Npcev+7HqQAKfjSYDhA
 2EXMaC1pImMC1v/l/w/Wsd9/700xw5EME/pVwVFnCSJwXIp26QtBpAa/jzp5lHfe
 X1+HLKo8hkOq5rt/VvP2tbLRbS6E2mxSOpmI8FWmp/IY82P0K5ZRebJen7NBUQWq
 kb1/CkaGiNCnITzdlQhf+qVVD7eYw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvuf66-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFo4jh122058; Mon, 19 Oct 2026 16:26:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvekp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JGQ04Q45285758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 16:26:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 855CB2004B;
 Mon, 19 Oct 2026 16:26:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0FC820043;
 Mon, 19 Oct 2026 16:25:56 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 16:25:56 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Sourabh Bhat <sbhat@linux.ibm.com>, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
 adityag@linux.ibm.com, nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com
Subject: [PATCH v6 0/6] ppc/spapr: Add RTAS error injection support for VFIO
 EEH
Date: Mon, 19 Oct 2026 21:55:34 +0530
Message-ID: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfX4ORY0AoXcm+K
 3GcroWDaWkdar1e8PznaSdVr/ULh0gIwgVJA2pFghmWgBJXOjV5DZjisI9F0/QnhObxyobeJOtl
 c2DDOTHWvAmKQcjr9xbGPy4Ciw+Ojds=
X-Proofpoint-ORIG-GUID: NcZjmG55K6jVepeCDsksjVtuV2Nk30cX
X-Proofpoint-GUID: DBOnDwcW6yaniASkPraPHyro_535WJKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfXzwQQPaYAaDB/
 vGL13mqtyFnkFPDmyqZEdz5hLweX5OAeYGrwQZ5XjvGxdQu1Tw0c6PFChLONbfd4lBtf8b7gGhj
 PHUP2khOXJb/qTpfx+zKbiadYJ0gJiP1IpaPYX39cOZDBlCgqDW7YKK2VuYcp+jBDObr++2eusO
 9w4bt/Rs21rsvWd7ozYSSos65N59gS6DERWh5B0B/rfWRBbCjDL5wS88ia+AERwn8Ft+CtqgJp5
 8UYcg/yNlKIufoJ6fzKEZAxMfBWijvgflBWUC4JV891filBooEFWxkO8BNwyoKtmc4Pk+q86Y+2
 nQRCzpjfvkFKbYVpFwQi1owZcOyKIOZc2OhllDgWuqXBF1zIOOowF95Y19rODsJcSxiMsqdNgiG
 KvKBJ3o9Hnv/ILwbEUfeIg6BL5VtW8Xa7mc5eeelvwGuQ6KTFenpASGvgcECZjxVDrJZ9179Z7v
 ICBa2fUF4le4uP5HutA==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad6449f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8
 a=jpY16ArVOPG__5ixgVUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190064
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series implements comprehensive RTAS-based error injection
support for VFIO EEH (Enhanced Error Handling) on PowerPC sPAPR platforms.
The implementation enables guest-initiated PCI error injection for improved
testing and diagnostics of EEH recovery mechanisms.

## Background

EEH is a critical feature on PowerPC platforms that provides error detection,
isolation, and recovery for PCI devices. Testing EEH recovery paths requires
the ability to inject various types of errors into the system. While physical
hardware supports error injection through firmware interfaces, QEMU's VFIO
implementation previously lacked this capability.

This series bridges that gap by implementing the IBM RTAS error injection
interface, allowing guests to inject PCI errors through the same firmware
calls used on physical hardware. This enables comprehensive testing of device
drivers' EEH recovery code paths in virtualized environments.

## Implementation Overview

The patch series introduces three new RTAS calls:

* ibm,open-errinjct:  Opens an error injection session
* ibm,errinjct:       Injects a specific error type
* ibm,close-errinjct: Closes the error injection session

The implementation supports IOA bus errors with 32-bit and 64-bit addressing.

For IOA bus-error types, QEMU uses the BUID from the RTAS parameter buffer to
select the target PHB. For address-scoped IOA injections, QEMU translates the
guest BAR address to the corresponding host resource address before invoking
the VFIO EEH backend.

RTAS IOA error types are converted to the EEH type values expected by
VFIO_EEH_PE_INJECT_ERR:

* RTAS_ERR_TYPE_IOA_BUS_ERROR    -> EEH_ERR_TYPE_32
* RTAS_ERR_TYPE_IOA_BUS_ERROR_64 -> EEH_ERR_TYPE_64

Requests with addr=0 and mask=0 are treated as non-address-scoped IOA
injections and are forwarded without address translation.

Non-IOA RTAS error types are recognized but return RTAS_OUT_NOT_SUPPORTED
in this series because their RTAS work buffers do not carry enough target
information to safely select a VFIO PE.

Tested on pseries and PowerNV hosts with KVM guests using the powerpc-utils
errinjct tool, together with the corresponding host kernel EEH RTAS error
injection patches:
https://lore.kernel.org/all/20260831065441.48654-1-nnmlinux@linux.ibm.com/

## Patch Organization

Patch 1: Adds the VFIO backend for error injection
Patch 2: Implements the ibm,errinjct RTAS call handler
Patch 3: Adds session management (open/close) RTAS calls
Patch 4: Advertises capabilities via the device tree
Patch 5: Splits VFIO EEH support from general VFIO code
Patch 6: Updates MAINTAINERS

Changelog:

v6:

* Add the missing vfio_eeh_container_ok() check before issuing
  VFIO_EEH_PE_INJECT_ERR.
* Remove the redundant ibm,open-errinjct and ibm,close-errinjct
  string properties from the RTAS device-tree node.
* Clarify that unsupported non-IOA error types are recognized and
  return RTAS_OUT_NOT_SUPPORTED.
* Update commit messages to match the implementation.
* Retain Reviewed-by tags from v5 where the reviewed code remains
  unchanged.
 https://lore.kernel.org/qemu-devel/20260901174110.45356-1-nnmlinux@linux.ibm.com/
v5:

* Added the missing files in patch 5.
* Moved the VFIO EEH stubs into a separate stub file.
* Keep spapr_pci_vfio.c as the Linux/non-VFIO fallback path
  and build the real EEH implementation from spapr_eeh.c
  when CONFIG_VFIO_PCI is enabled.
  https://lore.kernel.org/qemu-devel/20260831071958.58824-1-nnmlinux@linux.ibm.com/
v4:

* Removed the first-PHB assumption in ibm,errinjct.
* Use BUID from the IOA RTAS parameter buffer to select the target PHB.
* Added guest BAR to host resource address translation for address-scoped
  IOA injections.
* Skip address translation for addr=0 and mask=0 IOA requests.
* Convert RTAS IOA error types to VFIO EEH type values before issuing
  VFIO_EEH_PE_INJECT_ERR.
* Keep spapr_phb_vfio_errinjct() signature unchanged.
* Validate non-IOA RTAS error types but return RTAS_OUT_NOT_SUPPORTED.
* Removed host /proc/device-tree/rtas/ibm,errinjct-tokens probing.
* Always build the guest-facing ibm,errinjct-tokens blob in QEMU.
* Fixed ibm,open-errinjct return-cell layout on error paths.
* Fixed ibm,close-errinjct token validation when no session is open.
* Initialized errinject_tokens to NULL.
* Removed stale CONFIG_DEVICES include after dropping the associated
  ifdefs.
* Renamed the split EEH file to hw/ppc/spapr_eeh.c.
* Added Pierrick's Reviewed-by tag on the refactor patch.
* Added sPAPR VFIO EEH reviewer entry in MAINTAINERS.
  https://lore.kernel.org/qemu-devel/20260520095446.64206-1-nnmlinux@linux.ibm.com/
v3:

* Fixed the build failure reported at
  https://github.com/p-b-o/qemu-ci/actions/runs/26094993976
* Also fixed a GitLab CI breakage in patch 2 (qemu_log_mask LOG_UNIMP).

v2:

* Addressed refactor suggestions from Cedric and Pierrick.

v1:
https://lore.kernel.org/all/20260512071112.9675-1-nnmlinux@linux.ibm.com/


Narayana Murty N (6):
  ppc/spapr: Add VFIO EEH error injection backend
  ppc/spapr: Add ibm,errinjct RTAS call handler
  ppc/spapr: Add support for ibm, open-errinjct and ibm, close-errinjct
  ppc/spapr: Advertise RTAS error injection call support via FDT
    property
  ppc/spapr: Split VFIO EEH support from general VFIO code
  MAINTAINERS: Add self as sPAPR EEH reviewer under PPC RAS

 include/hw/pci-host/spapr.h  |  37 +--
 include/hw/ppc/spapr.h       |  69 ++++-
 include/hw/ppc/spapr_vfio.h  |  31 ++
 hw/ppc/spapr.c               |  57 ++++
 hw/ppc/spapr_eeh.c           | 577 +++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci.c           | 193 ++++++++++++
 hw/ppc/spapr_pci_vfio.c      | 315 +------------------
 stubs/spapr_phb_vfio-stubs.c |  62 ++++
 MAINTAINERS                  |   2 +
 hw/ppc/Kconfig               |   2 +-
 hw/ppc/meson.build           |   1 +
 stubs/meson.build            |   1 +
 12 files changed, 996 insertions(+), 351 deletions(-)
 create mode 100644 include/hw/ppc/spapr_vfio.h
 create mode 100644 hw/ppc/spapr_eeh.c
 create mode 100644 stubs/spapr_phb_vfio-stubs.c

-- 
2.51.1


