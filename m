Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA285C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJYa-0007ra-IM; Tue, 06 May 2025 10:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVH-0001iT-6c
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVE-00028X-I8
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so35758345e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542555; x=1747147355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K63s5sr9Xlf+KqacLl70oGl/JdebL8vSGbHbp6f9PWc=;
 b=bUMACFPrPutxKovkIOgEol3VHvxgWA5Ts1YOpsfXtNwmOweSv7D0JtKfwYhc97mxnE
 9YXrmm+aW/3Gv0lIG1i6l+27wiE4Wzay1+2Y+l1jrrCAVi4hOfW1Smb/FLDY4Ym7pQSQ
 ah+sH/REB1cDdHgq+CyOWc/GIaobgJBNenxJJs//On/n+mHjn72CQofzidAoAFm25ImV
 0fqFG/wOWPMyfrmnCeivmVd/nL7KENmnUBTETDxyK98QuL4TKGQ+pugjDZbnwFtWgUGY
 iqmIsB3/7olBDH2PHGRfwkfPNgSsZVhEejgZvxm2xIxo6+VwUhOR77U0aS2d4sTvLUMx
 uB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542555; x=1747147355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K63s5sr9Xlf+KqacLl70oGl/JdebL8vSGbHbp6f9PWc=;
 b=cBba/7t9ziy3Ohs9m2RdqaBylKQFtbIK0KWaBBu3BwQ+N1gppn1MzE6hGqGhACKPC+
 nfSAwFb4aY9qISOaGqK3MSTbEs7t6a0DdOCzM9lwpQ4ovABJaaJdcW4H227C8eLEXi/g
 r5BgRBKryZ5aXBIoHNa9qarDX5aNtcZ5zubjd0JnpXODkDM33WE7Ojhsx7jeF0MwpFMr
 8IDCKGWF974NTeXr8mvhoLgYI7c66/Q5Ei9bmAS/c8xkMXy7w0YETfvwgmUX34XJIdf0
 9l+nV8zbBENZ2IcU3rNK/7Nb0yIbsnmxqqV1cB8vrMY7cD4gX51VeYKia8EbdqCF/4N0
 UoMA==
X-Gm-Message-State: AOJu0YzZEiWOXPJ+Cq5F6uXkgyVDuFVB2kVierFhr3DkH+SqUGbH3cTy
 9eAN0bZUUj9gIzUM2yadFHLkN1TIGc3TU5gcoQ1ASattuVlOSLTmhRitmurmtmPuvAazYUB3/+e
 t
X-Gm-Gg: ASbGncu/Zea2qNgTRM2hBHYX2LKuth2b+CzGQreLgTH10YySjEo17Gs+lYrxrwXZ7o3
 LT3tDYcWPkhSQfCo+wqbw/Vtdtyq49HEjLLuNxfdegeCrItlje6+jjGBSOANxa8B6GhR1kyztXr
 ods5VBejstFoA9hY5sJ8M8dDmHCxdQogl+5bXThq7hko4tP4Nu6Ul+QkcdXFqDShNbSssdFFIRP
 D6o3BH/B8be+MpVphvDN65Iu7LrKz6ytqb/Kr0TtzZbeh3zloA+A0LRcVWAO8POPafYmuWOm0OI
 d4vEbeUOzbIx09A97wrzpwOeUreqPOQwUMoZ8wnO1T5j2N4=
X-Google-Smtp-Source: AGHT+IEuK6ifTfoI023ip3BuKYH8xZmfzMjyjwF09Kl6ENn2cY0krr4+wZ8x7q4KQ9v2XoxdDPjOAQ==
X-Received: by 2002:a05:600c:3b90:b0:43d:1bf6:15e1 with SMTP id
 5b1f17b1804b1-441d3a375d9mr389935e9.1.1746542554982; 
 Tue, 06 May 2025 07:42:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] hw/arm/virt: Remove deprecated virt-2.10 machine
Date: Tue,  6 May 2025 15:41:58 +0100
Message-ID: <20250506144214.1221450-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1c84297fab9..6e10b2b0857 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3611,12 +3611,3 @@ static void virt_machine_2_11_options(MachineClass *mc)
     vmc->smbios_old_sys_ver = true;
 }
 DEFINE_VIRT_MACHINE(2, 11)
-
-static void virt_machine_2_10_options(MachineClass *mc)
-{
-    virt_machine_2_11_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
-    /* before 2.11 we never faulted accesses to bad addresses */
-    mc->ignore_memory_transaction_failures = true;
-}
-DEFINE_VIRT_MACHINE(2, 10)
-- 
2.43.0


