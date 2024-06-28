Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABBFC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPq-0005hg-Jc; Fri, 28 Jun 2024 13:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPp-0005hT-GZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPo-0002Ez-3W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rb/XNVOr++O08J4/Xv3HqdQx3Qog+zVROp768RnHVi0=;
 b=GkWhOU8CIaKcvi4G2SK/tkBarO43eOgrF14UkUyoX/i6uahXOFemzksNnxQtWn1qigvoWI
 ++FkAdoXMqUXy/mkdiGua8Dikq6bYgaqNpf5A0sh2gOl2JELvq9SFmv/zLJK2PP0I7bP1E
 jmlciOSb+UYujNPoooGEpFCD4oO8SVI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-ZQzU4NliO1Gi18NUssrMUQ-1; Fri, 28 Jun 2024 13:29:36 -0400
X-MC-Unique: ZQzU4NliO1Gi18NUssrMUQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d05ce92ecso764589a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595774; x=1720200574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rb/XNVOr++O08J4/Xv3HqdQx3Qog+zVROp768RnHVi0=;
 b=MKY7coOMNeo3lklsof0K30ENQwgkrVN5Kp2vyUMSJu6f7O81rGXiRerZ7N2LS9AJTr
 XtK0bK7zxrDmWbu961gn938IkRDGaXTZp9TZRh9Qs+We/NZtvyMVzSagqaRWbsLJeW3k
 D9uQEHRziUlIDH6SbyT9Q9/gfmP3QlQ9ftNut2ZvOcfUxH0kvkpnOtDEn8lkH7d6H9xW
 8+Vz/bjoOBTLhmyAKol/00KGSh/ghPwqPnp48Yi5gqNW1tHj+0RhaUwEMw99d0/CZKuH
 kgfxjbYWtuAJyyUVKdMQMR5kDgl+YeQCrbK6Lhc+UvHvA+Mo8hvuhwaa4n/n8DfaFnk4
 hq2w==
X-Gm-Message-State: AOJu0YzU06qh/edkfU6pcMHqIjiX3ixRFfQOvIfDP6laORei7nPBSZf7
 gK88tyLktGhbUzbroB9SsrOriUZj4IB9oISFIdrXmvtrSRoFczo0nRGi7kfYY39F8KoLo4MdOxQ
 RurKV/p8+AT9vDuq1iGGHan+yczYH9ruoQVZ6WNxETc6eZyYz/vc+T7YEa8UOOMli6NwNzcCNjL
 AXOo0GSxwf1XrgtdrHtjtfZcEQb82sJaWSLosp
X-Received: by 2002:a17:907:6d19:b0:a72:b055:3dd7 with SMTP id
 a640c23a62f3a-a72b055407bmr183088966b.1.1719595774076; 
 Fri, 28 Jun 2024 10:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWVIVtDOEdKG07qeYEEPD155dH3VE4cj7L7xQC5knylZDO4zQyqLzMsa5bkYb/6z7nH02Tqg==
X-Received: by 2002:a17:907:6d19:b0:a72:b055:3dd7 with SMTP id
 a640c23a62f3a-a72b055407bmr183087266b.1.1719595773660; 
 Fri, 28 Jun 2024 10:29:33 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72affddd7bsm70365366b.186.2024.06.28.10.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/23] target/i386: give CC_OP_POPCNT low bits corresponding to
 MO_TL
Date: Fri, 28 Jun 2024 19:28:48 +0200
Message-ID: <20240628172855.1147598-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Handle it like the other arithmetic cc_ops.  This simplifies a
bit the implementation of bit test instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 13 +++++++++++--
 target/i386/tcg/translate.c |  3 +--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1b4edbe0580..29daf370485 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1275,6 +1275,7 @@ typedef enum {
     CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
     CC_OP_ADOX, /* CC_SRC2 = O, CC_SRC = rest.  */
     CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_CLR, /* Z and P set, all other flags clear.  */
 
     CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
@@ -1331,8 +1332,16 @@ typedef enum {
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
-    CC_OP_CLR, /* Z set, all other flags clear.  */
-    CC_OP_POPCNT, /* Z via CC_DST, all other flags clear.  */
+    /*
+     * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
+     * is used or implemented, because the translation needs
+     * to zero-extend CC_DST anyway.
+     */
+    CC_OP_POPCNTB__, /* Z via CC_DST, all other flags clear.  */
+    CC_OP_POPCNTW__,
+    CC_OP_POPCNTL__,
+    CC_OP_POPCNTQ__,
+    CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
 
     CC_OP_NB,
 } CCOp;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index eb353dc3c9f..934c514e64f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1019,8 +1019,6 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
                              .imm = CC_Z };
     case CC_OP_CLR:
         return (CCPrepare) { .cond = TCG_COND_ALWAYS };
-    case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
@@ -3177,6 +3175,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         case CC_OP_SHLB ... CC_OP_SHLQ:
         case CC_OP_SARB ... CC_OP_SARQ:
         case CC_OP_BMILGB ... CC_OP_BMILGQ:
+        case CC_OP_POPCNT:
             /* Z was going to be computed from the non-zero status of CC_DST.
                We can get that same Z value (and the new C value) by leaving
                CC_DST alone, setting CC_SRC, and using a CC_OP_SAR of the
-- 
2.45.2


