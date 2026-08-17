Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB4AC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxW0-00045V-PM; Mon, 17 Aug 2026 09:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVy-0003zf-1S; Mon, 17 Aug 2026 09:36:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVw-0007MU-ED; Mon, 17 Aug 2026 09:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=v6YDqayq+GIWlo0Mglq+6QTIA/xJ03QR+0cbN3+NoVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=v256Bv6SDwVYQum87RU1v7yTuOOh9OMvkuUY5YXoTR+mJvQVyhjdSKJhosPGR7+1E
 +isPCA1KRa1BGencbj8tBM1Vix7bFbu91dZcPn0TwyPzneaVTbYFVH2H8gM95wisi/
 tHc8YSa+JRzvQ0/tDzBEbYrr5tu484TbiJMwEbLfvtPgESvSyqXQEA76MvsQsZVUHw
 rmC6NWlEHDWA5hrEBzBzdUzmXK+r/FLP3ja7PX2e3qcgYooOD1Jo/19ByjxAQoPlut
 HXizrjbXoXlHHkwemBZRfi50l3G0cL9LLY0Y6D1pYFo1JBAqBOHOYRwyEuc4ziSvFw
 pPWfd9tailpaQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3A4CD1CBCC2;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7575540D41F;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id ACE2030F8E; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Farman <farman@linux.ibm.com>
Subject: [Stable-10.0.13 v2 115/135] pc-bios/s390-ccw.img: update s390x bios
Date: Mon, 17 Aug 2026 16:34:25 +0300
Message-ID: <20260817133451.2384630-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the s390 bios with recent fixes for out-of-bounds accesses.

Build it on debian trixie using gcc 14.2.0-19

This is commit 9b3d68edb24d on the master branch.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw.img b/pc-bios/s390-ccw.img
index 47240f0a74e..25ed6c4b6ff 100644
Binary files a/pc-bios/s390-ccw.img and b/pc-bios/s390-ccw.img differ
-- 
2.47.3


