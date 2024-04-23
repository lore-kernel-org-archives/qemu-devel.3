Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73520C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG1H-0005HV-9f; Tue, 23 Apr 2024 09:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG19-0005GX-Mu
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG18-000258-Ai
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8mqVLQ2NnAwYo1RcVt5KZzT8AO89zylqrz/dENTQxk=;
 b=iMQnk7ntb5DBxWfqfpbspKKtZf9ldyft5/OM+WPMa8CVjRz4Q/D2r+qWcMiF7k5M6m6nGA
 trL8oTOvcH3hhxF1fo9Kb99D5nI2Fj0wZTye0p4N1qiTmzvu1m+0Sj5UDArLzc/rm6JAvE
 GNf21ND2FPMliV7V6DON67KZSYTYErg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-J9_la2JxPLSaxQ7gfaMU5g-1; Tue, 23 Apr 2024 09:17:00 -0400
X-MC-Unique: J9_la2JxPLSaxQ7gfaMU5g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a51c76700adso550696966b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878218; x=1714483018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8mqVLQ2NnAwYo1RcVt5KZzT8AO89zylqrz/dENTQxk=;
 b=DlTiXhkGUXJXf627HVD32PS9YG9HOaFdYDS7ocxLTAusofbL8A5RVLzxflNLEqAAWe
 4EUzU7yuCr6wFXimmuxbXWP8Rqj6dqyHPGLBjG8DGuW7yUe9YGYfMxcl6E05CU2G4iCY
 y7WVtozRyvqisVo1TbvgudMq2nhtsseipLL3IuyqEu7KvYvDzZ1f4wlgumgQbJzdpJoN
 jbPUzuWT8kvLsQsLFFwXlIAl4CXuxKlxTgvObAGW/qQbvTnCRlGRAsLnTtPv60hPeCuB
 vYjXoc5UVvhyPOGyT1XAnWTdWDnERLyLThsjWN3cTQcAbWXtlWhQF/i9xHM9T+VG+3L6
 isLQ==
X-Gm-Message-State: AOJu0YyY7QLOD5eSrt162UEijlvsoUWBUfezMykmHoTvFQWNR7Lk2lcF
 DbjDxnhDzpzH7Uz751JasBshsgyqE61OKEt6JL8kUNqcuzFAEYfKBN6xWE0PjJS3slKlPQX0+Xk
 3aT13piSsENy72UZ8AyTpFS1leUUpHchwOrw7amzBkNj1DRrG44XjqT3EL7H37rhwRdK5UC2elP
 7OdprGCY9klo0YzF3ekFlUiNh7J+EDnt/8ynyG
X-Received: by 2002:a17:906:2e98:b0:a52:182b:dee9 with SMTP id
 o24-20020a1709062e9800b00a52182bdee9mr2495101eji.35.1713878218212; 
 Tue, 23 Apr 2024 06:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF08Xu87nzZKflWOURB/KMsuWynZFoS1Xu9sQI0XodjvV2CPXdgJfhI7rmnPfWIHMHO0E3ApA==
X-Received: by 2002:a17:906:2e98:b0:a52:182b:dee9 with SMTP id
 o24-20020a1709062e9800b00a52182bdee9mr2495074eji.35.1713878217854; 
 Tue, 23 Apr 2024 06:16:57 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a170906504e00b00a558014ab2csm6046134ejk.145.2024.04.23.06.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 17/22] rx: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:16:07 +0200
Message-ID: <20240423131612.28362-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with RX.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/rx-softmmu/default.mak | 3 ++-
 hw/rx/Kconfig                          | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index df2b4e4f426..e7caebe1974 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -1,3 +1,4 @@
 # Default configuration for rx-softmmu
 
-CONFIG_RX_GDBSIM=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_RX_GDBSIM=n
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index 2b297c5a6a6..b2fa2b7eec3 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -7,4 +7,6 @@ config RX62N_MCU
 
 config RX_GDBSIM
     bool
+    default y
+    depends on RX
     select RX62N_MCU
-- 
2.44.0


