Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC13C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHhQ-0004h1-H0; Tue, 06 Feb 2024 04:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhO-0004gR-I0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:02 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhJ-0004mH-ML
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:02 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-511538be947so1844314e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211495; x=1707816295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCiv7Y34jUunl2R1CBjG/RVHjCXAnByZwR7nxj0vfkc=;
 b=eB6fOi2URhg44M0HI9Yb9X1g0YP5Xiw67+PJ3wDKBlgcyNOVkdwyeWU96BDWULCzjv
 v8q63Uq24BTj6sY8yd0hMhOmFJ6F7shTm0TH/qBZbUpgtDZNtk31K6FvspRolWL2ONAT
 duoL7l0LIW3zV/l5Zasw2kjv7TcrIkgGWiQRYazVjn90WtcKsD5XfpaBNWue0kMfJUjK
 ybWIx7IKE4G+Jhm+V1LPubwuGG7vk60uBu6opJZqbhgsKxYInCpVgfi1vt/AEbryRsQk
 GsTIDShGaKaTVC2goj0ik8AvF2qCDSTfwJjuduZeJ4S/F/tgKzAwXjy+lFMkAB2m2YOI
 xcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211495; x=1707816295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCiv7Y34jUunl2R1CBjG/RVHjCXAnByZwR7nxj0vfkc=;
 b=Th7KywdTXFdRsRbfMjfo1HtiUhuycSUv12nB0o5vBYOMQwqqcGEXeD0eoSvKxM7f/V
 tuT1ijleOhvztxn3ZH2wDLHY0cPn76CBKwxjqXDmc4cbyPphhhAwIIMRUBqKbRMS35NW
 k/QGICFW/3gjsX3B0ZzNi3S6nhUFRRMz6ahZLvdvZVqmSUXtAvFayLQkJYBE8Xn9tYRg
 2uZdgOKDqeQ6GQxB0aPQTOq3Vgt5zo0xBxjyhej+W1pgSad0GVTx3Om0FvtCG4KxKBAV
 vPDXe5vGVAAR6DwhfbTExHzPOJ/gV8SsUGx+eYwvKm9+Dwqbq5NNWg63m7HjUfAGDetn
 j08A==
X-Gm-Message-State: AOJu0YztsKjWAGWbqUIMkFpoKjLkAzXWfmdOojTKCgPdyjj5UP4chPiQ
 HhzGCNIHMU80h48OPgRLhvTokR5cALEiUMskkG0izTjpRGHZ1aVfaHAxgzJ+gZrVTVXw3njf4sV
 qZ1g=
X-Google-Smtp-Source: AGHT+IHru52oWdP93tWsXl7pJhE4vv0aQuGEIHUeL8plRIN+OUbrX/PQSYn8oGpMnc4hRBI5GSwikg==
X-Received: by 2002:ac2:5e30:0:b0:511:1a26:daab with SMTP id
 o16-20020ac25e30000000b005111a26daabmr1248917lfg.2.1707211495128; 
 Tue, 06 Feb 2024 01:24:55 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVl9T0xIJP6DKHUNs/jNndvkCf+w52YW0d6cumA8Wd9XllQgkSvbwavYMknmpeUqb9jFBk1sfgkKlXZQufdoPn36uGA8s6gP07eUCfmmXozc9D6ba1xunH6aPzLjowwQTS4//APpRX54l/CSzR7LifsV3kJtNEaPUY4EI0UPXD9fqRmGNqM+7ZBXqLI2sPXvfpq3URFnqMUZ82pNkKuHajwdhk5Q/h7m6QYudGd7HdDoFTisa+mv/9RpPl+gZ5gw/LfbqXVVt/ZIq0YKtqRljSoYxFDk8NEk+8UGBMiMyVvA1HRw1T806PSREhGFxoTots8/W3TtKbngDTgSxo1jVgqrZ36TpMNoA==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:24:54 -0800 (PST)
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
Subject: [PATCH v3 06/17] docs/devel: plugins can trigger a tb flush
Date: Tue,  6 Feb 2024 13:24:11 +0400
Message-ID: <20240206092423.3005995-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When scoreboards need to be reallocated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/multi-thread-tcg.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 7302c3bf534..1420789fff3 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -109,6 +109,7 @@ including:
   - debugging operations (breakpoint insertion/removal)
   - some CPU helper functions
   - linux-user spawning its first thread
+  - operations related to TCG Plugins
 
 This is done with the async_safe_run_on_cpu() mechanism to ensure all
 vCPUs are quiescent when changes are being made to shared global
-- 
2.43.0


