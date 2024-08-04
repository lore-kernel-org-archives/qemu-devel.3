Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3243EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 16:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sadxE-0007gI-7E; Sun, 04 Aug 2024 12:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sadxD-0007c1-4W
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:19:31 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sadxB-0003zH-HW
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:19:30 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso8422299b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722788367; x=1723393167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHTHS043ONomxfPa9ysU+tp+4KLPG11Jj4l/rfnVUkA=;
 b=GqG2EecVk6BJpYOlcGtAaW7UxUtWfuIQNadXNQIN6pfEe3my/vEusnAQE6znBkkStS
 jVnLcMUKPxzjnzihV952wPR3Dx8x2F05VWaZTFS2r/HPZH9yz7oh+3ShXx2Hi31/WNT7
 yM6nawSY9xHC7XM+xKG5P9crTxcImr5PD5UDRZj9PpR7qEGIknPgt++JKRE2Ftqd6ksX
 hLhS9nTFWYMqJiQsDG64EpioYpEkGBOGRrNl+xvBKvGW8FYqwfGrKb2fI4WExHSZHGMD
 qPeLGOb1ZRO9k5Eixdo9IroGQkLD+HOQqu5jftF2OTf1w25skEZ8i5k+5AcsEZnCo+iP
 /dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722788367; x=1723393167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHTHS043ONomxfPa9ysU+tp+4KLPG11Jj4l/rfnVUkA=;
 b=MBwx6Kzrpg4NgczvEyLBD+xF0MjFdJWRluexzUthuNzNWyiIuAEzkT2kAuowXfJTd2
 hgikZ2OJj3y2ryuOGunbJ97sCwbBWN4DSJZtxl1Xh6xkVz2ybH5/hm3XiM2sm55FipDP
 c0l4lXEqC8GvHDm0jeMk9MlpAG+IEm6vdUDvoMSupwpy1Pcg16y1Nr/LNoFbl6uCVTPz
 u33jO1ZWKkUrwjXc572nML0kC1rf0VW++iuo7x0Rw9CDtYf0+Z7xMDcEoXjlnGkEbb3s
 gx264IQuJnkh2xsyjekPPO/sRMm516mGYxNzqp/+xBFIzHCURHhSiqR8JIr1mIwHovkR
 sg5w==
X-Gm-Message-State: AOJu0YzIJ/P0du5oLd7K01w9z86E90Frrm0i43O/kR6HSNyY758scKpU
 yfZ0N80iUshuR+9VgY1CgGVSz/Hl1dfZczSLzx2+WQuQs3ZTkNKCdr/iScpR7Fg8TMvt8cnc6eN
 WT2U=
X-Google-Smtp-Source: AGHT+IHJBUY9Gt+w8ibRn3yrh6cakP55szXiGQDXm0RlkkSTSTy7YiA7L3Xzj26CYAaHCoUMSKVLWw==
X-Received: by 2002:a05:6a20:1588:b0:1c4:986a:ddb8 with SMTP id
 adf61e73a8af0-1c69966b784mr15241167637.43.1722788367621; 
 Sun, 04 Aug 2024 09:19:27 -0700 (PDT)
Received: from amd.. ([2804:7f0:b403:720f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec4169csm4117530b3a.64.2024.08.04.09.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 09:19:26 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 2/3] configure: Avoid use of param. expansion when using
 gdb_version
Date: Sun,  4 Aug 2024 16:18:49 +0000
Message-Id: <20240804161850.2646299-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804161850.2646299-1-gustavo.romero@linaro.org>
References: <20240804161850.2646299-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
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

$gdb_version is now used in more than one conditional case and its usage
in such cases may increase in the future. Therefore, avoid using shell
parameter expansion when using it by setting gdb_version to its final
form.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a3aa257fd3..97de85d710 100755
--- a/configure
+++ b/configure
@@ -1103,8 +1103,10 @@ fi
 # gdb test
 
 if test -n "$gdb_bin"; then
-    gdb_version=$($gdb_bin --version | head -n 1)
-    if version_ge ${gdb_version##* } 9.1; then
+    gdb_version_string=$($gdb_bin --version | head -n 1)
+    # Extract last field in the version string
+    gdb_version=${gdb_version_string##* }
+    if version_ge $gdb_version 9.1; then
         gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
     else
         gdb_bin=""
@@ -1673,7 +1675,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge ${gdb_version##* } 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.0; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.34.1


