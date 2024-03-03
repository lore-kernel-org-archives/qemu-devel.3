Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FD1C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgjRD-0002Hj-GX; Sun, 03 Mar 2024 05:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRB-0002HG-VW
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:22 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRA-0001rN-UV
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:21 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so3291781a12.1
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 02:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709463079; x=1710067879;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8euAnCNzIztjXeyNg7DMouGQMP5MoiXBmM3i2w8JTRU=;
 b=ZUm6bv9Ule0ReE74AFoPw3lJBh4DV0hIeJxnqJuJxYy26LWAaNpaM9nRCghFIkiMDl
 PK4AbXV9Cdc9VZFsmzZpkwTe20MIi6XzP5W9ugObW5adg7EsH6ZRm7ZzFwhVjrBjOx4B
 NICCXWG7bWkZEA3tw6nCT1eFPXv3ZEml40KFWJNCTT0dqy9brmaa4DO4o7DtD6cSa2P2
 /E528hlwbIQQD30/WSnA7JuvRcCokfFGTEFnL4WeEVrZMN7/WF5BMcI53dAra+xLsAOW
 Zqrd+M79KRz9Oy9TU/aHX3Zehbvfkm4+37N2KflYD2WWdCs/c5uI2L68cjQehLol3nCV
 kJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709463079; x=1710067879;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8euAnCNzIztjXeyNg7DMouGQMP5MoiXBmM3i2w8JTRU=;
 b=vjX9VBYXXlVG6WOgrSHTZ439CB75vl7clD5W1/0XHsqh8/7i3QcRkkrm0NTzfWsLyP
 NMWyyqyhApgrrlIr/+gVqrEx7TSj5Y3HQuEYrr6/v7mQRYZsh4AW8rRgach5h0qDl+Uk
 GD42k8otkeKXxQhzsW+d9l8ptaOHUStOUAZfBPpMm3Ox1V/AmtaErgekXIdVoarGf578
 viLjAWQBh1kFQUysErnZYqY++gi9Tj4cC9hZRZSyxb7MTISt3YfDmAVjOIBWV9A6qCGl
 o0LSkLcQOhpRktx7Hq+OwXGjG+Pg713WweG63puGi91KG6NAAwFoGJIKVGA4mOuKryPn
 Us1w==
X-Gm-Message-State: AOJu0YxINmdAAYSO7Z1IxDyN+ME/yCPYdRbKWrKFJ7nfMZmFOKiSR3ND
 JvpNJ9lUryZ3KH1fIwTuK5Rfrq29ETi9y95Wi5ue3m5Qf6nd01gKnZ5ssvbLllib1/on9O4u1bS
 c
X-Google-Smtp-Source: AGHT+IEZ3rXPtNTO69XiXPFL/qSa5befnHTK0lTbNn4rLzlPG+lqYGI/QtXFCQoB4Yq+8kZguo9y/w==
X-Received: by 2002:a17:902:f681:b0:1dc:84ab:95d with SMTP id
 l1-20020a170902f68100b001dc84ab095dmr6947426plg.45.1709463079469; 
 Sun, 03 Mar 2024 02:51:19 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 kz16-20020a170902f9d000b001da0a698095sm6456090plb.282.2024.03.03.02.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 02:51:19 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 03 Mar 2024 19:50:37 +0900
Subject: [PATCH 3/7] contrib/elf2dmp: Ensure segment fits in file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-elf2dmp-v1-3-bea6649fe3e6@daynix.com>
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 contrib/elf2dmp/addrspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 980a7aa5f8fb..d546a400dfda 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -88,11 +88,12 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
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


