Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD9EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAsq-0005Y0-PS; Thu, 07 Mar 2024 05:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAso-0005Sz-3x
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:50 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsY-0007C9-RJ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:49 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso6213555ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806893; x=1710411693;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DgfW3dC2BQFvXbkrpvVsfPqRuCKLeW6kZAejsXMFwME=;
 b=XChQ+CU8MZcZoAiSyOKgtkVpeutHCHB6S4HM0I0U1uQqs4nqxsnGsY1UyPb8157EuO
 y5yei1WIHf584LShlEcmEbEEwTFa7Q65CTPljH6L1H1MgTWn6OhMnPOM+QCs3QZ6keEA
 CSDZ3JyRCTaPhquHfcK/TEFxYvsB61dyc8Vk0gkIEzPRzonXyabBo73nqxVfcZKP8e5C
 onrlxswus2roa+LgqCx66dvp9OHB/CVFXF1+fPyGGWVE91coVZh/IXB4FnwjHDSsjo8+
 JeMzN5i8s9VQxr1kOWtqmoSsaYcFKBe9ViGWMeXT3azr9JKrl8s5OAYBc/xT+ruZD47z
 KANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806893; x=1710411693;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgfW3dC2BQFvXbkrpvVsfPqRuCKLeW6kZAejsXMFwME=;
 b=wSxWKQb2pqCFpd96WlfyoPrAW11P886gToIREjaHZ6DjFSQ4l/e00alhOqFLUe9moA
 GsBGd2DNo0B9BufCCpACIuo3nP+91rn0q8+H3xXVvwy57OHokIgArkSZirOGlfjvOx2/
 EpMRHjMqWe26czNFoB8d7Gs8ugcFykllHc97K73INoomhFnReOxMj4tyXL8+DCit2Tnq
 fapFDjqiysReOTDSErlpqKLVUjcx2Kj0YdJfj7DVjANCk9POJGepA87Dk57SjRbnqdFz
 82XkGlVy+QBwQyWeQXoRgudHF7RTwYmSjOzkkbrVecU9RVVIwqKHosq+TZqb50liMwLR
 1Wdw==
X-Gm-Message-State: AOJu0YxoSr9Gi6Tmb4lbvdyHAPLWJQ37vt0vWetj5G0oD7XZfvmcDAjJ
 kCLkLC65MvbQnoZfPvQTnJSaYNXiqLdDAtJyxBPjw3YtHWFtsCZE51uDe0jbtNEYTDrA/2vIWo7
 T
X-Google-Smtp-Source: AGHT+IF68jZdEFj/hfyYQYRzibgDe2IpMF8NgclC81IrSYKhqEqysT+ohre6ZHAMbK0QQozN8FY/Vw==
X-Received: by 2002:a17:903:11c6:b0:1dc:a605:5435 with SMTP id
 q6-20020a17090311c600b001dca6055435mr8705251plh.31.1709806893548; 
 Thu, 07 Mar 2024 02:21:33 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 f6-20020a170902ce8600b001db45bae92dsm14237079plg.74.2024.03.07.02.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:33 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:55 +0900
Subject: [PATCH v4 12/19] contrib/elf2dmp: Ensure segment fits in file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-12-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

This makes elf2dmp more robust against corrupted inputs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index e01860d15b07..81295a11534a 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -88,11 +88,12 @@ void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
     ps->block = g_new(struct pa_block, ps->block_nr);
 
     for (i = 0; i < phdr_nr; i++) {
-        if (phdr[i].p_type == PT_LOAD) {
+        if (phdr[i].p_type == PT_LOAD && phdr[i].p_offset < qemu_elf->size) {
             ps->block[block_i] = (struct pa_block) {
                 .addr = (uint8_t *)qemu_elf->map + phdr[i].p_offset,
                 .paddr = phdr[i].p_paddr,
-                .size = phdr[i].p_filesz,
+                .size = MIN(phdr[i].p_filesz,
+                            qemu_elf->size - phdr[i].p_offset),
             };
             pa_block_align(&ps->block[block_i]);
             block_i = ps->block[block_i].size ? (block_i + 1) : block_i;

-- 
2.44.0


