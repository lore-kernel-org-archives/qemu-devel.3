Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B38E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNybH-0001s0-AT; Wed, 18 Dec 2024 13:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNya2-0001B9-BR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:30 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNyZy-0007Uy-Bv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:28 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa67f31a858so1249098766b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734545714; x=1735150514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgbFUsQ4LmsnQTjxQWiCGeGbjUd9LSSKaKM5ICyfigY=;
 b=UjyIva9XScvdl7q79LKn/PUlbq9D16pI1nvHdhX0+h2WOJnPsLt6YjgmcwrnJdMGXB
 YFDI0pp4MjyT7bVtwV4EFkXo2b9Aaghz5UDNkOrWQ1htemxd+0LzsKaEDVCkuShLvkGc
 8jaNiuxjcRyyShpq2r/6hCmJSj/ijZbZwqq0DN9irLjQ27exab5Ya+3oLDW7rpweEEWe
 ETfRFJP50eLwlzvhZhV3/iBEv0vlgQ3u27p1Sk+DenKYXWjIQ3iTpSnZ9/nE8bduoe9O
 WgGvqeZ52B2nMNQYKxkujFxvLROtsMoCIRTkOUCCf65MeCAKFaGjBJR+h/FYPxHSBSR5
 NnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734545714; x=1735150514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgbFUsQ4LmsnQTjxQWiCGeGbjUd9LSSKaKM5ICyfigY=;
 b=P+qFghOrDwfEypZwKB+h5tLsyELE6GXUU5HNnV2Cc21Kkac3FiM12Pk9fkEAW784KC
 wStBUtjcOJOkDnjoM0HEjUMcIeiM5xZ5s7f/phBNXkH5jyz3OJpcGBgV/eXSLOr+AgyA
 OCnVUz4Z/lMWSeVjOQkeGwParnXCUJSOPs0QFwO4v8n53RSFz9b4qABxF3iqM6CEgoAM
 kGQqJEeyrgrbVwGFIBsZyuUz5HH6MRflsslUE5JqsUyIWTYp8KNEgE9HAXiZcrjXjJTf
 yJEjq6SZZJtVv39hZ2NyvY/Jj1XTHRVaa1UCG8ssMuejlB20rQuIehA/gpf3X8YfXrsy
 ZHAA==
X-Gm-Message-State: AOJu0YyLYC07PHSF2EfiytxgRodgt58NZhd6yQxiHSARc8WXafkm9iEq
 dR5/mU8iKQIEza1KCNqyxnvuBLDdC9O6bp6UIjnchjhuNbBDG0M0YdCeno5+ji7LuDuoJTpCVn2
 5oV0=
X-Gm-Gg: ASbGncsWzDQtc/Py+0c0I/yWbYtnds+w6yBRTq0NGaFY6/gL62hTRwMwR2P3FWQqjcC
 ytEhWOutl66BDM4R9742fFBeLMAEz0mcGmpo2NRS5jNNKuLLOj6baSy4g8lwsxzRxcoJ1gQBxfQ
 OHydbGHN/BrdYFwTlWJn6UCg6AokoVDy5BPliQcPoACXXXzaSUOG6NArKsan/+HcDAczGaDZp0x
 amUNvKzVybykoVk5S9hl1y7rObbV1OCwoXJ9LYsNg7ozj/VDPoSqHs=
X-Google-Smtp-Source: AGHT+IGlI3D037XhUxhdKceDV/mqTJVrlNN1aGxKmJ3y4eteF39E3EeesiGODWa8khyF92qV+qfM+w==
X-Received: by 2002:a17:906:31da:b0:aa6:691f:20a9 with SMTP id
 a640c23a62f3a-aac078bfe69mr39233966b.4.1734545713494; 
 Wed, 18 Dec 2024 10:15:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aabc71ef8fbsm338376766b.165.2024.12.18.10.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 10:15:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF6495FC8A;
 Wed, 18 Dec 2024 18:15:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 4/5] hw/arm: enable secure EL2 timers for virt machine
Date: Wed, 18 Dec 2024 18:15:10 +0000
Message-Id: <20241218181511.3575613-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218181511.3575613-1-alex.bennee@linaro.org>
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 hw/arm/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 333eaf67ea..5e3589dc6a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -873,6 +873,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_SEC_PEL2] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_SEC_VEL2] = ARCH_TIMER_S_EL2_VIRT_IRQ,
         };
 
         for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-- 
2.39.5


