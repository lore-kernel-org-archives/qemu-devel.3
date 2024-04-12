Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF36C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQE-00072Y-ME; Fri, 12 Apr 2024 03:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ8-00070n-FL
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ6-00079b-US
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:00 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e411e339b8so5282885ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907237; x=1713512037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rkNxCt/0g8Id1+pQXEkuRBEGY5hnj70aYW+ARQ9RhY=;
 b=IARtOh47MGDsmxINTCLsAlLoq5CkD61rkgaKBjMBK9nkSArqpj8+tPHa6w6yRC8vvH
 Tk0S0PZo9GRAsRcr1Uq/J/sS8OICGwuxm490d36XIVMQTUQcH5ADDaTF8cLA/5D/sCSl
 ZhFSro03qmK69JGFiIXgiWCxqoWcrbjTN7W3hcc1q3MK1E3wwrIWAReNgCPYhpnQj5bh
 GPyRpe/QzdI+G4QsprY/Wzy1ZT+uei8cpyRECxZCppW+4G1Tif9c4m4iHe3z0qYGN6kY
 PRM6Rm9A1KfMgHGjMPSRzCvAP9MibwKPW6i60OSphXmduNkTW0mAW0at1xcTUQQnwsEV
 vmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907237; x=1713512037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rkNxCt/0g8Id1+pQXEkuRBEGY5hnj70aYW+ARQ9RhY=;
 b=U2AyRBU7dNliZAU0y2EOugMTAjM9NNKhC22Yj+6+tSWrP0VPCsGsREJhcAXBZudhLs
 du0YiB+QZnEs4/K4li6bmzFCMBM3gBR3xUf0LP/uMRf/uCxlpgSIE80z4s6E3SeYfhLe
 ia7imXlfa9R/sKSL5xR+itcOyY51kkr7ovT720UQQ4KPlURdaRiYlM+Ln279xEhzSNvX
 DvHjODcG0RBtsqmc7lSD53yJ6d1+CmSszDTMtqgTYUKL8hCtQhLB+FEyudvPLnDVHbvk
 4NpBd82WRyHMP/Y4xV2BbpssH0cL1ySzd8NOutr1uxXjJhkR7htHzDYWVTCCMh8s1a5c
 9nhQ==
X-Gm-Message-State: AOJu0YzBIPOwL4dy5fKn44XuVTMEPJz0VG1mzEw0ICZ0Y0NgrLnLVGUO
 0gdiA+clQwaECIHolytfeaP2eczZ6xsvjH/yQN/Cuw437igcUt9vqJz4IOKtRo4Lsxf0ObA/L2r
 C
X-Google-Smtp-Source: AGHT+IHmUlHocG4kYk9i0OE3silNXhWVflOySM8Xk/mZ9SydUwAPdDOfsfruyY0iGejRkGRRle9jUA==
X-Received: by 2002:a17:903:24d:b0:1e4:970e:37a7 with SMTP id
 j13-20020a170903024d00b001e4970e37a7mr1874001plh.60.1712907237402; 
 Fri, 12 Apr 2024 00:33:57 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 12/27] disas/m68k: Replace sprintf() by snprintf()
Date: Fri, 12 Apr 2024 00:33:31 -0700
Message-Id: <20240412073346.458116-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240411104340.6617-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/m68k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index 1f16e295ab..800b4145ac 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1000,7 +1000,7 @@ print_indexed (int basereg,
 
   /* Generate the text for the index register.
      Where this will be output is not yet determined.  */
-  sprintf (buf, "%s:%c%s",
+  snprintf(buf, sizeof(buf), "%s:%c%s",
 	   reg_names[(word >> 12) & 0xf],
 	   (word & 0x800) ? 'l' : 'w',
 	   scales[(word >> 9) & 3]);
-- 
2.34.1


