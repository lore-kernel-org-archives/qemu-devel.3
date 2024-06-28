Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD330C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN42x-0003Ir-H1; Fri, 28 Jun 2024 01:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42v-0003IX-Pj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42u-0008En-7b
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:17 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-706b53ee183so985082b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719552074; x=1720156874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7+5Sk6k3Qdhdd1bPl+/zET47DgJiYeK1rga8DTRerY=;
 b=YNDYs3y8fjqsDlhEnDOdiPGD2r9jC4MZ1fFsDmri/kR0Rr3pPww+jIhS0IXT2zSB7h
 yIhaCvaaGr47YZZjkeZstnAfOfcqITw7ficzMW+mu89+D7XJob8Hm26Djml8VIn4SWXd
 xRdimOIvBNFZm2rynHVr5aXGjPt9gxf1TCvBeR1r0KcpnBOW2ukWiT/EHt4y1dufbwfi
 Uc8tZK9UCUTTOg0WsAeAkOH+9fG4mczaBdlyxIHWfqWA7J9/ezFuMCcmPXfdl0OCxorJ
 CSbEpg8zq8L5M4pZgKChQbO4T9MJkAc40sLHdAsnPWut6eg2kfMEPa8XKZqlxZFi4EP+
 rEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719552074; x=1720156874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7+5Sk6k3Qdhdd1bPl+/zET47DgJiYeK1rga8DTRerY=;
 b=fG6S4IAZKqS3zB83XG13Z9/+UlGZuFQgXhaPdqFWCUILofaST9cc2PoGz8L2TItNcu
 t3DokVdooBrO1PRCdqkzt4cGE79uXKHTA9JbBm2XzjJf1Rmwtm6nylgUiQtu/uSe9eR7
 Gc/KgYIrrrpAshRJX8gDwow5qyeJjELgSBoTTOBw9mSOV0Jl1VmcH7bEzlac0fuuTp/u
 TSeFahEGWt/aWCuLhFZvV9jJpy4sKEX1/VGHcGQ2uTv0cbSE/8oT3W3L+m0vOYQYh51X
 JMOj2diblfi69hUsdxUDEOGwFBn9F1hY4Lpjase5r3WKhIBob3sCTs9otxcB8KoHYWxQ
 IpsQ==
X-Gm-Message-State: AOJu0YzHV7+U0/cLUL9QBrg229b18pL3Ulh9b0jbRaeaUCWrVGG2LSr4
 F+iPkaYr5WY77zgYZppvp5Mz4pxwv0bBNE69XbdSqoluLg9diN8piLP1UTK4RPS1+YBYnXTdbyt
 +
X-Google-Smtp-Source: AGHT+IHEjHD/Ea2vSOOYlS/c5GY8gJci2bY8gPJcHu8Fs83LIx0vC/o2icRWynl9XXYzUlUA2fNuIQ==
X-Received: by 2002:a05:6a20:a10f:b0:1bc:bd60:e7fa with SMTP id
 adf61e73a8af0-1bee48ff465mr1158861637.2.1719552074375; 
 Thu, 27 Jun 2024 22:21:14 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6b2a16cdsm423932a12.46.2024.06.27.22.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 22:21:13 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 07/11] gdbstub: Make hex conversion function non-internal
Date: Fri, 28 Jun 2024 05:08:46 +0000
Message-Id: <20240628050850.536447-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628050850.536447-1-gustavo.romero@linaro.org>
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
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

Make gdb_hextomem non-internal so it's not confined to use only in
gdbstub.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/internals.h        | 1 -
 include/gdbstub/commands.h | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 34121dc61a..bf5a5c6302 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -107,7 +107,6 @@ static inline int tohex(int v)
 
 void gdb_put_strbuf(void);
 int gdb_put_packet_binary(const char *buf, int len, bool dump);
-void gdb_hextomem(GByteArray *mem, const char *buf, int len);
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len);
 void gdb_memtox(GString *buf, const char *mem, int len);
 void gdb_read_byte(uint8_t ch);
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 306dfdef97..e51f276b40 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -91,4 +91,10 @@ void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
  */
 void gdb_extend_qsupported_features(char *qsupported_features);
 
+/**
+ * Convert a hex string to bytes. Conversion is done per byte, so 2 hex digits
+ * are converted to 1 byte. Invalid hex digits are treated as 0 digits.
+ */
+void gdb_hextomem(GByteArray *mem, const char *buf, int len);
+
 #endif /* GDBSTUB_COMMANDS_H */
-- 
2.34.1


