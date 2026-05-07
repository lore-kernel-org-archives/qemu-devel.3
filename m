Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5496DCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ER-0004a8-8Q; Thu, 07 May 2026 12:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EN-0004Wm-0c
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:43 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006m1-TE
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:42 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so657642a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169929; x=1778774729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mw1kdvtUwUPt4raLxQUB1roVMfIRc+atM3nbQew3RN8=;
 b=LXSVg/g4e5e0E0w39QZmCt05rdu904te0vqvPP2nADEPfomaBQ4zctAG0Z8wY9mDaK
 T9S4sgOoTEU/QcDLbCjQ2rJ7QGx/FGDhqdLryKQcV52zVZfbntRaWbHsgvxHkKtCrUQv
 SYc6H8Iy3JZ/GJPD5rQ2m8Ch37mePkV8D4Rx3YwHck4tjKhYsUTPearQuZfoyWgfcRLx
 3ObSndBrGvgw/CXLAJE7aijvmAthcO2v4Gsx6k8tyRDh6wkw54boYWEeTulV4lF/SKMH
 LOYLntDzHWIVDFTyqNljM13zorA1QUAUBc4FshkVv70ESt5SmkV82sTWQdrlgcu29C6D
 xqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169929; x=1778774729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mw1kdvtUwUPt4raLxQUB1roVMfIRc+atM3nbQew3RN8=;
 b=dUk2taI1leMhEm4Pz/XuFW4RDfaEf84qr0FETghUyzJX8HoahO8SWowfhOos85wfHw
 POUgPgIcLbpKe9SPCyFJoJyn0zeY8JhwTkxJBrJMvf63g/6kn7oOdt4D4YmI6uejwTBS
 VGm0BeM87AG+Me/FPE/rn07ScSC2O5PL+APCP4g1EVHgSLVu+1VFeS7ck5H1PjaJpMYv
 rSzuAvorkwpiZUS5rKL4ZTELWkeWVrzBN4/J9/ZNAM2ZjivoQfkaa8+djQBqaN9CUx9U
 vsrZoZWHuMfY3YsUIpC7OtwKdXgSHUBYhG1eVwur+h7Wb2bHzkWqB9t/CXjC37PGSVr/
 Xr9Q==
X-Gm-Message-State: AOJu0YxnRgMkVirP126nG0YEPtCs2+jKaCEcbWBMMSLiDt3S310eiJre
 IZwFFdtMm3aqXON3pdb1knBsiUOFk22MgxM1pkxhtCmv8kdRHw0o6g1R7lC+/aKVhIPHQK5hERB
 jDPsD
X-Gm-Gg: AeBDiesSB6XKG5yIV+pTu0N+gJVVvRYVJp7hELKdZYozkncWTphPJzOyUEGMrG/ZN2M
 G9/AF3TGAsaiGYHIfZfgue44mjQTyIM6G7lK6Pz8h5/8zGQy2DivkhYOUQpgrYv61tLXOCnULPC
 G6F9CBe921It6aRqNSHu0erThfyNa9UJ7KhWxgFZz/WCSbE4yfLdGtF6OlpGZiwCH423P7Z6rA/
 Jgvq5eno467MqPK1748FInM26bfHF5Qeg7pWCc8koGR+QjqfjbH9JpwPoeYBwC/IwmQboDvEr0+
 CEjqS7dzAsDea3cbY76HgIi0NBYCtaToMd+ohszsoLOV/1cKQq32LBmXy/qv6If+futbmCdgK7J
 JEKAHjZj1WT0CDV5KDsmr+WEmZMemIocscnBFKJkH14zd5Nooe5om2LRQhYZC0iM9449o3RkDo8
 NoIPQkgWCrj/NJyGuD/TEW9c1MHq7nZEx/gj+SLOQOYUHusw==
X-Received: by 2002:a05:6830:6005:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7e1deebc5b6mr4783099a34.2.1778169928901; 
 Thu, 07 May 2026 09:05:28 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/29] fpu: Mark unpack_raw64 QEMU_ALWAYS_INLINE
Date: Thu,  7 May 2026 11:04:55 -0500
Message-ID: <20260507160518.444797-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

This is almost always used with a constant FloatFmt,
so inlining pulls the constants into the shifts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 302612fe42..63697ab3db 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -633,7 +633,8 @@ static const FloatFmt floatx80_params[3] = {
 };
 
 /* Unpack a float to parts, but do not canonicalize.  */
-static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
+static inline QEMU_ALWAYS_INLINE
+FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
 {
     const int f_size = fmt->frac_size;
     const int e_size = fmt->exp_size;
-- 
2.43.0


