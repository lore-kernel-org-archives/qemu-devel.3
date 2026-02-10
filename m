Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BA8EB271F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 22:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpwZa-0003tJ-JZ; Tue, 10 Feb 2026 17:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpwZY-0003t1-Pq
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:51:08 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpwZW-0005jO-CP
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:51:08 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a7d98c1879so35159575ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770763864; x=1771368664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K1aIOziDuDsl5PmJsCFUlKmIRcmKVdsVef5jhLtgAhI=;
 b=FgADgUVQzaHKZJU+JZj5L2v3fyj5qJf3ahErUJ0mPm0q9Pipp0DSRvB9CT0/NPG5sH
 BoA71alWgqg5Ci5fUOf2W9G5+CP/JFumyTqd8euJbLtjoJxdN85ksbl8kck/9YKkgDC9
 WQ0++oiYovg/dUb2OBpPHEy4/7zWwGHsMmGruz9KxUxAy+4JkiPjqy7ezOtPShDs1Ojq
 kQT9KI+9iA6JRBJ7RRVCGRcGWTLnzUTfP1TM+VaWz9oZl3u5gC9nS+T0CcT/0v0m93Hj
 Kkn7tcDpcHtKz543MYWBOfdqNVcTkKy/yM2rLCU45ZNjZTzvkNQNUQrk5/UCwwzErcIP
 4uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770763864; x=1771368664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1aIOziDuDsl5PmJsCFUlKmIRcmKVdsVef5jhLtgAhI=;
 b=II6lKPUlsm5mg4yEHkfVRjsvEdaRLlFngLI4QBKg25N7eJnHBQXIBU818mASj0ZL0F
 OdXG91CBSRHyxvf5qHz9X93ejzrAiHAxuOwUldqLXjZiuTDDjnRZqUTzAtQba6fPTbJP
 KGcHnPZ/TdrdviO88vOlFb/dEG4QWBnlqBQSK5+pAIJQjc4pmPdYTMOxIJKd3t9gB1vp
 apw0sv+pzTZXc29DA9N3cGhbUVj7O3TCiJmyuCzUvfpbhOCqQ7G+NfeX8poQpVBAtTzQ
 Bsn9E6hqWPe+z6Kb0Bc7ddELREaJrgaFGTm6fXVKjiqqoT/cih9j2SiK19uZrS9vPJm5
 Pvow==
X-Gm-Message-State: AOJu0Yw36IkwrhhDo0A9IbqExWFNgyk/fD7UT6CnSuE01lc4nHIufBGy
 /4cgcQz3g3N5yXYm4Cyj9OsFY8suoHyIuQSmdo/KstBGFlAHDZt8mGzKVG3Twf1oOm+faFJQCe4
 sxhmk
X-Gm-Gg: AZuq6aLELW/q6+2XjUiMQ/+E4nETfVUZesJoGxNtcQNW/yZsf547ekGMCPUM108s8Ij
 zm9efG3noNlRS2t78r+RlFfkW8a8PBXXVWA/Qn8yz2IVQmTEs2nB+Em35YdrEBnanu4PZ4lJhkE
 NPS/zpta45a9TrMJvVWG8w3R1qTuyswm3LfqcTUfm5k7cRighLe4KX9VLp4Y8i6oIjL98TKwZeN
 CxrGQlzdgaPHXQ8Rcfv1m7mgD2+pbOCDahm1Y/muQUCfcYFnyt28G4eMHSNfQ69Cjw0yYHb9Tgx
 h9xnetH3P8Pka9oYhudP5SenSdo4EXJyCKSg5R7MAGYJjZWpsGmavpObjTi1Hkl3qX0mNyvWgSr
 uNCs93U6eeMVBjAjHN/3y5QK+/kITwRmhzLoCHO0Yzf81EiFuijoUJqFR5fSy7F8riO3gRQyCF9
 qPW+rzQYjha5ffHoDHZejeObfHn2ffOYEBwsHVwLPyybEKIeLHvZ1c4vLZkZHcK3fme90bhnT+2
 y9z
X-Received: by 2002:a17:902:f547:b0:2a0:b7d3:eec5 with SMTP id
 d9443c01a7336-2ab106e69e3mr37787085ad.33.1770763864475; 
 Tue, 10 Feb 2026 14:51:04 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29999ce2sm1197055ad.92.2026.02.10.14.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 14:51:04 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/1] Plugins: fix windows cross compilation
Date: Tue, 10 Feb 2026 14:50:59 -0800
Message-ID: <20260210225100.1573968-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:

  Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins_llvm_dlltool-20260210

for you to fetch changes up to b0353beebb0c4fa4059c88362561a8362ada8b4c:

  plugins: fix cross-build using LLVM for Windows targets (2026-02-10 12:58:31 -0800)

----------------------------------------------------------------
plugins: fix cross-build using LLVM for Windows targets (Mohamed Mediouni <mohamed@unpredictable.fr>)

----------------------------------------------------------------
Mohamed Mediouni (1):
      plugins: fix cross-build using LLVM for Windows targets

 plugins/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

