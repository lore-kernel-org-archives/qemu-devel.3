Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A3EC98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 04:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAJiJ-0007DL-Nh; Sat, 26 Sep 2026 00:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xAJiA-0007Cd-PJ
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 00:08:35 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xAJi8-0003kb-9k
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 00:08:29 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-672f90fc533so1535589d50.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 21:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790395707; x=1791000507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WfOrG7CvMWb1suVPNFr03mapnOOoDwUJHrrOFEWkYHc=;
 b=UYjBoDt4TfllFFiXVMNG6KGuAC0Xxx9teOGV1j76/EfquQO/Ps9losN2LIsFzTbygG
 6aY/h4TXgH+Uws+/DBcz0NDYsIqNAePEs5vwCa62+B17FiNveuuUPd02pOGaiW69abs1
 K9f91tCv5p4xoUZCp4mo8lMVyjvuUwRbiLdM4WIrYn4bcG7jBK+oXwPRYJIEEPlXtrrs
 cElIYbo52DkFhbgPDn08915nTPENfamQjnXGOrxDiSi/eBXBkd1x/25vxENHUe104DI4
 13Nf1S5ZkrSagUYaSCxwS6oEIIE0cjZPPpwTyQxZHJu5yNyNqqZwbGWJB+72p6Cf7Yjx
 k+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790395707; x=1791000507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WfOrG7CvMWb1suVPNFr03mapnOOoDwUJHrrOFEWkYHc=;
 b=YkIYvgUxytCsDevCQUiwM7qVZbPcgoy4rMuVvjeBdJ98MsXxFxFmATJRZZRXExwIVx
 Px4MYuklRdErZgesjQHc1lWYoP0prSUGEDC/P5icWz5rpmP+DgLY57k0T3PDgCqI7ca3
 zP1UhOc8ilrh0J+KywsJCBSUXlMV6Hxk0VNdiSPBlnS1FzdYzR4GugRgjOa8rKkqY89G
 1mLOx0o+JJPnaGupXMAP2n5thEZhBQt4xb7mCje2UbaP5AgvYILkE+ZwRYAgDfm0GbIB
 FEJ7VUMNRMfxWGqyu5u3dVyPvaVDBBI+2YKJqfcu6Y3H/oJdgvLMAs9p2nE9a32F93vk
 Qdxg==
X-Gm-Message-State: AFq9FYLro5Ic/P0zHPwxOMIvybGcOuu9Ep4o2rNpL3Vt9FL4mNb/codg
 85xA/Db1UbsA5V/BmHIyFhHcaxLRqcTwcOhgVgFwggbmvV2qR0CDWpym4ZZ9CQ==
X-Gm-Gg: AYBFou3qbU4ZniCBjV85K228p//AzifIhogPI1/2BFu4Qv06fYfNSjAvQdSqBtjqgTt
 kiAl1Qm33HMm1IVKlDLBi0irEC2Dawrl0jpCWTnmmhp4RpB0843Wdn13ZqHAxr6YzezbXMetJUP
 uuDQUO/r07EBS3J56nxkRN2flZt+Gw3aD5x1/iDTvrEzZgcePO50AcpOzN9GxKB6uRb+ThaIRzz
 Nzsth5a25dHavScHgctGJzUfastzbkvbVux0gc3ODhzISgUqcNRFW3XQ3x0iRIRhwx6q3WqyzzB
 xkMmKi1oZBeHJ20d5WnM1YChyxRmsQrLycEO5TgDRNc+Vg0iOioJZz8RVFxEL5WLXvzn90JbTzw
 XmRU5y8DVhGJSzI7/++HrbwI4CrPRMahykguT5H2r4a/HTHqhrg62qUzDFNL57i0t11o1c9eFa1
 NrUjRtp5/Fy8Pleyek+YBkNb3VLvoIrKOXveNzR74j9ET04rwgJSwRAGmFg7o/dZUJm40TnTA=
X-Received: by 2002:a53:e701:0:b0:66e:5604:ecd3 with SMTP id
 956f58d0204a3-672ed2648edmr2189426d50.37.1790395707119; 
 Fri, 25 Sep 2026 21:08:27 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6740ef87db6sm1810341d50.17.2026.09.25.21.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 21:08:25 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3/3] linux-user/riscv: copy the executable's e_flags into core
 dumps
Date: Sat, 26 Sep 2026 00:08:12 -0400
Message-ID: <20260926040812.725493-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260926040812.725493-1-mattst88@gmail.com>
References: <20260926040812.725493-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

Since commit 8c94db0ae97c ("binfmt_elf: preserve original ELF e_flags
for core dumps"), Linux writes the main executable's e_flags into RISC-V
core files, so debuggers can see the float ABI and RVC. QEMU wrote 0.
---
 linux-user/riscv/target_elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git ./linux-user/riscv/target_elf.h ./linux-user/riscv/target_elf.h
index 185b81a2db..e99a9d92ca 100644
--- ./linux-user/riscv/target_elf.h
+++ ./linux-user/riscv/target_elf.h
@@ -21,6 +21,9 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
 
+/* See linux kernel: ARCH_HAS_ELF_CORE_EFLAGS.  */
+#define elf_core_eflags(info)   ((info)->elf_flags)
+
 /* Mirrors struct user_regs_struct: pc followed by x1 (ra) .. x31 (t6). */
 typedef struct target_elf_gregset_t {
     abi_ulong pc;
-- 
2.54.0


