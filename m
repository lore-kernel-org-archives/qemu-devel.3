Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE258CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZ9-0002jK-Jk; Tue, 26 May 2026 07:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYq-0002bB-4k
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYl-00069V-ML
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso53787225e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793374; x=1780398174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mOf1t9vtlxggfQcQhxZ6SfC6s+33y2Fuu48ItViohA=;
 b=jCoHg5LmraQFvTYgL1or8EArYT7gAQuW+JlBBTvvBOECfJ/XBKyFdJnfnNmQzm1GQK
 AHE/AsmwzrTuRWpYBvbG4lSZRy2xfmStKfhK+2OwTKnJqtSAtoja9IyBaNS60+8MEBva
 925ZtBtKwiCrBPHw12LAsNI7pXmDWDNuCcu4THqq0/YspCUuccOOMZVfQwNC1JanHysK
 iyVg3HAnxLP6p3TS5IqALnDcZrMvnwTJjRCLFpwPtHCXCEO2eB6ro4qwW6IAKP8FiZYc
 kfVPhIeg4HOIkaKvfSqGDbEVgp0+WxrnN2Jv0NiO8zLImvPw3c7Rga71azs4w0Ry72sm
 GGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793374; x=1780398174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5mOf1t9vtlxggfQcQhxZ6SfC6s+33y2Fuu48ItViohA=;
 b=NyoO69wPQsq5gsWm53FIOS3uFX+CqKKdoEBrmxPXW34L05nIjaXPh8b8YSn9zzBwaK
 cjhkVDUL2cuKJzprSe+IU/80bS1UM3rhEdOBC9YN0eSRo07JCWCa5M9w4hdNKYEQfRko
 u4SvIhgZ4pOKsAPT0fRrZHfEHS734ZnJO20Q+L8pR4H0IOJcezepJ9t6EpUXe6/N9fkJ
 ZVOvq51PNSpSw7R+tAgziDin+Ur+8paQd32E5xSM7osICPP4tkv8M/56D9AheUBw84G0
 iZJAYDjOY0symrhpJbjI+uVFJT0Lmd2Am32Nt/jy/cHkoZGJjYU3hPlL2qENR9s2+aOw
 GxyQ==
X-Gm-Message-State: AOJu0YxG4NyJHo+s6MpuPYFPwoOr5L3fAPmM45G8vqalvg0vON2+46X5
 o/MvlIH3X6f+JBcLPDYbaOi6uHg9EMFPibM6gPF+zlyyRkBefZgJbf10n2CMF5KlK3M=
X-Gm-Gg: Acq92OGnQVrL7zgXA1wqoYvY9m3LlZoqu58IlmB1x0yLoNzfwS1p/DPcndyJ8VkInsO
 hARnVm95qfmdm6tKdqDaQl04xGAirxozAiAKjY07gXMUCRp55PjL+bYniAPeyBppVVra5F5yXXc
 lEE1QHzZY02c+P6ozBUqmwkb8imdi4ZeU82EuuDpUGvy213z/7lfrl8BKbd/jCIco0iyup7WGue
 Wfb+Ngc5Ahnjpq4B3/dNj9zilOb3bhLynhcvu9/POu5XjoN9P8+EiJVdq8ouO6I+jafXc8hIjAJ
 tdmoGTz7+77UsD902xuHjKMVTUkbbK3v5Pijc0YlVT/pKQVbui8Vil5QYFN9nzOgYb018TZGKlg
 XYzsWxYULXS2MuXrzRN1U35vbRY9hlBWHRFOJcTSYuUgM7EcXRoozIjJLbp7I4Pu6wpEh/3lEmo
 BqGTIJoWw+s9kynEm75naogjCkLEG4VxPswg==
X-Received: by 2002:a05:600c:4510:b0:48f:e230:72fc with SMTP id
 5b1f17b1804b1-490428ee268mr280848045e9.33.1779793373773; 
 Tue, 26 May 2026 04:02:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526c926sm562137785e9.1.2026.05.26.04.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A88B3604A6;
 Tue, 26 May 2026 12:02:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 12/14] MAINTAINERS: Cover debian-xtensa-cross.docker with
 Xtensa section
Date: Tue, 26 May 2026 12:02:40 +0100
Message-ID: <20260526110243.470002-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31500ea2660..a534f91e87a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -445,6 +445,7 @@ W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
 F: target/xtensa/
 F: hw/xtensa/
+F: tests/docker/dockerfiles/debian-xtensa-cross.docker
 F: tests/functional/xtensa/meson.build
 F: tests/tcg/xtensa/
 F: tests/tcg/xtensaeb/
-- 
2.47.3


