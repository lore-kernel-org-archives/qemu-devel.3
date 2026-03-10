Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE42FD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06OG-0000kz-05; Tue, 10 Mar 2026 19:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06OE-0000iz-6q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06OC-0008Hc-Ng
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso19376485e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184883; x=1773789683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KP6VOfzGLtmRcVJCFNprMbVs2/Pc+/OI2GI2yn1FG7c=;
 b=McEHA6Zg596XhkEdouEqeCHW2BzlgfdPog7zuVfPAlxDrRq3zoPbvawIorotrNdE3F
 v9YFPH/B/KjXUJWII7SFtewkWCROvjuZF5GVGLzOfVXMTwiSpyb6fTaj57sXIzgF6GmM
 dOXFbyPXqeCNz19VgLL2nhbTAotPfelHzzOXOaxusj2JCxr1hLJ32ONdSIJXcZ9f7Xl9
 UFp0U2C0YXQ+3hoH/OZofgiofv7JPmHa3McVn/e5sSRQVrswY/8dOqVKGWRhRJZLFayx
 bLhjx5a4rQvvYgyS4lAlkd3H8Rihr9V+GtRqnh1ua47jhN5ImS3eQoLYv6dNLC8sCCsN
 tZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184883; x=1773789683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KP6VOfzGLtmRcVJCFNprMbVs2/Pc+/OI2GI2yn1FG7c=;
 b=VdYbt20pbkuTdDmf0pQrOi+j1tQoYfXsitEBJLY7UxZOQy0KGlldkeV5LumbyuJG/s
 b/0D3TfStidBJ3HsLLJnczlsKao0CD9Uho8ezQ1MCsh60A1HqzVnidWn43R/dXQR/JJ1
 WwWrACa8Puoqnxm16SiCvPPxPOzeMXLZyPf2bBhJ611fqnWxgXbyaT3AwbSsYOumNpVg
 PfcmGX6ineLNLqUQXU+6/GUis7sOrqcCG6zYWLQjMO9aW7+i1/HVGLWDn3yFxUzhRq/V
 6TvTK2u3ku+/ZXIV7WDbTml3gT4SCGyoCoewF/7yL1CE7JsKOmGwnhbSamBizdncWZWd
 00yQ==
X-Gm-Message-State: AOJu0YwOMug6pelc9XoD+/cxofLo9Mty0VNPwrBok6oLk1rdNDU4dIra
 Tcyrp1A7PbitFD75ZgUGxEOwEESbeNyqhw6Xn6RNMX/rwGGJymYXS9SJVJYWCemVcXljNfoC7aF
 GoPRRJxM=
X-Gm-Gg: ATEYQzyXgPvsJ5TVWJhd4ypVpw6JnstTMLwjspZbpu8oylHci7qwPoduAOqNIpWzO7y
 JQ9MZu8+imXWd96Omx+havtwkcphNL+gge4OYO4lP24+cb5s6ZYRNLq50+kn4Sl6v2GOt2AwOm/
 RrOxggx/oMLqO3wz00BtYt5iQj6gHFb2A4DvEuoGNXkdDLIBcOyYC3opRJ3rGO08o6iqDCxz/7F
 xZ9fQhou9nk/hCCi2B6D9EKIJv0s9ga3TD5KVgNFlbDnx9nc0wOmOc3OFZNMiMTQJLkIXvjQqPB
 X32IdIy//Zzog1vSC6QvGBTZoqdJB47Gk4ehBYTDJKPs89OKByXJMJpaBZtSZrCiiubAsozwrhG
 o12MEWo3Md8rZt4NG2gmhgSBkLt7aZ3Z6Exf2nk8giUt1GiLBlVeIWY536K356yK9QTo2OXBugq
 g04hd1G/vnl/AeemmpGH1T6D+fUV0mZa9tV3jGfqYOTSFkkypQiIImhkA7oEfo5jFm2u2R3f6Y
X-Received: by 2002:a05:600c:3106:b0:485:39d1:b500 with SMTP id
 5b1f17b1804b1-4854b10576cmr11325605e9.16.1773184882858; 
 Tue, 10 Mar 2026 16:21:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b66ffe2sm6070145e9.13.2026.03.10.16.21.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:21:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 05/16] meson: Restrict gdbstub to user/system builds
Date: Wed, 11 Mar 2026 00:20:33 +0100
Message-ID: <20260310232045.58440-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1867560da63..db8918dd303 100644
--- a/meson.build
+++ b/meson.build
@@ -3754,7 +3754,6 @@ subdir('qom')
 subdir('authz')
 subdir('crypto')
 subdir('ui')
-subdir('gdbstub')
 subdir('semihosting')
 subdir('audio')
 subdir('io')
@@ -3805,6 +3804,7 @@ if have_system or have_user
                          output: 'decode-@BASENAME@.c.inc',
                          arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
   subdir('libdecnumber')
+  subdir('gdbstub')
   subdir('target')
 endif
 
-- 
2.53.0


