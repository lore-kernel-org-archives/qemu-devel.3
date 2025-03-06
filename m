Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AB5C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDUd-0004BZ-NS; Thu, 06 Mar 2025 10:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTw-00027M-Ee
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:56 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTu-0006QT-O1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:56 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390d98ae34dso665001f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276193; x=1741880993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LYWY2vE23XQ8tYGl52Ly1mLv0cHxN8U1e33vECpnZa0=;
 b=WoDq2h8W0O4WYxsptfhW71hWaxJbwQ78WtNYH3ROslQLftZFEtekbpJ33EGjETmAbr
 OgtYVO6EhxUMU/VoHD0fCmD8zSf8t2lu+BfqQP/Y2bee7fgKTJ76dN2SguneuofDHhah
 HsSW0vpb27trqjdaTvUOJcIn9hBSqIFHpdwvDgU5O6oGiGHPps5cf5ESgC4TRT8rw3Cx
 O6MQHBSkD7pQjXHQqk6qCymeTGnWm0jM/52murO28wXd7wNzdCJT84qKus7EQtTHiIUl
 b3Vlq/6+27dC21ZXHyha8XCM+EWY16UVnNr3DZa52XRKjiNUuA2+ZGG3rXbm0qbmElfG
 eQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276193; x=1741880993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYWY2vE23XQ8tYGl52Ly1mLv0cHxN8U1e33vECpnZa0=;
 b=AE89iD8Pq+tnY1gtYMdK1LL4xAEph3L9UVsvhX6hwHjVdgL0TC/YgZSPGgKVOGkbLe
 soXxhKaHwadZpDuLwWSnJ3yuzrWJYfC6pduAUGOlX30KpvfPZgWUvKt2as9Hx1W6PbSa
 7S4L5pomUXKJjqdA+rrrNw2NhidavEe+aRDSedK6fLqzh7to21DAF94BuZqhAlKpZEWq
 UgddktBjlkOC5sHURqRKssw1pfaPwDt2wgKDI3z/opQiaDhTpLmZHUSlNsUS0uLWasnU
 pKGOrJOoS+MiMlYsY3a4tLoib29tE24C5gLQkBNrHPppDw0rW9OWYy2Cu9PQoHldS5q4
 hKLQ==
X-Gm-Message-State: AOJu0YyU19egfYQ+Rd+1HO+zX53YrqQWuFYlrYDEhhpRky+0O39p0QSd
 7bAhM3v55k2H2MzB5NrsPicgysYPPt0Pj/AjGFHX+y4uq3X9ukokr76rjUvGtW1QWTaF/yl2JY4
 b6XI=
X-Gm-Gg: ASbGnctudpwduG2xAN00SWVDoUTdqL0MhCO7/uD1LNREpoksOQnLZ21zHs6zD/UExxY
 R1FIdO+iMigHs9bXvwQBTB/H9+tGp1/3n1qfQFKYqvuaKnqcPMsS0QBulvOxJZji9nT2nUslibf
 /ZUci9SAWnA/x30OoWJHvr7Nh/KqMK8VGOm9Q78KVLjvq8+ylPNNm5o/3VEyDGjQKU8CWrI81t6
 JPnaw5zTg+Heebmv/96SCz5Eek+fvMV2F+3J0u/CXpF0Knhpzo1hHdEWyJAjkK59GrXN65uNiGh
 Rd9xo3M2MYuuLQYG/FHgf4WlWXuBbzYXrZixeOiQoSY/Lgh7qrOwgkn4KTDy29mxccG3IglvwZJ
 6jSr3sEbqrMvvBPSdqaA=
X-Google-Smtp-Source: AGHT+IFbIfPYgKgILQiPx7IWkP1wTH6q62+CrK/jaMvNAXceqgLxVz1/pcKyG1d57YRFykHTcOSdNQ==
X-Received: by 2002:a05:6000:154c:b0:390:e7c1:59c0 with SMTP id
 ffacd0b85a97d-3911f75a94dmr6410177f8f.26.1741276192900; 
 Thu, 06 Mar 2025 07:49:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba679sm2381963f8f.8.2025.03.06.07.49.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/54] target/i386/hvf: Variable type fixup in decoder
Date: Thu,  6 Mar 2025 16:47:12 +0100
Message-ID: <20250306154737.70886-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

decode_bytes reads 1, 2, 4, or 8 bytes at a time. The destination
variable should therefore be a uint64_t, not a target_ulong.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Fixes: ff2de1668c9 ("i386: hvf: remove addr_t")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241209203629.74436-9-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/x86_decode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index d6d5894e54b..5fea2dd3cc0 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -61,8 +61,8 @@ uint64_t sign(uint64_t val, int size)
 static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
                                     int size)
 {
-    target_ulong val = 0;
-    
+    uint64_t val = 0;
+
     switch (size) {
     case 1:
     case 2:
-- 
2.47.1


