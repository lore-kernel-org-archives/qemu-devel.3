Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFFACD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShHH-0007lr-1N; Thu, 28 May 2026 16:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHB-0007b8-St
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHA-0004oG-8d
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so54918905e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999858; x=1780604658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6qUGzXh/3ZrkEIJ3K0nFyY2CO1yOR6/yIYd7TX6fPZA=;
 b=SIRTifc9RSoJPOzjRZ9r3plDUP2JMJqaCrwb2ni94++tEIsmDJaXLeuscwayhSrZfg
 S7BsMUGFad37HW1UEkhRw4H4bhK+m4g31TGJoiW4Irs+pF3aDAiVCg4uENmDwFNUN+Hr
 yk+NeF5YahRMbextbuMNETfveSBpnKbEEHChgJ2uFeldh1J/z1jXLQfTLzWSdL/7UqRt
 YFfJmu40OyRxb1JNXR6FtoNmedhSTAnvFhfN1LhqZHN961g7hKkYptgaoNS0tdmPaaux
 Uew4XkDYJve65BECPBhbg/S35JYwTOVdkVjDNvEoii1GD5DC/aUHulhUKZFQE/xtvIs9
 9elA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999858; x=1780604658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6qUGzXh/3ZrkEIJ3K0nFyY2CO1yOR6/yIYd7TX6fPZA=;
 b=BC6MO20w5Soe1kgRTRdkPP5Xp0GXxy1dyjyfRUPr97VJ7PLxPCEY4pYYIoSmEL2SOv
 6cKuW81rLGhVPRH6cHkCPSgxi1WCkC8AznZ/hq6v0r9LOneiKaNi6To9n2zSrda8Xvw1
 VGJ33kkVdtmndqOxodeyzu5HN3b5gFpw+JcDrCrfYm2EdKy4HraFehPH2sXVN3anjRtV
 v2OpI4fUFXG7LSNzYJTMuM+vxVkSVUGpnVBtlyxWYsspHORJ0m4tJWrekGb50NztB2oG
 a8pxhRCS+jKHIUy5GjZQQ0LzEYzUFT9ea1ke2vjZ95eUW7/buAgGytD7Bxg3mhUkLJVP
 TUjw==
X-Gm-Message-State: AOJu0Yzv8t5CW8BFlH1UwCNT3RHl/28M/19W17FADC3oS5TBC0v+rOqa
 Vv3nB7DYefr+/fTKC7/VPdmYSNOfL+a+yxNZ3h0DWf3pLg78kqDiDcn09GYtebUlqpXcZk5JDqA
 0CPznTP1awg==
X-Gm-Gg: Acq92OGaf13TLwnSeIY/lQvnd8vzo5pKHxMB8uk5fjDszAtIuHJZwk4ll8D3t7Zkgxe
 ZBONXji0h+xdga0zBnGoneehMnuVhPL0FA+V5c5kQTxYG66Ub3Osj/t9ew9rjBsF5tThFix0z8d
 ekBmt2hgNq5pzynLlDrXekCt2qI92J9/80V6/2HhvpP5MVyuYiTgLgkNodAL/B/nkCTRCZ0Q8dW
 udhA00uTwJTkZzV/YZcMxqTcY0aXLAm6HVCMb+n18WRt3t1FYX/V8Bo3yLqBhSvDNcXzbWQ/Gdh
 DsHyMFScaxHOoUox3X8p3IYPvpoFBqpVd81fUrCO8bQZcTR+xh05pGMReKAHxpxpBIIGFD0Aeqo
 oVWzY5zL0IbT3EnbOkZJ6Y6m0q06Py+BVuFf6Oq7S+/+9F47+U36TxDOJaKWSZM1vyJSQa72RbY
 nrcmCoAc4XWimBuB1plVbBhVmDjJu4FUDnIflsDFlgXgud6LsZMJvFbijYqMU7LQRfTQ==
X-Received: by 2002:a05:600d:8496:20b0:490:97ba:bc61 with SMTP id
 5b1f17b1804b1-4909c080f86mr572145e9.9.1779999858519; 
 Thu, 28 May 2026 13:24:18 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092855aeesm52164445e9.10.2026.05.28.13.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:24:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/22] target/arm: move whpx-stub to arm_stubs_ss
Date: Thu, 28 May 2026 22:22:41 +0200
Message-ID: <20260528202253.49122-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

This eliminates symbol conflicts for whpx symbols on windows-aarch64 host.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260528051642.115721-3-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/whpx/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
index 3df632c9d30..7385c14f534 100644
--- a/target/arm/whpx/meson.build
+++ b/target/arm/whpx/meson.build
@@ -2,4 +2,4 @@ arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
 ))
 
-arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
+arm_stubs_ss.add(files('whpx-stub.c'))
-- 
2.53.0


