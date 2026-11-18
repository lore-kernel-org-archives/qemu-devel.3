Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3F606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lz7jazN2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiN-0002dx-T7; Wed, 18 Nov 2026 07:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiE-0002Vl-1H
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiC-0005y9-7k
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5J764FQwsxMgYiN3Rr7kiYxo43hyF76/PQFlkRdMtGc=;
 b=Lz7jazN2TAdUaTGMzd4oBsLza9IikimwSo8skVv0T8AhiMliQNZNsJQ97fzeOHVU8JINEw
 NmIKcFfl44V9DyKKvcxg8+6T7s8RRdM5BQnnq69UobArLOZu9McyD2nB19PQk0Sgan7Z+7
 /o3vBoyZ0p4vp8G8kssRZdIQ/Vu71CQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-1y59mC7aNeOnI8ZBFvcf_Q-1; Wed,
 18 Nov 2026 07:24:25 -0500
X-MC-Unique: 1y59mC7aNeOnI8ZBFvcf_Q-1
X-Mimecast-MFC-AGG-ID: 1y59mC7aNeOnI8ZBFvcf_Q_1795004665
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A0C5180034E
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:25 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BCD518004FC
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 23/26] target/i386/tcg: rename X86_TYPE_0..7
Date: Wed, 18 Nov 2026 13:23:54 +0100
Message-ID: <20261118122357.659634-24-pbonzini@redhat.com>
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

Now that the tables are automatically generated, use the same RAX..RDI
syntax used by decode.def.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h              | 16 ++++++++--------
 target/i386/tcg/decode-new.c.inc          |  4 ++--
 target/i386/tcg/maketable_codegen.py      |  4 +---
 target/i386/tcg/test_maketable_codegen.py |  2 +-
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 92652f92f5b..3fe7a483301 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -49,14 +49,14 @@ typedef enum X86OpType {
     X86_TYPE_2op, /* 2-operand RMW instruction */
     X86_TYPE_LoBits, /* encoded in bits 0-2 of the operand + REX.B */
     X86_TYPE_ZERO, /* Constant zero, for CFCMOV */
-    X86_TYPE_0, /* Hard-coded GPRs (RAX..RDI) */
-    X86_TYPE_1,
-    X86_TYPE_2,
-    X86_TYPE_3,
-    X86_TYPE_4,
-    X86_TYPE_5,
-    X86_TYPE_6,
-    X86_TYPE_7,
+    X86_TYPE_RAX, /* Hard-coded GPRs */
+    X86_TYPE_RCX,
+    X86_TYPE_RDX,
+    X86_TYPE_RBX,
+    X86_TYPE_RSP,
+    X86_TYPE_RBP,
+    X86_TYPE_RSI,
+    X86_TYPE_RDI,
     X86_TYPE_ES, /* Hard-coded segment registers */
     X86_TYPE_CS,
     X86_TYPE_SS,
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 296356cc4ee..14d2d291671 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -975,8 +975,8 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         op->unit = X86_OP_INT;
         break;
 
-    case X86_TYPE_0 ... X86_TYPE_7:
-        op->n = type - X86_TYPE_0;
+    case X86_TYPE_RAX ... X86_TYPE_RDI:
+        op->n = type - X86_TYPE_RAX;
         op->unit = X86_OP_INT;
         break;
 
diff --git a/target/i386/tcg/maketable_codegen.py b/target/i386/tcg/maketable_codegen.py
index 99f0aaf2c91..b3f8da23265 100644
--- a/target/i386/tcg/maketable_codegen.py
+++ b/target/i386/tcg/maketable_codegen.py
@@ -18,8 +18,6 @@
 
 NUM_ENTRY_POINTS = 8
 
-C_TYPES = {'RAX': '0', 'RCX': '1', 'RDX': '2', 'RBX': '3',
-           'RSP': '4', 'RBP': '5', 'RSI': '6', 'RDI': '7'}
 C_EXT = {'zx': 'X86_EXT_Unsigned', 'sx': 'X86_EXT_Signed'}
 C_SPECIALS = {'nolea': 'NoLoadEA', 'xchg': 'Locked', 'lock': 'HasLock', 'mmx': 'MMX',
               'op0_Rd': 'Op0_Rd', 'op2_Ry': 'Op2_Ry', 'avx_movx': 'AVXExtMov',
@@ -48,7 +46,7 @@ def row_fields(entry: Entry) -> dict[str, str]:
         fields = {'gen': f'gen_{name}'}
 
     def set_operand(slot: int, type: str, size: str | None, ext: str | None) -> None:
-        fields[f'op{slot}'] = f'X86_TYPE_{C_TYPES.get(type, type)}'
+        fields[f'op{slot}'] = f'X86_TYPE_{type}'
         fields[f's{slot}'] = f'X86_SIZE_{size}'
         if ext is not None and slot < 3:
             fields[f'ext{slot}'] = ext
diff --git a/target/i386/tcg/test_maketable_codegen.py b/target/i386/tcg/test_maketable_codegen.py
index b2fe3753c43..ab5d26d7735 100644
--- a/target/i386/tcg/test_maketable_codegen.py
+++ b/target/i386/tcg/test_maketable_codegen.py
@@ -248,7 +248,7 @@ def test_write_only(self) -> None:
         fields = row_fields(entry('8B   MOV   Gv(w),Ev'))
         self.assertEqual((fields['op0'], fields['op1']), ('X86_TYPE_G', 'X86_TYPE_E'))
         fields = row_fields(entry('E4   IN   RAXb(w),Ib(zx)'))
-        self.assertEqual((fields['op0'], fields['op1']), ('X86_TYPE_0', 'X86_TYPE_I_unsigned'))
+        self.assertEqual((fields['op0'], fields['op1']), ('X86_TYPE_RAX', 'X86_TYPE_I_unsigned'))
 
     def test_ext(self) -> None:
         fields = row_fields(entry('F3.0F AE /2   WRxxBASE   Ry(r,zx)   '
-- 
2.56.0



