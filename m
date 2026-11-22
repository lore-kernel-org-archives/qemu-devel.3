Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230D606A32A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EnL+Lkbc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAl7-0001mv-3g; Sun, 22 Nov 2026 11:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl3-0001mJ-FL
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:41 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl0-0001Va-Mc
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:40 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso372856866b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366177; x=1795970977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/aSJIx3ot6ExZBZBw6/xlGpv4+RCnGlvY4fSEJbV4tk=;
 b=EnL+LkbcG8S4+B6RvhDW1r3HUnar3EBk+uDppD+eiJ5llfdjCSJYE79E9L1IxiOYeI
 cMsIGBfdxo2Un7tnsPGTivh5Wb1BU27AbAEnKM3GCuIKRqxP2h5uoCxbR87lxhVNjyg1
 JAIpUIqJvAV1CzWKnjq/RRujnhXHKVX6TWhSg5UCp+jd68b8jsOijdbIeQYMI72NwfY+
 Ec/cmrc6JZXPKMEciGZJweh4BLsEv0tP4qk57EsT16Ffy2QdlCNKsqakOivdCF6GJ/mF
 mNq/2tQaZ35EOmnL6VwAu1jcfUoyyi5DlBfd7GYr/ni1x3Nx8KI4t0/Jqd9CzcAeTETu
 XxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366177; x=1795970977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/aSJIx3ot6ExZBZBw6/xlGpv4+RCnGlvY4fSEJbV4tk=;
 b=H9XnieRsBC5H8MerwCikdjBm8ruhP2FWAF74jlmVgV2lSW8y7BHDCSm3q905CL37nk
 lIC2H3ixBI0jvGWvwT5bwQWMCPagc0FNA35J74iTpaZhhw2M1xmI4m9mj342zygBHEg0
 QuzF3Br7WE4iXgTY0Z4qAlZR3ypqe37cEAnbURsdMBzLURbTTjaxtayhS8aQbJWqxV3L
 7r6FA9jLlErMRg85zd7WBRN9LQnW8CO9UyliZdsNgBboB2giPwmYJ31j4N71wZlfiHX4
 NdJjx4mEVRmGMcqZOBv1+iqGelp8KwXu0mNzAxNsWZi61VkSl/vhfioTAAayCQ2Vx96R
 9bQA==
X-Gm-Message-State: APuU4Z8gOnXrxrKmDEC83ZQ8YHG5QvPgmeZ1qMBw1YXRJHiAvCzPr//I
 T403+/gtJ4W2ES26n56yCmlOjoaSF0Dttwl3DCEMzteGbalIOQFNQf5dBgjPzVb7
X-Gm-Gg: AZFdTZfdk/6x5mMuTfECX1cu3ABBfoGS/73+U2ZwW6rfFdiXexU2GHTD6YewSWNx3JJ
 rJWP/1pRR+w8OoGLwMEPnAVSuTddIbXYrJLAJ634TXnHWnlEcFMNf9/VFkWAhGbuGKbSGSKuzqU
 pcjrRY2MS/veezkzz90m0QAbTv5DRFTR++n8hGX9dNCn8lgpmmTLAOVPARqnOtwZ/M5wjqeWI8q
 K7sLfOn1PWraVNSwgfNmYmZId3pV3w3o18y7hPtfnnR5U8yq8kDI4/lVKnJYChov1tyMu+Xth69
 ZBTPFoXEXRW2K9P/jCb2Oc8JCP8xXNsNh86nd/bshlCaKmECly3c3D4M7GyuxsEdDzKbQ8Jxs09
 ZjUFZeVECVTLyoiYhae5bwSBwUYzea1S0sa2+BT18UqCvccJJHWBV4JYMZseyclUdK+JxWsf/cg
 nZSbUqXtZlpTX1krJBCz4HACVk9LqrOdZIkkU9zI26RxfJodoqBcNYSvD/NPVNUvmXMySBm3Py1
 PaocolXfjfuQFixnE2vD+yz8QFeqMdo4LY6QPhq75UjcVSrodVtxaiosSgrJVfZMltsQx5gWjwG
 ZsYDkH6dhaW0Hy5H9PCpJFVrQEVPmoOG2lg+Md/hxVdhkTMEBWks/pXprG6z6WIiJEVVgJqdcFP
 6wAhs0xYdC7CsC3F6Ud+h/Vap5e59GKGxUZ/5GbE=
X-Received: by 2002:a17:907:f812:b0:c50:d92b:6f40 with SMTP id
 a640c23a62f3a-c513a88a6b1mr697217166b.20.1795366176678; 
 Sun, 22 Nov 2026 08:49:36 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:36 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>
Subject: [PATCH 00/10] fix tests on FreeBSD
Date: Sun, 22 Nov 2026 17:48:55 +0100
Message-ID: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x632.google.com
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

Roman Bogorodskiy (10):
  iotests: use gsed instead of sed
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
 tests/qemu-iotests/145                        |  5 +++-
 tests/qemu-iotests/149                        |  3 ++-
 tests/qemu-iotests/162                        | 14 +++++++---
 tests/qemu-iotests/211                        | 19 +++++++++++++-
 tests/qemu-iotests/211.out                    |  1 -
 tests/qemu-iotests/296                        |  1 +
 tests/qemu-iotests/298                        | 10 +++++++
 tests/qemu-iotests/common.filter              | 26 +++++++++----------
 tests/qemu-iotests/common.rc                  |  3 +++
 tests/qemu-iotests/iotests.py                 | 16 ++++++++++++
 tests/qemu-iotests/testenv.py                 |  2 ++
 .../qemu-iotests/tests/migration-permissions  |  3 +++
 tests/qemu-iotests/tests/mirror-top-perms     |  3 +++
 tests/qtest/libqtest.c                        | 13 ++++++++++
 15 files changed, 100 insertions(+), 21 deletions(-)

-- 
2.56.0


