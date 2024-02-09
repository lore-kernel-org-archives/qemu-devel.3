Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43AAC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpH-0005BE-L0; Fri, 09 Feb 2024 04:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpF-00052n-Cj
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:37 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMox-0000Xo-Et
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:36 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33b401fd72bso372279f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469516; x=1708074316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JwCfqJ3Ez0Lr6G31mkvU42qgszP4QebKIdCzDv4GODM=;
 b=GrvD0tkjP4s3dOk6GtweWK6Ov2E0Nraxno8KWeAQvCBeml4SSgDED9MdSO9sMMt3AP
 ZWloNB8PdIJ6SxQ7lwfuW9tIEsMIsauvHbBU0GAwRs5IPLpRJIh7yFdLrvwkdxUNiHJa
 TiDiGu1aJNREwCJYfn30wK5Ks/13bMh8nr46SCHrJDPv/2Ngd3/70dC3imWFZuKVilyx
 TdYB68mqt2ONhQMZ9gcsCOOFDZFWt1oWH2ZAmPEdRq0Tc6Uj6qUTcYccbaMBx905/2qb
 yJn8B9Ysui2k9ebo5qMBBhg/Bf7q+VyK7h46ykLoY2zpsIg1VeGxR4Xb8sRwBEcBPGLG
 wo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469516; x=1708074316;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JwCfqJ3Ez0Lr6G31mkvU42qgszP4QebKIdCzDv4GODM=;
 b=aN+3TOrJHArPO641yt/TlLtPfOEQiC9MYbpStxCbvfTKh5taeQXvNUo+WJN2zzfQQw
 QTZZLSqHRrbI/gNc/bB4drAKU3S+4q1o6osBXDlVBe2/vv/eCFQh0n0XA/XCI8LXrPpL
 GKp70gtDTCwpOmmWWDMrj/D1xRVJEypSNdjrn85rMZVPF8/NrTwLS52HGFx2DwDMWuj8
 fP4l7JVHOY32ZPamIVRE+1HgPUvUBt/TUKIN/VgSQ18tdez9QtJg/hIMMQrk4WfrgvZ4
 HDb+kpc4cAIH2kBwiFr90qvgGiuIPk69uFBxpmesK3jrTcWN6WyjXZUQvkHff2MOMDqz
 G02w==
X-Gm-Message-State: AOJu0Yw7an3BlmBH21S038Nh5bVeuRX0Q0EfBanlzAYEt8AhNQfHzAGn
 wNtsq/oXGD09BTa9jG0udUPsisTqBvuk0QAEhhZmSYSKzkoHYxcuHKFUm1zVRqccNQzcOryi5HS
 uX40=
X-Google-Smtp-Source: AGHT+IHG6CR18Od9krUUVp5m1CmWVuF8/AVSjkgTdx52rCfODspWtjdTT/3y9olWNLlsy9LUWqk3ew==
X-Received: by 2002:adf:a35e:0:b0:33b:4acd:22dc with SMTP id
 d30-20020adfa35e000000b0033b4acd22dcmr677190wrb.16.1707469516089; 
 Fri, 09 Feb 2024 01:05:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXjIwYphfoXYTivwXAlxTBQgrAUXcN83O0GWXR9cXX6TtUFmC7WP6klMuHADGXuvElW0GRHAcae41gFEUzBPbPinO1HN7IvfMM1Sk+MwUX9LJXeJbrgKgE3bSU7baojYl6AJCWnR4UHD0xgsA1+7CALjUxFbxKXLMj4i9zRH9NpL501Wp6lvLPGaUD8gsy86GtsaRhqei++jUra8o6FjLb1UOFR1qWGRDuYMDcIsNTmZcN6fmbiD90Am/lWS5AXn0/PdJz0FmN8SxsEFEXDNxU1bQJtqv3V9lXGsI+aLrsVTPTBHphMIVoOh6vxfg0Lh/nCuSDoETmEVEN9mwoYm0ZY1A6u5AI=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a5d58cd000000b0033b443a7aa7sm1255255wrf.97.2024.02.09.01.05.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:05:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 00/11] target/mips: Remove I6500 CPU definition
Date: Fri,  9 Feb 2024 10:05:01 +0100
Message-ID: <20240209090513.9401-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Alternative to:
https://lore.kernel.org/qemu-devel/20240209085347.8446-1-philmd@linaro.org/
If the I6500 can not be tested or its support is incomplete,
there is no point in wasting energy maintaining it.

Philippe Mathieu-Daudé (11):
  target/mips: Remove helpers accessing SAAR registers
  hw/misc/mips: Reduce itc_reconfigure() scope
  target/mips: Remove MIPSITUState::itu field
  target/mips: Remove CPUMIPSState::saarp field
  hw/misc/mips_itu: Remove MIPSITUState::cpu0 field
  hw/misc/mips_itu: Remove MIPSITUState::saar field
  target/mips: Remove CPUMIPSState::CP0_SAAR[2] field
  target/mips: Remove helpers accessing SAARI register
  target/mips: Remove CPUMIPSState::CP0_SAARI field
  target/mips: Remove the unused DisasContext::saar field
  target/mips: Remove I6500 CPU definition

 docs/about/removed-features.rst     |  5 +++
 include/hw/misc/mips_itu.h          |  6 ---
 target/mips/cpu.h                   |  4 --
 target/mips/tcg/translate.h         |  1 -
 target/mips/tcg/sysemu_helper.h.inc |  6 ---
 hw/mips/cps.c                       |  3 --
 hw/misc/mips_itu.c                  | 35 ++--------------
 target/mips/sysemu/machine.c        |  4 +-
 target/mips/tcg/sysemu/cp0_helper.c | 63 -----------------------------
 target/mips/tcg/translate.c         | 62 ----------------------------
 tests/qtest/machine-none-test.c     |  2 +-
 target/mips/cpu-defs.c.inc          | 40 ------------------
 12 files changed, 12 insertions(+), 219 deletions(-)

-- 
2.41.0


