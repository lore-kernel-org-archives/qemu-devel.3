Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED14EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoA2-0001wK-0M; Tue, 10 Feb 2026 08:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA1-0001vX-9R
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpo9y-0006J5-5q
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:13 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so53541425e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731529; x=1771336329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uGmUMAxaPIgZzI2J5wAhB0++mAJXpnT/oS5kHIdBbGg=;
 b=wgWFHVuIqYagCgeSRVJqvGq4rNrt9QDvOBgyFDAQX1s5fHWCbh0LTbA5b6/y6hcrWE
 Jx475wcI9q9kfyGwc+SGRhWnbNk0FbWjp2PXDvbbo8kafRGW4bx+0N24q/eIDCaZT5Ou
 TP5hT4rl3laPOwizIcNIjetSEWmerHLSeqDmjmXiyXhQSTlbCV/av3NAEz4SaO3RlrRj
 FoyDmxP+/89tsmd37GiBLkslaa9Tkg+8lUUzQIhjJJzlHXAbzI/cD4kE18ry+iIySLC/
 1bLA+znSCOTHRX7ACkqRCGyKATO2rb1QxAdY2VxUwogQ2tqlqTQZdlJFUTh3hNSPo8B+
 LoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731529; x=1771336329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uGmUMAxaPIgZzI2J5wAhB0++mAJXpnT/oS5kHIdBbGg=;
 b=pp0RT0YYuKmd8E8K0XgpPs01oSsZISj8CtLQoYybewDfST+zVSUgrSli0Gm3aGNZY0
 bGQ9LweWd92u6cvz5LYcGJ0Ym0qYvbYyD6i++Ikps+gNTjaZ4n4o3CqRmRLrzUVm2Jyo
 J236g9vXDySx8dGGYUszpX/0zYP01wbTMvLXdVmIdjzcKncpHRV5NNJ722wEE8ODO29v
 B2D7Ym9EgW990/zYvsl6lrQA+lmlh6CRMIyaPjZxXOVdxdXQePvh6EQsjpKNMpuDtA4L
 aB4RE1yd3pAktqNpEb93mqiJvHJ3RkDc4ovf6kLEaAxy8fWB0w4Hnw09LiSzyEYjrVXw
 KPRg==
X-Gm-Message-State: AOJu0YwdsEXfDZzVOMEHAkYSDsttYDuBKNJ9ONKXyP3DJ7qbucazJKMs
 KB9OHQqMy1lX7vvysFh6CJkbW2LIeEijLjI+79BPShA77dhxzy5Bn40UXY2g+f86Iq3z3MCDPJh
 mT9AL
X-Gm-Gg: AZuq6aKu+SkbNOEk09EEsSpDhNa2vVlUM0r4YHGXf9HoluV4z9hpTEDuLjAnVHkfDH4
 0WPGpVG/iXiYPWo3CcDQ9pK5fDgzzERU7z9BjfqOJBYqcpsen1kRP5qHsWS1p8JTbvj1eWb6sJa
 a5JeccV1MJwZ80ChTOq3E8oGMJWODW1wHiZeyU9zxPG1Au2RGCGLvb1McOYuhGmBBbH4CNhDMrX
 OuKVQGGls1WfG7acvXZLKj131+SVxO9VVVHzQYbPkdOqrDt90PuvUBi985STSMSCOQI/HJzXfDR
 5WfM6H6BnkZwUeXbytL0lu9tnchx8xiIJFcow1gAqSENmJOWpyoRjvc84/hII9iGIK82Ix0if5f
 9uPlzS37un2uEPj26mcxbmzCBjtaNq4DyQviXmSkuXAVbKwxOdyI7468UXtTz0zWWuyNrI0ot94
 ToD1MNLFQ8w7M6oF5iMiTJWo9tZ12k3Dqfsz51QNrlm9Vz8V9IfWDaiebO8Kj5wAyCJ5Qv6zb3h
 CmgAo+ByX25culagG1m/UvhSv5sjfU=
X-Received: by 2002:a05:600c:45cb:b0:482:ef72:5778 with SMTP id
 5b1f17b1804b1-483507d15bbmr35436695e9.8.1770731528694; 
 Tue, 10 Feb 2026 05:52:08 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/26] target/arm/kvm: add constants for new PSCI versions
Date: Tue, 10 Feb 2026 13:51:41 +0000
Message-ID: <20260210135206.229528-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.43.0


