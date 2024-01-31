Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145DCC4828C
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6Jb-0001wx-Ie; Wed, 31 Jan 2024 03:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JZ-0001vm-6e
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:25 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JV-0007t8-FO
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:24 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33ae3be1c37so351028f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691079; x=1707295879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bonA+4kiwsu4AWOnHikZYFkdI6euRG1YokhpseyRs04=;
 b=Nk/CKIeHXNyRdInAR8ZxYHywObY5qYKq5uGVE5t6pi1D6Yu4u3pjctM26z2I62+z3L
 6QyV2KtZgiSuxSqewS0EfFcoayxZhd5jKadDgQC6BmCUK7hMxBS+LPHqT2zds3yQuDck
 6+grvMYsf8efm7lvbTuP+kHIpzmvzVgc97PFtE6CJsEXkNsazc3uondU3mzswexIzMmk
 zKf5zPvJUb42wtv39pt7R5t5aMFW0MNy6/oxAW7xepH58Mil2lgIPCpYOEWEapkCgVQQ
 hZlyNWZhvf3BffgQ1+7Vf+0Q6W93+9rWjcTdTEFHfDLPhmmsl12/KfQ7gMO94k8Soj9r
 b53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691079; x=1707295879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bonA+4kiwsu4AWOnHikZYFkdI6euRG1YokhpseyRs04=;
 b=wddD7xd2d0S7M+ebJkRTqZ5+5lS6AQ6duL7RZMu4q2ftPOBhvmZYCJKpKcHSiZcuUo
 obzpcKG2GRA7uNaDqKs1sPqkkNhWvcEq+3miGuGrXpYVFeZ+GB3U+rNumGEmtpnIIBGX
 lxPdq5wF1YnjBtJLzDLVTnkNOcMrvby6ra8QfhHwjmFBiJ/GYEHIgzHQnOX/gDDG0YV1
 L8QbOMGtDY6+eYapPDNUbLgu59Oph/+tQHvm1hdwpW6yuvFmXzMLRUJN2vkdKKosJYzM
 ACuJc9VMj0kdZuQyoGVYXKSxxvf5wBp6WQz/cM0ioua3SZvMTpHbBKTS9ltkZpdhUpQx
 JDrA==
X-Gm-Message-State: AOJu0Yz7mwHCUyJbh6MhNkVeLuLWzeIKetneevwgeAEdI961GQXo7gai
 x5S9/2GoYQ1DuZqAi9jTQgm4dk+imBRCOVPoVbHNOVL5lo7QqCR7Pl2O7G88iZPNt2SbhBvg/Ho
 =
X-Google-Smtp-Source: AGHT+IG9cNTOS44vhO3E6vJRZ7xwteT4owK+z210QPbIeudp1wqoRiOXRARuJQxSOqJ5kJme1cbO2g==
X-Received: by 2002:a05:6000:2cc:b0:33a:e605:57c9 with SMTP id
 o12-20020a05600002cc00b0033ae60557c9mr3826463wry.27.1706691079584; 
 Wed, 31 Jan 2024 00:51:19 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVQ42+SGV2b9T9vNSQ7/i5B7E8ml87bAHgex7OAhm9tPrSrg249P2XaKcY0dDH2ZNYS267tg84EC9f6n+M+6ZdW24jB6g==
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:19 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>
Subject: [PATCH v3 9/9] MAINTAINERS: replace Fabien by myself as Leon3
 maintainer
Date: Wed, 31 Jan 2024 09:50:47 +0100
Message-Id: <20240131085047.18458-10-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

CC: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfaca8323e..f076c97fcb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1708,7 +1708,7 @@ F: hw/rtc/sun4v-rtc.c
 F: include/hw/rtc/sun4v-rtc.h
 
 Leon3
-M: Fabien Chouteau <chouteau@adacore.com>
+M: Clément Chigot <chigot@adacore.com>
 M: Frederic Konrad <konrad.frederic@yahoo.fr>
 S: Maintained
 F: hw/sparc/leon3.c
-- 
2.25.1


