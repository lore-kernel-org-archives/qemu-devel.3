Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117C6C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fS3-0001l3-55; Sun, 05 May 2024 13:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS0-0001it-Bv
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:00 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fRx-0005i9-LH
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=NP0N3GXAxQ0oT/3vkVD47WATl6JL6lrtKMJPsb0DHs8=; b=ofZ3umL4gd4IAENk
 GkB3Mh+ZihtJ5GdEqDpNUs44XX9GC3tTW94WwnaH99eQ9+X4v6E9qLRRZdmq0G/fq7URJ8QqcYAmJ
 mmZH07M9x8qZ48IlKy+g8cK782tV8Y1T9twZV+8EsldADKjPgmzqYNrFVWjqqkSAR0B9cvIXZ0I5M
 GEKmWdf4ewLpSXY5eIHe+devaga/ex4vZgz6J3FpiDfbQWXS7C5NumsEXJExdO9Q4y8CuUosq6/1w
 SOREVJEJj0+s1/UFngrG52G4Jo8ztPSlQXP/kfFOksgRpp3gfvcHf5JVjpfJZhN7XvG3Dg79nHHxd
 98sKqnzX/kgYdV6XIA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1s3fRv-004nca-3D;
 Sun, 05 May 2024 17:14:56 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 2/7] linux-user: i386/signal: Remove unused fp structs
Date: Sun,  5 May 2024 18:14:39 +0100
Message-ID: <20240505171444.333302-3-dave@treblig.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240505171444.333302-1-dave@treblig.org>
References: <20240505171444.333302-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The structs 'target_fpxreg' and 'target_xmmreg' are unused since
Paolo's:

Commit 2796f290b546 ("linux-user: i386/signal: support FXSAVE fpstate on
32-bit emulation")

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 linux-user/i386/signal.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 990048f42a..9bf602b388 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -34,16 +34,6 @@ struct target_fpreg {
     uint16_t exponent;
 };
 
-struct target_fpxreg {
-    uint16_t significand[4];
-    uint16_t exponent;
-    uint16_t padding[3];
-};
-
-struct target_xmmreg {
-    uint32_t element[4];
-};
-
 struct target_fpx_sw_bytes {
     uint32_t magic1;
     uint32_t extended_size;
-- 
2.45.0


