Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3372C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfv-0006SP-7o; Tue, 02 Jul 2024 01:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfu-0006Oi-5p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfn-0007h3-QR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42573d3f7e4so24132435e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896601; x=1720501401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2eqbBVThGDKqLcuplSVwKVoFglEZNBCuYlGK95Q7ps=;
 b=TqMKpZuMPChSFxEkZZIPHl2Wg1aDizidsBRkOGjRHCyVYtgQhCZLHkFfwNUBSLuPxW
 7IVVnXRbwGg6LxRsmT6e4/iGOUe94yfYThjuAEcgWqijzcSC1emJp38Jv8VvFNBWZ7NL
 GD/eh5CP2CYW3YvIKylLtF+7yirX+6McUOydV1D6RJSGJMnPspy/55WrtMdcBj4aNzn7
 CxxoQIeelnb7vsLbwUhFujx6N85ES3W7k/+lAhikminP2UfzPBG80XhF1euUsk0Ppzpb
 9KD4IBcktQfiebr8Nw1Nrf/H/bdplh0LiAKgV0nDzZfVCphoD+RvPLMFH+VhjGsDrzEh
 86Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896601; x=1720501401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2eqbBVThGDKqLcuplSVwKVoFglEZNBCuYlGK95Q7ps=;
 b=IjUO3s0tWgNLSGHRRZYHbR+C5iMlxNswERBrAtytXd4GVn/oR5uIZxSPiX5TudqBq/
 6FacFbgY3rtt09aAv4APwUFY+GhR9F+G4c6YJ42B02Wnijsiclq8WMAp7Kn/UjRUJ8Bj
 wvGDTnyD92R2ONiGS5B3knUjfU4p0cJc0tWA18Zjn9UDqpCJp8javmPD53Fsq5liVif2
 DYgt8s+hw5TM2nyhFYxBRBpj8sZq6ikNCCq+eSVPdzqV/lPmLT+swFgmtVqTRo5fPM+Q
 xyiPSBVH7NqaL8GQ+xROwZM3pwQWD4KzMYpzgMtHIL8Ez6KzVLW7UDX92ty1QafgK+9l
 ic2Q==
X-Gm-Message-State: AOJu0YyZHJZN/qQ4JViIDH0+JND45/6cF7n4iBrxjSQiV4kt5qcfEeE6
 u79XVyyS1vUFfTZrxR7r3XDPGJFfGAVaF4qnkk2PrsDgfjTo5idsIdmRDViZz/VIIBw6OBIHZ2K
 J
X-Google-Smtp-Source: AGHT+IG3TonSCRws/XC0Fh7/GuvA5ROm5PRXzfzI9R9noEsYJ/33S6an61mLBQTd2EnBHnkiUS/+xw==
X-Received: by 2002:a05:600c:4b1a:b0:425:618b:3a4a with SMTP id
 5b1f17b1804b1-4257a0642d4mr49555235e9.25.1719896600964; 
 Mon, 01 Jul 2024 22:03:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1129ccsm11975427f8f.117.2024.07.01.22.03.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:03:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/22] block/file-posix: Drop ifdef for macOS versions older
 than 12.0
Date: Tue,  2 Jul 2024 07:01:10 +0200
Message-ID: <20240702050112.35907-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240629-macos-v1-3-6e70a6b700a0@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/file-posix.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index f3bd946afa..ff928b5e85 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3929,11 +3929,6 @@ BlockDriver bdrv_file = {
 static kern_return_t GetBSDPath(io_iterator_t mediaIterator, char *bsdPath,
                                 CFIndex maxPathSize, int flags);
 
-#if !defined(MAC_OS_VERSION_12_0) \
-    || (MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_12_0)
-#define IOMainPort IOMasterPort
-#endif
-
 static char *FindEjectableOpticalMedia(io_iterator_t *mediaIterator)
 {
     kern_return_t kernResult = KERN_FAILURE;
-- 
2.41.0


