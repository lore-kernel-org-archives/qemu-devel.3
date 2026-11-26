Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFA606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nauU4nEm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejk-0008Rp-M8; Thu, 26 Nov 2026 14:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-000821-R5
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:54 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej0-0005C9-KD
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:45 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c4d28f75d62so1199596466b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719700; x=1796324500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HOBX6CFbxJXHtm6YTdQPP7QmlZ2onfxZZP/ccFmOoac=;
 b=nauU4nEmdL+H3gBxaFEDtj8FjEZOcRHM4/IzIu7cMLbnK9qwLKhTcFz+rnDKCxFOIY
 DuhCvSbcKc2mooQryMaTxE6bUOPxA47+UWBgKeS9NpGQ5uds/EayzK36rtYP0c+xXiuG
 WM6W/mJAzXnL+T22ReyluYd7KDJxrNUWxrplR2tUvaOclgm/RxXG6HAzPJAIl7ULQEY5
 BbuZqYtEkBKNYeHwFNdE+5D0FgUzb1zQq+bYMVQZGnLy9tDwp0bP+T/6HAkhEIC1w5II
 wZoiZoRRIUBz7YPMr+vc7VO5gV0h44c8BbMEOAXLgd+4DV6VQQwrFN73B3HyPTCw+f5K
 rYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719700; x=1796324500;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HOBX6CFbxJXHtm6YTdQPP7QmlZ2onfxZZP/ccFmOoac=;
 b=doF+tPF9cw+6YycTb1uvpxBaxo4QdovK2bzkiiBbgwr0gcZCf2tJ29OGfGv2khsvLj
 aXGrpKSgQeI0r0e1xWB846yvCKlMFSeYChqF3eyFFzgN/IGvipfpbVEh0HSx3WHrAte8
 gJmhpjz1HQRx9udEMc6QWFX9tQ40PG4Gs/KlatrhV1Gjuip7tSXrhfLF3UvpEuxBDfkv
 QrSvkE9Lkptef20fEyqqQrE69nPiHT79Ksd6tQ+/Hr9C4W5S7UDKOzpfB2xUkZ3/vaqw
 pGgkLspCACtqEXt0d3NTD1/423lv4O963B3HB+jScIvduWj4ZILB/pUSgo9dx7wvDsOv
 3Q5g==
X-Gm-Message-State: APuU4Z/raWj2BVGoSu86yN0fKBWTubWclnzSMbCVqFWgVmwTTgGl3mDb
 mRa2iDe0ff7u/Pk1Vcrd2P4QLR+3wTfJgv/J3gwjSL2Kesm/jv3Z45sz1KcCOFjm
X-Gm-Gg: AZFdTZepx12VBcj4YmsUgziU1Zj9sNZKnJUd5kQCB1fruyYM4u9tR7ckLK167YSd7NI
 9xZMZLjb3qW/DcYByFlmoYxuwRN68dmy6bYIdHGRLjOJ2Myu0fUhoYEa76p30wANa7dYvIx9aAh
 IgOqTVvE0xjfcFwLSkMpWmeVYNDPnuDDlXQu3Sn3il/0YTmBxTksHacB9X6og5mybhfb6WAZJto
 5iBZWT9IYmqENnf2OeZsq2g/Qqejo+lpNw25J8rpzLzwi8fWTOYeAF82BH0fyhJrRjy38Smhr/w
 Gie6lo8l835BZsWaTC8DHZWiU0r5ccsp0iQKN740EBViE3ePw5CwlK1ThNqO+EGSUURmjVfpYmZ
 xoMHdhzCvyqu4L45NbQ2uER3KWRRVLJUqYu2mDTNPn32z0RjOa5ivy5+ivx3vZb66xuBzroqyMT
 oE+02XBUFlKd5rvXmeGkeVdnHxu2g33eHpvPz6Iy7kA+NghddBJG2jJBwcLsL2eK+7TMf9d6Om1
 WnSDdra83iBdhWDu7Lplq7D2oUw+VzBrZq+eRE1kNi0/NJTXozwSPF25oLf3qtQk9kzCJToqN+n
 toh9EtpWV25GCT+tzs3lQEKfHBcGNcF3DDDJ
X-Received: by 2002:a17:906:f5a5:b0:c51:29c:4b4e with SMTP id
 a640c23a62f3a-c513ac9f072mr1849214466b.37.1795719699414; 
 Thu, 26 Nov 2026 11:01:39 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:39 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>
Subject: [PATCH v3 00/10] fix tests on FreeBSD
Date: Thu, 26 Nov 2026 20:00:43 +0100
Message-ID: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62f.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes test failures on FreeBSD. Most of the affected tests
happen to be iotests.

This brings full test run from:

Ok:                1253
Fail:              72
Skipped:           669
Timeout:           2

to:

Ok:                1343
Fail:              0
Skipped:           653

thus, a successful run.

Changes since v1:

 - 01/10: use gsed only when necessary, not everywhere
 - 03/10: use more general "status=noxfer" check for dd
 - 04/10: adjust code comment

Changes since v2:

 - 04/10: add explicit <0 check for setsockopt()
 - 07/10: rather than converting FreeBSD strerror() to
   Linux ones, cut these OS specific messages completely

Roman Bogorodskiy (10):
  iotests: use gsed when necessary
  iotests: fix default QEMU_PROG on FreeBSD amd64
  iotests: fix the dd() wrapper
  tests/qtest: unset socket timeout
  iotests: skip preallocation tests if not supported
  iotests: mark 149 as Linux-only
  iotests: fix test 162
  iotests: fix possible race in 145
  iotests: properly skip tests that require OFD locking support
  iotests: fix test 211

 tests/qemu-iotests/115                        |  2 +-
 tests/qemu-iotests/145                        |  5 ++++-
 tests/qemu-iotests/149                        |  3 ++-
 tests/qemu-iotests/162                        | 15 ++++++++++---
 tests/qemu-iotests/162.out                    |  6 +++---
 tests/qemu-iotests/211                        | 19 ++++++++++++++++-
 tests/qemu-iotests/211.out                    |  1 -
 tests/qemu-iotests/296                        |  1 +
 tests/qemu-iotests/298                        | 10 +++++++++
 tests/qemu-iotests/common.filter              |  6 +++---
 tests/qemu-iotests/common.rc                  | 21 +++++++------------
 tests/qemu-iotests/iotests.py                 | 16 ++++++++++++++
 tests/qemu-iotests/testenv.py                 |  2 ++
 .../qemu-iotests/tests/migration-permissions  |  3 +++
 tests/qemu-iotests/tests/mirror-top-perms     |  3 +++
 tests/qtest/libqtest.c                        | 13 ++++++++++++
 16 files changed, 99 insertions(+), 27 deletions(-)

-- 
2.56.0


