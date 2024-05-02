Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82851C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFP-00005x-Cp; Thu, 02 May 2024 01:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFB-0008NX-0h
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:33 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF5-0002ct-FO
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:32 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ea2ac4607aso3833093a34.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628666; x=1715233466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fuiq9TfywDbJprPpCqgLClsfOUB0xDNyU+e5J9WUAuU=;
 b=QJs0DrNnU/c1Vueuq8Dc5mm44e0BhAFOhxwDnDwPvaYzQRKoaf1oCeGl/Yj+d+rwBn
 X0rzsIDD6LMsqCX7FMboR4zaZL611y1bYj0ckL/c2a2V+5H5fnfWV03qSJYlh+040s1d
 8tee509FGcjhdqO0gz0dVyrX3YmjzbF0vDqXXmysOz8eslsU9ES2Lpbzd5lWgp5WEvdB
 d0fjR0i61p447YLVDQcBiz9PYO0R12Ucrk4tU8kFLhT6QDhdzR3Et22S72Ec/QZp2NHo
 A2iBX/tWHnlH/+foeTx2G7Pegzm8heouAHXqRHvNRWa8o+bwkYc/po/hO4H1l8zHvBcj
 JzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628666; x=1715233466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fuiq9TfywDbJprPpCqgLClsfOUB0xDNyU+e5J9WUAuU=;
 b=I1sqk6sSU5MY1fdDEIswdhM6uSaqG/IQ2z866wP1TCYHQzui9ctOsXlEfClDcHnVRK
 z0e1W9onelunglo9uV6V2gBCsrcbbPQzapnXEigq2foiBGRiXQ1Zcj9fqbp8POUQPBaY
 gJgzJRZTkvMOsmc3bRrLOCb54jfN+NdDZ+8fHKonzTmXgumSsDhga0WmS7HTvDpmN+FE
 5VkHv84bzQAFLS5ZHUA9VzGMik2qhXflfPqD+rYIaThkQ6Qwd24wy0akNCvMDo1VNeFX
 18lO7LHxVyyqG4nkPvWrIuN4WEqUF5KjCsOkcJSrFYex8w4C8LikgydtpzRvkw6CL/ox
 IqGA==
X-Gm-Message-State: AOJu0Yzr8kSuSUPvbVDICsTosHAE26VnVpnkwv18n91M0i3Bi5bTeFEz
 lVp1gzQmIDWR/znTIEZ2i5BvkIdN/OrpIRyBY7amCpLhns+IznFLFdix20tEk31GQvlPu3PW542
 W
X-Google-Smtp-Source: AGHT+IG0xYv2uIQqckm5wcK5KqitnMG0RvsgD8PC+M6h2NKLCwb3PmZEkQaJXuPa0vJr3NWLXPxkkw==
X-Received: by 2002:a05:6870:b28a:b0:232:ff53:44fe with SMTP id
 c10-20020a056870b28a00b00232ff5344femr5088160oao.38.1714628665894; 
 Wed, 01 May 2024 22:44:25 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/14] target/s390x: Introduce help_goto_indirect
Date: Wed,  1 May 2024 22:44:09 -0700
Message-Id: <20240502054417.234340-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Add a small helper to handle unconditional indirect jumps.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c3c821430d..b1a93070cb 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1120,6 +1120,13 @@ static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
     }
 }
 
+static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
+{
+    tcg_gen_mov_i64(psw_addr, dest);
+    per_branch(s, false);
+    return DISAS_PC_UPDATED;
+}
+
 static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
                                  bool is_imm, int imm, TCGv_i64 cdest)
 {
@@ -1150,9 +1157,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
             goto egress;
         }
         if (c->cond == TCG_COND_ALWAYS) {
-            tcg_gen_mov_i64(psw_addr, cdest);
-            per_branch(s, false);
-            ret = DISAS_PC_UPDATED;
+            ret = help_goto_indirect(s, cdest);
             goto egress;
         }
     }
@@ -1465,9 +1470,7 @@ static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 {
     pc_to_link_info(o->out, s, s->pc_tmp);
     if (o->in2) {
-        tcg_gen_mov_i64(psw_addr, o->in2);
-        per_branch(s, false);
-        return DISAS_PC_UPDATED;
+        return help_goto_indirect(s, o->in2);
     } else {
         return DISAS_NEXT;
     }
@@ -1497,9 +1500,7 @@ static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
 {
     save_link_info(s, o);
     if (o->in2) {
-        tcg_gen_mov_i64(psw_addr, o->in2);
-        per_branch(s, false);
-        return DISAS_PC_UPDATED;
+        return help_goto_indirect(s, o->in2);
     } else {
         return DISAS_NEXT;
     }
-- 
2.34.1


