Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C72606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iy+ymwc3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiK-0002dJ-0V; Wed, 18 Nov 2026 07:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiD-0002VU-4Z
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiA-0005rm-Ra
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzCH9h4KKoUem2G2enPU1gEftet3Nh6+53r7LND01a8=;
 b=iy+ymwc3m4wFT2jO6s8sutBFAH9wyHBdMjtD6JjIaQKf/mOCGZ921RnNnop2NlS93UqMyo
 fHoXIaqC0ogEIZDCYZ5oLBST7FJszUCmLDflug6/y1tz+aEjyBaFc6O/8CZQ3O4IqVzuTv
 AzrX8YUj6+LcTEC1WLn1FiQQ9QQYXEc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-z2JIicgrOBKMB18VxP7rxQ-1; Wed,
 18 Nov 2026 07:24:24 -0500
X-MC-Unique: z2JIicgrOBKMB18VxP7rxQ-1
X-Mimecast-MFC-AGG-ID: z2JIicgrOBKMB18VxP7rxQ_1795004664
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A3C518004FC
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:24 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B51E180055C
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 22/26] target/i386/tcg: update decoder docs for new tables
Date: Wed, 18 Nov 2026 13:23:53 +0100
Message-ID: <20261118122357.659634-23-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 20c2a1328d4..296356cc4ee 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -40,20 +40,24 @@
  * and the instructions are illegal in 64-bit mode, so the choice of "Ip"
  * is somewhat arbitrary; "Iv" or "Iz" would work just as well.
  *
- * Operand types
- * -------------
+ * Operand types and modifiers
+ * ---------------------------
  *
- * For memory-only operands, if the emitter functions wants to rely on
- * generic load and writeback, the decoder needs to know the type of the
- * operand.  Therefore, M is often replaced by the more specific EM and WM
- * (respectively selecting an ALU operand, like the operand type E, or a
- * vector operand like the operand type W).
+ * The decoding table have the extra possibility of applying modifiers to
+ * the operand types.  For example, for memory-only operands, if the emitter
+ * functions wants to rely on generic load and writeback, the decoder needs
+ * to know the type of the operand.  Therefore, M is often replaced by E and W
+ * with an "(m)" modifier, so that load and writeback properly treat the
+ * operand as respectively ALU or vector.
+ *
+ * Other modifiers include sign extension and zero extension.  Specifying
+ * the desired signedness of the operand occasionally improves code
+ * generation for memory or partial-register operands.
  *
  * Immediates are almost always signed or masked away in helpers.  Two
  * common exceptions are IN/OUT and absolute jumps.  For these, there is
- * an additional custom operand type "I_unsigned".  Alternatively, the
- * mask could be applied (and the original sign-extended value would be
- * optimized away by TCG) in the emitter function.
+ * an additional custom operand type "I_unsigned" which is produced from
+ * "I(zx)'.
  *
  * Finally, a "nop" operand type is used for multi-byte NOPs and for
  * some ModRM instructions such as LFENCE.  It accepts any value of
-- 
2.56.0



