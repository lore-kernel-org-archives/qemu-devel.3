Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F0FECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38E-0004WC-Ne; Thu, 05 Feb 2026 12:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38C-0004TD-Kj
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:04 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo388-0001RI-Ik
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:04 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40a62601731so725592fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312419; x=1770917219;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MH3CTNgHcKhDTbJ9CGM6Uyl+1pZ+3hSdqtdPk+GPnoo=;
 b=3FBOzF7kDfubG99XnfnjulRUjBc0nQEgnLKzWAmKreFxSPGy72YUITCVDhzr5qFb7X
 wrtPKucwCiBrA2q9928HjE0L2OSudNj57a4osOOlPC4S03k1jaqVMT2DSjGPTz3nIzxB
 YcCZMTfOZccQyXnpYfl7io4ZFWYpOw5nnP5ctqUxCzilcXEg/J5OtDjuwY1zEWQ8JN2I
 UWfagIdb3PzlzDgj8G4/iS6OEi2ekVmEou5RYRkwzFpwetX1JeqroazWV1/zu8Z26uwE
 m42QAo45WXpIJHpQI6Vze15r1DoPinrwjQT/wUthtAV/YHM2yTNc6Ywfqyp17j4CKEkK
 TpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312419; x=1770917219;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MH3CTNgHcKhDTbJ9CGM6Uyl+1pZ+3hSdqtdPk+GPnoo=;
 b=cAxHDyBnWD9Dl21lAKUvj+Az5fHTCeKDQmSnqnFyBxtLX11XLP4AnPfMgN6xs6Ceep
 NaUr4JC88B0sRjBQschlg1SS1w7RjN4gjXuHAevRMzbNeAFmt2cuhwQG6Whf6a7Yon74
 T9WC94YYIbcGC//pOtGL2zr7A1JM/rLzOTVsOoztrtBPxvjl6XLWpqY9lluw65PA0pzZ
 VpvgGBz9pY4EZsRMbAEtgFtJuAaT6HXpMPqxAKJO+LKTlsP+QlFpq7U2flVAUZvJP1Da
 IH7PAQid+CDh65fWEbJ3344N/QUfjRDfr5Z3estJSVwwmbCZ3s/D+JwCTLZtJUyBiAGa
 vLVQ==
X-Gm-Message-State: AOJu0Yz5vlhjt9I3GsjuWLcy09ENB2Hkd6CPCUFySuKGLxh9H6z1zSkk
 LtRFlPMp530/q6oUsPqaGZG5tce8lkFE8kKDtIbFx2D9H9K1uInAlvBU8YEe3uYV6FuRgctuWpK
 tlg58
X-Gm-Gg: AZuq6aIErWfVY74T4JVnRVm7g/WG4EfHOBlWXAkTNJ61KEe8thJ6OkBaETgVM5J9h6X
 drxxOX7AqPJzC/SBb72HdytKWuGQQEWywSFsHn3ETMzNP0DND7esIEWFDILcmHJF/ZmuBnZ1/Ya
 UHRdBomlIp3HDQUkP0wWZDv55WthS3LuYZ0vK+u3FtXTQt3EDaDOY67DbJ6tB6glL28AYlugfRl
 j1mHSQ11MLWAnQZ3ep+nhZ4G3VEqUQj90vWDGsFh5cSs2tzkxvTNpLH4mwcjvs8n6BexeCKSZQ1
 rWAyZhkTlm9JFNEOPNcLkbnbfUTkm5XJ0Q8VBMdzrDI5+hS0c9jSeM/ee6EJhxlLj/ui9in8+DL
 cEJ2v3Bl9xW88LlFD9RTxsL9CSrx7Der0RWEaEpC01pa+lNXVQO26kX7p9npfdXPUHAtGR57Vm2
 Dqm3OV4Y2F
X-Received: by 2002:a05:6871:72c:b0:404:1967:d6f7 with SMTP id
 586e51a60fabf-40a96e6111emr7186fac.28.1770312419456; 
 Thu, 05 Feb 2026 09:26:59 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:59 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:50 -0700
Subject: [PATCH 17/24] bsd-user: Add do_bsd_semop implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-17-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=g6QgbLiuUV2oCvynafdqQSh66Ut9kbj2z1zPN1evnho=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLb/lZ8mkKLDlmsYBC25KkvXfG5r5jvmlVJ5
 OXkr8OAhZmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 ACWgEADDBpwWHB0oRMK2sxIDoQ+sg8+AO77jVxvJHPVivWIWRFYkcGHy/a7yP7tFobp2vHcsn0h
 wbNVgaTf68M/AvuXQzdkjG4kSiIWFhA3Wb2Iewl2wqeRqzWVLGrVY3p9qD9QVpPYXI1NN9S/P3I
 eCUTIup0JFDSQmG5e6u48l2Sxcp6Zc6U3aU7RrvMP5exaBO11roAjBg8/3AOGMV7Irdzsrk+6CU
 BPHR9YVGd/yvfgxpVZQk+IVlm9OFRjfUGdkTm1HaqWKaaLEJBO+jSBrMJG11PHyqNdwoKp9AEYb
 WZ73qSsbHsHQWnvs2PS3k7isZrRJvA4+G6+Qdv7vzZ5uJ+ntYYwcQ6PmbZ2EJT0WRvo3Ziwgpil
 409WhYniNMjqtKy4gxv/s1/mhfaihm032wkgXuxAKJNoLFclvGKTVkyiP23XyPHQfytQY13n/Pa
 53sXOBS8Jzo83+utbIJrdEHaSQVd/njbrzblGJ3PxRku2imTaco4l6vcVQZiUaAdYxbIXmWfI1X
 aG/dGgoi42xfFtoCNk9KqoIV+b93H/I+2U4tbWZLz+KUg/q92ZFRWObaGbeFMVY7EUULk0ZBa/t
 PixjgUrV36GzbMQllIrnpywqLdjXDUGID45Tg85x37N5CsmUV/tMb1npnOFsty7dpyMc8yQwMI2
 EZkvEvB92m/utOg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2b.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add implementation of semop(2) syscall to perform System V semaphore
operations. Converts target sembuf array to host format and executes
operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 18520548fb..1aa1549fd2 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -89,6 +89,28 @@ static inline abi_long do_bsd_semget(abi_long key, int nsems,
                 target_to_host_bitmask(target_flags, ipc_flags_tbl)));
 }
 
+/* semop(2) */
+static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
+{
+    g_autofree struct sembuf *sops = g_malloc(nsops * sizeof(struct sembuf));
+    struct target_sembuf *target_sembuf;
+    int i;
+
+    target_sembuf = lock_user(VERIFY_READ, ptr,
+            nsops * sizeof(struct target_sembuf), 1);
+    if (target_sembuf == NULL) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsops; i++) {
+        __get_user(sops[i].sem_num, &target_sembuf[i].sem_num);
+        __get_user(sops[i].sem_op, &target_sembuf[i].sem_op);
+        __get_user(sops[i].sem_flg, &target_sembuf[i].sem_flg);
+    }
+    unlock_user(target_sembuf, ptr, 0);
+
+    return semop(semid, sops, nsops);
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


