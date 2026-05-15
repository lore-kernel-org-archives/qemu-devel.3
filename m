Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEA6CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxF-0001M9-Tv; Fri, 15 May 2026 17:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxE-0001Lk-KS
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:20 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxD-0002wp-3Z
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:20 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so166762a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880018; x=1779484818;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIZZ3MoLaByazBW5BUbMYe7Y/3osI58B02Q2ofvFBtk=;
 b=Gssso2M3E44QiPXz5NfAghjxrWgVhJ9C8OSLt2ZW0ltqlMh7QH8pAkpS5RTLYVVVSQ
 omJeStze1cqReNZkFZn2geyeMXVHfyPigfnqpkc+Zz2+P7F25gyKMpiE7onK8o6mYdLh
 fz39SIevBKCc80YsD8l8dyvwHNDQetZTUw69qf8mdqZE+za0Jr2mHPIW1ERU/wTX5GTL
 L1l917wX76JPcKb/ej4Qb3A6TzWiYaWAVfQsUwKJc5cA4UcMEW/iNJVqfA7kGuMhmsqA
 Ml8XALBxOLYVOemME4kk7ldlHzuc34Qq+5rQDSSWCluuWtBWGBM9D42PgTTNso6WRyOw
 NO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880018; x=1779484818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BIZZ3MoLaByazBW5BUbMYe7Y/3osI58B02Q2ofvFBtk=;
 b=feYwckIKCOU5AtMwUdZPygX4RtJy3lueRn2HVdKojfrTsf7u1NsSOOSJXXaRlQV924
 bGQXJBLzwW7DJ+3CovXwkjRnfJvptEs219fy4uVb/c0smZH/vx7N30+yKJulvMhs7EkH
 +9t8Mnk7F/EUkD2VZ8EKZ44gDYozKFo6z8P7PmQ2rLBJVHXoX5/vqKGEF+cfO2IN6XSe
 yCnkngQMfcg/jF9Pqu1yGb/td/dE8unlvgKzC7MioX2CtgsVrswiaTLBKOOc2hOdXy7t
 eWn2hEUPABT2Eo16e5SkMMgr4ooL17H7MdYWkKuGBSz143+pWR/XKjKd8s1d9Q90nI2T
 Bc8Q==
X-Gm-Message-State: AOJu0Yzs2Q004FO25/zoggHeh2nwFIq21LgAy+5eho2ZTCx2fuf4I02n
 BVjzITlM2ECsgWehGoSn5Sx0lnj4fSFx7qnBOKT+3BnVrEOP2k0lX6eOPhF1wtuQqDw=
X-Gm-Gg: Acq92OFU9P8ye86RWbf6TRThu0Cw9/FWaT8kbsRlNmAteW5s3djcPc0Y25U1EL+TS/Q
 KO8A/EFq0O1QBP1wcmUpToTHtre9ml0ewMfoKRhPJT4b7Y76Z5o5gh7SerWVg+jolHrMkLOXhlc
 iBjBDOUvnwLrXeCcU1AaCi15PFqHmVWZiH1NKVBsKWaxlOCFgUYjVw7JIsImV78L8chMpY/iEvW
 aR8pFhHLA27iYiVJxPQxqzsMDHWMR0Z325e87bIu1LUKHZWJz/3xQHj1kdvKP5w78geGcdxqP4C
 kJZPpHCqMqcQXWkyTEF9KT2k6puRxi3GjAXCNenHzH4z9KydjN2z7FTHdzwPx/wcltFksG8MAuK
 zYFMv/hzcTRwlWBsLSPApb8MKZPJIaJmn4LK9NhB313o0Ijyu0/cgu3xfupNFJhN6+HHzLF/zkI
 Op5URSZ6lVmw==
X-Received: by 2002:a05:6830:4387:b0:7dc:c43b:9599 with SMTP id
 46e09a7af769-7e4ea07a52emr3810494a34.7.1778880017884; 
 Fri, 15 May 2026 14:20:17 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:17 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:15 -0600
Subject: [PATCH 16/66] bsd-user: Add socket system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-16-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=TZhqz7LKdkYXM01TJu9w2X05NnhTh/MQLP6Gzmk/xUk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43iw4Tqztg6wqzMPbD9c5J9buQYCQgN6HUss
 yNSjs/etBCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4gAKCRBsHNEofbAR
 AMNpEACC+dRCJPA0TeBnBGyXVvYMTEUYRvtOVasiJ+z5wMVHx95vrS225VS/7t6lM46658GmGTR
 MUcJOKfD5XESAo9oE1vCsCX1v/nkU8OCHyeBQw2ImP8MEBP1u7N7WGRdORO6x9EM7b3va22IhXL
 7Jclxl06wtioXBygLc4g4G4yQyl7WnJccsMFiRAul1AT6ZKwefVgbJb7wzEV4H4A4zalMiXyDrY
 SFCxKDQJunV9s0dnbphuSJYBAgJyrUeIXgVsgqIQFlkQYzuDRcNXrzh9Nra2wkEf/A04d8cZ3qd
 2JrZp819L6At5tYg+MUvgVnt0JCEFSzJjBFJOR5M/y5XBGRzEFQG8vZaGRXPLM27bQwGAytjHHJ
 RoUjnycKn81oJghQDd0MgWUfDC4KyzJ1A3/1P7mINGVCRhJA2EMcNgW4S7470SeX2+k+/M8+QaN
 bOKADMttwZ8zqOZQ54R6joMHHcilVau+w8YWfgJVWbfRd2yvE1tIQypo4gUvZzA8warvfrrwt1D
 /UWMdcBmFcvK4RmSGO5bjecTMMSHmxUUej28igP8a9A8q+njr0Of/IRYMxlDuBd+VW8rVmf3+WL
 /h9ldWPhIkbYARGKlTASehTjHDagNfjtmLoRnx0tdcj6i3Kbsn+/ZQUPykLSzB3oxYgYXYeppKE
 75c71BI0jD6nTFA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
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


