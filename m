Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EC5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMIr-0006XG-JE; Tue, 23 Jul 2024 16:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIb-0005fK-38
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIZ-00040d-H2
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso44885285e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767189; x=1722371989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JNSLq3T/DO8Fim2AW30tyDDzF8z85BC5OXkOQl9TDE=;
 b=faTz0xwKPZfA3940EgucNLTQArqTbQKKfytHgThB0DMssfffqkCFTnWNUXy9fb00Py
 5V138fA35RmcNBCN1PKJvRfzgQ5OoxcV6E2/oF15mFyrJqZXjRO0Yj8YCOnl4lR4ijWJ
 yHb7EYXWvEJXhajlqM1L/eQ1Lp4rMTrHk4rCsDiR932e135/FRjxaOCu/9knpu+5Ld2R
 zvC49vPSdV6gcnkVALb+/aXJVyKMOeg1mMU2aXFQwH+zrM8r2GWb59jfxZTjq0HsJplH
 3YK181nfdldFJ1c21YttbsuC7A4dhst/ScO4BZft1HHpRbeLCAfsLqxxiMH7XvDjYm5F
 CBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767189; x=1722371989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JNSLq3T/DO8Fim2AW30tyDDzF8z85BC5OXkOQl9TDE=;
 b=J3dLtmc0CVlWmf+MDHGOrOpUQ4BII8ShNdD+aQyAXWm/XBtBN9TE/KUr2GnrQktQMW
 5QjwwWHbyF1dR0cq2smeCuJik23IgeFcRI1whulwUNK2I/Pt3ooNQqB02BxjwkGpKPOT
 tvwoAemSKykfDupLie8Tj5vfkORD3pv/bllqJuFe1KzinLtAwYw209IjOSm3w2T6hgx+
 PKvdOnOYiM4I7y8DVIryenqR4c0GuHyFBBJy1DrNmTh7dxA0q3MA3HiyFXGpvTfsdFtc
 Jhb46vHiCFvlf763YAHGRrXx1XyIW4X/or1liDT8PMUYwoTiKSz7fAUboZMY/gnu9TB5
 nBzA==
X-Gm-Message-State: AOJu0Yyp0rMccwG+bb7Brr2ZB++OGlQorFHdE+j/QWODV900jCPtfFpk
 cLgCqpZIQDR//gIgwHC6ZqMAHUY4IP9YjNYIsHH43FOWhkni3H2ikRv3qF0Ztvby6EmFfh3Cw17
 GP+4=
X-Google-Smtp-Source: AGHT+IGAGzFqxFEqdjKwZQoZWYOrGqX7dkGdleVM4L1x2Szly4d1pLFg84uaAhDyyrl70ORwMSTX0Q==
X-Received: by 2002:adf:f250:0:b0:368:6633:c547 with SMTP id
 ffacd0b85a97d-369f5ac3e00mr32939f8f.37.1721767189140; 
 Tue, 23 Jul 2024 13:39:49 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9398497sm483755e9.25.2024.07.23.13.39.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/28] docs/interop/firmware.json: convert "Example" section
Date: Tue, 23 Jul 2024 22:38:36 +0200
Message-ID: <20240723203855.65033-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
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

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Since commit 3c5f6114d9ff ("qapi: remove "Example" doc section")
the "Example" section is not valid anymore.
It has been replaced by the "qmp-example" directive.

This was not detected earlier as firmware.json was not validated.
As this validation is about to be added, adapt firmware.json.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Message-ID: <20240719-qapi-firmware-json-v6-3-c2e3de390b58@linutronix.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/interop/firmware.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index ae417999447..57f55f6c545 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -470,7 +470,7 @@
 #
 # Since: 3.0
 #
-# Examples:
+# .. qmp-example::
 #
 #     {
 #         "description": "SeaBIOS",
-- 
2.41.0


