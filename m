Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC56DC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQUE-0005JA-Nn; Wed, 26 Jun 2024 07:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUD-0005IR-4f
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:06:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUA-0004ee-KT
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:06:48 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7024d571d8eso5109912b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400005; x=1720004805;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8gdrJSUaYQob8d/4ZxzgiF7J5n5fiKZWcn18f0CmUEY=;
 b=SCdPH9CMBhbehc8wnektX4X8oRmrwHenjJEZcZxUzGiTBUHwjFrtYE7P2NFEAI54t8
 dHU6ybS4HWchqGi7O9S0k9QP2Sypv5TPryRDIjftAyjTJFy59s2yUgR/Fb7drFvHzL2y
 elA7igDCBAkdGfCnu/ndsF939H/6EkityYAuCi3nbdArPnZOgp6NQX3RCUAEL/KXuKc7
 5cu768X4yq+mGLVSuKbGHBOiu1lMxFsqGj+YNOi/8bVdaJk11m/Dqj5fu6pvFG8ttUkT
 qs3hCe+WJpTfDKEfzRZiaNmNTb/AYRxlMHVeYddN7di8cq5BBmv3mkfs88QHtvHIO7+q
 u2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400005; x=1720004805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gdrJSUaYQob8d/4ZxzgiF7J5n5fiKZWcn18f0CmUEY=;
 b=hWTE1qHw3JrshddahxZ4Zv+Ti5fdJTto2eKD5XaTxUQuqePPqFQmR84wwNpCJDSK07
 sNA+hvCfuG/AIhIZl63rD4L7EzWR3AT4xMQMiRnJ9wFBfnajKDztTnURsFe+1OeQNSW8
 F3lGWvLLW0NYN3Tx7l7wIJSfqLwPk3s0dOyhTG7B/IMM3DRiYW6QjOy5sp3R3Zs628oW
 xBkNFJcmej05eAHa6dt7f0F16ngJ5uDLKHiSQYVhTgQRS08G2RaDVXLWqEnorFTA746j
 NY4tGKYdoyonMn8f7tqMpWVfbiQ5Gs9kBCx3rl7/mb/p9eaJI7sHyC2TaKPFr2GOFpWc
 XhWA==
X-Gm-Message-State: AOJu0YznRork4p3PrcNsdBnkipPL+hZpsrsRFl3Dc2WOOOJByUMrM4Cs
 6h4NjfGuglykYHjFsuHn4aAqsvJYLBJ6pEVOzHvAcXA5E3I4P9nBbx9MeN54sws=
X-Google-Smtp-Source: AGHT+IEm0Uk3jhijPGftXQo5d28gVdFOecDw4w56VU5pdI4g1PPkbbhI7q/sn3Q44Xj+9R245m8MMA==
X-Received: by 2002:a05:6a20:1a96:b0:1be:c4bb:6f33 with SMTP id
 adf61e73a8af0-1bec4bb7008mr517626637.12.1719400005215; 
 Wed, 26 Jun 2024 04:06:45 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f9eb4ea7dbsm97876115ad.213.2024.06.26.04.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:06:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:24 +0900
Subject: [PATCH 01/14] hw/core: Free CPUState allocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-1-f3cc42302189@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/core/cpu-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 0f0a247f5642..42f38b01a97f 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -274,6 +274,9 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
+    g_free(cpu->thread);
+    g_free(cpu->halt_cond);
+    g_free(cpu->cpu_ases);
     g_array_free(cpu->gdb_regs, TRUE);
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);

-- 
2.45.2


