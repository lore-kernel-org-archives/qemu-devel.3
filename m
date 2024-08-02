Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829F1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29m-00028q-He; Fri, 02 Aug 2024 19:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29c-0001ab-GC
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:49 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29b-0004HO-2B
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:48 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so3105639f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643065; x=1723247865;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rl/znR7UzS/Jv1fIJnzwl/xusVFEIhdoOvswwLVsMsA=;
 b=uwtlK/fX+94kU5k4vg0on7GeGwp7+c598sPaMm/OclVl85tfkY+ki+xvDjSacUwRqr
 PLnvRygKLBLPXTApyBzQ/UevYmhBIOgGuix42MhvXbdHN+oWI84iyzN1OT09I1AfeKgN
 KbctEh0cHAi1E8STU4M0SIxZup+aaGcss75hEFPHvtUrjXe8ymyGbvclOGZgJkBX44XH
 gnBjcPr10UWA1SHn2kGSK7J346vZXrOKOe3thmz7i5BWwAPD9ea+Q/Sna8Glwl8QBZDt
 YEjQsUar1GZMzyenIwIbVJYoHIBkoJIeECFNcfokEeammSQw8IzeVVRQI8oRDOdfEDm7
 suMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643065; x=1723247865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rl/znR7UzS/Jv1fIJnzwl/xusVFEIhdoOvswwLVsMsA=;
 b=qMGkvHv/JyUmP3ljwBE6iL3njmBa/hzDkTXaThb8BtHKxUwQaJ3IaghIwMDUfLPrss
 h5Ak0kdKmZCj8VYTW/mLBbi+8JV6r2pUcZuAzNgrtYAYfAXft0kujVo4jzFQDz9FfxW2
 1CkJE/Hp4mlEGD6P6rdRfovydeBl+pVAJ9zFakgobmsyedyXLshZCNZYXofW24+LTFxz
 gsGpv+sdjyXvZGhhOji8mosdybTfaxywZEOC2kHaoZmo1vkatQaewQfkgltPiIFyrPnT
 ZXz3jwkdNNc50ts0VDOcRbvq9nhvNHO1tsNDTdJzf0vWEtWzhUr9ElbD0ZVjNbABNJsK
 XPTA==
X-Gm-Message-State: AOJu0YwKtfzZ+PcpDkqCC+bNSn74k7Bh+ye1E2qHgo8Fenl5uqd0Q9PJ
 gQDhkHy08szuXao9XY61bEHBJ3XzO1wJYFxxchdoXKxNe1iwKxrF27Xb/fOZB3s8fK64sVohWBR
 l0+k=
X-Google-Smtp-Source: AGHT+IHaBirxAvRkwv2oRYt0555cjDOxoNSL52MbfDWjzhkOB1rTzgoq1htIwlyMZjYQI2GYbekYqA==
X-Received: by 2002:a05:6602:6c09:b0:803:85ba:3cf9 with SMTP id
 ca18e2360f4ac-81fd437127bmr663467339f.10.1722643065590; 
 Fri, 02 Aug 2024 16:57:45 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 06/17] bsd-user: Remove load_flt_binary prototype
Date: Fri,  2 Aug 2024 17:56:06 -0600
Message-ID: <20240802235617.7971-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

bsd-user doesn't have support for loading FLT binaries.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index f18a54cc933..b97a902a4c2 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -164,8 +164,6 @@ int loader_exec(const char *filename, char **argv, char **envp,
                 struct bsd_binprm *bprm);
 
 int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info);
-int load_flt_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
-                    struct image_info *info);
 int is_target_elf_binary(int fd);
 
 abi_long memcpy_to_target(abi_ulong dest, const void *src,
-- 
2.45.1


