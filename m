Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9422FE68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQw-0003r5-Fr; Thu, 31 Oct 2024 00:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQn-0003i8-Dd
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:09 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQl-000539-Hq
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:09 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2ad9825a7so409644a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347506; x=1730952306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Etq9dXgBLnq7Fjrg4VPpsKmiULD2dA0vZBWi1xVOs4=;
 b=FPLWlXsEtBdOKQcSXQSIxaHfL6tGgMtdtCjgEDArrybaHV4zvkjTxIQvDd9yVfxLWE
 Y5PqpSqQ8d7D6Bmeyg8jyVkd/6S+/2lgy7OWM7nFuyQ+vWGUpOvEuKHBlDa9K4lqri4Q
 v+tmirX4f3hP/SX8XJc/RS0rSOIM/3Enb7kIR/diOy6ZFdaTRf/A2NTHxhNYL7m9OBb7
 svSbmjlfh746cy0p0yZ0j1pqX1Yf33AvchfE7JY2nH4aUYhWgCRfIP3JixlWbeOrM6lM
 VKhtIk93wT6FYwQNc/DYxvQcaDmD8CQHfsUA9ub4Cmq45I6D+Z8d9wWIBDjoK9P6d86o
 1gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347506; x=1730952306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Etq9dXgBLnq7Fjrg4VPpsKmiULD2dA0vZBWi1xVOs4=;
 b=OKo7a5tT/xpQ1bAmpky8V6+l9HlXlv0F1JpXdHOhyWtkRP8+cEGpiq7f7VQN4fgsKZ
 N13E5xu1apS5neW8QjgX0CHvHamfbGKgSgikTY9MhXynJet9CFpGmXfGuN2lyZMkMUj7
 kjCqORIXAaDt2dbZeENAHCZBQB0DoZ+jGTBdc+ZcdJ5TQLCyw+cj9vY2xz4bxItZ4tbv
 ggGqd0SXDml4bt7+b1iFex9zhG15uDX4QxYfEqiyifuxJ+R6mlsAH5iHV/GVVO8f0Z7M
 +4q4j8t8Dr49Aym0Hk/exYhgsGOHzbkYYXPEO+nb1Ywesz0o9kUfvD1hHg3LWcO092UE
 srMw==
X-Gm-Message-State: AOJu0YyBWySKJ+WxED/1D9IXdX5WrXHXJgqqV0NyFe4YoATk8R0gKeAS
 ksS1TMctLZ2qHrRvX9wfzrs3AxH5a+9iMZjOmByArvSis8C48DgkqKgdyw8rX3Co8fCE0aF9j7Y
 JNJydCQ==
X-Google-Smtp-Source: AGHT+IFoQli6iUGkV26XRQDlHT2bJYFggKWojFg9urvSjvzTYD2+9EIDbSTsWGTEc/u6pjKnwG8pug==
X-Received: by 2002:a17:90b:315:b0:2e2:ba35:356c with SMTP id
 98e67ed59e1d1-2e8f11dceb8mr18783247a91.39.1730347506141; 
 Wed, 30 Oct 2024 21:05:06 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 09/12] plugins: add missing export for qemu_plugin_num_vcpus
Date: Wed, 30 Oct 2024 21:04:23 -0700
Message-Id: <20241031040426.772604-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 622c9a02327..0fba36ae028 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -803,6 +803,7 @@ void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
 /* returns how many vcpus were started at this point */
+QEMU_PLUGIN_API
 int qemu_plugin_num_vcpus(void);
 
 /**
-- 
2.39.5


