Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F8AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 16:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sadxC-0007Zx-Mf; Sun, 04 Aug 2024 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sadxA-0007Wl-M3
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:19:28 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sadx9-0003z2-62
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:19:28 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5c7f23f22so5792012eaf.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722788365; x=1723393165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PV3QfiL0bSdPt8jTZc4TMiZHEwd17GiN9hOOMRggKrk=;
 b=zvw5EZMdMiz1BveuQ69h+uT0JekxRXHYtbZNXS7Q/QHTiNRY298/xAdrZNNaYNObWc
 G97YNOP3LvxAltfGI+GSLWEH6ysh7II2Cxi5z9dMMEQ4Iy9aUtqc2z4wHgWyV7ky8Rlt
 RRwlLa48MnpCZTqyQWRDlEia5eBqT1K+NCqzjj2bi3dm0jIv922TskbpCwWsaKJkBw7F
 zisb8PBx9+CGp6wPj/fUCqPhrgdjWoqNah0JQZHpM7q4L4P8YpN4M9Br2qSkJ+VPYt7U
 jOWWs3eI85SZy6qx0edA9dF6HGzj7CppKKq5EQi8giAIASnjlSte/gs92edQ38A+quws
 4mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722788365; x=1723393165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PV3QfiL0bSdPt8jTZc4TMiZHEwd17GiN9hOOMRggKrk=;
 b=epj1zg0SNaBIp5zPdjQydhqpRBhlRC0eIMCOPVaRT2nFBhjo0nblydNInyuJ38YfJs
 HsLFPerSpGUcJpgo9V4XMYzThObhbDJCn8lM2iGea706wjmyjlarD/jmRXTI7yrhjIPK
 nBb7et0xNS0XicK3mgrnyPHN2Bw1buBtLsTsLcJeNc8bket5YUPJuQyX3VWXaD281kz5
 QhPSwhWc0M3uvoNaA/2CFdxpEWz/zdY8zL56h6Y7udKRXlhaa6LyC8OhEbZGMQH+8ecg
 +0TUWLSuZTE4HhNxTS87rHInonGV7hy0xc9ggNV1fLpm9W2vChPddayVs/21mNxAlOHp
 vyLw==
X-Gm-Message-State: AOJu0Yz/p3rMqNgKYNnBT8kVjyK5FX6lZV0ZDVNESWlLFhVE4ejJ51Ey
 u+ALcT1c+u2d9Ens75cgA2VhONEYVsiW60Ml51Vf2K8VFlUq1GaHO2Pnr5QOqfWpJ0LpmusjT5v
 ckcA=
X-Google-Smtp-Source: AGHT+IGVXHopNcNwQsnELjiKXZ9zWm+Tb1k0YPBcuB0eMgQiSdXH2A0ifbMBjamx6DZxZaZVSF1YHw==
X-Received: by 2002:a05:6870:1718:b0:260:dec5:11cc with SMTP id
 586e51a60fabf-26891af7211mr11404927fac.20.1722788365432; 
 Sun, 04 Aug 2024 09:19:25 -0700 (PDT)
Received: from amd.. ([2804:7f0:b403:720f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec4169csm4117530b3a.64.2024.08.04.09.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 09:19:24 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 1/3] configure: Fix arch detection for GDB_HAS_MTE
Date: Sun,  4 Aug 2024 16:18:48 +0000
Message-Id: <20240804161850.2646299-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804161850.2646299-1-gustavo.romero@linaro.org>
References: <20240804161850.2646299-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oo1-xc31.google.com
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

GDB_HAS_MTE must only be set if GDB supports the aarch64 arch, so the
test if "aarch64" string is present must be against GDB-related
'$gdb_arches' variable and not against '$arch' variable.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 019fcbd0ef..a3aa257fd3 100755
--- a/configure
+++ b/configure
@@ -1673,7 +1673,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${arch}" = "aarch64" && version_ge ${gdb_version##* } 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge ${gdb_version##* } 15.0; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.34.1


