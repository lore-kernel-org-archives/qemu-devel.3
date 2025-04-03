Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6FAC36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UUl-0006BT-R9; Thu, 03 Apr 2025 20:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUh-0005sc-Ll
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUf-00036S-Uk
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso1057437f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724868; x=1744329668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVs2JxQxPMzs6nQ4YF8OYK7Cstm8SjVx58qC1Ep7qgk=;
 b=igW0dRUql52h67d7kU1FgxNUuBKCaUcoKwyiUbB1c26KWp6DagbN/qMMmqDRnH7Cg4
 VFneVHOnMle0G5Yx+8AqSphiUdvqD7EI66vhECvDGdx5HJ5k3dFFOL6ixSKeaTEwVE5y
 a3Ld2mbka0McvAHlC4rv6p6Gm3xu5NCylCFxOrCWCfcA6dxoS2cRrGu0htXVy4h3V0Ve
 fXUNdpEhdwKmGbZsgFIplc7qYwb+S8bQzOF6fSdTvlo6ncqvhqtSQO+yAd/NjVqSDbRv
 8JwtC2SXliN1jktSIam/9Q7KwpSViGjuGX36sD65Hd5bL9NE5589eL1ssm0YUMTwW7xg
 xD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724868; x=1744329668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVs2JxQxPMzs6nQ4YF8OYK7Cstm8SjVx58qC1Ep7qgk=;
 b=eqtpqWaM8YSngl5vyJx3kJUjmZMOBfhfFaEhxGcIRH6KwHx6wJxBHrdi7LmHLE+V3O
 bZJudps8qNh48z2y3tMqbckBb85tC4l1c9pWsmdoap+RYAyauxq+3/6a4Vpmdq25/pPq
 NctOyXWhcEqgwU8W3ICgJzhm6SpE0fa0GFARQr1SyT8VO65vDNkd+LVCsN3+rsWFrO6u
 VIvLDIqTq+ckc8uXmked0fWEROuygYKHU4rO9YK4LkeJQPimnN9Bdv8mGnBAmDL4yw8k
 QC7VahVTqHuDN3+DtnjqwZu5nEGA8feDYE31MgjfhNGKALmhzVeOWefxmSyM+FkJPmd/
 7XWg==
X-Gm-Message-State: AOJu0YxY8NsLgaXVHa9d1zXP0+4pJR7zWrUA1PRO2qM91Oosdn1W1HwT
 NLGiizLnfI1aEcR8zW1TasCaoJvRjMzpDlIsl6mZWL7lFuwraUD4UC8K6dBunNVRK4oYrfiLaNd
 t
X-Gm-Gg: ASbGnctqrguHOTFjf9P8J9HaK3e32pPljIXrIWF5gwXfVqNq4X92Q9WQUz8AS79vqQY
 qhm3vaeA0MZbBr0+iK/exF8PZX8Xm5Ts24xWNEgky7of+OZCO60NaChEV5C5y3dCs1xWg77Yqk7
 diitIF0xrYmpxkMryu3YHNDi5K5505DkyzVtNd3m0bCTVBXfI/poLaHKOzVBtHQp39FGoyPqEgC
 qyb9/I9dYgfmhOwsnmz5zPKPbcU+QbqJp7s1YdRK6FbY+prcNgFGPBAVLwNx7RxP+PFJ9+MOPHO
 IjEjp3YwwWVHctFLrW7fj08m63KtMXgTk1c/HzE91E4V53ApesbTeJKyZVG5KgZWlYSDfocijj6
 m8kTxEdrV/nxD2Ncf1ns=
X-Google-Smtp-Source: AGHT+IEEO9lSns9bQ4khQmG0AdOPZ6+4riCDcRSgz0g3cJ3PUl9OaLC9tb7h/ZJDic329HoNl1CfAg==
X-Received: by 2002:a05:6000:4312:b0:39c:1f02:449f with SMTP id
 ffacd0b85a97d-39cb35b2550mr929765f8f.2.1743724868206; 
 Thu, 03 Apr 2025 17:01:08 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c302269a2sm3006627f8f.91.2025.04.03.17.01.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 25/39] hw/arm: Build virt-acpi-build.c once
Date: Fri,  4 Apr 2025 01:58:07 +0200
Message-ID: <20250403235821.9909-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Previous commits removed the target-specificities,
we can now move virt-acpi-build.c to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f52034ff6a2..536e3c369c5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,7 +1,7 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
-arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
 arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
-- 
2.47.1


