Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E5DC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPI-0002qN-HV; Mon, 13 May 2024 03:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPF-0002nb-SC
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPE-0001MR-1h
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-420160f8f52so3883365e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586450; x=1716191250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNBogQkAhCPuNJXeM44os2k6SzPQFDH25UufdeGcgDY=;
 b=fqPb4JBNn9AkE9sD5LasSmWmhOAvcCr79udD8f1GULMGk53DuqUtSafjkFkZVRU5r8
 Of5ClKe8ocgIAkB/nxMqRcMS3SJQX+xB+ibaxRX0+NdUyy8DKLvWbzxD6kCr+7OTWjUO
 zPOeyV4i+SWMzz7Nzffp7j98CdrdaG0lgNHqr7cjKJoZBTwPR6EDTzRUdFTQfHz017Np
 49Nln+tOuju3JIAf/9B1qLHaddaaYTho0VIdTL/z2rX1SddNM4q16SsKQemWvDvczm6Q
 2ty+RC/d8o+OhpIHqY8N4HV/Q7OsiNzan6Qa35jP0RcPcAxaKgqUWrWMB/mOjnhWacSE
 /Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586450; x=1716191250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNBogQkAhCPuNJXeM44os2k6SzPQFDH25UufdeGcgDY=;
 b=NxTNev9/kWqa9ltvvsf90aYhWX6b0+1lWANLyLO5RfWi+R4BfcY1xU9mY8nHYE5/yz
 NlXCYk4XMrvS/i8XNAozENAfh4+R06IBhxPhPBK/SBiKe+HRf8lnZjfwbGA/REI2m6o0
 bpD+6qpaBHaPudNy3K5CDRe+xGCciKyBVijE6FIwvkToFBZ/dSBuUxnU3peTUeLuGo5/
 DXT/WItwUspMpY5F5+F6qhNVC6BY0A8BuVIGuiuTF+9hW8u940zHv6CTcl9Dpb3OREPu
 h+RM8C6XYQUu0VUAqpGmbgG8aGAv/7G08Eqt2orlRQn1uBZwc/YhZLftWBwoqoMQI4aL
 0SKA==
X-Gm-Message-State: AOJu0YxFqY6IFaGsyMC3rVCDJ1QdF35mmAf7j7AIiXALOFEvA/PEj5Al
 J9P8iVI+8koHrn5HtDRYtGQtuaRzxm+Bz6VfM4iRMWUeZMzlGosTdHScTjIJ5XLKVoc2pjLDZ0F
 pqeM=
X-Google-Smtp-Source: AGHT+IFq3oye8xPiD2NZHqnoa0BmhJennWaDnc0zf4Uzw44F9ZuKp2OMJayd3iQVEFOAdwqauxlM/Q==
X-Received: by 2002:a05:600c:3b26:b0:41c:73d:62fe with SMTP id
 5b1f17b1804b1-41fead7a82emr55008395e9.41.1715586450705; 
 Mon, 13 May 2024 00:47:30 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 16/45] target/hppa: Always make a copy in do_ibranch_priv
Date: Mon, 13 May 2024 09:46:48 +0200
Message-Id: <20240513074717.130949-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

This simplifies callers, which might otherwise have
to make another copy.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 22935f4645..f267de14c6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1967,18 +1967,17 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 dspc,
  */
 static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
 {
-    TCGv_i64 dest;
+    TCGv_i64 dest = tcg_temp_new_i64();
     switch (ctx->privilege) {
     case 0:
         /* Privilege 0 is maximum and is allowed to decrease.  */
-        return offset;
+        tcg_gen_mov_i64(dest, offset);
+        break;
     case 3:
         /* Privilege 3 is minimum and is never allowed to increase.  */
-        dest = tcg_temp_new_i64();
         tcg_gen_ori_i64(dest, offset, 3);
         break;
     default:
-        dest = tcg_temp_new_i64();
         tcg_gen_andi_i64(dest, offset, -4);
         tcg_gen_ori_i64(dest, dest, ctx->privilege);
         tcg_gen_umax_i64(dest, dest, offset);
-- 
2.34.1


