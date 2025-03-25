Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64177C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txCzv-0000v0-AS; Tue, 25 Mar 2025 18:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzh-0000jx-D5
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzf-0006wr-Sm
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso3423623f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942614; x=1743547414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SOvxtJeq0EX5lR/jkU2/dH8LgMhbpkIvEfLhQT46Rg=;
 b=cS+9YF5DO1DzdWrCU5nGAMAQliQt2Ombjdj8Tod6IdFBtB3t05t5+tfbVOi21IugBo
 yhWlPTTKLAm0u/l6r1TWN4JDs0Q+naS/XxSt6+bhk5xfIWA93LRz2R0lxKC6fe1BsKM0
 WOTGniZqasvKsv0YpPdHC+jrq1c4UNa/t7QxzlNFNssW5VjhiY2cJ5xwvMJzMTiBLvna
 Y8IGLH8XTf3pfnIWHiH600Yy5oCBt6MIWYKvWFQFWQxjV4JJ3pvxbz9Cs1yDyPJkS7kI
 uOKRiFTHQt0PNVcAHy3DTqv9ViYLI59H19zieviylLnNAkavoPeCWpte8ZnA0B3ztWWq
 AF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942614; x=1743547414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SOvxtJeq0EX5lR/jkU2/dH8LgMhbpkIvEfLhQT46Rg=;
 b=T8SKOq3wAQeF31iFvbiFauocrTNKTdy9Qz9WchNW3Yi0Y+QEQ13g5uBeUL3Ga/81+M
 v0Bq1fLogh8GioS2W53Ov/I1BYEEJvyb4bqvLk8nia78PmupDSVFXFVgJYXFc+VTZ3u5
 cq90ArPKqtK/MaDd1pFQ2CE99WCYV7mmA0v83sHSNbd+ypHQJaJVy/G9IEOYR2QqeZi7
 HiPidvwLqVOQmZZXgCnDadbODYcoIh6wGma5Kjouyfst+pjmM+Z+xrZATSUuEorzb30f
 FboBOqePcuOPDcT5j6qeugILnrfZ+Z78M/fEsyPkk9HL+XfGMDJUL4PWFjto9KdjhnfD
 okiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsw7cbIMSNc6xZYJxqPUyMSOnksNVkQS7bhMjjYJ5r0titFU0JPnXJas7dFBuE+KfooVWuQcC8+bDl@nongnu.org
X-Gm-Message-State: AOJu0Yxr/t0aerAWbmRzoQFmBW+5PnEL/zy8DGrdCX2/IA1w3+Ed3nak
 hdvqF3ktBvxk6+SIrnvRA8owZwV0hqmtUQcRTe3uMVX6MxXTm60S5FdPgTpI5uA=
X-Gm-Gg: ASbGncvbYAoZwzSqqFXh1QdglUmKf6MkshWsxFDiuntfn+CZDcAgDwD/Loht0yBXOMt
 XHuzthZGX3TjLu0QqmlOBYmE1+QMv9rBVglES1Bp0FriLjlsMDmsZys2mOOrIP/xi5Bt9cGVALk
 4THRcyOs7yvhNjdSePoTvkTbr2clP/1PVAIqNiatFATzsejUvlnKZPAgADdQ7TWNnTUqMQZH3MP
 MUmYQSJJNxpIgJEbRUa54S8dnXH0QW28U/DIlhiHhgYcFxDkKNDbAB67UQQvrVdXO/gHj41qniA
 RULjo/NU99Kd62R1wEr5/G4WxlIog6W6MvtngYXfjkAYb+XRh2ZFLOdKK/VbRlZMZiUgPgF8Scd
 BInZOen0kiN+voH8CnSo=
X-Google-Smtp-Source: AGHT+IFeVdGSd4Y1ZRCNz3OUiqxsUVPZjedabVUe+RqcSWSAusCvErNVEAL+11un++kP3/MeK5lCEg==
X-Received: by 2002:a05:6000:1842:b0:391:2c09:bdef with SMTP id
 ffacd0b85a97d-3997f9261d0mr15336360f8f.30.1742942614322; 
 Tue, 25 Mar 2025 15:43:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efe61sm15199585f8f.97.2025.03.25.15.43.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:43:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 04/12] hw/dma/i82374: Categorize and add description
Date: Tue, 25 Mar 2025 23:43:02 +0100
Message-ID: <20250325224310.8785-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/dma/i82374.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 9652d47adcd..0bf69ef399b 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -150,6 +150,8 @@ static void i82374_class_init(ObjectClass *klass, void *data)
     dc->realize = i82374_realize;
     dc->vmsd = &vmstate_i82374;
     device_class_set_props(dc, i82374_properties);
+    dc->desc = "Intel 82374 DMA controller";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static const TypeInfo i82374_info = {
-- 
2.47.1


