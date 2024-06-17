Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5479C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZE-0005nQ-DG; Mon, 17 Jun 2024 14:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZ3-00053N-Lw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZ1-000511-Vd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:49 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-705c0115192so4002569b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650726; x=1719255526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSb4ge/oi7N04tkudfzAy1LJjUNLVfIVt+fkT6uQ/zo=;
 b=Vd8txHPTe5/dEI8YHWunZU1tTMsFciwVKGp8jLPnDyT8LacA6FZ1Z+nlqOFbaiV5IB
 7lhUYk4VQ7NoPNnMcrg+BvHFw2Ar9FKMrhi6P0v/G5Z9/1g5M6dN7MSXVFxHQJwCiCGW
 h6yqD+JaL6S6hRqQlt+dERf2UgJWh6DMC3MNa+0FzUoFX5lQuCn2LR+KoEyeje/HcuzC
 GBlZSGd/jraTylrhZiWYvKLXSNfAyVtUjPsSwuNOKCoOh7PE5ncRFXSWqjX2ZYK1yFJK
 li9731JpqFoycaVLAkSmBFr+aGt0E7Q0gZPCE88cfTygJwKbM86VN+7fMrSGjIGFYvJ1
 JCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650726; x=1719255526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSb4ge/oi7N04tkudfzAy1LJjUNLVfIVt+fkT6uQ/zo=;
 b=bPe65eCwfjsBTSBITPOoWDLiRl+2QRUtWRlpcB/G2ntTiRfiuAnSre2QwVF+5f5888
 l+tJOzUb3JmuoaBXh4uZCQOSIEm3AY1jfdNBB1TuotHMem1l1mbqoNGbLgcqJ1kYbPic
 ukLRPnyCVFelJtNEI4a7Lb1x+nm8izZVmVuBOMQwV4m3157JxuVJjDRgnsEyY/Qya+fa
 6nMELSrY5l5xiWuwfbSC/3k6g+YKNmqQX1HZaIH0ccnw6K9sF7t79u26NRB1ZhqsmjYl
 Jx+DeXH200hrSJ3OvLNc+bRhNyQyhHLsymEhR332RzGphyPOkFuT6VcHHQR2SB489CL/
 EHYQ==
X-Gm-Message-State: AOJu0Yxu//LHuGAmypGzYDnoffVNmyRnpryWRM3DLtv4HgCDph+Dc3hK
 tt/wN3bGV3Nx68kxZ2o4A7ChpWzjlRo3LUeM7SBVtjHdmrVQF6ey1RGD2OTRbmI=
X-Google-Smtp-Source: AGHT+IHiXp1QbDanXfoL1XJhppOzPqy3C5996vD1ONIrkyBLaTMCD8wrWZnQOIG7gy/pIkw4Hu+Ivg==
X-Received: by 2002:a05:6a21:3a4b:b0:1b4:82eb:61b8 with SMTP id
 adf61e73a8af0-1bae8002278mr14043670637.45.1718650726438; 
 Mon, 17 Jun 2024 11:58:46 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:46 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 12/23] Add ability to get rval2
Date: Tue, 18 Jun 2024 00:27:53 +0530
Message-Id: <20240617185804.25075-13-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Warner Losh <imp@bsdimp.com>

Function accesses the x1 register which holds the value

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_vmparam.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bsd-user/aarch64/target_arch_vmparam.h b/bsd-user/aarch64/target_arch_vmparam.h
index dc66e1289b..0c35491970 100644
--- a/bsd-user/aarch64/target_arch_vmparam.h
+++ b/bsd-user/aarch64/target_arch_vmparam.h
@@ -65,4 +65,10 @@ static inline void set_second_rval(CPUARMState *state, abi_ulong retval2)
 {
     state->xregs[1] = retval2; /* XXX not really used on 64-bit arch */
 }
+
+static inline abi_ulong get_second_rval(CPUARMState *state)
+{
+    return state->xregs[1];
+}
+
 #endif /* TARGET_ARCH_VMPARAM_H */
-- 
2.34.1


