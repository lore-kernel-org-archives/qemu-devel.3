Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180EAC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JNS-0002Dx-Px; Tue, 22 Apr 2025 15:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLZ-0000J7-Lz
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLX-0006bf-1t
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:56 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227c7e57da2so49176625ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350313; x=1745955113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRqDXJHX2zGNybTG6x2KjIY6H1Iy34YPBBK1EJX6qfI=;
 b=A9CE3pv0gYHjgesYCfN/H1lONq3asL9cv/ZNX4y6Iop3q7plflM1HOwuZAM5ir5ct4
 n68eEkLDRJJJQcAzCMVi4lCjv6beJh6QqoMiIyDGRbRkYpxGpYf5RTRNdPtd5yhF94n9
 Da5mFYqC/xlAsc3BYBq59ptpmOUm6XEXUzEw45YxDYhz5IGM3Z1iyI2iQ1DFsbQpYRlc
 AyGBKu0+ReRiptIDFbRvKdwTSGP0RJJ8EuVsRSBXd+5oLQ9KS1KmhrfVECIzUwBLY3Th
 uyv93PPuK6ItoPwMZV8Fn43uxtkK/kuyPVJRAryTzW6f7i6/ZT9UvYEGAyOQsBERB8qf
 ITPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350313; x=1745955113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRqDXJHX2zGNybTG6x2KjIY6H1Iy34YPBBK1EJX6qfI=;
 b=UWeDsWSYIeg07PBTpZULkv8HUx316EPeQpsD1UiCKeczUDVCTQycCLv8HsQD/hDD5A
 jCGmaiclTfLR0+u85n9DSgouNLUC+SLYNm9LMCO6gc4Vl/DnyOWNOv6yr/oeeMakpkpz
 E8Z27YdK39g0DLKBhJIHyMDTHcHZcs4iTQJSQy3iiIarXWxHlf4yevJ2r8iveIv7xRab
 EjJTKZRpjvrGA+4QpgczAPisn7tD+M6fmjGFxRSzU/eekEnIkr67gm7R9YIdvxXr9i42
 gBd+9QTpslNzYrueSgyL3BvpIcbVgU3yyR1OgepWdnmXvNyI/TumVOLNxwzkP5WZ0oXO
 T1zQ==
X-Gm-Message-State: AOJu0YwsCd9tb6PaZvkcMwk4EefcpHz8zKESqbWCtTuiDqqsKHK5ezmW
 6RSJEP3MIZbZlIRsGzoZP2/TyXmU0B39MQKCodTedrBbZMKrjTskAkzT3oKuwFMtx7aEn9PMhbV
 w
X-Gm-Gg: ASbGncul2FU9CluzwkAoIl6FipB0Lxm1Dt6CgduKmsY8n707hBPZ4CnRUsuXc6t0Oqe
 bbfxk81y9drynFgcLSrvF2ejYjVGMxkPGHE6ztqmoDqpvFBcpNlSKUUTOvBmBAa0pACEZbxVDM+
 fC5Jy2V0f+1uIZaFo5slCnsf/t2LAAAhzm6jlTrGQMx6mYr7Ant+q7g01FoZH8gMO38n6sz5Vvg
 7AjDifZBDK82EQ0Y+ncmnd9nSZgB4Wfc2e7ytBTO6rtnA4k7+5uuS6R0XpwqDxQ0i4kJfmGQz44
 EdN5c0lS2wVzMv5s+y6BORlG7D9K9/x14LsQZaF5T7FVJs4NHC/S5PEbKTcPNlzKUDMpCcnuxPs
 =
X-Google-Smtp-Source: AGHT+IH4xxb7TsfIIaMFci0eJEZBVyohgxZEMdp3Or7zyQXeKxAoLEDBho3wAqywp+fncl3Bxe9Xaw==
X-Received: by 2002:a17:903:1aa8:b0:225:ac99:ae0d with SMTP id
 d9443c01a7336-22c53285c0amr283484415ad.10.1745350313317; 
 Tue, 22 Apr 2025 12:31:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 049/147] hw/core: Move unconditional files to libsystem_ss,
 libuser_ss
Date: Tue, 22 Apr 2025 12:26:38 -0700
Message-ID: <20250422192819.302784-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Many of the headers used by these require CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5a545a0ed..547de6527c 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,7 +26,7 @@ system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
-system_ss.add(files(
+libsystem_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
   'gpio.c',
@@ -46,7 +46,7 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
-user_ss.add(files(
+libuser_ss.add(files(
   'cpu-user.c',
   'qdev-user.c',
 ))
-- 
2.43.0


