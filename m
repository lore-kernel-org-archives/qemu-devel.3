Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95BFE6BF37
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 21:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlvsW-0007yP-4E; Fri, 30 Jan 2026 16:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlvsU-0007xZ-56
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 16:18:06 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlvsS-0005Xt-LE
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 16:18:05 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso25796205e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 13:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769807883; x=1770412683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNGLFMFJ15V3YxrqLyoQP5mJtCmYxpiMYx7uMcWLKc8=;
 b=z5/EcdKUDDRx4CF4Avgbd1v1yzK4PtVZBfhuJ0DlUrsxqKMhrKD1KAwaAV6Mk4jUCH
 JH+ztPFU0Q/s6taEDPLlmMZ+T1jIQWr+tWXzi0li6ErDgga9bYzAnyIUXMXBmCYoayEw
 VQnoJag+uYtLgPeBvF3VfMiEm0/ea7H1rkWTTXHzB5iD0eJDTBIj9I/TfiVB0r1yW12Q
 SAAZUc3DHlgpBh0EzY+ImLAda4v8S6e2RlvhC0M8TduoToTn/WOf5p80B4fC6U8WQkwx
 G8TWqkpdfkYZP+Xa5FMXDgbqOqrqF9p7QnaSm7XchOn5vVCONsZ0kIsct9eQ9V+z/0er
 w15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769807883; x=1770412683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kNGLFMFJ15V3YxrqLyoQP5mJtCmYxpiMYx7uMcWLKc8=;
 b=alKID4y1hR5WhYs0BVcHGzVoBfM0Ej/xYHYXIz3hQWVT41WDPKftaufPT5CUChgjZb
 h6+J3RN1ksJWkV9r05loXZ0VTwypKN7UZ1G7A8GUscl1q+vgGNaVeo9f5uQpn3zxa0NS
 7qPOl9lk/gBG6YBaaCb2CoHXL2sQOg4eh87SKEgfoni807m9GErfp2SgcFf42+dxcHnf
 xlBHIinhOJeiDAlTNLban4UZc/gs1vQQd6rFjtd3LK+ux0/sdqAhbOMXfqmzwX3orxWN
 pmtnLJAPDZS3nsvOetg9Cwnh+oqQBScKQXMaXovAOkqqo7RYbbb+9qsiVV92sv6HJAGO
 mncw==
X-Gm-Message-State: AOJu0Yz2xAg62fYtWz9UCrEWN3NbBEEx+Ce5t6qZdOl1lOlfsxbPzjpf
 XyEaXAKnNZCiBCJMZF5YSlJuJwbM37F4+T8c/9KM+DXFlgG7ZYYUSegutr+PxH3/4jD/j6AVsnT
 PeinKkeg=
X-Gm-Gg: AZuq6aKKgEheaXf0+/HqPCk0HQl4nS1m3f18HNZv3qmw6/p1e6UyhHYe40BsuHMknPz
 M6yqD87U5NdrkV4/+n2ev6BpXUS8GhqBgT1RhM4JAreA+s7QdKmpn6gJKP1WdKXcCUkWYj+HsPt
 m6t+aq9mmWQMATjmZEG63e/2tU4KZmepISel+zHfyCqJyMI/KB2W675gBCEyVhwd7vBpyKkFxjf
 xpCOWc3scrJxPorkK/IKwFeaihq7N+QNnxM8rbI9WAMFc4WHCDBzmBdAKpVsLX2bFFA+xc9c33I
 jbS5S28nptB9VV+SoOYSjx0cyAfETRI3zXRY3lTON1G26Z/tBAa9GMMtcHc90+gVy6EZVXssYDc
 VqT0EnX6n0izo8iN2m87OnxeRg/kZfqH0GVnISPemLz8jOnb49q5DFX0VGB2LpyXfJJM/GQ6lRi
 ctHkLXTKlQJdSOcheYwgNNaT2htEI5G6RlV0ypP1cco/nOGp0UBxALsJ3rHMn8
X-Received: by 2002:a05:600c:a08c:b0:47a:975b:e3e6 with SMTP id
 5b1f17b1804b1-482db493a7cmr50762575e9.18.1769807882737; 
 Fri, 30 Jan 2026 13:18:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c515sm212846095e9.11.2026.01.30.13.18.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Jan 2026 13:18:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: jpcottin@google.com, Markus Armbruster <armbru@redhat.com>,
 Roman Kiryanov <rkir@google.com>, Will Hollins <whollins@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jansene@google.com,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 2/2] docs/devel: Mention enum typedefs forward-declaration
 is not allowed
Date: Fri, 30 Jan 2026 22:17:46 +0100
Message-ID: <20260130211746.46667-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130211746.46667-1-philmd@linaro.org>
References: <20260130211746.46667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Do not allow enum typedef forward-declaration to comply with C99
standard chapter §6.7.2.2 point 4:

  Each enumerated type shall be compatible with char, a signed
  integer type, or an unsigned integer type. The choice of type
  is implementation-defined, but shall be capable of representing
  the values of all the members of the enumeration.

Update checkpatch.pl to catch further additions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/style.rst  | 11 +++++++++++
 scripts/checkpatch.pl |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 12e509d10de..5ab5c21447d 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -416,6 +416,17 @@ definitions instead of typedefs in headers and function prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
 
+Enumeration (enum) type can not be forward declared as typedef, because
+C compilers should be able to know the size of enums before hand. Simply
+define the typedef along with the enum:
+
+.. code-block:: c
+
+    typedef enum MyEnum {
+        FOO,
+        BAR,
+    } MyEnum;
+
 Bitfields
 ---------
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3a9557417f7..119b2a6c002 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2414,6 +2414,11 @@ sub process {
 			ERROR("missing space after $1 definition\n" . $herecurr);
 		}
 
+# forward declared enum typedef
+		if ($line =~ /^.\s*typedef\s+enum(?:\s+$Ident)?(?:\s+$Ident)?;/) {
+			ERROR("forward declared enum typedef\n" . $herecurr);
+		}
+
 # check for spacing round square brackets; allowed:
 #  1. with a type on the left -- int [] a;
 #  2. at the beginning of a line for slice initialisers -- [0...10] = 5,
-- 
2.52.0


