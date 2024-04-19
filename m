Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14A7C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqh6-0004uB-UJ; Fri, 19 Apr 2024 12:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqen-0001He-En
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqef-0001Bn-Jp
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f90so12800835e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542400; x=1714147200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkRIZYSXM60C11pVAmU0c6gDc0GU3jgcOc8qxUScJ1Y=;
 b=HXm0WKxJZuapCTyseNNu6b/ahE7eAiH7GdiHTSJF/2GE4xjaXSLBdOdJGo63ETPPub
 Y65256jbNksuCQ0ZJ9bfzTz+/8Azys6k30yWo8jVB1ktL9swCn09SdWII1L5TWqdahb2
 R6GXSlK9u2ebQ5WuisTS0ePM98jUvjzVs5Q2IOM9a20YpRR7TdSpfsdfabZNzTNsEk6z
 7gpL7R1FvyKE8CmuamlEZRAdKCgHh3IqI/aOqECYSU4NTi6lFeaeSYX1+53MyngClI1D
 qLHYUCvLePFHcURsYfe3fFbARkYAlwqX6Z6A9V47ITVqs86klM7pdveNT6L4RLqdr3h4
 g8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542400; x=1714147200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkRIZYSXM60C11pVAmU0c6gDc0GU3jgcOc8qxUScJ1Y=;
 b=RKHsHLObMxT0Ib/yVmuJUmkx2cp6JdmShcgLpY+SbyFVK9ift3PgyNTR08GGJuSJaW
 q83B5Sh21yKbCaC/YhAQBWYp1dX5PeJx8Irs+zkR4y5VESLINfU8fqu7GyuUclCT/n6F
 JptFSWk09cA6dp4DnRk6jolzQi+oVa9y+dnist2fBvGvpM011Gci5h74YVSEEq+ri4Ip
 mmM+GR5lTcvFThDgjUUOcVwc7dAp92c7KjXIwlNQ69TVPwI7jIF3XgDXI2rnwaPaKNa5
 TvFs2qC3M2pcL6QFZJ/n0Qz6iL2LNfD1dPW9Hi5QQD8NlzO/HJSfsw90OIsWGOhUXE4u
 dBOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs+/k+0zQyeOUZN+2JwobCimt5Ft2Tn1pbcgx1m99ZkKgRsdF19mcjcZKK3xpW8CrMe6E3VMwhsWXSnt9f/Fv+fo4Hir0=
X-Gm-Message-State: AOJu0Yzm9cQSZ4W6FbddNRKCO08j1ybul2wC5+66ifWRLAEJ19P46HJi
 Q3ce1ziDEICtX2Q8Stt6FH9dM+OX20CQnCPSsHNne/TQq/fhdw7Nt2g+MU8Q2Bg=
X-Google-Smtp-Source: AGHT+IHAbdi0c326+6wQmTCOWDDeEMqnDrJNMO++dLbiFMIKRETjm2YK89aW5Ik3rFD1vYXenRdRYw==
X-Received: by 2002:a05:600c:4c17:b0:418:f6e7:3599 with SMTP id
 d23-20020a05600c4c1700b00418f6e73599mr3254144wmp.3.1713542399993; 
 Fri, 19 Apr 2024 08:59:59 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:59 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 20/22] target/arm/kvm-rme: Enable guest memfd
Date: Fri, 19 Apr 2024 16:57:08 +0100
Message-ID: <20240419155709.318866-22-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
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

Request that RAM block uses the KVM guest memfd call to allocate guest
memory. With RME, guest memory is not accessible by the host, and using
guest memfd ensures that the host kernel is aware of this and doesn't
attempt to access guest pages.

Done in a separate patch because ms->require_guest_memfd is not yet
merged.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: new
---
 target/arm/kvm-rme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 8f39e54aaa..71cc1d4147 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -263,6 +263,7 @@ int kvm_arm_rme_init(MachineState *ms)
     rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
     rom_add_load_notifier(&rme_guest->rom_load_notifier);
 
+    ms->require_guest_memfd = true;
     cgs->ready = true;
     return 0;
 }
-- 
2.44.0


