Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08593CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hF-000307-9T; Sun, 21 Jun 2026 00:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hA-0002z8-LH
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:08 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h8-0005Dh-Lx
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:08 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4474073fa81so558514fac.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015725; x=1782620525;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IZqvz8h4UtlNJLGSNtv/wFdOOIsa8XLH9YYwsbluMaw=;
 b=saNQY43syGty2lSh9AF+IFT1BiAxMKe0sAxozstK3AA1n+UY0OfDUpf3miT+dSzfBL
 qTEQa0cNsqPEaYfG1L4x3WbJaXRQEif0aKAPpOK9WiZCBPNeFLek3+2cbalyfhrnLRat
 sqgRZAAvFfj/B+qRHJfdUzDlqHDuXeVqnBqZ42iKb0gUofa65oBeu7hZX86xuLFKibbx
 ja/nlGxt8nMxyPFc8TVYX3TYbTgU75pGTQEL3xObOHlARkE3aiDgPA84b6EPStd17A5T
 zyqDDNzZMGfwBExkSs24TtNQAaL0+/gJG/NMz45ljy/NLxGp6sBRWJVS4XkmHSQbMcTA
 xXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015725; x=1782620525;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IZqvz8h4UtlNJLGSNtv/wFdOOIsa8XLH9YYwsbluMaw=;
 b=NKl+dFSHPZNNd+EHVZJTMnrbyCTQoUALaDzX5VcsJRSqi6/+bHmYAs4Z4Y+2zojTGa
 U/NcmQcIsLvVxjybKgoxjI2sMZrnQCDyMFIOFY/oui2nJucogEXbiXa6kwnOMXU3JlW/
 MBmOXFW79cH0q0FtFFC+W13UxAyRf/nNODsRKzJB8SVj3NW+UVh0WmanlTuuu2NqY2ra
 iC1gaHC0uO6Cbpw+tjva2Zd1owx9D+17yqDyRJiat3oAb5rtnG5cHEBZuWxvYqCRM70q
 IaxOp9cMt1SvAYvE3Y1zhboqmwUscWPssTJbwBOscgCMIgXsKbvkFoXnrSiskqxTx5OM
 Z5wg==
X-Gm-Message-State: AOJu0YxPiJm+yujeF3Yh0ja1kY/Z5nLSuXTS3gNK1uLg8v/D8yTJDZhv
 AwqmZLTQQKoRNIL1xcY07EUkImoWwtvcQKUG35Oz57bnapKcFxUslmWh+wjbUFBQUWg=
X-Gm-Gg: AfdE7cnR2OeRGUdL+jBRN4p2Le3+o2lCUHi7ZdU+9gp7UxuCQcxDk8PHcmT+NQKVxzf
 P0N5Ev1B99InT/8FVAPGsc1hxLNnwjCxn7KjMRX+hanuZDLALtJXiMpkh4pSaioaL++QtpUoc4Z
 QAhosYFVvoLt51hzhXwRnMP3Taub5OAf2F9mGWq8xgbI+2MruxCXvC20JunhuynMEnCQ6Jy3/bf
 ymeR7o34fKqgM41IZg9Isoa1XV/HUYSN2UbLUZDfRpqRqH6EPLqTTvZIHEC7qaKVlPkociXyLPy
 EHu3YNAkidr64PeyAY+wfrK2XAsMo53dx2f+3KGUPS5jRD2enGM9xpVfSNk2fHvDRkRKdeAAln2
 fQ9lsWUGxOT0unD1mdGyE3wConFedHtsJRqNOcvU7i+JwL0shgmqlh7ffgA99DJenySbYNQherR
 k=
X-Received: by 2002:a05:6820:190f:b0:6a0:c3ed:be45 with SMTP id
 006d021491bc7-6a0d8d5d523mr6997500eaf.54.1782015725055; 
 Sat, 20 Jun 2026 21:22:05 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:05 -0600
Subject: [PATCH v3 18/40] bsd-user: Add socket system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-18-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ZBAbJNClrfqHZU5D4NHPAXLrCS68cI/JIVaNW7vuVuc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z+kel8YPw0ignOYE6oJN0w7kL+/w4Vg9FIy
 vvn3w35gBuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfgAKCRBsHNEofbAR
 APSHEADRX8V7CDPqYk+uoCCcFiAyqjome/BlQOOf+gQVTN4bQrsbinwkom1XtjZT6WPz+piyn45
 PXcmWUlKYf3xINht6qejJn+JFNEvY4FAT8k+CwQZMymi8go3goBxei4imvaWE2z1T2NWB0Chv/O
 37mrFwyMmHrftvtBUCu9BX8rbRNldizmDzDjbF1rsm22a5/Ndi/gPHA8M7o+C/Y5ekfYi0GmgdG
 Km4pgWzcACTSs5gkUm+vw6h6jVdYxwWbgD7nG4Pl6H1ZkpNP1w7/48E/QktzRAp3JF+AtKhxlkY
 KYmZNeYXah75U9tQm2z/6mo6C3UAqbDJD6cvk8RqKLmZe+ORrDLL8s8F/7Y+fJZscBRXgJqV1OM
 mRPabb+8Pp+kX/kzPxwFNcNcQdK2V/uenTTyRhWCQknPdvOqY36X5jFLCo/5olxA+8r+ppKooZs
 GU4019btM2TtOxCyae50UOawzOPjUFzgleuLvveaDMgIPeqr02P6gH6sNWmngrKMayAvVFIWIHU
 0RDxpoRDqWB92DyWRSghX/FkLUZurdRVdMYTKumvRUBlRnjckQIVEQwJ7Ak3F0S1iemrteRaLrf
 m8NXgrLj9uGiLsbjZoVuAE7MrAPku1njMGtPoS/cptpNfMFzPvnivWiNeGhU4N+0GX2PCxi6crW
 kNT8YvNx7u5vNoA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Wire up socket-related system calls in the FreeBSD syscall dispatcher:
accept, accept4, bind, bindat, connect, connectat, getpeername,
getsockname, getsockopt, setsockopt, listen, recvfrom, recvmsg,
sendmsg, sendto, socket, socketpair, shutdown, and setfib.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 46fee46336..5d3a66e360 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1073,6 +1073,85 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_pdkill(arg1, arg2);
         break;
 
+        /*
+         * socket related system calls
+         */
+    case TARGET_FREEBSD_NR_accept: /* accept(2) */
+        ret = do_bsd_accept(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_accept4: /* accept4(2) */
+        ret = do_freebsd_accept4(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_bind: /* bind(2) */
+        ret = do_bsd_bind(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_bindat: /* bindat(2) */
+        ret = do_freebsd_bindat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_connect: /* connect(2) */
+        ret = do_bsd_connect(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_connectat: /* connectat(2) */
+        ret = do_freebsd_connectat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_getpeername: /* getpeername(2) */
+        ret = do_bsd_getpeername(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getsockname: /* getsockname(2) */
+        ret = do_bsd_getsockname(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getsockopt: /* getsockopt(2) */
+        ret = do_bsd_getsockopt(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_setsockopt: /* setsockopt(2) */
+        ret = do_bsd_setsockopt(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_listen: /* listen(2) */
+        ret = get_errno(listen(arg1, arg2));
+        break;
+
+    case TARGET_FREEBSD_NR_recvfrom: /* recvfrom(2) */
+        ret = do_bsd_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_recvmsg: /* recvmsg(2) */
+        ret = do_sendrecvmsg(arg1, arg2, arg3, 0);
+        break;
+
+    case TARGET_FREEBSD_NR_sendmsg: /* sendmsg(2) */
+        ret = do_sendrecvmsg(arg1, arg2, arg3, 1);
+        break;
+
+    case TARGET_FREEBSD_NR_sendto: /* sendto(2) */
+        ret = do_bsd_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_socket: /* socket(2) */
+        ret = do_bsd_socket(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_socketpair: /* socketpair(2) */
+        ret = do_bsd_socketpair(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_shutdown: /* shutdown(2) */
+        ret = do_bsd_shutdown(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setfib: /* setfib(2) */
+        ret = do_freebsd_setfib(arg1);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


