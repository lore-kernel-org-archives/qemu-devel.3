Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FvOpIXLk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1U-0003ln-Dq; Mon, 09 Nov 2026 15:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSuA-0005QE-8b
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu6-0004BF-1S
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:37 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DF3Yi3442679
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 17:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=8h2/wk8TQ6UkvbwC218Oi4ttFOL76QqI2ifdQXksA
 hw=; b=FvOpIXLk5kHiK2+2nC1hUM1bOBbk4ARTeFjg4csBDviWdyMoQfVYB3m8Z
 TTDkjqk4BJOmjLQ/EMftnkDbxLRg/RL27F4If733lI2mN5PKXBWTLrzyAaLv+/P7
 R1oqoAXsuY3STXBhvmwcLu1kxSc5PVVuKrH/hllwbsW2DzuPpW4FvRv+d8iWFBMk
 92j8qTSppdwMHj7D2waCbKfKI50bEb/2C3l4Q2e87rbHhe39y8PQbgVZF/vCARhl
 +Y9rhrnpRUlDTHxAEuBuJS2vipMe4pAN1JnqMG9AkJV3O3BmRF+vkUdglir+Mk1a
 MNjrWgzqZzNSWZ/qlbznAimDzRhcw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkfvqp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 17:11:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9Gnvla173322
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 17:11:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthhqqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 17:11:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HBLbv30671216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:11:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73CC620043;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C1A420040;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>, Bjoern Walk <bwalk@linux.ibm.com>
Subject: [RFC 0/8] Allow using KVM UAPI headers for mixed architectures
Date: Mon,  9 Nov 2026 18:10:26 +0100
Message-ID: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af1febe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=6LgiAv3i9NU8wES144sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX75HW7tn77KNL
 LLvoVbnR1ijqdzkO4nw+OogMh5Z0JYuR33HjCaSObOygII8pwHEZBKiotubytQPnCCjU6bQpToq
 gxK5yPUkuIVp8aoUAba20j+32B0k2wzezPlRP9lg1aBcCkseUzxrghAvP3ns8rUVQs7pnzUlPUT
 PTR8P3GL7CNWI52wn1c3uyiKqW1tEmfyKouH8ZY4UTsExeEIL1kOnFtTF2xo2KnPzrfL4nPHqk1
 ecoUSGFcPbQXYJehhx6mj6PTffl/cHFGR26oyO01jv4Wcn7+i5bzDAGoJWKvZ3mGsWGkiwQBDFA
 yh4gT9aRbIB+bgYGQnNZDA4ifumqs0BB1veJ4sMwlrDRHIcGwsc7zrexMDjhH1xNrkhy3ZfIIUM
 4guOZ7+M21IHtXhMaDfQlJ0ACjNrRM5tFUlTsQTB/5L/PEuL5IR8wMLXofdnDYvmhp7zThKgaC/
 E7i9u5rQrnebhio0JPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX3ygz877G1Yql
 RdUa6QbBPShWUeznimdVhxaGZCz2U7iuoMjXhxI+UEhECeEbL1UJi5O28Y1ihy7NAc3Q9HkeZN9
 V7Vpe0n6n2eBShSkXt2S9a6Tfwrft7s=
X-Proofpoint-ORIG-GUID: aqgAjt1PtdSwR1UjSvghX_EsOuxX5KzO
X-Proofpoint-GUID: aqgAjt1PtdSwR1UjSvghX_EsOuxX5KzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=bwalk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:31:04 -0500
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Recently, there has been made efforts in the Linux kernel [to bring
arm64 KVM to the s390 platform][1]. In part, this is done by sharing the
ARM kernel headers with s390 code. Similarly, it is expected that any
userspace application on S390 will pull in the ARM KVM UAPI headers to
get access to ARM-related API definitions.

[1]: https://lore.kernel.org/all/20261014092343.715112-C-seiden@linux.ibm.com

QEMU, as of now, has one implicit assumption when building KVM-enabled
code: the host architecture is equal to the guest (target) architecture.
This is enforced by symlinking the vendored kernel headers in
linux-headers to the corresponding architecture of the host CPU at
configure-time. The KVM API is included via <linux/kvm.h> which in turn
pulls in architecture-specific definitions from <asm/kvm.h> from the
forementioned linked directory.

This approach does not work in a mixed-architecture build, i.e. building
KVM-accelerated ARM CPU virtualisation on an s390 host.

This RFC suggests one possible solution by trying to split off the
architecture-specific definitions in <asm/kvm.h> from the generic
definitions in <linux/kvm.h> and allowing QEMU code directly to include
architecture-specific definitions based on the compiled target. For
common code, QEMU stubs the architecture-specific definitions in the KVM
API and poisons them for direct use.

This requires some rearranging of header files. This is peformed by a
series of steps:

0. The first two patches do some housekeeping that arose as a fallout
   from the rest of the patches.

1. We declare the already existing include file "system/kvm.h" for the
   preferred entry point to the KVM API, allowing us to consolidate the
   architecture-specific handling at a single origin.

2. We need to adjust the vendored kernel headers for KVM. One part is
   that we need to split off the architecture-specific defintions from
   generic definitions. We can do this by simply removing the include of
   <asm/kvm.h> in <linux/kvm.h> and require QEMU source code to include
   the relevant <asm/kvm.h> manually.
   The other part is to adjust include paths of transient dependencies
   to refer explicitly to the architecture they do belong to. For
   example, on ARM, <asm/linux.h> includes <asm/ptrace.h>. We need to
   change those includes to refer to "asm-arm64/ptrace.h". This is
   unproblematic, since we should never expect that individual kernel
   files are mixed within architectures.

3. Now we can extent "system/kvm.h" with the logic required to pull in
   the parts of the KVM API that is needed in the source code. For
   target-specific code which requires definitions from the
   architecture-specific KVM API, we make this selection based on the
   TARGET_* macros. For common code which should only ever required
   generic definitions from the KVM API, we stub the
   architecture-specific definitions and just include the stripped
   <linux/kvm.h>.

This allows for example to build a native qemu-system-arm64 binary on an
s390 host with ARM KVM acceleration as demonstrated by the last patch
(which is not considered part of this RFC).

Tree: https://github.ibm.com/linuxonz/qemu/tree/canton/kvm-uapi-header-changes/rfc

Bjoern Walk (8):
  hw/hyperv: move hyperv.c to specific_ss
  include: add header dependencies explicitly
  Prefer including "system/kvm.h" over <linux/kvm.h>
  scripts/update-linux-headers: Post-process KVM UAPI kernel headers
  scripts/update-linux-headers: Vendor hwcap.h and ptrace.h for arm64
  linux-headers: Update to post-processed KVM headers
  kvm: Adjust system/kvm.h for updated KVM kernel headers
  include: Explicitly include ARM-specific KVM UAPI headers

Nina Schoetterl-Glausch (1):
  meson: enable aarch64 KVM target on s390x host

 accel/kvm/kvm-accel-ops.c              |   1 -
 accel/kvm/kvm-all.c                    |   2 +-
 backends/hostmem-memfd.c               |   1 -
 hw/hyperv/hyperv.c                     |   1 -
 hw/hyperv/meson.build                  |   2 +-
 hw/i386/kvm/clock.c                    |   1 -
 hw/i386/kvm/i8254.c                    |   1 -
 hw/i386/kvm/xen_evtchn.c               |   1 -
 hw/i386/kvm/xen_overlay.c              |   1 -
 hw/intc/loongarch_dintc_kvm.c          |   2 +-
 hw/intc/loongarch_extioi_kvm.c         |   1 -
 hw/s390x/s390-pci-kvm.c                |   2 +-
 hw/vfio/kvm-helpers.c                  |   1 -
 hw/vfio/kvm-spapr.c                    |   2 +-
 include/system/kvm.h                   |  14 +
 linux-headers/asm-arm64/hwcap.h        | 159 ++++++++++++
 linux-headers/asm-arm64/kvm.h          |   4 +-
 linux-headers/asm-arm64/ptrace.h       | 337 +++++++++++++++++++++++++
 linux-headers/asm-arm64/unistd.h       |   2 +-
 linux-headers/asm-loongarch/unistd.h   |   6 +-
 linux-headers/asm-mips/unistd.h        |   8 +-
 linux-headers/asm-powerpc/unistd.h     |   4 +-
 linux-headers/asm-riscv/kvm.h          |   4 +-
 linux-headers/asm-riscv/unistd.h       |   6 +-
 linux-headers/asm-s390/unistd.h        |   2 +-
 linux-headers/linux/kvm.h              |   5 +-
 meson.build                            |   2 +-
 scripts/update-linux-headers.sh        |  63 +++--
 target/arm/kvm-consts.h                |   3 +-
 target/arm/kvm.c                       |   2 -
 target/i386/kvm/kvm.c                  |   2 +-
 target/i386/kvm/kvm_i386.h             |   2 -
 target/i386/sev.c                      |   1 -
 target/loongarch/cpu.c                 |   3 -
 target/loongarch/kvm/kvm.c             |   1 -
 target/ppc/kvm.c                       |   2 -
 target/riscv/kvm/kvm-cpu.c             |   2 -
 target/s390x/kvm/kvm.c                 |   2 +-
 target/s390x/kvm/pv.c                  |   2 -
 tests/qtest/migration/framework.c      |   2 +-
 tests/qtest/migration/migration-util.c |   2 +-
 41 files changed, 588 insertions(+), 73 deletions(-)
 create mode 100644 linux-headers/asm-arm64/hwcap.h
 create mode 100644 linux-headers/asm-arm64/ptrace.h

-- 
2.56.0


