Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561461091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MkN-0000an-OI; Thu, 19 Mar 2026 19:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkM-0000XG-1G
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkK-0007av-Ej
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aaed195901so5237105ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962742; x=1774567542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1wYAQxZ7DlIgdL+YHHsLWfcTy3c3+OooLp3tGYj2ZQ=;
 b=fkDbfveLMuDdR/IsKhC/75uxjbYFOXKhp80zfo+40Afnx3mjRrv0vdJTv2kzSmrkJc
 oQJM2epxmBH6eEwIMUNf5CVCDWQO4QcPAOUU26lHDoRE35+r0QLLE7Kr9AUcCom5s5Cs
 6gmGvI7ZSKzpZ3Kohxzwwsj68cIuZX9q0amY6MO8vbv7S+LQOWazm05BANk7dYtDhcAZ
 88YNFvePL+dKguP4p5uWHlwY3dioOMp6eww6NjwYcS8MKKqhqehCXuUAC5UQ+7CfibFm
 tfZMZxY01uJgSYWVYgNtZKx9QjocIuk45eIx9XZ90bIf0wWLhxof256V0oFH0nRhy38/
 PqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962742; x=1774567542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V1wYAQxZ7DlIgdL+YHHsLWfcTy3c3+OooLp3tGYj2ZQ=;
 b=N+fGMZoTEzEmVs00n59oj67cbWRxzLFSUWwdkmuQ6R7oFKmNOFZpd1/CLVen3R+g4u
 06O1GmK1T6y1ayQV+Kg/1OMzpiJ6wH1okDrkkf3HkBdwacIqvrfyyzep8ybB++knwgrj
 mIFvP/68dZ4CQVumIoFoIKG5wCu9hx+FGMuDZp++8fipLL/5/vxeMm5neFzhRnqS1SDs
 J67KSfXr8AEzUWn6MveQIAVG1zE3I8RVdoBm4PAh50N9QTBduzSjBGaIBiAdcBfaOFoS
 vtepDobYFl5NRLhBHX79FrRCcEC42fOnch7nEkswURlebYnj7Ua6fDmmrSyJZlgGZrci
 Jc3g==
X-Gm-Message-State: AOJu0YxdlrKk4Pka98vI8Urm9C7ZzFtXqMj7vQb39vY16XWTjxV/UrjA
 zx9sFVwxp2/D4+7q3Ey/+VMEmKTaTwZx7BDj4KDUFfsURw/m5amAJEXVFTaotQ==
X-Gm-Gg: ATEYQzxh0ClwPxZ3IT3tZ4zlhOovpKrrLFVQuV/8oTvLWCCpa8jfbiZHhdpjv1JcgaL
 JeZ9AYLLVXZw5r95qXDLk4wm/wSSnSJpvVwPnkniBeJMxFtKWiB2LjS7S7NhraDLGoK17XA/ORC
 60bzv4qD83YyOXSgVqeVpDRcL7RmH1W0BPiif+HbCWFjzYyKQb29rXih/oeMZ2SWdohYyxp609o
 VTzd4F79ksDtYYOqqonLcCgucW2B4rdgm2giVsXr4ifKceiv01us0UVVMwKsIhYJfUSOhNwc868
 zAPde4dbwO7iH9mcqyyw+hpeajy+PAHDZ7KpGKd6dVF5bv99gaDM8FrYMM4MNOtTzhiI3lYTs3x
 V0fCwzOjic4A3wh76V8sYhE+lq5X04f8GicT+SrHzo0CwP6Cvh2nxB+ClSwqQK7CWmkHwxZ59uE
 DHI9wmz/oUNRN3pfjYi2InA9ftri7yqcaAUMsqz2YfIQ==
X-Received: by 2002:a17:903:38c7:b0:2ae:4a4e:1e25 with SMTP id
 d9443c01a7336-2b0827826aamr8716685ad.25.1773962742317; 
 Thu, 19 Mar 2026 16:25:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:25:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/17] target/riscv: Fix null pointer dereference in
 cpu_set_exception_base
Date: Fri, 20 Mar 2026 09:25:07 +1000
Message-ID: <20260319232522.1867400-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add missing return statement after logging the error when cs is NULL.
Without this, the function continues to dereference the null pointer.

Resolves: Coverity CID 1644077

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260115130110.2825796-3-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..9be79622f4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -83,6 +83,7 @@ void cpu_set_exception_base(int vp_index, target_ulong address)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "cpu_set_exception_base: invalid vp_index: %u",
                       vp_index);
+        return;
     }
     cpu = RISCV_CPU(cs);
     cpu->env.resetvec = address;
-- 
2.53.0


