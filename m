Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8F9CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3I9-0004cT-KI; Thu, 21 May 2026 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hl-000466-VI
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:02 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hg-0008SA-Ry
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so2661984f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369467; x=1779974267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3yYafY8TJmCrFTnnXsB+UoyMxcWEdJ2PX05QeDqqFg=;
 b=KQhjupdc6rVwk5uIjFctuDfPm0PyeJGAC2syoghxUzzTGEkV9E1FMBzfKr33+SmUzs
 NZm3ZEaCW3EOMwgSScdclfhnF0e+i1aFOGEmIK8N4BYyuNPin0osO8HtnwoZr4N1ZjgW
 FrmKOU1rsMoNERo9oB5c8BprEi1sZtKnK0CuOXRc39f0yhJohU/lYDsgICJTKhTzEkgU
 LRJ80RIJieknxSsRcHJORxV0B/f+Qz/Br2L/iSTd0mDTUm79QwnvS6SBv5x0HozPoNFV
 c3CqnH+V0pDENurOnyQsa17g5rVPfqAmkCzMWy+5LPWUR10ZEtM+hAgoYuFWsjXH7P0d
 LfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369467; x=1779974267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3yYafY8TJmCrFTnnXsB+UoyMxcWEdJ2PX05QeDqqFg=;
 b=U1dBr2w60A045gXIjI63sMveq2sdsSwUfyAbAvAFRk5a8rE2/vNj2vSVkiKNmXYlTj
 yJIXFMjb17zqM6mXzd9c4tieevEN64Qlb2y1loNlOWtzwQbOAks47Y6xFac3sAA9WFH2
 cqFLJ6lv8s1d2TVs5A57xdw9G1R0ylMVFXAJNS/PgCIMEh4MrjKJbr/zGKz/Wqx8MbsW
 ascJ6kPILCkBKVhXEO53ZrZ5elxhNLml6ZabMaI1Olsu748gKIHPzUB5ktGhkSySe50M
 SfgmHpJTfMTIAREhMoORwmZMYRfOZ2/wsUYJLcme5tDmGDvjv+X8mk1DFVQuV+Ca+/80
 Ukbg==
X-Gm-Message-State: AOJu0YyveNfeU5ddQrQrZB9c3JB0Z1ruSNU5FIFNXrzPGKk5o5KpT715
 B9VwP5M4BqikBqwH4V5VhiYyC5oOszgAa4/6IaoDme/XSvZTssCNXJLmNHO5DKCsYjk=
X-Gm-Gg: Acq92OG4pYbvaT9WOIeHkC3ngAwH1GtsLLV1+9XPCOmcJhO1U1uTKQPwJUb40url6F/
 4Lp61+tsHDjCXVdoigqN87ufNbvAOUJagF1Z9Zrc/Kae3EIdQq84rPe/b7QELpogJPxqDhX6b0k
 4haYgOyQh+R9zxeMwgRynf4EvZKhHy1RzqXBYXmln6eh15wEnUcBGznFu2+P0osh5gykj/8JXEP
 RQE+MQ7U81t75Xn01sM+vncmclwSNGE4W7iyTDQAH0kTKoKpC+8eGSNU9fJq8up2BadpVBJSant
 Jze2GDSgL7RCdz5kuRDWQTxB/iZVFoojZ9vw5oKZCTaQBzZXLDEXfUcRhgPvG9yq3RCUh56rr4R
 bH2LznUdkckLcJLd1AHIv7wpUeUibv9bkRmxzrmViIgKRyqwiBGA8mF4ZSWg8kMl41Ru5uhb7oX
 OD82p/cknkE5vDdaaWiJKUs7rjVmuJlI2GJw==
X-Received: by 2002:a05:6000:430b:b0:45c:1c89:b1c6 with SMTP id
 ffacd0b85a97d-45ea3bef175mr4903860f8f.33.1779369466607; 
 Thu, 21 May 2026 06:17:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7cf1c2sm2827719f8f.4.2026.05.21.06.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 09BEF60338;
 Thu, 21 May 2026 14:17:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 08/16] gitlab: update issue template for binary test cases
Date: Thu, 21 May 2026 14:17:30 +0100
Message-ID: <20260521131739.540157-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Binary test cases are sketchy because they can be vectors for phishing
and other malware. Lets strongly hint that source bases tests are
preferred and binaries should have their provenance declared.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260511161757.105994-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab/issue_templates/bug.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug.md
index 53a79f58284..e20f586008d 100644
--- a/.gitlab/issue_templates/bug.md
+++ b/.gitlab/issue_templates/bug.md
@@ -55,6 +55,10 @@ https://www.qemu.org/contribute/security-process/
 <!--
 Attach logs, stack traces, screenshots, etc. Compress the files if necessary.
 If using libvirt, libvirt logs and XML domain information may be relevant.
+
+If attaching binary test cases you should describe where they were obtained
+from, preferably linking to the original source. We greatly prefer test cases in
+the form of source code that can be audited before compiling by the engineer.
 -->
 
 <!--
-- 
2.47.3


