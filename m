Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF204D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jko-0001QQ-L0; Tue, 15 Oct 2024 11:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjp-0000VM-J8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjm-0000kl-Qp
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e5827d6a7so2250022b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007129; x=1729611929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL2u07Qpq8qO+o5N1onMiU4q/NHO95fnaXoDim7+gRk=;
 b=fRgP2658NKvQqjuzZQDLtaEjqGp2YYDC51WJUdjAylu74evmIu4u92sCbbp1xZBKpG
 3j4LR1uWiVjM9VGyQ1JFGCaHylhbYmMdEv2+kthEAlJW2wFWEcIgo7XhUZWsNpUcQh6F
 wzzW/azf85T1WYm6ZFOSXZhPyCbBHUjc4UFmd7vwfcLHkeLEvhkjmxX8T6ThWoo3tjHc
 /VgF5I/wL+kPWXLdKrx/Y/fJWD0UPIxigrj5HanjP7tcYVrrz9AI81ftT+aiu80YDBIq
 c71gjCNXEHc+VAcfRv6igZFzY//eIIGAFSdotdccHkCOcb/MLVwAHz4Pe/fuV8LFVHQJ
 IfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007129; x=1729611929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fL2u07Qpq8qO+o5N1onMiU4q/NHO95fnaXoDim7+gRk=;
 b=t3NH7WJNSAUf43p7J9FIZxEPYBev+rqw6r+Pu2OttaCD34Y+2UwUMrOuOB3DDgFmiA
 GMGocVKWAFiSxD5CDouqZFswc1C1MXY3Ph/e6y82VCwKoF2QPBiwMH7NIwcrgMQy8qXO
 002oFLE1ursRnWTDnpSHxIDFfMYaEm7TJH630Vql4/+TgvywHtIAC+/aylIk1Yj0uMcA
 iEIWw2RdvUEmgRqG4z8Ej0R1C8i6jEbkD0qKl4FS36yXnI9jD2CqgA2oJ2rbswWYRzKg
 22Wni6VjtKBqU31RF5QJpmdN1ePmfXT+Xw3lsn/wp85Ucpot8j8XGJ+CMJKqWl0/zeoM
 gjYw==
X-Gm-Message-State: AOJu0YyYurdL5aWiNFYr1vOivke00YyulOR01ORb8zP2BoftC9jHYRTo
 ubHWdVd6GJvD6DUF4NUeDBeW/H69F4pNKYn9UYubixNF0uhO0lv7f2bBEmcOcN+dU44aTwqBlrw
 w
X-Google-Smtp-Source: AGHT+IFVB96zyIMaueeFm3yc+C5/3k/fnCEzDheT0JHm3UDRnymURMXvutSjmKpOd3ML3Ir2D1JE4Q==
X-Received: by 2002:a05:6a21:1789:b0:1c4:9f31:ac9e with SMTP id
 adf61e73a8af0-1d8bcfc21f5mr22118453637.42.1729007129251; 
 Tue, 15 Oct 2024 08:45:29 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392f72108sm1942941a91.47.2024.10.15.08.45.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/33] gdbstub/helpers: Introduce ldtul_$endian_p() helpers
Date: Tue, 15 Oct 2024 12:44:15 -0300
Message-ID: <20241015154443.71763-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Introduce ldtul_le_p() and ldtul_be_p() to use directly
in place of ldtul_p() when a target endianness is fixed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010175246.15779-3-philmd@linaro.org>
---
 include/gdbstub/helpers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 26140ef1ac0..6f7cc48adcb 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -95,9 +95,13 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
+#define ldtul_le_p(addr) ldq_le_p(addr)
+#define ldtul_be_p(addr) ldq_be_p(addr)
 #else
 #define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
 #define ldtul_p(addr) ldl_p(addr)
+#define ldtul_le_p(addr) ldl_le_p(addr)
+#define ldtul_be_p(addr) ldl_be_p(addr)
 #endif
 
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.45.2


