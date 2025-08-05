Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA565C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLW8-0008HG-DL; Tue, 05 Aug 2025 13:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLVv-0008Cu-60
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:31:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLVs-0004rw-Kv
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:31:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so4953296f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415107; x=1755019907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KR14e+wm0fzVOeoLpnJ3oijAHGMwneBum+gvtRg3F/I=;
 b=kQK1p+6RY1lSWXcnNuonyE1aeYSuRYQRpBxuAcZifNEEh1OoZDvW7B3h/m9gxafSc8
 dIGttagoOpFNDtNEvruDfhP1/NLyZBkHkY5tgFEbhiUjDwhyzbzXlWi5hPwU0SSUnxdh
 mPTT1Rh5v6RyUsliS7WIbp9ABEQIyKY8UGbDSHku1yr5Zk63ZM+jPPj3g49gnMNpL3PW
 mWCg1GB7ZKABWfSxqamMTeHmE/sSVB66YjlpdYgtw0VOla7mGl88Fp/AdA2gbs2OgNY7
 F0DHnbCeD8p3c0w61CQ1vKy7AiPAO+Bx00D8mJaAYCPcLVFeO0KF/edPvspo7D5mlKrt
 yPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415107; x=1755019907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KR14e+wm0fzVOeoLpnJ3oijAHGMwneBum+gvtRg3F/I=;
 b=CN2eh45Vlm0AU74ezfKrmK0LTt5DdasFaF0DBQ4DU7E11l3WNDgYrWj/dOEUpUjkHw
 cMOAD/agaCOpzW957av7QCMuNM0pdxA8wHtuMs7yk+RLa+G9PPn0GBGMMiqOqiMgXL0d
 jazHc1KxzyhciAxdMu8OI13t/5NojC6/D6XPm6SFYCfHw6tJemP6DpSxjAiLJaKydKes
 zDnSeK7u5xRJjSBHYhEXLQGS6KNg1AxJTU/ewqGkXuHeWeoSM5Qy4PBS4u1cdbg5aFwB
 NgG03ER18TUXJWFVqWpN/TbCncHwhfnSumZVMn1epY+PtIDjrka0kK/im1Y+CsToXviu
 JVBQ==
X-Gm-Message-State: AOJu0YxdaF4Ey7PtdR3uY5NbC/Up/uScPQyTVKCkIvdbr0FCYFih/hjp
 Kjq9CW7/NGjswvqTsWfMtks2Jo+DRskg1gYLNvOneG/j3u6AoSety2R2u2hk+Lb5mU6iqVnGAHa
 0rp+w
X-Gm-Gg: ASbGncuGt+kmyRPLYJa/4OQeQsaIW70Xd1Q83seI1i4F6Jw1WQmDJ1Etxd4e5MBtYcu
 7bRzU2LDnleV/inqvEJreL1ZeDB3FtWoTY9bVG7iHyMy+no+14SMLzS1GdQgX6xPr6eFNLFZORt
 rgarFvt0L9Kl/fz5nL20nOSxbMafPpxd2DIKE6sItBoNNhLgbRKrdh7/U+xU8SzmITfvqiuqbXJ
 xin+/CNGbkk3IEq56WCblEAA5KPeyOwYWyTzUqqTGnsw5e5pOXsKwLqesHtfEi+c27tuEJagjTk
 b8MuSl5x5DEwYpT6M/shjmzJL5Gu4J7/QJZXU7Dx5A4Kge/nI2ouunGPbQTvv23RRFO1ks7oXkf
 JiXrp/1bpRCMNdCWlnwsPXlKELApudwTergU2Jpp5FbpVWGwxyepj/VhQSXRYIX4/lyXSqTs7Ob
 gpCZJxIh8=
X-Google-Smtp-Source: AGHT+IFHWP6nld33QF3eJrrRR+ZR0hGOoMABlpV7IOhTK6XfsYkAFhRPqMu28c5JEgm/j3eVZfbEZA==
X-Received: by 2002:a05:6000:2083:b0:3b8:d893:5234 with SMTP id
 ffacd0b85a97d-3b8d94c4772mr11229118f8f.47.1754415106602; 
 Tue, 05 Aug 2025 10:31:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c51e2sm19487552f8f.32.2025.08.05.10.31.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:31:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 02/13] hw/sd/sdcard: Factor sd_response_size() out
Date: Tue,  5 Aug 2025 19:31:23 +0200
Message-ID: <20250805173135.38045-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Set @rsplen once before switching to fill the response buffer.
This will allow to assert in a single place that the buffer is
big enough to be filled with the response.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250804133406.17456-3-philmd@linaro.org>
---
 hw/sd/sd.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0bb385268ed..76ce54664f2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -729,6 +729,33 @@ static int sd_req_crc_validate(SDRequest *req)
     return sd_crc7(buffer, 5) != req->crc;  /* TODO */
 }
 
+static size_t sd_response_size(SDState *sd, sd_rsp_type_t rtype)
+{
+    switch (rtype) {
+    case sd_r1:
+    case sd_r1b:
+        return 4;
+
+    case sd_r2_i:
+    case sd_r2_s:
+        return 16;
+
+    case sd_r3:
+    case sd_r7:
+        return 4;
+
+    case sd_r6:
+        return 4;
+
+    case sd_r0:
+    case sd_illegal:
+        return 0;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
 {
     stl_be_p(response, sd->card_status);
@@ -2203,36 +2230,32 @@ static int sd_do_command(SDState *sd, SDRequest *req,
     }
 
 send_response:
+    rsplen = sd_response_size(sd, rtype);
+
     switch (rtype) {
     case sd_r1:
     case sd_r1b:
         sd_response_r1_make(sd, response);
-        rsplen = 4;
         break;
 
     case sd_r2_i:
         memcpy(response, sd->cid, sizeof(sd->cid));
-        rsplen = 16;
         break;
 
     case sd_r2_s:
         memcpy(response, sd->csd, sizeof(sd->csd));
-        rsplen = 16;
         break;
 
     case sd_r3:
         sd_response_r3_make(sd, response);
-        rsplen = 4;
         break;
 
     case sd_r6:
         sd_response_r6_make(sd, response);
-        rsplen = 4;
         break;
 
     case sd_r7:
         sd_response_r7_make(sd, response);
-        rsplen = 4;
         break;
 
     case sd_r0:
@@ -2244,7 +2267,6 @@ send_response:
         sd->data_offset = 0;
         /* fall-through */
     case sd_illegal:
-        rsplen = 0;
         break;
     default:
         g_assert_not_reached();
-- 
2.49.0


