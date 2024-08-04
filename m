Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A902C52D70
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 16:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sadxH-0007s0-33; Sun, 04 Aug 2024 12:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sadxF-0007kh-9a
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:19:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sadxD-0003zN-MJ
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:19:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d150e8153so3185920b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722788370; x=1723393170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gd5hFcFNPsqwaztOhKEC7VMI0bS3FH3SbOXvjsB2hfQ=;
 b=l/RukABMKl+MP99ytKMTdPm93C70lw/FTOCaSNVdt9aToucWianosCO+1Wf7qIZCdV
 h+YLSmDS8vphB57VkAk6D/kortr9oldlUoqz4gH7b4i5Ibyyea8r1wA+BrOQSal1Irw+
 InFbEliW3RO+rZ5FlJOWnzIOJq0M6B6i0oYkE6yGLv61SGMXtYUdEKlvtPtiaVWcEsf9
 j1UqdvBIbLB0wUw66VttrxnDTxMbgZwK50DKYaSbNkC83otwxTnucF9Fsfdzf4jMSpkc
 albXbw6lfr+d6bpRbTMrMh2De392W/Gt2d68AQ8U4wiR9yB0McXZgKSwiVri36hY0oiY
 lA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722788370; x=1723393170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gd5hFcFNPsqwaztOhKEC7VMI0bS3FH3SbOXvjsB2hfQ=;
 b=cLETEKPsxNQM4P4q6piXC8UwllMCHzfoZE3Q9iHD+PEkuGkzupzUmyUxT1+/T37503
 efp1If+UeP5vloBI7vvCEwnPOlp3Sq7JaU++IhfL65uE3zeo7ZXR+IvaTvoi8iJ//yye
 yMquBut5EfVVp39v5YXdfqp4AUjzTfpDJx4ZTZOmkV72hq0RKZq+E+Hv8gm5WhZ1UO+p
 EPJ7OljMwM0fuic3gH9szWz3WHer8yXonlZlH3jvzu+uXlcM+UUP33k8nK33mkXJccNd
 axXXfuonuI+pc93LFJK8NxOjrUtgnPqu0ehRoMi53Tceucxea5P0yYCb9Trr7aPW+Iqj
 u+jg==
X-Gm-Message-State: AOJu0YzaZEvrCn+UsKdSwBFd5ONuQHbo+ER7G9EWMDaR3N7K4lY3XfGS
 9QrTmbGlsF0t5BCq21A5XcBnlJXZJHkHsNVGHti5x3JghYYFlVOv85Ii3Y1FsSreCZLoySOP/3+
 g3tc=
X-Google-Smtp-Source: AGHT+IHzjzr7Pq4rj39vdONXW3iPeuU+TEQnvXOucBN3GIevlnazt2KZSDPgGb8jZ08cy8cj0MtXww==
X-Received: by 2002:a05:6a00:9491:b0:70e:ce95:b87 with SMTP id
 d2e1a72fcca58-71065b6f08dmr17562128b3a.0.1722788369810; 
 Sun, 04 Aug 2024 09:19:29 -0700 (PDT)
Received: from amd.. ([2804:7f0:b403:720f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec4169csm4117530b3a.64.2024.08.04.09.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 09:19:29 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 3/3] configure: Fix GDB version detection for GDB_HAS_MTE
Date: Sun,  4 Aug 2024 16:18:50 +0000
Message-Id: <20240804161850.2646299-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804161850.2646299-1-gustavo.romero@linaro.org>
References: <20240804161850.2646299-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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

The test gdbstub/test-mte.py requires a GDB version that supports the
qIsAddressTagged packet. According to GDB NEWS [0], this packet was
first made available in the GDB 15.1 release, not in 15.0, so this
commit fixes it in configure.

[0] https://www.sourceware.org/gdb/news/

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2477
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 97de85d710..d08b71f14b 100755
--- a/configure
+++ b/configure
@@ -1675,7 +1675,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.34.1


