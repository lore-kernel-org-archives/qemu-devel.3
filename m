Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BF0D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNH-0003RQ-Pr; Thu, 31 Oct 2024 13:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMc-0002Ab-SG
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMZ-0007Qe-R1
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=is5CdaaNMr3Jm3fsNDTy10/40GRNhVSMMooCmQjIYFY=;
 b=RFW+gwbL20x5HKdRDAVHmuAJ9TDXxAz6cexipzBNwwv9ULsmtOvfpgNuQL6YMVgLdoVAp1
 RxcJ744v7vLi0wQUvGsY+lkopaUiOMNFMZLaWJwyemJKgpblTGLFbkrp5/P0QJrs+bnPAz
 bvr0qLCToPKXr2ZsISgSDIcaqiJX2dU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-lCf523r8N0miI6ITa1_1BQ-1; Thu, 31 Oct 2024 13:53:37 -0400
X-MC-Unique: lCf523r8N0miI6ITa1_1BQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c937403b2bso835985a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397215; x=1731002015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=is5CdaaNMr3Jm3fsNDTy10/40GRNhVSMMooCmQjIYFY=;
 b=QEeCB49bOFCTVt6I5DBfU0CWZWKlcdFY+Bl4+/B7/AclWTnsvJyToir3WaInKLGXBJ
 NV257lq+8JdtzpKhDfFk7OMuR5Ju8tWNuGqDHny794JJVlFcfvo3vNhq1cJllM1hVIyD
 RMKxJKf41bgwOFmDwHZSwyka0wla+ID1VB6xwNUV3ggBMLuaKvTDZVVDfehGEgMJ+fdB
 4pD1wDGz7YOk3LCdtMCtf7AoVhY5ny/VFO4XJQ53Lv6sQShlux78raoaqxwMUIMI0Ms/
 WIqYX+81eLun02dQgxuHo3fAI5jKMf1CjIA09RBTRRdu57eKD86QLUQeBrHjkZxWSrjM
 SlIQ==
X-Gm-Message-State: AOJu0YzxNWgYSsp9r6h2hz496r32OBoaGs2chczPL5BqUMgfDk6FIXG2
 EHIzmt7RNO4hGSp8saeRypXFGyLcy7UbFXbTEl6oLs+PYN/BfWQZ2X4GEIkqNyFuDQDc7/uIbwA
 F8gXAk9cU7GYTfl0mYOJXn8rPi6FgdSJInIvRc0bdwlqARwSywwn7XF1oOzzBSbenekaJZW2dN9
 xmj5xNWBLHmUlf8MEqGSYob9i7KIaBkRDVHJeXYQU=
X-Received: by 2002:a17:907:97ce:b0:a9a:e91:68c5 with SMTP id
 a640c23a62f3a-a9e5093efccmr392120766b.33.1730397215510; 
 Thu, 31 Oct 2024 10:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/oljysjkBcGYDfLRJ1zR7svkShlI6QWn+ltmncMOXWF4XPwL14B7TyTsfEHdZ3N0h1LNTNA==
X-Received: by 2002:a17:907:97ce:b0:a9a:e91:68c5 with SMTP id
 a640c23a62f3a-a9e5093efccmr392118266b.33.1730397215037; 
 Thu, 31 Oct 2024 10:53:35 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e566993c0sm89676066b.222.2024.10.31.10.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 36/49] target/i386: add a few more trivial CCPrepare cases
Date: Thu, 31 Oct 2024 18:52:00 +0100
Message-ID: <20241031175214.214455-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d3bbcf7317c..6e89d4faef1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -993,6 +993,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src2,
                              .no_setcond = true };
+    case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
     case CC_OP_MULB ... CC_OP_MULQ:
@@ -1021,6 +1022,8 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
         }
         gen_helper_cc_compute_nz(reg, cpu_cc_dst, cpu_cc_src, cpu_cc_op);
         return (CCPrepare) { .cond = TCG_COND_EQ, .reg = reg, .imm = 0 };
+    case CC_OP_POPCNT:
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
     default:
         {
             MemOp size = cc_op_size(s->cc_op);
-- 
2.47.0


