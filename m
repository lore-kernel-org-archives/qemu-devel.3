Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5485D6E2AE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMH4-0001Nn-6e; Thu, 18 Dec 2025 17:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMH3-0001NB-5F
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:05 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMH1-0006cp-BR
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:04 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so8819175e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766096101; x=1766700901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VqKZLpa34/2mHsZkdi0oHv6jhbZhkwrYLZ5O570SEnU=;
 b=NkS6TzrLVI8u/f+qvyCv7y5O5vj2uqYxyDGtk685dVYl1z1wxEj6MPhQXqggubVQBD
 9P/zIJw0QxAz2NzxwWJsWOIOsoy4C78AUa3Sj9McWTmlBBk31K/9IAI8iI6IBPsHOu9b
 jEzwP5f+YYr/9vIBW+8ZW0dZHhDMg3hlM9YcRg32n0fnsMRNMkblLlCoc7VY1/Ywc1c6
 BJoMFdVp3wCwQdJ19tGXtg8ikLVz9LIgMpKejvuOBJuwRNIn62oB/1u3i8r9icHt+M0c
 jF87wJFvxA494H6hAJ9IZYDm75+UZcYAE00Nygtk3pg4F2BdG2U2gNFcj+BduVV6qqx8
 rHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766096101; x=1766700901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqKZLpa34/2mHsZkdi0oHv6jhbZhkwrYLZ5O570SEnU=;
 b=FS8KHjB17drGYRn4PJvnZNqKjrBjjBda+FKtrfBPqIM6BLaCf8AtlCfZwkj8qhcRrT
 HpdYvBampcNy4sA4/hErjk7RarO0FqJZZVnDpIyWNBC4UaajF/O1ietp+flQ6xI0tMUh
 1JLaJPBHly+la//xpQYf6LsKiwltKEqmAJraEOfyUJRoRdhHwdDzzt4wC6hCw6UEoizW
 p1Eve3wPqHaSleDuyRoC5QRimER3V89zlEQLWVAS2QZkbySE32WuhL17E75l2sNU0sg/
 NrftqRZZeQTDvDU/CzN7K2YxIvLL1XCKlHCuDP7Uffr5bqlpnHhxbhrzIu+Thg4QQLrO
 WF1g==
X-Gm-Message-State: AOJu0YyErQD+Kki6WFAIJqU0/pYEPCGr0M4+McZ5JeWVpvPiHHnnSuIc
 SqyHHWsB3jZrBWpfqSBdxsNHWnFauSCyeX7D97rBBJ0w9uH/WmyPbzLQ4X5gt53NojOvz3/yEeW
 9quaO0qM=
X-Gm-Gg: AY/fxX5ihBo8hAO/CfTdBz1EJmSxAhBp4ijGrF8Q1W2RefkbyTVj+BTMRRhpF5irSPP
 IJWrB3wmEyIQAnnJsttc5q32tjwL618cl7pdbMn7DTcuq26dHLvOKHa9NK2PbfHKlZMdVHe1rK0
 RsH6ArnUKhahRYcW37cm6nguKhXqgaqyTYGaw8Cyf/ItGglAeOTrsMy/60wCJTA5nSEDTDqA610
 jEBwL7cjbYPLIPj30gle/MLaRopFmpa1HbQJy445T95k/m251vL+NwSqXuyh+9Wr7usmhrO0XDz
 ySO3xpg+vHnPUCIWugYGiEnHCltTfW/hLBd+A0Ji9C/k8l4UENrR0nYBl1ACNfi77CzDJXMlI10
 mb4AyO8uGyj5Wu0rzPgQJ8hfoQ6QCrparPmAhkc8VAlPBmvQUHhHGNsqufWYT6knFN4qizDqHHV
 U+CADaV+ajOgwqM1buANWhsfpTM2H5XgQPoVYLVMEcV2amrlVPoQI4gJWLo4iuSEc+Kh4X+YI=
X-Google-Smtp-Source: AGHT+IESMvCE1Ej4aQ7AtJ7LoIDsrE9sfOCIIdXmfyUHSJqgJ70leuT4j6VrdteZp4o4TiPV8brx6g==
X-Received: by 2002:a05:600c:4e8f:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-47d1957da79mr6151865e9.18.1766096101050; 
 Thu, 18 Dec 2025 14:15:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa0908sm1204507f8f.31.2025.12.18.14.14.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 14:14:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] target/sparc64: Stop using the legacy native-endian APIs
Date: Thu, 18 Dec 2025 23:14:51 +0100
Message-ID: <20251218221457.73341-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

SPARC64 is always big-endian, so use the '_be' suffix to
select the big-endian variant of the load/store helper.
Simplify gdbstub using ldn(TARGET_LONG_BITS...).

Philippe Mathieu-Daudé (6):
  hw/sparc: Use explicit big-endian LD/ST API
  target/sparc: Simplify gdbstub sparc_cpu_gdb_write_register()
  target/sparc: Inline translator_ldl()
  target/sparc: Use address_space_ld/st[n]_be() in ld/st_asi helpers
  target/sparc: Use explicit big-endian LD/ST API
  configs/targets: Forbid SPARC64 to use legacy native endianness API

 configs/targets/sparc64-softmmu.mak |  1 -
 hw/sparc/leon3.c                    | 42 +++++++++++-----------
 hw/sparc/sun4m.c                    |  6 ++--
 hw/sparc64/sun4u.c                  |  6 ++--
 target/sparc/gdbstub.c              | 12 ++-----
 target/sparc/ldst_helper.c          | 54 ++++++-----------------------
 target/sparc/mmu_helper.c           | 30 ++++++++--------
 target/sparc/translate.c            |  2 +-
 8 files changed, 56 insertions(+), 97 deletions(-)

-- 
2.52.0


