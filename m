Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8B4FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcnK-000441-89; Wed, 06 May 2026 10:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnD-0003rH-EF
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnB-0000Gi-OR
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso68550915e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075999; x=1778680799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SQwTsh+iAyv/zCSx0/p3+pxdOCF3BHdT8oB8gjVmgyk=;
 b=NKTvDZvordaf1wv2rvfhplIh85/edhFtfuf3Qr0uroFoy5quda8iOm2Q5SDqyk7ROz
 xifqjvarjeTDmSlx2V8U7JmiUvtFuBWvXeyqVI8OXi3GqyB0pn5xoc/6dbRPuMKVTDag
 U7o2B4L/880Bc7g1tjgAEtwJ8+WFSpXOc97dPuwEjjfBfLThcK0zC4gCGnbRJxCLE+1t
 Bk+4MpoFXE/h4leJK7oxB9RDr2OItFLzMOEAdtmZhpgAy4hwckPTHocNtqB2LXJm1yN0
 pe59KW2LNwdUr2khaIey8hqXZtSXvWm/S3ttajp0mcu4vmItCvEEbxBo+dEQqIa80a7Q
 +SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075999; x=1778680799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SQwTsh+iAyv/zCSx0/p3+pxdOCF3BHdT8oB8gjVmgyk=;
 b=IXBU5bAYILO0JuptJBp+hHj6bHM77mHv5DjfIutixvCcOWBWOkGwh/EiSW3XBxwpdy
 Gg4YGCzlAF9InR3Ay3wBXZbfd0vxOdpQhNq9Rg9IdiXghT8AqeY4DQRCMKg4YccjIflc
 szVB1bEliwA1zVdh7BEASYSeu1WIdfOJq8ZE+zxJF1z4nVTmWV6+yBClc6hAWN2cuuej
 OhLT5B8MhTZSqAMgRKh3OhUQ2Pe++6hWsAzr3bABa0uyUQycBVO3/L1UpquzzRfwh4eY
 8NzTJ32DdhRq28Fr6A70/xXhu+BAesuCDVrXT1oQW8g0kYNCkB3Jlp0TR9fm8VtdNHXt
 wteA==
X-Gm-Message-State: AOJu0Yz02N6NsJv/XEInL/FndpGUivxiXNZ9DZDPnstCVz1VxrFWMcfn
 4rrXw+LtMStqQ+LQBMk06LUlAWy4SmCmldRLkpXNdY9P7rhNGMBbjue8ldpniwEtx6b9CP22V73
 Accf7sXs=
X-Gm-Gg: AeBDietBewb9K8uBuzZMZTA9w7awFLDpJxmdlA4yDfCkg6K/Ha18oEVHPElfiRkewkf
 9UIeG4T5gSyL6Rjk3tmOacqXCvj2F0vxWPOvRlxy5JRuX79YBpF3U6WSDqG2fNunJYAlbC7Gfhi
 grs/cY/diZTmS5XYkRO0OtT8El1JnrHOSu+lEhgJ502ZDYz5iB7Wjf953+hZFX/PFeZFLpBPlJl
 qL5gMDR3kdMvppXR8J/tBdoJe6XX0tmF3ncq9LX4dKzPXTBxbcyQTwhf8Kkv8TlHKhw0COqNKwT
 5BybNnTII2ozqy6998A3XXvnj/TF0sJLdPFEWatJI+Y7n2QLAgZVJSEaHRPCyY36erT8Ia9vgcd
 dBJ3fQsLindNR7x+7rfizebW/y8QDIdrOyafdLHQedXeYtHc9maRtdy2Lk57hiOfRmrq6liYbhZ
 WRzSuC2TFOC2DDNKQQ8+89ZRIz9fMW1HyvoqQHHZkGoKzzjq1wUI6DNiROLOUJV4zAWf7PEh7Rr
 mQZdvonGPJUeyouQ482rg==
X-Received: by 2002:a05:600c:b8a:b0:48a:5574:3a48 with SMTP id
 5b1f17b1804b1-48e51f32bf7mr64002555e9.16.1778075999186; 
 Wed, 06 May 2026 06:59:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm11330980f8f.36.2026.05.06.06.59.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:59:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 036/110] target/i386: Replace target_ulong -> uint64_t for
 TARGET_X86_64
Date: Wed,  6 May 2026 15:54:08 +0200
Message-ID: <20260506135524.20617-37-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These registers are only available on 64-bit builds, thus
always handled as 64-bit. This isn't even a migration break
because they are migrated as 64-bit since the beginning
(see commit 02536f8b1f9 "x86_64 save/restore").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260315165319.39727-1-philmd@linaro.org>
---
 target/i386/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f57c99e8b4e..a836efd45ee 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2061,10 +2061,10 @@ typedef struct CPUArchState {
     uint64_t vm_hsave;
 
 #ifdef TARGET_X86_64
-    target_ulong lstar;
-    target_ulong cstar;
-    target_ulong fmask;
-    target_ulong kernelgsbase;
+    uint64_t lstar;
+    uint64_t cstar;
+    uint64_t fmask;
+    uint64_t kernelgsbase;
 
     /* FRED MSRs */
     uint64_t fred_rsp0;
-- 
2.53.0


