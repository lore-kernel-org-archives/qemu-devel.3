Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE44E6BF3C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0TX-00070X-75; Fri, 30 Jan 2026 21:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vm0TC-0006mP-2M
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:12:20 -0500
Received: from mail-24420.protonmail.ch ([109.224.244.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vm0TA-000272-9Q
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail2; t=1769825533; x=1770084733;
 bh=YLX4rEU/4UQfYgFlUOjCqILj5bUwSlvUloseNXbbe98=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dn18NKSvC7Q+7T14gRQQrS0Ho0grJkArmHHtuZyJTnNoclruM79ko7LLZpl6207xu
 LaV0GwxOhIkzTFE6aM4QVVTYsDGe0At37qcHWckNGoUKdrufJLgANtlYBY/pUtD7NW
 /Yopoe4gWyIT2bIcYYKnTzqxrLcjVOCR25IhzUxYBNugQp9lSJUivTzLKHBjm4qfdJ
 GvhAfh0Ni32sodG3C6s+gBypNdYYQShEBAmYSSONdd/N1E3q/uowhz8jZFEUVxERRW
 PQMm/W0cLbM7o5emHx10QURz9PzgtgU49y4/hO8tCDmuL2u3G71J9auMnlCK0JvpC2
 6SsztLAVwHMBQ==
Date: Sat, 31 Jan 2026 02:12:09 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v4 3/5 qemu] tpm: Remove unused ioctl enum and includes
Message-ID: <20260131021116.1717230-4-damien@zamaudio.com>
In-Reply-To: <20260131021116.1717230-1-damien@zamaudio.com>
References: <20260131021116.1717230-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: c295d1bb183d18484a0b92b2c748a11f0106124f
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

From: Manolo de Medici <manolodemedici@gmail.com>

On GNU/Hurd, compilation fails due to missing _IO*
symbols.  As these are unused, remove them.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 backends/tpm/tpm_ioctl.h | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index ee2dd15d35..74c6e1bd27 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -12,15 +12,6 @@
 # define __USE_LINUX_IOCTL_DEFS
 #endif
=20
-#ifndef _WIN32
-#include <sys/uio.h>
-#include <sys/ioctl.h>
-#endif
-
-#ifdef HAVE_SYS_IOCCOM_H
-#include <sys/ioccom.h>
-#endif
-
 /*
  * Every response from a command involving a TPM command execution must ho=
ld
  * the ptm_res as the first element.
@@ -285,30 +276,6 @@ typedef struct ptm_lockstorage ptm_lockstorage;
 #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
 #define PTM_CAP_LOCK_STORAGE       (1 << 16)
=20
-#ifndef _WIN32
-enum {
-    PTM_GET_CAPABILITY     =3D _IOR('P', 0, ptm_cap),
-    PTM_INIT               =3D _IOWR('P', 1, ptm_init),
-    PTM_SHUTDOWN           =3D _IOR('P', 2, ptm_res),
-    PTM_GET_TPMESTABLISHED =3D _IOR('P', 3, ptm_est),
-    PTM_SET_LOCALITY       =3D _IOWR('P', 4, ptm_loc),
-    PTM_HASH_START         =3D _IOR('P', 5, ptm_res),
-    PTM_HASH_DATA          =3D _IOWR('P', 6, ptm_hdata),
-    PTM_HASH_END           =3D _IOR('P', 7, ptm_res),
-    PTM_CANCEL_TPM_CMD     =3D _IOR('P', 8, ptm_res),
-    PTM_STORE_VOLATILE     =3D _IOR('P', 9, ptm_res),
-    PTM_RESET_TPMESTABLISHED =3D _IOWR('P', 10, ptm_reset_est),
-    PTM_GET_STATEBLOB      =3D _IOWR('P', 11, ptm_getstate),
-    PTM_SET_STATEBLOB      =3D _IOWR('P', 12, ptm_setstate),
-    PTM_STOP               =3D _IOR('P', 13, ptm_res),
-    PTM_GET_CONFIG         =3D _IOR('P', 14, ptm_getconfig),
-    PTM_SET_DATAFD         =3D _IOR('P', 15, ptm_res),
-    PTM_SET_BUFFERSIZE     =3D _IOWR('P', 16, ptm_setbuffersize),
-    PTM_GET_INFO           =3D _IOWR('P', 17, ptm_getinfo),
-    PTM_LOCK_STORAGE       =3D _IOWR('P', 18, ptm_lockstorage),
-};
-#endif
-
 /*
  * Commands used by the non-CUSE TPMs
  *
--=20
2.51.0



