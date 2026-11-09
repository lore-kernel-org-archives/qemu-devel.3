Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DB606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FIFtSbNX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXtt-0005E3-HI; Mon, 09 Nov 2026 17:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtb-0005BX-Bg
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:27 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtU-0003lM-Ga
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:20 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8b66d1a08ccso1312577b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263473; x=1794868273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Xvf9o4c8oUpaT9noZn7hIYvZqZxntXJddruExxf9kQ=;
 b=FIFtSbNXDfkkmn6vKcI/aeqFKmihrLN/FHr1HG3ePhZ+y5Ya5u2RvkGAXYfVKKLLgh
 zqSGN32Hwv6RosfWN6licrDrQUI6OqoZDbKI8l/DIsGNbXshPaoa1aiToRmjxxaeMbpR
 8Sh7Evyrh1ieDfTjPfNy7zNXB4A6zjGNPwRXGSv4sS791cAmtjnMHyYTj+vjYUS2840t
 STtN9exz8AC84q8zhvC9xUqSQ7heqW7mwIzE0uLvG24BloPQIYOdAL5daATZAR9J3eeb
 ER/+Op+R0iHScLiFEg4W+VUH70NXNtuzOiGmS6aNz7A/sPUz5R9wipBhGrecbhfrL0vC
 /ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263473; x=1794868273;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Xvf9o4c8oUpaT9noZn7hIYvZqZxntXJddruExxf9kQ=;
 b=E0U4ubZElIu+yDIz6cBTtKiz05QKrq7JDdAl9yRgbkA5cr2FnI/5xOxi+bXgYKzznN
 yV7Z04agwpL8GSVF2kanbiN3cdPn3qBg14vNfxBglG1tdOGC/Cz/eOe4/x2A9t6Iunu3
 h03nWp//9JXqGo7ds0UJk4DIihjdV7ZqgqJ1m1h02JqVtbZwZFxvJCBGI8XYZciw7qFp
 xNEDluj39fdQJyicmfai17axXE6HBtwCIL8iLgT4YO+h513yGIUVf/IbJo1jc0cAHHep
 JeotTBlQa+4vFO5sly+eJBkGoxmrjBtHrg2VXNKEDOUkm2eohaLletry85ZbIqWYVsjj
 Xm9A==
X-Gm-Message-State: APuU4Z82EL1CBui4X1B69VDcH7sjOUsCl/Jn5duOWMgipbXaDrypD48M
 bYarBgE9hfD8BhmTwyL63B+EbgPw3un+PHwKBkOX+FSjvzY2HZMmIt+guKmj8mNAPZg=
X-Gm-Gg: AYBFou20Iv7d+gpprpCd++jqH4YYOebh1K5kiT93/6pMycdbm7PkR4IEfu/YhKGeRDo
 ndUy6CBNbY2sH+mPKKDyg8jVRdgcmsp8jQrR3IW6kQtXLmUyn4KeCba3dyyPtpM9IbfIeGiqkG7
 FMr1oBPUiFcGGq4bq/mXYddPXf7Tkf07ImSzawxbGVT2FzDVnuO0TLILtIn77CN+njZcvq/NW4N
 1Jfn0m6d2fkCWAm14psX1O6Yhl0txYSyt4uLzN9UJjN3CDfRwHfIg+FLAI9eFGVuPKfDYGc6D6M
 fQJ0qN9wtJSw8l+rdkGauKxRMtHkxLnzZSAwuLLrmylYB+JsOZsO2eCV/O8Mj1wUynQgbOqNVT8
 99pCJv17YTFY3uW3XWBq83oR2tTtPu/vqv51YIqtVYEyAAV1/ckqbwROw5AJpJM0LcPoFk/D+5x
 5OAVzYX3tYMMghlWiYidxSn7IEJXzz+2l5w40zNYqX+jvlKv38Bq/Qa0bFhZpe3GZhl/0P80yAJ
 aanhVUpmOqZA62RVOtm3rX5mPly0ShVvD72gSBpMiJORVFOxmOTNj1V0DclpFIx7nqaQaZ+IdTQ
 cUehYe6CZHqlQWBwZYHPHRCwTZ+YfeDFY+oUapyKkNVJaNGGfT60LZQ=
X-Received: by 2002:a05:6a00:b48:b0:8b5:a10a:a3e7 with SMTP id
 d2e1a72fcca58-8ba8773db51mr952190b3a.49.1794263472480; 
 Mon, 09 Nov 2026 14:31:12 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:11 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 00/23] Add Realm support to QEMU-VMM
Date: Mon,  9 Nov 2026 16:30:47 -0600
Message-ID: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patchset provides minimal functionality to start a Realm VM
from an Arm RME capable host using the following command line:

qemu-system-aarch64 \
 -M confidential-guest-support=rme0,memory-backend=ram0 \
 -object rme-guest,id=rme0 \
 -object memory-backend-memfd,id=ram0,size=1G,share=on \
 -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
back.  It is based on Steven Price's latest work [1] and the integration branch
that comes with it.  It is also compatible with Michael Roth's third revision of
his work on guest-memfd convert-in-place [2], rebased to QEMU master.

It was tested on the QEMU SBSA machine.

For convenience a repository is hosted here [3], along with the TF-A [4],
RMM [5] and kernel [6].  Instructions to compile and run the entire stack are
here [7].

Gavin raised a number of relevant issues in this post [8].  Due to the time
needed to look at each and the importance to keep up with the latest kernel
work [1], those issues have not been included in this release.  They will be
discussed further on the mailing list and addressed in upcoming releases if
need be.

[1]. https://lore.kernel.org/kvm/20261102141304.126883-1-steven.price@arm.com/  
[2]. https://lore.kernel.org/kvm/20261007134323.1606088-1-michael.roth@amd.com/
[3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v6?ref_type=heads
[4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v20?ref_type=heads
[6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v6?ref_type=heads
[7]. https://gitlab.com/Linaro/cca-public/build-instructions/-/tree/upstream-v6?ref_type=heads
[8]. https://lore.kernel.org/kvm/20260903193611.1058589-1-mathieu.poirier@linaro.org/T/#ma596f1f403f045262a39cbddd796349eb7d02e63


RFC v5: https://lore.kernel.org/kvm/20261002202026.1204110-1-mathieu.poirier@linaro.org/
RFC v4: https://lore.kernel.org/kvm/20260903193611.1058589-1-mathieu.poirier@linaro.org/
RFC v3: https://lore.kernel.org/kvm/20260825220101.3443954-1-mathieu.poirier@linaro.org/
RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html

Changes for V6:
- Several code alignment fixes (Gavin)
- Use MACHINE()->cgs instead of dedicated function (Gavin)
- Code simplifications and imporvements in several places (Gavin)
- Fixed changelog [06/23] (Enju)
- Respect alignement constraints when images are transferred to Realms (Gavin, Lorenzo)
- New patch [08/23] to set t he KVM_CAP_ARM_PSCI_0_2 extension (Lorenzo)

Jean-Philippe Brucker (20):
  [NOT-FOR-MERGE] linux-headers: Add RME related definitions
  target/arm: Add confidential guest support
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch Realm VM when requested
  target/arm/kvm: Use kvm_vm_check_extension() where necessary
  target/arm/kvm-rme: Keep track of images loaded in Realm memory
  target/arm/cpu: Set number of breakpoints and watchpoints in KVM
  target/arm/cpu: Set number of PMU counters in KVM
  target/arm/cpu: Don't read Realm registers
  hw/arm/virt: Set proper conduit method for Realms
  hw/arm/virt: Embed Realm VM type with IPA address space
  hw/arm/virt: Reserve one bit of guest physical address for RME
  hw/arm/virt: Disable DTB randomness for confidential VMs
  hw/arm/virt: Move virt_flash_create() to machvirt_init()
  hw/arm/virt: Use RAM instead of flash for confidential guest firmware
  target/arm/kvm-rme: Add DMA remapping for the shared memory region
  docs/interop/firmware.json: Add arm-rme firmware feature
  hw/arm/boot: Load DTB as is for confidential VMs
  hw/arm/boot: Skip bootloader for confidential guests

Lorenzo Pieralisi (1):
  target/arm/kvm: Add support for PSCI 0.2 to 'features' flag

Mathieu Poirier (2):
  target/arm/kvm-rme: Add mechanic to initialize realms
  target/arm/kvm-rme: Populate Realm with runtime images

 docs/interop/firmware.json                 |   5 +-
 docs/system/arm/virt.rst                   |   9 +-
 docs/system/confidential-guest-support.rst |   1 +
 hw/arm/boot.c                              |  70 +++-
 hw/arm/virt.c                              | 142 ++++++--
 hw/core/loader.c                           |  24 ++
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/core/loader.h                   |  14 +
 linux-headers/linux/kvm.h                  |  18 +-
 qapi/qom.json                              |   1 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu.h                           |   7 +
 target/arm/cpu64.c                         | 135 +++++++
 target/arm/kvm-rme.c                       | 395 +++++++++++++++++++++
 target/arm/kvm-stub.c                      |   4 +
 target/arm/kvm.c                           | 198 ++++++++++-
 target/arm/kvm_arm.h                       |  10 +
 target/arm/meson.build                     |   5 +-
 20 files changed, 1005 insertions(+), 50 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.53.0


