Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0468CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQis-0008NV-5U; Mon, 12 Jan 2026 17:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQiq-0008MX-IU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:16 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQio-0002Tx-Ue
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so65403535e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258153; x=1768862953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ffw9cHLWdzxkFXalmBmaFW0USephjLUc33GYPG8Vps8=;
 b=zIff4LaFTeS7Tdp+vc+6oTJp5SVLaWQabt1ThgLMjJJ2D9zqkR7QVIRsJQQdag+4yw
 u3Ja0XMJ4OEl4lKx/yRyhs2WAS5MSwBfeilBCwuPdgVWV7ARRZMlcvCtIHTHoOFWu1+h
 r/aX1oXrannVcNEwpDQ36qSYHc3c/6bO2906K1s2Sp+hxT9VKfgbbd6W4NljhcHKZulH
 L8wtst9Tfq69UmasqLAhYF0B9f9zWuKPFXZSkDoXPRZB1kmDrwG6jfrTwt9lAWDthj0r
 s5i3y2cEy0GJsxEuId8yjxsUNnuYOJrSo+dPadmYHa3pc+cIdu+sKD5q1GEtNDSt8IHZ
 MuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258153; x=1768862953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ffw9cHLWdzxkFXalmBmaFW0USephjLUc33GYPG8Vps8=;
 b=jtG9crHRsA/mpdjO5lJrGUMtymRJaeTDP9aFxcJZUhRHfBynMrZr/uBJJon95AAN+y
 ONupFUgAHeZqpYdNDwm2zBtvf3dI1hFy21OCO+L8sLRXXou4Tc2WEXxR9UxF3D8Lr34F
 JvEzgtvrakoj3C2ao0tK+8hzATn8AhvCvmpK02YwaVQ6P5NPYdk9cUDl3TH8fY2NVReA
 aespDCRmQDLQYN0sBXbMP9h6lSsUYWD0F9XuOzruy7WgDQhICbNN7xAL6KvTTGMNjm+l
 IXETzfVbrfeF2+t1WQK/Q86V12dDMiYAvrDWWAgh8DrqOQnOHC4qxglThMqE48QbZGAf
 qw9g==
X-Gm-Message-State: AOJu0YyQBLyRurX8OS6WuUJQ/nH3lYcDwqfqiBHt0Y+UOi8yBXLtZPbh
 YBS/1kO+V6ZjlB2h9B5mtQSnE8IFb65gJA53CFwRgy3PV07OL/ptsRKcP+L1fLhdHN5+WDmVqZI
 Bt5rfl0Q=
X-Gm-Gg: AY/fxX43HSp1VXNcvpY0urs6Cl6DnispHKfpmzUcUHtkHxL5LaJWhieJhb+RbFiWJJR
 AhrVRmQgf8CSk1FQwpnaBNP4lBGz15Y69ce25K500MkIKkQ7tD3cuEh1hJH71/MZZ8+ELIuQqqi
 nsWkWvksJQmDYV1sErHTVO6ci4+mk3qETLMJFTKyWWV7ODbS0yHWV+FmEpTRPcvvj5tqHLbxxo2
 9A2LQjduYdDNseOcih2vSllERV3yZ2GoMIJXWt6NegNcLSrLjRcflPSxjvXlpZHEH/Pyoji0jzx
 UHXMcHHMNiMuetTsIWmTC1AzUGl8Zt0KZEMCjlnKTB8P79iKEbqOUFHPKG+VrdKc+ZXI3n5wpv2
 UD0iovgs9Dt+dErq0/bN9yy1QiBF1p1d1TR0EbEzjIuv2sdMJGfQA/En8kmDIbJK/Hr66HjMrhZ
 S0SGdniNzk0o8I1UPA1bW91WYGn1CBkW8sYhuD5AW1bMkvXjAyTcKCjxtA62MO
X-Google-Smtp-Source: AGHT+IGiIPktkUS20bKyuv9TWaOeTdPhg0tPjbKPa025A4QUjX5BbyxRHuzC/ST3DfwGhF7e97WGBA==
X-Received: by 2002:a05:600c:45ca:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-47d84b39832mr192668085e9.28.1768258152861; 
 Mon, 12 Jan 2026 14:49:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184e1sm364388825e9.4.2026.01.12.14.49.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:49:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/61] docs/devel/loads-stores: Fix ld/stn_*_p() regexp
Date: Mon, 12 Jan 2026 23:47:57 +0100
Message-ID: <20260112224857.42068-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
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

Fixes: afa4f6653dc ("bswap: Add stn_*_p() and ldn_*_p() functions")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109063504.71576-3-philmd@linaro.org>
---
 docs/devel/loads-stores.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index c906c6509ee..57892e814cd 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -52,12 +52,12 @@ files which are built per-target.
 
 There are also functions which take the size as an argument:
 
-load: ``ldn{endian}_p(ptr, sz)``
+load: ``ldn_{endian}_p(ptr, sz)``
 
 which performs an unsigned load of ``sz`` bytes from ``ptr``
 as an ``{endian}`` order value and returns it in a uint64_t.
 
-store: ``stn{endian}_p(ptr, sz, val)``
+store: ``stn_{endian}_p(ptr, sz, val)``
 
 which stores ``val`` to ``ptr`` as an ``{endian}`` order value
 of size ``sz`` bytes.
@@ -67,8 +67,8 @@ Regexes for git grep:
  - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st24\(_[hbl]e\)\?_p\>``
- - ``\<ldn_\([hbl]e\)\?_p\>``
- - ``\<stn_\([hbl]e\)\?_p\>``
+ - ``\<ldn\(_[hbl]e\)\?_p\>``
+ - ``\<stn\(_[hbl]e\)\?_p\>``
 
 ``cpu_{ld,st}*_mmu``
 ~~~~~~~~~~~~~~~~~~~~
-- 
2.52.0


