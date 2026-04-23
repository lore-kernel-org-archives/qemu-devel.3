Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C787FDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxSF-0000bU-N1; Thu, 23 Apr 2026 13:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSD-0000XM-D2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxS8-00050W-7Y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso45120315e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963776; x=1777568576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USo4XixZxh0ONX4Sus0DTLLTZbV9KZKneQvSNxBeWnY=;
 b=Ou7s5s8yBXWd1vrhgtL9pM37yH05xXni+KZnLWVdyJgtLwlihtGGWEBUsuZZBtZQVa
 v2I0BLocrGIeRGM9PzA0ok1+mjaYpaFv2JqOZiHFLfHQf71tMylYAIUgg2CRlJZCyCuK
 aJuesUBLRVqK7tDdvF98ogh+n/tR+ZakpSQrqvsdgIjH5Yg5CrHWA6aILuW4HF44gSgy
 jLMz3jA25Okoa9YOq74TJf7pOKscJgwfjNR9NnDf7FTUBcPqxhOVJg7lYMpJqApGtAOa
 0iJtLRvnuIwE4+GK4+FaOnp69iKpom4sbxsFvNGJYU+7XotohFPw/Np5+mMKM7foocEO
 wGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963776; x=1777568576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=USo4XixZxh0ONX4Sus0DTLLTZbV9KZKneQvSNxBeWnY=;
 b=GabBaO0hRPCJKN5tXa/hrLNs/C6QnXyIarTNZKq9E9whh0hLCsuOhn0Lj3oOdzzbav
 2KHAaO59DNwos3eBNIXOTv74UhJEfTPyWt1o09o1f1hYgCtnvvF7L6pCtYx5YAXdNcwd
 AmnKvLIB4w22Xonr0/wfrX90yAzYE/MLHxsoFCfAOzxQ5uaYD+7WERJAaKhsWT13HJiY
 TCYOYlIRUO0UqzRXYZGDkp8UBmLr98VrzjlKfI6mDHMM4d2uNHpP/IwL5OP5casBV0bN
 0Nzks2ABXZQNnuGGbVPZwCmEnJJw5bNWCKHTooh10SKeQcO4lNVkdapSi7PeKNBxL66i
 Pu1g==
X-Gm-Message-State: AOJu0YxEdncm8d7Zg3xLyiBiUjdRsIwQKbSR/lHN21QVVUCTaCRyVZbo
 18Wl+HrCzzki4RRl0mQVOQn8LoqaWruPHKzedeDXLwYjD2tDpjCaSNwvpF0mlmfjckCnxUsCeBH
 oUJRoFZw=
X-Gm-Gg: AeBDieuUEB/pNV7fhQxs/eHB36j5tVCYuVSuNmIGvn0+GDViVmcHNc4XSM0y8NUwV6H
 OY0XVlO/TYTQuWJ4XIhQqrDYi/QUFyJGsrM06y3j6x4cmxr1NlwZBfJodtMT6KUieUZjMp8YJz+
 erSqaxGH2M4Wf8ahvZoCMLd0ncOaStBvBzAQax87RJCm/gKfpOm9MS5c0lLcvrMoD/MsUZycmtd
 ydq63SoN+D7HFBisx/+gmEuGtRymwZZn2QV4T6qwK9cJkLkNM/PwgBh2FBncV1WT4Q/G1FUKOmv
 PXW16lXnNX4xwlABpU+zp+KBHjNbIKqF7hG62kYQyYLC9Uuws7HSqTTbGuw9DI9i4p7k2veTX+8
 BB5Sq5BlCoApXrqmyfO7MpDbWx3uq69PxdTfFQEgp9KnOSunsNDuXZByf128Di1v9AkEiGmbJSi
 VmqSrYCK4QdHU1aEpzjdlggChpzeHYVmkpEe6nvf7bP/8LmcT6wMWQ7S0+m1MFWUNo3d2ZW8UBQ
 FOycDy1PDg=
X-Received: by 2002:a05:600c:890b:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-488fb775a35mr296097165e9.19.1776963775607; 
 Thu, 23 Apr 2026 10:02:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm580562955e9.1.2026.04.23.10.02.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:02:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/16] hw/arm/virt: Do not select Kconfig symbol PCI_EXPRESS
Date: Thu, 23 Apr 2026 19:02:15 +0200
Message-ID: <20260423170229.64655-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The PCIe bus is not provided by the Virt machine but by
its GPEX host bridge (selected via PCI_EXPRESS_GENERIC_BRIDGE).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4e50fb1111f..41d5e968c86 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -15,7 +15,6 @@ config ARM_VIRT
     select GPIO_KEY
     select DEVICE_TREE
     select FW_CFG_DMA
-    select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
     select PL011 # UART
-- 
2.53.0


