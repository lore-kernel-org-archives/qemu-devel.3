Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9524C30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQV3-00065k-VL; Wed, 26 Jun 2024 07:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUb-0005mp-Os
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUa-0004jD-AY
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-706a4a04891so780217b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400029; x=1720004829;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UtuCMhxUWw1DUkDzmxPc06M4yVAzJqdA967oAcSFqUQ=;
 b=SJeHWumu0ADDAZqcqWySPr/apWvWYfN1p/9LGJNIguUIu6/3O45VqtGvkrkwMR7F67
 MJDq00f5BYKOehSaJ0aGAcXjSqI3pYDBEFCeLu8gNn+iJqep/WQUH4RBs65Oa/ypIPbJ
 Z4u5NYh9i71DUVT1q+GpbRLXOKDaB1KAoIEuiGDGCfbTaVlYnisGX2l1VSDfuHpThRZs
 H6SPPhhjpifmbTZMV5BTEMyFIzLHmnG8q35N7JjelQYcCoxD/F2ReCxGEF8B8K9o3Cqh
 0vWeepOmpZdvM8YWMGPkU4fnH3puK5DgvC+igwO5zm1ECh0J0diXzgjxC2MDnosrLKvs
 j0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400029; x=1720004829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtuCMhxUWw1DUkDzmxPc06M4yVAzJqdA967oAcSFqUQ=;
 b=UJfqCbM5kvdAye53p5WNmIwi+t3Sjmcg56u14ros+7wePcLhXla0yKu153JTJdQUkj
 nFh0fOWNhD6VmJbvYeQa3WqxgCvwMUFy8hwuHzACHYKXX0NMwF2iNgHrtoGQSVoQxmTL
 3qHe2KPB7gPIIhV7kcJLwwUoTq+V/n/CmMXqzMtj10jw3qmhk+jmKq22lHF/mEFDJdSW
 +5CZKrwKn5DpnJL1eh/sLsEdacNQKqad9jSd8MzCyziZjv0mf627CcLkYpkk6V76wqU+
 Fe0NImLWcb84+eLgOTfB2lXC/eribwm4wsreKK8p1qkzEwXZb4SnahVwdRvOV+s6x+Lg
 Mchw==
X-Gm-Message-State: AOJu0Yxty+dadKxuy6Pv2lH0nH8IjhaQiW6sii3m/OwKUX1Ry8P8mLv9
 z1UmHArLI6AQJKILJLeHmoGwq8kmE9Mj9brTlAPKgoky7TOeX2eZXmH8CUR6LMM=
X-Google-Smtp-Source: AGHT+IF3Dc+m0QChTJ3J+oL5hbq9A7fYtNIurG9m8CclKzIjtqkWKlYcuGP9lQhN+pnh+ee0yqYcZQ==
X-Received: by 2002:a05:6a00:2b8:b0:6ec:da6c:fc2d with SMTP id
 d2e1a72fcca58-70670fd4341mr8138448b3a.23.1719400029011; 
 Wed, 26 Jun 2024 04:07:09 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706953ca94dsm3374624b3a.199.2024.06.26.04.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:28 +0900
Subject: [PATCH 05/14] ppc/vof: Fix unaligned FDT property access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-5-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
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
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

FDT properties are aligned by 4 bytes, not 8 bytes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/vof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index e3b430a81f4f..b5b6514d79fc 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
     mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
     g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
     if (sc == 2) {
-        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
+        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
     } else {
         mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
     }

-- 
2.45.2


