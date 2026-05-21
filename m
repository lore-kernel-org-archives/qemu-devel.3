Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1031BCD5BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3I4-0004GK-1z; Thu, 21 May 2026 09:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hj-00044P-BC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hg-0008VJ-OT
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso6026595e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369469; x=1779974269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTVlKsaFgg0tIzupuoHVqOYQ+PBnu11p6ihQwnWRn+4=;
 b=u5Xuve2wC1CvpX/ej4YU2PeE7Cg7x6KZFEQR6kjCKSw8irWL82S9+yQts288HeGnQJ
 J3VdP8cXTXuMqF8K62Skw8ITusG4X9z+znrL9pNPn5m4NjM0PtnOIMHOfzxyLe7XvffJ
 BUUkiDzhazjTK0w/VQjI5hRRFp4FzKKd1BVKX4vCSfXvpFimKxasjrswLhaS5rc2aJpY
 A7siCR14aI+t1SRFG2sZ22f9X80WmieUbGza0DZ934n0uj7Gv3Mva/lcra1hRKM8Gnyd
 S44q8p/Wy98On0MaRKkvHzA6F8tSLT0JPnj4D6eqSYVHL0IoPcOzdh54rnqZmnp522Oq
 kmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369469; x=1779974269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rTVlKsaFgg0tIzupuoHVqOYQ+PBnu11p6ihQwnWRn+4=;
 b=GSPTciK9HOr631CVdo3ZU3KSTWSIkrSsUv6MYsPxk0TJei83rpRAtsT2zyuCjEawSA
 0tzSJ11Zhfi9y2FTMQZm2p3nw8+fOySNCAfw310qNnMcUDRR5M25GinDSs22kHcuiSi2
 GOGrU5HjpMkmMnrRDK6qrywZwulxU3/5jcZAjufiUQEqrQ5BqUfhvW3kSxGZTknSAUU4
 mbu8ufBamVbFTHwyCs2UwzI2QNGhHHbX+rjYnzc/++j0y7tnhU2U5CdsT2A/QcW4lkHC
 4/NRPTxLzQKNCm6R8u7RUdpj0H7M3xlEsHSXLimBeoQW+lbm7a9WKr37bE/TIfL7N0U/
 G2ZA==
X-Gm-Message-State: AOJu0YzbJGW7UHsCjFlKlNe8enldAQXOYjG6FQ3duHWkaJ2IiTuQKd9j
 QNFAUJXdLQeiYzthbJALkhvVck8hWU1xkvv56OmAaU75Zh9OWoxKmXkZXVPIFK09eYE=
X-Gm-Gg: Acq92OGj+081m5LoS0dHiXy/FIP0gJWawF7z+O1e7FIUH7H1SvjmCpyWjjS1JuE3YNh
 //NZ7nnc8F94ncKEIecNfmG2y1NiRlshtpzHWsGfmBVqZ6tnGZJnJX610Slla6BYs3MVMN6K1Bc
 i/AzUMzZOiP1sUhVLr+hZUblyevUIkOtSuhC3lQ6DKNPrfka3PiEMWOYOWQeF2Bp3MomgP/FBJe
 qI7Q2Lmc+K94qB5NSK1MXJiVrr0/+gc7seigfRSZOfgC4ClKcqgECiIb6jyrOEq0k++maWNXND2
 V/THcBN+pa+SXmC3W+JypLhdQbh0PNwYPo7hrM2oG3Js8AfBh/geS7gXR7N4ic0CAYyBjepEYod
 Ekzo/mDkf3AgOPHKR0d6wdR9WRSPsH8XsiW0RnajahKTjJ0cVG/kVuzARSL7YtjWX2FxmeKkFdH
 Da0+nW/WTsm2XNr2Z/5ZHiZDA=
X-Received: by 2002:a05:600c:8592:b0:48a:5970:1fe1 with SMTP id
 5b1f17b1804b1-49036033339mr35805995e9.4.1779369469024; 
 Thu, 21 May 2026 06:17:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92ca96sm2598593f8f.19.2026.05.21.06.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6482360E4D;
 Thu, 21 May 2026 14:17:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 12/16] MAINTAINERS: Cover debian-xtensa-cross.docker with
 Xtensa section
Date: Thu, 21 May 2026 14:17:34 +0100
Message-ID: <20260521131739.540157-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03ec57efe75..c04fc1cd2e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -445,6 +445,7 @@ W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
 F: target/xtensa/
 F: hw/xtensa/
+F: tests/docker/dockerfiles/debian-xtensa-cross.docker
 F: tests/functional/xtensa/meson.build
 F: tests/tcg/xtensa/
 F: tests/tcg/xtensaeb/
-- 
2.47.3


