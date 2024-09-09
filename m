Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79562ECE58E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snnfD-0002TK-Qa; Mon, 09 Sep 2024 19:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snnfC-0002Sq-P2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:19:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snnfA-0005ng-Jy
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:19:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so22312125e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725923954; x=1726528754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RljF5ZZjKlfnOTNofIkZDAiguKbpQWfL+qX+BI8AThM=;
 b=N4/qBooiCYq20EqEJCLlF0HsRFFHf3tARTWI6urW1UzoElW6taIj3fa+5kttnapp/t
 s8MdNYEg3J40UYj1h+/SYetCIcsL/xYeLCXEEme0SuMkOX8h2jNxD/NVGHWvZroRHRW3
 ZR3OrzjNRz290HK19WNv/RKeTflg5X6SSVLd7Av5t38X5Fge/8HWsfIxYnQbMHvLam7C
 LdU4aGD34AvCrGkBY7Gr/5FskbZqf7ponA+N6fT6Je+BVgms5ggY3hYz9lXL9yxXkvgm
 WhlZhDB9p02vCmIZESWx36LpUji/vylTxMnC5yHGRpFknVIUyerlkdzdtPyJPDczLF3Z
 ccgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725923954; x=1726528754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RljF5ZZjKlfnOTNofIkZDAiguKbpQWfL+qX+BI8AThM=;
 b=v4lg/5k4lUiHkKZnLC3kK3wWXh1A7w2MnSyLjuc+VwI3F2CtOSK+KgBTuiOFA8AtTN
 KG647C/5dNJ9gJgKfI5M4ZbKGEW+vumdvvgFZitLpBKm5R9caGQb9rTluK/gUuR1qZK7
 5wF74fBfgAcYH7cKqAZCpMZjf00i+bkKvkGG7rgA0uG2uKzUh7L5KMzPjvw5Un3yXp/O
 9SqzQqoV4WKy1JQWb4049O2odXQ5LYUMajwNvEPUrqQfEYpcEkhn4j/dFfV1kfZpS6Lp
 F78G6Fmh4t2jDewXffAXJI8pKQ0vDJeDalm9ZKu28zQfIKGTCDcpaEij8ivcHxHHl0Sn
 rLkg==
X-Gm-Message-State: AOJu0Yzo2otk3/zbTO/4pac6sgOSVq/2SadDNhg5I3w3sm65y/s32mNJ
 ueNPK4a3rdDyXuOhgtlXKOQ6GhGIvj3/vpUOb0aJPvPsWFELdaB7eBK59gy1Anhxrm/lBpF5AJV
 H
X-Google-Smtp-Source: AGHT+IFdXr68q3G8lnG7nXkTY+80qJhIkf+RdlDuZIQT8J6AzRTL6zhCZovzVtUGO7r20YwQcuvKDQ==
X-Received: by 2002:adf:ee8b:0:b0:378:8b84:4de9 with SMTP id
 ffacd0b85a97d-3789229dae6mr8227202f8f.12.1725923954304; 
 Mon, 09 Sep 2024 16:19:14 -0700 (PDT)
Received: from m1x-phil.lan (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a258a3sm397127466b.89.2024.09.09.16.19.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 16:19:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/10 1/4] target/s390x: Rename local variable in
 save_link_info
Date: Tue, 10 Sep 2024 01:19:07 +0200
Message-ID: <20240909231910.14428-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605215739.4758-7-richard.henderson@linaro.org>
References: <20240605215739.4758-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

To simplify the following commits, rename 't' as 't2'.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240605215739.4758-7-richard.henderson@linaro.org>
[PMD: Split patch, part 1/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index e1b1dd43e1..faa6d37c8e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1417,24 +1417,25 @@ static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 
 static void save_link_info(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 t;
+    TCGv_i64 t2;
 
     if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
         pc_to_link_info(o->out, s);
         return;
     }
+
     gen_op_calc_cc(s);
-    t = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
     tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
-    gen_psw_addr_disp(s, t, s->ilen);
-    tcg_gen_or_i64(o->out, o->out, t);
+    gen_psw_addr_disp(s, t2, s->ilen);
+    tcg_gen_or_i64(o->out, o->out, t2);
     tcg_gen_ori_i64(o->out, o->out, (s->ilen / 2) << 30);
-    tcg_gen_shri_i64(t, psw_mask, 16);
-    tcg_gen_andi_i64(t, t, 0x0f000000);
-    tcg_gen_or_i64(o->out, o->out, t);
-    tcg_gen_extu_i32_i64(t, cc_op);
-    tcg_gen_shli_i64(t, t, 28);
-    tcg_gen_or_i64(o->out, o->out, t);
+    tcg_gen_shri_i64(t2, psw_mask, 16);
+    tcg_gen_andi_i64(t2, t2, 0x0f000000);
+    tcg_gen_or_i64(o->out, o->out, t2);
+    tcg_gen_extu_i32_i64(t2, cc_op);
+    tcg_gen_shli_i64(t2, t2, 28);
+    tcg_gen_or_i64(o->out, o->out, t2);
 }
 
 static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
-- 
2.45.2


