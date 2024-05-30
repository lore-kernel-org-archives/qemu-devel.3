Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A66C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaUZ-0003UK-7u; Thu, 30 May 2024 03:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaUW-0003LP-J7
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:46:29 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaUQ-0003PM-28
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:46:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4211e42e362so7045615e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717055178; x=1717659978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hI2T+luarfP0HirxpjgbiSprzocV4B84X0ChzbQjTTI=;
 b=Q3AXux5EdSD1bIcUmGEVfIEbx0VL5G/RebLhc/Tf7kepOQ9ocV6f4DFdy2DClnFs7U
 0u+LTSzjYRpz6/WAf8K+/1KnagPGdbhETwKPs4eCwu8plWJtQPpRY0T0gw7dt3gLBOPq
 Mbtg93W1hcNYZiP9UMPciA/3qC6ff4CuGR836Xbhl3mCesT/IBzGs+XAeJPlnwXnqkSF
 UZJZgSqn49vX45FwWmbg/X+x4+dzPNcOPDSW8x6rEqjP0YcYWqh3vq9ICoFyU3LUPVcX
 82GxEZURVVh+zRr/BGwx/BRq6KRnMNj6rgXzymtycTQ/HrUxw9+HYP5E7TV3CJHoxTJ2
 oulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055178; x=1717659978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hI2T+luarfP0HirxpjgbiSprzocV4B84X0ChzbQjTTI=;
 b=XEP0zzR2Cg71FJYkyWUv6Lq/+rbfgRn6+TG4HjmLQ4JfrVbJshAnsdFSTgc9i2qxrY
 LMUxkN0HP6IofWl6iIh0PvZVj1305JQlXcrFtxfd9yHGmjQe6RWdYwqazQjQCWsuV8bz
 3GHUk3uMWpvbaEUiwTLIuCDMSKiMsAQniqpdzOCHz+Hnb5d8iR68hpFM+xI80rLluWOK
 G5DrfEOcrg5pQjG0vf7/mbCr2EYKqwkxV96CeQcCMMykP9E3chEq00flP5D5NbETriGN
 ytKIy/qJ15IHADGHGfT9j5L4siikZv1JhRdklgvv4MwyO9JMKkdA/gFzTsJ0VLSl/NQu
 EOlA==
X-Gm-Message-State: AOJu0YygVVD6QqD7CoGPFFXfVaqc0YGT/G5uN+/JSVMVj9NyYo9c44ov
 W4iHs/WTL7vVjcIm5Bi34eUeX8Q1PK38BZ00cpKQGCZt7HcC372qU4n8mHeIqTKnK1TuB0FtHSl
 z
X-Google-Smtp-Source: AGHT+IHMB7e1aA0/Au/J75fvu14IRd0ItPMjz95Gm4bpwh2vr3i45Bt6iV2jFdH57yMuPhbKAKaH5w==
X-Received: by 2002:a05:600c:1c90:b0:421:2202:1ccf with SMTP id
 5b1f17b1804b1-421279279d8mr14502305e9.28.1717055178651; 
 Thu, 30 May 2024 00:46:18 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212706c952sm16556555e9.26.2024.05.30.00.46.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:46:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/s390x: Deprecate the QMP @dump-skeys command
Date: Thu, 30 May 2024 09:45:44 +0200
Message-ID: <20240530074544.25444-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530074544.25444-1-philmd@linaro.org>
References: <20240530074544.25444-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer @dump-s390-skeys which is target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 5 +++++
 qapi/misc-target.json     | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 40585ca7d5..3cb43085ba 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -148,6 +148,11 @@ accepted incorrect commands will return an error. Users should make sure that
 all arguments passed to ``device_add`` are consistent with the documented
 property types.
 
+``dump-skeys`` (since 9.1)
+''''''''''''''''''''''''''
+
+Use the more generic ``dump-s390-skeys`` command.
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 4e0a6492a9..e5109b1265 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -237,6 +237,10 @@
 #
 # @filename: the path to the file to dump to
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @dump-s390-skeys instead.
+#
 # Since: 2.5
 #
 # Example:
@@ -247,6 +251,7 @@
 ##
 { 'command': 'dump-skeys',
   'data': { 'filename': 'str' },
+  'features': ['deprecated'],
   'if': 'TARGET_S390X' }
 
 ##
-- 
2.41.0


