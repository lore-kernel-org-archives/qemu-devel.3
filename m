Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92057D711D3
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 01:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWPZq-0004kp-CM; Thu, 18 Dec 2025 20:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vWPZp-0004kg-3f
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 20:46:41 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vWPZn-0001vx-D7
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 20:46:40 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9F8F7140005E;
 Thu, 18 Dec 2025 20:46:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 18 Dec 2025 20:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1766108798; x=1766195198; bh=KOVecchrD7
 sYVUL7ytytGzmt7eASaT8+EAR+I6AaQ7A=; b=y57ANoShygo6z29oX+iMI82DTC
 d4cFMVKNhAqoNm+uwx6kVhR45IO3MtZNcKNUxsvNydArdhrWCs/dgJk477p3Dfs3
 Ha31eCjgmua8tGY7iTjOuHJpdkzT6A4IxCqrAEHpfc+pGrO9UIPxysKTjMY6bRso
 x6mgnU1hBK745mOdAENP1LF/uTfddzrcNIa6C5305/pFeov/mUTV7nb0jqkxbNu3
 TS70QB7tpYtXlgCCEwK3C4ERP3oW5VJwxfzJMBHpTwbjQJ17xDEz5VnIRaMFxqg8
 gVWoOZQZkcZi4GoqX/tYeDNyVYOZgxkDKAdfRq1j4YJDhF2VFtUolbI8rNQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1766108798; x=1766195198; bh=KOVecchrD7sYVUL7ytytGzmt7eASaT8+EAR
 +I6AaQ7A=; b=alTVF2mNgCgLN4qke0zhhkubeBMsRYZzv0cKA34fTjI6C47uPqB
 LQ8rqfBgL68OuFcjLVGZ9oMtaoVYmI9GizLSAVjKh95tPWtbjmf7X2t98dpRfCfS
 PAZzWzapzcdgBOYDNk7yLE47EyDHeyuuG2NW2mikrPQDIIpeWz+aRi7MOLKSIta2
 O3qxu18VlaZUgi7Rd7SP2Ff9ca84TokmnH/NPIX21Yj/KxasqGw1fyS3DsTp649L
 AAKBlkkmtVXe5KefDCM66TKFZmbKP3bPR6A5ee7g48tV9UT9Ua2gBdvH7bsQzWZF
 TgFQGQuwzyxohdGEB47j8j3C5w5mo+N/GnQ==
X-ME-Sender: <xms:fq5EadToGeeJn8keN1c0UDZzkhNDDtz3ukDal6IaN73J8ziZbgzgYw>
 <xme:fq5EabGFPsZXYgdQgTOEzlAA_bw4ltku3ZFr7xEO97hB4d1ErzPH0vDABXmL0BEJM
 _CYHmYyRSLdjmm883dEUQZezq9aMI6aztXFws7qOaC2nCIXKaabtxw>
X-ME-Received: <xmr:fq5EaR-lfC1b0lUrCa9s1l_aJi1V0pGAr2zGieAL8NXaBbVY8hOEHoS-XW1Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjedtvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhiuceo
 tghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhteeugf
 eujeelteeggfeigeevjeelgeegudfguedvheeghfffudffledukeeiveenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghloh
 hnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
 tghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegthh
 grugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgvlhes
 nhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:fq5EadIf0ianzsUqw0g4vxQ-a56PBC7-XMhbRJktKgOXwhzWHzWrng>
 <xmx:fq5EacZAJPZAMooUe5VQNpvKFGl7lRP8yDVY3HdE7old0IXkndfWuw>
 <xmx:fq5EafL787KaJVWQkdANh9-t7HiPtA72tUJWcjd4jUtQD85DHC8CDA>
 <xmx:fq5EaaAtt-9iICOjpOLirxM8CS7wqYSg3-rTGF2uvxHeMzoBoJVKzg>
 <xmx:fq5EaV65OTdKXSeXSVZxE1Y6pDYPY4UUepXRkIDLtBDJ-WFsqSuZXgoz>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 20:46:38 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 1090552e;
 Fri, 19 Dec 2025 01:46:37 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH] migration: Remove unnecessary zlib include from qemu-file.h
Date: Thu, 18 Dec 2025 20:45:12 -0500
Message-ID: <20251219014512.387773-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.498,
 FROM_SUSPICIOUS_NTLD_FP=1.997, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Commit 70eb5fde05 removed zlib from the libmigration dependencies but
missed removing the zlib include from the header file. zlib doesn't
appear to be used anywhere in qemu-file.h. This is fine in most
environments where zlib is nearly always in the default include path but
breaks the build when it isn't (NixOS for example).

Fixes: 70eb5fde05 ("migration: remove unnecessary zlib dependency")
Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 migration/qemu-file.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index c13c967167..c50a3fee53 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -25,7 +25,6 @@
 #ifndef MIGRATION_QEMU_FILE_H
 #define MIGRATION_QEMU_FILE_H
 
-#include <zlib.h>
 #include "exec/cpu-common.h"
 #include "io/channel.h"
 
-- 
2.51.2


