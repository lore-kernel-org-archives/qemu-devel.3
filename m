Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBB606A338
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Orwfu5Bo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIWk-0002Xj-GA; Wed, 25 Nov 2026 14:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV8-0001ad-1n
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:56 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0002IR-IL
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:53 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c513a854320so144190866b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634265; x=1796239065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SjCBFXPEPa2n7DTqPPWuC0cHPQc8UHQfnWzummTxEAM=;
 b=Orwfu5BoEqSfhw1AR7urkw0hhuxX+BxVEOv1suyLLS4QsQpz03ANDvbuQBBEokdp4y
 PadzjnLdAoR32LMGnA+W1CuVhKyARUpoyzFNhx8WvPlmEMEEUkL4jRogWiU0uTekdb/P
 duZ0GKi5K9Nv7mS4xK3Mi02ZQIcmWu+c/+U9m0TO0LipYIUYrRKsgOxZyVLcBPcq2/OV
 RmHfWV7jg3waIfPpA2FOBtFzVcMacTkkfzXFDw65NSuEebFCpJ6c9ErEE0tkts//nCrx
 xf5YP9g4KV8ZqrAlZOV6Z/a6VJfzqPL5Ww1I6kJj8n4yh65pkYJzLGoQJZRLKjZyx5IF
 vXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634265; x=1796239065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SjCBFXPEPa2n7DTqPPWuC0cHPQc8UHQfnWzummTxEAM=;
 b=SaA50wtHHtyghHZu5XFXMFehc+iXSQSBRTEXxTF5n/7gJLwPXfD+z57zVDcdXQ4VRT
 kAX9Y35kxDk3aixDXkxYrUgdOf0z1L3I0B0yX0kSp1C0SA9hzUIf7zj5FQIp7NuEswqB
 j0xZdTbFXj+MVNoaLeRJ//zeIRwLK/hPwKFxBn8G41bjWZAaJDbAtFuoa925/aUQlDQZ
 yCt7mlCPz3/mqAHJ3fyB29FW8g10a0fksLeEalHWGoJ23fOL7h5b2bqJpHW7dLoF2Cwb
 f9zAcJWTtsacZX/kJrKGAykCsPqMdIysOR5cf20p6HwQEwwrkUyu3C1Bw07FzXs3ykxJ
 6mTg==
X-Gm-Message-State: APuU4Z+CAOgQUPaUDw8QBoSoTgsYrwsHYcc+frz34v3TGXDrPS4nX+xO
 iR0a3UciZO00YidCjPAHXnGoajzd2GufXM/aKQFSejaiQtgs41GKCQzvxeUzekqMbs4=
X-Gm-Gg: AZFdTZcypDvo3Ek2ma1auD77GfbOUwWY1twvi9Y38KpezMkRrgA43VcE6G9wq9J30Dj
 gkhALSSxxwOuFQgZxZODPD2dQeLsiNIIUEojPT879dBh/cY4cygup3j1r7P053aju6WeTppgDp0
 TtpEV1fyhd3oCnDJWzinqo6CDhAe3To0lB5CkZGUg5hHZuOqzKM2KidiK/VQWa1hCiZFr+oK764
 0X9hbEdbKjDlE3liIlz+NWO84kx5uTjfpVHgNCmRckp5P66/WNnO82KQYTRnvXPrJNDZdQb50V0
 R7oW1KUFpI2hEbuaMbOlxK0CzLAJfuM4mmF9oPtiAywrerGjGYrAx7lNM+/8OAdXnVGdpRSzYZd
 LP1im8Ko4xTMLO21Op3xlFnK+ZW/b5Zll0XisLpgFUslgvcsDdsvFR/OiIJTv5eUqX07yCg/Wi6
 G6A8x6fdPTYelvrxg3B6Wi3Iad3scBJSIucuAjSB7KPtOS30tWQZ/yMdfHzbgo/LAFU7rNCKFPI
 w7iTFWFTjvSKkyvr3uYneeB7Bn/ELQCXBd7NDnmTE9xL2D4eDJyDR2/n6FnlqxZRlt16h+Z/4jc
 DrTY5zaRq+SndBmowkCGzjKeejrpPlagaOfERymLaXQYgSsql0Ku+vMYeU12yBnZeQjDCcqn2SK
 3y1yDoNoLG6LHwW1hyVbMKjnSmnCLgKEw20Hinh0=
X-Received: by 2002:a17:906:6547:b0:c50:6005:9133 with SMTP id
 a640c23a62f3a-c513a84f2e9mr1229839066b.8.1795634264674; 
 Wed, 25 Nov 2026 11:17:44 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:44 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 06/10] iotests: mark 149 as Linux-only
Date: Wed, 25 Nov 2026 20:16:56 +0100
Message-ID: <20261125191701.93931-7-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
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

Test 149 requires Linux specific dm-crypt and cryptsetup,
so mark it supported only on Linux.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/149 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 6dff39a28a..7b7afbd539 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -404,7 +404,8 @@ def test_once(config, qemu_img=False):
 
 
 # Obviously we only work with the luks image format
-iotests.script_initialize(supported_fmts=['luks'])
+iotests.script_initialize(supported_fmts=['luks'],
+                          supported_platforms=['linux'])
 
 # We need sudo in order to run cryptsetup to create
 # dm-crypt devices. This is safe to use on any
-- 
2.56.0


