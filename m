Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CFCECE577
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7da-0003fI-Dn; Sat, 07 Sep 2024 22:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dY-0003Z3-UO
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dX-00053D-Hh
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:48 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d88c0f8e79so2548009a91.3
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762406; x=1726367206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWk3ZOhTNIHcodblpY60Bu/bdWzkAkFjFWEaQMye1xc=;
 b=y1GqD8ewkU8svjFKjFFXHQvlbwMd5GFSbS/Nmojcj1NEZwBgmNk13DjPTbQx6W3w5t
 t5rGn4Dt2swSXgIXt1sPr/yY+1+/Xv6L8hb69vmRHNrlyIPnKwWfchJ17Pz09n0QWAjE
 2ohByaNpCU3B5nksn4ATSfUjxTFOTtv9Rs/ZoOWxTgQRav77KnC4jeL2TZGcmEHI4CRr
 8iSnaIa82hGKIMIaPA/rSA/xnFt19K43gbECQg6wfD1ViFDvBRnqzIR+cQ4ZARHa+SZi
 2YV0kG6Sql5ZJqCh4E8KFy5xI2PzeFu7MKQrZvffmPWpebMJQXzHqpOEIgR4z0HGMXC9
 9VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762406; x=1726367206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWk3ZOhTNIHcodblpY60Bu/bdWzkAkFjFWEaQMye1xc=;
 b=aHpL2sekS94MEXYLT+i+MWvEDUlGVgRXAvCaLnDCyT9X672WuwugVqAdF7Zkzr2dU4
 88NBAOQ5UjRRo6B87VOsMrTpM37fbev7hfvpe4vLgBOZ3WfmMfmCUn/om/0LsqhLw2cN
 X9BG1R5c8FpcJGbQlHRZqhQUlcIIyl6q+y0Ieqvyb9o8ylSQNmwhoQS/HcMLAlZDcF+h
 RB5QxGtQuzmUC3QrelZPlGbx/5BMY/4CTvYwmrwsxbV8qV8dXx1ULsJ/nBv+IxuFmgpz
 flQ/C7KjMLoGVlSjn5AOUi2ESFGaXXw08SZRV6ASpzjA5eMoFHmjJ3sanXgzLXRaKNHv
 AFtg==
X-Gm-Message-State: AOJu0YyOX9s9p5KJtfLyXP18IWGRvJaKvsng2Zn91jM4Eae8mNN1XsqO
 hHwFW0qHIA+/fMTKHLJoQK/sBv7rgSEunmMgnJ/VAtEmfedJfwI1wxxNYvcFk833GAnXXhFoPuk
 P
X-Google-Smtp-Source: AGHT+IH9Ke0y8ADDVleX4YZLLhJKEG93+ZkxsVhb0yKnkUNeAIv2wkc8bdvSFbDSP9ttTVr9CeL64g==
X-Received: by 2002:a17:90a:8ce:b0:2d9:dd4a:6a95 with SMTP id
 98e67ed59e1d1-2dad50d14c6mr8341590a91.25.1725762406167; 
 Sat, 07 Sep 2024 19:26:46 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 11/12] tcg/i386: Add predicate parameters to tcg_out_evex_opc
Date: Sat,  7 Sep 2024 19:26:31 -0700
Message-ID: <20240908022632.459477-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Extend tcg_out_evex_opc to handle the predicate and
zero-merging parameters of the evex prefix.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 839384885b..2a3ae28e85 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -674,7 +674,7 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
 }
 
 static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
-                             int rm, int index)
+                             int rm, int index, int aaa, bool z)
 {
     /* The entire 4-byte evex prefix; with R' and V' set. */
     uint32_t p = 0x08041062;
@@ -711,7 +711,9 @@ static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
     p = deposit32(p, 16, 2, pp);
     p = deposit32(p, 19, 4, ~v);
     p = deposit32(p, 23, 1, (opc & P_VEXW) != 0);
+    p = deposit32(p, 24, 3, aaa);
     p = deposit32(p, 29, 2, (opc & P_VEXL) != 0);
+    p = deposit32(p, 31, 1, z);
 
     tcg_out32(s, p);
     tcg_out8(s, opc);
@@ -720,7 +722,7 @@ static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
 static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
 {
     if (opc & P_EVEX) {
-        tcg_out_evex_opc(s, opc, r, v, rm, 0);
+        tcg_out_evex_opc(s, opc, r, v, rm, 0, 0, false);
     } else {
         tcg_out_vex_opc(s, opc, r, v, rm, 0);
     }
-- 
2.43.0


