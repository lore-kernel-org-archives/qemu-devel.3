Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7604EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JNs-0002XB-0R; Tue, 22 Apr 2025 15:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLb-0000Pw-4c
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLY-0006bw-GT
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225477548e1so56979995ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350314; x=1745955114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhN0H72crR7ocnAMdx8d6CUFaK0puwv/7eMWfuXv8/4=;
 b=b0YUwDfauX5GVdda3nQz7lSeuweNyscsaRuFsdmMSzEGyVgiey9ntAfU7mh+IuQrne
 YJdNrDCFbN9jC5eqCEWH3nvs8t5+Hf9VT5sezPK+ycB9OawoohY1UdiI2CUFVXKulB82
 rKMzfRtMoBCOnMnBB3E9hp1SYxWz57crf3Q1IOJRmZHf771gcJbZQA8lU1W7ScXMuHbV
 tzqkcheBfOZidJLFNJ8Gh6c+8s97DMXs01uRVRUHS8En7CZBE21scmvx8vpHlufYh8Gd
 y4DYpnayLFenfwOPl+v1674CyrDXXAZZMLim/up3UvGv9V/3vjAqdpyDR9HkGXkpw47B
 9lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350314; x=1745955114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhN0H72crR7ocnAMdx8d6CUFaK0puwv/7eMWfuXv8/4=;
 b=foJmSajifQU+kX1Pk/UIZMf1M93zDIqZO4xRKrN7CNhVkIeBINV6Varaq4M3T5idM9
 mcoRvsKLN2vjDCVHYth2IAldv9KZlYbKjI8S3bLh8TaDlZC/F2JeWKSzULFRVR2ausPt
 nbFUhEdfiAqiXMvkS3hRzef+1hWNvNNHYzyBGdMYYVr1l0ZJHphmhd42ujFAJAYQtXB7
 qM268xCL9K7HhDnDXQVVxqqaCghIMtPkJDIWnePTmF4goLf5cp3cjirpxg5hXQDWIF8a
 HIsILHj4I8LmE5DECmnUH57Fy6xlNsQGjPBb44qGhECWUYnBbhLVXVoOc3UNXTAl7xEx
 1MMQ==
X-Gm-Message-State: AOJu0YzARaCkaTq5kygpTLFCcFnCLD9WBH5L7FT9QI1uMwP5r6caNMGt
 ZiuruCPZEuktcoBBn4n02JHPHbNO4jloyyvUo9EBC2fsqSxv6rKGOTv0ksQeMYQOLaRXwRqtuYD
 w
X-Gm-Gg: ASbGncspdoukU3WZElURdfR8T8scl0aQQiw749O6S1fHUPTDfNhFVLBG+NyJHfFCdCz
 mFDkdG4u82YopnkqvDj6j/LYdGi9FXgXMeFRoIBvqRDRMChHkLKy57/agvfSPu/8R1sz/mRnEco
 z4qMmNgnxnf0FUObIA4FdNkb4ZW2rtX0OoAHd5a9pAv7hHmzrFsJGT08ARu5s3GKVJMlJksugqk
 XdLJS5SvuZa0wTV0+f4Kg90ISYIAuk8yw9FAP9DJqWH7SqJS7A0DE7MoeoTF6dNgD5C7yI/01Xx
 Bw0kxcqUADaVjvfccSS7MMr4Eg41GHq3+klS5lmR6qh2tJnlJuyczukt/17gVqvky0sG76wUJC0
 =
X-Google-Smtp-Source: AGHT+IGOAwVHM5lv/o9dQBfWAdTUz86nYkbss67V50XaWl3GtQgDcW47BB69GTuwsEuVnds2NhrsuA==
X-Received: by 2002:a17:903:1ce:b0:223:f9a4:3f9c with SMTP id
 d9443c01a7336-22c5337ca0cmr223085375ad.9.1745350314633; 
 Tue, 22 Apr 2025 12:31:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 051/147] plugins: Move api.c, core.c to libuser_ss,
 libsystem_ss
Date: Tue, 22 Apr 2025 12:26:40 -0700
Message-ID: <20250422192819.302784-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Headers used by these files require CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/meson.build b/plugins/meson.build
index 3be8245a69..5383c7b88b 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,5 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c', 'api.c', 'core.c'))
+libuser_ss.add(files('api.c', 'core.c'))
+libsystem_ss.add(files('api.c', 'core.c'))
+
+common_ss.add(files('loader.c'))
 
-- 
2.43.0


