Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC22CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8S5-00042v-SA; Wed, 29 Oct 2025 11:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S0-00040i-SO
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:04 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rr-0002sN-Io
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:04 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso2896966b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753050; x=1762357850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hu+xToBwuzqdEh5e7QygWn/gh6d7IcoBc8Yowdh0cMI=;
 b=TUs6olxYW87ft+yZ0qCg4D1N6NVzwmaPZJ6j62qF3rHzb1iCBuFBHWafkjAPOEzgvH
 CxEM8tQlm1nsj+6IvE/oFm/jwoaZpOxxEe5W62mcMZ4tbbS/qnYy3B+hCEt5CAI69gYS
 IYlG9lzN17JPhf7r8/G10oxsPhYfylOwdEaLnJr2FIX68ZDLbm/nPuoaY5AW9uVqR0KT
 ZkC9HvIdxFzy1Mpzh9NoPBAUYQewBy6m+G/rWk1EyCfLwcvwSRwjllIkkpVm53j5uWRL
 vLMJx/ebOrU/FbS6m+EVn37ooyqaSkIVorPAn1N7ictzJJkYt5ERYAMb0edFYyN8QAa+
 G6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753050; x=1762357850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hu+xToBwuzqdEh5e7QygWn/gh6d7IcoBc8Yowdh0cMI=;
 b=Jz1f3jrVwq1L1r4BB+9jgpFOVcL0YmgjgaZ5jxrB12sQizz/cGkawAcdxfy0enLLhY
 Yjbwgo49RvtMae21RF25QOSrPgyIIZNaI+/c842lANq3pFafzTmqlUH5g6MnXPoMFrUy
 VLdh7q4yOTa5SDuVJlYYayFVe0DBvuV0mVrrVgVgL9H77hrpCX9TEew9ECwidNe5utLE
 7JCiqEWbb2HnYuNkV/nH2BaHjOtEDBPkFPwsb8NKSE6fE1GU8cLJCU6EqFvXTgsGqc/h
 m/NtsJlIIwexlO2226V42QScpQ4ssyOg348atWzg5/jlXHJtrM3p0S4rKIS/F8w6U464
 kYDg==
X-Gm-Message-State: AOJu0Yw3vHjexzxYGfBEjtG+XPTnI3ioDPgJCRuEKU83FKE0Dw9Vlb0w
 nlpMEzSqqaYKRmGTU1nZRXEcm615V3/E+FSWeJwZ4rHXqSjwp1gOZRohPxWPVGVkh4o=
X-Gm-Gg: ASbGncviT/A3kGKMoMAn6toPxiheFfDp6Qyn9i6Ot4n/QR53C6a6PWPqI1HA2YDjywW
 R8vLwJ5igB60TQ2e7dDiql5sv1ckjiDTERv/t/xOCZhnaOi7JBa4Jwo009uSxC4j6lHn+TC/XJN
 Fwh/2IIterjIv+96EnKA8WyRpyHCoCnuub9UIVEkS0BPt3EI4+gfMR819SXSqmaNTrlElANfrvw
 IC3xYdDZnVTX8n7UJboOF6mgdK9A23ksbRVgp2wunkbj8FIkyI/4eExhfef4eEOWc/sYhruLmA6
 p1ErAH+Ama1DWtB3U0cqmi/yRFJxRHR5yqbb5VfOt52gpypXmIDEb5Bin0StNJOPfMBT261N53B
 CTKlJ7wTvj7paNwmmZtty3D21tgCF5xEiyOMl31++HN27GYOPaEJiByoijgvKZhvsZ9mHYYhza1
 iX
X-Google-Smtp-Source: AGHT+IEoYqd6LgOTMjS+K4kXHYqappYM/LD/Cev18VsgsBQTKFQlotL9UEmjY6uQPSEG1WNjOgfprQ==
X-Received: by 2002:a17:907:a03:b0:b2d:e514:5348 with SMTP id
 a640c23a62f3a-b703d4ae452mr340573266b.33.1761753050347; 
 Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8530905dsm1461341566b.6.2025.10.29.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3EB1B5F9E0;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/35] scripts/ci: allow both Ubuntu or Debian to run upgrade
Date: Wed, 29 Oct 2025 15:50:13 +0000
Message-ID: <20251029155045.257802-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

There is no practical difference between the systems when it comes to
updating the installed system.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251027110344.2289945-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 66bde188755..253d0b759bc 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -24,7 +24,7 @@
         update_cache: yes
         upgrade: yes
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     # the package lists are updated by "make lcitool-refresh"
     - name: Define package list file path
-- 
2.47.3


