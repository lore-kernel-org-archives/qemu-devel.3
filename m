Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB3AC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHiQ-00064H-3W; Tue, 06 Feb 2024 04:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHi3-0005Pr-RQ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:49 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhw-00052F-CP
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:43 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5115fcef9e9so348185e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211533; x=1707816333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9D4k6QS4DbxEf/czoo6ZOLuGzDbZtd2vzfrrW34BdNw=;
 b=rh1ljblFzFmNRzDd2sGA18k6wKO4fnqgUK9g5LlJZajgBlIORz8OiL1NTsrRUbTRbQ
 5DJB8TC1sHu5qwCip4rCUnOsywZhBkQ2635F1pcvi9JfV+vf5J72RLRozYLw+8VtF4M4
 T3TB2j78BTctBFnCWC257D8o7uReryTO8BWvd5HGwUbAqKf2w+uEPm36jrq0miACvaS+
 6qgm9LlSt1/pziC3r7HtbMv1Y9Bb7Vi3Tit8oUZ62QMZhx/7upZf4YVpIYALJIsm11uc
 32H5uVoVzMa0azzSY34l0u1bgVJvTaNC35cLBLOHRWACVDUGGZaHHf1fkHIyZhpqq7OO
 kWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211534; x=1707816334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9D4k6QS4DbxEf/czoo6ZOLuGzDbZtd2vzfrrW34BdNw=;
 b=Lkdx5UQyy50PRTygXqQD4izZ7ao974jEAahz76CwGdzJI6O3BNb96T0KsbS3LEOEie
 uzBpS26gD6wyO2WuiLfuEDLLNQmDnSS9aTlYu++PVtq7jcj8QPjqCLl/H8nxZypY0Ce2
 3/SRJKiadZ7ikUTdrq3P//BPtBKriLxgueGCANW6J39qXARBQHHyvH4MMXIB/lqKwjL2
 Sae87tBtLBpAEQQqS53+310NnzHGa6MNPAFN22PjJ3anQ2NAzCT2dXWNQq0BQlvU9ona
 +7/GJW0Z4lsnjWcGkx6mFF5k2+lnvCwrPq/mBTSHLXt6irDNMyBmPcMQ1hXbItyOgNAX
 8oXA==
X-Gm-Message-State: AOJu0Yx1VdBTvk9INIriueG/oNZz8kv1tX6MR0/fhohtAMJtrzm0psSM
 BYjqB/fuwYpCB1ALt/mIh/sVPGn634OkYy7Ek8PvqMf7B8onZu71gRaJWJ0V0rAWkLf746b9HlY
 lX20=
X-Google-Smtp-Source: AGHT+IHl3Xub1o/veHBAV0LHzKzN4/nI5Rqmmo+hYRuI0TrdsKzruurz8QyJXai32V2e1F6qwSDtrA==
X-Received: by 2002:a05:6512:402a:b0:511:60ca:d4eb with SMTP id
 br42-20020a056512402a00b0051160cad4ebmr322152lfb.28.1707211533808; 
 Tue, 06 Feb 2024 01:25:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU28NjH2CMq7BMcXqdGqUi44UODq9JP5K0hMCtXLzPod2XqtPx6X6l7dlvVPtYI4L8bazVn29mUgzxnthCYJMUJlC9QyQSwKDvOWZ0TpUSMwYgAgfjISZfMpPMMm1Fuao4yzYN1GsHZ0wWg0r8ui3Gw+3jwXHpIrLsAeRGt4Snr+D7E0Z9gK33bg4oAi+mh/KHkPUyaTI55r81hi8c0AKjCszugXnKcdF0YKEIGNLvW4aIUQ2w3EHPUFK78ra0FMALz9A57zPNWDM3R6otnII9P+MDvK0RsqbxYrGQbGZC7OMLluBKHJrHnOFVTQpMitOpiHYk4ZzC/hQZNfyQegPJfXFQb6AOiYw==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:25:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/17] MAINTAINERS: Add myself as reviewer for TCG Plugins
Date: Tue,  6 Feb 2024 13:24:22 +0400
Message-ID: <20240206092423.3005995-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfaca8323e9..80528d3dc63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3676,6 +3676,7 @@ TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
+R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.43.0


