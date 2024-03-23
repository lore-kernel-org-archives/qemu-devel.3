Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47B7CD11DD
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 09:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnxqV-0001p6-UH; Sat, 23 Mar 2024 05:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rnxqT-0001ob-Mu
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 05:39:21 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rnxqR-0006wz-F3
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 05:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1711186752; bh=COeUxPMaD1DVJx8UC71ryN/Nb2YKVJ3r+rLd91PtcjA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=cvinKVltPhKKv+fZktQLD2C1ljdHhNlI7CnvNkF3cwSbCLphfC0aAFir7GZbAX+uS
 BHAfwK4IK4K/Y2RxYHjXmd8/2XPKPy6XY9E/X6OaCmloicF0lzV01cNJtsmQT2P3tW
 Yymu29akSx+fH6RfwZtGXVf1uqP73plYA0Kof7Gg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sat, 23 Mar 2024 10:39:12 +0100
Subject: [PATCH v7 7/7] Revert "docs/specs/pvpanic: mark shutdown event as
 not implemented"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240323-pvpanic-shutdown-v7-7-4ac1fd546d6f@t-8ch.de>
References: <20240323-pvpanic-shutdown-v7-0-4ac1fd546d6f@t-8ch.de>
In-Reply-To: <20240323-pvpanic-shutdown-v7-0-4ac1fd546d6f@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711186751; l=758;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=COeUxPMaD1DVJx8UC71ryN/Nb2YKVJ3r+rLd91PtcjA=;
 b=Ykda+L0OHk09gNPbJIZ/IR4GO4R/ZIVEWt6/d4vNdH5eSU2bQtLU6at44FcFWdM2XmB682X6q
 Hi8P/uAy7OcCb/jDkqtzBC0ZMVu9zSxqvxPTSDDR+caCl4jMECJUAHj
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
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

The missing functionality has been implemented now.

This reverts commit e739d1935c461d0668057e9dbba9d06f728d29ec.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 docs/specs/pvpanic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index b0f27860ec3b..61a80480edb8 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,7 +29,7 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
-bit 2 (to be implemented)
+bit 2
   a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface

-- 
2.44.0


