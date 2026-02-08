Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637B6EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 06:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voxpx-0000QI-7R; Sun, 08 Feb 2026 01:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1voxpc-0000Pl-Cx
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 00:59:41 -0500
Received: from mail-24420.protonmail.ch ([109.224.244.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1voxpa-0007Ut-4P
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 00:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail3; t=1770530375; x=1770789575;
 bh=TwyJA0ynE+zwbWVHEw2NWdp39rt/RvC9XMk5dogbfeo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=0l5NI93ycNRXDftoT8cADAEb1r4a1Z0ZxOcnpoQNpA2q5hUUhS2lYd2CU0/hH4giG
 6ZPk1Pry8SPqvF68ia9Xq+Aa+AIhuGoaZiRXvQpPNSrBtcZKginwUzMIjyvCV/rope
 ffP6BMysYIwryJWb07k+w3fm+muR9rN1CQgN+x6y3b0csjGKmZXIC5sBqi0RBq5YwL
 Ahneth0icKa735zrWCKjVpRcFL1XvaPPgfJD+G6iQIy7hz4SFMcqCMPWuwkWNbg0l7
 ALjFu9e/8saMyAa86GvAwGR2Twc2kiJelx1/2V0oNKkjPiM1iGXPOyGYOdzltzu16P
 xAgRO12EUzObQ==
Date: Sun, 08 Feb 2026 05:59:32 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v5 3/5 qemu] tpm: Add conditional to not compile ioctls on
 GNU/Hurd
Message-ID: <20260208055858.2166524-4-damien@zamaudio.com>
In-Reply-To: <20260208055858.2166524-1-damien@zamaudio.com>
References: <20260208055858.2166524-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: dad7c3b1e760d01f09eefb9f58d725b9d63b73c9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.20; envelope-from=damien@zamaudio.com;
 helo=mail-24420.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The Hurd currently doesn't have any TPM driver, compilation fails
for missing _IOT__IOTBASE_* symbols unless these are left undefined.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index ee2dd15d35..e466311455 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -285,7 +285,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
 #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
 #define PTM_CAP_LOCK_STORAGE       (1 << 16)
=20
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(__GNU__)
 enum {
     PTM_GET_CAPABILITY     =3D _IOR('P', 0, ptm_cap),
     PTM_INIT               =3D _IOWR('P', 1, ptm_init),
--=20
2.51.0



