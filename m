Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5319DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYj3d-0000iI-1G; Tue, 30 Jul 2024 05:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3b-0000bV-5Y
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:22:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3Y-0005lM-Vo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:22:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4281abc65daso18168545e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722331327; x=1722936127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQ1Qo4EummoLtaisooBllEpj3+LWFIK8W5rm3kHkgq8=;
 b=Zm3+08Gz9e2VswihpWAIfNRLWT7e22ZbRv74FjJHx6lHLX6A7vXYEKJlnEcA95BFJB
 CV26TM3HjNoM/BI2Z2vcWDjMls6NoMGm+HW6u2+KC1FZEiJ3XhY2mWUbn1lv+9c2YhMU
 qyGOzfjFa3Fi/9tMtnhtT3Grd5lHCi3nhQ4D7abpZ4BegbHnHA3x3K8Akmbzjej7+uWI
 xHrwAUYvUi8EuAX+ZBspV4vx4/xS7+iqpYDaUrR/CfOzfLM6XUIW4O0j52cMIoy83w2x
 HM8EnLf/2eX48dpwBENCpz0GbwypPNd17AUinggAk2BuxWm19SN5GGfUFyJKWvRpjR3p
 QWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722331327; x=1722936127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQ1Qo4EummoLtaisooBllEpj3+LWFIK8W5rm3kHkgq8=;
 b=xEMxa6lo8rMZQzaWffM1Fm9+GU8QTDB0sm1T9JZF2dgf7qsVRbNEg5Uc1xzbVgNgJ0
 e35pt/57AL9uqN9ABY9hjdrQot2AHLTf9cNdTPFvackT8hhaUW2+JF8h5oPIwF9I9K/5
 KR66sB/05spnUGiyQ0yEg2YLpisZG3+pS4AFKSOmaq5iKejlOkZEVJYBRjVwdhNTh3Ij
 3MrAw1128wzoooEKujLxyDgOzdTGwB2CaKSghteZzZ+IEvBhkMmLsRkkCE0e3FuHOD+A
 QpqWP50UkxTCeCwJWBRig41cotTF14TcPImqZo/qYLbB5Td8A9GouQExFHVQc50iVN6Z
 Jv+A==
X-Gm-Message-State: AOJu0Yyo/kinxFVC8bIdDDIT+pazTOLEHrjmKvvoPRNETV4nr1HkULkO
 ExLfWajcmm5YFKBQjD1xyc39dZ5q6cHK5Te7OTXIy223ToSrCrLKVTFg1uRWlF4HlTvxeuyAMdQ
 A0oU=
X-Google-Smtp-Source: AGHT+IFRTF+dUA9Tr+PQeP7ek4VXX28cN88EFTIOg8DPMdw2Go1EPZECbANoRDKe3r5gRZnwH/8ReQ==
X-Received: by 2002:a05:600c:3541:b0:428:314:f08e with SMTP id
 5b1f17b1804b1-42811d736f4mr65614495e9.5.1722331326831; 
 Tue, 30 Jul 2024 02:22:06 -0700 (PDT)
Received: from localhost.localdomain (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93594b6sm251246625e9.5.2024.07.30.02.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 02:22:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-9.1 3/5] hw/sd/sdhci: Reset @data_count index on invalid
 ADMA transfers
Date: Tue, 30 Jul 2024 11:21:36 +0200
Message-ID: <20240730092138.32443-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730092138.32443-1-philmd@linaro.org>
References: <20240730092138.32443-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We neglected to clear the @data_count index on ADMA error,
allowing to trigger assertion in sdhci_read_dataport() or
sdhci_write_dataport().

Cc: qemu-stable@nongnu.org
Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2455
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d02c3e3963..8293d83556 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -846,6 +846,7 @@ static void sdhci_do_adma(SDHCIState *s)
                 }
             }
             if (res != MEMTX_OK) {
+                s->data_count = 0;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
                     trace_sdhci_error("Set ADMA error flag");
                     s->errintsts |= SDHC_EIS_ADMAERR;
-- 
2.45.2


