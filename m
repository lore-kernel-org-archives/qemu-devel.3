Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558FFCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMNh-0002hj-Ib; Thu, 15 Oct 2026 10:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHMNc-0002hV-GT
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:24:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHMNa-0004H6-Lq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:24:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso49188a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792074260; x=1792679060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aoHlPhqUSxKVyOoFQ9X885UhL6Z9j+dN2KPMlXU//Gs=;
 b=c1jiriyMngSTgAOvzFnzhfLjgEQo6EKWAPzhL6zmMx2Nt3N/tDu2iihfzt/EHZVkG3
 3tKQ23PJAF1A7JKie6wMURgtIemQkS9H2DI1ZIhHw3b8/xz5uG6+9a5mtPI+xBFkPlF2
 UzQiKoi0P0VZourUJN2DQl3vqMCU4nlb+XOqN/YlNX8kzs5g/pWLjlDVtWK/ackKODQD
 v//UCerW0in5VadT7GKavqNqJHq05SLNNiuplMp+E8/4EJkvr7Qvb4v3hSKHfptsAh6L
 xNeDi3UPpMb+juLCqbGVljRMxbCi7pfY0YHIc2d6CDkAaml2lg8CQG72wo8xIZVuoOtG
 1/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792074260; x=1792679060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aoHlPhqUSxKVyOoFQ9X885UhL6Z9j+dN2KPMlXU//Gs=;
 b=EuIMuOR2vzFRzFAtvp05xrwdYU8UbZBtMWCblWpLJrBmIOhxBhZ2H5MzVGINul5+yK
 2Y1H3Ecube8pDmwhYLGLpCyds69/C0k2HTc6m6amzY9NFBR2c4aD4GTiKREHInnKElCR
 mfyzoJV/Y6scDIvDNwunSHpK9iVBcByT8CbUJIdFP849Zs44a8ZSeu811TJnjefzofsf
 +Sc+ENDCvdyj/gnZgwjFgoUiYeRMFcAMxZ+A6YW8CZNgOTNT9M3tN0NmC5hiONsHGO9L
 /gX+bYbtmTvWwhg/5bckLLpWA8wk7z/muKeP8gf/PxxHjI/d9m66DGs4wWyaFcKyetgS
 FWcw==
X-Gm-Message-State: AFq9FYJ+INvekVAb3/H0ZI0+vP79gD7LvaHMW6mW2dVKxjdFp6vPdzt1
 /K6V+Kd6kwViHDEMRhVAWBl/HHIJHsxH7EhWNpPuh7WctM2VVt9vaiExnCyeOp6u
X-Gm-Gg: AYBFou3AVr+oVjsA+W7oOrxQmcBmIgJKhOojvQiOiDstOoO2xGFgacL0lQeLcawpdUz
 VA3l0qjTVsaeoAgLiHS8p9fCrme8t9Wedls4fIqFk5syvvoTZUOPfWR7sHv+El4dzZBJKEMHt3b
 lw0JK8vUbGluEAD7+pw3T1cePDfPy1qq6toV+nrU82EDKR7Hgko5XanDw+xv18whHwGLQuepo6V
 l1cifguliFHUAjyaGly13le+KjdpBNBse+iT1wjwBhyuTbEk/7qYzTYkarEkPM0Lqmufh2NOjmM
 POT5GsNQVliL/0KKXmVjxnJe4PLxoREWKSbJI0IsqfiFs4Ie+oeiTHPMXrhPztYe9csMHJiG+pH
 s+rAC0uB7jMJbFgtl0rcMdnZoLOG7EAU75mOvzN1LozqUEB3LXsCWgU2bjIV0g9UbXu/pjzZR7k
 /fOjQPVyna7PugSP9n1uV0jFiaJViM8pnXEUzhr+Ytq7ZetHttZnN7LY29XvFF7Zjd7w+MJXfeA
 GvrcKKMXS0QP4GlUbmot/oTmwryHg1L9KkHxqGoBDBU6jcj/I+xtKtzqkEvm4IlUxj9Tdfppjdd
 eisozVSo
X-Received: by 2002:a05:6402:20ce:10b0:6b1:a67b:d378 with SMTP id
 4fb4d7f45d1cf-6b38781fabemr170776a12.17.1792074260028; 
 Thu, 15 Oct 2026 07:24:20 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b221e89523sm1382006a12.21.2026.10.15.07.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 07:24:18 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v2] qga: do not run hwclock(8) on non-Linux POSIX OSes
Date: Thu, 15 Oct 2026 16:23:42 +0200
Message-ID: <20261015142342.50436-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x532.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, qmp_guest_set_time() sets system time using
the settimeofday(2) system call and then runs the hwclock(8)
util to set hardware time.

hwclock(8) is Linux only, so current implementation
always fails while trying to run it on non-Linux POSIX OSes,
such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.

Update the code not to run it on non-Linux. The settimeofday(2)
call sets both system and hardware time on these systems.
For example, on FreeBSD settimeofday() calls settime()
which calls resettodr() [1] which updates RTC clock [2].
It is similar on OpenBSD and NetBSD, though implementations
differ a bit.

Additional detail: on FreeBSD RTC clock setting can be
disabled with the `machdep.disable_rtc_set` sysctl.
As we cannot do anything about it, do not handle that
case separately.

Non-Linux POSIX OSes do not provide a common utility
equivalent to hwclock -s, so report an unsupported operation
when no time is supplied.

1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
Changes since v1:

Replace "#if defined(CONFIG_BSD)" condition with
"#if !defined(CONFIG_LINUX)" as hwclock(8) is Linux only.

 qga/commands-posix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837e285b6d..ffd1744b74 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
         }
     }
 
+#if !defined(CONFIG_LINUX)
+    /*
+     * BSDs (FreeBSD, OpenBSD, NetBSD) and illumos do not have the
+     * hwclock(8) tool. These systems update hardware clock when
+     * settimeofday() sets system time, so no additional actions
+     * are needed. Setting system time from RTC is not supported.
+     */
+    if (!has_time) {
+        error_setg(errp, "Setting system time from RTC is not supported");
+    }
+
+    return;
+#endif
+
     /* Now, if user has passed a time to set and the system time is set, we
      * just need to synchronize the hardware clock. However, if no time was
      * passed, user is requesting the opposite: set the system time from the
-- 
2.55.0


