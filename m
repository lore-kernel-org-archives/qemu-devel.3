Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E46C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNYZ-0002Up-R5; Fri, 23 Aug 2024 02:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYU-0002O0-E0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYH-000378-9c
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-712603f7ba5so1403527b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393616; x=1724998416;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b4fRw6ya5cnFbQAZ70Uw8BnHXsKEEdwvnI09RO2JZjU=;
 b=dlHtcE0VED/esk8e+YdidFgXWkO4W7WWNGo4SmgANOd/pxSB2zR4j/L+gvnchExWZU
 YdCSJu0cIwBZv2FCyc2XjeogVZSG4P9eNO4DeXee0ywbumuuGwZdfQQnPeo9CRnWu1ZS
 7eSCXHbhXIpTI5JppcTLORuOkPkKDqv+V5fE6k2iMShhyu50+kJ5DwaTKhr6hOWNhCVp
 BLvm0LRxaGW09H5DMg6P2Dlhk0w8iWuJuVABvd9eIKEGRO2e/7Qlf3AhJJdeDHq6PvUH
 DCbQ/IfdPoAJ0hPdYK7ak/M6W5XrcfSqXPHjR4nAaVGxQlP/9YwXaUY+2yE1Vr+YTP8z
 wQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393616; x=1724998416;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4fRw6ya5cnFbQAZ70Uw8BnHXsKEEdwvnI09RO2JZjU=;
 b=u+QcwN2ptKnHESGovoO2wmLstbgDLfeuyiXJuneG3MrO0zAXY4UK5qL0WAFPOH8AgN
 4MGdIIMNCf77XklGlhfDaxqir4ncZBduA8xXwMgPDzsinFqiCDpvkiioPUEoB6pqnsng
 XeeUhg9dw5ur38CqpJ2GdigUYk8ncpZRVaJzSwtUyjE0faguLnO0x87InK1jwRB+2qlI
 CyVp7SnSBaZeBNTpSX4YOVXwcqUPH2rZqTfoAt25IBTwK9y5wNsEeC8SyM839tHri5xx
 biecnc1ZO/v3bGQImgIxZNYrkyK7ilWmyeRvBkRnpfF3Mqo1Pwiy0KQquqGzRfMcIo0/
 qJwA==
X-Gm-Message-State: AOJu0Yw8zFsLgjyyy+SoYKAIp0VYbIOta0hpq/o+J8AS5AL48q0vpPLh
 wu2GebC7RNqtirKusA25EctfMPCmgk/oe3dPquGwG0laF1M+kmJncPCiXAC5Nhg=
X-Google-Smtp-Source: AGHT+IEqho7w76m6+nPWwV3j9fAGvJFVqKDMS/DQRiOrn+gYlgjQbuDe7q2Ae/okScjoRm2rK6bGHA==
X-Received: by 2002:a05:6a21:478b:b0:1ca:da51:6635 with SMTP id
 adf61e73a8af0-1cc89d29da2mr1717102637.1.1724393615889; 
 Thu, 22 Aug 2024 23:13:35 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2d5eba26377sm5363854a91.32.2024.08.22.23.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:13:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 15:13:07 +0900
Subject: [PATCH v4 2/7] memory: Do not refer to "memory region's reference
 count"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-san-v4-2-a24c6dfa4ceb@daynix.com>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
In-Reply-To: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Now MemoryRegions do have their own reference counts, but they will not
be used when their owners are not themselves. However, the documentation
of memory_region_ref() says it adds "1 to a memory region's reference
count", which is confusing. Avoid referring to "memory region's
reference count" and just say: "Add a reference to a memory region".
Make a similar change to memory_region_unref() too.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 02f7528ec060..b9f0ad09bfad 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1217,7 +1217,7 @@ void memory_region_init(MemoryRegion *mr,
                         uint64_t size);
 
 /**
- * memory_region_ref: Add 1 to a memory region's reference count
+ * memory_region_ref: Add a reference to a memory region
  *
  * Whenever memory regions are accessed outside the BQL, they need to be
  * preserved against hot-unplug.  MemoryRegions actually do not have their
@@ -1234,7 +1234,7 @@ void memory_region_init(MemoryRegion *mr,
 void memory_region_ref(MemoryRegion *mr);
 
 /**
- * memory_region_unref: Remove 1 to a memory region's reference count
+ * memory_region_unref: Remove a reference to a memory region
  *
  * Whenever memory regions are accessed outside the BQL, they need to be
  * preserved against hot-unplug.  MemoryRegions actually do not have their

-- 
2.46.0


