Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D491D73EB7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 03:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlf46-0006fc-IU; Thu, 29 Jan 2026 22:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vlf45-0006fL-Q4
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 22:20:57 -0500
Received: from mail-0701.mail-europe.com ([51.83.17.38]
 helo=mail-07.mail-europe.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vlf3y-0002Uw-FP
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 22:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail2; t=1769743237; x=1770002437;
 bh=C2VZhh12921o9k2Mf4T1lBb1ZcsaCGXAfNRNzJgarek=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=K91F8U/X3hfOvZuJguTUR1ynPIJ4nLi8E7zS9MoG8rdwcbaw8j2aVB2iTDWNni4qt
 v/CSkXE4sA2sz6PRG7T0EHJS9AdTPXgFVOMrywWXdOthX9U1Cbvn0CttFsuPAChIbk
 a0IbJHlt2EOAfWvSrheX6Y+IIWWkRgiYyLl6Woq5rRVRSK++MkwPc8QQJMWabTn2FO
 OldCu3wPFn8gtgrykRzEkC0ovRwm0lOZ581bq9AfjiWXjjIVwxtthXIkZywkMc2Ay9
 WTbWWQywoUa2IuqxZ6fr/Rk7OauXvHJH81fJ5YMThoBqYSc8y8AEx/xiqfYy6CGt0n
 zLAXy5acj89Pg==
Date: Fri, 30 Jan 2026 03:20:32 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 stefanb@linux.ibm.com, peter.maydell@linaro.org, kwolf@redhat.com,
 berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v3 3/4 qemu] Exclude TPM ioctls definitions for the GNU/Hurd
Message-ID: <20260130031954.1661880-4-damien@zamaudio.com>
In-Reply-To: <20260130031954.1661880-1-damien@zamaudio.com>
References: <20260130031954.1661880-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: 9055c0fc63e4c39e4f6d1b4566b0d450f1585e6f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=51.83.17.38; envelope-from=damien@zamaudio.com;
 helo=mail-07.mail-europe.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

From: Manolo de Medici <manolodemedici@gmail.com>

The Hurd currently doesn't have any TPM driver, compilation fails
for missing symbols unless these are left undefined.

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



