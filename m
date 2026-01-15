Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0D4D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSW4-0002ad-3A; Thu, 15 Jan 2026 13:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVP-0000iD-20
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:39 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVJ-0005vc-MR
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:38 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso728447f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503326; x=1769108126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SO+QQhetqwg3Ke62Uve9EBCMA+Sar8of/HhJLrfwAtQ=;
 b=NBIxnmi4yRp2hmt8aLnN+c5O6rCv2UAo7KYaG26ksmxbmciyjNgBsBex3uDdVXjW/l
 KWs3qsp9jqkRhLZPitNkZUd7CaW/D44FPnH8LAB5XXPKMwKQAv6L69Z88eb4kQ9D8qfr
 SO5KQ7oY+1p5miDHT9QpCkt34JTJSNbXvk6TQGkJz7JfiRkI5S7OpQc/rMPCp/a71Wxx
 B6SH2AjlVsp0NUCPhwo0Zuss6HOQ5nj6VuHk2gK6w3a+JKThNS0B0ifIce0ZTIODklqX
 ZdszMutdQz8HUAyBcE3Dd8nO4Ok2+ObgPihs5dRYq5HBnKj9lRSIZ5jYB5CI8dhSsSW4
 xfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503326; x=1769108126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SO+QQhetqwg3Ke62Uve9EBCMA+Sar8of/HhJLrfwAtQ=;
 b=VX530IJjFg2/El/qsVWMMuHpdUSP28Kk0Y0qc6kHc3mvtNGkhJsHhWgzYcvK/B2ag0
 OogV/Hs/9vHVvQr4PnFfsQ5nLFk67Uqr0ZgEo8GAKC7QpLF7w3sd4bfLacgEZUX6CFXZ
 DLxWEWVj58O9kFTm93LZ8CFI50nhfj72g3lR9WmTs9TNP7rAt7bHdugGj75S1og/sPJ2
 ZNsdNLqAmoXUqVaffByvkPTSGmWcIEsvxgBLsCVKEDXiWEk77Ufmr8SJRbR/cpFsWShH
 0xVF4/swEfnNpQwrm6UktPb+qK1Z4hmWvkGE4hEMptJgM6No2FBUGGHfPWKu1cEbIqoL
 wbKQ==
X-Gm-Message-State: AOJu0YxJljxnx/t8pSwdVjS8o7hiaHaAN5dFvAUmPUJHqNcorLW+v7Zp
 QFFNKl6FniQX1BjFsqveoWV4aWjnD+ODx+jx1Gad6aBdx3HJeJ9Mxfl0xGXq36uMpr9j0usgRFy
 TE95P
X-Gm-Gg: AY/fxX4yA7oDCSW7Jsh7cU6xKf6McuQkj+EwDsK1YndWnhghuB+T8Sp9w92YGYFLv1Q
 CeM6HkiGcbaUrF4wGWoW5bCyYfgOUfMsli8Vz5MEgBJXkSOV9jtB/xJwhtP6KotQYAUv9IAIr9f
 aTVMS7kqv6DEkpMdu19NsMB9PnjiTW1x5rPSEXO5TlHNFNxyRmFyxOWFTNU5cRU2GHRlAcjEjTC
 obFk5uBQAzl8fdrf8sSpWxkS4CSm4M8iBud3XPQutzzxrBxPgU5ghFAEqzufAJ2nCZdmeXZCqXS
 xSfTPrBqo42uLcWhpEvNog59GRM+yjIjNNp0iGqmAdmvoA7acajoqNzsKEaDWiFbwZYczaRa4g0
 PUVlE7UYfda/GWV6ix3j44ve0iOUGUfWi373DGUXLEFMIALj07Acwu0mU25AECYIv/XYIlKYlE9
 V5mxWXJaw6ao+AaXOBnNm0V+JkZEomK8YaVtsv/2hnhMlAxpy3I/b8nvrx9Mr+v+u59Z259mIS4
 33HL6PrKfKCC1nb/ZSFgDilpxUjONYPOFoqljhVKhQzbx4PR9OLavla
X-Received: by 2002:a05:6000:4383:b0:42f:bad7:af55 with SMTP id
 ffacd0b85a97d-43569972e7fmr495371f8f.6.1768503325710; 
 Thu, 15 Jan 2026 10:55:25 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/25] docs/system/generic-loader: Clarify behaviour of cpu-num
Date: Thu, 15 Jan 2026 18:55:00 +0000
Message-ID: <20260115185508.786428-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The cpu-num suboption to the generic loader has two effects when
it is used with -device loader,file=<file>:
 * it specifies which CPU to load the data through
 * it specifies which CPU gets its PC set to the file's entry point

Our documentation is not very clear about what happens if you don't
pass this suboption.  The default is that we pick the first CPU to
load the data, but we don't set the PC for any CPU, so the "If not
specified, the default is CPU 0" is confusing: it applies for loading
but not for the PC setting.

Clarify the text to make it clearer that the option has two effects
and the default behaviour is different for the two effects.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/generic-loader.rst | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
index 4f9fb005f1..3ac39cfbbe 100644
--- a/docs/system/generic-loader.rst
+++ b/docs/system/generic-loader.rst
@@ -87,12 +87,17 @@ shown below:
 
 ``<cpu-num>``
   This specifies the CPU that should be used. This is an
-  optional argument and will cause the CPU's PC to be set to the
-  memory address where the raw file is loaded or the entry point
-  specified in the executable format header. This option should only
-  be used for the boot image. This will also cause the image to be
-  written to the specified CPU's address space. If not specified, the
-  default is CPU 0.
+  optional argument with two effects:
+
+  * this CPU's address space is used to load the data
+  * this CPU's PC will be set to the address where the raw file is loaded
+    or the entry point specified in the executable format header
+
+  If this option is not specified, then the data will be loaded via
+  the address space of the first CPU, and no CPU will have its PC set.
+
+  Since it sets the starting PC, this option should only be used for the boot
+  image.
 
 ``<force-raw>``
   Setting 'force-raw=on' forces the file to be treated as a raw image.
-- 
2.47.3


