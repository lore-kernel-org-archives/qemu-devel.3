Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D3606A32A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N8xy40nz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV64B-0002nY-SP; Sun, 22 Nov 2026 06:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xV641-0002la-BC
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 06:49:00 -0500
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xV63z-0007ow-JB
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 06:48:56 -0500
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-3b41c8d9767so1419747a91.1
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 03:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795348134; x=1795952934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NlltqfSF918VBEnqSoMJ0QSzdpCKGXq5A3Tqeg549ms=;
 b=N8xy40nz8lKModVyjUVF/Uxs53NBrSGlJHYceoJ5BAUeS5LhsGoVmii6mpy7ycNf/g
 4tTcFX8zNg/5o57Bf09H5w7EwnlDhPhTt7y/A5ny9cOBB7JhU9NaP4kKlnAxcN/rfzKx
 9JwTo3J9njkRSToggykAiK6ZYWxNnixqQXCNM2N4f5dTUbaLM+wuU7G/XYvYEjNvzx4Y
 Z9OukOiyKVBoRvdmhrURQwCsQiPkQu7JpfVJMQWDUs9aN+Ux73Kuwei49MvBQKLaP1ea
 MpAMZtZAZ+LqBaGhixLZkAvL+j6yraoUnSwhDvqLpXRKs0RZu44MmGm4eM+MSR+8wGoM
 yrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795348134; x=1795952934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NlltqfSF918VBEnqSoMJ0QSzdpCKGXq5A3Tqeg549ms=;
 b=EuH9iOzg27TNp3DIqlpLjoBXeUPwPX5nh4viugLBZAgxIqXlnJ9mHgaakbKwvN0CKb
 ZZuEToJPtrRrZGkmpm1S+eZskMjoMm6DUlNvlAY5YZ6XoKrTuppP0SHdW5CL+Y680f/i
 BC4iHTZNi04IX9Stxtfv+b4hiQoIuPGR7fib8DJ2KilljyIz+62iSllXuM+T0vUMwrSR
 BfJsNyzv9z88Dw1ImFnnsgbYwhwkcd3zxtZbe3eISuMAE3FwiccUBVVTtWNKIHWW6wuW
 f96b/usFLsSIgfV8WNFmNosu41BA2msZZa/ouJ/snvH1r9MEU5PmUcbOlf6gBgAzFiVd
 +qgg==
X-Gm-Message-State: APuU4Z+OehaMoqd7i7n4hTLsE8fkDP/1IICTRUesGt1YcUR2KjnOEWP3
 BfycqpN0wT4Zsczb4Gh7cf2YWx25QaAsthK4a5SSbqmZY40c23NKD9POq69YODjZpCQ=
X-Gm-Gg: AZFdTZc5HBljcInVYhjISloZc2gtJk4ytOVz9vd5MS88ZcFlt1wHthIzscPLcafBr4c
 SLhRKqcAnBvN8U1tHVtwOLiCpDrxI8qocQFITaMQK1rWYautinscIh7G2APxNlNhU+7gYNQWv+H
 mIpk/V1ru8+GFFRJanWxaLRA3MHvZ3YAOmtu0D9Er+vKFhDH+NyCV6QMkFFEKsfuEoo5W8cA4Xk
 Q12vXAUNvr91AeBByqHAB1gqvEUOrIRtyL6CWg08JnLnwm/NSMsDYcSyqybqpzyCT4aj1lwzlBv
 P+t50cNzwQrasDACwNN1tKs3YL8ehfgXTxnfRkCdFGITDqV3++2qH9WSCQ1hd++3Z1bVwU9V9qH
 b8hlL1nHex+amfqdR8IgXjv3O4idHcwWDz5bLI/V7TybicW+AbDRFDdZ+CsNYXD8EO9PYPONzBg
 6o0O2QL9Q5992lxvwhgIabnV5lBNVhvV1HBkGJgAH788chx5z+9qE1NasDNULrJfdcZDOMVBt2f
 rkZaIGpD5W3fv0o2c3VpinyV8y3TU51Jc6q8GD3h6wpC1ok6pZ4PCCNS/uGEhHYsjutobA8K43I
 miqib7ibC1j1GEVkF/h/dE+Qs8A=
X-Received: by 2002:a17:90b:4a92:b0:3b3:fd13:683a with SMTP id
 98e67ed59e1d1-3b41c995b82mr8237349a91.59.1795348133665; 
 Sun, 22 Nov 2026 03:48:53 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0b52dsm13698947a91.5.2026.11.22.03.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:48:53 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH v2 0/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Sun, 22 Nov 2026 19:48:48 +0800
Message-ID: <20261122114849.1672198-1-zhuwei@sangfor.com.cn>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
---
 block/monitor/block-hmp-cmds.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

