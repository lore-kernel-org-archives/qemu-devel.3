Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCCEFEE4F0
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 13:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwKpj-00039S-LR; Sat, 28 Feb 2026 08:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b72d15f47cbd2fc93580f33fa86a7e23595a68dd@kylie.crudebyte.com>)
 id 1vwKpi-00039K-LF
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 08:58:14 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b72d15f47cbd2fc93580f33fa86a7e23595a68dd@kylie.crudebyte.com>)
 id 1vwKph-0003Md-6t
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 08:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=1cW8m9CznvVSXBqqkMkGCOQtHpv0/ZO/h4HZc9XH7as=; b=qfqCK
 JKyPzQjopfayHWxo4NNc9IJ4QOhMINCZub46EYwkmpyfO5BjGCLcD67QcMD67Vq3TBaJsZNaPdjhS
 ogMhU4mPSCGraJbKT0YH0OXHst8kFkhwU2xIZwQMwCi0QVzsvtQZesjwx1zG4t1iP/YOsR1/i4ekJ
 lxeyYMqi8C/s1TEoqxFQgk74HE1PH6H7KMngMj6pJFmmnKx4nvnUoUBN2WwXcCvuuqPSfj4TYSQSW
 8ywhd341kfa0hMqffQ3JJ7P1Kd7mto70YuihNy32H7MmbeeSywK/ijFHvqT1pgqv263Tqk3xWYlD4
 VgQImRf+FdiXPxf/HjpPjpbx1wyvENF8P+TsdNiJw6GNso66eWqq6XA2J4mwtK+JD37CeTOVsOnHL
 fzrScI3phWARLxEvAxqRklKya2CAQugx4P84YQ8sBy87CL1iQ6scIRYUGe2diN89lL/2gpLS+SZMN
 IdRdBTo7FmG2uE+S3ks2XfKMtOqbjbptSR8iaQbhH+RUjh3h11gmGHBzjqKg9SHiCcoOGr0RuLY2Z
 oSvdqkyPuhSYUe/hZ+kiyOLNUHxubOcXyxVoDLVcHTeTEKwz+yO+/KGS0IAv6sNl+I2rmMwfWMiJk
 nFVH+HOHnahGhvrjqXhsRCplbAcILD3Y0YZYM6PjuuDYZA05dTNK7GicRo2VeI=;
Message-ID: <cover.1772285406.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 28 Feb 2026 14:30:06 +0100
Subject: [PULL 0/2] 9p queue 2026-02-28
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Richie Buturla <richie@linux.ibm.com>,
 Oliver Chang <ochang@google.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=b72d15f47cbd2fc93580f33fa86a7e23595a68dd@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit d8a9d97317d03190b34498741f98f22e2a9afe3e:

  Merge tag 'pull-target-arm-20260226' of https://gitlab.com/pm215/qemu into staging (2026-02-26 16:00:07 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260228

for you to fetch changes up to b72d15f47cbd2fc93580f33fa86a7e23595a68dd:

  hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth driver (2026-02-28 13:46:42 +0100)

----------------------------------------------------------------
9pfs changes:

* Fix crash under unlink-heavy load in v9fs_mark_fids_unreclaim().

* Fix crash with the synth fs driver.

----------------------------------------------------------------
Christian Schoenebeck (1):
      hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth driver

Richie Buturla (1):
      hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()

 hw/9pfs/9p.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

