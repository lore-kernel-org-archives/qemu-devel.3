Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A9AC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetfz-0007Li-ML; Thu, 24 Jul 2025 06:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfw-0007GY-4o
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfu-0007xp-Hv
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:47 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ae401ebcbc4so140149966b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354785; x=1753959585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iTbOkoML9iQCshUrP18Abi3U+8iyM74A5UM1y7IVCA=;
 b=uY4ILHzJttxc+T5bEmRlz8RPwXK2sUC5RMzDUz1LqMQ5EDX1mf2ba/CFmgAMI0qPoW
 fnd4874oIkZuuIPWQwWLNDIOQq4fzkMYTDHpwmB/Ca0375ZeJa3KQXTM5+HefMzAO9xd
 iaX77K5QIuo0k50DEUFx5KMowpdMOXvvKTXKtNNcPl1dfd0ZayDiQYP7fBbmQMBFvepG
 apwJwSPkhk4MvsLS49JSq2N5f594VHnG70KqVLfroc2QhSVWkJraiW8ZHf/5Z73tKTgg
 FBVJFQw9S1GyHzgS/rrpM/l2mH5AAA12LBWCKGPStZhR+dEm5lOS3dOjU8jui6qZb3fJ
 7owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354785; x=1753959585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iTbOkoML9iQCshUrP18Abi3U+8iyM74A5UM1y7IVCA=;
 b=nEnsVvRTKnVwFP5Pi+Tcb3/OZ41Jd9cNqz6sMPVYhrdwmURYeQbdIPWfmstUucEcCl
 TF6e+0KOTx2+9DFebBm5m/3BEvTM6dC4U4r2NCYlFCxYrQfahhiCkp+pIZIivyyA/EUH
 0Ma8akUR1QVsu2BsLWIGu7JvprsrElbciFOG6Sb3adr8oWN76Ht80+abjaUl+4kfi4KI
 qno8fC6hhhaMmmlThR6Adf7RVrgb4BIweZFpkLwpsQzHY3CbQ+ZypXskgDqXmr1Argwl
 +M+u9ypL5x3NFcXcaWK50DjcUKyHbGeiah8s43+170CZLJgj8ZeNYJNuMj8LeROayD/G
 BiNw==
X-Gm-Message-State: AOJu0YwUXZJvC6XwV/Gxvw5xkv1s1bZXP88/W9u9Ns+SZXBlYeHBm3Nd
 G4+/m2aTpnzdba3tul4+ZyzRum6AupPBcp2Mjob6fItp0IgvvK/51BtWAPqpJzvRmYg=
X-Gm-Gg: ASbGncsz4jQhUWcs992wD5U1HYyuit00r0UUcDYthq+hT1e6FfO8da0rflBnmtfCAO2
 ISlNcYn5yFnzu/vRXAHur0UCLALxF0U1HTsm6OuWN6jwt8eUhuShp8a5+jzSzfG/5omNJosIDls
 vZNoFQ6kGQe/bh9amezw1DuO+ZWuGWe+mIxz/RCzrtEwHuqQsbQebUbZdulyzHguSieSdFcj8eB
 +DDX2IZFiRAVQGi2M+WJTk/uQtO/qaFE/K5TFT1dZdMMoy/3Rg9mZrQfXnMZZl0FG6XhTVJHZ2D
 HE1aJFB9ciV/MkcgwB8U01Qon/mi4ymqsH786F/W3kWGi9umW0y7DtzPp3yspYxloVstDygD1A/
 1rnroKS7sZ0m4jzf2Lwephac=
X-Google-Smtp-Source: AGHT+IEndWxu5GGgdiiwOXzIzp6BmevD9l+niY3p+ASoR9rLtOsy6dM4DelBCD6y6XB1HqNjHq1VyA==
X-Received: by 2002:a17:907:738a:b0:aed:745:a139 with SMTP id
 a640c23a62f3a-af2f88628b2mr470457866b.33.1753354784744; 
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47f44dba8sm93964766b.71.2025.07.24.03.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4AB535F8B5;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 04/13] docs/user: slightly reword section on system
 calls
Date: Thu, 24 Jul 2025 11:59:30 +0100
Message-ID: <20250724105939.2393230-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Expand the description slightly and quote ioctl(). I did ponder
mentioning something about why DRM ioctls are often missing but I see
we have the I915 ones so I guess its just no one has done them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/user/main.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/user/main.rst b/docs/user/main.rst
index b8ff203c212..05de904225c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -20,10 +20,14 @@ QEMU user space emulation has the following notable features:
 System call translation
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-QEMU includes a generic system call translator. This means that the
-parameters of the system calls can be converted to fix endianness
-and 32/64-bit mismatches between hosts and targets. IOCTLs can be
-converted too.
+System calls are the principle interface between user-space and the
+kernel. Generally the same system calls exist on all versions of the
+kernel so QEMU includes a generic system call translator. The
+translator takes care of adjusting endianess, 32/64 bit parameter size
+and then calling the equivalent host system call.
+
+QEMU can also adjust device specific ``ioctl()`` calls in a similar
+fashion.
 
 POSIX signal handling
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.47.2


