Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A3606A31F
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Nov 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zj0YB9uu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xXDrY-0007QR-T8; Sat, 28 Nov 2026 03:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xXDrX-0007Py-4Y
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 03:32:51 -0500
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xXDrT-0007EH-6X
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 03:32:49 -0500
Received: by mail-pj2-x0a.google.com with SMTP id
 98e67ed59e1d1-3b52896ae66so814157a91.1
 for <qemu-devel@nongnu.org>; Sat, 28 Nov 2026 00:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795854765; x=1796459565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+gc1ndr3PqZ6cfWMBlRIjKNCkftd8mgPd0C/rZq7APg=;
 b=Zj0YB9uusbAhYut8kVKVTm/HQ95LXU40FyPRcuCGtF4gTNDw3QCorrWZxPYc9qxeiy
 Zn3b++efIv16yudLWxsGt3eoq+PtGNzoaLUs5qgo1pFdhUG5eteE3p0FXZB3zAUA44Q+
 CtA7BC18VfvRCMqqTt30my6m0FQbh7ynOp0k+HC/nh1m5cnAJkQ8JbMF5cTG0bGmnzSd
 fshZvmvEM2lX0yp1w8XXBj5lROX/rTeki28DC06mtC1CURfyWG1EKoKJ1TPZHkUiilwK
 DKmJ0zWwzyIUN/KgqpLOGrDlWGmkg8gzrG+O7Oaqf7JlSEkW/WFUtyPq27RTu0lDs6jL
 LG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795854765; x=1796459565;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+gc1ndr3PqZ6cfWMBlRIjKNCkftd8mgPd0C/rZq7APg=;
 b=f0H5GRyJMNCNsRWjqiZakcAcAECYICh3aOLopsCoki2pKWIgahF2OmxCi8a2+2j6mj
 naZ2qTrO5cF8XfuXd04Gw9tjenqfortORfo+7154C221HbfTph0N3tGsk8IykCSK/fGf
 LDewzcWM7lodZTgDyVCxxN3EftGbRyhHoYx4HHb7qn6P1DpxilKCK0814pERJs08FeLB
 b3w4Tn90bu95O6fpaVEGOfs7HrwElMYmgpXgH+F9EZUpreYa+pWX7JKRurjRVDufZrzY
 6zoiGsoeDjIiPKSetVdKHZRhmvLu6VCHzlvc8Oq2QfL+cVCk7TtwfXtl3MbBoHxf4qvH
 DSOQ==
X-Gm-Message-State: APuU4Z/7qKnYjEd4cGaJNbuaQIktKZoMkhXRsz3EF3Sfpl3q5y/RYo2L
 Wte1nCIdJJ+3nxjSfKir/P8dtKnFLNjMReSvBf99JEH/RIyb0h4tIzV8X/g3rVL327uze49QypY
 =
X-Gm-Gg: AZFdTZe3OvPXd4zedy1jQtGnfO9XIM7TrqJ3hLl13w7h2RYtTe1KHvDepUXTIWhG6d4
 bnUV6yjzKekoFXJSsYH/c30VjR/M8iFDrLjjdTRS6JMOqcyZl8OsHVIbMqv8mPuV7FrXEWQyk/u
 62rSrhGTQgG+sgZ/lid2BhkbbJe35nQp+AQ7QAWsKCcNc61IOwTuHsXDjnCokh7mFvG6mtR3O84
 KhjwA5AplyJf7VMXXeWFOyvLBqFX50qMOT92f4AKkEf6WZupH3z0FqDRg2yvQE7h3mjStZgnhAr
 dBZ1SluDrHSSe+h8PbrOPgU80mBpbu8ERQLD4kU3wVK7WHsO/jFxIVGXvKWocxo60QGLbe3mBS1
 L3QwdFc3w6jdL4XX9Xz8JnuTaSFcTq67GGLInTiQmEmhCTEVOMbhgLf8bXh4u9VkAtYR/+ToLwK
 ahdSs9Qy9SkIwcMv2g7yYRtW2D8jpPQg09s6YjlTI88M9mNP8QUnrUxQ90/UpAXz4FnGjS//I7l
 OmXFv805nut9cBc6Oa3dD+oPakNmCy8/QHtmVQoBtLS9v6OlbzhPbGYsUZYY2N9VvyZbuMYHOM8
 GNHKUAGYbR0I3ze2aB2+DbeSafmB
X-Received: by 2002:a17:90b:3ecd:b0:3a4:adea:50ad with SMTP id
 98e67ed59e1d1-3b41c9e46c6mr28227490a91.27.1795854764551; 
 Sat, 28 Nov 2026 00:32:44 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d0332bfsm14410853a12.22.2026.11.28.00.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 00:32:43 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH v5 0/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Sat, 28 Nov 2026 16:32:23 +0800
Message-ID: <20261128083238.1434965-1-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::a;
 envelope-from=zachwade.k@gmail.com; helo=mail-pj2-x0a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zhuwei <zhuwei@sangfor.com.cn>

Hi,

hmp_info_block_jobs() walks the BlockJobInfoList returned by
qmp_query_block_jobs() with a single variable, 'list', which is used both
as the head of the list and as the loop iterator.  By the time the loop
terminates 'list' is NULL, so the trailing call to
qapi_free_BlockJobInfoList(list) frees nothing and the full list handed
back by qmp_query_block_jobs() is leaked.  Every "info block-jobs" HMP
command run while a job is active (stream, mirror, commit, backup...)
leaks the whole list.

The patch keeps the head of the list in a separate variable and iterates
over a copy, the same way hmp_info_blockstats() does, so the list is
released as intended.  No functional change is expected; it only fixes
the leak.

Changes in v5:
 - Use a for loop and iterate over a copy, matching the style of
   hmp_info_blockstats(), as suggested by Markus.

Changes in v4:
 - Corrected the Fixes: tag to point at the commit that introduced the
   leak, "hmp: fix memory leak at hmp_info_block_jobs()".

Changes in v3:
 - Dropped the redundant comment.

Changes in v2:
 - Corrected the Fixes: tag to point at the commit that introduced the
   leak, "qmp: add query-block-jobs".

Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

