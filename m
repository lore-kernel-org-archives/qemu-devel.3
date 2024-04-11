Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD201C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv294-0003OD-4Y; Thu, 11 Apr 2024 17:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv292-0003Nw-IX
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:39:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv290-0004lw-EL
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:39:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-417d029bf15so2059805e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712871580; x=1713476380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IDmcslUAelQNuuThaJDYP8czpqm/pNDa1dM39p8C5s=;
 b=KorOlhBBxddC1Lvr3osSYu8/0zeHipMoMXkgzfbpB0GO35beE1F0im935uWsdwLWz3
 11Gmttgup7QN2E29uCkStLcxyHp+N+c3IzyPA2pUIhw0BijxfDwgJ/YyuoQp++Hg/VWD
 fVQlF1lRofFekxtBdtrKtNjSxFcDGASXxRwBoi/fh+GwMsqQYN8rhGcD+m9+IWcR8eY5
 Oh5vAxNtCbH/rI5iQO6pmo5YCQUGrrFcRbQ0C2PypAv4jbn+8kEc97FP/mioJg9hRBA5
 XVPwemEAIPdgoBk/P0w6yihh5Q6cKBzZoSc25NxuCgX1IfkWiB3XUga+nerqqpfD+JvP
 b10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712871580; x=1713476380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IDmcslUAelQNuuThaJDYP8czpqm/pNDa1dM39p8C5s=;
 b=bA41wGGs+sui3TWRSIM6Jyd8FbYQFcnot8T//K2rf2J1SKUfVU0O/jcythqtfJKBeU
 LBRlu4czASKMYL1iRW9gKBfIpaY6iOjbnsq5RCRL5GBl4sUdzYQ6mCrVE+/FHDikkDz0
 ApVzhk57bM4Iufpq4NtWQ85pUTUCHd6vAo/f8NOl7c45XRPMTqiXz+gPZLmao/GZZvCG
 eVWUTsXdbsjyj647BgBIrkqEDkYL21bfdhkURO30vNNNs6l+jEmJszH5+3i7TAbIMrjR
 D155ltKG+OxAWAjKmP0w7aaK4D+fF5JyJsfBxHEg9eJqE+Pw3ssbZSVwfStJDe2pOEI+
 9FOg==
X-Gm-Message-State: AOJu0YzJFZ/Xj46THAlmXWAFcJuyWlIYylBNEqA2+qTWyW2yGsibMP7l
 Ib1svaJxsCLtpdwxfXbmS/W8rX3SGr9QWXVZ8MafDSK5bFIc8f2sy0bS4aJb+GjMrh1vIbYfbc+
 TwVE=
X-Google-Smtp-Source: AGHT+IEc2Sc9F+qZcicc/Hi8cYF4eXpqGUxlxN4n7ccIGhom+XpCjSc49G6EICbYQKa4OblHtVAoUA==
X-Received: by 2002:a05:600c:1d1b:b0:415:48b3:e270 with SMTP id
 l27-20020a05600c1d1b00b0041548b3e270mr649616wms.9.1712871579919; 
 Thu, 11 Apr 2024 14:39:39 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 s12-20020a05600c45cc00b00417e8be070csm1764939wmo.9.2024.04.11.14.39.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 14:39:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] disas/m68k: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 23:39:32 +0200
Message-ID: <20240411213933.36548-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411213933.36548-1-philmd@linaro.org>
References: <20240411213933.36548-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Inline sprintf_vma() and use snprintf() instead of sprintf(),
silencing the following warning:

  [38/244] Compiling C object libcommon.fa.p/disas_m68k.c.o
  disas/m68k.c:977:7: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
      sprintf_vma (buf, disp);
      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/disas/dis-asm.h | 2 --
 disas/m68k.c            | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index b26867b641..1d8a4ce9a1 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -15,8 +15,6 @@ typedef void *PTR;
 typedef uint64_t bfd_vma;
 typedef int64_t bfd_signed_vma;
 typedef uint8_t bfd_byte;
-#define sprintf_vma(s,x) sprintf (s, "%0" PRIx64, x)
-#define snprintf_vma(s,ss,x) snprintf (s, ss, "%0" PRIx64, x)
 
 #define BFD64
 
diff --git a/disas/m68k.c b/disas/m68k.c
index 800b4145ac..e8e61c7a4e 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -974,7 +974,7 @@ print_base (int regno, bfd_vma disp, disassemble_info *info)
       else
 	(*info->fprintf_func) (info->stream, "%s@(", reg_names[regno]);
 
-      sprintf_vma (buf, disp);
+      snprintf(buf, sizeof(buf), "%0" PRIx64, disp);
       (*info->fprintf_func) (info->stream, "%s", buf);
     }
 }
@@ -1069,7 +1069,7 @@ print_indexed (int basereg,
       (*info->fprintf_func) (info->stream, ",%s", buf);
       buf[0] = '\0';
     }
-  sprintf_vma (vmabuf, outer_disp);
+  snprintf(vmabuf, sizeof(vmabuf), "%0" PRIx64, outer_disp);
   (*info->fprintf_func) (info->stream, ")@(%s", vmabuf);
   if (buf[0] != '\0')
     (*info->fprintf_func) (info->stream, ",%s", buf);
-- 
2.41.0


