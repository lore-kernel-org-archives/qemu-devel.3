Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D94CD1290
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq97o-00024O-Tr; Fri, 29 Mar 2024 06:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97n-00023V-2M
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:15 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97k-00015d-9M
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711706772; x=1743242772;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=USSSIVCjPSbOtnv4n93fr+Nx0gEISVP5OpWqSlGRleE=;
 b=ReJL7A1CHQjjQ/4ETxlC7YhJhgwWOLWmcs7hbIJLOOwE8hy10SGKsXGm
 WQ28cdW4yL8rUzVl5t682D9zV+6wVz0Y6ph+xNPKfuSMycc+l4z6cLaZ5
 V8CJNgEfeU1lU0pu0a5xSb0i2fSx7dDmKYPIjmFK/mAn7qIRSlEOlhPi6
 zwEY302QF5Qbbbn8M6mrP+j/e3Mp3jngyPaFRK1UyvGhZJxAqXHJ/hmVP
 kCB7k1sGRF2GuqhDLae2TWy4aRonl4b964ROflRYtEZIbymHIURx7iKaP
 LdYVMzHtxhAah+48Z4yepPO+TCb7c4X1r/fPP04pErLPD110h+Cm305fl g==;
X-CSE-ConnectionGUID: c0XuI374SzivMrV2Ij1pag==
X-CSE-MsgGUID: YDxi1VhhQsKkKYRpU+Ivjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17519173"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="17519173"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 03:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="21441940"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Mar 2024 03:06:04 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for-9.1 0/7] target/i386/kvm: Cleanup the kvmclock feature name
Date: Fri, 29 Mar 2024 18:19:47 +0800
Message-Id: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Hi list,

This series is based on Paolo's guest_phys_bits patchset [1].

Currently, the old and new kvmclocks have the same feature name
"kvmclock" in FeatureWordInfo[FEAT_KVM].

When I tried to dig into the history of this unusual naming and fix it,
I realized that Tim was already trying to rename it, so I picked up his
renaming patch [2] (with a new commit message and other minor changes).

13 years age, the same name was introduced in [3], and its main purpose
is to make it easy for users to enable/disable 2 kvmclocks. Then, in
2012, Don tried to rename the new kvmclock, but the follow-up did not
address Igor and Eduardo's comments about compatibility.

Tim [2], not long ago, and I just now, were both puzzled by the naming
one after the other.

So, this series is to push for renaming the new kvmclock feature to
"kvmclock2" and adding compatibility support for older machines (PC 9.0
and older).

Finally, let's put an end to decades of doubt about this name.


Next Step
=========

This series just separates the two kvmclocks from the naming, and in
subsequent patches I plan to stop setting kvmclock(old kcmclock) by
default as long as KVM supports kvmclock2 (new kvmclock).

Also, try to deprecate the old kvmclock in KVM side.

[1]: https://lore.kernel.org/qemu-devel/20240325141422.1380087-1-pbonzini@redhat.com/
[2]: https://lore.kernel.org/qemu-devel/20230908124534.25027-4-twiederh@redhat.com/
[3]: https://lore.kernel.org/qemu-devel/1300401727-5235-3-git-send-email-glommer@redhat.com/
[4]: https://lore.kernel.org/qemu-devel/1348171412-23669-3-git-send-email-Don@CloudSwitch.com/

Thanks and Best Regards,
Zhao

---
Tim Wiederhake (1):
  target/i386: Fix duplicated kvmclock name in FEAT_KVM

Zhao Liu (6):
  target/i386/kvm: Add feature bit definitions for KVM CPUID
  target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
    MSR_KVM_SYSTEM_TIME definitions
  target/i386/kvm: Only Save/load kvmclock MSRs when kvmclock enabled
  target/i386/kvm: Save/load MSRs of new kvmclock
    (KVM_FEATURE_CLOCKSOURCE2)
  target/i386/kvm: Add legacy_kvmclock cpu property
  target/i386/kvm: Update comment in kvm_cpu_realizefn()

 hw/i386/kvm/clock.c       |  5 ++--
 hw/i386/pc.c              |  1 +
 target/i386/cpu.c         |  3 +-
 target/i386/cpu.h         | 32 +++++++++++++++++++++
 target/i386/kvm/kvm-cpu.c | 25 ++++++++++++++++-
 target/i386/kvm/kvm.c     | 59 +++++++++++++++++++++++++--------------
 6 files changed, 99 insertions(+), 26 deletions(-)

-- 
2.34.1


