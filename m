Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28011C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5gu-0003gT-Cu; Mon, 03 Jun 2024 07:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gh-0003Ng-Cy
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gf-0006CA-TO
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f44b42e9a6so32490365ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413432; x=1718018232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPlluaU0uKur6NZ6KKIaWWCj2wxgWKV0EN/SjQ103ro=;
 b=jXWytTWX0bB4HpwyMvUEpJnDYIGLFyCtEdToQRR7h0OLcVtPGNoT5Hq+/9BCKmoBo7
 wSS1icDfc2q4IkDkrw2lKcONfJdV8kfovFXNaY0fjjcs5CZGf/1+xj7vcnmdXLfU/YRZ
 Wd2MlcZSTHFFzkJAtjP5OSQVdICUVVgnva4qQtk/hfoM6K90iejo0PACHcVuA6SXHQgU
 fX15dugsIXz6tMgBCYeS8SlcLJGcKiWxiwzndsPZBaFgbowF8e+1b4ILsyjTMxd55ZiY
 HasF2fARUjmPXzNQSKksqvBPj7YqDv+S8VMav6HJwFat1G534YKH69dyfoRFOlXP2Md6
 T+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413432; x=1718018232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPlluaU0uKur6NZ6KKIaWWCj2wxgWKV0EN/SjQ103ro=;
 b=kzqs4CxF/p04eApmBMz80+KRS4WGIf2ieXjFv3Rfk6ISSzSTs9XKnkQHOunLjTYFf7
 FrUT2BSr+OZZQdC/DN/s2CbuEIX+nyiIjCAX5azrl9uwNClxlk7290fJvM4u4LGz7uub
 L3lwyvUSfSviCs3dpRWTlst2AF0C+dBedMfF00ibMviv6YzkenN/q9QjUZqw/K/YADje
 DNTHl7Fvb/vtBo4BR3Pp5XVlOtny7R6XpH3MBZZOdMMnAfFMyUaH5TqkoHQcOihN1LyG
 BzoBwhynZzA7U8wSbOT6uvtx3ri/QvDDflAyh9lpeWPn5SoEKPb3qUhiM7KeF1ok2420
 uMoQ==
X-Gm-Message-State: AOJu0Yx2q2wawxt1UnXrUXVobBe4aSGgTOnNICMhpJFkR8nkMMtwwqlO
 0AeDmEFHkUMUPekMUF/98mq7CYhwks52v5UurMzt6D/LJiAWdvR6fhY4hg==
X-Google-Smtp-Source: AGHT+IHSY8JWmT+z224LIAc6GWB8TdcnuxE5APhTM8lB5gLJEwdmPt5w9IHO3b6tZlsUjChYTR680g==
X-Received: by 2002:a17:903:32cf:b0:1e4:9c2f:d343 with SMTP id
 d9443c01a7336-1f636fe87b4mr94280805ad.7.1717413431706; 
 Mon, 03 Jun 2024 04:17:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 06/27] target/riscv: change RISCV_EXCP_SEMIHOST exception
 number to 63
Date: Mon,  3 Jun 2024 21:16:22 +1000
Message-ID: <20240603111643.258712-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Clément Léger <cleger@rivosinc.com>

The current semihost exception number (16) is a reserved number (range
[16-17]). The upcoming double trap specification uses that number for
the double trap exception. Since the privileged spec (Table 22) defines
ranges for custom uses change the semihosting exception number to 63
which belongs to the range [48-63] in order to avoid any future
collisions with reserved exception.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240422135840.1959967-1-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fc2068ee4d..74318a925c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -670,11 +670,11 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
-    RISCV_EXCP_SEMIHOST = 0x10,
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
     RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
     RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
     RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT = 0x17,
+    RISCV_EXCP_SEMIHOST = 0x3f,
 } RISCVException;
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
-- 
2.45.1


