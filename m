Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB359CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVxz-0002Ks-97; Mon, 11 May 2026 15:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxi-0002JM-CM
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:43 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxf-000869-LO
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:42 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso2521059a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778526398; x=1779131198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmY7F2wQOdNNHZqSlt4US+jGj2nBqRNa2RTnZ8QtfS8=;
 b=biEBbcIwZfTer1QnlsrC8+Z0bQJ7FzFuOyBCZBtCQXoRVDqKsdyxb4gyyg1GXzAtqo
 d6IX3ye+MGxy2f5MN7NeC5qHcP19RVsz9HhDce0gt/RwmKusuV7sb/moAxlaDOlv/j++
 3QYZ9RK2ihb06A915TR/CZSF63eu40iXjEOiRR/auwVfvslf1HzZGqUGc0spkEPeyBqy
 a7T5pcXbJtCYgRX5bvtnceJZKSvSO/JrtwDMQKAJ0vIEKR6OGYAoqPB/JiuIqJwID+Nc
 OOpIXXv53MUsG96L/A2XFFpGxKzKNW5duu+PocXGgx18LXLN4uVjP0Hqblmi6V2UYA9Z
 mfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526398; x=1779131198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmY7F2wQOdNNHZqSlt4US+jGj2nBqRNa2RTnZ8QtfS8=;
 b=pGmX03k/Mu3lYMGVdw7XtEukRboqpg3accgQr608dMAtefyTYqyyVHhIybvQTQawt4
 N++2n5ka6AGMZfvTBy3JLbpDNA32vHdqyYNx2FloCP/1gNcVSWUTU+P4uD2wDafMTuPt
 V3A45qxJgBBxER98dNUbZQzQk1oJFyQDyljyMSDJqi1HIyp4r+5ipdxEBjAzzjm4CpdM
 BsDGciUzn5dHCl7tD8XlxFxMo543v2uAa1XPIaEZHLVkqPMt5LIkd/Rn3CE9pIeKa43s
 NVQKdQ/wCz5/snx5zANZgCX0/vnRaMdgBiIVkoQUnuC71sRtwvzrezOyK/7N9WA7Mi2t
 hPVw==
X-Gm-Message-State: AOJu0YxO0bSTDyx5rsSvp+Fifd4o1RM5uwpztYsocntLdD7eoSiYVsw1
 Z9dU9PzegBTranYgCvU0iMptS32k6Mxubs7b9Tn3mwAXarpjtTJDS196m8Pu0xtUGAROqOvpNnn
 n8/9a
X-Gm-Gg: Acq92OHbrkbvpDDoApXGArV7SzYKlXjims/DWumMKbfuUIi7qzMYRGIw+yM3ZmQEmDi
 XnXxdEDMi4Kxo/zEY0Y3bTErW8YA14VXtmXZl2ONXxNjQ9cZkBWFUmocrYhsnHhrkmEYYDKxSAe
 1vson5Lc9sGcDi6dbI/UyYG1mLETMV7l+nBC8WkWqfeGVhxcX3wPlyLV03pSAyeVVggO+W3AV6B
 Gqsb9go6xL99YdhTeCBYfNW6RTmrWelyd90MrOoz+dtWV9R+/WgTznzZtMNvkbsyWLeFazQgm8R
 ZhjpDMj4Ny5a3vPcExA0Sry+XZn+iWMmQm445M/NG6ADf6XpIUCJbeWA8iMM6vpIstyl2ECQFuN
 JId+amy8lkHAIIwaMuEEZs0YiF6nsp0Han1EVH+Kjv4A//OXvhwdocZnaySXT7KEpbNJj/GJdWe
 Ftho19WQUgzY/LXRBZjj4PGq7fS9SnvLPcuJzips8ff8Q5xA==
X-Received: by 2002:a05:6830:6d48:b0:7de:a17c:3716 with SMTP id
 46e09a7af769-7e1df13142bmr15848868a34.28.1778526398248; 
 Mon, 11 May 2026 12:06:38 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm7157011a34.23.2026.05.11.12.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 12:06:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
	philmd@linaro.org
Subject: [PATCH 1/5] meson: Build target-info-qom.c with -fno-lto
Date: Mon, 11 May 2026 14:06:30 -0500
Message-ID: <20260511190634.472174-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511190634.472174-1-richard.henderson@linaro.org>
References: <20260511190634.472174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 5fbdc75a0f..9a804dc810 100644
--- a/meson.build
+++ b/meson.build
@@ -3852,20 +3852,24 @@ subdir('system')
 # without lto, not even the alias is required -- we simply use different
 # declarations in different compilation units.
 pagevary = files('page-vary-common.c')
+tinfoqom = files('target-info-qom.c')
 if get_option('b_lto')
-  pagevary_flags = ['-fno-lto']
+  nolto_flags = ['-fno-lto']
   if get_option('cfi')
-    pagevary_flags += '-fno-sanitize=cfi-icall'
+    nolto_flags += '-fno-sanitize=cfi-icall'
   endif
   pagevary = static_library('page-vary-common', sources: pagevary + genh,
-                            c_args: pagevary_flags)
+                            c_args: nolto_flags)
   pagevary = declare_dependency(link_with: pagevary)
+  tinfoqom = static_library('target-info-qom', sources: tinfoqom + genh,
+                            c_args: nolto_flags)
+  tinfoqom = declare_dependency(link_with: tinfoqom)
 endif
 common_ss.add(pagevary)
 system_ss.add(files('page-vary-system.c'))
 
 common_ss.add(files('target-info.c'))
-system_ss.add(files('target-info-qom.c'))
+system_ss.add(tinfoqom)
 
 subdir('backends')
 subdir('configs/targets')
-- 
2.43.0


