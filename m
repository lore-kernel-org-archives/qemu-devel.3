Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295DFE7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdux-00045L-Q0; Fri, 06 Dec 2024 14:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdut-00043c-7t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdur-0003Sd-Ls
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:06 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-215bebfba73so23964605ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512984; x=1734117784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxns1y/BgfBe5xDZQgTR43Ph44Qsk4ANUhvirqhaS04=;
 b=Po43CQ9y9TvKYtBXy7j06YOJ557WSsDxBAf7Dh0dmclwy7wi9KF+4uJ2wiQHZP9kRg
 S8VnJWRuXAODc1JlTsTEcL7jtoBPADqXOFihZ4v1nTq+n+DoFj4R3u234Alyzfr+FO5i
 c61QDubjoYYAS55F/pF/0Ybvr1+GecPU2IeVHqVe+JM1Z0TM1RzN/2ZzYWZBHFWto0hl
 +zevZfLDOglediT19qNsd3K0wCjR7yVWe+tOeUWmJkMmZr54gVDOLmv1m2DycMa77mY6
 OBhzAxXZJX8O3dLiPlLiVAA9I3rht18odMtSLIkQKFTn+a05xI4RujFrQLMWgW0D2auI
 GT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512984; x=1734117784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxns1y/BgfBe5xDZQgTR43Ph44Qsk4ANUhvirqhaS04=;
 b=Vw/FJ63hK4yTHM2NHi2uykg77EqdnfKe2thUV8ZPcfVD+XCk76A48Ymh/Lpo2w4Urp
 6NnQlIJ/IcS9gVH7/ZSwQYaYaWZvcHOU2U0F++tZIiGHTxYx+GHDxoMvGTs2X94FE1Vc
 /Z5/y69TZRyYTWNLDO9IeLIRLTpcuHqRHPi0BWoKhIORKt5QCM2zp9eSm92MWNUFCBrI
 xUsNz9uw1LffAxmbUGmcSk3rmzvLHK+NpnH0OLxfjW9El3iVq3bZe2H1jzJuMXzJMsRm
 N0ym6WSNr4W3IZ7kSeNXjOwgdvo1myZ7lYQ+3nfhturR1vgUGaGYYv7rb5sFvtJbrv5k
 /EZQ==
X-Gm-Message-State: AOJu0Yw+y8bE+qCC5r4q0MPEdh0kU/B6saK/J5jsNkuWx3H8QgA4Zwdi
 Iz5wwDtv3HhdsNZkww5HnCqz18VRoiDdWx8m2Jp2SHUQN1SCVcvUc6/3hMlNf7ZkweogxuK2XtA
 nOpU=
X-Gm-Gg: ASbGncv7V//Nmi/PMuX0hI6laT0r2CzxDwXYfDrytBGPZBnYm/TA5BtkyqN0yV+q2P2
 ML3Sb1dtFoGuCqn2YvOJWpTNGfDMM8CM9WwGM+I4W0tpndg8Qb7jV3rHhOTY1UV0JSU7ZxvBSb7
 rrDn3vbXjuX7IbklA1b8GVxmAHnppV9UeqFnbPv1zbt3IUrZtJsbKqZ1o5lWY3lwUfRGNmFNxpl
 3HJNT1Pd89U9CW4htVRya8Edm5AFJrw/AXTZZRjvXixFam0z7k8H+YZ1jsLd6lc0r84QIAPgQ/t
 yNV0uuPc
X-Google-Smtp-Source: AGHT+IHJJleob/BsE5gI3Z60RdIXKdHyBEatFui1XI7rrGuhPou8p8Q+uVqGP1BSTB4j3o+NzzINZA==
X-Received: by 2002:a17:903:8cc:b0:216:2259:a4bd with SMTP id
 d9443c01a7336-2162259a5cbmr30092825ad.52.1733512984240; 
 Fri, 06 Dec 2024 11:23:04 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2161e5a6f23sm11720395ad.266.2024.12.06.11.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:23:03 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 2/4] docs/system/arm/fby35: document execute-in-place
 property
Date: Fri,  6 Dec 2024 11:22:52 -0800
Message-Id: <20241206192254.3889131-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
References: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/fby35.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
index bf6da6baa2a..e19274e75c8 100644
--- a/docs/system/arm/fby35.rst
+++ b/docs/system/arm/fby35.rst
@@ -45,3 +45,8 @@ process starts.
     $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
     $ screen /dev/tty1
     $ (qemu) c		   # Start the boot process once screen is setup.
+
+This machine model supports emulation of the boot from the CE0 flash device by
+setting option ``execute-in-place``. When using this option, the CPU fetches
+instructions to execute by reading CE0 and not from a preloaded ROM
+initialized at machine init time. As a result, execution will be slower.
-- 
2.39.5


