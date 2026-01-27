Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D26D2F002
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTF-0000p5-77; Tue, 27 Jan 2026 06:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTD-0000n9-Gi
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:55 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wy-QL
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:55 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so5401537f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514170; x=1770118970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crYjczPOr9VWfJ7k4yR+NNBroAwy/yhvhc7qTRw8Yok=;
 b=LTcr3dV8edJFAPFmmRPFK0YHtDVikgagk5nhyncjmNJbEAKIqtIlZvKtur6lzs6/0H
 TnqulN6Syqndx2F6QwHdv7dgniHrcsiMS4eq/n5isb9vVavNJuHZ4JNtK4nok3Z8AH7I
 Y4hSmpff7vIma8P4BVwJR7nX8SqoCjJOHi7BXDunUpmR42YiKlCa9UaJ23NE8QSnEyyY
 SxERwWWLVIbvVpp5Ph+kp0hr7blRMFc19Vjw92ZxoX/k0bIC2FQKin7HWC+/c1GMVDRx
 A4Oo1/SQMJeBWAYu4MnJ1yMeakZi13sxLN6aFHXcCLnw3nyEcJKjsWB+9Im9kDL96k6P
 m1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514170; x=1770118970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=crYjczPOr9VWfJ7k4yR+NNBroAwy/yhvhc7qTRw8Yok=;
 b=uCb3PkZMo47/HMYRQGv9QXpX6DZoYqlWiaT6bde/IvEmLGzOmwYBMUvkQp6CKcEXOs
 q1B0M4akhKZ7TCf1eIwhM9hch4pxWjnoCxJuUEoW2TYcI9v9QHPa6yo6B3iNjHZ/2jb3
 uG+tj+FMmjcK+Vd4SaqeP42N1KrIiE08CMqPLxgtcYMESmV2OksFj+ibxBGLSDWqQdf8
 tLfKFFd1GX+fF9i7TuXop8BdTLUZfXlk4l8Evj+a7sfN71iOkvIWT6NVJL8Ra/0fiBtE
 ZrF9v2l1U/5T54srpyJvyllbQ00WVPSp9iSuNORPVRr6+sXDMLC1X++cGLJJvMWTk6Ym
 W06g==
X-Gm-Message-State: AOJu0Yyyn5fQ8mRak9Ja1ld0yfJbPGIsYgM6v11k2xAyh7pkJ6+yiiRV
 vtufS+xVO1At7OHII9ftmryIz8N6bv2LvSt4W6BxDH0AfJl+56p6l88A2UXMi+OLlAw=
X-Gm-Gg: AZuq6aLt5vdnTEE38VCDGCqNBuvuZaG3XZRSSE8zc6GHESr0WcZKSK+YdUDI+Jicnhb
 SQiYQ6iotO2+mUXv/0XGIZoWxwwSq2reXoRPKr7iKoQXF5aSGaZoZcgUY3gqzBVTBI2fowPkqub
 dViR2e2TWfAOLEYMbcRMFayqbJT/G36/Z7hO8hTCUSUfLR0GYuyIEV0k6h0VrRjtclYxsfOHM34
 Fq9jYj5Iz37KFqSWrbT4F/Rfqt+qNvxos1/6u0btv1UlKAYxyw9wYaQwe7VKkKKJTRTDh449fpY
 1ISKYaKR+sL4Sbn076D0c1RogwvhBljLfRn2y7tvA1gxAIz6o8H3MmViQWkIAkci+S9x5aehNGI
 o0t7h1IroqxXQfY3E/yM0enlvKYa0gzaSet235xg/ynFxXAZwt3sDf/owg4RvH/lhpBRFKxipwa
 jMYcKTKRM+1MM=
X-Received: by 2002:a05:6000:290f:b0:432:7068:18a with SMTP id
 ffacd0b85a97d-435dd032b79mr2355786f8f.20.1769514169645; 
 Tue, 27 Jan 2026 03:42:49 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e717cbsm37984225f8f.24.2026.01.27.03.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A9965F951;
 Tue, 27 Jan 2026 11:42:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 9/9] MAINTAINERS: add co-maintainer for TCG Plugins
Date: Tue, 27 Jan 2026 11:42:39 +0000
Message-ID: <20260127114240.3009791-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I would like to help Alex to maintain TCG Plugins. We talked about it
and he will keep the priority for merging series, but I can occasionally
merge some of them when there is a special interest.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260115202511.2709767-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d346cda1ff..dccdf478886 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4053,10 +4053,10 @@ F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
-R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.47.3


