Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F20D2F003
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTH-0000s2-78; Tue, 27 Jan 2026 06:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTE-0000nY-2w
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:56 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wQ-Rb
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so43942625e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514165; x=1770118965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPRnttpGMff0nrpLtf1btVa24s4YYCBdgoaFmwnnBqM=;
 b=qYJSAUjJnJKjajKTIzHcvLrTgaBR8pKRLfKXDDl4Y6lDMg1Bvv2haiKANdRhnvghU5
 QRaPXN29lYUyk3Pwmb8QTfY02HG4ufmbqur5g5foOQ6B0UJdg2fVJM+GyTooxU4xmliX
 oJrvjlrLhySBHeZyv9I0x9LMNdg3r9uuARblVKJOi/IFWo9X3kvRJDlYVHB+uRJYq4b3
 eqRq67a4STq8luhvkaDI+RSJ9XBtIh58r7PCfNAv7iHgNf1/pXAme3Fiqz96oYoi/8QY
 GCG/M2O4ZPBQz+H/lW9YSM+dtG2V8Gd7P3SDUhfnEAwseavWi+hZndxtwh1IBoU9Bevr
 0exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514165; x=1770118965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EPRnttpGMff0nrpLtf1btVa24s4YYCBdgoaFmwnnBqM=;
 b=JlEnRWnr0vSCu+Rl2gGbgy+e7+lnEIqU9M+FN/h/XkALcDhEO8M5rMWmNJAZBRQ3mS
 by2VF/PlXBrScZaJSzcHs+2S/qHsNLMh5eHcXIX/UWYN8c47hi/sjv4Fs7DlRaJ7NheB
 2M7naZGlfEH7RAsWfuNCqKXAnibKKe2J5ygQxRj+VFMNJiCgDP0M9CLGncK73FDhehML
 yRecDiJBSkjgIcvYS963+QgqBxfhVUdJlLdNcUWpqct2nuxY4O0nWf7sEPIQopED6IQU
 vPUn0AcjthoAtR0cBnX/lC3y9VpYjMVeP6dEboUNf0RkpOdFwl6eyvnAsEdJJ9G7oEw2
 lePg==
X-Gm-Message-State: AOJu0YwXZvxNEULCJNB4aLyM8tKbr23kul7osScflfsBehKxWZbzkeaO
 HQpD7Zvbm+H5dMPxivYkHIxpSFsfQGeQ2dtndXFhS3pT0CJ2uErXPfHoxfONo4tr8Rp6Hv5bzJJ
 sIALMt7E=
X-Gm-Gg: AZuq6aLd28YOhZAB2Mz6ZuiG2uP/a0uivBf5kQssvO1J0/DiQalvLvrWGD/xJ38Qv0A
 /6Hd7Ya6TYUsPkDhLFAcW5RAxH9/AXOMVe9bYG+QFyvtKR3sMSgSH/UiNWOsMrxiQFwx34tFXNw
 gSGHWRqThppC6g59i7tyzxM7HbqXNWzpx4Dh+ADXsczA16nWWqcnBMmLnapnAtMWLjbyXAI64Hz
 reUJcLW22kR3AM1JcgWNWBcv2vUaXjjS/sZzu6EsMngxcbDb4y73gG22o7Qpge+GFfX/HmLo/b5
 GsWpJewsFid9oUBchmdeaegWcmdXtXcqmVKH80ma1f4CyUbjvUZrSfjT7rdA6AEAn3WX7a3+RWS
 raHXee5SHG4UMclHAOi2b61Eb4m5xR4v2iEnwWKMcj3QqY7MiVn0vYJqKVhINrmX2lH/lsxKYWq
 DPkF1loi4WBdI=
X-Received: by 2002:a05:600c:8708:b0:480:5678:1fdd with SMTP id
 5b1f17b1804b1-48069c0dea2mr19130155e9.12.1769514164703; 
 Tue, 27 Jan 2026 03:42:44 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d627871sm127629405e9.6.2026.01.27.03.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA2E05F8F1;
 Tue, 27 Jan 2026 11:42:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/9] MAINTAINERS: regularise the status fields
Date: Tue, 27 Jan 2026 11:42:33 +0000
Message-ID: <20260127114240.3009791-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Orphaned isn't a state, Orphan is. Likewise all the other "Odd Fixes"
are capitalised so fix the ones that are not.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260123145750.1200879-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index faa3286fdd1..c7b732c34b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2694,7 +2694,7 @@ F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
 
 pcf8574
-S: Orphaned
+S: Orphan
 F: hw/gpio/pcf8574.c
 F: include/gpio/pcf8574.h
 
@@ -2922,7 +2922,7 @@ S390 3270 device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Collin Walling <walling@linux.ibm.com>
-S: Odd fixes
+S: Odd Fixes
 F: include/hw/s390x/3270-ccw.h
 F: hw/char/terminal3270.c
 F: hw/s390x/3270-ccw.c
@@ -3842,7 +3842,7 @@ F: tests/unit/test-uuid.c
 
 Yank feature
 M: Lukas Straub <lukasstraub2@web.de>
-S: Odd fixes
+S: Odd Fixes
 F: util/yank.c
 F: migration/yank_functions*
 F: tests/unit/test-yank.c
-- 
2.47.3


