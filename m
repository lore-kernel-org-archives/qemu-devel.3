Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57BFCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3x-0002bg-WE; Sun, 18 Oct 2026 09:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3q-0002Tg-MO
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:26 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3n-0002Kx-2z
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:26 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-93e6eb77f0bso129550285a.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330582; x=1792935382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x4IaF9z025l/Fpk2IsxGNfdeO5acQjE/iVO9VTHti00=;
 b=Rp81lUiWcDpBGTDCTBibkbGJt0EX6+wSUXes3dkIOa1l0PgECNI0b+IVr+XhDuyxs8
 t2n224i5LyViA/z+dDaAZSuE9y1JK5+9OWnBqwQdWLuS7dvPnwnCax+WOQYCAUA84bwJ
 a+uBGNgAu7/81wgWcXIHJB6kYInoI46kEl4PHwyB52X9Huuei80VoLTBzA4wUYdF60Db
 1gDsrwVkW0FqfGfMzg9IPiH7e12a9ZUDjPXS9G8A62ZI1S6p/REv+aU+yjaCdqFn4dbX
 5/Y064TA2H/qw4PTV0OIY0DQJS962de168E5NNumIh36MvXWLc3Zq0qoSNxbclrWzrT8
 R9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330582; x=1792935382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x4IaF9z025l/Fpk2IsxGNfdeO5acQjE/iVO9VTHti00=;
 b=0+LDCiXrKxOg7dyfV5baP720XPIRqMCi8m6znxcN3rR2cLpxuQFY0ICN15oIqwQUYG
 n5HLKDU8LW4keQUsQgkoFg7nGj+8swgFyaP3EsOP/5RVlPnXJ5sqZZR2O/Nt4YOmT5Cd
 SQUUstFQSfLYk7Rp+Xm16EtxQDUHkh9ehIGWh3gODMiO/Q/6JR/7n+yuV8kQR3gvKkxQ
 TgjRKacPoHnBl07dhyg5aBrn1jtzlmOy/e1UCddm+cHbwvixCZ4MPcwaWYZ/+V3Z+5NM
 +aCJ4KrcyDb8sOgHkUIRauyWKB+fLYN2Y0vIzMNlqRwh7XuJx8TOhWQe9GjPpm3xFXOm
 qLeQ==
X-Gm-Message-State: AFq9FYJ6q+OE+oTT7kDq9BvUI+Sv/GnGVJdUR2fccPyyvSoCRNasn4uU
 67bDsowGtXqKTUqTOvSQLA2XKL2tr59naVyxdZ6O/UjmABrBB6EZj2A8WaNPcnaH
X-Gm-Gg: AYBFou21A0Zp992IUICH+4e++MfJedlhbwdfbiIXACiKomFrFk9jppWm+8OXHmHrr5e
 rI8l65UrL4f5Nh7om5RlPkY3QWVISU5ZBiYo7RYQq8g3YoJow1tai6VTgQxRFSI2Q6hdWI9EXQc
 JgkGTsHHZBgcx77tYCIzY91u5vGuoAOurY6CfFWS/3/98u4nhbiHKqH+SxJaN1D/DK9vrIu9qU9
 lXLHEYaXP553BC8WHo0Lq5dVTX/tF8EGCNNYbs55xWsW9IbQW66eZc7NDdB8+kzl5yzGKDApVuY
 imT35uJD37MUPGTnALPM3kKocXIt+g0diML9GNHqawDIDkH9jIuvxGwHL2SQvRxBIPykzrDw1l4
 GYNTA+Wzl1t0U30cH96XCQHnn9SV2LRW90TJaSCkgBa5qfnZY+R0HZgShPoAkWSujp1wex4MuUP
 35evZNmwtxnRGtoXjSC0AcTeKRqeNDN1Upa6A+eEnc4/8wGelqSLphCd9ISQd5Mec+1QlnmAFVc
 CJP6asrilqBUSDslVrSR1PZ6uB9ZUJAipWrRpbYeL49M9iOGmFoE0eYFatb0XUk4GpEj/E=
X-Received: by 2002:a05:620a:290e:b0:93c:ba44:673d with SMTP id
 af79cd13be357-93f29ceece7mr865957185a.23.1792330581954; 
 Sun, 18 Oct 2026 06:36:21 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:21 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 16/17] docs/system/arm/raspi: move PCIe/GENET from missing
 to implemented
Date: Sun, 18 Oct 2026 09:36:02 -0400
Message-ID: <20261018133603.64323-17-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018133603.64323-1-marcelomanzo@gmail.com>
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

raspi4b now has a working PCIe Root Complex and GENET Ethernet
controller (added in the preceding patches); move them out of the
"Missing devices" list and into "Implemented devices".

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/raspi.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 44eec3f1c3..a8fc37e920 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -36,10 +36,12 @@ Implemented devices
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
  * Broadcom Serial Controller (I2C)
+ * PCIe Root Complex (raspi4b)
+ * GENET Ethernet Controller (raspi4b)
 
 Missing devices
 ---------------
 
  * Pulse Width Modulation (PWM)
- * PCIE Root Port (raspi4b)
- * GENET Ethernet Controller (raspi4b)
+ * PCIe MSI/MSI-X interrupt delivery (raspi4b) -- INTx works; a PCIe
+   device that only signals via MSI/MSI-X needs ``msi=off,msix=off``
-- 
2.55.0


