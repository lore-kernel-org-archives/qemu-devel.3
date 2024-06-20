Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1E6C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEUy-0002G7-Uo; Thu, 20 Jun 2024 05:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEUx-0002Fa-3n
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEUv-0005Ry-DZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718877268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mB6qUyfk7CEyOLtSYFq4HWKNU3wdVBe6UZgliSYNpcM=;
 b=flk7wJ4DdHukX65+gtGU0VTHNuehc5k0M7yTLMo16DPJSq5tMpU653//ClZgv8eD149twI
 eHW4uCE3vjCkm/vvus8TM11LLuX5PLpP+c9xW3kzYW8z5fDxepu5GE3P+7bclv57orTLsR
 fFBFn2MKPbJPYJ36gOkMd9+dJEXm1h0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-lZ-yi2FuPYiXyRW-L6XtbA-1; Thu, 20 Jun 2024 05:54:26 -0400
X-MC-Unique: lZ-yi2FuPYiXyRW-L6XtbA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57c6979daf7so341363a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877264; x=1719482064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mB6qUyfk7CEyOLtSYFq4HWKNU3wdVBe6UZgliSYNpcM=;
 b=rEuUf1E9RGpSJkxHA9H9VdjpspMt2zdiKRSDRqb29wyGqUMHEy4KvLb2lAGNIqT+5i
 cSBE1gLHlanjOleKORB/NligsVwexy6QfmyjjHhjxsNjcE5YAJfOiMw4YlJnahxdF1eC
 u+Z2HROZ7ERiZuaYE/YN8N89q9rVwuKmKSBz6rg9JY1b0F6O/s/8yb1LYG1DEnu8spJu
 7uVrWK/swTKYGx5eSKDcl3dY9lFN1tw83fT5KzAuC/wRD0f1fCNwhSB94kBq9nWFxlTO
 OufPbbbNptcTR7uJEycs6+CL6nBtlrb4ON3wfmqfk7HXFlTRxkp62fnmc7q1/+Gx3AsL
 PuCw==
X-Gm-Message-State: AOJu0YwBOWZ2bqfWCCxQ0bVLDFxsS1Kg0IhN4ie6QQwa8yw5ruEeqZbv
 qDaANyLApY8lYi/vw4+V3qqMB4/zj36Ehh0tqOsgo1NkTi5DINh4Jgp/6namQJzBUgG/wxld37l
 DINPcc4yH6ECMjSucoIbOX8KLEh6uNSR+9w85AHaKFGSKrC8Vx3yXoQtQE6T7o+fvQrD/vJeIFZ
 4UpzlQBn+7QlvpYfdta1yMoDAvg7fbGKovHgdn
X-Received: by 2002:a50:d6d7:0:b0:57c:5f74:d8ff with SMTP id
 4fb4d7f45d1cf-57d07e750c8mr2960967a12.21.1718877264640; 
 Thu, 20 Jun 2024 02:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwrgvmp2sBwO+HqQd3L0vQhEO1A2g2UqS++YxTiAoqdUyr/irKL/XOyXhTgWvMCQ9iYqYXMw==
X-Received: by 2002:a50:d6d7:0:b0:57c:5f74:d8ff with SMTP id
 4fb4d7f45d1cf-57d07e750c8mr2960956a12.21.1718877264218; 
 Thu, 20 Jun 2024 02:54:24 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cbb05b465sm8894650a12.18.2024.06.20.02.54.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:54:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] target/i386: use cpu_cc_dst for CC_OP_POPCNT
Date: Thu, 20 Jun 2024 11:54:10 +0200
Message-ID: <20240620095419.386958-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620095419.386958-1-pbonzini@redhat.com>
References: <20240620095419.386958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It is the only POPCNT that computes ZF from one of the cc_op_* registers,
but it uses cpu_cc_src instead of cpu_cc_dst like the others.  Do not
make it the odd one off.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 2 +-
 target/i386/tcg/cc_helper.c | 2 +-
 target/i386/tcg/translate.c | 2 +-
 target/i386/tcg/emit.c.inc  | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7e2a9b56aea..f54cd93b3f9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1332,7 +1332,7 @@ typedef enum {
     CC_OP_BMILGQ,
 
     CC_OP_CLR, /* Z set, all other flags clear.  */
-    CC_OP_POPCNT, /* Z via CC_SRC, all other flags clear.  */
+    CC_OP_POPCNT, /* Z via CC_DST, all other flags clear.  */
 
     CC_OP_NB,
 } CCOp;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index f76e9cb8cfb..301ed954064 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -107,7 +107,7 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_CLR:
         return CC_Z | CC_P;
     case CC_OP_POPCNT:
-        return src1 ? 0 : CC_Z;
+        return dst ? 0 : CC_Z;
 
     case CC_OP_MULB:
         return compute_all_mulb(dst, src1);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ad1819815ab..f32cda4e169 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -324,7 +324,7 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_CLR] = 0,
-    [CC_OP_POPCNT] = USES_CC_SRC,
+    [CC_OP_POPCNT] = USES_CC_DST,
 };
 
 static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 11faa70b5e2..fc7477833bc 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2804,10 +2804,10 @@ static void gen_POPA(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_POPCNT(DisasContext *s, X86DecodedInsn *decode)
 {
-    decode->cc_src = tcg_temp_new();
+    decode->cc_dst = tcg_temp_new();
     decode->cc_op = CC_OP_POPCNT;
 
-    tcg_gen_mov_tl(decode->cc_src, s->T0);
+    tcg_gen_mov_tl(decode->cc_dst, s->T0);
     tcg_gen_ctpop_tl(s->T0, s->T0);
 }
 
-- 
2.45.2


