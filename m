Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD429CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QS6-00053V-T0; Thu, 16 Oct 2025 12:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9QRu-0004we-RH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:03:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9QRl-0001hG-In
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:03:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so799400f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760630595; x=1761235395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IKB36zl1JhFyiPdH+NdngDZusOe5aX6RiH1LliwRAQQ=;
 b=GyDjCpTfN/V6fw91zdeZemUDrRi2iaCizMf3QJ58NigmLZ70MTSRe/f6EQsE3HoXLx
 Wc11R9d3+kg6D/1rKSYu5+K0thzpLD1bz7WC16LCxI5TAdJlEKtP8B0n5X2sf6/84mO0
 p26mY4PZNoOpFQo2npJH21xc9ccmwUWAfw96wN+jCJurSk93fAPkFA2OYZGLgDI1ddm5
 W3KIUoKSWpNWPiCQ/vwTb1jL0/S0K8LDZSbePXpDar/AkMUahZjfChg7GA+ynJSonNLp
 ex2ymrgRLwHLpUfK8devnH/mVkH8kAmNHPCUfraXj2q3x+16bSWpM7dSbqCJlrEkAiqU
 kwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760630595; x=1761235395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IKB36zl1JhFyiPdH+NdngDZusOe5aX6RiH1LliwRAQQ=;
 b=oOiROd5C0s5onHyD6eYR++JzNsC/gbV0vFJGfsMIf8gu+rL8fXWqTKIsOSQtW+cjSj
 DkBaaTTlVfroA2T+QannnKjfJcfw0oRsYLqMj1j5DADtvLfnP6GS7ULQ9+fRsno+MGV7
 Nr9/a2Ib4aH8m9Qpg8fcydemoE5G1pYg5z5wtvSr5VTm6Qf0IjNQ946u3Jx2gDOj2Nkq
 fNPf4c1w81FNKofbWe5a5GlatOgmMld+IU1REkAvcHSmYgigdYhP6A9tQrBYHeKMSGSN
 rorilpo9h5p4aZeKJN5Kon8KZgUSBuAKU8x3Pub31Ow75szgQUVXG0YlO+uHRK8MdePQ
 gHDA==
X-Gm-Message-State: AOJu0YyXAj9fp+4DZCJs3PspXBfjqZKjPES7MWlSSXzOcFPCwKnRsMIE
 kXaQCoxo0KN9gVJlegwRH3hW/Aj7lOFk/8wKpGhzpwomU9pOuj50LYYh1qdk/E63Z2Lpsk+3iR0
 McGeOE6Y=
X-Gm-Gg: ASbGncumfLCgtaHeFtwVpAxtHzO3JLnF15p4yJewVDSnMUnnhDh9nhsJA+rsoVWWn3V
 t8/yYdDdhIuIgN9ka5nohUfMGzTVvh6YsIlYQo+cBvPpfM+Jm9lzDK4q3YXy+OphvRGhIzA6XTC
 UaDads+p5T8j72mSm2QTMyHRUBvAfBTsp05jkOkoZcFElIlZAkTdd4uqL5KFIq1ER5/SSvcyAas
 PsTpATYgYy4Fqah9kPFNepRFeyIHiTa2l+9tF0Q+f45Fp0Ib9DOYoH+DX/FOKVNVeDeEf03SwGN
 UJCSdtkxXSH+ZNFxLDkVcTvYftvIcPZ5kJyDAGchvdhCF8dts1QM/yGgmVFtE400t2lDBHEFYWx
 vd6vHyvvOsI5SBKNbFqZvOYCHZHJWeE1mPayQghuHC/WdzOXoZsCObXoWfjycokg8uwD3k46dRZ
 RCtNDPNG8j+UaHEiYHoJVfAcJdwklMfmm7gX/GcatRFYZm3PyB0g==
X-Google-Smtp-Source: AGHT+IHc2QVW0JmuszkuVMZr+1PU3RMdjQmy+L55oMQMcNkPH5YbCu1FCTXqUROSYj9rKGwgERWMiA==
X-Received: by 2002:a05:6000:186a:b0:3ff:17ac:a347 with SMTP id
 ffacd0b85a97d-42704d7be45mr538647f8f.27.1760630595354; 
 Thu, 16 Oct 2025 09:03:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d015esm36608065f8f.33.2025.10.16.09.03.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 09:03:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] migration: Remove unused VMSTATE_UINTTL_EQUAL[_V]() macros
Date: Thu, 16 Oct 2025 18:03:13 +0200
Message-ID: <20251016160313.25751-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

The last use of VMSTATE_UINTTL_EQUAL() was removed in commit
16a2497bd44 ("target-ppc: Fix CPU migration from qemu-2.6 <->
later versions"), 9 years ago; remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 65abe3c8cc0..ca7cc0479e7 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -19,8 +19,6 @@
 
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT64_V(_f, _s, _v)
-#define VMSTATE_UINTTL_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_UINT64_EQUAL_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
@@ -40,8 +38,6 @@
 
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
-#define VMSTATE_UINTTL_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_UINT32_EQUAL_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
@@ -53,8 +49,6 @@
 
 #define VMSTATE_UINTTL(_f, _s)                                        \
     VMSTATE_UINTTL_V(_f, _s, 0)
-#define VMSTATE_UINTTL_EQUAL(_f, _s)                                  \
-    VMSTATE_UINTTL_EQUAL_V(_f, _s, 0)
 #define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
 #define VMSTATE_UINTTL_2DARRAY(_f, _s, _n1, _n2)                      \
-- 
2.51.0


