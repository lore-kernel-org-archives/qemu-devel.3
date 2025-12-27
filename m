Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B69E92716
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 21:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZbRC-00037G-Gb; Sat, 27 Dec 2025 16:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vZbRB-000367-Qi
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 16:02:57 -0500
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vZbR9-0001wh-OP
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 16:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1766869371; x=1767474171; i=laurent@vivier.eu;
 bh=3BhyWd999eaNpoNCxphb74xL2WE0O0kT3KZOAVzI358=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ERKOy4+dA2cHTdmW9P5GqDgeCuswAtjIrYJhTG/SpI+Q/Il2JVKifPLpylLm2rEA
 zro/qf5F72bnQDzb0xRkkHWcvBk5y9Y9SQiN99E6WsZBDcnTsqGM/5QMRYaa3Wxut
 q6I9cUbDEi3qFDHEx39fxSms7IcejzLJGiuT24Wji5w9D7tpdEBubWpb07m4fa4IR
 FgMYc/wnMx1iUe+I4iZLzFTyKDbK6t/E55fwgtA3cL74XncRZtMCbVj/VJhqtQKah
 ZHCubOMYzkFGuUG3f67GZ6sc9bBTRknjr3s3xg4yymh79vfsH5Z1tQlx/pJgoJLkg
 KNEGteORZb/EnhJvsA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MtObA-1vv7OW3Z1S-00rzse; Sat, 27
 Dec 2025 22:02:50 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] m68k: link.l is only available with 68020+
Date: Sat, 27 Dec 2025 22:02:50 +0100
Message-ID: <20251227210250.411882-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zNIZnberu0bHEOn59g6ZrotQY5mqhB8kO6Ul+r+ck/zRXULOy2i
 uWkqjH1tsIA74UB3nPqWfjAdJNrIiT5ML2GltiIInaCjnjihZcxQwP8widTAD/dfrNXXiaD
 l1skUN2Achkjm72gSIyDzT7L/oF1Y7Az3Hx+8W9jML2s2F37bXHSgENJNFSdlSUQdQuLSPp
 qYi5ocHVDJOrTfx6zNPPA==
UI-OutboundReport: notjunk:1;M01:P0:jj2VB54MXuY=;iNFK0RswPBw6gb4E5FTEygiT4t9
 fOiKvktj0/EuyEojgettRLaz8zI1mRSqhxDKdMJab+TZVTwyvt6116Ju8VPqg9XqJ/RGOpREP
 8oGjwfj7dQit+yUG3StdlkJJ/yO0+r2vW07Agcxkm3Gr+zQbO3ZX4zdHJAvxtTmAlNWPQdXLg
 oV8ou0hxhKvUAdiWQDMWRl/2nuqgjDLcw0LyN9HUTc2+C6f+3AapQzwrJYjw1sKs89+W6DnxK
 7TlvG+w/56wtlmkajgFbTlxcxvfnpVrI+e/sznB0tRH95nOqoLfml4v4cVbgkIsg9Z1to39q0
 UL+MGj3f3008wKy0Qkfy23B//01ykUevK4JEYyD3uroTJATpz6k+Kax16glh/L/woPAsrc47z
 Fnkw06HbB2Oc2+RRJ9oM8QHoeqx7DWsb2RYdpQJRqECAyEFWCZNnr52C0wsDKx7e+51Y8GseN
 arRQf0IS6rOyhv4YsqKkkiuWDUPQhl+MtjivtB4CgmvKVXXQMbam1v9x/8cfjm3TYmjVKdIVr
 UKrFrQ1pR1kMdMGHHaSvwdFE9mADcbAFuLU88uGDl8gH9FxkBZg5B7mf97GrmdXnoVkdOMLFW
 5vkYwaK7sXPfZfjZSVh66gR67nrt3hS+6liDiCyZ12KLZDjKSfi27SjT6P7M8krsjaE9eJ8HS
 I8LjkBWf4qQR0QW2S7yd1MNsa2t9zDbLxHVMVXHz09FB62YRyTMjVBthWtYwjT01Z7flMmAuf
 U6WpRcSFKH+9E6sHAiHTr0mCiaNUW8K1+dXyvc2UAboSpNcwY06K6GALue3vc1TFAcgGh6ns5
 ieJ3PJ/jeXCP4RnNiFFV2fZ22zAuDALufVRc7zg3/2v/VyQDfLXH8R1WeY082PjvXuypRrafc
 VG9IUAA5Vc0xz97SWO5f+boNHiftmzYBtuuU/LWJJRJbY1dzivyCoJXCaEZJyzB4zLEEbBIpY
 e2+yqwTACdNWXJD3KgNEdZoBSPBz9o55xIoUshFcTC8vgS1tjThcD61NEgOx1MefJ5lBtzwsl
 mxFTeYxJZ+6Jr0te5IuS5OQzS/PsGZ4ReoixM8pml+OLaxh5wuP9Pm6m4lIPMJpL9i50dzyRX
 wSylLQNOBL8oAi1hqjRdIVPBnsa41aLIxK31pNetU5p3EYCXF/MQKsOliRivyxnJBhuPBlV+Q
 AC1C2PO9Y/DaGd0Lwfmo4G8aa7R6HBtSuH1SdtFPxlFwLJoGx6D/olv9OxoM7W9CDSNYn4ljW
 BVAT++UIjDkNcDAtfVnefq96nryLKxVtVTKaRpNSSJpzG9b+t03wmC5xNdhjCiMX7EdEQWnqz
 1cD/zKE5ulqMl9D/5TyH0sPHigb+t1vIGssJSYFpyM/Bpw3R+cpv5Md614sglw5QjStFdQLcc
 vcU4gCFgxQCuCd90ajdFETEUl93Yi5bARkk+a8QKYE8pf6iFwqpco1GBBNyvaVT1iRYQzqE4b
 RhUsbF7U4vNzKxib/oQ2l+ZCDahdY/jxKtz1WWcfjB5K+uPuqxBZJtNxT9BLd+zXyEyt1/cQ/
 ItnKeXCk5PJ9mGjH3Mh7e0+98KpkYWH4i2Nrj8ZCDWA7MsfmHxZH7U+bt6ryw+eJB5zn4OzLl
 J56GSOAtwlZIIqDJNeqWv8VWeYC6TVHPhX3NLQjbqnGk22l110A9VaLbCXODLoCXNGFGDFs3m
 YvX5OP0c/D5jKYUrQFZGacEAzIwqynqGbO+uOJgQgVojmn+nyw3bW7hNxavl8Fuf5HRLbqHwx
 G7RIXPUd2FUqzylqCgxHAFDxT3EtRYlu4fw==
Received-SPF: pass client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Base 68000 only supports word size.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
=2D--
 target/m68k/cpu.c       | 3 ++-
 target/m68k/cpu.h       | 2 ++
 target/m68k/translate.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f1b673119d6b..b55e604b11d1 100644
=2D-- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -235,7 +235,7 @@ static void m68010_cpu_initfn(Object *obj)
=20
 /*
  * Adds BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST, CAS, CA=
S2,
- *      CHK2, CMP2, DIVSL, DIVUL, EXTB, PACK, TRAPcc, UNPK.
+ *      CHK2, CMP2, DIVSL, DIVUL, EXTB, LINKL, PACK, TRAPcc, UNPK.
  *
  * 68020/30 only:
  *      CALLM, cpBcc, cpDBcc, cpGEN, cpRESTORE, cpSAVE, cpScc, cpTRAPcc
@@ -260,6 +260,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MSP);
     m68k_set_feature(env, M68K_FEATURE_UNALIGNED_DATA);
     m68k_set_feature(env, M68K_FEATURE_TRAPCC);
+    m68k_set_feature(env, M68K_FEATURE_LINKL);
 }
=20
 /*
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d9db6a486a80..7911ab9de30a 100644
=2D-- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -555,6 +555,8 @@ enum m68k_features {
     M68K_FEATURE_MOVEFROMSR_PRIV,
     /* Exception frame with format+vector (from 68010) */
     M68K_FEATURE_EXCEPTION_FORMAT_VEC,
+    /* LINK.L (680[2346]0, and CPU32) */
+    M68K_FEATURE_LINKL,
 };
=20
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index eb1ba150745e..78efa3e597c4 100644
=2D-- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5829,7 +5829,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(move_to_sr, 46c0, ffc0);
 #endif
     INSN(nbcd,      4800, ffc0, M68K);
-    INSN(linkl,     4808, fff8, M68K);
+    INSN(linkl,     4808, fff8, LINKL);
     BASE(pea,       4840, ffc0);
     BASE(swap,      4840, fff8);
     INSN(bkpt,      4848, fff8, BKPT);
=2D-=20
2.52.0


