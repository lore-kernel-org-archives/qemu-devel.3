Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045D5CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShGy-0006U4-V7; Thu, 28 May 2026 16:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGx-0006PT-1t
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGv-0004lE-4c
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso7493897f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999843; x=1780604643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RYFINop6p56kZCsuAs8/Iw2R8r5qzUVy0JocaJvYfm0=;
 b=SQ0U3W/crA0KSJvgfGNI2SqQbxddEJ47iDtSz4XN7BkkdEBmCsJ6FEyh7g/fSPnkVQ
 geFSCWndluJ3TA4YP9iTOynFyf6TjGaR/fPjWADaAM8Fqt1Y8ihToD9WBvUtuMn+mNOX
 PLEV2IBXKob8L2fN8lOnu2v4HO1JIt+zW60ldPs1fC4XpWNVcwzMQcB0VCS+/bJFGfpZ
 SP6DqBdME2CE+jUPuKEXJ21gi9GJuZUpYhOHat27NzuUtgymkT9qmSiHm9862tUwlPWv
 RrTEyryXnr0JPkxo5WD7FrjeFTZsSsfjwmBO/UEqyyMHndO1lOY+aE2cUajWKb/2TRqA
 FojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999843; x=1780604643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RYFINop6p56kZCsuAs8/Iw2R8r5qzUVy0JocaJvYfm0=;
 b=lnnvEmS531a54OmpB5jswU7UbVUlrw1V+arHS5u27f0HyD4ktXyrAbTeODCpIr6MwG
 QQ9TL5r1bqESCm/flri4dvXrhdQzTxmX5X2lSKDcPYNZZmh1WGrskr00Acroe1DZwFxF
 X0EgjI6+LsVPSPlRmCprLexlmgBCo13qAjbs5xdva5Wlx7zC1v7JT8dQ3hVq8SLueSS3
 XKqh3hn/yiyybGLwcbCId757GIMMGf2fiuRUbr6vOnIUnewzJUdgjfUpp411vUwHCDdD
 sy4xGx1dm4CD/T3VStbooYGSubv1I2aLZfTyfkKhiupgPKXR91xrZafF8lLcJhYbGM5J
 oneA==
X-Gm-Message-State: AOJu0YyyvYAf/xsItb1jmZLOpU+g19r9e0PtVjdMxX4DOVxRi4Vm8iHM
 KnppU6XfN2rnjk9+Sy6FmMuMyoJPpvUId8NSdDskwMXqaAVaJS+TNpC4nls2pmDj/z5aGvcJaRo
 KhwiPMtmpGw==
X-Gm-Gg: Acq92OEGpVJfX99LIpPVu2az1GYAxLqkORUJeIKjUPkNbCDlsn6CpCg1fEeikr5SUPX
 GG54dTg1ie92kk2/8SmVrY1+nFtSF0dUq5UuDIa36UKe49D2Xj2EXH/cRfSXxqRSvKIOWyhz+b5
 pYPbwSzw0XtTH9Pz4XAkLF2a5GVMmebFab+rrzggD6im7O48seWNDabIJQ11MarZtW78xcHjQWK
 5JQ/B1ESsrxvg/Kstt2vSAow9hwn1mKpx3XIQMNEC8Y6N4UBwGIvL428OvrgO7ZTdkYIhRzDyaz
 yUvtp5Jfc/GyAgIDx+YLatywMl2DcDS6LGJn/Bd6ZvqWSjAH5Ah+KRNNWwOL8CxEvQSoMYs8sCu
 SQ4PV4uNh/A+y4IC8SDk7OZCU7pb1BQLKnmtJNjZ7VblxFHcKNEH2Ogx1Nzdkkrpp10qHWxlHm4
 zlFMhi5TrcagehtBMhciPY0rwb85w/pcUFUIF7kxxTEuw+FzxfdyEIYz5w5d7nRnt5UA==
X-Received: by 2002:a05:6000:2b09:b0:45e:ec27:b4c2 with SMTP id
 ffacd0b85a97d-45ef06162a7mr731870f8f.36.1779999843326; 
 Thu, 28 May 2026 13:24:03 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb4bae01sm16053149f8f.0.2026.05.28.13.24.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:24:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/22] meson.build: move some subdir before system lib creation
Date: Thu, 28 May 2026 22:22:39 +0200
Message-ID: <20260528202253.49122-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Allows to use stub_ss in those sub directories.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260528051642.115721-6-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index e396394f4c1..19e123423b5 100644
--- a/meson.build
+++ b/meson.build
@@ -3730,6 +3730,19 @@ subdir('fsdev')
 subdir('dump')
 subdir('accel')
 
+subdir('backends')
+subdir('configs/targets')
+subdir('disas')
+subdir('migration')
+subdir('monitor')
+subdir('net')
+subdir('replay')
+subdir('stats')
+subdir('tcg')
+subdir('fpu')
+subdir('plugins')
+subdir('ebpf')
+
 if have_system
   subdir('hw')
 else
@@ -3838,19 +3851,6 @@ system_ss.add(files('page-vary-system.c'))
 common_ss.add(files('target-info.c'))
 system_ss.add(files('target-info-qom.c'))
 
-subdir('backends')
-subdir('configs/targets')
-subdir('disas')
-subdir('migration')
-subdir('monitor')
-subdir('net')
-subdir('replay')
-subdir('stats')
-subdir('tcg')
-subdir('fpu')
-subdir('plugins')
-subdir('ebpf')
-
 if 'CONFIG_TCG' in config_all_accel
   subdir('contrib/plugins')
 endif
-- 
2.53.0


