Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40843D3C934
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YFN-0003Lc-IV; Sun, 20 Oct 2024 11:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFM-0003LD-46
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFK-0005PF-ON
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMwb4cqMtnHKGBA9xJPy57dYI46qDTx8J452fpJp7/c=;
 b=MVDOIY3ATvLJh9KPPo8BM002fgfKZBQ+5SnCtE7Hc/xRM79NiR7+L6oOmC7O2NjuoewD4H
 IbWIS3yoK1dU+cmdJ7hxUFRqrtoMqsPAYOhXSUZotu0x9N2l7bQfKDaOKSdgeUBNqNPIuv
 ekmrzNFM0a+nU1C3E2C0+pwd5mQR+bM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-KS3alombNPKMMT_qbc7-HA-1; Sun, 20 Oct 2024 11:53:31 -0400
X-MC-Unique: KS3alombNPKMMT_qbc7-HA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4317391101aso457565e9.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439610; x=1730044410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMwb4cqMtnHKGBA9xJPy57dYI46qDTx8J452fpJp7/c=;
 b=jVdNOoWQKhUuwo2ptt0bjYoH3Bk6BuV7AfGHyGe/23COteVnViEA50GhJVbPJUoLiF
 dKzegxp2GZj9DopvQcvAtF7Xqnet1zshe5l2c9dVkvFUwN342FIU9EuLW/Y9JgJvRmKw
 x7sSz6Vt3/3B/j9Ge0raX5/oIOeIFlNEIt9+O6al3qvrBP8lFsUidCU9vYwKmnhRNVo7
 BhOioEvuXUre1UNDuxVxqJz7krRb76Lx8ls8oINrVCXPOEITtYjQ5YEIlQ02Rtvn1dw9
 xwaT/t2WKNX88Sq4a1MMtu+ULdwE8qmYsK/LrIv7EHg5neTr6US4HC+oo60C9Bi4roCa
 WRaw==
X-Gm-Message-State: AOJu0YwP+ld+5e20V/1SevVhKTpcxvxVJMqGWThoIOkL5WkekjIh4v7e
 x7Xtg60o5Taz7tJ71nzba12Qg6cmS1P8MEjkdrCTjDkU42ydFXjhIvVAm6uv5fkFONGQVSNdDmt
 /0IqVJaJxvOeaEBHQlVKPqrPxHfgxR8N8FMH24lDhLXIdUhGe8G4T9vnVJ6AwQGa2jgzF7MZv3+
 P/UM9Cm8BB4vQGwgpuDlwUw7s+THGCcvFAxHCTe6k=
X-Received: by 2002:a05:600c:4ed2:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-4316163b8bbmr63952505e9.8.1729439609801; 
 Sun, 20 Oct 2024 08:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQfHN5TXu0JflghqLSw/jVxhSR+lR6woc1hz0kzri/1mvHNFCwU+0Vc/pW1+SV2XtJ8LkFug==
X-Received: by 2002:a05:600c:4ed2:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-4316163b8bbmr63952365e9.8.1729439609293; 
 Sun, 20 Oct 2024 08:53:29 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f58ae9bsm27070935e9.21.2024.10.20.08.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 01/14] target/i386: use tcg_gen_ext_tl when applicable
Date: Sun, 20 Oct 2024 17:53:11 +0200
Message-ID: <20241020155324.35273-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Prefer it to gen_ext_tl in the common case where the destination is known.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ef190416b49..dc308f31041 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -883,16 +883,16 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
@@ -1041,8 +1041,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
@@ -1052,8 +1052,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, true);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, true);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size | MO_SIGN);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size | MO_SIGN);
             cc = (CCPrepare) { .cond = cond, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
-- 
2.46.2


