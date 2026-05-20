Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C666CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZK-0001cR-5F; Wed, 20 May 2026 13:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ7-0001Sa-IT
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:41 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ2-0001xo-4Q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:41 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36643b96b99so4823898a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297514; x=1779902314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTV+CLBxiOJvwZGNE9Pre6H8XgUGreJTp6/Amr+aefE=;
 b=vzfMCNw1cOejXQQ9hFqdLpu52Rvb/WaoYpSkDdxxNwLz9i0K3x+45eYbrbSY0e5MDR
 /SwBAEENf0+CFmw8LjndpK3yicorehGOD/aURY43Iv4qWIYGdEYmp2Wr+jnDOJKarhYq
 UYmqdktTtp8BQWynPeeCoIc3nZyB4DZJ3suKr2kyJzEZQSHwtnZ+L5+pcjdJ8WrAii+7
 DLlCBVCoC3vzui87YS4oAEpIcW2MwZJ4YhB71mX/HbU6EL065EOWNEiGMWxyZDiz3ii6
 NK94bRUqoW5HXU6ep6D9lK0rdt95+scjzMqnclPHsCpxCAOfM6HlHO6AlGEXjlJGGaQG
 ECGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297514; x=1779902314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTV+CLBxiOJvwZGNE9Pre6H8XgUGreJTp6/Amr+aefE=;
 b=RCckdGfkqU+t6Wiftyq61lA8JEIz8UkoC5do1SCz1q13Oo9gYoD5aVaBULwnHh0ZkL
 710ieJ2DlohT7ucaxdIzjCKs77cVvW8sn0rbcbLsJRNmtfOayvEvZ68Djl8VRN/bF3mZ
 WFCmtf2OtESKk69X0UGIarMkvH5tTTvxzySWKWUAXWLWiwMSCLnYA7P5mNdMZAYDTGdn
 X0RjQ/WCXz2keQbjEBA4wRSKCm67AotairnXIYGpF1xIIFUNeO1XsBHQtBp4XeKVumyn
 eWeBFqb5XxKDCwphfj6bUMdyYW34Qjg5MSUVKMkMM33ewtB4jKmcUVk2KMHEpOKpcTaf
 DdcA==
X-Gm-Message-State: AOJu0YzRmldyL27c8XIGjwZDes4NsUBpAFi/GATGIgeZsyGzGuX/PKY5
 /udUAEgfhO39Ii0LPakHAFqPz+jOlXE2AAcePOuglQ8nxEsHcn1K1V9nrm6ZssBp/EqIengfM5a
 MxvhHJTk=
X-Gm-Gg: Acq92OHMMvRI/5Kn155mcki+XFmB2s5nwgteT1Tq0Yn1wLLbldbjyeRcd7367HKqT5r
 XIjzluhUyVLi34RbuYRwekV2/JFmeLkt84Lar2veA4OYMVXo04CFdNsOHXAFPyI2IiL82Z07yLp
 Y/JU0TPQHCFcBnk+3sLSzgpjggCE+AdMrFvOrydytarUGc6/Vz1ZjmXVUi66M+6vVPk+M0yxfWD
 h1FhzwhSBTlzbNW6LVIFnU7GPffuRkqQ/25aSMgBpqwdA8TC4O4v6/pOhh46Qn1Be3erENby5l6
 qsVmFKPCWjMlvpIXN9iLxBDsYB14eRgh9yTJAEWwxrs/xpIbnGyK/xxChDrzZIbQMce7CPmeLId
 llPppujgz9PxJpKuO5qt9mJhPlSxS0vRoo+p7iML/QQK5ypumLrbImTUzOQzkIS85SszIvDFrQJ
 BNOiis1mLv7O80Ntmf6NxiOjWCE1HT
X-Received: by 2002:a17:90b:4a87:b0:369:d22:4788 with SMTP id
 98e67ed59e1d1-36951dc3ebemr25948746a91.25.1779297514503; 
 Wed, 20 May 2026 10:18:34 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 17/30] fpu: Use get_float_2nan_prop_rule in partsN_pick_nan
Date: Wed, 20 May 2026 10:18:07 -0700
Message-ID: <20260520171820.848839-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index fd3e79fd3e..f40a950b41 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -53,7 +53,7 @@ FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
         return partsN(default_nan)(s);
     }
 
-    switch (s->float_2nan_prop_rule) {
+    switch (get_float_2nan_prop_rule(s)) {
     case float_2nan_prop_s_ab:
         if (have_snan) {
             ret = is_snan(a->cls) ? a : b;
-- 
2.43.0


