Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9845606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ed36dGnI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQzL-0006p2-58; Mon, 23 Nov 2026 05:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xVQzJ-0006oB-40
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:09:29 -0500
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xVQzH-0005xZ-Kg
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:09:28 -0500
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-3b41c8d9767so1790940a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 02:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795428566; x=1796033366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ep2d5wzrMXXLe3jBJ/5eME0n3VU34aiA2qLzli7jlGE=;
 b=ed36dGnIpM/HjOXr36NvHv15id6ZTX7+LC7Z5rS2OM529+59FCwjlLpCOrYM7U0X2s
 JMTAGrQdba6rC1z+dr/cx4I2nhdVRm99NnKcAbWo+eyKH8SmRJoQSnxqWr7k/XGbMwWW
 Tt3RSBw2AkOlmtnUcOSdOPPHvEW9KZepna7ueMBL8Cf3Ce26Od47JwTG/DRP07Vg9wI+
 YayW7i8meFzwoQYD2WGFq2sNIzKWf/wGwNfXvIiFESlp1dNkiq/zCx8ABtXjj2qIqkVR
 mYNnPmuFrz2QA8fskRMtSxNGNEEv/MpwdXPXe4wcXlqXSFZdYSLmH87fqGLNdgok0m9t
 K9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795428566; x=1796033366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ep2d5wzrMXXLe3jBJ/5eME0n3VU34aiA2qLzli7jlGE=;
 b=BMFjpMnciqbb1dhfIo97EotTlFdQQ8IZvQaI2mtOpkxAu/xvQCKY9XQmzMxF5EDEE5
 QlgfmOEJPBoD0SAUxIiCsxirFxPX7Tw6ud+tw1k07LdCp2bXwysk2jB9nlRSTm/FzuRe
 ynXsVX8z6ByzayLglRUezcXswKuGCqfiloIOciW1FdXdwT/YTosfoK57OyDJtYJpeewN
 Qzs20QUawBqfL9PCfhayNPZygJCW93oI0ToDFT9s8j0wDEOlCyLmS3Z5+zRigPmPUx3Y
 AobpxU6s7vUS73NrkQ6xHioZNrN2DvdXfEWljhspIdcc8f1j605Be1RGowExSIRJ7fh0
 jLvg==
X-Gm-Message-State: APuU4Z+C8wnbSNpYWkkqa/wxc9/LBDrMcszXzLAe3EeAiNA7SQfNL7ar
 8KgqL5OlUUclXCYc1Q9Cg9WR42enFf/XBVuiHkXjHRbRGeLNO7YNTB5jB76gl0+k3HYtE8aCa3Q
 =
X-Gm-Gg: AZFdTZfLSPcQd/9qULSFmsAuBtNNLlyudPpbJTyoiB18gsYOvGVh+OU16ZK5WrjxQUC
 NGZUqe/T7HveQZe4nWl0JVoj2IkrFa2iNh1f0dj4I2k/FoPD3cU7kHfiCPLTYI8K83v+FC0PIX/
 pZOr2ce/Z7Nb56gst2qDIJVvD2F4fo8cG3guIHEduImAnRidt79kk51vjhX9C3qgHSxsEFjbkAa
 Cnxs40sr0Yps1YIFhK+82Co0u+kzBc3owxgqJijbBY2CbVkYUIpYgqZ4yQ6gwbYTg7aDLmvVIPn
 sg2VufywT2r7wKJxfdVY5O21S3/YqMPQZO0jBKePv5ASu/hxGOcL2QpxQa+9L3pRihHBV3wXyqy
 nm1Tm6FuL9kkjGYGNSkBofiTKaq+5pPA7Mh3v6un80CUH1qazl1czzzPLNn2c5Ud28LJ+iDTNbn
 loLymZmLmicLusJD+nvQ0CkLcHgnNCZKXXdasohOTGtHt0a6A0GWiV4TF3FYmhsw/Y6cV6vFTcO
 Fdo3nsbkGYMRXgkqS0xmVNHB9iZGo0iPIFoR5hpnJIBjTsaKzIBcfwli+bi4ypexGLRN6aot4ZE
 4HevXrl+UxwAxLJYq0YyVHLhntc1huAhiXtjU2vEAMbbP+6e
X-Received: by 2002:a17:90b:1b0d:b0:3b4:ab19:ae08 with SMTP id
 98e67ed59e1d1-3b4ab19af42mr849801a91.57.1795428566137; 
 Mon, 23 Nov 2026 02:09:26 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b48b41928esm6198164a91.9.2026.11.23.02.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:09:25 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH v3 0/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Mon, 23 Nov 2026 18:08:48 +0800
Message-ID: <20261123100920.2966172-1-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::;
 envelope-from=zachwade.k@gmail.com; helo=mail-pj2-x00.google.com
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

The patch keeps the head of the list in a separate variable ('head') and
frees that one after the loop, so the list is released as intended.  No
functional change is expected; it only fixes the leak.

v3:
 - Dropped the redundant comment.

v2:
 - Corrected the Fixes: tag to point at the commit that introduced the
   leak, "qmp: add query-block-jobs".

Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
---
 block/monitor/block-hmp-cmds.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

