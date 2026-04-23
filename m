Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8BFF589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuSh-0000jL-6T; Thu, 23 Apr 2026 09:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSZ-0000hZ-O3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSX-0005z4-VM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso73804025e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952272; x=1777557072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/UDtj7gfZ3kgIfva6r6vm5X3cv8jqakF8suWMRcPwdw=;
 b=hv75uZ3TShfSnVb2Bq0oiToMp8ZbKpLvtA2xQuUQZTK/ca2V2Nr7ZCuCwqsD1daHuY
 B4Kxf9rHw+X9LtFcz9cR5lUHvel74GAgBg2oT6cDNJvCa2/jag0coO5hWFW9Gk7HqQo4
 GM8LztSP+wSVITH7j7v0u9ckD31BCkgbZij8EPnKbT2WlG1XBy+gYR6ojsecwoWGZeXo
 CVML2vYmPBRTzLFO+KTVtgnylGoPkEO8xwB6Df/A2veIWePJzokQf4uxVuqbNjTEqZbS
 602pHCCkk7VYTuhRxViYMxEPaeHyOjkNbXpuRLlpwKlOjwwFCFhXsWNXWN7Uobvf7vsu
 5fIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952272; x=1777557072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/UDtj7gfZ3kgIfva6r6vm5X3cv8jqakF8suWMRcPwdw=;
 b=nYCzSyGOtjY9tmQv9wmDHZjXhvIFHPJXMNUQ3xZby/ysF+NDIhWOtpGyduKC4x4eda
 m1EBv49BwH5q6RP5nefhCDT5WhUB28gdF7nsoG+/aqQjwWgX/UJ/qfGrsUEj0m3wNmyM
 YfcuIN7OReRLmVTZzev2nQ46wD38YEg1I1Mmy19x3ZR/C6z3ekEHl6e50HaP+cmPsEIk
 2GqDvWPsFVrVsFLZPy7Of1TI6yx8ugOfbVd7XMczwBjTrYFPfgD6/zu1S00Djfpcdgke
 EoL6iIUMBch/euLz+m5ZQnBj+y/huqX/+n6yR2l2IisbALr9KMLDJqbOqMVoME3ENXHm
 XgHg==
X-Gm-Message-State: AOJu0Ywvxmi/DhLem8HgwET0y4GgC+DxDXdF+yWqr+QvEE88fCzqbraI
 rq8Sux0f+5iH7xBdp2urbA8DQs6Kg2JxlLhDYyXiagHLiNQEoz6eGuEahoYxjjD8JKhxBtAfk5N
 wDqkWQfE=
X-Gm-Gg: AeBDieuRsTX8vO/0XZE9GG1/eGRNnq/KX2SdePUxrwkHxaFOVMBqvfTsVask6X071+r
 FM/k5Df4Ujd8qLN+JCZbBQfmHGhfmoVEBAYuZactFRAReCC2JiWv9BLK9jpaYcqqJ9ZnLaczAUs
 1g7sxUk18Gm+wHXSa3Xh25BnLt49/tIhCGzchKPne4BaEbs2v2NC9yANDSZ/kcswl+YrmUG8GNY
 dKGk5KR4Haom4VoEpk9F5LB0x+UH5YBl7kaC96235B6HFM0HMG1GP+5HTEa4U6rKFLOxlPXGasX
 NiJLu8Ccs4Gc8cAubNYZRANlvWl29FjAmgQOQn43CjwqeUGBMG1gkjRQveZlrnn+yTNp3AJn9KW
 o39hDfnTvufBz9jn6noHi64BDT7UYhEz4crUp3uVp5iem6aPkqscfZm6qhfhYiZZE9ecPm4GDJb
 GLx6xGb+sSrbbeLIQzte9XKIeZE9i57BnKsUx7FWO3WPsVH3HqBopB/tilFDkTVnvohMbE6yBrb
 uLsvZ4IKdM=
X-Received: by 2002:a05:600c:888b:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-488fb796f95mr316910515e9.31.1776952272008; 
 Thu, 23 Apr 2026 06:51:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm502234495e9.14.2026.04.23.06.51.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:51:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/9] target/s390x: Compile few files as common unit
Date: Thu, 23 Apr 2026 15:50:30 +0200
Message-ID: <20260423135035.50126-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
References: <20260423135035.50126-1-philmd@linaro.org>
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

Nothing in these files prevents it to be built as common unit:

 - cc_helper.c
 - excp_helper.c
 - fpu_helper.c
 - vec_fpu_helper.c
 - vec_int_helper.c
 - vec_string_helper.c

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/meson.build | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 17c9374d09e..67f31bfddd4 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -1,14 +1,16 @@
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'cc_helper.c',
   'crypto_helper.c',
-  'excp_helper.c',
-  'fpu_helper.c',
   'int_helper.c',
   'mem_helper.c',
   'misc_helper.c',
   'translate.c',
-  'vec_fpu_helper.c',
   'vec_helper.c',
+))
+s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'cc_helper.c',
+  'excp_helper.c',
+  'fpu_helper.c',
+  'vec_fpu_helper.c',
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
-- 
2.53.0


