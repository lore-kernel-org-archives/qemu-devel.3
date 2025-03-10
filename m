Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246BDC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQfE-0001nM-Oa; Sun, 09 Mar 2025 20:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfA-0001mP-A0
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQf8-0007HI-K8
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1695774f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565189; x=1742169989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDbWzQ3TRhfqcCdGrWE6Ka+gW+QxOu8dbIYkiLZFWgQ=;
 b=rwDxUUNhP9klUCNLQKYifXTQNLSCekAG0Z2mfQd4l5jHrbNQbHlBSN1X1a29+s88hl
 fTk/eO7fOwQdGkIxnydrlKS9BABWnB/y/mm4HyX8vbEttazWT1CavjT9wulK9+mGIvLo
 jlAZwDWl62IklOAyX+7a5bT5SPbL/OSHTevWi7NzK831sxzwK404DhWDe4gQRv3JvlzN
 juzPIrrpJnMQVQeLiA0W8m0ZK0TAM9CGhqPgcyXxwWBcb6EyxBDHuJPdb47cgT26NP2Z
 NlmwkZ3sidro1Za+ZGhtKzQ7xuXje3y5p/+ksd+nRGDFh0fqEYqDsJeYlFVlZsGT8jEo
 aPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565189; x=1742169989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDbWzQ3TRhfqcCdGrWE6Ka+gW+QxOu8dbIYkiLZFWgQ=;
 b=VgnAAZKNuoXO+Y+t4bzN8oYnMSdi1nYYE7y3MXMP5vkm5S9CJgvxYcU9Xf6JW21gh2
 aS4QD53MRcq/CXi3i3DWv9TTadTSj0XUfs+SQTi+K509Eo/SAGFabacXOdsBSs3IfCV0
 /+a3ZmOjbazVEBn4g6YObV1EfpN5b1MfhhU1LaUpin9q9G6AV08zLq2cP6DbK3OIjyWc
 CcXHMIHVBz1sMp7YUjo66o+malGN5Sgv5A6wLH9pKHv9R78IytfFbx0Jiiipvxmf/TW0
 H638bIwoR4f2BK8/bA94bNTyOt1qXtbTApregM6aFnc/W0HrKZsEYjTj8VUhimDIyG5E
 wANg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjpdIJSKoNhVzs8pKMwvJH/LtGOD/2O5pU7ZkSQrYP+R/WNSBCBHj3HHa0GgaQXLgsZcEScO3/RnNo@nongnu.org
X-Gm-Message-State: AOJu0Yy+3aVfNGrSoyCxc4HXNBY2NZHCF1NznrXLyvHpPNDgLis8RvQx
 pJsybc3r4t5qB/Ue40n5nsODGnYNDCjTuD0i0gh0/JlsASyuETkP5L64O8/Wrh0=
X-Gm-Gg: ASbGnct9B0LH09aO7ZkQziKjqHAI3SULECkQ5kcEVZrV/OeIb7BhGArcMQUHlRZRxgU
 F61kVbLF8vhuS7UKE1W/dyfXFn3ALaJeKr03sd5WrosEc6E0sEJ0OdaoKU1yfi6J4HF9G5dMeuU
 wb6zbX0W2QkJY3tE+1AD/HU+QSbwhVfROYYFtzqF8C2JL8XauMXgJOA/TcDyWcYl2oz3lCFfm3J
 uaQ3fjykK8dGt+H/S77YNy+rzh4G62D6zV0MtqABiEQXDcI9ODChXVo8NGKZUsjSqZUABWyXXeO
 ioWsKt2Fkdc6Q4SWeizXmsrISK6SMONcz1CHXvK4X+QXFfdU5yr3eS7qBOSTjBc9+9FDdtKR0sF
 1CfJv4ndK976OBnC/lLI=
X-Google-Smtp-Source: AGHT+IGVanCNFzRSF3SmLVxHOaiguwuhQTCRH2KkDxTielp4+GYm6Mo+9tz5liVeZoKELFPotM63EQ==
X-Received: by 2002:a05:6000:2c6:b0:391:31f2:b99e with SMTP id
 ffacd0b85a97d-39132d1fc45mr7670552f8f.2.1741565188972; 
 Sun, 09 Mar 2025 17:06:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfbae50aasm4331045e9.8.2025.03.09.17.06.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:06:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 01/14] hw/qdev-properties-system: Include missing
 'qapi/qapi-types-common.h'
Date: Mon, 10 Mar 2025 01:06:07 +0100
Message-ID: <20250310000620.70120-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

DEFINE_PROP_ENDIAN_NODEFAULT() macro uses ENDIAN_MODE_UNSPECIFIED
which is defined in "qapi/qapi-types-common.h".

Fixes: 4ec96630f93 ("hw/qdev-properties-system: Introduce EndianMode QAPI enum")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-properties-system.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index b921392c525..49a3825eb46 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -1,6 +1,7 @@
 #ifndef HW_QDEV_PROPERTIES_SYSTEM_H
 #define HW_QDEV_PROPERTIES_SYSTEM_H
 
+#include "qapi/qapi-types-common.h"
 #include "hw/qdev-properties.h"
 
 bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
-- 
2.47.1


