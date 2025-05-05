Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EA5C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1U-0005hD-3T; Sun, 04 May 2025 21:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0t-00040j-5a
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0p-0002bt-AJ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:58 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so3142845b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409974; x=1747014774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=a5ZrCkDtL56ar5+hzzch8dDPLLjpjZGmmysCI6uCYF7xJWxSlOqF+S86fBAABiL41K
 yJWm45pKQM1PXFzl+Qbz+OFOwW/L7EyZomNOs63mH2QJ/t/2/fMbQAeUaSk96iVM9ikN
 o6mA3j7ErviM2rIsJiDLESLbuF/ahTW6qqE9mdsASYONVH5pSLUZzX8JDmToDm5vW4OL
 AGHqQzLxtElmZHod5mDaaeVpDaEZuiGHSKDvA7v5vKaGyd0EjQjQDZWjTT+Zpltucmbw
 YfiIpM6SBWOptsflWTocdx4mPixm7vt2GAUAiFHMGBuHnZfN7tGjRc0IDtDhsWVxpH5Z
 9+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409974; x=1747014774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=ipkHPgMNvXbz2IonBncPK2ZV+JLe35AWTolxJfm/Unrkjb4/3hY2nMGADTC5Qff/vY
 9sphPQsPwdYLh67pOb+tI3qXZjiRHCmQwLR6NMEOBiEkAtmhxm2eRUgnnRpDUF3z1p4C
 NxOV5fMLQ8/X+DisH/CE12wapKeRdsI8x++6lJ8zTQL3dicrqpmZV+6A2mO4HGWJkxCP
 XagW/45bHk+L7yxTX7NE9/IJiZQSiPrHoL8hh1V74H6TxQucw5V1CAA0blrOyJAIO09Z
 FnbCa1SZCSFlOhGdBt4gryBJO7pAnwLMdUoWAPE+bwimwhrWMz9Prd9vehF38G5Ka6ne
 R70A==
X-Gm-Message-State: AOJu0YzjUGQMLyIrrZuG/hMCrIpCbGvA9vvyQ/6zE+0TAbca0RJRnyTJ
 gVdw/l3lNS7kFyCgAd2wv+vdy+4CYjIt4Uu0sT1Q6uHdsPuEQuKSe97B2G42r2yM3iBLCH6jO62
 U1J8=
X-Gm-Gg: ASbGncuYTXcEK/UhuvOI/ZGBPPbD1aXxxQe7a33wYgbvZRLWdfl4Snq7JOh9/8NdzEK
 3PYdopza6305Z/27MPcFIn/xsB/EwSCA3CXumamD4H0N52Wiyck++dbxX4mG3YpwYI9CFD3+xIm
 szrCitxMF6E/WfOs4C72jkdHD/ebLh0R2QSPT93JWnthE02BesxwlfzDWCC0wO0JSmoHk+Z/hyw
 IKHP7xBRD285tE3AEue/9yUy0IFnGJ35mDqHnRPXtOpG+aySSpnDVzo4OK4p7Uf16mxlUVeXaey
 h4OanL83m6yAEd14SNggVeR9YDCFAuSHc195joy4
X-Google-Smtp-Source: AGHT+IHdlJKhlcZ2kt3ODw4v558rSVu1ViDFZ39o1QmfrNdqy3wKd5aYQgrOUrBoY8TpFSoZhih5EA==
X-Received: by 2002:a05:6a20:72a2:b0:1ee:e655:97ea with SMTP id
 adf61e73a8af0-20e07c0bfdfmr12520841637.41.1746409974048; 
 Sun, 04 May 2025 18:52:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 28/48] target/arm/arch_dump: compile file once (system)
Date: Sun,  4 May 2025 18:52:03 -0700
Message-ID: <20250505015223.3895275-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 06d479570e2..95a2b077dd6 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arch_dump.c',
   'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
+  'arch_dump.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


