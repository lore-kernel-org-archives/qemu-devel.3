Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B03D3B997
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3yb-0001CC-Ci; Tue, 09 Dec 2025 15:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yZ-00018G-2a
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:23 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yX-0001Jc-Kv
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:22 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e2e47be25so3076118f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310779; x=1765915579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mm7cQtcn5xkKQTNvHIWxJwwmJPuvh0n6grNa/WZuROg=;
 b=Ux9q6JUSRviniacjq7AwtRTzhLrPv7PVKnRUHqt+UGTS7ZYSyk200I0ynBQtLzZp2o
 etJL15E2tD9GS2A0X+jEWTk6IfYhj0KQz0layqg8hfu2tVe7cnR3A9kcAr1FqJtKbsHS
 oojvpKrRqwVgsjXnJOStvYMwGeGb6P+AYCjpS3hEnYJRc5ug3b1+LjqWNNCV+KyzsCoi
 VjdKsjnUxg6pPRt1yBRqmzPUFZOpiq6tJzg4g6ilJDWluJG9NJmGFx9JWqgTbJje+Dk/
 EfLNOspOdodf11dQucTg7iX0ehm8AkMvEIUcenQZ3q89OkKH+aHDdOK19ES5AaEcSK9C
 33PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310779; x=1765915579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mm7cQtcn5xkKQTNvHIWxJwwmJPuvh0n6grNa/WZuROg=;
 b=PxEu+Kn1HNUnznGHotwmBdooSdDIQQVp2BhMq1HOb//WjYYFBb0V1aeWUQGKyE3dHx
 v636O85mkKQRVlILSr05fEO50oQAWrw6wK7jlB9WkR3XC2LD5L8M6o+vc7qPQn/JVaxn
 fsNLFLfZYZxj7oI03LSAdDXHqqPtyb72OBgzPKEi5cW65dYXcOX4Kcjp6xV/fZfoh9f4
 KzLiTlEjpNs1LHP9mCQrkcUDTgBvcLj9phWHXbrYZEfaJdWgsfIkxgPSRcijPYJcxf6P
 vUxMYd57tET0L8ot7qm1Al/JJsSNX7LFExhS68T4Qj/UZKMu+R55fEdcC5Y1NDRRat20
 nLUg==
X-Gm-Message-State: AOJu0YzCDBbfD1rPcfz6LF0HbxsghYucC2iv4EKg6LEtnvoIb4jayp9s
 gkAcP3DsDE4sd1J5qn5y70JzsNF3rvT3vcp+2KPAq10nhddJfLKmkNQvXAUe4L2x9o1SBn2K0Li
 7UvTM/Ho=
X-Gm-Gg: AY/fxX4RDQ3tBfsmzbtGBXFfjGliwdybtQgnwVpVSIGT52g+RNVt6mY4KKVVFkcR8l5
 O0iJ1Uau2dbI+GWJCQhYBTMMyAsGkfZX+n9OHmZOwgewEg3u7ZLZYaDaOYgdKElI4Ui/cZZLeEN
 BeTdmA/UUkyctNpXpwkQpPTnUIblh3JNt4IGVdok+KkJPPjtsfI4d4a49AmyWdTBwZJ+isDHUPe
 jMk+BqJfYKsJQah7GocxmMIKWvqB3Q/X/4WJZslcYx87Y13xuCyn8B7n64n48QwIgHRHp0TDz9P
 I810ajE/e8QfdEpTpY3BI/N+UYiPAW+k3FuCNgRxqlcQL8824fbz8SLAOpUrksvc/9OQtbmoX8+
 2lZsOCgBsuzgyQPHHTo7PjkUvA5qGSJeIzLBaNcKxKG/mp3fZ34qlPs/KkrMGwMsdQz81aVgY5i
 oKNypGi5DsrZ88DZOoVbGLk63Kto8hD6xrM8oFXpamHZImAdJe3gjrK8iU1WBu
X-Google-Smtp-Source: AGHT+IGCcjDLKc1LXLzaeZIIAtfda9+zZCb/+juAMCDdJI4u6knVPBN8+V3lCZ3WxjkaS414aQwgNw==
X-Received: by 2002:a05:6000:402c:b0:3e8:b4cb:c3dc with SMTP id
 ffacd0b85a97d-42f89f0943fmr13001691f8f.3.1765310779483; 
 Tue, 09 Dec 2025 12:06:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d22249esm33049671f8f.25.2025.12.09.12.06.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:06:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] hw/pci: Fix typo in documentation
Date: Tue,  9 Dec 2025 21:05:33 +0100
Message-ID: <20251209200537.84097-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20251209125759.764296-1-sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6bccb25ac2f..b72e4845009 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -751,7 +751,7 @@ int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
 
 /**
  * pci_iommu_unregister_iotlb_notifier: unregister a notifier that has been
- * registerd with pci_iommu_register_iotlb_notifier.
+ * registered with pci_iommu_register_iotlb_notifier.
  *
  * Returns 0 on success, or a negative errno otherwise.
  *
-- 
2.51.0


