Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF3C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1wh-0007Le-T4; Wed, 16 Jul 2025 09:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <44f51c1a3cf435daa82eb757740b59b1fd4fe71c@kylie.crudebyte.com>)
 id 1uc1t0-0004QV-83
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:09:30 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <44f51c1a3cf435daa82eb757740b59b1fd4fe71c@kylie.crudebyte.com>)
 id 1uc1su-0004Jj-0v
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Message-Id:References:In-Reply-To:Content-ID:
 Content-Description; bh=0ZRtJtc7/6GydXmew0iEUkGd2lEZOsvNu3j9CfMXRm8=; b=q85Qf
 c4IK099evUHvgPAso1hGPtxQZSw68Fpq20N2EWI7vV9aSRkEN8C7y/zVnViPFyRUEQsfy7DfhYXNB
 NuZR0GrvNituqGUHviKDHkizrpLfCdZXylNeW28e2/rkQsayrjKaiyNe64yGAo/FW+MvEkPRgho6l
 2KR+ok+79tcMEBRO5Klvyu0KwMmFaJzVLfT/RcKn4GXRcfYl05OcrrJ/zwlgl2VShnEfyilxF+PIM
 ETPtuTkJMGmOALaI9H3PCu0VBvLjJgBFCjVfFqW9m4oajPxqs3T5Sb8qzEo6SOSFix8uuEkJHpGgs
 cMzt7pbKuefc47rL7L+IdNE0L3T5PbIoLfjUWi11DT5D5ATjjci5fxwBVUvUrWmgiC886/pr3f6tw
 xUuDdbDkJo7asXkJ4R9MVCLFZIyiA46GN29KfjJ5kpyZn9IloUx+20JzXPdkAbnXvspIeuxyglYF0
 xYw6dIRXerUQyxmr3QUUoSM+L3RGi56bhEUZEvHShTxs25rFM0AJVnH785VJ6prfUT90TyR2Crlix
 YDM227fY7EKhtmr/x3DPzEh20gWMBXGsVWvk8Qf7uLqg61D2/hdCgF9ROImC0bp5oQx8IUXtBLOuK
 BhgAQN/Ah+Vcn/AfiQtMc4vn7We7i6t2SaDdl0tv1RhKGFpcJroAdoQhuJ8r2s=;
Message-Id: <cover.1752669861.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 16 Jul 2025 14:44:22 +0200
Subject: [PULL 0/2] 9p queue 2025-07-16
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Sean Wei <me@sean.taipei>,
    Philippe Mathieu-Daudé <philmd@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=44f51c1a3cf435daa82eb757740b59b1fd4fe71c@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit c079d3a31e45093286c65f8ca5350beb3a4404a9:

  Merge tag 'pull-10.1-rc0-maintainer-140725-1' of https://gitlab.com/stsquad/qemu into staging (2025-07-15 00:12:07 -0400)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20250716

for you to fetch changes up to 44f51c1a3cf435daa82eb757740b59b1fd4fe71c:

  hw/9pfs: move G_GNUC_PRINTF to header (2025-07-16 14:18:48 +0200)

----------------------------------------------------------------
9pfs changes:

* Tightens printf-style format checks. No behaviour change.

----------------------------------------------------------------
Sean Wei (2):
      fsdev/9p-marshal: move G_GNUC_PRINTF to header
      hw/9pfs: move G_GNUC_PRINTF to header

 fsdev/9p-marshal.c | 3 +--
 fsdev/9p-marshal.h | 3 ++-
 hw/9pfs/9p.c       | 3 +--
 hw/9pfs/9p.h       | 3 ++-
 4 files changed, 6 insertions(+), 6 deletions(-)

