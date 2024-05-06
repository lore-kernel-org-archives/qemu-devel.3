Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50348C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tQe-0003Be-7r; Mon, 06 May 2024 04:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQU-00035y-64
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQP-0002F2-DL
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMrKAa7QBhLGGLcB5AvDcFvCq//pQo94Rmq9NikpxBY=;
 b=Jp0PScIv8xscDu25eUYswWssNo8jH+AM2ROHuANu2qf6Xj1FPMLG93aDbdNLxejH7pdGz8
 bB2M8/c207P5664rqW3oK7E1dokM3UVvkrNEjD8SE8/olTeuY9DglEc+XI8fVdKOFNTk0v
 hsLg8khvgaDVWmfaYLpekCfIXzZ3B/c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-1vHum5DSNmafEdJWw1dibg-1; Mon, 06 May 2024 04:10:15 -0400
X-MC-Unique: 1vHum5DSNmafEdJWw1dibg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51f0d924685so1559141e87.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983013; x=1715587813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMrKAa7QBhLGGLcB5AvDcFvCq//pQo94Rmq9NikpxBY=;
 b=O+UG8mvUoTaHDfDI8HlOjhskifYNBfj/lmQMk+mBRZoWZlYa9DXmfwqlj3Tuz3DI9O
 SOuKOKBPXFBI8GFkIbTkaiMNISZlVG3N0Gs52lbnDqtJiL5hac76F+qf9Yrxs3VAZbME
 ZyvRnaCnD/4Wr1/oIikTk++DkUS4lJF7fJi1Dud+ZVzHOYGGojxd143J8H0FWQtVM71W
 nbatS1cFx79CKPTWTSp3PEMmUnabinDvjVgLHthEsUZFwjML3gbnbyIKX1u1cSJntVqM
 d0BTGf89z7lHtQzQdzamlEUvsIkw1RpdWnBgb4Kr/go+C7vW1r/cPxspzrl8BsPwjL3P
 dTuw==
X-Gm-Message-State: AOJu0Yx0oPCrGxCE2wvnHaAt9/pAcFiU6xC32mT3ju98B1vGON9JAzDW
 6zED/WG6+pu1rvkWCp+9fueNxyWX7jh4z9XmOWEEDoQ2jwytWbdwcp9qW7EK9oeq62lwL83+yMv
 Ih1Xy5T2HxImyejBfz6VeOzx6hNfNc194aGmi5cGML54l64Z0JAxAunc+Qkjfi0bYWBPOrnZYTE
 0VuWZfksGzSniwBBdz8iYrugzEz9sYkjPdZji/
X-Received: by 2002:a05:6512:6d5:b0:51f:6ab6:9e5b with SMTP id
 u21-20020a05651206d500b0051f6ab69e5bmr10729011lff.36.1714983012838; 
 Mon, 06 May 2024 01:10:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQAZ+qVzMOT1PEKSEwhHWrVn+KsNYjVR0pzI51b6NteM0x9VhGCWjBoDJ34Wv3Ph6pyuPGRA==
X-Received: by 2002:a05:6512:6d5:b0:51f:6ab6:9e5b with SMTP id
 u21-20020a05651206d500b0051f6ab69e5bmr10728986lff.36.1714983012350; 
 Mon, 06 May 2024 01:10:12 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a1709060e4200b00a59c23c411csm1727643eji.160.2024.05.06.01.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 04/25] target/i386: cc_op is not dynamic in gen_jcc1
Date: Mon,  6 May 2024 10:09:36 +0200
Message-ID: <20240506080957.10005-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


