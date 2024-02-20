Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1FBC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLAA-0004tm-Uf; Tue, 20 Feb 2024 03:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLA5-0004k5-6W
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLA2-0000Vi-MT
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lH54QBenIkKz2SFD32IDe+ZcrIDsRVoxMKqUbplF1dY=;
 b=VZLpyVAJf7Rz3EUTqOGBdrZETtb//LD/S2RD/QKLZ3jwmSr6vbin17J6OS+aqA9FMOwiAK
 V+x96Wiq3pCcafbEsg1hBWyHcpJkL9g11mOvZZyoCTH+hm5IVuo2pfVi7+j7ggDD/wFLoT
 dD1CKMhsJqiJdBG4HNq7qR0+K7amTVc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-1A9-aKY4OgW0MHofkDgoHg-1; Tue, 20 Feb 2024 03:07:28 -0500
X-MC-Unique: 1A9-aKY4OgW0MHofkDgoHg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2f71c83b7eso433140966b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416446; x=1709021246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lH54QBenIkKz2SFD32IDe+ZcrIDsRVoxMKqUbplF1dY=;
 b=aafNGaVHAPLXPq3NTxqpNh35FF637jDWwY6m2emSky+Cqn83B15GHnVFJiykP3xZMH
 FL7c7dQoxsVl2OjIM4KGE1G+BL0QlXGESFbz/8j9c36E+PIEIKNiPJ0bxQAUR/zILmXt
 Un2zRn7nN3M9UYYmer5z3WoxK8IAKmJYdwF9ipJW3kGFrfOanq5VrtYHaed16lMm1yBD
 e3w3BHipuYPApiAsMV4rLnjrYcuyrxbfunHn5HHmljOakLkXD9h0qxZbunJZrF0tiBfl
 Odh+c5KGGNZekiepimRgg/Kazv+0BZ+2KIP1+G2HCt+HXjFGwt2SZGmyXLNttc0GYlnI
 0PJg==
X-Gm-Message-State: AOJu0YxtmBeI2cuO+noIoSy9NnbIMHkCx9YThj9Wivfulb0LqQfbpno1
 wRAXKsGU7i7hnVGnqwUdDN/ahmPRSwalGNH3/ScS3ym/ZYWt/XV6oNmfjKwR4rX36U14dh91kRe
 oJQshFNsAqeY6ZpvXN3h/G4GPndryuu3ruXqtvz2A4F1ajCYEPVi/O8txj3dBUrVOJjuAjtSM4m
 9b+ZD+ZTalrVhy8UqpTI4YI5VH7QtJhU5MUV64
X-Received: by 2002:a17:906:2a90:b0:a3e:1ab9:b6a1 with SMTP id
 l16-20020a1709062a9000b00a3e1ab9b6a1mr4653227eje.21.1708416446473; 
 Tue, 20 Feb 2024 00:07:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbPw3FRx0k4nx/xLvqu9ORI17smIoYM0SdzGQgHXGAg2LiAxFbDjOh10jwv530fAQCYLD2FQ==
X-Received: by 2002:a17:906:2a90:b0:a3e:1ab9:b6a1 with SMTP id
 l16-20020a1709062a9000b00a3e1ab9b6a1mr4653212eje.21.1708416446137; 
 Tue, 20 Feb 2024 00:07:26 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 fj21-20020a1709069c9500b00a3e5adf11c7sm2596010ejc.157.2024.02.20.00.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:07:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/17] mips: remove unnecessary "select PTIMER"
Date: Tue, 20 Feb 2024 09:05:50 +0100
Message-ID: <20240220080558.365903-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There is no use of ptimer functions in mips_cps.c or any other related
code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 505381a0bba..ab61af209a0 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -50,7 +50,6 @@ config LOONGSON3V
 
 config MIPS_CPS
     bool
-    select PTIMER
     select MIPS_ITU
 
 config MIPS_BOSTON
-- 
2.43.0


