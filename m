Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E35EC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 17:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro5C1-0002jd-U0; Sat, 23 Mar 2024 13:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C0-0002jU-D1
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5By-0005tg-O5
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e036b76725so23062375ad.1
 for <qemu-devel@nongnu.org>; Sat, 23 Mar 2024 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711215001; x=1711819801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUaBJKSO6H1bbGryp1PQTqH1TE2lEnHyVoVrY4Z6LJ4=;
 b=EKUQBHz/gWiXootyOgWrvCZyndOG6d6PZhWUr9CRXifHOo4swQlQZJCynMp3US5bAi
 QQY137/SB4CISSeVML3f/KaqadQaguc0o4MoXmcderDA6GSp0RpKj5GV3EoQ/oksyHzY
 CoWurv8teL8wg683+8LX2ChcONRB8Jcq6/TqB+FkqjMIRN1UY9D/NwQKMt2KKbQU/BuQ
 8qofkMktOPLbm18UL+DYHZiOu9cczjpz3JpxQiz7W28HIndk/NJn6qEG2BSsECcojcee
 znX2rGAduqgpnE/ncJq0g1Aixo3sE88CYZklDlwLHj8oeFrGlqDj22AdZu+2dhL0DmxY
 aI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711215001; x=1711819801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUaBJKSO6H1bbGryp1PQTqH1TE2lEnHyVoVrY4Z6LJ4=;
 b=pgAp4sf6JC1aK5rdiCJNzNJAMZdezGBm+R+DCxx+rYj7zEdjlo2mIAn+42MucLkybZ
 OA9Q8lqgLUVeN+817kAhCPeBOC/lWeTXyTIWF+4TezckLyaqluo6TFPVteKdaTPbEc6g
 K5Gw7avEpHCv5Qv0NGz+SOxo6majCkMDgIStrrrKBIFqVooUVbsCxQ8Azg/i26H5drZR
 L4PSUGBQcTOYwYM4iJR0qQNjoUw2eh98/vRmWMYcDUWBA6ZUG1HBlo0vWEW653S6WgPN
 9vD2DQK+MTjOhRpbb6xFwT6ytFgfZ/BPOFHARdZoXG9ezPdHGtPj/KDJ0Grv/VT9gF0d
 Rqyw==
X-Gm-Message-State: AOJu0YyV9TIrFd8pWjgVU9CJK9DBL8XLRqpQZgk7Gw6z5MLXaLKjNnb5
 Cr8xIVsapMgLO6RynbrQZoWPIB5FHMAkrzCJxzSaFMjW0TPZAE8RwgdT2ayTiW8aElRm7N3L5vr
 X
X-Google-Smtp-Source: AGHT+IFGoxjdaizMWgMcVEb0sCy8IeIqKCiVhhAWD8E6hyVywhwuNbEu9Otl4VO4PcD2uP9bLLv+Nw==
X-Received: by 2002:a17:902:c412:b0:1e0:a7c0:1806 with SMTP id
 k18-20020a170902c41200b001e0a7c01806mr1948749plk.25.1711215001297; 
 Sat, 23 Mar 2024 10:30:01 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm1811758plc.104.2024.03.23.10.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 10:30:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org, deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] target/hppa: Fix B,GATE for wide mode
Date: Sat, 23 Mar 2024 07:29:49 -1000
Message-Id: <20240323172954.1041480-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240323172954.1041480-1-richard.henderson@linaro.org>
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Do not clobber the high bits of the address by using a 32-bit deposit.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1766a63001..f875d76a23 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3880,7 +3880,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         }
         /* No change for non-gateway pages or for priv decrease.  */
         if (type >= 4 && type - 4 < ctx->privilege) {
-            dest = deposit32(dest, 0, 2, type - 4);
+            dest = deposit64(dest, 0, 2, type - 4);
         }
     } else {
         dest &= -4;  /* priv = 0 */
-- 
2.34.1


