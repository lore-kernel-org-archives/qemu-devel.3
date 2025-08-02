Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14D3C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJ3-0001RT-4J; Sat, 02 Aug 2025 19:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIx-0001Cz-T9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:20 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIw-00018q-Il
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:19 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-433f3bc84e0so622930b6e.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175976; x=1754780776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBti5m0dF6b3Sc0I6qGteHg5X6Zr9g2kU2k58zFoTUk=;
 b=w93Mrk6z18yaO9Tbhd+rYbMB1HLdf3p+k9G1flZHgaOZPu1/vwUYx5B4Mqtqt3q0DL
 f6jonUrYFIIfEjGNIXi4dAfNlpZaPkF8+fRBAfDDCE8FNE0iHtLt6uRvmT1mhUvFm6v3
 ArFxfkRyc31wi2B+SZiTdXjvA8O84mVbO7mBPAxRqarocjmEiev6EwTOe4T/iRid4PRr
 XWBJ/gsfnqUsVIHcLqobgoGLiHpmW+ZPxq2BHpGHCJPvT7QbfVXvHR0pelEP/RBUt4mE
 SF+PVcYm2yD031+rQRZoo6ijfAWtwfw6OAuDTWpPCSaD5Jljk8K2JksX3B6AUo867ZcM
 bPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175976; x=1754780776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBti5m0dF6b3Sc0I6qGteHg5X6Zr9g2kU2k58zFoTUk=;
 b=luCVhBjBpHCb4BH6nFtwe18q7zm9CgmbuBWXuZZIt0zt0N122YAfzdUSw99wJIqPRR
 bCEhx54bNzNia677o/jfE9E+B3QfFH0G+8TbXA9LrvOVseDupb51SF5VdisTsqc+OLIN
 5jV1MuNuXwG9eML8Yatd/UQt+bE++tZZstVGCwPVonStFQzIHOOREpPLrX27Fv24Te+k
 9FCiDt4I/rtsGfUfRiztY5k0k2AIbJ41ur2SU8mZYGE5nofzFRmAagdIpLh4HAIx5dK9
 FDqhciA54Lh51BZSgDrY/NwrWVAuyOmfLbQZvoVABoY5SmOnSfVkfXLo5bODQAWpgWgg
 DzoA==
X-Gm-Message-State: AOJu0YwHGzJwPn1l0ORNbBdgEholypFGxECs5t7q5aqeCsuPRcqoBiTO
 A8f40iEULRwgjBL1QpTs7HDeoz4K3hQPvO6dSeAaemA9VxsZ9IqnNakpwLpeDiAAweqLAq1iRul
 0IE0Qcf4=
X-Gm-Gg: ASbGncvAuQB2g/QAHApSNguOuo0/naLLfAs0XZ3OCtwg9QcVJRG8DQOd3MJovCpDYmE
 HcTvn/Mqx/gwk4G9J/kDagJf3IQPamCZZtIbfXVm1O2BIW6Dl5Tqz6LtlfchKpzDxqEe+PCaAso
 PoQbG/ovLKOiqbkUOs5Cwns3LpvhV/kbv1kD8Rfz4TLJFjxsU9McshRhqBB9rumYF8oB09T1EGp
 keJYBDsCNWqbnIkv85/CZABjHKd2f08ktOyjCy/TIxAhBPhv1NX9N7h/M9RmudreSK9axRZeGcr
 zHpa8C9BZOErecKaZuig6DPcjXQbQzG8KI9f8VwOH6b+T/ekKHG+7G5DHepX1Q/jYhTytyL39c+
 HFEjov61dU4YP4rJ250OC0Mb8dGEGHOvhzwpXDRQceeus1vVe3Q6d
X-Google-Smtp-Source: AGHT+IHq+ePnkF8GgdCHBYdg9+lh7StxwqnlFTbwRY77KlN61qrZpA5j5bw84jpHw66n+WchrLfwUQ==
X-Received: by 2002:a05:6808:2104:b0:433:ee48:cb9d with SMTP id
 5614622812f47-433f023c4a4mr2543423b6e.15.1754175975991; 
 Sat, 02 Aug 2025 16:06:15 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 18/95] linux-user/i386: Return const data from
 get_elf_platform
Date: Sun,  3 Aug 2025 09:03:42 +1000
Message-ID: <20250802230459.412251-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Rather than modify a static buffer, index into an array of const data.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/elfload.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 1b759098ca..ef3a6c35d2 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -17,13 +17,9 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
 const char *get_elf_platform(CPUState *cs)
 {
-    static char elf_platform[] = "i386";
+    static const char elf_platform[4][5] = { "i386", "i486", "i586", "i686" };
     int family = object_property_get_int(OBJECT(cs), "family", NULL);
-    if (family > 6) {
-        family = 6;
-    }
-    if (family >= 3) {
-        elf_platform[1] = '0' + family;
-    }
-    return elf_platform;
+
+    family = MAX(MIN(family, 6), 3);
+    return elf_platform[family - 3];
 }
-- 
2.43.0


