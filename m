Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB05EA7940
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhc7-0004Nw-El; Wed, 04 Feb 2026 13:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhc1-000476-4y
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbz-00019y-FR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso10601995e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229701; x=1770834501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qdXoLhrWNktizoOz+xJF/JbA7BLhwaH5pSsoPSydNY=;
 b=WFpX8Xzqyp8kw6q1zLnmNwBVVmEZowyp/9Tt9fUYeIhwAqoPsGk+Bn58S4qhWBPLXZ
 2pid27w5kFpZl90dlWEKgM3FuuqVQTSXGR41KpNqfvEr0XB7CwVVlmsRdID/kErOLTPo
 NXrKLUR5Fb4PZfRj8S4JciOXfxqEAq8CE3S2pbVdol/NMrC1Br87YJ0q0gHI5lWUZ7QY
 Qq0P8wMH+3MlLtJF/cJgJYxgTUNAc2thJUgCDUDzUYV+ePDOivzZKTolBAaanVDs6peM
 0BDwFDwukSWrRfulvDhWpizhxHwiKY9j1l0ELZ9vWXy7f1gsUZZ9frQsM9bZrJ+31Ao+
 9XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229701; x=1770834501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1qdXoLhrWNktizoOz+xJF/JbA7BLhwaH5pSsoPSydNY=;
 b=E6aS658lu2evXsqwzTD0SL8FZnGvLcQms1f04ib0kGs0LR3go3LatsMWZGSUr5sICo
 sDU6QrB/uKxXCUe7AGxer9Txztnnn33JcxDXianWi0/E1IpYg371tANLQg89LYu7sfs6
 ULhk3QBl9IiN/dDFIMEoddeH/aH7B1zT24+TYcIrR6F3oQmvZAEv4LahIVaO6fDS74qj
 ObUoM6hAlD/EYE0U7C7+xDO8lJtYfqK3LIGovBSSvUiovqjladHYuEZ05e8oXDs1/Sr9
 0Cn8ui2MLYdns9ZOCJdj16OjFC5kmzplJGe0w/v82U6tdrvj7NBY/j+s7twc53LjR/0J
 uL9A==
X-Gm-Message-State: AOJu0YzlalrnSutSWbiHvJ6KpmVXt8OfD6h0417OToCw7MK9Oj2IvPA1
 yKt8lNBeE5Bax0uq8yP/RseIC6PVkRNIwddi3mxuQB7MAdCve/1lcequHOqPzsl9uP0sm6tzXEv
 j8JcE1L8=
X-Gm-Gg: AZuq6aLDPYJAcz9Rj/3/vOqyI0pkoI3MFRqeXJsYddR6q6f8KYUJAxOGZWblbrZPnCq
 pts+7KPTCoMwDvWQVnYCQBkStCfUBhv/IsbWtfmx2jF9oN9C/CNGFe6ailIY3qNV0wdqMFkbN5y
 qksL0V9HFvjbhDjPpL+0cHkonYwv8bxXW/5ORMBcWPXfL4VUC2MxpwwtIFf/P5FKCO9ex6Z++Va
 ZCp886etCa2KqnCzEf8N/DBUfJS52zHsWPB6E43nYGIWuEaFyg1UJie8lZXWzk5mJVowa4nvJFI
 BZU0EuLnLHaJoss9ryf5xt+BGaYIqBNHaPIxATPdAArVd/m4/BLca4RMoYFKyjYTroyWdGkwqRR
 to9xEkmWjY+rXfyZAOBqFktj2BdSIGY/Kx56zoN7ftBHuOfo34tK+h95mIoa8FBEEzb2ZaN6+AH
 7Oa0NOzer1db2Gf3GQ+XymrJMrqVyuoau8VlvLhmJB+Ya2r1jIExbpfVoAJ8ic
X-Received: by 2002:a05:600c:5619:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-4831791784bmr2497235e9.11.1770229701593; 
 Wed, 04 Feb 2026 10:28:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d4d030sm3049545e9.13.2026.02.04.10.28.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:28:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/9] target/s390x: Expand TCGv type as 64-bit target
Date: Wed,  4 Feb 2026 19:27:21 +0100
Message-ID: <20260204182722.44062-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204182722.44062-1-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The s390x target is a 64-bit one, so TCGv expands to TCGv_i64.
Use the latter which is already used about a hundred times in
this file, and is also more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 540c5a569c0..437f5a4aeb7 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3142,7 +3142,7 @@ static DisasJumpType op_mov2(DisasContext *s, DisasOps *o)
 static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
 {
     int b2 = get_field(s, b2);
-    TCGv ar1 = tcg_temp_new_i64();
+    TCGv_i64 ar1 = tcg_temp_new_i64();
     int r1 = get_field(s, r1);
 
     o->out = o->in2;
@@ -5743,9 +5743,9 @@ static void in2_a2(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_a2 0
 
-static TCGv gen_ri2(DisasContext *s)
+static TCGv_i64 gen_ri2(DisasContext *s)
 {
-    TCGv ri2 = NULL;
+    TCGv_i64 ri2 = NULL;
     bool is_imm;
     int imm;
 
-- 
2.52.0


