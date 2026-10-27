Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spgnSRw5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf6V-0002l0-Pr; Tue, 27 Oct 2026 07:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf6U-0002kZ-R6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:12:30 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf6S-0002oX-Sh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:12:30 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-156cbe59622so3348297c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099547; x=1793704347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hzZbDFZM/UYJO7c6bpSnID+Nzy+oI4pCYhor9frfI5Y=;
 b=spgnSRw5Tplr2bofpKU2EikdZXwF9n17BTP+ihVJ0iN+QE6k8jCzvR6ZQ1ol0sfAkL
 tEW+hNeOp5xilIaRLlnHS/BcxPpMrfVVUZgDq24tkhneXRhBu8IRHds4wE7WHx5+utv7
 10+6ImETfc+3F2ujVMGFXVFo2H8BJYcVclXuucBWs7wUr5o5POCeDZXh2tWePsoDhnI6
 olxEvOS4Mz/j8xGS0beNLzBBnddHRLWmARK3r4zbqBBP4X9vxpyy9nEVwcFzzpDJH6pc
 4mRZU8theSd1y43JnI2cE3cZtos3b7pTTmeuM46CqzSbMo6fCY1EBU6bBeALgMOmBjB+
 4qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099547; x=1793704347;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzZbDFZM/UYJO7c6bpSnID+Nzy+oI4pCYhor9frfI5Y=;
 b=NbSJwq+57Ei6MXKghLPqC0W/w0tzZUDm3mjKLVTeA8aEeQx/Tco59SyakKLmo3Fs0g
 sWSk97C1rA9noT442dxcBfIU2XYHa2u6sG58WzItifeAAlWexOnQKEzBlIH4VPIpir/l
 vjJ09apUxNN2H813+yxLlpeqqXZk2a2tiVXT/lcIsRD22A3lnvdk1/Hkc8mUGIz4BAzn
 LMkZDx2c40LnrcrMsYRjI7GH8voOG6kA7sXwnVFqRljXLS2ZaEH0GN7VzP1WcrGoZ1PF
 DzO/IHDMJWgG4RkGefdZgS4sZCIoL14uiZVk4XWFrQSFcwbh4W9VKBlsduus70hAlXO0
 ZnWQ==
X-Gm-Message-State: AFq9FYJuCuQNqVEsWXqL7PJQTldGEyw11u7mdXjgzmJTlKi/A7+J3eF1
 WWShxigW7iFJFQ+8YqWK6mmD4v68TVHD/ZCTFtfHtOuLknCOny6GKmuu4rrIICf4
X-Gm-Gg: AYBFou3ggYlCSA6SJGpPI4UmMmPtrfOGCoMb1TPKGDE636pjNRbXprm1gQnySJRY7o/
 qMCe2VS4wTBjGmvJFGCGmvOVpbFAMHWbcuNtfaJuygHC0eTFNWL0wrNAE6LFrVVXmz2vjVXop1W
 NSanmsIh1XSaE05MG0gXidYOUbJf3u2fUdfaBBGqTFJFRK0k7oJQORsMqy9wV0KlHWgVqbnSgJ/
 by6krw0DvnfuOaPS2W1H0e7843oUsgcC1fCkeUL1NEOSs1O4mOr66iH/wIIyaZK562me/Ka6mga
 BYl2GUJCFguUHszoNQL+fcBcP7wTBVVEeid4dJV4t5ZVxTSQ5O4VpFkUxZuvgAkiobZObT+rCE/
 3IF+j7m0jSkcsREVq5YSwjbW0D1Jiu/a6Hi2Gfg+DHiooFYF4mUKQzjTiNKbhgkgFAqx54x7fTs
 iUzeLY/2hI4hGOAvivyZbwUkPpU1/JsftyIyESSij1152VNPUDJScjP5FdxcGgMxS0r37X+UxbW
 C03kWKtJ//lxOWoLH27lHt79FcAgmdO78mRli5CbMlDNMdEXZi42GGokAh5oJ0MUC3eyqoqDwgZ
 LAf++bt6a+LQ
X-Received: by 2002:a05:7023:889:b0:152:9e88:daaa with SMTP id
 a92af1059eb24-19936e34cafmr14125662c88.36.1793099546945; 
 Tue, 27 Oct 2026 04:12:26 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:12:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eric Blake <eblake@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 00/17] machine: uniquify virt QOM names
Date: Tue, 27 Oct 2026 19:11:58 +0800
Message-ID: <20261027111216.392-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Multiple targets register a virt board as MACHINE_TYPE_NAME("virt").
Those QOM types collide if more than one board is linked into one
qemu-system process. This series splits the QOM type from the -M name
so each virt board can keep a unique type while -M virt, help, and
migration stay the same.

- Add machine_class_set_name() so boards can set MachineClass::name
  when it must differ from the QOM type. machine_class_base_init still
  defaults the name to the QOM type without -machine. Document that
  MachineClass::name is the -M name, not the QOM type. Sort -M help
  by that name so order matches the printed names after types are
  prefixed (arm-virt-11.1-machine vs virt-11.1).
- When target_heterogeneous() is true, give each colliding virt board
  a unique QOM type and keep the existing -M name via
  machine_class_set_name(): riscv-virt, arm-virt, or1k-virt,
  hexagon-virt, loongarch-virt, m68k-virt, and xtensa-virt. Otherwise
  keep virt. Versioned ARM, LoongArch, and M68K boards keep virt-<ver>. Latest
  ARM virt still sets mc->alias to virt.
  This is for the review from Daniel:
  Link: https://lore.kernel.org/qemu-devel/ar_dK-_KUS3h2dkL@redhat.com/
- query-machines returns MachineInfo typename, the QOM type from
  object_class_get_name(), for qom-list-properties. The -M name alone
  is not that type once virt boards are prefixed.
- Use target_heterogeneous() from the base. It still returns false, so
  qemu-system-<target> keeps the QOM type virt.

Changes v3 -> v4:
Rebased onto d73149283205645625bfa9fe029cfb68e4c4a9ae, which already
includes target-info: add target_heterogeneous. The boards.h example
uses arm-virt only when that returns true.

Changes v2 -> v3:
The versioned-machine example in boards.h now follows hw/arm/virt.c.
machine_class_set_name() keeps the -M name as virt-<version>, the QOM type in
the example is arm-virt, and the latest helper is DEFINE_VIRT_MACHINE_AS_LATEST.

Changes v1 -> v2:
- query-machines returns MachineInfo typename. v1 returned only the
  -M name, so a client that appended "-machine" looked up the wrong
  type for a prefixed board such as arm-virt-11.1-machine versus
  -M virt-11.1.

Yonggang Luo (17):
  hw/riscv/virt: move virt TypeInfo into its type_init
  hw/arm/virt: move virt TypeInfo into its type_init
  hw/or1k/virt: move virt TypeInfo into its type_init
  hw/hexagon/virt: move virt TypeInfo into its type_init
  hw/loongarch/virt: move virt TypeInfo into its type_init
  hw/m68k/virt: move virt TypeInfo into its type_init
  hw/xtensa/virt: move virt TypeInfo into its type_init
  machine: allow -M name to differ from QOM type
  hw/riscv/virt: use unique QOM name
  hw/arm/virt: use unique QOM name
  hw/or1k/virt: use unique QOM name
  hw/hexagon/virt: use unique QOM name
  hw/loongarch/virt: use unique QOM name
  hw/m68k/virt: use unique QOM name
  hw/xtensa/virt: use unique QOM name
  qapi: return MachineInfo typename from query-machines
  machine: match the versioned virt example to arm virt

 hw/arm/virt.c               | 53 ++++++++++++++++--------------
 hw/core/machine-qmp-cmds.c  |  1 +
 hw/core/machine.c           |  6 ++++
 hw/hexagon/virt.c           | 21 +++++++-----
 hw/loongarch/virt.c         | 44 +++++++++++++------------
 hw/m68k/virt.c              | 37 ++++++++++++---------
 hw/or1k/virt.c              | 20 +++++++-----
 hw/riscv/virt.c             | 26 +++++++--------
 hw/xtensa/virt.c            | 20 ++++++++++--
 include/hw/arm/virt.h       |  5 ++-
 include/hw/core/boards.h    | 39 ++++++++++++++++------
 include/hw/hexagon/virt.h   |  5 ++-
 include/hw/loongarch/virt.h |  5 ++-
 include/hw/riscv/virt.h     |  5 ++-
 qapi/machine.json           |  6 +++-
 system/vl.c                 |  8 ++---
 tests/qtest/qom-test.c      | 65 +++++++++++++++++++++++++++++++++----
 17 files changed, 247 insertions(+), 119 deletions(-)

-- 
2.52.0.windows.1


