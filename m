Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D69EECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snnfL-0002gK-Fo; Mon, 09 Sep 2024 19:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snnfK-0002em-6o
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:19:26 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snnfH-0005oE-89
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:19:25 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c26b5f1ea6so5960529a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725923961; x=1726528761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeiZa47TlEcucXkTbh9/FQ0FaLdwV7ONW3ardm6BGVU=;
 b=e+/CIkmT1xe3RdW33KbQfYxTy186K90YhJEu+LOmGe6qaSIT0Hqpo2auK+ndBWxt3v
 0ylEH/8k6COZom0huAAvqRQIdpIuwQdTG912kvOK6f46dTPN7Z4wk2Az7QP/VfayaUrZ
 oWE7zhndpKXk8Fiawqjj8htM1V0ByYuyVbIKHQylPABzl01zrsqe1NsyWbkaf9IOF9cn
 P3WGlJnaXNyyUtR6ceezvGxwdeHxRhYWzgcM89rl1BlitQwxGvDG8aj4vdae+alAQMY+
 q0Sqay0aOa95NvAVdjpLJ6NAf+Hm6BqQ3ws5lL1MxwMzQD6SAcfvi2d0ShO5+hESoD7B
 FAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725923961; x=1726528761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TeiZa47TlEcucXkTbh9/FQ0FaLdwV7ONW3ardm6BGVU=;
 b=lDnPyno/2M2zHDPb6IqQm8T8d+xPycANOxDpiIEyT28PGJvnsh3oDT6Z6WSrCBt0XJ
 5qK4fe7Mih8z0iH/lr7FwfLO0XFHYfBOqaLe9j0DQAJBPrrbXNpmnIzS2PII7DtiynBI
 /R3Fu2X+q8gmn1JV7mklUgPWsL28NcklXdhaVbzoliFkf7KklxE1BoNc81ikKrlU4mSv
 kxn0OdtdIaSwzIMv0t6+A/mhBdp4fboYd2d7p4R2iuY+d2o0DBJNvGeKtIGxkJkY+d/B
 QSkKrX3njfpxKOFybYe0bXFQ3iOxBW6bLpCdnKdMoup8S323Aia5PepGEs8SUs8BifQ4
 yavw==
X-Gm-Message-State: AOJu0Yx9saJMqVPKSfS/3kJw87VrBC5QHbnW3dwl6vc4mTH0oUh+XMtu
 4RzoT9SweNqnmAFJGmlzN5O8SGWzkYvJAV0+Cx5LvPheuCkpvBi1oPoi3dT9y3X6KyBmSP/UeDm
 6
X-Google-Smtp-Source: AGHT+IFWmo9smGcIpLjf8x9B2J21o+j78htaxNH0yC5gxifsK+nHANz5br/OXXqnY06eZJ1faRiTzw==
X-Received: by 2002:a17:907:2d0a:b0:a8d:51a7:d5e8 with SMTP id
 a640c23a62f3a-a8d51a7d9c3mr464237466b.15.1725923960687; 
 Mon, 09 Sep 2024 16:19:20 -0700 (PDT)
Received: from m1x-phil.lan (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835551sm401436766b.24.2024.09.09.16.19.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 16:19:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/10 2/4] target/s390x: Use deposit to set psw_mask in
 save_link_info
Date: Tue, 10 Sep 2024 01:19:08 +0200
Message-ID: <20240909231910.14428-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605215739.4758-7-richard.henderson@linaro.org>
References: <20240605215739.4758-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240605215739.4758-7-richard.henderson@linaro.org>
[PMD: Split patch, part 2/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index faa6d37c8e..53ec817e29 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1417,6 +1417,7 @@ static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 
 static void save_link_info(DisasContext *s, DisasOps *o)
 {
+    TCGv_i64 t1;
     TCGv_i64 t2;
 
     if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
@@ -1425,14 +1426,17 @@ static void save_link_info(DisasContext *s, DisasOps *o)
     }
 
     gen_op_calc_cc(s);
+    t1 = tcg_temp_new_i64();
     t2 = tcg_temp_new_i64();
+
     tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
+
+    /* Shift program mask into place, garbage outside of [27:24]. */
+    tcg_gen_shri_i64(t1, psw_mask, 16);
+    /* Deposit pc to replace garbage bits below program mask. */
     gen_psw_addr_disp(s, t2, s->ilen);
-    tcg_gen_or_i64(o->out, o->out, t2);
+    tcg_gen_deposit_i64(o->out, t1, t2, 0, 24);
     tcg_gen_ori_i64(o->out, o->out, (s->ilen / 2) << 30);
-    tcg_gen_shri_i64(t2, psw_mask, 16);
-    tcg_gen_andi_i64(t2, t2, 0x0f000000);
-    tcg_gen_or_i64(o->out, o->out, t2);
     tcg_gen_extu_i32_i64(t2, cc_op);
     tcg_gen_shli_i64(t2, t2, 28);
     tcg_gen_or_i64(o->out, o->out, t2);
-- 
2.45.2


