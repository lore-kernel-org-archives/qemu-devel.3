Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D0ACA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBzwg-0004R1-6K; Wed, 30 Sep 2026 15:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominic.plunkett@gmail.com>)
 id 1xBzOv-0000p7-Ss
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:51:33 -0400
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominic.plunkett@gmail.com>)
 id 1xBzOs-00080g-Vs
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:51:33 -0400
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48882c1f2baso1840269f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790794288; x=1791399088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z5qLeOY2G7RNIauWgxn2GCHdV5Z4xLWEsfOsvx+wKs4=;
 b=waSZU/DykI9koPW7MhbmHtD1DEVjhulQoBkFtibcuXGb0r3tUurE+C+HexPL/wd3tW
 MlAYu4fspLYW9OGYgijinIgoQsR0LH0cQRW27NHmJleOK0+z4UNlfdUGDZaj+SKDTDrZ
 Bqq/lb3nmOew8+YnHDRi4i2z+9vuojBfmejITc7CC0cpgeH8TUW9Bnf3U9fsetxqMWrV
 NP/8vW8mf4q6PQPOV9jZf4bRXTZ97AKYHajEZKzSwjW2X3bi5eWLBX0fgggvnV/kGsDV
 SAYNbUCmSsANUX45I5P/v4fZZO622ChZE42zKCK3YFtAN6/2mM396uinsEe2J/0Sin6k
 kFjw==
X-Gm-Message-State: AFq9FYIytxDY0ES3pHl5Bl5PP6sdshf5rWfTuIJdjWgkb8FH8jq9BEix
 O/rNLzSBdRmM22klLqmHFv/+XKqslB07yZACZryNpy+bzZ3nNkTZmcIFhpMTAPw8
X-Gm-Gg: AYBFou2BVTA8KX8lYt14gBKtW+AbgDJek8lF7wKD8QyNRgdVmCYQaAlEq3FjhRTVgOo
 1ORXnaB8Qe43eZ42zBKXEyR1rFGLUJ26Jgcq/3O0xvtjffR54P6jRW8NswSJs+X1zjm1uufEiYr
 itrqo/ehIpy8aihA6TWtXFnCH6EP39zIrQE6FesAYYOB2CO6NNp4gMkLCnUcWmkEz5wu1HR9Dzs
 U0M95D7wv717R3gqSdLgTWOVwCfm93AdAqQtyL8kzKa21lRU/Sf2YyPVhQLFITRFVrGjbA5ExlZ
 YYJjAYpjQQ3RNZETrGgPZd0r825nNetDIr6ZhFV6QLStuXRf2+v0BtmN9L1YtAakgAee1y4WMSP
 733GMj92fQZniPWqwsZWh9eAkeh/HLfALIAzwIGb4fnbxcapy+yWOOsC7mk0LUd75nKsKcN/Px0
 KqZrw37fjW4liSzUNP7XZF0/BNFSyThnxy36gkFSJmm40JqeqMcaf2u/wb
X-Received: by 2002:a05:6000:230a:b0:48b:515:f94 with SMTP id
 ffacd0b85a97d-48b05151156mr1966979f8f.51.1790794287814; 
 Wed, 30 Sep 2026 11:51:27 -0700 (PDT)
Received: from tower ([185.182.52.52]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff96dsm1162790f8f.8.2026.09.30.11.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:51:27 -0700 (PDT)
From: Dominic P <gcc@gcc.dp11.uk>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH 0/3] tcg/optimize: Fix s_mask for rotate by constant
Date: Wed, 30 Sep 2026 19:51:21 +0100
Message-ID: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=74.125.225.99;
 envelope-from=dominic.plunkett@gmail.com; helo=mail-wr2-f35.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Sep 2026 15:26:25 -0400
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

fold_shift rotates s_mask for rotl/rotr by a constant.  For I32 the
INT32_MIN OR in fold_masks_zosa_int can turn the result into a bogus
sign mask, and the next sign extension is dropped (ARM sxtb; ror #1;
sxtb, i386 movsbl; roll $31; movsbl).  Patch 1 handles rotates like
5fe51606146 handled the logical right shift, patch 2 adds tests,
patch 3 builds the test-i386-opt-shr test that the meson conversion
dropped.

Found by differential testing of GCC output under qemu-arm.

Tested: make check-tcg for arm, aarch64, i386 and x86_64 linux-user
on 9c88811b81, 312/312 pass.  The two new tests fail without patch 1.

AI disclosure: these patches were prepared with an AI assistant
(Claude, Anthropic); each commit carries an Assisted-by: trailer.  I
know docs/devel/code-provenance.rst declines such contributions and
that checkpatch.pl rejects the trailer.  I am sending them openly and
leave acceptance to the maintainers.  If they cannot be taken, please
treat this as a bug report; the reproducers are in patch 1.

Dominic P (3):
  tcg/optimize: Do not derive s_mask from rotated s_mask
  tests/tcg: Add tests for sign extension after rotate
  tests/tcg/i386: Build test-i386-opt-shr

 tcg/optimize.c                     |  7 +++++--
 tests/tcg/arm/meson.build          |  1 +
 tests/tcg/arm/test-arm-opt-ror.c   | 21 +++++++++++++++++++++
 tests/tcg/i386/meson.build         |  2 ++
 tests/tcg/i386/test-i386-opt-rol.c | 21 +++++++++++++++++++++
 5 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/arm/test-arm-opt-ror.c
 create mode 100644 tests/tcg/i386/test-i386-opt-rol.c

-- 
2.55.0


