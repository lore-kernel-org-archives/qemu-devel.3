Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D4606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k/ttNT5x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKS3-0002wP-8s; Tue, 17 Nov 2026 09:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xTKRZ-0002ue-Jv
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:46:05 -0500
Received: from mail-pi2-x0b.google.com ([2607:f8b0:4864:3a::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xTKRY-0007wY-5l
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:45:57 -0500
Received: by mail-pi2-x0b.google.com with SMTP id
 41be03b00d2f7-cd693e0942bso1262067a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794926754; x=1795531554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M2c87rC0eKg0YcAW0LWTJsk9v+Ge4vxJJOiIV6oGOIk=;
 b=k/ttNT5xKS/CcqpxQ3/35mZk/xrMM4gKqg3jdIkeJ15bIMIvJvb2beNXb/gLEob2As
 +f3dMYF7WJ6iap+CNQwxpYjLakugKDAzWjEz7Yu2onkmuL343P8mf2cZ3clrcR16x8/s
 ekbPu2bsUeof1cNREkHgtD6K/5Fe0qETx8IesI4NmX9AuTDlNJ0FWv9YCADwMBGpo3Ht
 K1CzNXREKs/y8Zpr71NfiXunkykNSS8VVqFUudqsSZK5mqNzkkXr2vjriMCTqji3fDym
 +k5k/b68RhOC/4Qc34u33ctQwZ3gLC9m9f0hF8Ga6mQVWBymvvImjCvNUHdcTBhglxZb
 KJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926754; x=1795531554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M2c87rC0eKg0YcAW0LWTJsk9v+Ge4vxJJOiIV6oGOIk=;
 b=v1rZ6i1X23qnDe41NEqAiqb3w2cFgkHVN59jr4Gs/Hw1R9KZiYtl4m2XhX1deo3dbc
 ksSHNjaWyAYQnqbAQLx/dHyT6Zpo4BbSmunaTVpxVGStQpjlr7sUtJh4J19eNjh7WiOi
 +mftgrnHKzj0z8FZ5eIOoY5Vku4qunLptelCXdRIKrPl24b7kyXIu/QOUG6wEHiNAaEV
 Xuj1TXQChzWU1yWGiDn9OSD9IJWeZk3An2U5FfSD8NQJ63vjdz192eAK4PoyyHiZpZNP
 cqCKYHF4Z6DaoKB6u4pTD0Jgwc+sxC4HW5vAmZR9krqzCGa2fnrX/F7AilHgwfCLhhdi
 I67w==
X-Gm-Message-State: APuU4Z+HTiKaYb/y25tJUYtj68NCLTr667FcDGAOwrEfj6sYZfN9zhou
 VNJM7Rbw/DIVjr50UucrfyH+zWdONsLmSVEhMan9XcT4w5fDM7QA+QejFja4RAAFA5xHl/qh
X-Gm-Gg: AYBFou0x20ax9MlV9MiaOmheCtxuPpBCLZglcrOKypjHWVw91FzQeaiNSDPQOt8Z2WK
 lcx1N4klsNg1NySNQAegp1zhpZpmX+sSjGSWJsOrWRsNoOE3vg1SlH24SBZPyc3NH9DZn4yJQTW
 hZ/55j/qrQrky1UZjfbdHkksU1kejhgMgE85F4ySPrbnwqLgKL1zn2zbbMHdogLoKcpX5XsKD0c
 UR2H+W/ZfZ/6yTKY7Ebe0UB2n+pACwLqzej5FaG09UxTI5sHRriTFC/ZEm15dIOnsTHNAkDPG1W
 iUmErWGuB56DIuj1813VXUziJg/dO7S2QlTFSdujOr8hGYYKll+0SZvsLv3tMvczjTUaqOt5NUI
 1uTYE9eLeqkkO5/NQSQYXAdP5f81nQ4L2XPuldSo22R4lVQU25W0c6lMmgzRDn+l2ahsPpjjnBV
 2kqrjHnGIKqSnKV2xlgLQANhQ4i2VN87T8alcOzKTI0A4Th9nuIJl0K4a4E+y/wEG2EfXEpFg2l
 uUYtWzXo8rJI/QMnHZowHa2ImdOCWIT9hH6riI283oEIhkjW/NSJtJnC+XbC+ndzIV8Ho3WELss
 nZvOOiP3kjNs5eg3oJsD1JdH0/8=
X-Received: by 2002:a05:6a20:6a22:b0:3fa:df2d:d3cf with SMTP id
 adf61e73a8af0-3fadf2dd8c7mr7371879637.14.1794926753655; 
 Tue, 17 Nov 2026 06:45:53 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde150b8efcsm1244776a12.2.2026.11.17.06.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:45:53 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 niming <niming@sangfor.com.cn>, zhuwei <zhuwei@sangfor.com.cn>,
 "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH 0/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Tue, 17 Nov 2026 22:45:47 +0800
Message-ID: <20261117144548.3252867-1-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::b;
 envelope-from=zachwade.k@gmail.com; helo=mail-pi2-x0b.google.com
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

Reported-by: niming <niming@sangfor.com.cn>
Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
---
 block/monitor/block-hmp-cmds.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

