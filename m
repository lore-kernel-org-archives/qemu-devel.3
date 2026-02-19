Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BDFE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Ml-0007Mq-39; Thu, 19 Feb 2026 05:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mj-0007Kq-02
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:37 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mf-00068R-JH
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:36 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso5838885e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497272; x=1772102072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uewsi/mPGL3ids9kCkc0fCnRUOxmgBIwrJlT0/lGETM=;
 b=NTxlVJmlFHDLuylVPrG1qqPEOqGzJHf+wtZ1r2s+b/BbV+ZyNaPt/B+D/C7lFKOdtF
 CmvSnSs2u0iU4dmMGS8OfKKJ0DQCCe7eluPSc8lNGMPLbjs+Exr8lgKf7YKn8buM8/bl
 Il7jYNsDiLWlaYKdPw6AYZb0LKu3rZA3sWwQAUppOad15aJ0TL8izyYwQ7/czQYGjLPB
 YJgWePSLYqKFdVmSrJvhjl+aBa2Z67bIMSBvXf8560MgR2Muhf2po/AuZgSvA+X0p4K2
 cPzCxMK0rmpJFQOsNTKUVhya/zUpUNI13tNN7WKDBBp3rOkBvDg5R+0HOmn1YPBStTKa
 jIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497272; x=1772102072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uewsi/mPGL3ids9kCkc0fCnRUOxmgBIwrJlT0/lGETM=;
 b=wCkO+HnBhWYUE05OI0emtWKRRSAXcEhYZirP4a/5Hnoko3NNIn1aXUccaWDMUeIjgp
 juDcLdQj59jI497N7RNEd7J9qzn3FBl9nD6dmg9iH+0JRhW0oVOLPoknBaKiJ7Folw56
 k/d91hGsdP7gzxVQIWeL0T2lfaeXZDIgfpnjPnSEiDPMu6k5jCXBWu/AayhfRjRDwYra
 DMfEOefzW/LeILoLj/Nt3Vg/uaJV8OsNGqYUxx/IPWcdKTBHQBX9X35vwpAtg9eaQqLy
 h9KasmfHP+vjZa1m390Evy+7HJaL0saQvqu6K2I4YTAERk1X34knZms3YDmNtQds3sPX
 2Q8Q==
X-Gm-Message-State: AOJu0YxvZQxFlI41U5fvKlIGTc8C9xtojXWYHoBcyaV0OpboEArmgDjy
 fYips1z8lupnCWSDGoMg3niKhDyG/PBl/BUHE/+lPTHkYbDzkbios3MkgN6EWJjK7dEpyJc9YQY
 cXkZu
X-Gm-Gg: AZuq6aKrs6NeL2XIOsbPxfq0Wad+CRsS/ijsJxjAAQDBI4Dsjva4RXS3xTf6o6I+Uin
 dNo4fmjwpaWIQcs5oDyC8FRpRWhHY3UPX0/IhqVOtZeSfsrHK2dRg2aHmkG+8LgQMuCM4kx0mno
 rL24C2PpSmLsIQqogvuhkM603j/6ZmYu1twij5txdTz+2ZPIJvpvSv2LhMXo267tMV0m2APOYsl
 zjVgWJ0MFnCVH4PQoMR/KqMIEha7hzk1ZvhVqNnCEj+8/3wki+s0uzjnE3NIM99Eu2y70PzkF0V
 ss3Gmyi2iw7Iqav+3j13YhLHhxwtrtFlrf+6GcYiN1LWbvnemSoxKy/S+t81gjFlwUXQ6LK4v2Q
 dfdtHwYHbRF1V2HXTIQzppjGR199X2lmm2IpMzfIkXQUOgStVABeJgFsIcNpBR9TaeL7q5OcyT2
 /gToOTqbPTuJifTu05C9WHYcZNoMMiTUulmOENwIi5OZDCW8+xG5Ux/DcHP8+iisM9xaARyzX0f
 uPsUSBa0fZvo8INlOyCTZY8e8ryQ3Q=
X-Received: by 2002:a05:600c:8011:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-48398ad6e2bmr79086915e9.17.1771497271803; 
 Thu, 19 Feb 2026 02:34:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/32] target/arm/tcg/cpu-v7m.c: make compilation unit common
Date: Thu, 19 Feb 2026 10:34:01 +0000
Message-ID: <20260219103405.3793357-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-11-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 85277dba8d..cabf65e623 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -49,7 +49,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sve_helper.c',
 ))
 
-arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
+arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(zlib)
-- 
2.43.0


