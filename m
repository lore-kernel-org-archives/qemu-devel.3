Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC3606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GXogUFrR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMjVp-0002Nt-TH; Fri, 30 Oct 2026 06:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMjVo-0002Nj-G8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:07:04 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMjVm-0003wq-U3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:07:04 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so339575766b.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793354821; x=1793959621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=66LYN8fy2rxPpp1Ww3IHdkHkpUQE+Q/ltH4ImMP7pYo=;
 b=GXogUFrRWTMXv9U9xQZVuehArnceSw6KIrQZiJKOvvGj8c/sgaBkt0ruXr3ROscAoY
 LZle02EYo9PM0JUlEP7lsXDeN6jCdA9lbVdW3v8Z2NqJ5oiUh19Zk7DqWkK8LfkLSxvo
 zgYtnVjEv12PRQypP4iOqWx8CBsbYP0lP3gYbjlhYTlcLo/NYGNNiL+HKPC/Dc21Fr/U
 hVnTDdN/i+WfkRd/cBCVVjVnCfQg+TSTbkxNUWf2w6eeMGLAMMQR9mRkkqrM1TZDA8x0
 GZZJScRYZRDxol7VTG+8DiIhq7+gEqHGNgD5l6IAEW0QHnd4XOBIWlfsnIO1N65HAUHS
 7TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793354821; x=1793959621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=66LYN8fy2rxPpp1Ww3IHdkHkpUQE+Q/ltH4ImMP7pYo=;
 b=cx0R2HG0ZzNOsT2Hc1hCOdVQb9TvkcnIdTisiAy/f+QqKqteKP3p+C1eAyGol/4Uqg
 7MfBeZeqcSd4DGVjB6v6tO9y5a7lU0Tourk8T96o0CKd80kJqMDG8Fmkq9KvjpBPWcJd
 XIhSr48g2XKdoMLzIzgS3ul1LdwbxtP3HVii1TvWLAzW3A3nK9yCr+MtDwuBohnvMSdV
 pVmd8IuzIUw0QyfYMG4u2f8WrC/QyJmOfed1QpZctCge0Zz1if0s0M+w2I8yMcn+Rsry
 Adg8iYkEqg2TM74t4jfvQoj4BiMGGIQDtlfZVsWV+GLiYdm5t3KfpybKaYXSRZYrBWXx
 g6Ng==
X-Gm-Message-State: AFq9FYKsEGj60eBrCv0+64Y4Cuba3pmQ6wU5lxEx0jKmzAuho8Y7YmyG
 ZbXbo8tRcJf6hnQtWiAAU7U3OwJbhIMHfc8YiB8VnkSXKnnuEj70a+YaULZjt1kOo3KA2FOHcXD
 qFyIS4ds=
X-Gm-Gg: AYBFou0RjBMQmbrP/DSIbmWErzhC57dVIaC33hhoYbRW7ehZ6ev9o4u1NBj6QsSv9vP
 +0ljB13WITDgQCQljsixKr+PXSkOhWaGSvx5UKxA05ca7E8UJBCKsIQGz/Du7VwUfOF0WteBZq0
 eX/0Jl+TKSrgrRve41EznG3TLKvLnwSfy8/aRv7s9WGWfuFVTE2z5Y7dhbt3nJNDgE2zWYSjX5M
 DZz7ov1ni7NeVLA5/heBKGjqJ0vBDZxjvMQlKd1ZN5P8/5nuqA2gDgu9iILlGkGOlrV9lj0gHwk
 2Tpf4nMt822HJRrcwk/o91Rb29ShWqhVUVRSIol0TLyhe+NM/Xo7RD+9amk2kvj97J1A4tl0IxU
 rdx+kb8z4dMvDQlW9eug+qRVqEcX8sreK/YYKYPeZ0QkRiBkGA5kxVok4PgxI1cNVZHYfo+ynkL
 ShS0+Idh4DPh52dmLpOtdGKEGfYeT4MtrftPr0h04GwRw9yIFcs3ygeIFt+/60BtxL2o4ajEdVr
 F71D36sm5e3Z3knvZhxTqLdX15VgtFzyzTaoq6fITGZ5qV7yT4OcpnqcrauOg1fWRpKXouK/vsB
 hSxRKo0GXctAVIuEtuzP9uerd3PFO9d7tuZRCDTUYoiHaPhR0NMcBuhH2KyzwxK77gvJm5fheio
 hRAUJpdIo4GbidhRGcMLlhLwL6d2c7oABqQ==
X-Received: by 2002:a17:907:869f:b0:c41:825d:ed8c with SMTP id
 a640c23a62f3a-c49d147e127mr454673666b.26.1793354821137; 
 Fri, 30 Oct 2026 03:07:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae0f4sm2068789f8f.58.2026.10.30.03.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 03:07:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] hw/m68k/next-cube: Show deprecation notice to users
Date: Fri, 30 Oct 2026 10:06:59 +0000
Message-ID: <20261030100659.781819-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In commit 5d3333e12a034 we deprecated the next-cube machine, but
forgot to set its MachineClass::deprecation_reason. Add that, so
that anybody running the machine is shown the warning that it's
now deprecated.

Fixes: 5d3333e12a034 ("docs/about: Deprecate the 'next-cube' m68k machine")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/m68k/next-cube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d8cb4a8c23d..0d927c7b485 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1370,6 +1370,7 @@ static void next_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
     mc->no_cdrom = true;
+    mc->deprecation_reason = "machine is incomplete and cannot boot a kernel";
 }
 
 static const TypeInfo next_typeinfo = {
-- 
2.43.0


