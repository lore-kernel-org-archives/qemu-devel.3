Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4875DCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7yX-0008SP-Ho; Tue, 21 Oct 2025 04:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yV-0008P2-DN
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yT-0000vd-JA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:11 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-426edfffc66so3917234f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036247; x=1761641047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3K5y5Cy9vHhm90mgMJ5DoRZ8l6l8+H0Bizm6UlEWJA=;
 b=chQpY0zndARBr77YwkXaxzTsj14nPP70kHawkGUB+S5O30/SNzOGeTomJZvGTBwv83
 8reLFm5VIBeFTxykFpDNatCKxhTFyYKgi6ECi6UVXgmGYLK3trXL6pC55fwywzH4Jlv2
 A8AzPEOvW11rfqWPU1OeBBTAd7S2AIqn2WHsmXKlXKrUToVwnZIt2qiyStn8KXBvAOoC
 eoeiAzJjNrSMR1zpKdun3csAGkK7oMh+7myRmGWZ8kpAGmGKHHtLEmU/k9RlfcYpX0je
 RDK3BL97h/kTqYRRiYd0o6Ltiky0y0hT3J9QnuB0H1O+CyZa5/M7guYCnjYSFwGstTRt
 Knmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036247; x=1761641047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3K5y5Cy9vHhm90mgMJ5DoRZ8l6l8+H0Bizm6UlEWJA=;
 b=j6BEEZqhACLDxpV5Q9h0aut65RWttiAVu1bn5FPG/lFU5RWPBaf1dG25Fc6m+ecIWp
 wcwlRstQ3rDZcyzknxKZVB57ywkaaVnAHgUlXKP0uGNOHog1bSZbutL5SHH0923ua724
 uqtzwHm6vlkE7zadhphivKVUeJqodIMqh4CdPd/7mveX47dxfR+XroDnBRQWKpUPStM/
 z9YJ6Adm8CWtTRRi8w6+r66FrkYjZ7wjfnRKh4lWLMQScjE6CojC6UAmPuFk3PUUMPdv
 eHbPD3Wp8ecF/k7hsL/s6BbF+s/b9nLS3bx6HWcpGsuOot5LfVJjXAeSTr/oq4lAgFdS
 ZY3w==
X-Gm-Message-State: AOJu0YzHUQf31Ya+yRV3RLxRTBgE4NkETrrFE4cHILHL1DwZcEChhLBX
 cZQjEfSPXDxz5dzDZIh2xySC1u+xyKLrrs4yNrz08VvbI+oSV3+0BL3rHq8AdICvm3wAarqUVwL
 LbBNZoKg=
X-Gm-Gg: ASbGncvX6IPEhVlpwkGUPnFCPAbIjK0cIXfHqi15EE0FcrOO7iqVN38dFrT7lRinMqB
 oGi2MqWGSJfsPxHvAEjCNmbR7pUIdySGKgeQL9oQ/GKdo5F+e/prRa3oHFyAMdrxw7+WXLIwQmu
 I4633SWQG2FTQKtguwYsGWCy36LxIOPj5T390sQnxpf2d4ehm4P2HBcHVxYPaQLYG3dOO93GMDy
 vlu7swr7pvH/Dht0lw/jcDlzfUbBYhz8c+TF++ssq+zq82dypvHb1fF/wrvvTJUS0xcV4ayU2Y1
 LoJPt8nwpC+HzUiqKKrT6kaW8OllFD0J7OfyN8E+lKt7bhe/Eiv3VBdhT8DA/5rGj3VifpEgM2t
 R5DBW3ZS/wVZkPZxmK1BKIroEN+q9llmho3gBGBQl8pW63DAnBwz/clqA23IpB8pGpLywxrB9Hm
 EzeoP+rWm5v7M9Hnlf08g7l4Ey2qbkOg1m3bAkfuS2ZD1DkwANDw==
X-Google-Smtp-Source: AGHT+IFrUC44XvQIgOPF1oe6aZhOa3HgUHCNQaYkwG+BqMdOw9kgMknMuXUQUq9O++GPrdyZKrFphA==
X-Received: by 2002:a05:6000:240d:b0:427:7cd:bde7 with SMTP id
 ffacd0b85a97d-42707cdc0c2mr9949977f8f.5.1761036247544; 
 Tue, 21 Oct 2025 01:44:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9853sm19155987f8f.33.2025.10.21.01.44.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/11] hw/ppc/spapr: Inline spapr_dtb_needed()
Date: Tue, 21 Oct 2025 10:43:38 +0200
Message-ID: <20251021084346.73671-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 458d1c29b4d..ad9fc61c299 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2053,11 +2053,6 @@ static const VMStateDescription vmstate_spapr_irq_map = {
     },
 };
 
-static bool spapr_dtb_needed(void *opaque)
-{
-    return true; /* backward migration compat */
-}
-
 static int spapr_dtb_pre_load(void *opaque)
 {
     SpaprMachineState *spapr = (SpaprMachineState *)opaque;
@@ -2073,7 +2068,6 @@ static const VMStateDescription vmstate_spapr_dtb = {
     .name = "spapr_dtb",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = spapr_dtb_needed,
     .pre_load = spapr_dtb_pre_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(fdt_initial_size, SpaprMachineState),
-- 
2.51.0


