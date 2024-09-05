Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15690CD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC74-0001UG-Gm; Thu, 05 Sep 2024 09:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6v-00010j-Q6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001kO-7k
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso5996405e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541272; x=1726146072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/1zEM1x6OVqIhqR0ynhG68F5R1rKfetSPpPKrgmLcWE=;
 b=Vo8NTsrLVRGPN/5ista5TiplIwnOm195CBK5hXTku/488R1FpF/OU6RbGhBEWjNTl2
 J7xzVOBg8Dtqfh8ZJZWQzKqYbX/mef0Gy7sl75ueuqnvs94Urjwze3tscIgA2TxRahyf
 lYpKJcNrWcF7/UJ+qvWnCGFZFXy7+f/u+/VN3X4PyupmlwAczvvaZtrejtQ7NjM4R69Y
 HDaLQtOLLt0PZ4PzKq8F7wLU8XA4xbjFKDwldOezTBKbuGcjFv4te/HVt6Ph9i8Mzvpd
 9229EufOP/ECNsyIuYRGg+LTSgRb7fuvXAu6LY68W86QF7zewHS9+kvO5WqjslvNGnBM
 FXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541272; x=1726146072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1zEM1x6OVqIhqR0ynhG68F5R1rKfetSPpPKrgmLcWE=;
 b=iT55Qgi4np1s1UEid9bgfHoIyqSYvi3lUAvKgxiSVkC7q5XDkYF4jYRPCBpbExIjiW
 IyWhNAxYTavFtZEbSLy4FKLID0vRzDO/LmEbd8PKao7XkOY73GMB7TN1I/kwYu4lQAQA
 BrzEXL3a5WFR7kzU4wQgokOWkznYAcMKMS/M6aQcpAePIuLfX2RcAZQIlJCiQSVpWCJz
 9F4s7qa5axy44b3+H4ecUSgxb/7J86VIbTQp8kkogB2HLwx4Wq7+HCfTzTiH1YVBV+s+
 6vvv2Pf1bF39z87s54KMTuVEteNELb7E2JzyR9KeC7PPTrucl/s6AAmauSeurHPaQC9/
 yBiA==
X-Gm-Message-State: AOJu0Yye2EPSAafHTvaob6tJwYtu0l49v5wnXmXF0Q/scX2f7jZXPbzr
 GqsWeMjcGGwgH4udeTpwr/QKOU2i3oPuOseSXBch1W7YWdXbH+MdMsY5lYVWD+qETvj86BEIQeL
 v
X-Google-Smtp-Source: AGHT+IHR9nfitc3xMkWd6+4bWjNXxjmK4Y1jlpLloUow3joUSGeXv4I27i7HKafEFno2xhwUYcrTdg==
X-Received: by 2002:a05:600c:4509:b0:426:6153:5318 with SMTP id
 5b1f17b1804b1-42c9545f8bamr39624475e9.19.1725541271976; 
 Thu, 05 Sep 2024 06:01:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/25] hw/arm/sbsa-ref: Use two-stage SMMU
Date: Thu,  5 Sep 2024 14:00:48 +0100
Message-Id: <20240905130100.298768-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that our SMMU model supports enabling both stages of translation
at once, we can enable this in the sbsa-ref board.  Existing guest
code that only programs stage 1 and doesn't care about stage 2 should
continue to run with the same behaviour, but guests that do want to
do nested SMMU configurations can now do so.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240816161350.3706332-5-peter.maydell@linaro.org
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index ae37a923015..396abe9c1bd 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -621,6 +621,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
 
     dev = qdev_new(TYPE_ARM_SMMUV3);
 
+    object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.34.1


