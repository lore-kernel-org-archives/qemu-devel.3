Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1530CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTJK-0007ec-I1; Mon, 24 Nov 2025 04:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGW-0004nV-2D
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:53 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGR-0001pq-VK
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:47 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso31250305e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978022; x=1764582822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlQBoQUGrpoDgJ1FkbU5HTXl/nKutbDif4xg1MCHo9s=;
 b=fezUxClpD+LOcyCcrVYTgLb+0tBL9M0DdeRIfid9TKtpvNFj+550VKZBqcvHsp1kzJ
 XsJTkq9JKJ31sYZhy8o1cRy6bE1qml3k0ljpkiJQvimJME6c9JiSNkU0T6WqIK1aV1fg
 LvFfPZaeMY0Q+0AvfxG2YZIyqK+ngv5Xme9YglWU0LXHzBpgu9+OSfs+/x+sCSK0gyEN
 Jb3P2ZZkHoQqeWHZnT+HEFZU461im6r7xYmVAAWBdmYewVacItXUZ2YkU7Sp5zBIcG1M
 LyFqOmESiFOZnkg6ZGBPlEaROLCfrx70y1sdqz8Tn32g/Y634dF3dXy1qkM3TQdYt25j
 PHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978022; x=1764582822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LlQBoQUGrpoDgJ1FkbU5HTXl/nKutbDif4xg1MCHo9s=;
 b=SvHoGaapW3BEh+vhKhdgFWzZebo5hejz7RH5xxQbiKLQZnSXn1MoQQg52oywbIzWit
 QQpnIT/5UMrISM6ng5TfWfPOfYXM1wMPZ6hNmA8xfMIQ3jIJXLuLmYKK7FFvCsdJHNX6
 DsVO7QOUqhrFsXUCZhNEpK+bVXBP0LCmCwJG8VGDE39OmtMU2phkewrOuhkAXI2I2MQu
 qRqAQ3e8IGGI8LRVaprMYIRruFJvgQkpaUNncpm79UUYP9c11OiN7sT/uFgiqiv1/Qpj
 tZd9BGMeUXJ49o7TfWzbFvyOYFJcqiNfNfTiLlXfReDgadGlvjTwLW6BjkW3FpTDNm4t
 EIjQ==
X-Gm-Message-State: AOJu0YwFMyxtXcIum9F/eHV4n1ojHh3c2UtT00nu8QUzDZJb/OHWnCoz
 mQlbKHNjWPN/OSj+49ODyxceU5KNh7ZT8J0QvAJ9z12YFDCpO0KS8m9jQrfCDO6H3U8=
X-Gm-Gg: ASbGncvPzU1es+J5EFh3MztnhBFUOsYuR1dlfYJZxMTD785qXMgHUx/SOFWIGDYp7TP
 SUOqcTjH+yypeWuAqK6hQYpOX9r2qpZsvoI2p1ghpqg0PZI8LHNRnBqw4yWPz6kheWFtHBF5Zbo
 r38a7Tz5jORkosq4uViGEOt0LGjBsQhnBwdKaYNxrHcJcGXpJiaJlqkrDHSXn1RuUzwloHsBM//
 VMDKthOQHx8miRnh7fapD+WnBrqWZnrEehh7hg99bwjutOHPFb0spP92TeVY/UFev5FPXHDnU+j
 5gX+DNCrUjryK4EUUxUm8jPX3bJXigX+6Lape1IrTLG66Qjs4dQZpmk5FymLwOFsse/kLbMtH4e
 MWSkJ/AbfUL1gjtJQUROYWY2gluO8G2erKQdCBYRVGPp8Qt2DOjR26c3PzL+D5nuUdfHwWugH3L
 2WpLO2u4HWMjrSxp5KhZmthw==
X-Google-Smtp-Source: AGHT+IGQGYcmArSDY18251zycuR8jBFSEls98XrwL6JfvMi9Q5/8jSwd7SXAtriuTodVx2vU4E99oQ==
X-Received: by 2002:a05:600c:4f45:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-477c04db9a0mr118883475e9.8.1763978022179; 
 Mon, 24 Nov 2025 01:53:42 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a81sm27829192f8f.26.2025.11.24.01.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 01:53:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F24F760218;
 Mon, 24 Nov 2025 09:53:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Subject: [PULL 4/6] contrib/gitdm: add mapping for Eviden
Date: Mon, 24 Nov 2025 09:53:35 +0000
Message-ID: <20251124095337.537277-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124095337.537277-1-alex.bennee@linaro.org>
References: <20251124095337.537277-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-ID: <20251119113953.1432303-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index bf1dce03fde..4e67c3e484d 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -19,6 +19,7 @@ crudebyte.com   Crudebyte
 chinatelecom.cn China Telecom
 daynix.com      Daynix
 eldorado.org.br Instituto de Pesquisas Eldorado
+eviden.com      Eviden
 fb.com          Facebook
 fujitsu.com     Fujitsu
 google.com      Google
-- 
2.47.3


