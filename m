Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3577BCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE99-0001Tb-DQ; Wed, 29 Oct 2025 17:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE97-0001SW-HR
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:55:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE8p-0008Fz-VA
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:55:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4770e7062b5so2388725e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774932; x=1762379732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOPF1zFpZ0IVButgmQFJplfYa1Vz8SXRSfLGOFADvUA=;
 b=tgGHM3mGmJyVwgKqVCCWWtIUOLmpFS/PaieEZwfgVj9hqyjhadtu/zP/9an//y4nls
 OSI7PEKPFDT9KshToiKCKMXjgwcpJmtdKUYBz65DQmHLY7EZzUR8sXOWfHHnIFK85jaL
 7DguQGGfy1H+pJNBRgyl1nRhyBuaGfQLE2bXmCtgQu6jK5eE1b7l+gBSuK2E61fOmRki
 c8+Rr8xaZxoabKV2C23sEiDNBnFRs1sOA8pYF7N+0aRexZ+J1ok/V0dMLeP8kHD5lnsy
 4mq+UX/6aC7jFBsJps8AWbkSmpPibJq8R/eJvllQQ5W0SlEnj7jqeBB5YuoryIR9AQds
 ZH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774932; x=1762379732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOPF1zFpZ0IVButgmQFJplfYa1Vz8SXRSfLGOFADvUA=;
 b=wV3j0PpP+piOBwae2QHkzupmS/rygm9b3R/4AOj+6yTSdp8zGhkiRbsugNhitOl7yz
 o1noq60Rc9LI/A0YVpKXK63c8LHCpXCS4ls27SYS0uylb+yTDQ6g7BhW/rxMaEACI3lU
 gMy+umNxWgu/puQsuDiEx4hx5h0KQP3ltIz2SU2VoX3pIHyACBGTbuaavQM7MvLWzPiW
 D7oVA+scqzPyf18kkjbSgMWaS5x5yOWul7GjOYMRuanLmoyLjiUCByu/zHVF9DvLrX+g
 Kn0mKEQTWhyEstWKRmJD6zICkYNcKPm9nTzo0X7GuN9dCsjc3z4S3WnfgnDExeTmnX/v
 YLiQ==
X-Gm-Message-State: AOJu0Yw42XkLt2cKCPYLka4kPdgbMr/wR8tmS2k5GyBMcyaghQnH00Pp
 ZGpY6nMbVTDb1R1wgUTOalg0Scc+vFh4hJKxx242J2oW2S3s2sgEnKs1qpCeVUvFAyB7g16kQrl
 SYB7joHM=
X-Gm-Gg: ASbGncuRQAr2HhoLx9aPegwqfbYk81n8KVcwUW8WbZDI6FCwHXNhwpys0C4FYz8JkiK
 j+Rr8kxwlt2IQDF4uzzLic6I2BME7abe3Euf5q5XTR2qvFQTRg4ZaKyfPyQs+i+P3+XeuBD3yDc
 L81Wckf49ZWU5MGDijpLM8RG1znG4Wy3VNIm00pX99/tiQkYchDP6RhMARBbRmBWPzoCuSTeV6V
 p9RrCZugdT4UAQPo/+YJ4zgVgpguxOqj6zFh9/0qv2fWRBRLChNjTptv2Jpib1vjhLSziz4JJBA
 9MwM2PDXnplwsjEgEMCAd1mtt4UAHa+Fq78UEw/pwAMxpz/HsOoumG8Vp6VKDLQq3l6zANQ35rM
 bNmWHnArXX4ppauGmEmtG5eERK/2rILqQxi49m+Wnnmh4H2wcCdLYKkzXr0KYG6b+yAuOIEl1DF
 QiZiE56NOB5DFQW6IWNtQIVTVUZh5380MFDqRj+hPkIaWl2xK4oA==
X-Google-Smtp-Source: AGHT+IEl4nUv2n4I+KrswPcLjQvm2w+xDSmJHfLBFVN5aeuMLEmDwo3pmxbxmfUOW76fgzkvzkSriA==
X-Received: by 2002:a05:6000:2307:b0:429:8d28:4079 with SMTP id
 ffacd0b85a97d-429af002489mr4416430f8f.62.1761774931664; 
 Wed, 29 Oct 2025 14:55:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728a97656sm3936615e9.9.2025.10.29.14.55.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:55:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 15/23] hw/arm/sbsa-ref: Build only once
Date: Wed, 29 Oct 2025 22:39:52 +0100
Message-ID: <20251029214001.99824-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Since previous commit allowed the use of accelerator definitions
in common code, we can now move sbsa-ref.c to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210144.58108-7-philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b88b5b06d7e..531a635936a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -14,7 +14,7 @@ arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
-arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
+arm_common_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_common_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
 arm_common_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
-- 
2.51.0


