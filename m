Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D08606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T3JJleXy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIWB-0001p8-Hk; Wed, 25 Nov 2026 14:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0001Yw-Ok
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:50 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIUy-0002C6-M3
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:47 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c51a02ad3acso178913466b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634261; x=1796239061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CXVVVAsJgGgmmXgnyIeylm0E2XTN+JpikTOKxqPHqXg=;
 b=T3JJleXySMMn1q5U3MF/lISPJ5cxPnRQuBMTsVvGsQC+VypnT7bNQZlEQwEnvR6UEm
 bY5QGXxTzs3go+034aWg6DlV5dlneVFahqQ4GwBQ+ZHfayxdvDVnt6EotgnUNrSIkK4m
 i2fv2CtTKI5joPtisvAZ9l3wVRCkEvKXdw12Rk2/FUbtKjh5imIp33zGWMVW0YeNTr4n
 45Ha9OLlCrC2qJkGL1aeEbygE5r3w0aRlllHVW4VHYgL6mzJhYPdvCe/qCScopSss+BV
 oMSjUr2CV4NI+mY1DAYtKmxtc5dfguCLvU73pI+UhJ/xXCfVXDoE9ajXcaEFgNLoXxnm
 FaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634261; x=1796239061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CXVVVAsJgGgmmXgnyIeylm0E2XTN+JpikTOKxqPHqXg=;
 b=p6aAlgDBm7idcfjnwzGYk1iOHXWIoWRhBo/q7LmaAq/J4l6D2WV4vqVk0NSAgmfd6p
 gNsa9mYfavMgvwJGehcxeiuzfI3TwuI9CAuIiKkbKvO+GBgkr45xRVdqa8ArWdDMPMHa
 uqV+TiMsY/YewAKPd13dBMPKxpd6nnKJqwOmisSfGO95kzIJli0fQ4fEBOGNO/Y/rB26
 gg276ZIlMDEl0zlJu4w6v8rdbM/ZVch6AAxXcxMtnRaw6HIjGdpyFZR5WTagvrjAw706
 3vPoZIj6uF8mTNBiK3ZUjdf5+pLy2dNJbQBA7OZo9mm+mHGe8EpAT6clAbrqQ1p+4MCd
 NhAA==
X-Gm-Message-State: APuU4Z8yKoJVpeBDQQUtdYA86QANOhLbQI/onOf7FGd0kJ2vvkWNsP2F
 sn7Bt1zBZi+RifvqaNxfQjliPrQS1fQrsxivHT3Ucl3U/LBMhjbS1qN9BXM0aKtt
X-Gm-Gg: AZFdTZfPUSXpvEbmcpIW6sjbjGSCnXPIPHGSDzBmJfhDF0yuwhiT+5enWsE6bt4ZLZY
 RKR/rOAnmaaWM/6ZQ8+UwJtqgqwORM3wYdYZYpkysMbzB/eDpd4GSryiK2OEW1VNDFHc88irDtl
 uqnPArOd4lbh2BKC3Oqj9PQymt3TDKYXSkiMdhk9M7G/RBjCwk4XP7ctJIqNXjg2beZhTLNb1/u
 s5SvQnJt/XjtHxcdeFXTZ7u5hUt24YO3dnTG3QZ/ilo5+kYY5R3G0olhHzeWmoCzYaZzKmoT0Qz
 gwQ6DC2PM/zCtouUJFCRBkcMO65LCTC8NuLWI9sC6y84fNkXuM+19262Owzxe0WHc77b0B8R8bq
 qUCg1hivZHTW817yyXD2sqOSugo5esQzuzNuEsYdheMPjRRsxY6DpxHBqES6Eyf5gfSDdoYiz6N
 n3QUWXQ0SYQmWdsAFusQgf7dGLLTzLdQl61h7LtQeEq0lMKcb7BmNaqYp8UG4l2IbfGRLIHozHS
 LJ1ZbKZBXsYuPbY0sj2NmkK3HMca0xiWcLuaiXthAOfU4kdsafHjC9eRobtZtQ5+ukYLMy6VYsP
 mdCjIrXMVmfPsmYTYS+vOnwtLOXKfYoKKWs1TN2AJjU1fRJIWA+UFO6MOjPMkNFq76cBUXJti9r
 /+jL4Jq469Ob4Iis08RmeMLM3UpNO94v3NHc+/p4=
X-Received: by 2002:a17:907:20e4:b0:c40:9b75:84af with SMTP id
 a640c23a62f3a-c513a5ec7cbmr1177389166b.8.1795634260633; 
 Wed, 25 Nov 2026 11:17:40 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:40 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>
Subject: [PATCH v2 00/10] fix tests on FreeBSD
Date: Wed, 25 Nov 2026 20:16:50 +0100
Message-ID: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
 tests/qemu-iotests/162                        | 14 ++++++++++---
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
 15 files changed, 95 insertions(+), 24 deletions(-)

-- 
2.56.0


