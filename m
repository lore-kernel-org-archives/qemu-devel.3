Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E58CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxh-0002lP-Hm; Fri, 15 May 2026 17:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxf-0002d1-Dq
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:47 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxd-00036I-Q5
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:47 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso323080a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880044; x=1779484844;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZZgub/ePDDWE5FkQuF8yjkRLktGlum9Bc8Z4CY9iTsc=;
 b=xIReD9bOXR6vSVUYN/a5tl+BI89TxYTQqO8KRyctNaUQHVi0PJZ3kzCaZoVVfAdLTp
 h5AYIAu4oGOH7fCav/BFPIlCOHmYku+Bs8xTG9vo/eeYHnn4bdMoxjSiJFBT+2UPX+16
 l9YPZV5Fai/Z1V7MX1t4vrxs801eErEvG2eRLZ7NuakV8jgxGpHBWVi6TAJpJUqjEG0n
 HCXnx7bslNW33DBd/ytTHfHmRhlN8fzVOSF9Q8dItxXAB+9Mf5ac1S5mCOrGoxg5O0TG
 f+4V7c8XGay0LowDBdhUqnApqFR6hPxAZCoWns0ps6kNAcmiPNsEaE+SfGfn0Ug/SDh9
 zTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880044; x=1779484844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZZgub/ePDDWE5FkQuF8yjkRLktGlum9Bc8Z4CY9iTsc=;
 b=oRjrYGdlRcrg/rOC13X64QT6zaWv9BG3J5C/Htg4defntHUeQa/tu6xkhRJ3s4qBjF
 SWJCD4KDQz+7b90Jjf/vh1hVLWtqpyqaK5XGewj3Og/3nwyWyW0jY15HN5eRvL6O+QoO
 qhXXfClmAwJ6HF9eJ6cxiQPXqq/TYPORNdQnnw9EW4Cr0OHL8Z/8SJv96EzinHHT7HbL
 czmJ5cZ3n9XB/XR0a1FeYcrD/YvrltZG33JZTQANzH5yTCgi6kbJVZ39xI5qSNvu/ff7
 ypkBnA2sPg+QSck47DUmEeuznMGQ3CCAaq5J8cnQkt2dAz5lEfuHttyobC+aEpjFVunn
 dSQg==
X-Gm-Message-State: AOJu0Yx+tdMf61oQzKgC2tVjjyG1eyoMbmuHwwybSzk85VzRlyYShcSr
 BSH6FLZmYGnksyt2yeTR8GYCkciTRwKBNRquBKkyavTNfOyWxgojD5nxqh5Wkjq7WfUc4iCfB4o
 UrhSlNP8=
X-Gm-Gg: Acq92OGq+cdagES3zqoHzoKO0EcmXqH85z5EHxxoDihV7huq17gAbOyLoLWl99Ylz09
 V7ctGYaiu716nOws4skQpiAEKYEfKWkFCVH395QFl1CDeMrKGbqR6WQ4JHPNvO+pXacysqA08is
 ObdVWSeYA0vXqHv/Lvi1DATlmdAcGBEgDUOHq7VBTFRr2wc+9PPk+itnOtdq4Dlq3tNUaJ+Fv/p
 8qSOW3uBo9mHBdEDWg/NBGq1GsBB2ptUis+cTaB44BKzX87nlBSOmEqSYir7DLI/xXcBExcTwXh
 PG5NsDupnTIj6N6Ozh3bNyWj6F/I3TdyZXBaWKc9epZwoE+43D4ZO77v/RUGow1x32AFVwhZn5q
 mJ9z04ARL8Ml8x5w5fKlAdmiNgg+/jcTZKHPytOE5j/XUJU7xVIQM3RHC2CRytSrsql6vvQGoc3
 LIqecS7GzDyg==
X-Received: by 2002:a05:6830:488f:b0:7e3:d29b:fea4 with SMTP id
 46e09a7af769-7e4fa0569e3mr4204608a34.22.1778880044066; 
 Fri, 15 May 2026 14:20:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:43 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:39 -0600
Subject: [PATCH 40/66] bsd-user: Free CPU state and TaskState on thread
 creation failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-40-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=6zH1P/EfzAjKwYbXo5qc1t1pTr0e5VpKM3jOBHc8mPk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43lDJ8iIfjt9qmgALG7gHoMp/QgNSAiZ+8F4
 WlCvZg+PvGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5QAKCRBsHNEofbAR
 AJt+D/9ckcYy5nQeHZw/9rgVWmSU0SzTOl/TBcuEitvElFqH9N3WFC1/anQtRPpg+kWsYlNl3Ni
 iWDYseS6gzRQ2Me4uTrNWPRV9VNNb4j6rYuGItzjZNxDVrit3W4s4WflAygz/7e2GT7ZefLmjM9
 qV3zt+PWISglhpt2uwx8t+1BUagmg+gGA9M7zLfTZT3/Ho/lTsve1o3Z4lPN7xioU4AMyrLu5cN
 PsV3BzYU+3IqCFoL/IJByplfz73AiA7UgoJRYHz8esU1HpdD4tVkhBUO24+BWXJXTbBL3Y9poTv
 sSyGnmw/RBRtsmJCbBocChTw4QxgatKdMCVZUBkARehe5nz3/+nQ7k3RIbKfd6bGfZXxh4OhqBZ
 SQRs3daAPYfj05Z5JLXdoUkeserSmUddd4RXDhJ8G+ZZYDSMJC9c6R71gCwuXUqnUlqNZ3Vglg3
 Cyr+n+0e8Zdv4PAInKE2kRFA/Og7qnTfmh0o8EgGecYnF/DCmL2fnrpZLztw36zgNEkU+WaD881
 bUu+q5QsWK9te4QyiGca/PkHv2Ifnt3Oa8fq1dGXeuN/tNxO9stOQE4s99c9TVFXXcXpkj5pY3l
 q67kscRloKcE30aNUviCFK3+0zwzdUSelVIjlEl/6cr4nZL77qRRExBKDdRc8jeosKTnp/j7gak
 yDla+xRcS3YekJA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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

When pthread_create fails in do_freebsd_thr_new, the allocated
TaskState and CPU created by cpu_copy were leaked. Clean them up
using the same object_unparent/object_unref pattern used by
thr_exit, and free the TaskState with g_free.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 1d88ee05e4..9e6055a040 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -1633,7 +1633,6 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
     sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
 
     ret = pthread_create(&info.thread, &attr, new_freebsd_thread_start, &info);
-    /* XXX Free new CPU state if thread creation fails. */
 
     sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
     pthread_attr_destroy(&attr);
@@ -1642,6 +1641,9 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
         pthread_cond_wait(&info.cond, &info.mutex);
     } else {
         /* Creation of new thread failed. */
+        object_unparent(OBJECT(new_cpu));
+        object_unref(OBJECT(new_cpu));
+        g_free(ts);
         ret = -host_to_target_errno(errno);
     }
 

-- 
2.52.0


