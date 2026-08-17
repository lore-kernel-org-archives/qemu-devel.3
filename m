Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37EFC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtJv-0006Cq-7a; Mon, 17 Aug 2026 05:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtJC-0004Jl-UB; Mon, 17 Aug 2026 05:07:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtJB-0001px-FC; Mon, 17 Aug 2026 05:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=uFYAHr8BbrHS1vZbqbTnbC6JEjz8S14OJJrMSGhNacE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DUzAf4qMYolL2ODhk8Cbu0fqjRKKD8PE0yJJ7GjkunROMne1A/akCHp3DijaBUxPC
 f6mq+MBnJ7whl7eJtno/KEuJxhjX48GZdJIGwRlskkAQifv2UcSjVac4XP/6RwrzVD
 2m7xiVHrZamPm72pkoCyr29kTy7Z4xUbX2KCj/KuvQs+iMc1e3ITKcXIzbDaEVd9Tr
 diKL6GQ4krh2nb5JYBZyElLZhB0FOvQcPYnlZ8QY/3P+/dWLXmCGQrzEpTfPUxhNSq
 /KurqSquHL2jkPzhr4YzGoN8i3Sc+F/4IBoFEg/UdfQroigAez9VQ9pEe7Ean2dR0j
 d5UswzqENO6Kw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5D43F1CBA4A;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3D14640D02C;
 Mon, 17 Aug 2026 12:05:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DFE6130D0C; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 22/42] pc-bios/s390-ccw.img: update s390x bios
Date: Mon, 17 Aug 2026 12:04:27 +0300
Message-ID: <20260817090453.2034156-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
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

From: Eric Farman <farman@linux.ibm.com>

Update the s390 bios with recent fixes for out-of-bounds accesses.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 9b3d68edb24d4e04f49822c6e11641e4eb23dfd5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw.img b/pc-bios/s390-ccw.img
index e24a93e14a8..291cd77eaff 100644
Binary files a/pc-bios/s390-ccw.img and b/pc-bios/s390-ccw.img differ
-- 
2.47.3


