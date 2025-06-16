Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DEDC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRC3y-0006p5-Fc; Mon, 16 Jun 2025 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uRC3w-0006ou-SF
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:47:56 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uRC3u-00030G-R0
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:47:56 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 3E7A91551
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1750088840;
 cv=none;
 b=EYcGu6jDvYIgHuKZ+OvL2OYisvo7qgdLy1NQjA0losdQSkJm5/bUOs8qwocQh7/RgqGS1msJ/0R08WJhUT2QP6tdFJSr3hg0E1LyU+fsRUOp2JZOPbTU6C5GOysIhp78xVfXYUd7lyvujTPNVTTF4z2Tg4JlhUmMMlxfjRNR9g6rt7Qh+IpUBe2KodsQrgudpHm9OpUqwnYcsHbXy7bL9sTwasGnNrVoRS3BV5vpe4TnsguJq0AjQLvyfCHtjzSjUtRgX76Zr+YAIb+vJy9jQFmo0pkLBxRzzo0huDLWNMdXUOtVlskV8Jzz7VY5dz7e4jhpyw51jRymNCqBbpeLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1750088840; c=relaxed/simple;
 bh=viBnvh6ru/1CgsMNU838rnlyUiSdUtwB3pQbrKCIRG4=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ht83QmR/uf0s0LQz7Jot+tT6LJcNm3rRrMGDA60ngrUB5Bx+TwrqAbs0Oeql/M9jyX4vW3HCyTmQPKzz2WOICC/zkHrOoW7eFvE4q1Cwo4YBA4MEnwcddCYHW4bJ1QLss59B/G4X/u7li5huQaSveOve3JRpUkJQoABmlolYl+5nkzwrKpa7YK9biBAte8ccR0IEwUciMr6TPxCJneTz7E0wPTQNExAkl0v70XWgSG1YmFEEqxKhwcBRngi0jw0ecv0yTi4iOrfjBYhh376jOu32U7kMeJa5h2nbNJWBrPdkIq825KCpGMt3BcJJOjrXOIt2eyf0eOlIt0rXAmeQmA==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1750088839;
 bh=viBnvh6ru/1CgsMNU838rnlyUiSdUtwB3pQbrKCIRG4=;
 h=From:To:Cc:Subject:Date:From;
 b=84LsvngBPT6n40hMYpMvp6lmMowcKi5RkIdPbIGRK6jbKB1+EqoUTM4NPNQCzZNaq
 bQJ5n3iX3R6rjnk5vIZG/h0Hx+bNy3TeKqji2Y/AQ51wpIH70PlLNaGcG8WT/q+6y+
 WlOP2x4CvKb9wRlVwj03RdELub6RW7JsMHteP2cLTII5J/pFcEFv+VeQVt2tFMY0ub
 mFGRATdmYya5h04fzYL7wWJm4sALQwR2zNezH8yeHIsSgPDNazKPaUDj1D9b2vOoAQ
 5pE20GCg08loyRPq0Jl8OBsKQAJUbeoochue0N7V1GDTOsBHCZhVHND3QCSLet3krr
 8eWKQ3APciAuA==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 3E7A91551;
 Mon, 16 Jun 2025 23:47:17 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>
Subject: [PATCH 0/6] Fix paths for relocated files
Date: Mon, 16 Jun 2025 11:46:50 -0400
Message-ID: <20250616.qemu.relocated@sean.taipei>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Several files were renamed in previous commits, causing their entries
in MAINTAINERS and source comments to reference outdated paths.

Update the filenames to reflect their current locations so that
maintainer lookup works properly, and readers can find the correct files.


The rename history can be verified using:
  git log -- <old_filename>
  git show --stat <latest_commit_id>

I have also included the relevant commit IDs in each patch to make
the review process easier.


Sean Wei (6):
  MAINTAINERS: update docs file extensions (.txt -> .rst)
  MAINTAINERS: fix paths for relocated files
  MAINTAINERS: fix vendor capitalization (Vmware -> VMware)
  MAINTAINERS: fix VMware filename typo (vwm -> vmw)
  treewide: update docs file extensions (.txt -> .rst) in comments
  treewide: fix paths for relocated files in comments

 MAINTAINERS                     | 22 +++++++++++-----------
 docs/spin/tcg-exclusive.promela |  4 ++--
 hw/acpi/nvdimm.c                |  2 +-
 hw/acpi/pcihp.c                 |  2 +-
 hw/acpi/vmgenid.c               |  6 +++---
 hw/misc/ivshmem-flat.c          |  2 +-
 hw/nvme/ctrl.c                  |  2 +-
 hw/ppc/spapr.c                  |  2 +-
 include/hw/acpi/pcihp.h         |  2 +-
 include/hw/misc/ivshmem-flat.h  |  2 +-
 target/arm/cpu.c                |  2 +-
 target/loongarch/README         |  2 +-
 tests/qtest/vmgenid-test.c      |  2 +-
 13 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.49.0


