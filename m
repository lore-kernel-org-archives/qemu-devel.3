Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D57DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpdy-0002T5-D4; Thu, 27 Jun 2024 09:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpdx-0002Rs-AS
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpds-0007sq-PW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:58:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f480624d0fso62760185ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719496707; x=1720101507;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=heud5oPL9PguF+0Dl89or/td6O7yLCDZcvUAaJnUzns=;
 b=I1WQV2Z7/+iHdYpOmWF4r/sowSnXcCTZakDB7UKyj36IIPDZJ7zLPZS0aYZS8pV5y/
 sNQW1QuyLT3ENNuRme/oE1EvzdDOWr8o75Du0ZEcK/dx+SJYb6+NY4WmH0Zc6oTvQnw0
 7duVc7p+UDn3v9YHCNsiM/BRxfsQOQvRjZu2T4OeApODY5j5oGVbNOIqVV60QtW98vEF
 o1sW+mHgTXk28qjvuy02oJ5QSrpjQXkB0bcivEt3er/LYjFyOQDCI71nqgv9+2QhnGC+
 A6Il6Bop288gW44fS/qZu4JQiNGFhvgGj2JcLt285D6QnFBX7w0TZnpUJWglkUrVLTsQ
 6jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496707; x=1720101507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heud5oPL9PguF+0Dl89or/td6O7yLCDZcvUAaJnUzns=;
 b=F9IbtfgtnKOwafFKwpt8F9erFpHXXV8ha6e6LgMNTeCmdFsCWODRRmzl+Gm3noFRBL
 k9cw4m2gEFUK+6GtBXb/eeV72MQV3AT8La8KGgehQSHucr2UZ/iKS6/eq2d/EvEIkW0T
 pQ8gMrDT+yhBScfnk9nuMc9nqqze0hzxP55ujgsIKz74p/lhWlG9BcioauuSXvhTQIpF
 OZUu5KBgFrDiKmqe0/O3R3fEqk7UOUheucMqb8AfPbThwpI3Ux+ttTas80+Fnr5eH0dn
 la4rgEHeU9RjYLdMK1EDFScPYTS/k8FAg5LFRy0LcC7EeVfua3f/ukW367BpUqySTLL3
 +AIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8BkvsAFmc8sok+zIliEP4bQVPfQYaKybeka7mPaYMpa2aaBAeSxbbj2KxwQHnxRj15wYONJWsaBppTwmaxwHPkMMZiVk=
X-Gm-Message-State: AOJu0YxphL4MaTcu0ZVloigwMpFq7dvQ4SfGxWHN55Aep22oE1/rnYeF
 1YYJwCBZVcXg4Fzktu5VMVoutzbyD8IYq7B++93mOpyOoYo3fU2Van/P+hPr49c=
X-Google-Smtp-Source: AGHT+IGon+Kh3oEuD1ex29QX/ojEPrLpLRJrh9wy0wfsAUnKEz9YFU2FzV3on1LO4wXqU1vRQAiMJQ==
X-Received: by 2002:a17:902:d505:b0:1fa:ac73:ca2d with SMTP id
 d9443c01a7336-1faac73cb78mr15108605ad.11.1719496707334; 
 Thu, 27 Jun 2024 06:58:27 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8f25a1sm13532155ad.73.2024.06.27.06.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:58:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:58:05 +0900
Subject: [PATCH v2 4/6] tests/tcg/aarch64: Fix irg operand type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-tcg-v2-4-1690a813348e@daynix.com>
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
In-Reply-To: <20240627-tcg-v2-0-1690a813348e@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

irg expects 64-bit integers. Passing a 32-bit integer results in
compilation failure with clang version 18.1.6.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/aarch64/mte-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
index 88dcd617addc..146cad4a0499 100644
--- a/tests/tcg/aarch64/mte-1.c
+++ b/tests/tcg/aarch64/mte-1.c
@@ -15,7 +15,7 @@ int main(int ac, char **av)
     enable_mte(PR_MTE_TCF_NONE);
     p0 = alloc_mte_mem(sizeof(*p0));
 
-    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1l));
     assert(p1 != p0);
     asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
     assert(c == 0);

-- 
2.45.2


