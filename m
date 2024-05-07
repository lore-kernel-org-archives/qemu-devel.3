Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED52AC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUM-0004TP-DF; Tue, 07 May 2024 06:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUL-0004Si-7M
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUI-0002IW-Lz
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tkxSghSjR4ENCOCTqTHpgkYlq4A0zKbSI7o1Uqb86F0=;
 b=V1tuXzjyErynjufFeMveKA6n+xx5CSR1qY4/bOKLeupHmCB4SFgHmNg9nbTw1BaRI/XWWk
 uMOUf9Axxrtcwm3uf1fzQZSqxnLQiaPfP3klHFHuM6zPSOg+AC8kcvmiRSZKaBBnH20CXZ
 sUC2qy0+ubghQ3ylOF1hriGxXNoBu6c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-kbKkT9tsOW2Mm4GxJezk_g-1; Tue, 07 May 2024 06:55:56 -0400
X-MC-Unique: kbKkT9tsOW2Mm4GxJezk_g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso173944966b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079354; x=1715684154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkxSghSjR4ENCOCTqTHpgkYlq4A0zKbSI7o1Uqb86F0=;
 b=mqXj3AxI4hgN9Q/RuB615gNCP1Yuz/zcvF1Uu0wZVKM847+AjnPmrpZYEyq3m++bsF
 xoPbSKMrJnIxw38IMo2rsONZ1xrwwdd2XHiV1aFWdXCQb7ii0XhhQMSog7yKpgt7ErFV
 XKr2Sa/yi7lqJmnPS+E/SDR1gzdtaUMk80a1LhMDJCJqaCPpNVRDstAQ5nIOX6qzDJBI
 FMlEgkqn6TY4Wx+d5pEGJNi9niGGkQWfCQoxsqVc8mnsTbvmOrPa+FHlfnEw3Ye6tYYv
 ubFRaT1t3S+0xQxzsg+WCRmLtyk/ZsZ/1kUfZAlpFAMtiQjnZVD5n86FO0VQcYufcb+M
 McqQ==
X-Gm-Message-State: AOJu0YxR3uIFIuUaG2rADCZaW72t60zg6EPiYt0sQMp9KQelL8msMTW3
 Buaq+AKpkoGdbPmNgkuYcgO1h5Wj0j8PYE86XDHpM2MGiAcqvfBTKqQmcD3l3p/sTZQCeJEFVRm
 RKYnz0v3jRBFvI5wfIn10nY3SKkqOJPnpOMSzoUfdOnJKgTrbhUkY0mkTCsz3/VtHiDGCk/omc2
 mNMIajwq4L7UaN9u3Yn/b9sLhO3oJQfPFu/LnP
X-Received: by 2002:a17:907:9403:b0:a59:c833:d272 with SMTP id
 dk3-20020a170907940300b00a59c833d272mr4957014ejc.13.1715079354715; 
 Tue, 07 May 2024 03:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ+UleOGqhS8Nex6FtITqtnfUeMlUjNIknLx51OILuUl9yAJ8BKhKTTZIeXRcfDgR6vss6kA==
X-Received: by 2002:a17:907:9403:b0:a59:c833:d272 with SMTP id
 dk3-20020a170907940300b00a59c833d272mr4956997ejc.13.1715079354418; 
 Tue, 07 May 2024 03:55:54 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 bo15-20020a170906d04f00b00a59b87dd0bbsm3396150ejb.161.2024.05.07.03.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:55:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/26] target/i386: cc_op is not dynamic in gen_jcc1
Date: Tue,  7 May 2024 12:55:17 +0200
Message-ID: <20240507105538.180704-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Resetting cc_op to CC_OP_DYNAMIC should be done at control flow junctions,
which is not the case here.  This translation block is ending and the
only effect of calling set_cc_op() would be a discard of s->cc_srcT.
This discard is useless (it's a temporary, not a global) and in fact
prevents gen_prepare_cc from returning s->cc_srcT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9aecd415b38..3f1d2858fc9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1227,13 +1227,13 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 
 /* Generate a conditional jump to label 'l1' according to jump opcode
    value 'b'. In the fast case, T0 is guaranteed not to be used.
-   A translation block must end soon.  */
+   One or both of the branches will call gen_jmp_rel, so ensure
+   cc_op is clean.  */
 static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, s->T0);
 
     gen_update_cc_op(s);
-    set_cc_op(s, CC_OP_DYNAMIC);
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
     } else {
-- 
2.45.0


