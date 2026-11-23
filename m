Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A3606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mi20Ikhg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVU1n-00066T-92; Mon, 23 Nov 2026 08:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xVU1X-00065V-Ao
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:24:06 -0500
Received: from mail-pi2-x06.google.com ([2607:f8b0:4864:3a::6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xVU1U-0002iE-UL
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:23:58 -0500
Received: by mail-pi2-x06.google.com with SMTP id
 41be03b00d2f7-cde0148b2abso124742a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795440235; x=1796045035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CenVLPlBcdp3GAGiLz8Oz0E3ripWNF96OyxkCYEDPa4=;
 b=mi20IkhgV4QQUz5kjQY1YiQoTHhmXFGuDDIbqDzxTf6AltOP/nOOnbI9aGsOTJY1a9
 W/wpF+X1ch5shJ81YHbdNYBjggHD2YU26wsLb59I3Ikwm/KJzwuc1h6VcWFaO8KiAIvt
 BuENDWsfVCsnRoCm5aowG+/xMLPWvJO51CfA8yfJftESN8+HMIRs4bnaN2SLj+IBu/CN
 LMFp6w8PAmFcmpXuw5tw6pmaqBcfc/PaZuzLchznFKGK0TGtYAv+EVh4KJX/ilTZbYV8
 EA/3pEKk45xugaHzcusRT064iHYtt0xHiQpHYxuLZ5et+L/Abn0eoKH6MRfGxsXwkSHK
 0uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440235; x=1796045035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CenVLPlBcdp3GAGiLz8Oz0E3ripWNF96OyxkCYEDPa4=;
 b=lBh50E/3E3YQn1/4u07zXvpUq0IpMtjfsP/5A8jOYhYkVrcoH6jjcTgjEt5TuYKvav
 XTZIfUhyFbTn7Uox3d+DmvFRnHLLlTJHCcR/CNdBqLgwn2JlkSkvBrOzyHI0S0L7qXnU
 HBR9Cof+g9+zo7GgEwsNEsAKfCZvCNa8QtHpK3Vsu9DjXxr9Zx+nMPchcEQN3lsNtyT7
 IdAAy7x/lWKeR6yDVL+HcaMALdsefFYBz7FJ+wMjKRORZx5Q08/bgA+Nh8P2oIfq6Ty6
 aNvZyQbWGFEGNHD+ajHx+rWdmn29aDWe+EehV9v2MfcUsHWTcnIBITOObAT6Bz8cmbiq
 6KNQ==
X-Gm-Message-State: APuU4Z8hFyKzbRUnDa+y6+FCKLyS2xVVcIcoJsxYdvXuxZlMV6MNJm8F
 tJxBOWo1g5oLfPB/rbcgXv80eQWgKMxz4lZ3R8FmKKpdVy7mHc/Fqe+Oas2pBd2CfbIg4L99a5s
 =
X-Gm-Gg: AZFdTZdwdv1fk8IBYgokhpJ2coX8mFvzWfh8AeaR6s1bjdWwMm4E+NZ2JAAX14onO3T
 Um+64Iw0kjRexTa2ODCRVhmM7Tnz9ir/g+rk8s8lHJ6zosXnDHo675ZiAitb68OaCxzz5eGacfT
 QE3/Wuai9vBoxbbQhybZfr4I+eDMpnJk09g05v9nmKE8wPG8HTnXZkUkva2pmgi2ROr+Dxsk9u0
 KZfBQ0fnQJ2p3TdrLBmsrQrDXw6VBtaF4VeKjjBV0uvl1c6apD2lLd4cek5a2AW46HWqKEYH5J2
 nBy6jYJuPRCe9GcdiV6FBFznARIW36STl/QEktB/WvGWk3kAvZdzdb0Qh86p3ycTI2TsW+VLIvk
 9HKgNWmccEbQ3W39AiqqSIxU19IcP7eD3kYahG/Q0neVi4HaT6ZCDRcgmdIbDYceHS8Lwr6yjiI
 4fX53B0I0QkeKh/U9DgSilMkVrs0EWKoNxm08BcOeH887vJTIkk4H3XNxP7MFALrM37nelYFqnP
 zjvnYVlRkhxFhND2SYAC0ZMHd10Q/5r0PrwLABaExX/ni4eqDd8OISmAOUgSRY7j4BI5/HmG/LH
 mAwfhE227gNiSGF2DJCG8Oj1Kog=
X-Received: by 2002:a05:6a21:798c:b0:3fa:7d82:5e9b with SMTP id
 adf61e73a8af0-4014c25613cmr10251460637.64.1795440234584; 
 Mon, 23 Nov 2026 05:23:54 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87343f83dsm5588710b3a.39.2026.11.23.05.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:23:54 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH v4 0/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Mon, 23 Nov 2026 21:23:41 +0800
Message-ID: <20261123132344.3154080-1-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::6;
 envelope-from=zachwade.k@gmail.com; helo=mail-pi2-x06.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v4:
 - Corrected the Fixes: tag to point at the commit that introduced the
   leak, "hmp: fix memory leak at hmp_info_block_jobs()"

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

