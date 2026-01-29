Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120F2D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUVe-0006Fu-Kr; Thu, 29 Jan 2026 11:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlUVX-0006E3-8s
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:04:36 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlUVV-00052R-Ju
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:04:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F3E5360054;
 Thu, 29 Jan 2026 16:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F99C4CEF7;
 Thu, 29 Jan 2026 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769702669;
 bh=unftXSgHWEkxnx4LgC08fLeS+sdR7x3Wrf1OOjEUZyk=;
 h=From:To:Cc:Subject:Date:From;
 b=GYh8EOeH2L6Pus7iG7agZZ68iJuJh4QpwiK/mznAqrDvcqZpA2vH+m94+7zfpT9rl
 tRzZokVQrrrkN41wgtLb8TZJZvbrxT/+Hz3d2sON9UKxbcFgn0y+Bpir7LlaRTjM+b
 jskRebH3ktaxxCGjKZ3gJO0/9C3G436K9h1bI2cYVzBF6GJu+J7UuzuNuF5fG2tszm
 5VWZL/z4ewqauoCYqwZM7pBlT6YbkXEUts48OWf/o/z75xnPmAfHdsc7PwWEIDpMg1
 qNQDgG9ouKpgy+jRQcHypptIoJHMghnXeAax3+0vjO0iDM5Sf1t39ujp5jKhrDUI6j
 bvYH2aWpo2euQ==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlUVP-0000000FNyS-20O4; Thu, 29 Jan 2026 17:04:27 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 John Snow <jsnow@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 0/1] Sync kernel-doc with newest upstrem changes
Date: Thu, 29 Jan 2026 17:04:04 +0100
Message-ID: <cover.1769701431.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

This changeset does a new sync on the top of the Linux Kernel
kernel-doc changes. It is in sync with latest -next, plus
two series I submitted today to linux-doc:

- https://lore.kernel.org/linux-doc/cover.1769673038.git.mchehab+huawei@kernel.org/T/#t
- https://lore.kernel.org/linux-doc/cover.1769701598.git.mchehab+huawei@kernel.org/T/#t

After linux-doc picks my changes and this patch being applied
on QEMU, all differences between QEMU and the Linux Kernel
version will be only at scripts/kernel-doc.py.

With that, syncing from Linux kernel should be as simple as:

	cp <linux_dir>/docs/tools/lib/python/kdoc/*.py scripts/lib/kdoc/

and eventually add any new *.py file that it is there, if any.

The way this changeset works is that, at QEMU's kernel-doc.py
we have two new classes that are derivated from the kernel-doc
ones:

1. class QemuCTransforms(base class: CTransforms).

   The CTransforms class contains Linux-kernel function transform logic.
   all we need for QEMU is to add a new element to one of its lists:

	self.function_xforms += [
            # Add a handler for QEMU macros
            (KernRe(r"QEMU_[A-Z_]+ +"), ""),
        ]

2. class QemuRestFormat(base class: RestFormat):

   The RestFormat class contains the rules to output docs in rest
   format.

   All we need is to override self.highlights for it to use
   the QEMU way to define cross-references, e.g.:
	"#foo", instead of "&foo".

-

That's said, the newest kernel-doc version that this change is
using has gained support for documenting variables as well.

It could make sense to use it to document some global variables
where needed. The CTransforms as one list to do variable transforms
as well, so it could be used to document QEMU specific ways to
define static and extern vars.

Regards,
Mauro

Mauro Carvalho Chehab (1):
  scripts: Import Python kerneldoc from Linux kernel

 scripts/kernel-doc.py                  | 177 +++++++--
 scripts/lib/kdoc/__init__.py           |   0
 scripts/lib/kdoc/enrich_formatter.py   |  80 ++++
 scripts/lib/kdoc/kdoc_files.py         |  37 +-
 scripts/lib/kdoc/kdoc_item.py          |  18 +
 scripts/lib/kdoc/kdoc_output.py        | 120 ++++--
 scripts/lib/kdoc/kdoc_parser.py        | 432 +++++++++++----------
 scripts/lib/kdoc/kdoc_re.py            | 231 +++++++++---
 scripts/lib/kdoc/latex_fonts.py        | 184 +++++++++
 scripts/lib/kdoc/parse_data_structs.py | 498 +++++++++++++++++++++++++
 scripts/lib/kdoc/python_version.py     | 190 ++++++++++
 scripts/lib/kdoc/xforms_lists.py       | 105 ++++++
 12 files changed, 1711 insertions(+), 361 deletions(-)
 create mode 100644 scripts/lib/kdoc/__init__.py
 create mode 100644 scripts/lib/kdoc/enrich_formatter.py
 create mode 100755 scripts/lib/kdoc/latex_fonts.py
 create mode 100755 scripts/lib/kdoc/parse_data_structs.py
 create mode 100644 scripts/lib/kdoc/python_version.py
 create mode 100644 scripts/lib/kdoc/xforms_lists.py

-- 
2.52.0


