Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D60CFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTIN-00048Z-Ky; Wed, 07 Jan 2026 08:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIG-0003fT-BF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:44 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIE-00006X-Lz
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so15233155e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791380; x=1768396180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPewYGIgnLtmjiblgvLSQFQTyV7kU6Zgv5bBB5uTL4A=;
 b=ZI9rSZVXClSfkGQumOPhGvAtr2t6qQdwVf97+JO3uDyhI1MIGy7WRgPm6ecrurHeYV
 hTC8NfakP4NnXDThCrUPB2OAJ9zz84I2YqRNxTS20Dn6QD0F8I+BGKWBlAJRYIbiJsA5
 Q2FN+uAbCublOCxGe01YJSdwM+dgVXGmLqZIeig6U4fT1m7j+cMCROAHDFqpen/jWoZc
 VAHbv+HdhfiXammAYN9za0Z7YNG9PF67rIVWAi9KUiQ8w0cXMMj/IccfCGr2x0gcDbwg
 Kfiah6H0mznvlBDXL4AIrvap+Eb49/nmdV51lqBOsorWL7FmMC+vH3mPG884jK+9DrHT
 J4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791380; x=1768396180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aPewYGIgnLtmjiblgvLSQFQTyV7kU6Zgv5bBB5uTL4A=;
 b=V1T6G2qZcgOqJSzWiDZitnnenuvDPXTGHu0moJwhn8F3pUa+srStLCR10C6E4uckaf
 d9bJz5bagJpOhMMgyudnJObjIuW4JYrTiCcsfMQ4tIwBsa+2W1SavJFVPvVVVpLhsdu3
 29UPO8zIdEe8AVwJRXjvziE6Q2OOeuk5Ycale6PLzOA40WTS0lD3jvCT6YwS2Js/ZW9W
 HNUFnAXtVbycB8SVx8Ks4WNq00UZIcZVQqtu6an/WL4boU1dc2r61kJ8kjliXSlm0hkp
 mQ1ayNawaPHKCsoLrnOVPP94DP7dUHzlBH7IFxsWeWCpDtNslzTTFXGGT5cz+ub1cy5R
 RRzA==
X-Gm-Message-State: AOJu0YwLG+fmLkMb71qnL5fdp6WEe/LhXWRpBH5+mCEuP9MwdrAjKYOA
 QCV+tbPoARvGpTDQXLCoU5PsntXUna8GCwhbJ0S96y9N4B0LsD0+LZZHUWk+KVmz82XujhHJdaN
 3F2IecgA=
X-Gm-Gg: AY/fxX7lvMjPTieL7O9CX+xSqe7TTHg7U4zS6TvCy7VPUQthTmJvKbFVoozpxqSrGpb
 akRaTpeqoozPJmjfbDHmQK9SytTdgbmk+rDQ7ZJjNhpTpRP3jbGpv/JTC3+9tSu+doa2Sm4/jFi
 uMhuqVZue7cX6s9zK6jgoIhmyMoNlXa0KO+6OH0+Wm0bEp9jIdznpYvQTlobn8k7N9ge4cMM6i9
 xS7GdrcL89OHyn4A5Em3HZKdEcM0K7bBtsttyg30cs7SNuhG78yKHp9FMyzNAsP5nhDJH3eEqKd
 RxxULRp1JhftSHSIBaBoQzCP/5jMmBMgRflYWdBoCATXBr35wU9Ctm0JMJoiCTkayGB2IaMEPeh
 JslCiS2CSBLdwGkO03ZFUkEwJ16R62g+9aZgfyxa4xtJ0C+ekt8wfdZGHOI41N5qqChpehrmOWm
 TdFHAEzZHHHDO5vTaWBBJYG+RTNKY4u16zpgD1WGEiy1QEVgEjmwxZatrmTGGllrQvhRRnX7c=
X-Google-Smtp-Source: AGHT+IGIRiNxB0NCxGXhSdKhU/qzBcpdcASeChuep496ruNNOu4gsI6rfs31nS9eYBXKnSJv2r7EEw==
X-Received: by 2002:a05:600c:3b1f:b0:477:63dc:be00 with SMTP id
 5b1f17b1804b1-47d84b5b3e6mr25335715e9.25.1767791380271; 
 Wed, 07 Jan 2026 05:09:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5fe83bsm10763021f8f.38.2026.01.07.05.09.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:09:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 13/18] target/s390x: Introduce CHSC_MAX_REQ_LEN definition
Date: Wed,  7 Jan 2026 14:08:01 +0100
Message-ID: <20260107130807.69870-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
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

Since commit 166f1bb7968 ("s390x/ioinst: Rework memory access
in CHSC instruction") the access is no more tied to the page
size. Define CHSC_MAX_REQ_LEN to better express the relation
with the length of the Channel Subsystem Call request.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/ioinst.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 2320dd4c122..d07773d14a3 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -398,6 +398,7 @@ typedef struct ChscResp {
     char data[];
 } QEMU_PACKED ChscResp;
 
+#define CHSC_MAX_REQ_LEN  0x1000
 #define CHSC_MIN_RESP_LEN 0x0008
 
 #define CHSC_SCPD 0x0002
@@ -660,7 +661,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     uint16_t len;
     uint16_t command;
     CPUS390XState *env = &cpu->env;
-    uint8_t buf[TARGET_PAGE_SIZE];
+    uint8_t buf[CHSC_MAX_REQ_LEN];
 
     trace_ioinst("chsc");
     reg = (ipb >> 20) & 0x00f;
@@ -690,7 +691,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return;
     }
-    memset((char *)req + len, 0, TARGET_PAGE_SIZE - len);
+    memset((char *)req + len, 0, CHSC_MAX_REQ_LEN - len);
     res = (void *)((char *)req + len);
     command = be16_to_cpu(req->command);
     trace_ioinst_chsc_cmd(command, len);
-- 
2.52.0


