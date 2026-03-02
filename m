Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A523D58E4F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunQ-00018P-6z; Sun, 01 Mar 2026 23:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunO-000181-RA
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:14 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunN-0006u4-EJ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:14 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-46394090d2fso1435643b6e.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425332; x=1773030132;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbxmYAczTPk4Zwsv3UHEtw0iIXvxxCRAjkHtFUnoMJE=;
 b=Q8XciLRNohUduqEXkjqTx50LWslBBoOYQYAB5Is97YtLZDC5GSNO67fo1UDph5D/e1
 AJBMQXxUKsUHlFQCk5Uh64fZtiC0WOFi6RiXNG+nDarVgMwS9v7UTPg+vvQLZ+DkH2SH
 fIXgokA9gzgqUIAWvoqPRadF0GnFV6RUc7kQzh1Cr6gXeNW6uk/cN83sAHtiQEnRT7gN
 A4FbS70jTUD7rmRGNCjnOj+MTo7yFXk+TewxnlbkDvhJ0T+YOCFL8BEP+vPAzBh2tx9G
 eMuBeJrlIKmYglFqQBqFC91G49YrD5/vlvIWE7sFzkWIlVdk4ZlyqYmGuD6ZPxUfKioe
 FaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425332; x=1773030132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xbxmYAczTPk4Zwsv3UHEtw0iIXvxxCRAjkHtFUnoMJE=;
 b=XDsCChGf8Fs6Er/OVzkgI/dclLVnngPy7OB5rc5GsE0lYSRMad4uHoHrOW5m6SmAOV
 baVWa7HbSJTFFVsndt9BbeLcWL84h9kXHfhMFfdxjmAbWb6/TBpJVhJ0hIt963OtQjLG
 dniSKga7LPZi1ZKJCcmz7WvenZMntI13teoXQwHpzqzaoUSVCjYXkVUQYITADlxllIKB
 hwTrcnoIDpBeubMaXGG8rKGrOeDHxuI/3rKJ8JEiF+ZVXzjPeXJuC7pjBzSUQaxYG5C4
 gUmVlRCUkVNKNb7CoURHyZur+WdCxyQcq/ffsLdbLjZT6XH5Atm3S7aT1+BWMu+yxa7s
 tMBg==
X-Gm-Message-State: AOJu0YzK/oYEiPw/m+RmVrRcdDVwLxwf1m93UxekLTejUFHxtki8dZEv
 xyDUdm+cnDxPQttRba7rTSLQeANDj07O1QsRBnQQX1TTTqGzef6Xw5VaI2bfJe+sFcBEYgpX6rL
 e0XcUvKI=
X-Gm-Gg: ATEYQzx8K/erRC1Cy6ZGIU83xQTy28Zhhqj92Seplm86K03ZR29ooxAmfKs9B/5zyBA
 IYmm/uALC2Lu1F5Us1GL6hg+2RF52COjgZ4zJvOeYJ4Otts0lzbP6UuCb3YAaLfLpy+xE7USsvk
 NkqXuQ/HSdjbaWSS30hb6D1zNa7BnLNPsgh89EOREavls96L6qa2O0hYrdmyuRLEUx+sO5MZLF4
 zjCaGC6DDM6JxH49sptreXfC3XtRwVnFYTe2V8uw63SZpIVe7oEB8jjgYs1ciMxvZHeArV7ZYd8
 sVzZOP2/vYinCGhKNH/gmEzqUk5pZF2hWtH3NqTj7ZtxCxZrWUnyF6oODZRSZa5e2zzTl/UOa4Q
 z9pwAXHUagt6G0S3XtnNyLekSlnyUy/lwG1JGMKvqPQlceNdrl3UMWuY+TNgH0EloNey3/p63fc
 jgeFpRO+COng==
X-Received: by 2002:a05:6808:1b2c:b0:45c:925b:5848 with SMTP id
 5614622812f47-464bef47bb9mr6789776b6e.45.1772425332035; 
 Sun, 01 Mar 2026 20:22:12 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:11 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/27] bsd-user: Add System V message queue syscalls
Date: Sun,  1 Mar 2026 21:21:13 -0700
Message-ID: <20260302042115.83410-26-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x236.google.com
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

Connect the System V IPC message queue syscalls:
- msgctl(2): Message queue control
- msgget(2): Get message queue identifier
- msgsnd(2): Send message to queue
- msgrcv(2): Receive message from queue

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 234bd78fd2..f39e521e42 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -894,6 +894,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
         break;
     }
+
+        /*
+         * System V Messages
+         */
+    case TARGET_FREEBSD_NR_msgctl: /* msgctl(2) */
+        ret = do_bsd_msgctl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_msgget: /* msgget(2) */
+        ret = do_bsd_msgget(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_msgsnd: /* msgsnd(2) */
+        ret = do_bsd_msgsnd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_msgrcv: /* msgrcv(2) */
+        ret = do_bsd_msgrcv(arg1, arg2, arg3, arg4, arg5);
+        break;
+
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;
-- 
2.52.0


