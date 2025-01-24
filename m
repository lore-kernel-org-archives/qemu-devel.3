Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034D1C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMev-0003Z4-Kh; Fri, 24 Jan 2025 11:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZh-00069e-8a
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZX-00064i-Cq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436202dd730so16575645e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736215; x=1738341015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1n4b3Sbe/IW5K25A4cb6upe/VFAy/+5L91fnNWowiOo=;
 b=PV8FF46EQSv655R6R1CYir2ekj1t3zcuAJArLS0pADO/Je02iwhQwJRko7wWBY24v6
 kJ0D78uSLjpVZeahmynXUu4MiE4Z/WHo+c70WFLhKGLwc5ZzNE6mFEik+FMsJv7UFQ4J
 CjjHi2XQzkSn+CGTAH9wf5oEgHTzdKHfyDNan5s6lFqSS8/ZI7fRyEK3BIFpw6ye72cP
 BG2RBT0kZeX5UpnO/gWpHBxkRd1F3TuDup5x8Oh/ZGTwXGpoLLAFM47sKUJ/fDANGgnf
 SUkTq3cNmCn7lm3zbR6/Hmbq/NjnLp4/udeS2eqDyzKj92eP05MpW8dcG22c3oF8uAcN
 Z49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736215; x=1738341015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1n4b3Sbe/IW5K25A4cb6upe/VFAy/+5L91fnNWowiOo=;
 b=SzH5QkVsjpxUjexgYmRBv/46YqraMfZOarzLfJzPDA8f1hs+nJdN4J41HI414QrHSv
 DuG5/zbUYaHtCsLF1QPvdyl2IoFu+AESPU6naq9zZdmWxKaf8QqJP4FAPQf+FEDhKcAy
 hEFMvhEvH+LgML6ULeNzH8MILFT8rqfjdX7nnOOyKzQA7EJAQog+m/qQaeP1cWMqtMXl
 C0Yzwhvf4OFn9rAaquytI0LAsg7O+X/4xO1pW65XziC5xLXDBHCkrvb+/VpgufulFlio
 Zkbgc5zMFd+DCxrxC8mUxwSXnyzDRYCJ9aIIHOhHYfUmvwk164085uene8sltvKVdkIg
 z4fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMiN33IcAUQ4UNgkcoGBO5tfHOms/h2PGH5ns7KgE2e8+IoHyClhMuliGF3as7UfbUUeJL0CWNEDTk@nongnu.org
X-Gm-Message-State: AOJu0YzYprbuhD+fmO2XVA6+SwsJqWcpCqwhQftErGpX+L2HXDmU+YA0
 F5eKCItecrSUQcwJAKlOmFv1go8mDSuJ7YxMKUsWNF9rAgMWfRTh0l4SSjlrb3r0d1Pl+1F9oSa
 7
X-Gm-Gg: ASbGnctHZJ55xT/Iqjn3nm1HGt9qTryPFMGCFmn7H9Dw+qVorKMChbpJb/eEb6CdK8G
 KxIyTogA4ETCkb4L0Wa7iCz9gXoGVgVtuAnn59Zk7czG6C7+gRybmA7W6TlMZzAJKAW+LHAX020
 WaekpcfvP+NjOJjGTe8tqaxy2iwehlW0V6KEqRpIqjW7BTu20Bgul5CRN/54K407eRFPrs1dSZX
 cbExH6R5qm2qtyhZ/7eqbNRvfybWf7zhCJUS8l0j1Zkeva9B9zcEXnPnIsgyTOLXpM+x2zb/nx5
 ZkwzKTpYuLs=
X-Google-Smtp-Source: AGHT+IF7e8PjN4Jru9fKkRWpUImsevZ2iOZzFwEiB4Q8wbpknoCa/I5P4/9ts9hLUEGN5f3qdTTwNQ==
X-Received: by 2002:a05:600c:4687:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-438913f2df1mr295380125e9.18.1737736215407; 
 Fri, 24 Jan 2025 08:30:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:30:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 76/76] tests/tcg/x86_64/fma: add test for exact-denormal output
Date: Fri, 24 Jan 2025 16:28:36 +0000
Message-Id: <20250124162836.2332150-77-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add some fma test cases that check for correct handling of FTZ and
for the flag that indicates that the input denormal was consumed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/x86_64/fma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
index 46f863005ed..34219614c0a 100644
--- a/tests/tcg/x86_64/fma.c
+++ b/tests/tcg/x86_64/fma.c
@@ -82,6 +82,18 @@ static testdata tests[] = {
      */
     { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
       0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
+    /*
+     * normal * 0 + a denormal. With FTZ disabled this gives an exact
+     * result (equal to the input denormal) that has consumed the denormal.
+     */
+    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, false,
+      0x8008000000000000, 0x2 }, /* Denormal */
+    /*
+     * With FTZ enabled, this consumes the denormal, returns zero (because
+     * flushed) and indicates also Underflow and Precision.
+     */
+    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, true,
+      0x8000000000000000, 0x32 }, /* Precision, Underflow, Denormal */
 };
 
 int main(void)
-- 
2.34.1


