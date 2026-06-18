Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF971CD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCAm-00029t-SM; Thu, 18 Jun 2026 08:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wa85I-0008NV-3Z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:26:48 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wa85G-0008QA-Bv
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:26:47 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 427C7240103
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:26:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1781771201; bh=/k+mbaurDZsgy+c2LXE6TVsgvla8M841Zg1MbsLBc00=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=F0KFZ+EcxTWMkSUgnZD9yU3vvddyCgNOJjqFdACtYHQdejOZ95YV55xYSkWE6ZnqT
 acEQRvhNA2bCJv64mZW3hrrDqcsrG4sWTnTk/1+puCpsLJuLn1AhJE8df3J6FhSV9p
 khC2rzbwCLN3gVc2Az3HXdNndhz86LWemRlteivIpR/Y9N7SXo5/Y0zjFRV16WLi8w
 QR19wEXSFCdZ83G8cladstlSXTYxIgoYVbS1AOeWHhLSiO7P4OkiXM+MlosP6vt36T
 rh6i55yfI/oeZcxxb+1sM4mcghE/GviZDcPvm0PSPk7zkRKlt7gNMaoyxGfKGAsFbY
 qIyo9JLQ2F0/g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4ggv2m1TW0z6tvs;
 Thu, 18 Jun 2026 10:26:40 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM pseries 0/1] pseries: Update SLOF firmware image to
 release 20260618
Date: Thu, 18 Jun 2026 08:26:41 +0000
Message-ID: <20260618082623.345255-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:00 -0400
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

 Hi Harsh, hi Nicholas!

The following changes since commit c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff:

  Merge tag 'firmware-20260617-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-06-17 10:17:29 -0400)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/qemu-slof-20260618

for you to fetch changes up to 7abb51793e131ca374d4fb0c3f0d1878d9199069:

  pseries: Update SLOF firmware image to release 20260618 (2026-06-18 10:08:06 +0200)

Note: this is not for master, this is for pseries

----------------------------------------------------------------
- Fix parsing of ELF program headers

----------------------------------------------------------------
Thomas Huth (1):
      pseries: Update SLOF firmware image to release 20260618

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 994176 -> 997584 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

