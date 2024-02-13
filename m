Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9937DC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHi-0001I1-FD; Tue, 13 Feb 2024 04:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHf-0001FB-OR
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHd-0000F7-FL
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-410ee8ed659so10993075e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817256; x=1708422056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCiv7Y34jUunl2R1CBjG/RVHjCXAnByZwR7nxj0vfkc=;
 b=hQ2iram/kVpcCC6PEctwmLiIYa/kmYqINX5rWvQcJc0buyslbqUjXHtJ52ErO/6dae
 ERFScidoBrp3JGA7dkFZ+5JFlEnoDMiQHk0VU5X9E8/8QAaYdrMjqhTWR247krx2wNSz
 al4iI/KROY11uMJjt89U/ASZ//FexmxDoSW3agVdI5pS+YwZiFHk0q9+sx4icOLfMbtT
 6z8B05Gv8iCxf8mLzPdpv1HmuOGJ9nB2KaGQmlY++hHTYP/2xn4OxndaYpCLGFDuEIwr
 HBVlfvsJD0t7y6Yk2C/C+0mt1ATLRL/wdH2X3OLLsNwDpyBCjChCkvKw8o/I/LJhRQ5O
 NHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817256; x=1708422056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCiv7Y34jUunl2R1CBjG/RVHjCXAnByZwR7nxj0vfkc=;
 b=k//naS9OBD4HMRIxQLPMCxwx3bnEE1A9ax+vW+NzJ0NJFWT5N4YMqJcwMPWFn9i9Oy
 XEp/15O9iRvBoBQR6yfpzLtHpd9oOw0+CfEqoiH4WsoWiE3tZG/g2pn3ouJq/Mn0Ofr0
 BHXX96eddREpED+MuB/s2xJg07E+3GIurLNkW28OrSBxC8QGU53gP6cyIUIZ7xwCjXo/
 CdBUQcAnkM/KnSbx+fJQo7FPMXV8IEzIfWPv4SjdDDo2m3gQGr4LoVvxSkjz7ficSYZv
 Oh5f0r5OOyjZSaF9EFlh402HbzZQ59r+fO6ni9fnEjCgD7zRSBFbASDBXJhcCZwC01u5
 f7zA==
X-Gm-Message-State: AOJu0YxCa6kWWOUlbIzxfUo8h7uQM6uOS7DaPzVWWDo5M2boUn7Bt0+O
 VVnV+jBKuQzrA3pJX+xq4xeZRloQ60R/Kiy3vwzYee3RxFrdo6tHSfmmUJzopp3pb7g4mOTeBTI
 U
X-Google-Smtp-Source: AGHT+IH1Vlh+A2dnNroI/C8Ib5gDnAmekTjKIcV7UFd8zHG6/DvqdYddbsZC4VkBDIfv754+gvgxRg==
X-Received: by 2002:adf:f712:0:b0:33b:4656:5e5 with SMTP id
 r18-20020adff712000000b0033b465605e5mr7037261wrp.27.1707817255860; 
 Tue, 13 Feb 2024 01:40:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUoRrmmGEOa0u44g/bsi1O7imA2tnVu1EFhpwHeM/d4KIGMYq10RvQECJxrFveFIQa7be1JOc1ba1bIYSKdnwXLAsz7S/3gfLuzVjf6AgA5cJzX3Xu+x0L97+KxwRk8lNGmOKMOFBkxZrPA9fM2gX7Of1tXnYqUJ2p0yGtIk7UB98WaZzosbqfj4cuWQOyiiZLprYvLX9WpgmaUEwpJZiROPPfUUibYgddOb/lE/BPyHZitmhj53LI49jrV6DzSkti4XLyhpAemkhqUuvp0tCBj4r38a+Ti8k0SSYeXMo+jt4hxapHKLjXwTj+xQIhMDZEot2+5iw5D1W7NbbVbRp/eF5o74g==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:40:55 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 07/18] docs/devel: plugins can trigger a tb flush
Date: Tue, 13 Feb 2024 13:39:57 +0400
Message-ID: <20240213094009.150349-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x332.google.com
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


