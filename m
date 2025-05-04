Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E739C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvO-0002TM-FE; Sun, 04 May 2025 01:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvF-0002LL-Vg
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvE-0004Si-75
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c33677183so39687195ad.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336591; x=1746941391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=iLtjL+pgKKaOB7mYYIADOtOkeAQHhRhxRBXoWtevVtj1ajmyWfEp8kzl9jffjJ7tVo
 5/L4KLraKbanJPP/djhfcevuBbemz6CqtUgEDXwtxJFq49c0yRXFrzOrWQJWkeVgIs1x
 yzmYpSMriH/AoqRdVHIl28ZyHUgB7pJUrjLpz6cu6cOQljd/wj94XIbkFj7/iBEx+WbC
 5MHdX5aXxdDnQAeMt/5j3ivQZwRdVsNWH97qfALX3jmKYB8flzaIlIC7rCfiJkKn8wOF
 OGSZf2CmGivZotrP85E5Y4xS6TgGMT1A4yo5E5qCHP8V78oC542euVIZGBcJCHUlaesG
 O/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336591; x=1746941391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=eWIuanFUWJ3eEmwrvM2JIbBmjj6uBRll+L6drO5M1OOuCaTfCACS0tg5+LdADNL3xJ
 Pca1tfv8qsP1PvdCULC6uhUt7gSIraSkvNm2zapujdiWPa2pmhGYLANXmwPfWzJjMZCx
 bdwy3djBvDdoXkq7b5YNqZ068xQcxxxMBSjF+3pmJ2CVMIKxuQ5H4DMMFnuLPa8I+z+E
 4Hn/Y+Zt3DmyGWwT1jokNH0UdTlC6FTT8J62d7vg/fjdh8X/rBIuPVBS6lTGeYEwLQZ7
 I5n+EkQZ+FQP899dV3tCrNDjyYJM1vbioB4Lha0lY3teE5igA99OSBsWneMWvHSOmUtW
 d/Yw==
X-Gm-Message-State: AOJu0Yzc0EmughDzmRqmYPONmw+vQzTKhW+V7KVVAzD1ZlkfS/cuLOvQ
 XdADJig/7TW1Od/bFWz8Atawya9ZD2e5IOrdKK3MOYpArp1aNvYtE/mix0ntJ4v3mFmCyv1BWYl
 kDCw=
X-Gm-Gg: ASbGnctaSLPjxYhNrJz17TKcuSbPkgn1pVt8TmXNqVj+OgHvrbELiX6ZgRVSb9vWmHq
 kmEHx+8BipCetRE5kHk+0rplPXTezEg4OJI/yqZoHwZJBiul5AChge7ISO0X0J6XmDoIFiC/B7x
 IaDYa77rfoSULO62Yflhv+/AIG1cd43lWjp8pDLP5GVw/gbsNqhxVrwH0lLbKSJt2kVPl2fos1d
 9fNxVc0xBUFVnWnw1BRU0IJWzMCM87EIiex8A9XVCh9o41u2+peTwKwEfs3TNXy3mr8bALyuJJ3
 GOrZ13h1WTvZR+N1oemX7p9PP8HWGVm9yy45/7/l
X-Google-Smtp-Source: AGHT+IEw7LdFolSK1L01aWRSXu0ZYhSFBV06ZwXjbG/l61w2CauR9M4H+Y+brnPiGKAodZUYp8tXtg==
X-Received: by 2002:a17:903:19eb:b0:224:1eab:97b2 with SMTP id
 d9443c01a7336-22e1ec3e7c7mr45995215ad.53.1746336590793; 
 Sat, 03 May 2025 22:29:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 35/40] target/arm/kvm-stub: compile file once (system)
Date: Sat,  3 May 2025 22:29:09 -0700
Message-ID: <20250504052914.3525365-36-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 29a36fb3c5e..bb1c09676d5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,7 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
@@ -32,6 +32,7 @@ arm_user_ss.add(files(
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
-- 
2.47.2


