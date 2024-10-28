Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22903D33996
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RWy-0008RK-BN; Mon, 28 Oct 2024 11:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWk-0008BL-9Y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWi-0000p6-V4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=is5CdaaNMr3Jm3fsNDTy10/40GRNhVSMMooCmQjIYFY=;
 b=b4jZDM+Co0p4W8ja9G6GPkVWTqhEfUbuagCtJBhIQr4mIpmyUJTu7EgKGw3q0vIecKz41h
 oXrmP9a0mxjytJnAGlrBvK+OJ1ijE3/XyiCfDATTCA2DE7XkXYNURF8IcwW8ZFQ3bsSLyV
 fj3ZQPdphgZs7ft1Y8JWk+BWo043rY4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-4ryQ3RkxNbS7wqxBl9xrqw-1; Mon, 28 Oct 2024 11:19:26 -0400
X-MC-Unique: 4ryQ3RkxNbS7wqxBl9xrqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d52ca258eso2406051f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128764; x=1730733564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=is5CdaaNMr3Jm3fsNDTy10/40GRNhVSMMooCmQjIYFY=;
 b=gDbQ13SFY+xxGDWxS5f6+iBj8rNF3KOGzhTTzfqP5x3lBL5yaiOIjyfECYdWlLdh09
 EfZ5nhvo+AGlwKi+RZtRsh3EB5ldCl7YjV3eyAUVLq+OLBFMx9n+e8Hu/U8CodBYuefD
 XOg7zMse8UXL3yMGIArWHSC6VrjvpIq3iEtgtbd8K/W32oMem65VpOPoJSRGskGkBRs1
 TVxjifP+CCVFlyAvIFxEP2uJbA8lhHiWe6TxYqi4sUSHif6O+vP/uZ1tsDCEJ5kLNiEK
 HW2n797cDUV+76cVBTbRxWiwRLyEcTeDCd3Z0OwHgg/mJmEa9UC5r620sSVN7C3xHoLh
 vrsw==
X-Gm-Message-State: AOJu0YwUnccFYQBgvwzr1eKEFquy8wMJZPodIhG0EKq4VjvQF5cK8lqf
 4KJO1za4otQJgzvGYr1gDnQsJY9/WGRtaFdgYQxRl2vG5nq3VNtetQeqw+3OXqRviapXM3IkvSa
 D+zSAL3xe29wRn/tC8eu1Qz9ou/sKBUgX4ChHiVVb0p5obIvzf1gCqeR3yIoePtwLGqUT+nETU+
 BRxi1UmVFzNIuCfwVEhAl6pQOwCbR3mYPVle4ghB8=
X-Received: by 2002:a5d:58f1:0:b0:37d:3735:8fe7 with SMTP id
 ffacd0b85a97d-380611455b2mr5810636f8f.32.1730128764395; 
 Mon, 28 Oct 2024 08:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzZpyYI5Gl8v9BD143GwksOOoRaoML/fIhXwrVE6AJv6Z/dvI/tr8+MHKoH3DBPdKF5oo15Q==
X-Received: by 2002:a5d:58f1:0:b0:37d:3735:8fe7 with SMTP id
 ffacd0b85a97d-380611455b2mr5810618f8f.32.1730128763933; 
 Mon, 28 Oct 2024 08:19:23 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b712bfsm9749464f8f.79.2024.10.28.08.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 09/14] target/i386: add a few more trivial CCPrepare cases
Date: Mon, 28 Oct 2024 16:18:46 +0100
Message-ID: <20241028151851.376355-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


