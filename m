Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C0C30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQV6-0006KQ-Ap; Wed, 26 Jun 2024 07:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUv-0005wi-Lz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:35 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUp-0004kx-OM
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:33 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6e3741519d7so4515848a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400041; x=1720004841;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mUrmTt8+oFrzMkNkVkHTZpmYshFavrmG3OzzHBupQWA=;
 b=yhKuopH7NajgdB0EjwxQaCBPu3qyb8EajO8IOqVMA6b2IIfReFhhTQOX6rNEBjmjrO
 g32wB5dliPrTZrS5oH9auxe7pq69dWt1SiDhwjSB6cZL3d1bZW7iySCxIKTttBK20iNI
 EZQPHIomKhE/vWiM9yRUGOzKZVmG32bKxj2Dg4kWL7TMPkfvxnlrp0kYnusIKHoWgPeI
 JrVU2lwhN9BsrfKEtySQf7NHRF7+NIu1uSFrNvn8IdKcD4UKBzyrYzaGL6KYoHEDMF5X
 9fZzRPO6fnBXXol4xQjO5Ny7ZVZ1IKDjAQHPo7+jVsntMAniafzvUS7Ctyg/6ltGzAD8
 LEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400041; x=1720004841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUrmTt8+oFrzMkNkVkHTZpmYshFavrmG3OzzHBupQWA=;
 b=ePiwwyMo1aHBb1m8ANDzYKXu/TlD2Tj5Rx0b7Ik7rjbefCeyoNhYlELTbXhZDh1W5n
 dFZJ6kXdYisMNLsnfJqinyVtLr3o7/5oDpo8BKX+gC8k6wMU9AV3AL2EWWDQKIEjOU58
 7mzxvG1bH2Ggzob9bk6ep/OPzPXh0gs3cT9teavic46AT6/zSm/qaErMUF7QsLjFcIvY
 LlOhR0e6gc3tPyKlD7V2MQZOvh5pufuqrC5pPbHHb2PZ+KzDmD3acp9rYBSOY+FIeXYP
 A37rRYH7k8rRPY5Kt7/wdnQ+BwXz5k/oZE3TCYm1Hs+AAUD78CnYkj6uKDlFcw/qvpzF
 HK3g==
X-Gm-Message-State: AOJu0YyWDnIF3iP4hj1qnUcUy4argv5zEZoffY3VYpfZM8To5FRQd29q
 TFxRzBPosP/NXOtGcXBtaTcxFxpotvYwq/iqfQE1JOPk3cksI1MvqrpFUm8YIJs=
X-Google-Smtp-Source: AGHT+IE4qbHI1diVoBe9v5IequM5ti+nRE8x43HfaWZexsEG4+NNwDbERwgbGUr7DxNcZjxO9MjDLw==
X-Received: by 2002:a17:90a:8c91:b0:2c8:538d:95b7 with SMTP id
 98e67ed59e1d1-2c8538d9832mr8818555a91.32.1719400040964; 
 Wed, 26 Jun 2024 04:07:20 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8d8061497sm1380082a91.34.2024.06.26.04.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:30 +0900
Subject: [PATCH 07/14] migration: Free removed SaveStateEntry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-7-f3cc42302189@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index c621f2359ba3..10b261823b7c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -874,6 +874,8 @@ int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
 
     if (se) {
         savevm_state_handler_remove(se);
+        g_free(se->compat);
+        g_free(se);
     }
     return vmstate_register(obj, instance_id, vmsd, opaque);
 }

-- 
2.45.2


