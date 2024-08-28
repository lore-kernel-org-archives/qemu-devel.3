Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8ABC54EDA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjGje-00017s-Kp; Wed, 28 Aug 2024 07:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sjGjc-00016Z-GO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:21:08 -0400
Received: from rn-mailsvcp-mx-lapp03.apple.com ([17.179.253.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sjGja-0002W7-TF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:21:08 -0400
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by rn-mailsvcp-mx-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SIX0085RDYPT400@rn-mailsvcp-mx-lapp03.rno.apple.com>
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 04:16:01 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version : subject
 : to; s=20180706; bh=JOJm/4lOlsmVlEbjUhnhrCOdGKorOCCDRQbj1exZWrg=;
 b=LE6BQ+LqRzEbMlUf+ES+xCjVYy4lXQYgowqhyeMfo+ug/VviJd6ojcCn3hhT0S0aDVbj
 /XG8Mt4vJ5fRmJ0krA+qOUZ3h3b7a9+RrgAl+oZP/7MYd0QcvUu4eWNXg9ffN3bJX0IE
 2TmiHtjR51YU3sYgZYM31ifbKmCpNaBHA24VpM9OakNML1foFw83qGYOw7K5iQLMZu5V
 tcwylCn867Absu8gPNcwD6O2iVeqypLXZxMQpgqEa/yZF7BwLRAFPP1CCsreBJN291NY
 XesAajyqJOyC0/Ce9bsOII0u74igjOBDRo6hD2q4uvisMAyVhL5ydsE9vXSNTqDWDNbk 4g==
Received: from mr55p01nt-mmpp02.apple.com
 (mr55p01nt-mmpp02.apple.com [10.170.185.213])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SIX00TAPDYKD2G0@rn-mailsvcp-mta-lapp03.rno.apple.com>; 
 Wed, 28 Aug 2024 04:15:57 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp02.apple.com by
 mr55p01nt-mmpp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SIX2GG00DAAEB00@mr55p01nt-mmpp02.apple.com>; Wed,
 28 Aug 2024 11:15:56 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 18a8a04ab20a1763aa377ff80017b310
X-Va-E-CD: 48d6300b3347b37c06ba4ce56f7a1df6
X-Va-R-CD: 757d58d0173110a31b814f032dff5ba2
X-Va-ID: eb5b3983-04fb-4599-ad7e-67f3c342bfcf
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 18a8a04ab20a1763aa377ff80017b310
X-V-E-CD: 48d6300b3347b37c06ba4ce56f7a1df6
X-V-R-CD: 757d58d0173110a31b814f032dff5ba2
X-V-ID: 9ade30f9-6d5e-4c81-aae3-fcd08fea6f0b
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
Received: from Mac.apple.com ([17.11.139.69]) by mr55p01nt-mmpp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SIX2GJ1IDYJB800@mr55p01nt-mmpp02.apple.com>; Wed,
 28 Aug 2024 11:15:56 +0000 (GMT)
From: Danny Canter <danny_canter@apple.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, agraf@csgraf.de,
 peter.maydell@linaro.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 danny_canter@apple.com
Subject: [PATCH v2 0/3] hvf: arm: Support creating VMs with 64+GB of RAM on
 macOS 15+
Date: Wed, 28 Aug 2024 04:15:49 -0700
Message-id: <20240828111552.93482-1-danny_canter@apple.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-version: 1.0
Content-transfer-encoding: 8bit
Received-SPF: pass client-ip=17.179.253.24;
 envelope-from=danny_canter@apple.com; helo=rn-mailsvcp-mx-lapp03.apple.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchsets focus is on lighting up the ability to create VMs with 64+GB
of RAM through using some new APIs introduced in macOS 13. Due to the IPA sizes
supported in macOS, the first version we can properly support this requirement
is macOS 15 as (if the hardware supports it also) the kernel adds support for a
40b IPA size, which is the first supported ARM PARange value after 36b, so we
can advertise this to the guest properly as well in id_aa64mmfr0_el1.

Today if you asked for a > 64GB VM you'd be met with a pretty unwieldy
HV_BAD_ARGUMENT. On machines without 40b IPA support this patchset also
improves this, and the message mirrors the kvm_type error you'd get on ARM:

"qemu-system-aarch64: -accel hvf: Addressing limited to 36 bits, but memory
exceeds it by 18253611008 bytes"

Changes from V1 to V2 (Thanks Peter for review!):

- Added a new function pointer to MachineClass to be able to freeze the memory
map and compute the highest guest physical address. We use this to inform VM
creation on what IPA size we should ask the kernel for. This is very similar to
what ARM's kvm_type() does.

- Fixed redundant loop in `round_down_to_parange_bit_size`

- Move the splitting up of hv_vm_create logic per platform to a separate patch.
This is mostly for readability.

Danny Canter (3):
  hw/boards: Add hvf_get_physical_address_range to MachineClass
  hvf: Split up hv_vm_create logic per arch
  hvf: arm: Allow creating VMs with 64+GB of RAM on macOS 15+

 accel/hvf/hvf-accel-ops.c | 16 +++++++---
 hw/arm/virt.c             | 42 ++++++++++++++++++++++++-
 hw/i386/x86.c             |  2 ++
 include/hw/boards.h       |  5 +++
 include/sysemu/hvf_int.h  |  1 +
 target/arm/hvf/hvf.c      | 66 +++++++++++++++++++++++++++++++++++++++
 target/arm/hvf_arm.h      |  3 ++
 target/arm/internals.h    | 19 +++++++++++
 target/arm/ptw.c          | 15 +++++++++
 target/i386/hvf/hvf.c     |  5 +++
 10 files changed, 168 insertions(+), 6 deletions(-)

-- 
2.39.5 (Apple Git-154)

