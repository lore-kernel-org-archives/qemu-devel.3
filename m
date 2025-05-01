Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14EDC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb5o-000100-7r; Thu, 01 May 2025 17:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb5m-0000zF-2y
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:14 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb5k-0006Sa-J3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:13 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d6d162e516so11463135ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133511; x=1746738311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0h0T0XYnYLjPAQZ2YEHiTRTZsrkk7NXiD5Jirf7sOvY=;
 b=KX9wbSGoSQN4BGpuJ213MWBFl34bwzOH3kUgdSAcrw1E9QGFvHcmzlCtB/lpG70s5K
 wYDnfXiUE7VAgUyIe5/0FSPfpI05c4OtcoCrR0Ki+W2FYce5RSK2fMoqYcnJ+rp2bcOw
 tBLxoau9S0UXPu8VDsakAssn+4Tdalh7ZWc/p4E+Us+KZQTAPDIuu6qekwKJabTQ+Dyw
 XDtuxdTi4rjmGLuu5YolRXjL0ZfpmWy+ueJsFGrNoWLWbzAG1Zr6ncduN7mLgJOUf3oM
 gDnYwoGCbhKkkPgfJGq3I4iC/7TNXBL+oS6qf0OKiGGoCNao+xT7MIsyl7aQJokxBGfh
 jCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133511; x=1746738311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0h0T0XYnYLjPAQZ2YEHiTRTZsrkk7NXiD5Jirf7sOvY=;
 b=ocoUNVr+8FvZls/2uigQmO0srUd7VPDE7sCs+L+Q8h+hBQfRW0zTeMyohCiPPb5PZr
 bfzD7niZUhlst5reKDCNxF4bibUQinZCubDyVN6F6+y1xC8pnA8tD5wCFV+n0wjr2A4i
 ylp4Rezy2ukYmg617kfrGCOHH5FC1DJGQTMWVe9eJlIVFCmY8RlhvYnKEN1W22jtWslm
 sdyUTrk1/G7y9LDGfmsIB/fT+0/ZAFfQq6ATgxD9w7ykWHAIlWqsFkUuoY/D/MUCOlKv
 qyv21DgWMRiSr/uTGxIKIIuRxxiHcB3rLM0lzkoU5ib2c3g1lhDFlZ/1IZA6fcjGy2Vh
 WT8Q==
X-Gm-Message-State: AOJu0YytQkPYgUwUBQh72lrjSeq5eK9frlYJ3+rbCc8+jSAIZdVOZ6B+
 3QWmEjnURw4W/3vm52xbD72MONRw42WlWs+yMVSxeFpeYrJ4DZbKMahYkGF9NStzlUN20/T7rm4
 T
X-Gm-Gg: ASbGncvgpsSyxA/F0KPY2Wbr1rGNSre3Vl1gDukbFtyeA0hRN5oNc9tdfnlO4Z7Yv9c
 hoewS+Cq/CnaWMl1tCJ8vS3IM5knnYoX1xbe4/dPs+tLz6wW7bnkdLvp0gkN1XCGtGBFMxZ60G2
 B9vUHR00H6TK76TNmXhBXFX94BrxEj/kmSh5WRSn2zuhmbc0GVdGykWsyzUzkLxxk7m5PpV3z1w
 QHdekDVL0DCew15jdDcre+qPpldq2ko29O28sFlvB87GX/xWMjBSvsxW8UGV8sqSoMR6UozHHFw
 IIKdQINTywE79CCbCfNX2A5BQgJD6wfXOHHGqVzDdSRuL/UoYqbqc/c0zidT4kL4Ef9q5VCrpnG
 YxPkHVuXvpTLWPPU=
X-Google-Smtp-Source: AGHT+IFh8n9MmJbVyx45lC1+gqYeauh0qoc78UnBChyJAU9v7q3pAgI5kk7rjfAy1HE2rIzsP49xFQ==
X-Received: by 2002:a05:6e02:b46:b0:3d9:43fe:8e49 with SMTP id
 e9e14a558f8ab-3d97c1ade2bmr5797325ab.8.1746133510774; 
 Thu, 01 May 2025 14:05:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa5832bsm44463173.84.2025.05.01.14.05.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:05:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 01/18] hw/i386/pc: Remove deprecated pc-q35-2.8 and
 pc-i440fx-2.8 machines
Date: Thu,  1 May 2025 23:04:39 +0200
Message-ID: <20250501210456.89071-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 9 ---------
 hw/i386/pc_q35.c  | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 98bd8d0e67b..0d6ad9db627 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -746,15 +746,6 @@ static void pc_i440fx_machine_2_9_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 9);
 
-static void pc_i440fx_machine_2_8_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_9_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
-    compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 8);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a1f46cd8f03..54c18100122 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -639,12 +639,3 @@ static void pc_q35_machine_2_9_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 9);
-
-static void pc_q35_machine_2_8_options(MachineClass *m)
-{
-    pc_q35_machine_2_9_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
-    compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
-}
-
-DEFINE_Q35_MACHINE(2, 8);
-- 
2.47.1


