Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC156C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueXu-0001EY-10; Tue, 18 Mar 2025 17:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXn-0001Du-73
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXl-0000ia-4n
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2260c91576aso49620925ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333531; x=1742938331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCoWmgPRVw8+vOgQ2VpvLXdyfprmS+31wGRDcwl1Zz8=;
 b=ckjzLH+7aeZkIhbZ2cx7ew32JnLoMcXkW71RYmo/BF85Hx1dl8WirTC4v2041h914q
 fMslhdDEGzFqH8EbDcbr0N4ZgsF85cwNZo2pKZvu+9REMplJX9s4W2Oh3viz1/IIHSq+
 HrHsUu/ADvH7WHG/csM6zh0GYGCDLqNOkzu8EPs/RhYzhaMsW/kiylRR9Au+eVG6NhxJ
 E2uKW9FtAU3643RxiAx7DX1f4qAm2ehPsY8K+VEjsfz5JUVlcRvFMUYgbiSj9/awXTXJ
 foW6H+itYoK2hkbvH83GU3RQiP4kF+SFRT2VhtHzKEGHaKCsc6o5JU30Gm41E10zNTRJ
 OSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333531; x=1742938331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCoWmgPRVw8+vOgQ2VpvLXdyfprmS+31wGRDcwl1Zz8=;
 b=qMKYIo/xAqMz/yJdlggDTInkRgh3g3XX3j6WOXHY2ng0YfHRapqeSIspBpgymmFoYb
 lOS7laHUH+fURAzOwUmUXfnB979di7Yl4Ku/ZlZP/vJNMXpLFYDh4QL5rlGXWhdu99s3
 FEy5jkSTaxkZ9w+vuw/XqDQAKqQdbJMVVOF49gsDMsonxalaK+aemOa4oXAwvEhYAlwE
 i6Bu7vjzNozzoKBq98mjetaIy70FLimUi4VGHMBwzdRWn9Yj5D8BeNKZrLXsl08FW+sy
 wB/8MVkLrq2AGcW4QNZc41yheZYlxTaDO2BDLeDNmZMzGKCojJTyS/cziNUzyT3Ita8U
 kFxA==
X-Gm-Message-State: AOJu0YxPFHBAl9xO+8K9Vo33Xpb5xmPpU7YRqAC7ecChHKWtBGU7GFwr
 /QMEOlOjm2WuvSLhW2cS70QZp/nt2ajH/2qFJh/i5A6T6latuEPrVUs/mA5A66zwbh+lPJGNvyP
 7
X-Gm-Gg: ASbGncsS+V6erWdToJAJItN/DdCt/zkg0mXGb3slRn0f3zSBDetI73iONx3veVAYlZ0
 r5xuUsuHGi/new78btewnDTMaxHxmY/YrUH5QBiQviwn68aQErY7THtIbKcE/9ZLj9K8TNGvcS/
 SoLF5WbSieFDTKaqvgUIqvO0DIFlYZQdMJQBiCb0bZdMNilnbAjvxcaE2ohVEW3RkEt9/Hj8Egw
 H+zd7twit3D7VXSed3tUsPEdC731tXv0zKpbrE2I7yUkBtvqQajRhwjEgaG7045CDx29W0O7KmB
 o93L9txpyOcUa7rJAwu+TJDiEqLAcRz3sPcIUFGrc89J5mvN7FNm53mOTRke8a38YlS9SJrSH0S
 X
X-Google-Smtp-Source: AGHT+IEKTZyPN+SLbskZb6F0uqkxtGLXMyHMV9hKVTbdBZL/0zld6Xk57CH5/O41CRDLXtW0CFBHJA==
X-Received: by 2002:a05:6a21:692:b0:1f5:79c4:5da0 with SMTP id
 adf61e73a8af0-1fbecd36b70mr288549637.31.1742333531154; 
 Tue, 18 Mar 2025 14:32:11 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 01/42] accel/tcg: Build user-exec-stub.c once
Date: Tue, 18 Mar 2025 14:31:26 -0700
Message-ID: <20250318213209.2579218-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

CONFIG_USER_ONLY == !CONFIG_SYSTEM_ONLY.
Therefore it's cleaner to just add to user_ss.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 38ff227eb0..14bf797fda 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -12,7 +12,6 @@ tcg_specific_ss.add(files(
   'translator.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
   tcg_specific_ss.add(files('plugin-gen.c'))
 endif
@@ -22,6 +21,10 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
 ))
 
+user_ss.add(when: ['CONFIG_TCG'], if_true: files(
+  'user-exec-stub.c',
+))
+
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
-- 
2.43.0


