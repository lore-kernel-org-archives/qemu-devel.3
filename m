Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6371FE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvGo-0003dJ-CE; Thu, 26 Dec 2024 16:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGm-0003ci-SY
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:48 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGk-0002vr-Kx
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:48 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 75BB713801CD;
 Thu, 26 Dec 2024 16:19:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 26 Dec 2024 16:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1735247983; x=1735334383; bh=9T
 fa1rDNwXRupn9JzeRFLaFDM4uveGgn0m7nX3vBjdQ=; b=R7LP437+PAJlLYZVnv
 pK2g5qafm1bzrYp93aldwzt8dZlsqrnT/F+zVf98JeUnjOr1Wcc1Mk2OUDvdhZmR
 iMmf4j1UF4INWeO0ZCCMKp9BeZZpCiBubIHfsr1FyTAfbWJ4c5hSkt5mQYXFCMvY
 d4akgrzveGAIk/8cK5iGiKElugxkL8vGOl6mv12xotR4NTJynOTpObncp+7KxxMc
 WuUZRw0NpBNbZN5KVnvHoyTad8QlSPebaplULGu3jQ6kOrBnPlidRz920OZT3lkW
 fXtb7Ljzct7E9rZQFnRDvNB4WWEbstzAxIFHetIBoYK4cMmzTCo+o6AiKjazmkhs
 azGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1735247983; x=1735334383; bh=9Tfa1rDNwXRupn9JzeRFLaFDM4uv
 eGgn0m7nX3vBjdQ=; b=cqUuOGfGgh5ghGg2aWeDkX4lJVGYw/AcV+9uHfQmESDU
 8ACs1ymK0NtEiAY2xliGKdLARCUEEduCJGiFtqcSvsh3x7FoEhdYH0apQOLWPS+o
 6Q/F4gCjG89xQm+wgWG52FU2uBcYIowHM9CqAA5T6PAL8LxZ92nrFq4bmI5vtOmd
 D/T0kN046Uu/HPn2sozBMJ6DTFLO73qVFEHVc9hkKHe79aIiWTHTupZiH8Qx8X2A
 FzmLOlyaX/4av3MX0Wxfj3o3rTLxj/xZgy8Egzyw00pa/I5f2g9I4iro5jycfjOY
 LL8MxUxAxPXHGAAm7K2io7V/cO7Rm47yuhUylnBN/g==
X-ME-Sender: <xms:bchtZwVSsncurSKfDVBP6vwBo5adED9EnGEk9a-3Y4WM7nBjCfFiTQ>
 <xme:bchtZ0mGL2fWmt9VnZqjKOhuO8uDXKXMOhgAkiCXi2mVW-RBpsiEw4LsPEyauC8Fb
 YmjpEAyR3SqFqFIjJA>
X-ME-Received: <xmr:bchtZ0YbjrK8wysfTnNj7ItzgRM_TDTOYpTXc-alDbMY0E_EK_f5Vtnx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
 ucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihgh
 horghtrdgtohhmqeenucggtffrrghtthgvrhhnpefgveffjeetgeejfeelgfekteelkefh
 uefggedvueeujeekjeetkeekvdffffefudenucffohhmrghinhepkhgvrhhnvghlrdhorh
 hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohepuddvpd
 hmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghosghisghosehlohhonhhgshho
 nhdrtghnpdhrtghpthhtohepmhgrrhgtvghlrdgrphhfvghlsggruhhmsehgmhgrihhlrd
 gtohhmpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphht
 thhopehgrghoshhonhhgsehlohhonhhgshhonhdrtghnpdhrtghpthhtohepvggslhgrkh
 gvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhih
 ghhorghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdroh
 hrghdprhgtphhtthhopeifrghnghihrghnrghnheehsehhuhgrfigvihdrtghomhdprhgt
 phhtthhopeiihhgrohdurdhlihhusehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:bchtZ_XsbdB3pK_Jq1UBZ7xFESoKNdwkTS80JIWLfoK88aF2pR9neg>
 <xmx:bshtZ6nG0aVPDnOn0uIBG88I37hNoF9jCQPBQ4oxypntnkFW7ryNvA>
 <xmx:bshtZ0cIgEW2uH2Dhoq8atct3ACnwKtKcR4MoD7nKONvfhEko_lCig>
 <xmx:bshtZ8HhBEUPCMpIy1oBZG66dXwx7DBa_qkAVEeJJEw7kmxUMNJ4ww>
 <xmx:b8htZ1_UIOJSw-lzVFtumfK005__CJZyjc9NgNV3vVjAzlZ9dFIexLGT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:40 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 00/23] target/loongarch: LoongArch32 fixes 1
Date: Thu, 26 Dec 2024 21:19:31 +0000
Message-Id: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPIbWcC/22MwQ6DIBAFf8XsuTSwUoo99T8aDwirklgxYEyN4
 d9LPfc472XmgETRU4JHdUCkzScf5gJ4qcCOZh6IeVcYkKMUiMgmUyPr/YeSYLXS1grpeKMVFGO
 JdD5FeLWFR5/WEPczvonf+r+zCcaZtgq7O90a6bpnP+1DMOvVhje0OecvPyLAs6gAAAA=
X-Change-ID: 20241222-la32-fixes1-368cc14d0986
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4602;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=qkAwBPvCGYmgd2GcEqE5EO56ATPfJyQyIj1xUYeSbz8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9ludlrhCs861Q5kbDrJeLt4mmronnbOB3H7JM4UB
 DxgX/C3o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZido+R4X/i//ymFsUXZ9mX
 n8j39Elgd1V//WIi78ZPS+aqfM45e52R4UbmP8GHbB8vfVu0fYW2UlnExd6Ai2ou7W+EnLtq4v7
 28gMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

It's boxing day so time to dump big stuff!

This series is a collection of small fixes I made to TCG for
getting LoongArch32 build to work.

There are still many thing broken, especially on CSRs. More
series following. A brief todo would be:
- Refactoring CSR handling to perform sign extention and handle RO
  fields.
- Refectoring TLB code to allow MTLB only configuration as well as
  special TLBELO format for LA32.
- Check instruction availability for LA32R.
- Handle LA32R priviliged modifications.

LoongArch maintainers, feel free to take subsets as most patches
in this series don't have dependency on each other, and I don't
want to take a pile of patches time by time.

There is a checkpatch error in trans_vec.c.inc inherited from
existing code style.

Thanks for revivewing!

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Dump all patches made ready so far.
- Split LLSC patch into two (Richard, philmd)
- Link to v1: https://lore.kernel.org/r/20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com

---
Jiaxun Yang (23):
      target/loongarch: Enable rotr.w/rotri.w for LoongArch32
      target/loongarch: Fix address generation for gen_sc
      target/loongarch: Fix PGD CSR for LoongArch32
      target/loongarch: Perform sign extension for IOCSR reads
      target/loongarch: Use target_ulong for iocsrrd helper results
      target/loongarch: Store some uint64_t values as target_ulong
      target/loongarch: Cast address to 64bit before DMW_64_VSEG shift
      target/loongarch: Fix some modifiers for log formatting
      target/loongarch: Use target_ulong for CSR helpers
      target/loongarch: Scrutinise TCG float translation for 32 bit build
      target/loongarch: Scrutinise TCG vector translation for 32 bit build
      target/loongarch: Scrutinise TCG bitops translation for 32 bit build
      target/loongarch: Fix rdtimer on 32bit build
      target/loongarch: Scrutinise TCG arithmetic translation for 32 bit build
      target/loongarch: Fix load type for gen_ll
      target/loongarch: Define address space information for LoongArch32
      target/loongarch: Refactoring is_la64/is_va32 for LoongArch32
      target/loongarch: ifdef out 64 bit CPUs on 32 bit builds
      target/loongarch: Introduce max32 CPU type
      hw/loongarch/virt: Default to max32 CPU for LoongArch 32 build
      qapi/machine: Replace TARGET_LOONGARCH64 with TARGET_LOONGARCH
      target/loongarch: Wire up LoongArch32 Kconfigs
      config: Add loongarch32-softmmu target

 MAINTAINERS                                        |   4 +-
 configs/devices/loongarch32-softmmu/default.mak    |   7 +
 configs/targets/loongarch32-softmmu.mak            |   7 +
 hw/loongarch/Kconfig                               |   2 +-
 hw/loongarch/virt.c                                |   4 +
 qapi/machine-target.json                           |   8 +-
 target/loongarch/Kconfig                           |   3 +
 target/loongarch/cpu-param.h                       |  12 +-
 target/loongarch/cpu.c                             | 194 ++++++++++++++++-----
 target/loongarch/cpu.h                             | 150 ++++++++--------
 target/loongarch/cpu_helper.c                      |   2 +-
 target/loongarch/helper.h                          |  22 +--
 target/loongarch/machine.c                         | 120 ++++++-------
 target/loongarch/tcg/csr_helper.c                  |   2 +-
 target/loongarch/tcg/insn_trans/trans_arith.c.inc  |  25 ++-
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc |   8 +-
 target/loongarch/tcg/insn_trans/trans_bit.c.inc    |  34 ++--
 target/loongarch/tcg/insn_trans/trans_extra.c.inc  |   8 +-
 target/loongarch/tcg/insn_trans/trans_farith.c.inc |  53 +++---
 target/loongarch/tcg/insn_trans/trans_fcmp.c.inc   |  16 +-
 .../loongarch/tcg/insn_trans/trans_fmemory.c.inc   |  34 ++--
 target/loongarch/tcg/insn_trans/trans_fmov.c.inc   |  83 ++++-----
 target/loongarch/tcg/insn_trans/trans_shift.c.inc  |   4 +-
 target/loongarch/tcg/insn_trans/trans_vec.c.inc    |  70 ++++----
 target/loongarch/tcg/iocsr_helper.c                |  20 +--
 target/loongarch/tcg/op_helper.c                   |   4 +-
 target/loongarch/tcg/tlb_helper.c                  |   2 +-
 target/loongarch/tcg/translate.c                   |  11 +-
 28 files changed, 537 insertions(+), 372 deletions(-)
---
base-commit: 65cb7129f4160c7e07a0da107f888ec73ae96776
change-id: 20241222-la32-fixes1-368cc14d0986

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


