Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDABC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIee-0000Tx-V6; Mon, 13 Jul 2026 11:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeO-0008UT-T1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-0001AO-H4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493ec555a26so21576715e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956771; x=1784561571; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bkzleIr6QtX2FYwb1SY9PNRHwo9lxQmQ1xA229dq5sE=;
 b=wAKqczvJrZE1QkUav6meZ4dptMIpFkrdakgq0xHa1wZ2jgq9y55UK7msayhu3yCUo+
 9JBFD9HTvjVfVvznZYfycCtblKE/emNwKculC6XkYgsij3BO+ttdB9daLHxVMywXFmPy
 zl7rV0ce8z/vRWXMpZHXz6TEglDeCnZrlvk8uAMfqNcOEIvhcOVkmFnOuW1/3Ytcn8wk
 4QH1iMOnmxIekGrxOO3Z9+5uw1gMPBUxi4M/TX+991fosemAH+BFJtlCEi/ffUJmQAJ1
 VaJgIns0hdjBHnjk3QI0e/lcUfUtyzDbqc7zmnmxi01JV+Ipc0RBGySiRjnrtA309NZj
 50aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956771; x=1784561571;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bkzleIr6QtX2FYwb1SY9PNRHwo9lxQmQ1xA229dq5sE=;
 b=ZWTMUD+zG87MqWQbRiT6MZbLxTH7Lr11IQ0CDX79MBOht4kAZoiC/kXryXn80+Rq9D
 X+4wI+cHkxD3ovecWVEjNpOtpXpA8a5g9U75HoJwZQh51ACKjyrEZRNOAucg618iZDku
 JWbhQmrWexwQgwa5+o5E91JWqz0+3aIFIGmp9SI0AxqpQ6C0gDkbMfawB4/ceojbdMfz
 JjgZcaSSuZHtlTKPYtc6QR6U2U/pFP8ohmScm6vpPPlL88ohgSk0Ll9l2nl+en/msB3y
 XembGHprIxcR7YFpNYJCMaYAfma+sFlqpvrdGtvLOThGNvHqK+eP6G7HKwPCf3LwUJ0D
 1mWA==
X-Gm-Message-State: AOJu0Yzavt+4tns1KtToqQZFVToIqzs9z08kDUAgwj3sNhPcReVLdhZb
 PSq26tNtOriM0RCmSXMRmy7hPnIjZGy5dfwn4qNT48ITmrGwAI5R00QuFzL6EFgKCR3orlxg6FW
 l635Byi5XkQ==
X-Gm-Gg: AfdE7cn0ZtbuaaoULdRy0igJ2vrfF94JR8ULLfh1iGTMVQyzYtDQbDD2ZEeb3JaffdE
 w6EKLYeSO8+I/LnZIsDfVPiUG9zg9skH6LJy6oW4FjWD4//cNzE8xudSc41/V7H2ySa6Hm7n9So
 P55anOog6qorg3hQ01qSY5iH2y//E1Bjps/kmTZuuK1wbaCqEoaYQ4xTnZtu8R20wB8gp0pNElb
 zi6csvb0ZSNX4nQPPuw365novZVmmMhH6l01pJUhLv23FmvDq+sxzPlQYronYpjTIc9slLzzPsa
 BZ9oFdmq2RP4DkC71Q5o1/SAyIQClRUM74KnJs3MVKh3qWJ9K2X+aPHfsoXIUezg+dc14DOwNsU
 rQgTdIYFx+S3gtEkhsxTqd+NmMHmua09Ls/HB6dMCx7a2n5LI6gjYqiC8mpeA+L80xkgDluNRup
 PjvDUC58yHtYb1My8iyauJWDu4+S2Ki649kgxSiRLevqKbIBAYu8VLllTNPm5kslkTLL+Vx4+rR
 wdL7II/r+UzwblKKBytTA==
X-Received: by 2002:a05:600c:4e46:b0:493:efcd:b809 with SMTP id
 5b1f17b1804b1-49401d2d054mr42817155e9.6.1783956770905; 
 Mon, 13 Jul 2026 08:32:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/26] arm/virt: fix smmuv3_devices leak
Date: Mon, 13 Jul 2026 16:32:24 +0100
Message-ID: <20260713153233.3391818-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fixes: 92e340997f861 ("hw/arm/virt: Use stored SMMUv3 device list for IORT build")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20260709111225.1106856-1-marcandre.lureau@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6a3c69ba8f9..219597cabd0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4417,6 +4417,7 @@ static void virt_instance_finalize(Object *obj)
     }
     g_free(vms->oem_id);
     g_free(vms->oem_table_id);
+    g_ptr_array_free(vms->smmuv3_devices, TRUE);
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.43.0


