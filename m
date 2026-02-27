Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B24FFD5335
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvuoC-0004NL-Fb; Fri, 27 Feb 2026 05:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvuoB-0004ND-Rd
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:10:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvuoA-0007NS-CV
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:10:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso15167265e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772187052; x=1772791852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z09DeO9ZVounnmVx7N9pPlDmZ1HKHx+K/z55rjb6HgQ=;
 b=WrdwIul3jLwJVyigqMwgY6913q82JV9sw5fVY5rEe+heGfcrWGG2+HSFmjZfaFrYhb
 +eejz06rhIbwcRcBZ8f+s+mOBfT7U5GtYIG/7E/w00UWZYmtHIV3pPD0GcKc/eiybN75
 cmJFXIOg6hjMf0hb1knenAx+ciIOwhV0/UdfAFxRx7GO8YcNIyxFVkpVcX6VtCB3h+tt
 qIdu0ODfuK02rdmXF3KNbwhdAQcDBse/ufkA8HFLo8wXH4avkvkCqwKVaiTExjXHBwZe
 0S2vOOf4Ke6dswqjv/UQdoUPj99I8nVYAbka2MCkOLGGA05LISOwBMTQR5OOsJAC+GnK
 qC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772187052; x=1772791852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z09DeO9ZVounnmVx7N9pPlDmZ1HKHx+K/z55rjb6HgQ=;
 b=ZucFuW8W6bj7xpKWJo/wcQ7jDtsjKAPKYba2cVVLzTN8OSHhR/2+THra4yYOBHwwK1
 owz+bIKiuzZ6fyfrbyEPbeCQSd5WVF0X5flH+7Mhk1OlWPC/+bhVem3mvjNmS/wr9fHW
 i2a+i6zXF0exMGAA5nxp8pDca6d/CS++abqbpAKa/+GwA9/N7He4inVEEP7IuxbTQWD2
 jkUzKPOmFEen45TsmHkBN1ahJe8l45UUKAtcPzhWwjZoRBhXAa1e7hIu77Ih+LjNVy6c
 hj0kzAts2ouBXYHn+sUl71MG355IkR8YoJs97SOM2ovBBNYw6PeT896xJdVS3yPZwd/M
 m9Aw==
X-Gm-Message-State: AOJu0Yy2zRKU/Bfn1k3QwgZKNp3pyac2/dqhnkuN/z3R0/0Kuf0hP43c
 y5cXLh4ObHnqTJgy4u50r2ShR8vcMkNpf5DTPCJF3gm5BHw8mFQdYtSpZCAqDBae9gwDryV2KEF
 EbU+p54A=
X-Gm-Gg: ATEYQzwxel7IgXmGC1+bcH9zXcxQ1fDAae02mZhs0QfkjcFz1GohgRmnDLM4tVoylY4
 qCDnYgQm9xuZWfqmt2Gn0Uk4c9rQyus+RCxBrx8Ht538RmVuEEw9erranlBnPd/fFFSnixPOTr/
 H5V3MRH9QxBpyuFMzvofTYyDA/2eO1ufFGavL9rvuK3fzHarALrtWObhl2FOUxjld/XbPSRgNZn
 eeEgeDR/f1a+TgaJx/9ryG2KPqxwVMz24naIcYz+KkY9cTHc9sLYzBJOsF9ma4HAKjVw5/oLkNQ
 WXObAm3aWBiyydaqkZsVkynisPqxfwy6JFXDyUQM18o5WXzadExtDJml6WUcBtus+xMsV6P7Jdu
 /iTVNK7+VTe4I+vQy620r8j3fHBBphQ5ZboN825DQKUQESio+6nJtxJL/9LEjIjyt6KGEUXPQzR
 aCXUJQhYbwyTkm22MKZ8pUpim5ydPY451P99TxGbsMRmoHCJmWWemwadpjvNPWBtJlZu7/EtJxc
 8R0lM0GKSw=
X-Received: by 2002:a05:600c:c16e:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-483c9bf448bmr31275325e9.24.1772187052290; 
 Fri, 27 Feb 2026 02:10:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccb9f9sm58404345e9.23.2026.02.27.02.10.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 02:10:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 1/2] meson: Restrict gdbstub to user/system builds
Date: Fri, 27 Feb 2026 11:10:38 +0100
Message-ID: <20260227101040.70763-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227101040.70763-1-philmd@linaro.org>
References: <20260227101040.70763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Limited builds (tools, documentation) don't need to generate /
build gdbstub files. Only process the gdbstub/ folder when
user / system emulation / acceleration is built.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 3cd1d8dbc66..60415df69a1 100644
--- a/meson.build
+++ b/meson.build
@@ -3724,7 +3724,6 @@ subdir('qom')
 subdir('authz')
 subdir('crypto')
 subdir('ui')
-subdir('gdbstub')
 if have_system
   subdir('hw')
 else
@@ -3767,6 +3766,7 @@ if have_system or have_user
                          output: 'decode-@BASENAME@.c.inc',
                          arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
   subdir('libdecnumber')
+  subdir('gdbstub')
   subdir('target')
 endif
 
-- 
2.52.0


