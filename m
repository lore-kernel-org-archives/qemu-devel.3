Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F52CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQim-0008JG-FM; Mon, 12 Jan 2026 17:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQik-0008Gh-S1
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:10 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQii-0002Sa-Gf
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:10 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so3978167f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258146; x=1768862946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3UBcoWYZ9FcYRyqD0IbUW2qOcqLU2a5TKjSPHWpmxpQ=;
 b=xH7u0gCICE3gr/fY1tbbO/xwxAGD+9mljDjmfow1IgGVaKreHZ9cGup/4ruHUe3/mV
 b2mKfa8UPpoFUsFOFjNnTO/dQwwfBHFPgfa6w8XZ7b3kGqZGt53uJFbVsAE0U5hA8/nP
 LbIdt7lnoqahk/IDnBLc6fGSqcGpmY3hPkbh+3Fpu7QdP3gxARM/p3lgVpqibNI2tDHf
 1kaDdlHzE85rFbOphx1mB2dCU36kyESlNxyloUHoarPKh3+5Jow2AKML9SCyF5rkFo0w
 7xtioiIgrOBRoodeJ1QVBq9O05ZnohqgIAYrwjUOUTW69yKpmRkgasFOLuY5dxrJTEvv
 0afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258146; x=1768862946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3UBcoWYZ9FcYRyqD0IbUW2qOcqLU2a5TKjSPHWpmxpQ=;
 b=HAaUvxb+cTFUJV03jKcXqzVRfyUUF/UVn72UYmO4itoVeYiS9wL5aRgBYtA7uta1os
 Fw52fGXDGqP0buaXT3hfm1Ycf3kMaKRaLSeySDiuqcDCKW2hE4izWwyCAkVv83b9PhXk
 4ig4yYm5mTvuC99LkX/iMiBroMB7Qb6FFclv40NTLJ4z92N6lFAtaB2vqXTaDVE0VlPL
 nhEF6ij5hYmPb9BH8PJTeZtjN84YfSI9n9K+7+SlIjjcNMAi/s79Hh6yOeM0vSjmGxtx
 YzBqijPOLdDkeLEYRYdAvH/ExDNCD4peJalTvm8/kf0EARuLS6LcBekPy83gwrh/Tg0R
 zQ4A==
X-Gm-Message-State: AOJu0YwrfcyLLmey2+jjlaKxwc3AZbRPGNQvzLVf/7EvFrhnW+YJgaRZ
 rbooOdrzm9SZn0bXFclPDxrBP8YJfzZWGUrTrL8lrrYZUUCz0Mxy98YK5w3n/vCCQL8T0vr6x/C
 GLZlJYsw=
X-Gm-Gg: AY/fxX7KDURS0BjPgqA5HftpQC82GPy4Z3yidVbLYEPXgVeIhYj/swXuX3aUZ4kyPa5
 i1gHW78fLx8b1+TXE53YP1/XruwZzNpduqJ6JKrxtcXVksCwtWTqmF7NERLPHue+daVFOL+j7+J
 /Pw2+CoxDRlCfAUQddjPoZCJeQ0jxenlKO0emesLCNlinSdwKVIi8KEH+C3EIBRxGtuIRZSEQQk
 50iyKyfOk3rwJCh8qI+FGArWZypr0XSTk+aMTlYLnRE8vFHfvYp79OmT+dmupcSYp+LrXw1zdLk
 MldIkuGKV02oWblKwAyGhlIM39B7XhYWMdZSvw/6bmOal8E11AJJqAwGGj5WboteEkrJJXAI9FB
 IOg+fU7biwGDOCD84X8zMVPtjMD3Cfo3nCGu4VPwebOO4Dm2MPZLfwRvoRUoHlSZFmfjAcENpSh
 BSKzD0B8uk0JWOvvTW8pGxTOaJVj/51BcyYZFSYqHxy4f78XDVCJ0hx6cKR5De
X-Google-Smtp-Source: AGHT+IEWhxQZsRa12yBYMQvmdU55meC/skjsjTfVAXM5Z6vunkkY8umXyGkl5ZzrhnX1ZBoNrLfHVQ==
X-Received: by 2002:a05:6000:616:b0:431:9f1:e4c7 with SMTP id
 ffacd0b85a97d-432c363418dmr22316764f8f.21.1768258146321; 
 Mon, 12 Jan 2026 14:49:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0860f5sm40633963f8f.0.2026.01.12.14.49.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:49:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/61] MAINTAINERS: Cover 'system/memory_ldst*.h.inc' files
Date: Mon, 12 Jan 2026 23:47:56 +0100
Message-ID: <20260112224857.42068-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Missed in commit c611228c0ed ("include: move memory_ldst*
to include/system").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-2-philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a46c7fd0b0..88deca06cd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3285,6 +3285,7 @@ F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/ram_addr.h
 F: include/system/memory.h
+F: include/system/memory_ldst*
 F: include/system/physmem.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
-- 
2.52.0


